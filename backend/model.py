import psycopg2
from psycopg2.extras import RealDictCursor
from llm_helper import ask_ollama
import re

# Mémoire temporaire des conversations
conversation_memory = {}

# Connexion PostgreSQL
def get_connection():
    return psycopg2.connect(
        dbname="chatbot_ia",
        user="chatbot_user",
        password="admin",  # ⚠️ adapte ton mot de passe ici
        host="localhost",
        port="5432"
    )

def split_questions(text):
    """
    Découpe un message utilisateur contenant plusieurs questions (max 3)
    même sans ponctuation claire.
    """
    text = re.sub(r'\s*(et|ET|Et)\s+', '. ', text)
    text = text.replace('?', '.').replace('!', '.').replace(',', '.')
    parts = re.split(r'\.\s*', text)
    questions = [p.strip() for p in parts if p.strip()]
    return questions[:3]


def predict_intent_db(user_message, domain, user_id="default_user"):
    """
    Recherche dans la base les réponses aux questions.
    Utilise la mémoire pour garder le contexte des échanges.
    """
    try:
        # Vérification du domaine
        if domain.lower() != "parcoursup":
            return "Désolé, cette tâche ne m’a pas été assignée. Je ne traite actuellement que les questions liées à Parcoursup."

        # Initialisation de la mémoire utilisateur
        if user_id not in conversation_memory:
            conversation_memory[user_id] = []

        conn = get_connection()
        cur = conn.cursor(cursor_factory=RealDictCursor)
        cur.execute("CREATE EXTENSION IF NOT EXISTS pg_trgm;")

        # Découper les questions
        questions = split_questions(user_message)
        responses = []

        print(f"🧩 {len(questions)} question(s) détectée(s) :", questions)

        for q in questions:
            # 🔁 Ajouter la question à la mémoire
            conversation_memory[user_id].append({"user": q})

            # Recherche dans la base
            query = """
            SELECT response, similarity(LOWER(pattern), LOWER(%s)) AS score
            FROM intents
            WHERE domaine = %s
            ORDER BY score DESC
            LIMIT 1;
            """
            cur.execute(query, (q, domain))
            result = cur.fetchone()

            if result and result["score"] > 0.3:
                print(f"✅ Réponse trouvée pour '{q}' (score {result['score']:.2f})")
                response_text = result["response"]
            else:
                print(f"⚠️ Pas trouvé dans la base pour : {q}")
                context_text = "\n".join(
                    [f"Utilisateur : {m['user']}\nBot : {m.get('bot','')}" for m in conversation_memory[user_id][-3:]]
                )
                prompt = (
                    f"Contexte précédent :\n{context_text}\n\n"
                    f"L'utilisateur vient de demander : {q}.\n"
                    "Réponds clairement en 2-3 phrases maximum, de manière utile et directe."
                )
                response_text = ask_ollama(prompt)
                if not response_text:
                    response_text = "Je n’ai pas trouvé de réponse précise pour cette question."

            # Sauvegarde la réponse dans la mémoire
            conversation_memory[user_id][-1]["bot"] = response_text
            responses.append(f"🟢 {response_text}")

        cur.close()
        conn.close()

        # 🧠 Combiner les réponses
        final_reply = "\n\n".join(responses)
        return final_reply

    except Exception as e:
        print("⚠️ Erreur dans predict_intent_db:", e)
        return "Erreur interne du chatbot."
