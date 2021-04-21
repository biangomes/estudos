from rest_framework import viewsets, status
from rest_framework.decorators import api_view
from rest_framework.views import Response

from api import models, serializers
from api.integrations.github import GithubApi

# TODOS:
# 1 - Buscar organização pelo login através da API do Github
# 2 - Armazenar os dados atualizados da organização no banco
# 3 - Retornar corretamente os dados da organização
# 4 - Retornar os dados de organizações ordenados pelo score na listagem da API

@api_view(['GET'])
class OrganizationViewSet(viewsets.ModelViewSet):

    queryset = models.Organization.objects.all()
    serializer_class = serializers.OrganizationSerializer(queryset, many=True)
    lookup_field = "login"

    def retrieve(self, request, login=None):
        return Response(serializers.data)


# Remocao das organizacoes da listagem
@api_view(['DELETE'])
def OrganizationDelete(request, pk):
    queryset = models.Organization.objects.get(id=pk)
    queryset.delete()

    return Response('Item deleted!')


# Consulta específica através do login
@api_view(['GET'])
def OrganizationQuery(request, login):
    queryset = models.Organization.objects.get(login=login)
    return Response()