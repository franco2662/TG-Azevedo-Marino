from ast import parse
from datetime import datetime
import json
import time
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
import threading

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

@api_view(['GET'])
def last_analisis_id(request,id_user):
    id_analisis = last_analisis_by_user(id_user)
    resultado = json.dumps({'id_analisis':id_analisis})
    return JsonResponse(resultado,safe =False,status=status.HTTP_200_OK)

@api_view(['POST'])
def prueba(request):
    try:
        print(request.FILES['file'])
        file = open('tgamapp/ia_tests/ArchivoIAReducido.txt', 'r')
        for line in file:
            print(line)
            break
        file.close
        time.sleep(3)
        return Response(True,status.HTTP_200_OK)
    except Exception as e:
        return Response(False,status.HTTP_200_OK)

@api_view(['POST'])
def save_virus_info(request):
    save_virus_list()
    return Response(True,status.HTTP_200_OK)

@api_view(['POST'])
def analisis_optimizado(request,id_user):
    try:
        id_sesion = last_session_by_user(id_user)        
        # Crear una lista compartida para almacenar los resultados de los hilos
        results = [[] for _ in range(3)]
        with request.FILES['file'].open() as file:
            content = file.read().decode()
            file_procesos = io.StringIO(content[content.index("Node"):content.index("Directorio_Columna")-1])
            file_directorios = io.StringIO(content[content.index("Directorio_Columna"):content.index("Registro_Columna")-1])
            file_registros = io.StringIO(content[content.index("Registro_Columna"):])

            analisis = Analisis()
            fecha_actual = datetime.now()
            analisis.fecha = fecha_actual
            analisis.fk_sesion = Sesion.objects.get(id=id_sesion)
            analisis.save()


            hilo_procs = threading.Thread(target=analisis_procs_results, args=(file_procesos,analisis,results[0]))
            hilo_dirs  = threading.Thread(target=analisis_dirs_results, args=(file_directorios,analisis,results[1]))
            hilo_regs  = threading.Thread(target=analisis_regs_results, args=(file_registros,analisis,results[2]))
            # Iniciar los hilos
            hilo_procs.start()
            hilo_dirs.start()
            hilo_regs.start()

            # Esperar a que todos los hilos terminen
            hilo_procs.join()
            hilo_dirs.join()
            hilo_regs.join()


        lista = json.dumps([results[0],results[1],results[2]])    
        return JsonResponse(lista,safe =False,status=status.HTTP_200_OK)
    except Exception as e:
        print(e)
        lista = json.dumps([results[0],results[1],results[2]])        
        return JsonResponse(lista, safe=False, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def historial_analisis(request,id_user):
    lista = json.dumps(get_analisis_history(id_user))    
    return JsonResponse(lista,safe =False,status=status.HTTP_200_OK)