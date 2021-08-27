import streamlit as st
import yfinance as yf
import pandas as pd

st.write(""" # Online Stock Price Ticker """)

tickerSymbol = 'tsla'
tickerData = yf.Ticker(tickerSymbol)
tickerDf = tickerData.history(period='1d', start='2020-07-03', end='2021-07-12')

st.line_chart(tickerDf.Close)
st.line_chart(tickerDf.Volume)