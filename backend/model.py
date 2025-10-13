import os
import json
import random
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression

# --- Fonction pour charger les intentions selon le domaine ---
def load_intents(domain):
    base_dir = "C:/Users/h p/chatbox-ia/data"

    # Association entre domaine et fichier JSON
    mapping = {
        "parcoursup": "intents_parcoursup.json",
        "sante": "intents_sante_agrement.json",
        "default": "intents_parcoursup.json"  # fichier par défaut si domaine inconnu
    }

    # Choisir le bon fichier selon le domaine
    file_name = mapping.get(domain.lower(), mapping["default"])
    data_path = os.path.join(base_dir, file_name)

    # Vérification du fichier
    if not os.path.exists(data_path):
        raise FileNotFoundError(f"Fichier introuvable pour le domaine '{domain}' : {data_path}")

    # Chargement du fichier JSON
    with open(data_path, "r", encoding="utf-8") as f:
        return json.load(f)

# --- Fonction pour entraîner le modèle selon le domaine ---
def train_model(domain):
    data = load_intents(domain)
    patterns, tags = [], []

    # Extraire les données (patterns et tags)
    for intent in data["intents"]:
        for pattern in intent["patterns"]:
            patterns.append(pattern)
            tags.append(intent["tag"])

    # Créer le modèle TF-IDF et la régression logistique
    vectorizer = TfidfVectorizer()
    X = vectorizer.fit_transform(patterns)
    y = tags

    model = LogisticRegression()
    model.fit(X, y)

    return model, vectorizer, data

# --- Fonction principale de prédiction ---
def predict_intent(text, domain="default"):
    # Entraînement du modèle pour le domaine choisi
    model, vectorizer, data = train_model(domain)

    # Transformation du texte et prédiction
    X_test = vectorizer.transform([text])
    intent = model.predict(X_test)[0]

    # Chercher une réponse associée à l’intention prédite
    for i in data["intents"]:
        if i["tag"] == intent:
            return random.choice(i["responses"])

    # Si aucune correspondance trouvée
    return "Je n’ai pas bien compris, pouvez-vous reformuler ? 🤔"
