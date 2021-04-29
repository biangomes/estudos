from rest_framework import serializers
from .models import Livro

class LivrosSerializer(serializers.ModelSerializer):
    class Meta:
        model = Livro
        exclude = []