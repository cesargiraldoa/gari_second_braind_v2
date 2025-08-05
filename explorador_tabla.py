import streamlit as st
import pandas as pd
from db_connection import obtener_conexion

def explorar_tabla(nombre_tabla: str, cantidad: int = 1000):
    st.subheader(f"📄 Explorando tabla: {nombre_tabla}")
    
    try:
        conn = obtener_conexion()
        query = f"SELECT TOP {cantidad} * FROM {nombre_tabla}"
        df = pd.read_sql(query, conn)

        st.write(f"Mostrando los primeros {cantidad} registros.")
        st.dataframe(df)

        if st.checkbox("Ver nombres de columnas"):
            st.write(list(df.columns))

    except Exception as e:
        st.error(f"Error al consultar la tabla: {e}")
