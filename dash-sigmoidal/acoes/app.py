# Importando as bibliotecas necessárias
import pandas as pd
import numpy as np
from pandas_datareader import data as web
import streamlit as st
from datetime import datetime
import math


# essa função é responsável por receber os dados do usuário
# como os nomes dos ativos para depois baixá-los
def load_data():
    atvs = []
    for nome_ativo in range(3):     # 3 é o máximo de ativos permitidos
        nome = st.text_input("Nome do ativo + .SA: ", key=str(nome_ativo))
        atvs.append(nome)

    # Recebe a data de início de observação dos ativos
    # a_start = st.text_input("Ano de início: ", key=str(datetime.now()))
    # m_start = st.text_input("Mês de início: ", key=str(datetime.now()))
    # d_start = st.text_input("Dia de início: ", key=str(datetime.now()))
    # start = datetime.date(a_start, m_start, d_start)
    start = st.date_input("Data de início: ")
    end = st.date_input("Data de fim: ")


    # Recebe a data de fim de observção dos ativos
    # a_end = st.text_input("Ano de fim: ", key=str(datetime.now()))
    # m_end = st.text_input("Mês de fim: ", key=str(datetime.now()))
    # d_end = st.text_input("Dia de fim: ", key=str(datetime.now()))
    # end = datetime.date(a_end, m_end, d_end)

    # Cria um DataFrame que é a principal estrutura que vamos utilizar pra nossa análise
    # e geração de gráficos e insights
    data = pd.DataFrame()

    # Baixando os ativos no DataFrame criado acima. Utilizamos o 'Adj Close', porque é a principal informação
    # que nos interessa.
    for ativo in atvs:
        data[ativo] = web.DataReader(ativo, data_source='yahoo', start=start, end=end)['Adj Close']

    return data


# Carrega o DataFrame gerado na função load_data()
df = load_data()


# Criando uma header para sidebar
st.sidebar.header("Parâmetros")


# Sidebar Ano
st.sidebar.subheader("Ano")
year_to_filter = st.sidebar.slider("Escolha o ano desejado", min(df['Date']), max(df['Date']))
