import psycopg2
from psycopg2.extras import RealDictCursor
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from fuzzywuzzy import fuzz
import ollama
import re

def clean_text(text: str) -> str:
    """Nettoyage basique pour éviter les faux positifs."""
    return re.sub(r"[^a-zA-Z0-9\sàâçéèêëîïôûùüÿñæœ]", " ", text.lower()).strip()

def get_connection():
    return psycopg2.connect(
        host="localhost",
        database="chatbot_ia",
        user="chatbot_user",
        password="admin",
        port="5432"
    )

# --- 🔹 Récupération via embeddings Mistral
def retrieve_with_embeddings(question, top_k=3, seuil_similarite=0.6):
    try:
        conn = get_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        emb = ollama.embeddings(model="mistral", prompt=question)["embedding"]

        cur.execute("""
            SELECT question, reponse, 1 - (embedding <=> %s::vector) AS similarity
            FROM faq_parcoursup
            ORDER BY similarity DESC
            LIMIT %s;
        """, (emb, top_k))
        rows = cur.fetchall()
        cur.close()
        conn.close()

        if not rows:
            return []

        results = [r["reponse"] for r in rows if r["similarity"] >= seuil_similarite]
        return results

    except Exception as e:
        print("⚠️ Erreur RAG embeddings :", e)
        return []

# --- 🔹 Récupération via TF-IDF classique
def retrieve_with_tfidf(question, domain, top_k=3):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT pattern, response FROM intents WHERE domaine = %s", (domain,))
    rows = cur.fetchall()
    cur.close()
    conn.close()

    if not rows:
        return []

    patterns = [clean_text(r[0]) for r in rows]
    responses = [r[1] for r in rows]
    question_clean = clean_text(question)

    vectorizer = TfidfVectorizer().fit(patterns + [question_clean])
    X = vectorizer.transform(patterns + [question_clean])
    sims = cosine_similarity(X[-1], X[:-1])[0]

    best_idx = sims.argsort()[-top_k:][::-1]
    contexts = [responses[i] for i in best_idx if sims[i] > 0.15]  # seuil baissé à 0.15
    return contexts

# --- 🔹 Nouveau : Fuzzy Matching (tolère fautes et abréviations)
def retrieve_with_fuzzy(question, domain, seuil=70):
    try:
        conn = get_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("SELECT pattern, response FROM intents WHERE domaine = %s;", (domain,))
        rows = cur.fetchall()
        cur.close()
        conn.close()

        best_match = None
        best_score = 0

        for r in rows:
            score = fuzz.ratio(clean_text(question), clean_text(r['pattern']))
            if score > best_score:
                best_score = score
                best_match = r

        if best_match and best_score >= seuil:
            print(f"✅ Réponse fuzzy trouvée ({best_score}%) : {best_match['pattern']}")
            return [best_match['response']]
        return []

    except Exception as e:
        print("⚠️ Erreur retrieve_with_fuzzy :", e)
        return []

# --- 🔹 Fusion intelligente : embeddings → fuzzy → tfidf
def retrieve_similar_context(question, domain, top_k=3):
    question = clean_text(question)

    # 1️⃣ Essai Embeddings
    results = retrieve_with_embeddings(question, top_k=top_k)
    if results:
        print("✅ Réponse trouvée via embeddings.")
        return results

    # 2️⃣ Fallback : fuzzy matching
    results = retrieve_with_fuzzy(question, domain)
    if results:
        print("✅ Réponse trouvée via fuzzy matching.")
        return results

    # 3️⃣ Dernier recours : TF-IDF
    print("ℹ️ Fallback sur TF-IDF.")
    return retrieve_with_tfidf(question, domain, top_k)


