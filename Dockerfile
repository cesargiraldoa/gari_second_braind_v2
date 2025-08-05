FROM python:3.10-bullseye

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TZ=America/Bogota

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    curl \
    gnupg \
    unixodbc \
    unixodbc-dev \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    libcurl4 \
    libkrb5-3 \
    libgssapi-krb5-2 \
    odbcinst \
    tzdata

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app
WORKDIR /app

EXPOSE 8501
CMD ["streamlit", "run", "dashboard.py", "--server.port=8501", "--server.address=0.0.0.0"]
