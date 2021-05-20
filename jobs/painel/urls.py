from django.contrib import admin
from django.urls import path
from .views import index, cadastroEmpresa, visualizaVagas

urlpatterns = [
    path('', index, name='index'),
    #path('cadastro_vaga', cadastroVaga, name='cadastro_vaga'),
    path('cadastro_empresa', cadastroEmpresa, name='cadastro_empresa'),
]
