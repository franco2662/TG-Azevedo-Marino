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

# Create your views here.
@api_view(['GET'])
def user_list(request):
    users = Usuario.objects.all()
    serializer = SignInSerializer(users, many=True)
    return Response(serializer.data,status.HTTP_200_OK)

@api_view(['GET'])
def verify_user(request,user_email):
    if request.method == 'GET':
        try:
            user = Usuario.objects.get(email=user_email)
        except:
            return Response(False,status=status.HTTP_404_NOT_FOUND)
        serializer = SignInSerializer(user)
        return Response(True,status.HTTP_200_OK)    

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
            
