# Referência: https://www.youtube.com/watch?v=3pMsmxlVIpc&t=13s

# Importando as libs
import streamlit as st
import numpy as np
import pandas as pd
from datetime import date
from pandas_datareader import data as web
import matplotlib.pyplot as plt
import seaborn as sns
sns.set_style()


# Nome da aplicacao
st.write(
    """
    **Web app ação**
    """
)
# Opções disponíveis para o sidebar, em que cada opção dessa carregará alguns dados
# * Home: onde o usuário irá inserir os dados principais como quantidade de ativos, data de início, data de fim,
#         quais ativos ele irá analisar.
# * Meus ativos: nessa página, ele conseguirá ver os ativos escolhidos, DataFrame e os gráficos de retorno ao longo do
#                tempo.
# * Sobre: informações sobre a aplicação, como a data de desenvolvimento, versão, autor, colaboradores, etc.
menu = ['Home', 'Meus ativos', 'Sobre']

# O st.sidebar.selectbox é que "lateraliza" a lista de menu e ainda a deixa como caixa selecionável.
# É feito depois uma estrutura IF-ELSE pra selecionar o que irá mostrar na página
choice = st.sidebar.selectbox('Menu', menu)


# Recebendo e baixando os dados de ação
# * lst_ativos = lista que irá carregar os ativos que o usuário deseja analisar. É requisitado que seja o código do
#                ticker + .SA pra combinar com a API da Yahoo Finance!
# * df = objeto DataFrame que irá guardar a lst_ativos como labels e os campos serão os Adj Closes providos pelo Yahoo
# * qtd_ativos = será limitado!
# * start = data de início da análise
# * end = data de fim da análise
def get_data():
    lst_ativos = []
    df = pd.DataFrame()
    qtd_ativos = st.number_input('Qtd. de ativos: ')
    # Início do período que o usuário quer visualizar
    start = st.date_input('Data de início: ')
    # Fim do período que o usuário quer encerrar
    end = st.date_input('Data de fim: ')

    # Recebe os ativos que o usuário gostaria de baixar
    # lembrando que o limite é a qtd_ativos
    for i in range(int(qtd_ativos)):
        lst_ativos.append(st.text_input('Cód. do ativo + .SA: ', key=str(i)))

    # Baixa os ativos do yahoo finance e populando o nosso DataFrame
    for ticker in lst_ativos:
        df[ticker] = web.DataReader(ticker, data_source='yahoo', start=start, end=end)['Adj Close']
    return df


inicial = get_data()

if choice == 'Home':
    # Instancia da funcao get_data, que permite que o usuario insira
    # os ativos e as datas correspondentes
    st.write(inicial)

if choice == 'Meus ativos':
    st.write('Ativos', inicial.columns)
