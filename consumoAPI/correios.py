import requests

print('### Consulta CEP ###')

# Obtendo cep do usuario
cep = input("Digite o CEP para consulta: ")

# CEP tem que ser de 8 dígitos
if len(cep) != 8:
    print('Quantidade inválida de dígitos')
    exit()

# Faz a requisicao
request = requests.get('https://viacep.com.br/ws/{}/json/'.format(cep))

# Passando para um JSON
dado_json = request.json()


# Se o CEP existir
if 'erro' not in dado_json:
    print('==> CEP ENCONTRADO <==')
    print("CEP: {}".format(dado_json['cep']))
    print("Logradouro: {}".format(dado_json['logradouro']))
    print("Complemento: {}".format(dado_json['complemento']))
    print("Bairro: {}".format(dado_json['bairro']))
    print("Localidade: {}".format(dado_json['localidade']))
    print("UF: {}".format(dado_json['uf']))
else:
    print('CEP inválido!')