import streamlit as st
import pandas as pd
import numpy as np
from pandas_datareader import data as web


lista_ativos = []
df = pd.DataFrame()

def main():
    st.title("Risco & Volatilidade: conhecendo o seu portfólio")
    menu = ['Home', 'Teoria financeira', 'Gráficos']
    choice = st.sidebar.selectbox("Menu", menu)

    if choice == 'Home':
        st.subheader("--Seu Portfólio--")

        # Method 1: context manager approach
        with st.form(key='form1'):
            qtd_ativos = st.number_input('Quant. ativos: ')
            dt_inicio = st.date_input('Data de início: ')
            dt_fim = st.date_input('Data de fim: ')

            submit = st.form_submit_button(label='Simule pra mim')
        # Results can be either form or outside form
        if submit:
            st.write("Insira os seus ativos")
            for i in range(int(qtd_ativos)):
                ativo = st.text_input('Cód. ativo + .SA: ')
                lista_ativos.append(ativo)


if __name__ == '__main__':
    main()