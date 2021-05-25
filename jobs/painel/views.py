from django.shortcuts import render

# Create your views here.
from painel.models import Vaga, Empresa


def index(request):
    return render(request, 'index.html')


# View para cadastrar uma empresa
def cadastroEmpresa(request):

    if request.method == 'POST':
        nome = request.POST.get('nome')
        setor = request.POST.get('setor')
        cnpj = request.POST.get('cnpj')
        endereco = request.POST.get('endereco')
        cadastro_empresa = Empresa(nome=nome, setor=setor, cnpj=cnpj, endereco=endereco)
        cadastro_empresa.is_staff = True
        cadastro_empresa.save()


    return render(request, 'cadastro_empresa.html')


def visualizaVagas(request, id):
    empresa = Empresa.objects.filter(id=id)

    return render(request, 'visualiza_vaga.html')