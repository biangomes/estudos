# importar bibliotecas
import streamlit as st
import pandas as pd
import numpy as np
import pydeck as pdk


# Carregar o caminho do dataset
DATA_URL = 'C:\\Users\\beatr\\Documents\\GitHub\\Estudos\\dash-sigmoidal\\dataset\\ocorrencia_2010_2020.csv'


# Deixando salvo em cache
@st.cache
def load_data():
    """
    Carrega os dados de ocorrências aeronáuticas do CENIPA.
    :return: DataFrame com as columns selecionadas.
    """
    columns = {
        'ocorrencia_latitude': 'latitude',
        'ocorrencia_longitude': 'longitude',
        'ocorrencia_dia': 'data',
        'ocorrencia_classificacao': 'classificacao',
        'ocorrencia_aerodromo': 'aerodromo',
        'ocorrencia_cidade': 'cidade',
        'investigacao_status': 'status',
        'divulgacao_relatorio_numero': 'relatorio_numero',
        'total_aeronaves_envolvidas': 'aeronaves_envolvidas',
    }


    data = pd.read_csv(DATA_URL, index_col='codigo_ocorrencia', delimiter=';')
    data = data.rename(columns=columns)
    # data['longitude'].astype('float64')
    # data['latitude'].astype('float64')
    data.data = data.data + " " + data.ocorrencia_hora
    data.data = pd.to_datetime(data.data)
    data = data[list(columns.values())]

    return data


# Carregando os dados
df = load_data()
# Coloca em uma lista as classificações únicas
labels = list(df.classificacao.unique())


# SIDEBAR
# Parâmetros e número de ocorrências
st.sidebar.header("Parâmetros")
info_sidebar = st.sidebar.empty()       # placeholder, para informações filtradas que só serão carregadas depois


# Ano
st.sidebar.subheader("Ano")
year_to_filter = st.sidebar.slider("Escolha o ano desejado ", 2008, 2018, 2017)
# sidebar.slider(texto, data mínima, data máxima, data default)


# Checkbox tabela
st.sidebar.subheader("Tabela")
tabela = st.sidebar.empty()      # placeholder que só será carregado com o df_filtered


# Multiple select com os labels únicos, gerados em "df.classificacao.unique()"
label_to_filter = st.sidebar.multiselect(
    label="Escolha a classificação da ocorrência",
    options=labels,
    default=labels,     # se selecionar um default específico, deve estar dentro de uma lista. Por exemplo ['INCIDENTE']
)


# Rodapé escrito em Markdown
st.sidebar.markdown(
    """
    A base de dados de ocorrências aeronáuticas é gerenciada pelo ***Centro de Investigação e Prevenção de Acidentes
    Aeronáuticos (CENIPA)***.
    """)


# Somente aqui os dados filtrados por ano serão atualizados
filtered_df = df[(df.data.dt.year == year_to_filter) & (df.classificacao.isin(label_to_filter))]


# Aqui o placeholder finalmente é preenchido com dados do filtered_df.
# Com isso, o placeholder que era .empty() agora é .info()
info_sidebar.info("{} ocorrências selecionadas.".format(filtered_df.shape[0]))


# MAIN
st.title("CENIPA - Acidentes Aeronáuticos")
st.markdown(f"""
            Estão sendo exibidas as ocorrências classificadas como **{", ".join(label_to_filter)}**
            para o ano de **{year_to_filter}**.
            """)


# Raw data - tabela
if tabela.checkbox("Mostrar tabela de dados"):
    st.write(filtered_df)


# Mapa simples
# st.subheader("Mapa")
#
# st.map(filtered_df)
