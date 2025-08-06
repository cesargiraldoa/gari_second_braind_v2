# Imagen base Debian con soporte ODBC y compatibilidad para pyodbc
FROM python:3.10-bullseye

# Variables de entorno
ENV ACCEPT_EULA=Y \
    DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=America/Bogota

# Instala dependencias del sistema y agrega el repositorio de Microsoft para el driver ODBC 18
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unixodbc \
    unixodbc-dev \
    msodbcsql18 \
    libgssapi-krb5-2 \
    libkrb5-3 \
    libcurl4 \
    libssl-dev \
    libffi-dev \
    gcc \
    g++ \
    libpq-dev \
    tzdata \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# Instalar dependencias de Python
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copiar el código de la app
COPY . .

# Puerto expuesto para Streamlit
EXPOSE 10000

# Comando para ejecutar la app en Render
CMD ["streamlit", "run", "dashboard.py", "--server.port=10000", "--server.enableCORS=false"]
