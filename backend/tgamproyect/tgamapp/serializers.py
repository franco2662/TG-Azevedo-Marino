from dataclasses import fields
from rest_framework import serializers
from .models import *

class SignInSerializer(serializers.ModelSerializer):
    class Meta:
        model = Usuario
        fields = ['id','email','clave']