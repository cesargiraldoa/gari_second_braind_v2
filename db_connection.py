import pyodbc
import streamlit as st

@st.cache_resource
def obtener_conexion():
    try:
        server = 'dentisalud.database.windows.net'
        database = 'dentisalud-db'
        username = 'cesar'
        password = 'AI4Dentisalud*'
        driver = '{ODBC Driver 18 for SQL Server}'

        connection_string = f'''
            DRIVER={driver};
            SERVER={server};
            DATABASE={database};
            UID={username};
            PWD={password};
            Encrypt=yes;
            TrustServerCertificate=no;
            Connection Timeout=30;
        '''

        conexion = pyodbc.connect(connection_string)
        return conexion

    except Exception as e:
        st.error(f"Error al conectar con la base de datos: {e}")
        return None
