from django.contrib import admin
from django.urls import path
from .views import index, cadastroVaga

urlpatterns = [
    path('', index, name='index'),
    path('cadastro_vaga', cadastroVaga, name='cadastro_vaga'),
]
