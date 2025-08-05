import streamlit as st
from eda import mostrar_eda

st.set_page_config(page_title="Gari Second Brain V2", layout="wide")
st.title("🧠 Gari Second Brain – Análisis de Ventas")

menu = st.sidebar.radio("Selecciona módulo", ["🔍 Análisis EDA"])

if menu == "🔍 Análisis EDA":
    mostrar_eda()