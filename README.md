# iachatbox
Le chatbox I.A by Netsen GROUP - Projet POC - CDP F.T 

# Spécification Technique — Projet ChatBox IA Open Source  
## Stagiaire : Aïssatou Diallo  
**Encadrant : Fayçal TOURE**  
**Suivi hebdomadaire : chaque vendredi**

---

## 1. Contexte et Objectifs

Dans le cadre de son stage, Aïssatou est chargée de concevoir et développer une ChatBox intelligente, capable de répondre à des questions générales de type « comment ? », « pourquoi ? », « est-ce que ? », « peux-tu ? » etc.  
L’ambition du projet est de construire une solution 100% open-source, indépendante (aucune dépendance à des services tiers, API propriétaires ou système de crédit), tout en intégrant des fonctionnalités d’auto-apprentissage (machine learning).

---

## 2. Fonctionnalités attendues

### 2.1. Réponse intelligente aux questions  
- **Compréhension du langage naturel** (NLP) pour interpréter des questions générales.
- **Réponses sous plusieurs formats** :
  - Texte simple (explications, procédures pas à pas, synthèses)
  - Lien vers des ressources externes (articles, documentation, vidéos, etc.)
  - Lien ou affichage de fichiers/images/documents internes (si sollicités)
- **Gestion des questions ouvertes** : capacité à gérer des formulations variées.

### 2.2. Moteur d’auto-apprentissage  
- Le système doit pouvoir :
  - **Enregistrer les interactions** pour améliorer ses réponses.
  - **S’enrichir à partir de nouvelles connaissances** (corpus de textes/documents internes ou externes).
  - **Permettre une supervision humaine** (validation/correction des réponses).

### 2.3. Interface Utilisateur  
- Interface simple et ergonomique, accessible via navigateur web.
- Affichage clair des réponses, liens, fichiers, images.
- Possibilité d’exporter les conversations.

### 2.4. Indépendance & Open-source  
- Aucun recours à :
  - API propriétaires type OpenAI, Google, AWS, etc.
  - Systèmes de crédits ou limitations par usage.
- Tous les modules doivent être open-source, hébergés et exécutables localement.

---

## 3. Stack technique & Outils

**Technologies et outils privilégiés :**  
- **Langages & Frameworks** : SCALA, Python (optionnel pour certains modules ML/NLP), Pola.rs, Streamlit.io (pour l’interface)
- **Traitement de données** : Hadoop, Talend, Kaggle (pour les datasets d’entraînement)
- **Base de données** : PostgreSQL (stockage des logs, corpus, interactions)
- **Déploiement** : Docker
- **Visualisation / Reporting** : Power BI

---

## 4. Architecture cible

1. **Moteur NLP/IA**  
   - Module de prétraitement du langage (tokenization, vectorisation, etc.)
   - Module de classification/intention (modèle ML entraîné en local)
   - Moteur de recherche documentaire (corpus local)
   - Générateur de réponses

2. **Backend**  
   - API REST (Scala ou Python) pour l’interface chat
   - Gestion de l’historique, logs, apprentissage supervisé

3. **Frontend**  
   - Streamlit ou autre outil open-source léger pour le chat (interface utilisateur simple et responsive)

4. **Stockage**  
   - PostgreSQL pour persistance des données
   - Système de fichiers pour les documents/images

5. **Déploiement**  
   - Conteneurisation via Docker pour assurer portabilité et indépendance

---

## 5. Contraintes et recommandations

- **Open-source Only** : tous les composants, modules, librairies doivent être open-source.
- **Aucune dépendance à un service tiers** (pas d’appel à des API externes pour le NLP, l’inférence ou la génération de texte).
- **Datasets d’entraînement** à privilégier : jeux de données publics/documentations internes.
- **Sécurité** : anonymisation des logs/conversations si stockage.
- **Scalabilité** : architecture modulaire pour permettre une évolution future.

---

## 6. Méthodologie & Suivi

- **Réunions de suivi** chaque vendredi pour faire un point d’avancement, lever les blocages, ajuster le scope.
- **Livraison incrémentale** : développer puis valider chaque brique fonctionnelle étape par étape.
- **Documentation** : tenir à jour une documentation technique et utilisateur.

---

## 7. Accompagnement

> **Important :**  
> En cas de besoin, tu peux solliciter un accompagnement technique, notamment sur la partie back-end (API, gestion du stockage, conteneurisation Docker, etc).  
> N’hésite pas à demander si tu rencontres des difficultés ou souhaites approfondir un sujet technique.

---

## 8. Livrables attendus

- Code source intégral (hébergement sur GitHub privé ou organisation)
- Documentation technique et utilisateur
- Rapport de stage détaillé (objectifs, méthodologie, résultats, difficultés rencontrées, perspectives)

---

**Bon courage pour le projet !**
