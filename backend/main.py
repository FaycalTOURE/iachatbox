from fastapi import FastAPI
from pydantic import BaseModel
from model import predict_intent_db as predict_intent

app = FastAPI()

# Définition du schéma des données envoyées au backend
class Message(BaseModel):
    text: str
    domain: str

@app.get("/")
def root():
    return {"message": "Chatbot API en marche ✅"}

@app.post("/predict")
def get_response(msg: Message):
    response = predict_intent(msg.text, msg.domain)
    return {"response": response}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8501)

