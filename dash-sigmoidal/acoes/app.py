# Importando as bibliotecas necessárias
import pandas as pd
import numpy as np
from pandas_datareader import data as web
import streamlit as st
import datetime
import math


# essa função é responsável por receber os dados do usuário
# como os nomes dos ativos para depois baixá-los
def load_data():
    atvs = []
    for nome_ativo in range(3):     # 3 é o máximo de ativos permitidos
        nome = str(input("Nome do ativo + .SA: "))
        atvs.append(nome)

        # Recebe a data de início de observação dos ativos
        a_start = str(input("Ano de início: "))
        m_start = str(input("Mês de início: "))
        d_start = str(input("Dia de início: "))
        start = datetime.date(a_start, m_start, d_start)

        # Recebe a data de fim de observção dos ativos
        a_end = str(input("Ano de fim: "))
        m_end = str(input("Mês de fim: "))
        d_end = str(input("Dia de fim: "))
        end = datetime.date(a_end, m_end, d_end)

        # Criando um DataFrame vazio
        data = pd.DataFrame()

        # Baixando os ativos, propriamente
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