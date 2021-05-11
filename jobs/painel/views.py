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
        Empresa(nome=nome, setor=setor, cnpj=cnpj, endereco=endereco).save()

    return render(request, 'cadastro_empresa.html')


def visualizaVagas(request, id):
    empresa = Empresa.objects.filter(id=id)

    return render(request, 'visualiza_vaga.html')


# View para se cadastrar na vaga
def cadastroVaga(request):

    empresa = Empresa.objects.all()

    if request.method == "POST":
        nome = request.POST.get('nome')
        endereco = request.POST.get('endereco')
        dt_abertura = request.POST.get('dt_abertura')
        dt_fechamento = request.POST.get('dt_fechamento')
        texto = request.POST.get('texto')
        Vaga(nome=nome, endereco=endereco, dt_abertura=dt_abertura, dt_fechamento=dt_fechamento, texto=texto).save()
    return render(request, 'cadastro_vaga.html')