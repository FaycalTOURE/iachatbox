FROM python:3.10-slim

# Dossier de travail
WORKDIR /app

# Copier requirements s’il existe (sinon tu peux directement installer Streamlit + requests)
COPY requirements.txt .

# Installer les dépendances
RUN pip install --no-cache-dir -r requirements.txt

# Copier tous les fichiers frontend
COPY . .

# Exposer le port Streamlit
EXPOSE 8501

# Lancer Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]