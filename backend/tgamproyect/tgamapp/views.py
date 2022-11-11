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
    roles = Rol.objects.all()
    serializer = RolSerializer(roles, many=True)
    return Response(serializer.data,status.HTTP_200_OK)

@api_view(['POST'])
def insert_person(request):
    print(request)
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
    print(request)
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
            print(user.estado)
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


