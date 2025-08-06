# Imagen base robusta compatible con ODBC SQL Server
FROM python:3.10-bullseye

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=America/Bogota

# Instala todas las dependencias necesarias para el driver ODBC 18
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    gcc \
    g++ \
    make \
    unixodbc \
    unixodbc-dev \
    libgssapi-krb5-2 \
    libkrb5-3 \
    libssl-dev \
    libffi-dev \
    libcurl4 \
    odbcinst \
    msodbcsql18 \
    && rm -rf /var/lib/apt/lists/*

# Copia e instala las dependencias de Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el proyecto y define directorio de trabajo
COPY . /app
WORKDIR /app

EXPOSE 8501
CMD ["streamlit", "run", "dashboard.py", "--server.port=8501", "--server.address=0.0.0.0"]
