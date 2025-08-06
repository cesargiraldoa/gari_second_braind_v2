# Dockerfile_microsoft_repo_5ago25_OK
FROM python:3.10-bullseye

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=America/Bogota

# Instalar herramientas básicas
RUN apt-get update && apt-get install -y curl gnupg apt-transport-https

# Agregar repositorio oficial de Microsoft para ODBC Driver 18
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Instalar dependencias y driver
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y \
    msodbcsql18 \
    unixodbc-dev \
    libgssapi-krb5-2 \
    gcc \
    g++ \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    libcurl4 \
    libkrb5-3 \
    odbcinst \
    make \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Establecer carpeta de trabajo
WORKDIR /app

# Copiar archivos de la app
COPY . /app

# Instalar dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Comando por defecto al ejecutar el contenedor
CMD ["streamlit", "run", "dashboard.py", "--server.port=8080", "--server.address=0.0.0.0"]
