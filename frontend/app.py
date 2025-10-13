import streamlit as st
import requests

st.title("🤖 Chatbot Multi-Domaines")

# Choix du chatbot / domaine
domain = st.selectbox("Choisissez le chatbot :", ["default", "parcoursup", "sante"])

# Saisie du message utilisateur
user_input = st.text_input("Vous :")

if st.button("Envoyer") and user_input.strip():
    try:
        # Envoi de la requête à FastAPI
        response = requests.post(
            "http://127.0.0.1:8501/predict",  # port où FastAPI écoute
            json={"text": user_input, "domain": domain}
        )

        if response.status_code == 200:
            bot_reply = response.json().get("response", "Pas de réponse")
            st.text_area("Bot :", bot_reply, height=100)
        else:
            st.error(f"Erreur {response.status_code} depuis le serveur")

    except requests.exceptions.RequestException as e:
        st.error(f"Impossible de contacter le serveur : {e}")


