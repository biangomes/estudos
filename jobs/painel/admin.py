from django.contrib import admin
from .models import Empresa, Participante, ParticipanteVaga, Vaga, EmpresaVaga


# Register your models here.
class EmpresaAdmin(admin.ModelAdmin):
    list_display = ('nome', 'setor', 'cnpj', 'endereco')

admin.site.register(Empresa, EmpresaAdmin)


class ParticipanteAdmin(admin.ModelAdmin):
    list_display = ('nome', 'email', 'cpf', 'telefone', 'endereco', 'curriculo', 'dt_criacao')

admin.site.register(Participante, ParticipanteAdmin)


class VagaAdmin(admin.ModelAdmin):
    list_display = ('nome', 'endereco', 'dt_abertura', 'dt_fechamento', 'texto', 'status', 'modalidade')

admin.site.register(Vaga, VagaAdmin)


class ParticipanteVagaAdmin(admin.ModelAdmin):
    list_display = ('participante', 'dt_aplicacao', 'status_vaga')

admin.site.register(ParticipanteVaga, ParticipanteVagaAdmin)


class EmpresaVagaAdmin(admin.ModelAdmin):
    list_display = ('empresa', 'vaga', 'qtd_vagas')

admin.site.register(EmpresaVaga, EmpresaVagaAdmin)