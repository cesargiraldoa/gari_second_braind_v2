import pyodbc
import streamlit as st
import time

def get_connection():
    retries = 3
    for attempt in range(retries):
        try:
            conn_str = (
                "DRIVER={ODBC Driver 18 for SQL Server};"
                "SERVER=helexium.database.windows.net;"
                "DATABASE=dentisalud;"
                "UID=gari;"
                "PWD=Garimind.2025;"
                "TrustServerCertificate=yes;"
            )
            return pyodbc.connect(conn_str, timeout=5)
        except pyodbc.OperationalError as e:
            if 'HYT00' in str(e) and attempt < retries - 1:
                st.warning(f"⏳ Intentando reconexión a la BD ({attempt+1}/{retries})...")
                time.sleep(2)
            else:
                st.error(f"❌ Error de conexión a BD: {e}")
                raise
