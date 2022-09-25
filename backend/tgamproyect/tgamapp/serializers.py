from dataclasses import fields
from rest_framework import serializers
from .models import *

class SignInSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = ['id','email','clave']

class PersonaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Persona
        fields = ['nombre','apellido','docidentidad']

class RolSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rol
        fields = ['nombre','descripcion','docidentidad']