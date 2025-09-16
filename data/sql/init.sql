-- Création des tables pour ChatBox IA
CREATE TABLE conversations (
    id SERIAL PRIMARY KEY,
    session_id VARCHAR(255) NOT NULL,
    user_message TEXT NOT NULL,
    bot_response TEXT NOT NULL,
    confidence_score FLOAT,
    feedback INTEGER, -- -1, 0, 1 pour bad, neutral, good
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE knowledge_base (
    id SERIAL PRIMARY KEY,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    category VARCHAR(100),
    keywords TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE learning_data (
    id SERIAL PRIMARY KEY,
    input_text TEXT NOT NULL,
    intent VARCHAR(100),
    entities JSONB,
    validated BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index pour améliorer les performances
CREATE INDEX idx_conversations_session ON conversations(session_id);
CREATE INDEX idx_knowledge_keywords ON knowledge_base USING GIN(keywords);
CREATE INDEX idx_learning_intent ON learning_data(intent);

-- Insertion de données d'exemple
INSERT INTO knowledge_base (question, answer, category, keywords) VALUES
('Comment ça va?', 'Je vais bien, merci ! Comment puis-je vous aider aujourd''hui ?', 'greeting', '{"comment","va","salutation"}'),
('Qu''est-ce que tu peux faire?', 'Je peux répondre à vos questions, vous aider avec des informations et apprendre de nos conversations.', 'capabilities', '{"que","peux","faire","capacités"}'),
('Comment utiliser Docker?', 'Docker est une plateforme de conteneurisation. Pour démarrer : 1) Installez Docker 2) Créez un Dockerfile 3) Utilisez docker build et docker run', 'technical', '{"docker","conteneur","utiliser"}');