import pyodbc

def obtener_conexion():
    server = 'dentisalud.database.windows.net'
    database = 'dentisalud-db'
    username = 'cesar'
    password = 'AI4Dentisalud*'
    driver = '{ODBC Driver 18 for SQL Server}'

    connection_string = (
        f'DRIVER={driver};'
        f'SERVER={server};'
        f'DATABASE={database};'
        f'UID={username};'
        f'PWD={password};'
        f'TrustServerCertificate=yes;'
    )

    conn = pyodbc.connect(connection_string)
    return conn
