import streamlit as st
from explorador_tabla import explorar_tabla
from gari_secondbrain_analytics import main as analytics_main

st.set_page_config(page_title="Gari Second Brain", layout="wide")

st.title("🧠 Gari Second Brain – Bienvenido")
st.write("Conexión exitosa. Proyecto en marcha.")

menu = st.sidebar.radio("Selecciona módulo", [
    "🔍 Gari Analytics",
    "🧪 Explorador SQL"
])

if menu == "🔍 Gari Analytics":
    analytics_main()
elif menu == "🧪 Explorador SQL":
    explorar_tabla(nombre_tabla="dbo.Prestaciones_Temporal", cantidad=1000)
