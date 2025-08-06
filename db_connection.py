# db_connection.py

import pyodbc

def obtener_conexion():
    server = 'gari-core-production.database.windows.net'
    database = 'GariCoreDB'
    username = 'gariadmin'
    password = 'C0ntr@s3g4ri'  # ✅ Confirmado anteriormente
    driver = '{ODBC Driver 18 for SQL Server}'

    conn_str = f"""
        DRIVER={driver};
        SERVER={server};
        DATABASE={database};
        UID={username};
        PWD={password};
        Encrypt=yes;
        TrustServerCertificate=no;
        Connection Timeout=30;
    """
    return pyodbc.connect(conn_str)
