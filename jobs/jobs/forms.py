
from django.forms import ModelForm
from painel.models import Vaga



class VagaForm(ModelForm):
    class Meta:
        model = Vaga
        fields = ['nome', 'endereco', 'dt_abertura', 'dt_fechamento',
                  'texto', 'status']