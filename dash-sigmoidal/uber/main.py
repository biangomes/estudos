# Importar bibliotecas
import streamlit as st
import pandas as pd
import numpy as np


DATA_COLUMN = "date/time"
DATA_URL = "dataset/uber-raw-data-sep14.csv"


# st.cache deixa em cache os dados, aumentando a velocidade de carregamento, pois nao será recarregado
# toda vez que a pág. for acessada novamente pelo mesmo IP
@st.cache
def load_data(nrows):
    data = pd.read_csv('../dataset/uber-raw-data-sep14.csv', nrows=nrows)
    data.rename(lambda x: str(x).lower(), axis="columns", inplace=True)
    # convertendo o date/time para objeto do tipo datetime
    data["date/time"] = pd.to_datetime(data["date/time"])

    return data


data_load_state = st.text("Loading...")
data = load_data(1000)
data_load_state.text("Pronto! Carregado")


if st.checkbox("Mostrar Raw Data"):
    st.subheader("Raw Data")
    st.write(data)


st.subheader("Nº de corridas/hora")
hist_values = np.histogram(data["date/time"].dt.hour, bins=24, range=(0, 24))[0]

# Gerando histograma pela lib do streamlit
st.bar_chart(hist_values)


# Criando filtros para os horários
hour_filter = st.slider('hour', 0, 23, 17)
filtered_data = data[data[DATA_COLUMN].dt.hour == hour_filter]
st.subheader(f"Mapa para a hora {hour_filter}")
st.map(filtered_data)