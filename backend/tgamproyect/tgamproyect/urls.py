"""tgamproyect URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from tgamapp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/',views.user_list),
    path('verifyuser/<str:user_email>', views.verify_user),
    path('validatesignin/',views.validate_sign_in),
    path('persons/',views.person_list),
    path('verifyperson/<str:person_docidentidad>', views.verify_person),
    path('fkperson/<str:person_docidentidad>', views.fk_person),
    path('roles/',views.role_list),
    path('insertPerson/',views.insert_person),
    path('insertUser/',views.insert_user),
    path('viewuserlist/',views.vw_user_list),
]
