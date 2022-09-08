import imp
from os import stat
from django.shortcuts import render
from .models import *
from .serializers import *
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

# Create your views here.
@api_view(['GET'])
def user_list(request):
    users = Usuario.objects.all()
    serializer = SignInSerializer(users, many=True)
    return Response(serializer.data,status.HTTP_200_OK)

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