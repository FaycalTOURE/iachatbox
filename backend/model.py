import psycopg2
import random
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression

# Connexion à la base PostgreSQL
def get_connection():
    conn = psycopg2.connect(
        host="localhost",
        database="postgres",
        user="postgres",
        password="admin"
    )
    conn.set_client_encoding('UTF8')
    return conn

# Charger les données depuis la table "intents"
def load_intents_from_db(domain):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT tag, pattern, response FROM intents WHERE domaine = %s", (domain,))
    rows = cur.fetchall()
    conn.close()

    patterns = [r[1] for r in rows]
    tags = [r[0] for r in rows]
    responses = {}
    for tag, _, response in rows:
        responses.setdefault(tag, []).append(response)

    return patterns, tags, responses

# Entraîner le modèle à partir des données en BD
def train_model_db(domain):
    patterns, tags, responses = load_intents_from_db(domain)
    vectorizer = TfidfVectorizer()
    X = vectorizer.fit_transform(patterns)
    model = LogisticRegression()
    model.fit(X, tags)
    return model, vectorizer, responses

# Fonction principale de prédiction
def predict_intent_db(text, domain="parcoursup"):
    model, vectorizer, responses = train_model_db(domain)
    X_test = vectorizer.transform([text])
    predicted_tag = model.predict(X_test)[0]
    return random.choice(responses.get(predicted_tag, ["Je n’ai pas compris, reformulez svp. 🤔"]))


