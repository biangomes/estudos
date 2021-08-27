# Importando libs 
import streamlit as st
import pandas as pd
import numpy as np
import yfinance as yf
import matplotlib.pyplot as plt
# from pandas_datareader import data as pdr


lista_ativos = []
df = pd.DataFrame()

def main():
    st.title("Risco & Volatilidade: conhecendo o seu portfólio")
    menu = ['Home', 'Teoria financeira', 'Meu Portfólio', 'Sobre']
    choice = st.sidebar.selectbox("Menu", menu)

    if choice == 'Home':
        st.subheader("--Seu Portfólio--")

        # Method 1: context manager approach
        with st.form(key='form1'):
            qtd_ativos = st.number_input('Quant. ativos: ')
            dt_inicio = st.date_input('Data de início: ')
            dt_fim = st.date_input('Data de fim: ')

            for i in range(int(qtd_ativos)):
                lista_ativos.append(st.text_input('Cód. ativo + .SA: ', key=str(i)))
            submit = st.form_submit_button(label='Simule pra mim')

        # Baixando os dados do Yahoo Finance
        for ticker in lista_ativos:
            df[ticker] = pdr.get_data_yahoo(ticker, start=dt_inicio, end=dt_fim)['Adj Close']

        # Results can be either form or outside form
        if submit:
            st.write("Formulário OK.")

    if choice == 'Meus ativos':
        st.write(df.columns)

if __name__ == '__main__':
    main()