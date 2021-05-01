from django.db import models
from address.models import AddressField

# Create your models here.
class Empresa(models.Model):
    nome = models.CharField(max_length=100)
    setor = models.CharField(max_length=100)
    cnpj = models.CharField(max_length=100)
    endereco = AddressField()
    dt_criacao = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.nome


class Participante(models.Model):
    nome = models.CharField(max_length=100)
    email = models.EmailField()
    cpf = models.CharField(max_length=13)
    telefone = models.CharField(max_length=11)
    endereco = AddressField()
    curriculo = models.ImageField(upload_to='pdf', blank=True, null=True)
    dt_criacao = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.nome


class Vaga(models.Model):

    status_vaga = (
        ('Ativa', 'ativa'),
        ('Inativa', 'inativa')
    )

    modalidades = (
        ('Presencial', 'presencial'),
        ('Remoto', 'remoto'),
        ('Híbrido', 'híbrido'),
    )


    empresa = models.ForeignKey(Empresa, on_delete=models.RESTRICT)
    nome = models.CharField(max_length=100)
    endereco = AddressField()
    dt_abertura = models.DateTimeField()
    dt_fechamento = models.DateTimeField()
    texto = models.TextField(max_length=500, null=True, blank=True)
    # True: vaga aberta; False: vaga fechada.
    status = models.CharField(default='ativa', max_length=100, choices=status_vaga)
    modalidade = models.CharField(default='Presencial', max_length=100, blank=True, null=True, choices=modalidades)
    dt_criacao = models.DateTimeField(auto_now=True)



# Model que relaciona o participante à vaga exigida
class ParticipanteVaga(models.Model):
    vaga = models.ManyToManyField(Vaga)
    participante = models.ForeignKey(Participante, on_delete=models.RESTRICT)
    dt_aplicacao = models.DateTimeField()
    status_vaga = (
        ('Andamento', 'andamento'),
        ('Aprovado', 'aprovado'),
        ('Reprovado', 'reprovado'),
        ('Congelado', 'congelado'),
    )

    status = models.CharField(max_length=100, choices=status_vaga, default='Andamento')