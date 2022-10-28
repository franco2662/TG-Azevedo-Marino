from dataclasses import fields
from rest_framework import serializers
from .models import *

class PersonaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Persona
        fields = ['nombre','apellido','docidentidad','fechanac','sexo']

class UsuarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = ['email','clave','fechacreacion','fk_rol','fk_persona']

class RolSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rol
        fields = ['id','nombre','descripcion']

class ListUsersSerializer(serializers.ModelSerializer):
    fk_persona = PersonaSerializer()
    fk_rol = RolSerializer()
    class Meta:
        model = Usuario
        fields = ['id','email','clave','fechacreacion','fk_persona','fk_rol','estado']

class ViewUsersListSerializer(serializers.ModelSerializer):
    class Meta:
        model = ViewUserList
        fields = '__all__'
