from fastapi import FastAPI
from pydantic import BaseModel
from model import predict_intent

app = FastAPI()

# Définition du schéma des données en entrée
class Message(BaseModel):
    text: str
    domain: str  # On ajoute le champ "domain" pour savoir quel chatbot utiliser

@app.get("/")
def root():
    return {"message": "Chatbot API en marche ✅"}

@app.post("/predict")
def get_response(msg: Message):
    # On passe aussi le domaine au modèle
    response = predict_intent(msg.text, msg.domain)
    return {"response": response}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8501)

