import streamlit as st
import requests

# --- CONFIGURATION ---
st.set_page_config(
    page_title="Assistante IA", 
    page_icon="💬", 
    layout="wide",
    initial_sidebar_state="collapsed"
)

# --- CSS MINIMALISTE ET MODERNE ---
st.markdown("""
<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');
    
    * {
        font-family: 'Poppins', sans-serif;
    }
    
    .stApp {
        background: #0f172a;
    }
    
    /* Masquer les éléments Streamlit */
    #MainMenu, footer, header {visibility: hidden;}
    .stDeployButton {display: none;}
    
    /* Container principal */
    .main-container {
        max-width: 900px;
        margin: 0 auto;
        padding: 40px 20px;
    }
    
    /* Header simple */
    .app-header {
        text-align: center;
        margin-bottom: 40px;
    }
    
    .app-title {
        font-size: 32px;
        font-weight: 600;
        color: #f1f5f9;
        margin: 0;
    }
    
    .app-subtitle {
        color: #94a3b8;
        font-size: 14px;
        margin-top: 8px;
    }
    
    /* Zone de chat */
    .chat-box {
        background: #1e293b;
        border-radius: 16px;
        padding: 24px;
        min-height: 400px;
        max-height: 500px;
        overflow-y: auto;
        margin-bottom: 20px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.3);
    }
    
    .chat-box::-webkit-scrollbar {
        width: 8px;
    }
    
    .chat-box::-webkit-scrollbar-track {
        background: #0f172a;
        border-radius: 10px;
    }
    
    .chat-box::-webkit-scrollbar-thumb {
        background: #475569;
        border-radius: 10px;
    }
    
    /* Messages */
    .message {
        margin-bottom: 20px;
        display: flex;
        gap: 12px;
        align-items: flex-start;
    }
    
    .message.user-msg {
        flex-direction: row-reverse;
    }
    
    .message-avatar {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        flex-shrink: 0;
    }
    
    .user-avatar {
        background: #3b82f6;
    }
    
    .bot-avatar {
        background: #8b5cf6;
    }
    
    .message-content {
        max-width: 70%;
        padding: 12px 16px;
        border-radius: 12px;
        font-size: 14px;
        line-height: 1.6;
    }
    
    .user-msg .message-content {
        background: #3b82f6;
        color: white;
    }
    
    .bot-msg .message-content {
        background: #334155;
        color: #e2e8f0;
    }
    
    /* État vide */
    .empty-chat {
        text-align: center;
        padding: 80px 20px;
        color: #64748b;
    }
    
    .empty-icon {
        font-size: 48px;
        margin-bottom: 16px;
        opacity: 0.5;
    }
    
    /* Zone de saisie */
    .input-area {
        background: #1e293b;
        border-radius: 16px;
        padding: 16px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.3);
    }
    
    .stTextInput input {
        background: #0f172a !important;
        border: 1px solid #334155 !important;
        border-radius: 10px !important;
        color: #f1f5f9 !important;
        padding: 12px 16px !important;
        font-size: 14px !important;
    }
    
    .stTextInput input:focus {
        border-color: #3b82f6 !important;
        box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2) !important;
    }
    
    .stButton button {
        background: #3b82f6 !important;
        color: white !important;
        border: none !important;
        border-radius: 10px !important;
        padding: 12px 24px !important;
        font-weight: 500 !important;
        font-size: 14px !important;
        width: 100%;
        transition: all 0.2s !important;
    }
    
    .stButton button:hover {
        background: #2563eb !important;
        transform: translateY(-1px);
    }
    
    .stSelectbox > div > div {
        background: #0f172a !important;
        border: 1px solid #334155 !important;
        border-radius: 10px !important;
        color: #f1f5f9 !important;
    }
    
    /* Bouton clear */
    .clear-btn {
        background: transparent !important;
        border: 1px solid #334155 !important;
        color: #94a3b8 !important;
    }
    
    .clear-btn:hover {
        background: #1e293b !important;
        border-color: #475569 !important;
    }
</style>
""", unsafe_allow_html=True)

# --- INITIALISATION ---
if "messages" not in st.session_state:
    st.session_state.messages = []

# --- LAYOUT ---
st.markdown('<div class="main-container">', unsafe_allow_html=True)

# Header
st.markdown("""
<div class="app-header">
    <h1 class="app-title">💬 Assistante IA</h1>
    <p class="app-subtitle">Posez vos questions, obtenez des réponses précises</p>
</div>
""", unsafe_allow_html=True)

# Barre d'options
col1, col2, col3 = st.columns([3, 1, 1])
with col1:
    domain = st.selectbox(
        "Domaine",
        ["parcoursup", "sante_agrement"],
        format_func=lambda x: "🎓 Parcoursup" if x == "parcoursup" else "🏥 Santé & Agrément",
        label_visibility="collapsed"
    )

with col3:
    if st.button("🗑️ Effacer", key="clear", help="Effacer la conversation"):
        st.session_state.messages = []
        st.rerun()

# Zone de chat
st.markdown('<div class="chat-box">', unsafe_allow_html=True)

if not st.session_state.messages:
    st.markdown("""
    <div class="empty-chat">
        <div class="empty-icon">💭</div>
        <p><strong>Aucune conversation</strong></p>
        <p>Commencez en posant une question ci-dessous</p>
    </div>
    """, unsafe_allow_html=True)
else:
    for msg in st.session_state.messages:
        if msg["role"] == "user":
            st.markdown(f"""
            <div class="message user-msg">
                <div class="message-avatar user-avatar">👤</div>
                <div class="message-content">{msg['content']}</div>
            </div>
            """, unsafe_allow_html=True)
        else:
            st.markdown(f"""
            <div class="message bot-msg">
                <div class="message-avatar bot-avatar">🤖</div>
                <div class="message-content">{msg['content']}</div>
            </div>
            """, unsafe_allow_html=True)

st.markdown('</div>', unsafe_allow_html=True)

# Zone de saisie
st.markdown('<div class="input-area">', unsafe_allow_html=True)
col1, col2 = st.columns([5, 1])

with col1:
    user_input = st.text_input(
        "Message",
        placeholder="Tapez votre message...",
        label_visibility="collapsed",
        key="user_input"
    )

with col2:
    send = st.button("Envoyer", key="send", type="primary")

st.markdown('</div>', unsafe_allow_html=True)
st.markdown('</div>', unsafe_allow_html=True)

# Traitement de l'envoi
if send and user_input.strip():
    # Ajouter le message utilisateur
    st.session_state.messages.append({"role": "user", "content": user_input})
    
    # Appel API
    try:
        response = requests.post(
            "http://127.0.0.1:8501/predict",
            json={"text": user_input, "domain": domain},
            timeout=10
        )
        
        if response.status_code == 200:
            bot_reply = response.json().get("response", "Aucune réponse reçue.")
        else:
            bot_reply = f"❌ Erreur {response.status_code}"
            
    except requests.exceptions.Timeout:
        bot_reply = "⏱️ Délai d'attente dépassé"
    except requests.exceptions.ConnectionError:
        bot_reply = "🔌 Impossible de se connecter au serveur"
    except Exception as e:
        bot_reply = f"⚠️ Erreur : {str(e)}"
    
    # Ajouter la réponse
    st.session_state.messages.append({"role": "assistant", "content": bot_reply})
    st.rerun()