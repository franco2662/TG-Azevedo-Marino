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
        fields = ['email','clave','fechacreacion','fk_rol','fk_persona','fk_empresa']

class RolSerializer(serializers.ModelSerializer):
    class Meta:
        model = Rol
        fields = ['id','nombre','descripcion']
class EmpresaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Empresa
        fields = ['id','nombre']
class FullUsuarioSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = '__all__'
class FullPersonaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Persona
        fields = '__all__'
class ListUsersSerializer(serializers.ModelSerializer):
    fk_persona = FullPersonaSerializer()
    fk_rol = RolSerializer()
    fk_empresa = EmpresaSerializer()
    class Meta:
        model = Usuario
        fields = ['id','email','clave','fechacreacion','estado','fk_persona','fk_rol','fk_empresa']

class ViewUsersListSerializer(serializers.ModelSerializer):
    class Meta:
        model = ViewUserList
        fields = '__all__'

class SesionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Sesion
        fields = ['horainicio','ipconexion','fk_usuario']

