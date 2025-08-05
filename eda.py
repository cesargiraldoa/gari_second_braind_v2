import streamlit as st
import pandas as pd
from db_connection import ejecutar_sql

def mostrar_eda():
    st.header("🔎 Análisis Exploratorio – Ventas")

    tabla = "[dbo].[Prestaciones_Temporal]"
    cantidad = st.slider("Selecciona cantidad de registros", 5, 1000, 10)

    query = f"SELECT TOP {cantidad} * FROM {tabla}"
    st.code(query)

    try:
        df = ejecutar_sql(query)
        if df.empty:
            st.warning("⚠ No se encontraron datos.")
        else:
            st.success("✅ Datos cargados correctamente.")
            st.dataframe(df)
    except Exception as e:
        st.error(f"❌ Error al consultar la base de datos: {e}")