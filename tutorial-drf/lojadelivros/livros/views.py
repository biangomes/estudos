from rest_framework.decorators import api_view
from rest_framework.views import APIView

from .models import Livro
from rest_framework.response import Response
from .serializers import LivrosSerializer

#import json
#from django.http import HttpResponse
#from django.shortcuts import render


# Create your views here.
class LivrosApiView(APIView):

    def get(self, request):
        livros = Livro.objects.all()
        serializer = LivrosSerializer(livros, many=True)
        return Response(serializer.data)

    def post(self, request):
        return Response(output)


livros_view = LivrosApiView.as_view()
