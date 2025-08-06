# Imagen base robusta
FROM python:3.10-bullseye

# Variables de entorno
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=America/Bogota

# Instalación del driver ODBC 18 desde el repositorio oficial de Microsoft
RUN apt-get update && \
    apt-get install -y curl gnupg apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y \
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
    libpq-dev \
    odbcinst \
    msodbcsql18 \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY . /app

# Instalar dependencias de Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Comando para ejecutar la app Streamlit
CMD ["streamlit", "run", "dashboard.py", "--server.port", "8080", "--server.address", "0.0.0.0"]
