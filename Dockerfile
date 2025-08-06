# Imagen base robusta compatible con drivers ODBC
FROM python:3.10-bullseye

# Variables de entorno
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=America/Bogota

# Instalar dependencias de sistema necesarias para pyodbc + ODBC SQL Server
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    libcurl4 \
    libstdc++6 \
    libkrb5-3 \
    libgssapi-krb5-2 \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    curl \
    gnupg \
    tzdata

# Instalar pipenv y crear directorio de trabajo
RUN pip install --upgrade pip

# Instalar dependencias Python
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copiar el resto del proyecto
COPY . .

# Ejecutar Streamlit
CMD ["streamlit", "run", "dashboard.py", "--server.port=10000", "--server.enableCORS=false"]
# Copiar archivos de la app
COPY . /app

# Instalar dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Comando por defecto al ejecutar el contenedor
CMD ["streamlit", "run", "dashboard.py", "--server.port=8080", "--server.address=0.0.0.0"]
