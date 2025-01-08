# Usar uma imagem base Python oficial
FROM python:3.9-slim

# Definir diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copiar requirements.txt
COPY requirements.txt .

# Instalar dependências Python
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o código da aplicação
COPY . .

# Criar diretórios necessários
RUN mkdir -p static flask_session

# Configurar variáveis de ambiente
ENV PYTHONUNBUFFERED=1
ENV PORT=8080

# Expor a porta
EXPOSE 8080

# Comando para iniciar a aplicação
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app 