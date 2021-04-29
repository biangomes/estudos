from django.db import models

# Create your models here.
class Empresa(models.Model):
    nome = models.CharField(max_length=100)
    setor = models.CharField(max_length=100)
    cnpj = models.IntegerField(max_length=100)
    dt_criacao = models.DateTimeField(auto_now=True)


class Participante(models.Model):
    nome = models.CharField(max_length=100)
    email = models.EmailField()
    cpf = models.CharField(max_length=13)
    telefone = models.CharField(max_length=11)
    curriculo = models.ImageField(upload_to='pdf', blank=True, null=True)
    dt_criacao = models.DateTimeField(auto_now=True)


class Vaga(models.Model):
    empresa = models.ForeignKey(Empresa, on_delete=models.RESTRICT)
    dt_abertura = models.DateTimeField()
    dt_fechamento = models.DateTimeField()
    texto = models.TextField(max_length=500, null=True, blank=True)
    # True: vaga aberta; False: vaga fechada.
    status = models.BooleanField(default=True)
    dt_criacao = models.DateTimeField(auto_now=True)


# Model que relaciona o participante à vaga exigida
class ParticipanteVaga(models.Model):
    vaga = models.ManyToManyField(Vaga)
    participante = models.ForeignKey(Participante, on_delete=models.RESTRICT)
    dt_aplicacao = models.DateTimeField()
    status_vaga = ['Andamento', 'Aprovado', 'Reprovado', 'Congelado']
    status = models.CharField(max_length=1, choices=status_vaga, default='Andamento')