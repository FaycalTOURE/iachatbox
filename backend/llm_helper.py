# backend/llm_helper.py
import requests
import json

OLLAMA_URL = "http://localhost:11434/api/generate"

def ask_ollama(prompt, model="mistral", max_tokens=512):
    """
    Envoie un prompt à Ollama et renvoie la réponse du modèle Mistral.
    Gère les erreurs et vérifie la structure du JSON.
    """
    payload = {
        "model": model,
        "prompt": prompt,
        "stream": False,
        "options": {
            "num_predict": max_tokens,
            "temperature": 0.4
        }
    }

    try:
        response = requests.post(OLLAMA_URL, json=payload, timeout=90)
        response.raise_for_status()
        data = response.json()

        # Ollama renvoie { "response": "..." }
        if isinstance(data, dict) and "response" in data:
            return data["response"].strip()

        # Autre format (cas rares)
        if "text" in data:
            return data["text"].strip()

        return None

    except requests.exceptions.ConnectionError:
        print("❌ Ollama n’est pas accessible sur localhost:11434")
        return None

    except Exception as e:
        print("⚠️ Erreur lors de l’appel à Ollama :", e)
        return None

