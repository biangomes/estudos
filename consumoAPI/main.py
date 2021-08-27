# Referencia: https://www.treinaweb.com.br/blog/consumindo-apis-com-python-parte-1
# Consumindo APIs com Python - parte 1
import requests
import json

# def buscar_dados():
#     request = requests.get("http://localhost:3002/api/todo")
#     print(request.content)      # o retorno não será amigável
#     todos = json.loads(request.content)
#     print(todos)        # o retorno agora será amigável, pois se trata de um JSON

if __name__ == '__main__':
    buscar_dados()