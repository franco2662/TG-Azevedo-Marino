import email
import imp
from os import stat
from django.shortcuts import render
from .models import *
from .serializers import *
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .validations import *

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
            
