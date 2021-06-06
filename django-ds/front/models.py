from django.db import models

# Create your models here.
class Ativos(models.Model):
    codigo = models.CharField(max_length=20)
    open = models.FloatField()
    close = models.FloatField()
    adj_close = models.FloatField()
    