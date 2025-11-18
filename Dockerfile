# Utilise Python 3.12 slim
FROM python:3.12-slim

# Définir le répertoire de travail
WORKDIR /app

# Installer les dépendances système
RUN apt-get update && \
    apt-get install -y build-essential netcat && \
    rm -rf /var/lib/apt/lists/*

# Installer Poetry
RUN pip install --no-cache-dir poetry

# Copier les fichiers de configuration Poetry
COPY pyproject.toml poetry.lock* /app/

# Installer les dépendances Python dans le container
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

# Copier le code source et les données
COPY ./src /app/src
COPY ./data /app/data
COPY ./README.md /app/README.md

# Ajouter src au PYTHONPATH pour imports propres
ENV PYTHONPATH=/app

# Commande par défaut pour démarrer FastAPI
CMD ["uvicorn", "energy_demand_forecasting_mlops.api.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
