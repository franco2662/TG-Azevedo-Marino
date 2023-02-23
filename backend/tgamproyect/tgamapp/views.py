from ast import parse
from datetime import datetime
import email
import imp
import json
from os import stat
from signal import signal
from django.shortcuts import render
from .models import *
from .serializers import *
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .validations import *
from json import *
from .proyect_ai import *
from .postgresql import *

from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser 
from rest_framework import status

# Create your views here.
@api_view(['GET'])
def user_list(request):
    users = Usuario.objects.all()
    serializer = ListUsersSerializer(users,many=True)
    return JsonResponse(json.dumps(serializer.data),safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def verify_user(request,user_email):
    if request.method == 'GET':
        try:
            user = Usuario.objects.get(email=user_email)
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)
        return Response(True,status.HTTP_200_OK)    

@api_view(['GET'])
def verify_person(request,person_docidentidad):
    if request.method == 'GET':
        try:
            user = Persona.objects.get(docidentidad=person_docidentidad)
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)
        return Response(True,status.HTTP_200_OK)   

@api_view(['GET'])
def fk_person(request,person_docidentidad):
    if request.method == 'GET':
        try:
            user = Persona.objects.get(docidentidad=person_docidentidad)
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)
        return Response(user.id,status.HTTP_200_OK)   

@api_view(['POST'])
def validate_sign_in(request):
    if request.method == 'POST':
        try:                       
            received_json = json.loads(request.body)
            user_entry = received_json['email']
            pass_entry = received_json['clave']
            pass_entry_hash = user_get_password(pass_entry)
            user = Usuario.objects.get(email=user_entry)
            if(pass_entry_hash==user.clave):       
                return Response(True,status.HTTP_202_ACCEPTED)
            else:
                return Response(False,status.HTTP_401_UNAUTHORIZED)
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)
            
@api_view(['GET'])
def person_list(request):
    persons = Persona.objects.all()
    serializer = PersonaSerializer(persons, many=True)
    return Response(serializer.data,status.HTTP_200_OK)

@api_view(['GET'])
def role_list(request):
    roles = Rol.objects.all().order_by('id')
    serializer = RolSerializer(roles, many=True)
    return Response(serializer.data,status.HTTP_200_OK)

@api_view(['POST'])
def insert_person(request):
    if request.method == 'POST':
        try:
            received_json = json.loads(request.body)
            fecha = received_json['fechanac']
            fecha_formateada = format_date(fecha)
            received_json['fechanac'] = fecha_formateada            
            persona_serializer=PersonaSerializer(data=received_json) 
            if persona_serializer.is_valid():
                persona_serializer.save()
                return JsonResponse(persona_serializer.data,status=status.HTTP_200_OK)
            return JsonResponse(persona_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            
        except Exception as e:
            return Response(str(e),status=status.HTTP_404_NOT_FOUND)    

@api_view(['POST'])
def insert_user(request):
    if request.method == 'POST':
        try:
            received_json = json.loads(request.body)
            pass_entry = received_json['clave']
            pass_entry_hash = user_get_password(pass_entry)
            received_json['clave']=pass_entry_hash
            usuario_serializer=UsuarioSerializer(data=received_json)
            if usuario_serializer.is_valid():
                usuario_serializer.save()
                return JsonResponse(usuario_serializer.data,status=status.HTTP_200_OK)
            return JsonResponse(usuario_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)

@api_view(['GET'])
def vw_user_list(request):
    users = ViewUserList.objects.all()
    serializer = ViewUsersListSerializer(users,many=True)
    return JsonResponse(json.dumps(serializer.data),safe =False,status=status.HTTP_200_OK)

@api_view(['POST'])
def update_user_status(request,userId):
    if request.method == 'POST':
        try:
            user = Usuario.objects.get(id=userId)
            user.estado = not user.estado
            user.save()
            return Response(True,status.HTTP_200_OK)
        except:
            return Response(False,status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def update_allusers_status(request):
    if request.method == 'POST':
        try:
            users = Usuario.objects.all()
            for user in users:
                user.estado = not user.estado
                user.save()
            return Response(True,status.HTTP_200_OK)
        except:
            return Response(False,status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def get_user_by_id(request,userId):
    if request.method == 'GET':
        try:
            user = Usuario.objects.get(id=userId)
            serializer = ListUsersSerializer(user)
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)
        return Response(json.dumps(serializer.data),status.HTTP_200_OK)

@api_view(['GET'])
def empresa_list(request):
    if request.method == 'GET':
        try:
            empresas = Empresa.objects.all().order_by('id')
            serializer = EmpresaSerializer(empresas,many=True)
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)
        return Response(serializer.data,status.HTTP_200_OK)

@api_view(['POST'])
def insert_sesion(request):
    if request.method == 'POST':
        try:
            received_json = json.loads(request.body)
            user_email = received_json['user_email']
            received_json['fk_usuario']= Usuario.objects.get(email=user_email).id
            serializer=SesionSerializer(data=received_json)
            if serializer.is_valid():
                serializer.save()
                return JsonResponse(serializer.data,status=status.HTTP_200_OK)
            return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)            
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)

@api_view(['GET'])
def get_user_by_email(request,user_email):
    if request.method == 'GET':
        try:
            user = Usuario.objects.get(email=user_email)
            serializer = ListUsersSerializer(user)
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)
        return Response(json.dumps(serializer.data),status.HTTP_200_OK)

@api_view(['POST'])
def modify_user(request):
    if request.method == 'POST':
        try:
            received_json = json.loads(request.body)
            usuario = Usuario.objects.get(id=received_json['id'])            
            pass_entry = received_json['clave']
            if(usuario.clave!=pass_entry):
                pass_entry_hash = user_get_password(pass_entry)
                received_json['clave']=pass_entry_hash
            usuario_serializer=UsuarioSerializer(usuario,data=received_json)
            if usuario_serializer.is_valid():
                usuario_serializer.save()
                return Response(True,status.HTTP_200_OK)
            return JsonResponse(usuario_serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)            
        except Exception as e:
            return Response(str(e),status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
def modify_person(request):    
    if request.method == 'POST':
        try:
            received_json = json.loads(request.body)
            fecha = received_json['fechanac']
            fecha_formateada = format_date(fecha)
            received_json['fechanac'] = fecha_formateada
            persona = Persona.objects.get(id=received_json['id'])            
            persona_serializer=PersonaSerializer(persona,data=received_json) 
            if persona_serializer.is_valid():
                persona_serializer.save()
                return Response(True,status.HTTP_200_OK)
            return JsonResponse(persona_serializer.errors, status=status.HTTP_406_NOT_ACCEPTABLE)
            
        except Exception as e:
            return Response(str(e),status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def analisis_test(request):
    lista = analisis_test()
    return JsonResponse(lista,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def save_analisis(request):
    save_bd_test()
    return Response(True,status.HTTP_200_OK)

@api_view(['GET'])
def complete_analisis(request,id_sesion):
    lista = analisis_completo(id_sesion)
    return JsonResponse(lista,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def count_procs(request,id_analisis):
    lista=fn_count_procs(id_analisis)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def count_dirs(request,id_analisis):
    lista=fn_count_dirs(id_analisis)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def count_regs(request,id_analisis):
    lista=fn_count_regs(id_analisis)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)
    
@api_view(['GET'])
def count_all_analisis(request,id_analisis):
    lista=fn_count_all(id_analisis)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_bad_procs(request,id_analisis):
    lista=fn_list_bad_procs(id_analisis)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_bad_dirs(request,id_analisis):
    lista=fn_list_bad_dirs(id_analisis)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_bad_regs(request,id_analisis):
    lista=fn_list_bad_regs(id_analisis)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_bad_all(request,id_analisis):
    lista=fn_list_bad_all(id_analisis)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_bad_all_avg(request,id_analisis):
    lista_completa = fn_list_bad_all(id_analisis)    
    lista = fn_bad_all_avg(id_analisis,lista_completa)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_analisis_by_user(request,id_user):
    lista = get_analisis_by_user(id_user)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_bad_procs_avg(request,id_analisis):
    lista_completa = fn_list_bad_all(id_analisis)    
    lista = fn_bad_proc_avg(lista_completa)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_bad_dirs_avg(request,id_analisis):
    lista_completa = fn_list_bad_all(id_analisis)    
    lista = fn_bad_dir_avg(lista_completa)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['GET'])
def list_bad_regs_avg(request,id_analisis):
    lista_completa = fn_list_bad_all(id_analisis)      
    lista = fn_bad_reg_avg(lista_completa)
    resultado=json.dumps(lista)
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)