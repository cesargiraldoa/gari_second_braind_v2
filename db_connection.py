import pyodbc
import pandas as pd

def ejecutar_sql(query):
    conn = pyodbc.connect(
        "DRIVER={ODBC Driver 18 for SQL Server};"
        "SERVER=sql8020.site4now.net;"
        "DATABASE=db_a91131_test;"
        "UID=db_a91131_test_admin;"
        "PWD=dEVOPS2022;"
    )
    df = pd.read_sql(query, conn)
    conn.close()
    return df