from django.shortcuts import render

# Create your views here.
from jobs.forms import VagaForm
from painel.models import Vaga


def index(request):
    return render(request, 'index.html')

# View para se cadastrar na vaga
def cadastroVaga(request):
    form = VagaForm(request.POST)

    if request.method == 'POST':
        if form.is_valid():
            form.save()

    return render(request, 'cadastro_vaga.html')