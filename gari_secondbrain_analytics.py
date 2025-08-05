import streamlit as st
import pandas as pd
import plotly.express as px
from db_connection import obtener_conexion

def main():
    st.header("📊 Gari Analytics – Edad vs Prestación")

    try:
        conn = obtener_conexion()
        query = "SELECT TOP 1000 Edad, TipoPrestacion FROM dbo.Prestaciones_Temporal"
        df = pd.read_sql(query, conn)

        st.dataframe(df)

        if not df.empty:
            fig = px.histogram(df, x="Edad", color="TipoPrestacion", barmode="overlay")
            st.plotly_chart(fig)
    except Exception as e:
        st.error(f"Error en análisis: {e}")
