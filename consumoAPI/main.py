import requests

print('### Consulta CEP ###')

# obtendo cep do usuario
cep = input("Digite o CEP para consulta: ")

# CEP tem que ser de 8 dígitos
if len(cep) != 8:
    print('Quantidade inválida de dígitos')
    exit()


request = requests.get('https://viacep.com.br/ws/{}/json/'.format(cep))

print(request.json())