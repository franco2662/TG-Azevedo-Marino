from django.shortcuts import render
from .models import *
from .serializers import *
from django.http import JsonResponse

# Create your views here.
def user_list(request):
    users = Usuario.objects.all()
    serializer = SignInSerializer(users, many=True)
    return JsonResponse(serializer.data, safe = False)