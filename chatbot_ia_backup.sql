--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: chatbot_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO chatbot_user;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: chatbot_logs; Type: TABLE; Schema: public; Owner: chatbot_user
--

CREATE TABLE public.chatbot_logs (
    id integer NOT NULL,
    event_type character varying(50),
    details text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.chatbot_logs OWNER TO chatbot_user;

--
-- Name: chatbot_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: chatbot_user
--

CREATE SEQUENCE public.chatbot_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chatbot_logs_id_seq OWNER TO chatbot_user;

--
-- Name: chatbot_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatbot_user
--

ALTER SEQUENCE public.chatbot_logs_id_seq OWNED BY public.chatbot_logs.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: chatbot_user
--

CREATE TABLE public.conversations (
    id integer NOT NULL,
    user_id character varying(100),
    domaine character varying(100),
    user_message text NOT NULL,
    bot_response text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.conversations OWNER TO chatbot_user;

--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: chatbot_user
--

CREATE SEQUENCE public.conversations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conversations_id_seq OWNER TO chatbot_user;

--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatbot_user
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: intents; Type: TABLE; Schema: public; Owner: chatbot_user
--

CREATE TABLE public.intents (
    id integer NOT NULL,
    domaine character varying(100) NOT NULL,
    tag character varying(100) NOT NULL,
    pattern text NOT NULL,
    response text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.intents OWNER TO chatbot_user;

--
-- Name: intents_id_seq; Type: SEQUENCE; Schema: public; Owner: chatbot_user
--

CREATE SEQUENCE public.intents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.intents_id_seq OWNER TO chatbot_user;

--
-- Name: intents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chatbot_user
--

ALTER SEQUENCE public.intents_id_seq OWNED BY public.intents.id;


--
-- Name: chatbot_logs id; Type: DEFAULT; Schema: public; Owner: chatbot_user
--

ALTER TABLE ONLY public.chatbot_logs ALTER COLUMN id SET DEFAULT nextval('public.chatbot_logs_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: chatbot_user
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: intents id; Type: DEFAULT; Schema: public; Owner: chatbot_user
--

ALTER TABLE ONLY public.intents ALTER COLUMN id SET DEFAULT nextval('public.intents_id_seq'::regclass);


--
-- Data for Name: chatbot_logs; Type: TABLE DATA; Schema: public; Owner: chatbot_user
--

COPY public.chatbot_logs (id, event_type, details, created_at) FROM stdin;
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: chatbot_user
--

COPY public.conversations (id, user_id, domaine, user_message, bot_response, created_at) FROM stdin;
\.


--
-- Data for Name: intents; Type: TABLE DATA; Schema: public; Owner: chatbot_user
--

COPY public.intents (id, domaine, tag, pattern, response, created_at) FROM stdin;
1	parcoursup	salutation	bonjour	Bonjour 👋, bienvenue sur l’assistant Parcoursup Guinée ! Comment puis-je vous aider aujourd’hui ?	2025-10-29 23:14:57.270595
2	parcoursup	salutation	salut	Salut 👋 ! Je suis votre assistant Parcoursup Guinée. Vous avez une question sur l’inscription ou les formations ?	2025-10-29 23:14:57.270595
3	parcoursup	salutation	bonsoir	Bonsoir 🌙 ! Ravi de vous retrouver sur Parcoursup Guinée. Comment puis-je vous assister ?	2025-10-29 23:14:57.270595
4	parcoursup	inscription	comment m’inscrire sur parcoursup	L’inscription se fait directement sur le site officiel [parcoursupguinee.org](https://parcoursupguinee.org). Créez un compte, remplissez vos informations et formulez vos vœux avant la date limite.	2025-10-29 23:14:57.270595
5	parcoursup	inscription	je veux créer un compte parcoursup	Allez sur le site Parcoursup Guinée et cliquez sur « Créer mon dossier ».	2025-10-29 23:14:57.270595
6	parcoursup	inscription	c’est quand les inscriptions parcoursup	Les inscriptions sont généralement ouvertes de janvier à mars chaque année.	2025-10-29 23:14:57.270595
7	parcoursup	inscription	comment fonctionne l’inscription	Créez un compte, complétez vos informations, puis formulez vos vœux avant la clôture.	2025-10-29 23:14:57.270595
8	parcoursup	documents	quels documents faut-il pour s’inscrire	Vous aurez besoin de votre numéro INE, de vos relevés de notes, d’une pièce d’identité et d’une adresse mail valide.	2025-10-29 23:14:57.270595
9	parcoursup	documents	quels papiers fournir	Les documents principaux sont : relevés de notes, pièce d’identité et lettre de motivation selon les formations.	2025-10-29 23:14:57.270595
10	parcoursup	documents	faut-il un relevé de notes	Oui, les relevés de notes de première et terminale sont nécessaires.	2025-10-29 23:14:57.270595
11	parcoursup	admission	quand aurai-je les résultats	Les résultats d’admission sont publiés à partir de juin sur votre espace Parcoursup Guinée.	2025-10-29 23:14:57.270595
12	parcoursup	admission	comment savoir si je suis accepté	Vous serez notifié directement dans votre espace Parcoursup avec la mention « accepté », « en attente » ou « refusé ».	2025-10-29 23:14:57.270595
13	parcoursup	admission	je n’ai pas eu de proposition	Participez à la phase complémentaire pour formuler de nouveaux vœux.	2025-10-29 23:14:57.270595
14	parcoursup	phase_complementaire	c’est quoi la phase complémentaire	La phase complémentaire permet aux candidats sans proposition de formuler de nouveaux vœux sur les places disponibles.	2025-10-29 23:14:57.270595
15	parcoursup	phase_complementaire	comment participer à la phase complémentaire	Connectez-vous à votre compte Parcoursup Guinée pendant la période de juin à septembre pour formuler de nouveaux vœux.	2025-10-29 23:14:57.270595
16	parcoursup	phase_complementaire	si je n’ai pas été pris, que faire	Participez à la phase complémentaire ou contactez un conseiller Parcoursup Guinée.	2025-10-29 23:14:57.270595
17	parcoursup	contact_aide	comment contacter le support parcoursup	Vous pouvez contacter le support via la rubrique « Contact » sur le site [parcoursupguinee.org](https://parcoursupguinee.org).	2025-10-29 23:14:57.270595
18	parcoursup	contact_aide	je veux parler à un conseiller parcoursup	Appelez le numéro vert Parcoursup Guinée : 625 79 99 06 (appel gratuit).	2025-10-29 23:14:57.270595
19	parcoursup	contact_aide	j’ai un problème de connexion	Essayez de réinitialiser votre mot de passe. Si le problème persiste, contactez le support via [parcoursupguinee.org](https://parcoursupguinee.org).	2025-10-29 23:14:57.270595
20	parcoursup	au_revoir	merci	Merci à vous 🙏 et bonne chance pour vos démarches sur Parcoursup Guinée !	2025-10-29 23:14:57.270595
21	parcoursup	au_revoir	au revoir	Au revoir 👋 ! À bientôt sur Parcoursup Guinée.	2025-10-29 23:14:57.270595
22	parcoursup	au_revoir	bonne journée	Bonne journée 🌞 et succès dans vos démarches Parcoursup Guinée.	2025-10-29 23:14:57.270595
32	sante_agrement	type_agrement	quelles structures doivent être agréées	Les laboratoires, cliniques, pharmacies et centres de formation en santé doivent obtenir un agrément.	2025-10-29 23:24:12.909376
24	sante_agrement	salutation	salut	Salut ! Je suis votre assistant dédié aux demandes d’agrément du Ministère de la Santé. Quelle est votre question ?	2025-10-29 23:24:12.909376
23	sante_agrement\n	salutation	bonjour	Bonjour 👋, bienvenue sur l’assistant du Ministère de la Santé. Comment puis-je vous aider dans votre démarche d’agrément ?	2025-10-29 23:24:12.909376
25	sante_agrement	salutation	bonsoir	Bonsoir 🌙 ! Je suis à votre service pour toute information liée aux agréments du Ministère de la Santé.	2025-10-29 23:24:12.909376
26	sante_agrement	salutation	hey	Hey 👋 ! Comment puis-je vous aider avec votre demande d’agrément ?	2025-10-29 23:24:12.909376
27	sante_agrement	salutation	coucou	Coucou 👋 ! Prêt à vous accompagner dans vos démarches d’agrément au Ministère de la Santé.	2025-10-29 23:24:12.909376
28	sante_agrement	definition_agrement	c’est quoi un agrément	Un agrément est une autorisation officielle délivrée par le Ministère de la Santé, permettant d’exercer une activité réglementée.	2025-10-29 23:24:12.909376
29	sante_agrement	definition_agrement	que signifie obtenir un agrément	Obtenir un agrément signifie que votre structure respecte les normes sanitaires, techniques et éthiques fixées par le Ministère.	2025-10-29 23:24:12.909376
30	sante_agrement	definition_agrement	pourquoi faut-il un agrément	L’agrément garantit que les activités de santé se déroulent dans un cadre conforme et sécurisé.	2025-10-29 23:24:12.909376
31	sante_agrement	type_agrement	quels sont les types d’agrément	Il existe plusieurs types d’agréments : laboratoires, établissements privés de santé, pharmacies et écoles de santé.	2025-10-29 23:24:12.909376
33	sante_agrement	type_agrement	y a-t-il plusieurs types d’agrément	Oui, selon l’activité : laboratoire, établissement, pharmacie ou centre de formation.	2025-10-29 23:24:12.909376
34	sante_agrement	demande_agrement	comment faire une demande d’agrément	La demande se fait auprès de la DEPS (Direction des Établissements Privés de Santé) ou via la plateforme officielle du Ministère de la Santé.	2025-10-29 23:24:12.909376
35	sante_agrement	demande_agrement	où déposer ma demande d’agrément	Vous pouvez déposer votre dossier à la DEPS ou en ligne sur le portail du Ministère de la Santé.	2025-10-29 23:24:12.909376
36	sante_agrement	demande_agrement	je veux demander un agrément	Constituez un dossier complet avec les documents exigés et déposez-le auprès du Ministère.	2025-10-29 23:24:12.909376
37	sante_agrement	documents_requis	quels sont les documents à fournir	Les pièces à fournir incluent : une lettre au Ministre, le registre de commerce, les plans architecturaux et les diplômes du personnel.	2025-10-29 23:24:12.909376
38	sante_agrement	documents_requis	quels papiers faut-il pour un agrément	Vous devez présenter les statuts, le plan des locaux, les CV du personnel et un rapport d’inspection sanitaire.	2025-10-29 23:24:12.909376
39	sante_agrement	documents_requis	quelles pièces sont nécessaires	Les pièces varient selon la structure, mais incluent les documents administratifs, techniques et juridiques.	2025-10-29 23:24:12.909376
40	sante_agrement	delai_traitement	combien de temps pour obtenir un agrément	Le délai moyen est de 30 à 60 jours ouvrables selon le type d’établissement et la complétude du dossier.	2025-10-29 23:24:12.909376
41	sante_agrement	delai_traitement	quel est le délai de traitement	Comptez environ 1 à 2 mois, incluant la phase d’inspection sur site.	2025-10-29 23:24:12.909376
42	sante_agrement	delai_traitement	en combien de jours on reçoit la réponse	La réponse est transmise sous 30 à 60 jours après dépôt du dossier complet.	2025-10-29 23:24:12.909376
43	sante_agrement	suivi_dossier	comment suivre ma demande	Vous pouvez suivre votre dossier sur la plateforme en ligne du Ministère ou en contactant la DEPS.	2025-10-29 23:24:12.909376
44	sante_agrement	suivi_dossier	où en est mon dossier d’agrément	Munissez-vous de votre numéro de dossier pour suivre votre demande auprès de la DEPS.	2025-10-29 23:24:12.909376
45	sante_agrement	suivi_dossier	je veux savoir si mon agrément est validé	Connectez-vous à votre compte sur la plateforme pour vérifier le statut de votre agrément.	2025-10-29 23:24:12.909376
46	sante_agrement	renouvellement	mon agrément est expiré	Si votre agrément est expiré, vous devez faire une nouvelle demande de renouvellement.	2025-10-29 23:24:12.909376
47	sante_agrement	renouvellement	comment renouveler mon agrément	Soumettez une demande de renouvellement 3 mois avant expiration, avec un rapport d’activité et un certificat de conformité.	2025-10-29 23:24:12.909376
48	sante_agrement	renouvellement	quel est le délai de validité d’un agrément	L’agrément est valable entre 3 et 5 ans selon le type d’établissement.	2025-10-29 23:24:12.909376
49	sante_agrement	rejet_dossier	pourquoi mon dossier a été rejeté	Un dossier peut être rejeté s’il est incomplet ou non conforme aux normes sanitaires.	2025-10-29 23:24:12.909376
50	sante_agrement	rejet_dossier	que faire si ma demande est refusée	Vous pouvez déposer une demande de révision après avoir corrigé les points signalés.	2025-10-29 23:24:12.909376
51	sante_agrement	rejet_dossier	mon dossier n’a pas été accepté	Vérifiez les observations du rapport et complétez les pièces manquantes avant une nouvelle soumission.	2025-10-29 23:24:12.909376
52	sante_agrement	contact_ministere	comment contacter le ministère	Contactez le Ministère de la Santé via le standard téléphonique officiel ou la rubrique Contact du site web.	2025-10-29 23:24:12.909376
53	sante_agrement	contact_ministere	quel est le contact du ministère de la santé	Appelez le standard du Ministère ou envoyez un mail à la Direction des Établissements Privés de Santé (DEPS).	2025-10-29 23:24:12.909376
54	sante_agrement	contact_ministere	je veux parler à un agent du ministère	Rendez-vous à la DEPS ou contactez le service d’information du Ministère de la Santé.	2025-10-29 23:24:12.909376
55	sante_agrement	au_revoir	merci	Merci à vous 🙏 Je reste disponible pour toute autre demande d’information.	2025-10-29 23:24:12.909376
56	sante_agrement	au_revoir	au revoir	Au revoir 👋 et bon courage dans vos démarches administratives !	2025-10-29 23:24:12.909376
57	sante_agrement	au_revoir	bonne journée	Bonne journée 🩺 et à très bientôt sur l’assistant du Ministère de la Santé.	2025-10-29 23:24:12.909376
58	sante_agrement	definition_agrement	qui donne les agréments en santé	C’est le Ministère de la Santé, à travers la DEPS, qui attribue les agréments.	2025-10-30 12:06:01.7526
59	sante_agrement	definition_agrement	agrément obligatoire ou non	Oui, l’agrément est obligatoire avant d’ouvrir toute structure médicale, pharmaceutique ou de formation en santé.	2025-10-30 12:06:01.7526
60	sante_agrement	definition_agrement	agrément et autorisation sont-ils pareils	Non, l’autorisation est temporaire, tandis que l’agrément est un acte officiel et permanent.	2025-10-30 12:06:01.7526
61	sante_agrement	definition_agrement	agrément pour un cabinet médical	Oui, les cabinets médicaux privés doivent aussi obtenir un agrément avant de fonctionner.	2025-10-30 12:06:01.7526
62	sante_agrement	definition_agrement	agrément pour un laboratoire privé	Oui, tout laboratoire d’analyses médicales doit avoir un agrément délivré par le Ministère.	2025-10-30 12:06:01.7526
63	sante_agrement	demande_agrement	où trouver le formulaire de demande	Le formulaire est disponible auprès de la DEPS ou téléchargeable sur le site du Ministère de la Santé.	2025-10-30 12:06:01.7526
64	sante_agrement	demande_agrement	faut-il payer pour un agrément	Non, le dépôt du dossier est gratuit, mais certains frais administratifs peuvent s’appliquer.	2025-10-30 12:06:01.7526
65	sante_agrement	demande_agrement	à qui adresser la lettre de demande	La lettre doit être adressée à Monsieur le Ministre de la Santé et de l’Hygiène Publique.	2025-10-30 12:06:01.7526
66	sante_agrement	demande_agrement	est-ce qu’il faut déposer physiquement	Oui, le dossier papier est souvent exigé en plus de la version numérique.	2025-10-30 12:06:01.7526
67	sante_agrement	demande_agrement	est-ce que je peux envoyer par email	Certaines directions acceptent les envois électroniques, mais le dépôt physique reste obligatoire pour validation.	2025-10-30 12:06:01.7526
68	sante_agrement	conditions_agrement	quelles sont les conditions pour avoir un agrément	Les conditions incluent : un personnel qualifié, des locaux conformes, un équipement adapté et un dossier complet.	2025-10-30 12:06:01.7526
69	sante_agrement	conditions_agrement	faut-il être médecin pour demander un agrément	Pas forcément, mais il faut au moins un directeur technique ou responsable médical qualifié.	2025-10-30 12:06:01.7526
70	sante_agrement	conditions_agrement	peut-on avoir un agrément sans diplôme médical	Non, un encadrement médical ou pharmaceutique est obligatoire selon la structure.	2025-10-30 12:06:01.7526
71	sante_agrement	conditions_agrement	est-ce que les locaux doivent être inspectés	Oui, une inspection sanitaire est effectuée avant la délivrance de l’agrément.	2025-10-30 12:06:01.7526
72	sante_agrement	conditions_agrement	y a-t-il des normes d’hygiène à respecter	Oui, les normes d’hygiène, de sécurité et d’accessibilité sont strictement contrôlées.	2025-10-30 12:06:01.7526
73	sante_agrement	apres_agrement	que faire après avoir obtenu l’agrément	Une fois l’agrément obtenu, vous pouvez afficher le certificat dans vos locaux et commencer vos activités.	2025-10-30 12:06:01.7526
74	sante_agrement	apres_agrement	faut-il renouveler chaque année	Non, la durée de validité est de 3 à 5 ans selon le type d’établissement.	2025-10-30 12:06:01.7526
75	sante_agrement	apres_agrement	est-ce qu’on reçoit un certificat	Oui, un certificat d’agrément officiel vous est remis après validation.	2025-10-30 12:06:01.7526
76	sante_agrement	apres_agrement	peut-on transférer un agrément	Non, l’agrément est personnel et lié à une adresse précise. Un transfert nécessite une nouvelle demande.	2025-10-30 12:06:01.7526
77	sante_agrement	apres_agrement	puis-je afficher mon agrément	Oui, il doit même être affiché publiquement dans l’établissement.	2025-10-30 12:06:01.7526
78	sante_agrement	inspection	qui fait les inspections	Les inspections sont menées par la DEPS et les services d’hygiène du Ministère de la Santé.	2025-10-30 12:06:01.7526
79	sante_agrement	inspection	quand a lieu l’inspection	Elle a lieu après le dépôt du dossier et avant la décision d’agrément.	2025-10-30 12:06:01.7526
80	sante_agrement	inspection	est-ce que l’inspection est annoncée	Oui, une date vous est communiquée à l’avance pour préparer la visite.	2025-10-30 12:06:01.7526
81	sante_agrement	inspection	que vérifient les inspecteurs	Ils vérifient les équipements, la conformité des locaux, les diplômes du personnel et les conditions d’hygiène.	2025-10-30 12:06:01.7526
82	sante_agrement	inspection	que se passe-t-il après l’inspection	Un rapport est rédigé et transmis à la commission d’agrément pour décision finale.	2025-10-30 12:06:01.7526
83	sante_agrement	cas_particulier	mon agrément a expiré pendant la pandémie	Vous pouvez demander un renouvellement exceptionnel avec un justificatif de retard.	2025-10-30 12:06:01.7526
84	sante_agrement	cas_particulier	j’ai changé de propriétaire	Un changement de propriétaire nécessite une notification officielle et une nouvelle demande d’agrément.	2025-10-30 12:06:01.7526
85	sante_agrement	cas_particulier	je veux ouvrir une antenne régionale	Chaque site doit disposer de son propre agrément délivré localement.	2025-10-30 12:06:01.7526
86	sante_agrement	cas_particulier	je veux changer le nom de mon centre	Toute modification du nom commercial doit être signalée à la DEPS avec les documents mis à jour.	2025-10-30 12:06:01.7526
87	sante_agrement	cas_particulier	je veux ajouter un service de maternité	Un nouveau service médical nécessite une extension d’agrément approuvée par le Ministère.	2025-10-30 12:06:01.7526
88	sante_agrement	sanction	que risque un établissement non agréé	Il s’expose à une fermeture immédiate et à des sanctions administratives.	2025-10-30 12:06:01.7526
89	sante_agrement	sanction	quelles sont les sanctions possibles	Les sanctions peuvent aller du retrait d’agrément à la fermeture définitive de l’établissement.	2025-10-30 12:06:01.7526
90	sante_agrement	sanction	mon agrément a été suspendu	Contactez la DEPS pour connaître les raisons et les démarches de réhabilitation.	2025-10-30 12:06:01.7526
91	sante_agrement	sanction	peut-on perdre son agrément	Oui, en cas de non-respect des normes, de fraude ou de plainte fondée.	2025-10-30 12:06:01.7526
92	sante_agrement	sanction	que faire en cas de retrait d’agrément	Vous pouvez introduire un recours administratif ou déposer une nouvelle demande après mise en conformité.	2025-10-30 12:06:01.7526
93	sante_agrement	technique	je n’arrive pas à me connecter sur la plateforme	Vérifiez votre identifiant et mot de passe. Si le problème persiste, contactez le support technique.	2025-10-30 12:06:01.7526
94	sante_agrement	technique	le site du ministère ne fonctionne pas	Le site peut être en maintenance. Réessayez plus tard ou contactez le service informatique.	2025-10-30 12:06:01.7526
95	sante_agrement	technique	comment récupérer mon numéro de dossier	Vous pouvez le retrouver dans votre email de confirmation ou sur la plateforme du Ministère.	2025-10-30 12:06:01.7526
96	sante_agrement	technique	je ne reçois pas de mail de confirmation	Vérifiez votre dossier spam ou contactez le service d’assistance du Ministère.	2025-10-30 12:06:01.7526
97	sante_agrement	technique	puis-je suivre ma demande sur téléphone	Oui, la plateforme en ligne du Ministère est accessible sur mobile.	2025-10-30 12:06:01.7526
98	sante_agrement	formation	faut-il un agrément pour ouvrir une école de santé	Oui, toute école de santé doit obtenir un agrément avant d’accueillir des étudiants.	2025-10-30 12:06:01.7526
99	sante_agrement	formation	agrément pour école privée de santé	Il faut un agrément délivré par la DEPS après vérification du programme et du personnel.	2025-10-30 12:06:01.7526
100	sante_agrement	formation	combien coûte un agrément pour école	Le coût dépend des frais administratifs et des visites d’inspection.	2025-10-30 12:06:01.7526
101	sante_agrement	formation	je veux créer un centre de formation médicale	Préparez un dossier complet incluant les diplômes, le programme pédagogique et les plans du centre.	2025-10-30 12:06:01.7526
102	sante_agrement	formation	qui valide les formations médicales privées	C’est la DEPS et la Direction de la Formation qui valident et agréent les établissements de formation.	2025-10-30 12:06:01.7526
103	sante_agrement	au_revoir	merci bien	Merci à vous 🙏 et bon courage dans vos démarches auprès du Ministère.	2025-10-30 12:06:01.7526
104	sante_agrement	au_revoir	bonne continuation	Merci 😊 Prenez soin de vous et à très bientôt.	2025-10-30 12:06:01.7526
105	sante_agrement	au_revoir	merci pour les infos	Avec plaisir ! Je reste disponible pour toute autre question sur les agréments.	2025-10-30 12:06:01.7526
106	sante_agrement	au_revoir	ok merci	Je vous en prie 🙌 N’hésitez pas à revenir si vous avez besoin d’aide.	2025-10-30 12:06:01.7526
107	sante_agrement	au_revoir	merci pour votre aide	C’est un plaisir 💪 Je vous souhaite une bonne réussite dans vos démarches.	2025-10-30 12:06:01.7526
108	parcoursup	infos_generales	comment marche parcoursup	Parcoursup permet aux bacheliers de s’inscrire, formuler des vœux et suivre les réponses des établissements.	2025-10-30 12:32:52.953048
109	parcoursup	infos_generales	je veux savoir comment sa marche	C’est simple 😊 : tu crées ton compte, fais tes vœux et attends les réponses des universités.	2025-10-30 12:32:52.953048
110	parcoursup	infos_generales	je comprend pas parcoursup	Pas de souci ! Je peux t’expliquer étape par étape comment t’inscrire et faire tes vœux.	2025-10-30 12:32:52.953048
111	parcoursup	infos_generales	a quoi sert parcoursup	Parcoursup centralise toutes les candidatures pour les études supérieures après le bac.	2025-10-30 12:32:52.953048
112	parcoursup	infos_generales	c’est pour qui parcoursup	Parcoursup est destiné aux nouveaux bacheliers et à ceux qui veulent se réorienter.	2025-10-30 12:32:52.953048
113	parcoursup	inscription	comment sinscrire sur parcoursup	Tu dois créer ton compte sur le site officiel de Parcoursup avec ton numéro de candidat et une adresse e-mail valide.	2025-10-30 12:32:52.953048
114	parcoursup	inscription	je narrive pas a minscrire	Vérifie ton numéro de bac et ta connexion Internet. Si le problème persiste, contacte le support.	2025-10-30 12:32:52.953048
115	parcoursup	inscription	le site parcoursup marche pas	Le site peut être en maintenance. Réessaie plus tard ou utilise un autre navigateur.	2025-10-30 12:32:52.953048
116	parcoursup	inscription	je me suis trompé dans mon inscription	Tu peux modifier ton dossier tant que la période d’inscription n’est pas close.	2025-10-30 12:32:52.953048
117	parcoursup	inscription	comment modifier mon dossier parcoursup	Connecte-toi à ton compte et clique sur “Modifier mon dossier”.	2025-10-30 12:32:52.953048
118	parcoursup	inscription	je veux supprimer mon compte parcoursup	Tu peux en faire la demande à l’assistance Parcoursup via la rubrique Contact.	2025-10-30 12:32:52.953048
119	parcoursup	documents	quels documents faut pour sinscrire	Il faut ton numéro de candidat, une adresse mail valide, ton relevé de notes et une pièce d’identité.	2025-10-30 12:32:52.953048
120	parcoursup	documents	faut il une carte didentite	Oui, une pièce d’identité est obligatoire pour valider ton dossier.	2025-10-30 12:32:52.953048
121	parcoursup	documents	jai pas mon relevé de note	Tu peux poursuivre ton inscription, mais tu devras le déposer avant la validation finale.	2025-10-30 12:32:52.953048
122	parcoursup	documents	faut il une photo pour le dossier	Non, la photo n’est pas obligatoire sauf si l’établissement la demande.	2025-10-30 12:32:52.953048
123	parcoursup	documents	est ce quil faut un email pour sinscrire	Oui, une adresse e-mail valide est nécessaire pour recevoir les notifications.	2025-10-30 12:32:52.953048
124	parcoursup	orientation	je sais pas quoi choisir	Pas de panique 😊 ! Consulte les fiches formations sur Parcoursup pour trouver celle qui correspond à ton profil.	2025-10-30 12:32:52.953048
125	parcoursup	orientation	quelle filiere choisir apres le bac	Cela dépend de ton bac et de ton projet professionnel. Je peux t’aider à trouver une formation adaptée.	2025-10-30 12:32:52.953048
126	parcoursup	orientation	quelle formation est la meilleure	Chaque formation a ses points forts. Choisis celle qui correspond à tes compétences et à tes objectifs.	2025-10-30 12:32:52.953048
127	parcoursup	orientation	je veux faire medecine	Tu peux postuler en médecine via Parcoursup, selon ton bac et ton classement.	2025-10-30 12:32:52.953048
128	parcoursup	orientation	je veux aller a luniversite gamal	Université Gamal Abdel Nasser figure dans les établissements accessibles via Parcoursup.	2025-10-30 12:32:52.953048
129	parcoursup	admission	jai pas encore recu de reponse	Les réponses arrivent progressivement. Patiente quelques jours et vérifie ton espace candidat.	2025-10-30 12:32:52.953048
130	parcoursup	admission	comment savoir si jai ete accepte	Connecte-toi à ton espace personnel pour voir ton statut d’admission.	2025-10-30 12:32:52.953048
131	parcoursup	admission	jai ete refuse partout	Pas d’inquiétude 😌 ! Tu peux participer à la phase complémentaire ou contacter ton lycée pour un accompagnement.	2025-10-30 12:32:52.953048
132	parcoursup	admission	je suis en attente cest quoi	Tu es sur liste d’attente. Si une place se libère, tu pourras être admis.	2025-10-30 12:32:52.953048
133	parcoursup	admission	jai recu plusieurs propositions	Tu peux accepter une seule proposition à la fois, mais tu peux changer ton choix avant la date limite.	2025-10-30 12:32:52.953048
134	parcoursup	bourses	y a t il des bourses	Oui, des bourses nationales et étrangères sont disponibles selon ton dossier.	2025-10-30 12:32:52.953048
135	parcoursup	bourses	comment demander une bourse	Tu pourras faire ta demande de bourse après ton inscription à l’université.	2025-10-30 12:32:52.953048
136	parcoursup	bourses	peut on avoir une aide financiere	Oui, certaines universités privées proposent des réductions et aides au mérite.	2025-10-30 12:32:52.953048
137	parcoursup	bourses	bourse etrangere disponible	Des bourses étrangères sont accessibles via le Ministère de l’Enseignement Supérieur.	2025-10-30 12:32:52.953048
138	parcoursup	bourses	comment savoir si jai une bourse	Tu recevras la notification dans ton compte Parcoursup ou par ton université.	2025-10-30 12:32:52.953048
139	parcoursup	aide	mon dossier est bloque	Vérifie que toutes les pièces sont téléchargées. Sinon, contacte le support Parcoursup.	2025-10-30 12:32:52.953048
140	parcoursup	aide	je veux de laide	Bien sûr 😊 Dis-moi sur quoi tu veux de l’aide : inscription, vœux, résultats ou bourses ?	2025-10-30 12:32:52.953048
141	parcoursup	aide	je comprends rien au site	Pas de souci 😅 Je peux t’expliquer chaque étape. Tu veux commencer par l’inscription ?	2025-10-30 12:32:52.953048
142	parcoursup	aide	le site est lent	Cela peut venir d’un grand nombre de connexions. Réessaie un peu plus tard.	2025-10-30 12:32:52.953048
143	parcoursup	aide	ma page ne charge pas	Vide le cache de ton navigateur ou essaie depuis un autre appareil.	2025-10-30 12:32:52.953048
144	parcoursup	phase_complementaire	cest quoi la phase complementaire	C’est une seconde session pour formuler de nouveaux vœux sur les places encore disponibles.	2025-10-30 12:32:52.953048
145	parcoursup	phase_complementaire	quand commence la phase complementaire	Elle débute généralement en juillet et se termine en septembre.	2025-10-30 12:32:52.953048
146	parcoursup	phase_complementaire	comment participer a la phase complementaire	Connecte-toi à ton compte et choisis parmi les formations encore ouvertes.	2025-10-30 12:32:52.953048
147	parcoursup	phase_complementaire	jai ete oublie dans les resultats	Contacte le support Parcoursup avec ton numéro de dossier pour vérification.	2025-10-30 12:32:52.953048
148	parcoursup	phase_complementaire	jai un probleme avec ma reponse	Tu peux envoyer une réclamation via la rubrique “Contact” du site.	2025-10-30 12:32:52.953048
149	parcoursup	salutation	bonjour	Bonjour 👋, bienvenue sur l’assistant Parcoursup ! Prêt(e) à commencer ton inscription ?	2025-10-30 12:32:52.953048
150	parcoursup	salutation	salut	Salut 👋 ! Je peux t’aider à comprendre ou remplir ton dossier Parcoursup.	2025-10-30 12:32:52.953048
151	parcoursup	salutation	bonsoir	Bonsoir 🌙 ! Tu veux que je t’aide avec Parcoursup ?	2025-10-30 12:32:52.953048
152	parcoursup	salutation	coucou	Coucou 👋 ! Besoin d’un coup de main pour ton inscription sur Parcoursup ?	2025-10-30 12:32:52.953048
153	parcoursup	salutation	hey	Hey 👋 ! Je suis là pour t’aider avec tes démarches sur Parcoursup.	2025-10-30 12:32:52.953048
154	parcoursup	au_revoir	merci	Merci à toi 🙏 et bon courage pour ton orientation !	2025-10-30 12:32:52.953048
155	parcoursup	au_revoir	merci beaucoup	Avec plaisir 😊 Bonne chance dans ton orientation sur Parcoursup !	2025-10-30 12:32:52.953048
156	parcoursup	au_revoir	bonne journee	Bonne journée 🌞 et à bientôt sur Parcoursup !	2025-10-30 12:32:52.953048
157	parcoursup	au_revoir	bye	Bye 👋 et bonne continuation dans tes études !	2025-10-30 12:32:52.953048
158	parcoursup	au_revoir	ok merci bcp	Je t’en prie 🙏 Reviens si tu veux plus d’informations.	2025-10-30 12:32:52.953048
160	parcoursup	infos_generales	parcoursup la cest quoi meme	C’est la plateforme d’inscription pour toutes les universités et écoles guinéennes après le bac.	2025-11-03 13:10:10.473953
161	parcoursup	orientation	je veux faire une ecole rapide genre 2 ans	Tu peux viser un BTS ou une école professionnelle, il y en a plusieurs sur Parcoursup Guinée.	2025-11-03 13:10:10.473953
162	parcoursup	orientation	je veux savoir comment choisir mon universite	Tu peux comparer les universités selon les formations, les débouchés et la localisation.	2025-11-03 13:10:10.473953
163	parcoursup	documents	faut il payer pour sinscrire sur parcoursup	Non, l’inscription sur Parcoursup Guinée est totalement gratuite.	2025-11-03 13:10:10.473953
164	parcoursup	admission	jai pas recu de reponse depuis longtemps	Les établissements mettent parfois du temps à répondre. Vérifie régulièrement ton espace candidat.	2025-11-03 13:10:10.473953
165	parcoursup	bourses	comment savoir si mon dossier de bourse est valide	Tu recevras un message de confirmation une fois que ton dossier sera validé par le service concerné.	2025-11-03 13:10:10.473953
166	parcoursup	aide	je narrive pas a me connecter sur parcoursup	Vérifie ton mot de passe et ton email. Si ça ne marche pas, clique sur “Mot de passe oublié”.	2025-11-03 13:10:10.473953
167	parcoursup	infos_generales	cest quoi parcoursup guinee	Parcoursup Guinée est la plateforme officielle d’orientation pour les bacheliers vers les universités et écoles du pays.	2025-11-03 13:11:25.365748
168	parcoursup	infos_generales	qui gere parcoursup	C’est le Ministère de l’Enseignement Supérieur et de la Recherche Scientifique de Guinée.	2025-11-03 13:11:25.365748
169	parcoursup	infos_generales	est ce obligatoire parcoursup	Oui, pour s’inscrire dans la plupart des universités publiques, il faut passer par Parcoursup Guinée.	2025-11-03 13:11:25.365748
170	parcoursup	infos_generales	est ce que parcoursup est payant	Non, l’inscription sur Parcoursup est totalement gratuite.	2025-11-03 13:11:25.365748
171	parcoursup	infos_generales	je veux comprendre comment sa marche	Pas de souci ! Tu fais ton inscription, ajoutes tes vœux et suis les réponses des universités sur ton compte.	2025-11-03 13:11:25.365748
172	parcoursup	infos_generales	comment avoir un compte parcoursup	Tu dois créer un compte avec ton numéro de candidat du bac et ton adresse mail valide.	2025-11-03 13:11:25.365748
173	parcoursup	infos_generales	parcoursup cest fini ou pas	Pas encore 😄, les inscriptions sont toujours en cours selon le calendrier officiel.	2025-11-03 13:11:25.365748
174	parcoursup	infos_generales	cest quoi un voeu parcoursup	Un vœu, c’est un choix de formation ou d’université que tu veux rejoindre après ton bac.	2025-11-03 13:11:25.365748
175	parcoursup	inscription	je narrive pas a me connecter	Vérifie ton mot de passe ou ton numéro de candidat. Tu peux cliquer sur “Mot de passe oublié”.	2025-11-03 13:11:25.365748
176	parcoursup	inscription	le site parcoursup beug	Il se peut que le site soit surchargé. Essaie à un autre moment ou avec une bonne connexion.	2025-11-03 13:11:25.365748
177	parcoursup	inscription	je narrive pas a valider mon dossier	Assure-toi que tous les champs obligatoires sont remplis avant de valider.	2025-11-03 13:11:25.365748
178	parcoursup	inscription	on me dit numero candidat invalide	Vérifie que tu as bien saisi ton numéro du bac 2025 ou contacte ton lycée pour confirmation.	2025-11-03 13:11:25.365748
179	parcoursup	inscription	jaimerais reprendre mon inscription	Tu peux rouvrir ton dossier si la période d’inscription est encore ouverte.	2025-11-03 13:11:25.365748
180	parcoursup	inscription	jai perdu mon mot de passe parcoursup	Pas de panique 😌, clique sur “Mot de passe oublié” et suis les instructions.	2025-11-03 13:11:25.365748
181	parcoursup	inscription	comment faire si jai pas dinternet	Tu peux te rendre dans un cyber ou un espace numérique dans ton lycée pour t’inscrire.	2025-11-03 13:11:25.365748
182	parcoursup	inscription	est ce que je peux minscrire avec le portable	Oui, mais il est préférable d’utiliser un ordinateur pour plus de confort.	2025-11-03 13:11:25.365748
183	parcoursup	documents	jai pas ma piece didentite	Tu peux continuer ton inscription, mais il faudra la fournir avant la validation définitive.	2025-11-03 13:11:25.365748
184	parcoursup	documents	est ce quil faut le bac original	Non, une copie ou ton numéro de candidat suffit pour l’inscription.	2025-11-03 13:11:25.365748
185	parcoursup	documents	comment deposer mes fichiers	Connecte-toi à ton compte et utilise l’option “Téléverser un document”.	2025-11-03 13:11:25.365748
186	parcoursup	documents	faut il une attestation de reussite	Oui, si ton diplôme du bac n’est pas encore disponible, tu peux mettre l’attestation.	2025-11-03 13:11:25.365748
187	parcoursup	documents	jai pas encore mes notes	Pas de souci, tu peux les ajouter plus tard avant la fermeture des dossiers.	2025-11-03 13:11:25.365748
188	parcoursup	documents	mon relevé de note est illisible	Télécharge un nouveau document clair et bien scanné.	2025-11-03 13:11:25.365748
189	parcoursup	documents	on demande quoi dans la lettre de motivation	Tu dois expliquer pourquoi tu veux cette formation et ce qui t’intéresse dedans.	2025-11-03 13:11:25.365748
190	parcoursup	orientation	je sais pas quoi faire apres le bac	C’est normal ! Je peux t’aider à découvrir les filières disponibles selon ton profil.	2025-11-03 13:11:25.365748
191	parcoursup	orientation	quelle ecole est mieux a conakry	Cela dépend de ton domaine d’étude. Par exemple, Gamal pour médecine, Kofi Annan pour informatique, etc.	2025-11-03 13:11:25.365748
192	parcoursup	orientation	je veux etudier a lambanyi	Tu peux choisir une école privée dans la zone de Lambanyi si elle figure sur Parcoursup.	2025-11-03 13:11:25.365748
193	parcoursup	orientation	je veux aller a lambanyi universite	Cherche “Université de Lambanyi” dans la liste des formations Parcoursup.	2025-11-03 13:11:25.365748
194	parcoursup	orientation	comment choisir la meilleure formation	Compare les débouchés, les matières et les avis des étudiants avant de choisir.	2025-11-03 13:11:25.365748
195	parcoursup	orientation	je veux faire droit	Très bon choix ⚖️ ! Les facultés de droit sont disponibles sur Parcoursup.	2025-11-03 13:11:25.365748
196	parcoursup	orientation	je veux faire comptabilite	Tu peux choisir une école de commerce ou de gestion dans Parcoursup Guinée.	2025-11-03 13:11:25.365748
197	parcoursup	orientation	comment trouver une formation rapide	Cherche les formations courtes ou les BTS accessibles après le bac.	2025-11-03 13:11:25.365748
198	parcoursup	orientation	comment trouver ma vocation	Parle de tes matières préférées ou de ce que tu aimes faire, je peux t’aider à orienter ton choix.	2025-11-03 13:11:25.365748
199	parcoursup	admission	comment savoir si jai ete accepte	Va dans ton espace personnel Parcoursup et regarde la colonne “Réponse des établissements”.	2025-11-03 13:11:25.365748
200	parcoursup	admission	jai pas recu de message	Vérifie tes notifications dans ton compte et aussi ton e-mail.	2025-11-03 13:11:25.365748
201	parcoursup	admission	on ma mis en attente cest grave	Non, tu es sur la liste d’attente. Si une place se libère, tu pourras être accepté.	2025-11-03 13:11:25.365748
202	parcoursup	admission	jai refuse sans faire expres	Tu peux contacter le support rapidement pour voir s’il est possible de réactiver ton choix.	2025-11-03 13:11:25.365748
203	parcoursup	admission	jai ete accepte dans deux ecoles	Tu dois choisir une seule proposition à la fois.	2025-11-03 13:11:25.365748
204	parcoursup	admission	comment valider mon choix	Clique sur “Accepter la proposition” dans ton espace candidat.	2025-11-03 13:11:25.365748
205	parcoursup	admission	jai pas ete pris nul part	Ne t’inquiète pas ! La phase complémentaire te permettra de refaire des vœux.	2025-11-03 13:11:25.365748
206	parcoursup	bourses	je veux une bourse detude	Tu peux faire ta demande auprès du ministère ou de ton université après ton admission.	2025-11-03 13:11:25.365748
207	parcoursup	bourses	est ce quil y a des bourses en guinee	Oui, il existe des bourses nationales et aussi quelques aides privées.	2025-11-03 13:11:25.365748
208	parcoursup	bourses	comment faire pour etre boursier	Dépose ta demande de bourse en ligne après ton admission sur Parcoursup.	2025-11-03 13:11:25.365748
209	parcoursup	bourses	je veux une bourse a letranger	Tu peux postuler à des programmes comme le DAAD, Campus France, ou Maroc Bourse selon ton profil.	2025-11-03 13:11:25.365748
210	parcoursup	bourses	est ce quil y a une bourse pour les filles	Oui, certaines institutions encouragent les candidatures féminines avec des aides spécifiques.	2025-11-03 13:11:25.365748
211	parcoursup	aide	le site ne souvre pas	Vérifie ta connexion ou essaye avec un autre navigateur.	2025-11-03 13:11:25.365748
212	parcoursup	aide	parcoursup ne marche pas sur mon tel	Le site fonctionne mieux sur ordinateur. Essaie depuis un PC.	2025-11-03 13:11:25.365748
213	parcoursup	aide	jai une erreur 404	Cela veut dire que la page n’existe plus ou est en maintenance. Réessaie plus tard.	2025-11-03 13:11:25.365748
214	parcoursup	aide	je vois rien sur mon tableau de bord	Recharge la page ou reconnecte-toi à ton compte.	2025-11-03 13:11:25.365748
215	parcoursup	aide	comment contacter parcoursup	Utilise la rubrique “Contact” sur le site ou passe par ton établissement.	2025-11-03 13:11:25.365748
216	parcoursup	salutation	yo	Yo 👋 ! Prêt à t’inscrire sur Parcoursup Guinée ?	2025-11-03 13:11:25.365748
217	parcoursup	salutation	slt	Salut 👋, comment ça va ? Tu veux qu’on parle de ton inscription ?	2025-11-03 13:11:25.365748
218	parcoursup	salutation	ça va	Oui merci 😊 et toi ? Tu veux de l’aide avec Parcoursup ?	2025-11-03 13:11:25.365748
219	parcoursup	salutation	tu es qui	Je suis ton assistant virtuel Parcoursup Guinée, là pour t’aider avec ton orientation.	2025-11-03 13:11:25.365748
220	parcoursup	salutation	qui ta cree	J’ai été créé pour aider les étudiants guinéens à mieux comprendre Parcoursup.	2025-11-03 13:11:25.365748
221	parcoursup	salutation	tu fais quoi	Je t’aide à t’orienter, comprendre Parcoursup et régler tes soucis d’inscription !	2025-11-03 13:11:25.365748
222	parcoursup	salutation	tu peux maider	Oui bien sûr 😊, dis-moi juste ce que tu veux savoir sur Parcoursup.	2025-11-03 13:11:25.365748
223	parcoursup	salutation	qui est tu	Je suis un assistant virtuel Parcoursup Guinée, toujours prêt à t’aider !	2025-11-03 13:11:25.365748
224	parcoursup	au_revoir	merci infiniment	Avec plaisir 🙏, je te souhaite une belle réussite pour ton inscription !	2025-11-03 13:11:25.365748
225	parcoursup	au_revoir	bonne nuit	Bonne nuit 🌙, repose-toi bien et reviens quand tu veux !	2025-11-03 13:11:25.365748
226	parcoursup	au_revoir	a bientot	À bientôt 👋, n’hésite pas à revenir si tu as besoin d’aide.	2025-11-03 13:11:25.365748
227	parcoursup	au_revoir	merci pour laide	Toujours là pour t’aider 😊 ! Bonne chance avec Parcoursup Guinée.	2025-11-03 13:11:25.365748
228	parcoursup	au_revoir	je vais dormir	D’accord 😴, repose-toi bien et à demain pour continuer ton inscription !	2025-11-03 13:11:25.365748
229	sante_agrement	infos_generales	cest quoi sante agrement	Santé Agrément est la plateforme officielle du Ministère de la Santé qui gère les agréments, autorisations et renouvellements des structures sanitaires en Guinée.	2025-11-03 13:37:35.035827
230	sante_agrement	infos_generales	qui gere sante agrement	C’est le Ministère de la Santé et de l’Hygiène Publique à travers la Direction Nationale des Établissements de Soins.	2025-11-03 13:37:35.035827
231	sante_agrement	infos_generales	est ce obligatoire de sinscrire sur sante agrement	Oui, toute clinique, pharmacie, laboratoire ou centre de soins doit être enregistré sur Santé Agrément pour exercer légalement.	2025-11-03 13:37:35.035827
232	sante_agrement	infos_generales	est ce payant	Non, la création de compte sur Santé Agrément est gratuite, mais certaines démarches administratives peuvent nécessiter des frais officiels.	2025-11-03 13:37:35.035827
233	sante_agrement	infos_generales	a quoi sert sante agrement	La plateforme sert à centraliser les demandes d’agrément, les suivis et les renouvellements des structures sanitaires.	2025-11-03 13:37:35.035827
234	sante_agrement	infos_generales	ou trouver le site officiel	Tu peux accéder à Santé Agrément Guinée via le lien : https://sante-agrement.gov.gn.	2025-11-03 13:37:35.035827
235	sante_agrement	infos_generales	comment marche sante agrement	Tu crées un compte, remplis ton dossier en ligne, puis suis ton état d’avancement jusqu’à la validation officielle.	2025-11-03 13:37:35.035827
236	sante_agrement	infos_generales	quelle difference entre sante agrement et mesrs	Santé Agrément relève du Ministère de la Santé, tandis que le MESRS gère les universités et formations supérieures.	2025-11-03 13:37:35.035827
237	sante_agrement	inscription	comment creer un compte	Va sur https://sante-agrement.gov.gn, clique sur “Créer un compte”, puis remplis le formulaire avec tes informations.	2025-11-03 13:37:35.035827
238	sante_agrement	inscription	je narrive pas a me connecter	Vérifie ton mot de passe et ton adresse e-mail. Si besoin, clique sur “Mot de passe oublié”.	2025-11-03 13:37:35.035827
239	sante_agrement	inscription	le site beug	Essaie avec une bonne connexion ou depuis un autre navigateur comme Chrome.	2025-11-03 13:37:35.035827
240	sante_agrement	inscription	jai perdu mon mot de passe	Clique sur “Mot de passe oublié” sur la page d’accueil du site pour le réinitialiser.	2025-11-03 13:37:35.035827
241	sante_agrement	inscription	on me dit identifiant invalide	Vérifie l’adresse e-mail utilisée lors de la création du compte.	2025-11-03 13:37:35.035827
242	sante_agrement	inscription	est ce que je peux creer un compte pour une autre clinique	Oui, si tu es le représentant légal ou autorisé à le faire.	2025-11-03 13:37:35.035827
243	sante_agrement	documents	quels documents faut pour demander lagrement	Tu dois fournir les statuts, la carte d’identité du promoteur, le plan de localisation, et le rapport technique du local.	2025-11-03 13:37:35.035827
244	sante_agrement	documents	faut il une visite du ministere	Oui, une mission d’inspection se déplace pour vérifier la conformité de la structure avant validation.	2025-11-03 13:37:35.035827
245	sante_agrement	documents	comment deposer mes fichiers	Connecte-toi sur ton compte et téléverse les documents demandés dans ton espace personnel.	2025-11-03 13:37:35.035827
246	sante_agrement	documents	mon dossier est incomplet	Ajoute les pièces manquantes avant de soumettre ta demande pour éviter le rejet.	2025-11-03 13:37:35.035827
247	sante_agrement	documents	combien de temps pour avoir lagrement	Le délai moyen est de 15 à 30 jours après la visite de conformité.	2025-11-03 13:37:35.035827
248	sante_agrement	documents	comment suivre lavancement de ma demande	Connecte-toi à ton compte et consulte la rubrique “Suivi de dossier”.	2025-11-03 13:37:35.035827
249	sante_agrement	aide	le site ne souvre pas	Vérifie ta connexion Internet ou essaie plus tard, il peut être en maintenance.	2025-11-03 13:37:35.035827
250	sante_agrement	aide	jai une erreur 404	Cela signifie que la page demandée n’existe plus. Retourne à la page d’accueil : https://sante-agrement.gov.gn.	2025-11-03 13:37:35.035827
251	sante_agrement	aide	le bouton valider ne marche pas	Recharge la page ou utilise un autre navigateur.	2025-11-03 13:37:35.035827
252	sante_agrement	aide	je vois rien sur mon tableau de bord	Déconnecte-toi puis reconnecte-toi à ton compte.	2025-11-03 13:37:35.035827
253	sante_agrement	aide	comment contacter sante agrement	Tu peux écrire via le formulaire de contact sur le site ou appeler le Ministère de la Santé au +224 620 00 00 00.	2025-11-03 13:37:35.035827
254	sante_agrement	aide	je veux parler a quelquun	Va dans la rubrique “Contact” du site ou rends-toi à la Direction des Établissements de Soins.	2025-11-03 13:37:35.035827
255	sante_agrement	salutation	salut	Salut 👋 ! Tu veux qu’on parle de ton agrément ou de ton inscription ?	2025-11-03 13:37:35.035827
256	sante_agrement	salutation	bonjour	Bonjour 😊 ! Prêt à créer ton dossier sur Santé Agrément Guinée ?	2025-11-03 13:37:35.035827
257	sante_agrement	salutation	tu es qui	Je suis l’assistant virtuel Santé Agrément Guinée, là pour t’aider dans tes démarches.	2025-11-03 13:37:35.035827
258	sante_agrement	salutation	merci	Avec plaisir 🙏 ! Bon courage pour ta demande d’agrément.	2025-11-03 13:37:35.035827
259	sante_agrement	au_revoir	a bientot	À bientôt 👋 ! Reviens si tu as besoin d’aide pour ton dossier.	2025-11-03 13:37:35.035827
260	sante_agrement	au_revoir	bonne nuit	Bonne nuit 🌙, repose-toi bien et à demain pour continuer ta démarche.	2025-11-03 13:37:35.035827
261	sante_agrement	demande	je veux ouvrir une clinique privee	Tu dois d’abord créer un compte sur https://sante-agrement.gov.gn, remplir la fiche de demande, et joindre les documents requis pour obtenir ton agrément.	2025-11-03 13:37:35.035827
262	sante_agrement	demande	je veux renouveler mon agrement	Connecte-toi à ton compte et clique sur “Renouvellement d’agrément”. Joins les pièces mises à jour.	2025-11-03 13:37:35.035827
263	sante_agrement	demande	comment faire pour modifier les informations de ma clinique	Va dans ton espace “Mon profil établissement” et mets à jour les données.	2025-11-03 13:37:35.035827
264	sante_agrement	demande	jai change de local	Tu dois signaler le changement via ton espace en ligne et demander une nouvelle inspection.	2025-11-03 13:37:35.035827
265	sante_agrement	demande	mon agrement est expire	Tu peux le renouveler directement sur la plateforme, avant ou après expiration, selon les procédures du ministère.	2025-11-03 13:37:35.035827
266	sante_agrement	demande	je veux ouvrir une pharmacie	Les demandes d’ouverture de pharmacie se font aussi sur la plateforme Santé Agrément avec un dossier spécifique.	2025-11-03 13:37:35.035827
267	sante_agrement	suivi	mon dossier est en attente	Cela veut dire qu’il est en cours de traitement par la commission d’agrément.	2025-11-03 13:37:35.035827
268	sante_agrement	suivi	mon dossier a ete rejete	Consulte le motif de rejet dans ton espace personnel et corrige les points demandés avant de le renvoyer.	2025-11-03 13:37:35.035827
269	sante_agrement	suivi	jai recu un mail mais je comprends pas	Le mail t’informe de l’évolution de ton dossier. Connecte-toi sur la plateforme pour voir les détails.	2025-11-03 13:37:35.035827
270	sante_agrement	suivi	comment savoir si jai ete approuve	Tu recevras une notification “Agrément validé” dans ton compte et par e-mail officiel.	2025-11-03 13:37:35.035827
271	sante_agrement	suivi	jai pas de nouvelle depuis longtemps	Les délais peuvent varier. Si cela dépasse 30 jours, contacte la direction via le site.	2025-11-03 13:37:35.035827
272	sante_agrement	paiement	faut il payer pour lagrement	Oui, certains types d’agrément nécessitent des frais administratifs fixés par le Ministère de la Santé.	2025-11-03 13:37:35.035827
273	sante_agrement	paiement	comment payer les frais	Le paiement se fait soit par dépôt bancaire, soit par mobile money selon les instructions de la plateforme.	2025-11-03 13:37:35.035827
274	sante_agrement	paiement	jai paye mais cest pas valide	Conserve ton reçu et contacte le service technique via le formulaire de contact.	2025-11-03 13:37:35.035827
275	sante_agrement	paiement	y a t il des frais pour renouvellement	Oui, mais ils sont souvent moins élevés que pour une première demande.	2025-11-03 13:37:35.035827
276	sante_agrement	paiement	je veux savoir combien coute lagrement	Le tarif dépend du type de structure : clinique, laboratoire, pharmacie ou centre médical.	2025-11-03 13:37:35.035827
277	sante_agrement	salutation	tu es un humain	Non 😄, je suis un assistant virtuel de Santé Agrément Guinée, mais je parle comme toi !	2025-11-03 13:37:35.035827
278	sante_agrement	salutation	tu habite ou	Je suis dans le cloud ☁️, mais je travaille pour les professionnels de santé de Guinée 🇬🇳.	2025-11-03 13:37:35.035827
279	sante_agrement	salutation	tu peux maider	Oui bien sûr 😊 ! Dis-moi si c’est pour une inscription, un renouvellement ou une question de document.	2025-11-03 13:37:35.035827
280	sante_agrement	salutation	trop cool ton aide	Merci 😄 ! Mon but est que ta demande d’agrément se passe sans stress.	2025-11-03 13:37:35.035827
281	sante_agrement	salutation	tu fais quoi maintenant	Je t’attends pour t’aider avec ta démarche sur Santé Agrément Guinée.	2025-11-03 13:37:35.035827
282	sante_agrement	salutation	jai faim lol	😂 Mange bien d’abord, puis on reprend ton dossier tranquille !	2025-11-03 13:37:35.035827
283	sante_agrement	humour	tu dors pas	Non 😆, je travaille 24h/24 pour t’aider à finaliser ton agrément !	2025-11-03 13:37:35.035827
284	sante_agrement	humour	tu es medecin toi	Pas encore 😅, mais je connais bien les démarches administratives du ministère.	2025-11-03 13:37:35.035827
285	sante_agrement	humour	si je te paye tu fais mon dossier	Haha non 😄, mais je peux t’expliquer comment bien le remplir toi-même !	2025-11-03 13:37:35.035827
286	sante_agrement	au_revoir	merci beaucoup	Avec plaisir 🙏 ! Que ta demande d’agrément soit validée rapidement.	2025-11-03 13:37:35.035827
287	sante_agrement	au_revoir	je reviendrai demain	Super 😄, je t’attendrai pour continuer ton dossier.	2025-11-03 13:37:35.035827
288	sante_agrement	au_revoir	bonne chance a toi aussi	Merci 😊, mais c’est toi qui vas réussir ton agrément !	2025-11-03 13:37:35.035827
289	sante_agrement	au_revoir	bonne soiree	Bonne soirée 🌆 et à très vite sur Santé Agrément Guinée.	2025-11-03 13:37:35.035827
290	sante_agrement	au_revoir	a demain	À demain 👋 ! On reprendra ta demande ensemble.	2025-11-03 13:37:35.035827
291	sante_agrement	au_revoir	merci pour tout	Toujours là pour t’aider 😊 ! Courage pour la suite de ta procédure.	2025-11-03 13:37:35.035827
292	parcoursup	difference_parcourpro	quelle est la difference entre parcoursup et parcourpro	Parcoursup Guinée est dédié aux formations universitaires après le bac, tandis que ParcourPro concerne les formations techniques et professionnelles.	2025-11-04 13:53:17.008704
293	parcoursup	difference_parcourpro	cest quoi la difference entre parcoursup et les formations pro	Les formations professionnelles sont orientées vers la pratique et les métiers manuels, alors que Parcoursup concerne les études supérieures académiques.	2025-11-04 13:53:17.008704
294	parcoursup	difference_parcourpro	parcourpro et parcoursup cest pareil ou pas	Non, ParcourPro s’adresse aux jeunes cherchant une formation technique, tandis que Parcoursup est pour les études longues à l’université.	2025-11-04 13:53:17.008704
295	parcoursup	difference_parcourpro	je veux faire un metier manuel je passe par parcoursup ou parcourpro	Si tu veux apprendre un métier manuel ou technique, c’est ParcourPro. Parcoursup est réservé aux formations universitaires.	2025-11-04 13:53:17.008704
296	parcoursup	difference_parcourpro	est ce que parcourpro est lie a parcoursup	Non, ce sont deux plateformes différentes, mais toutes deux sous la tutelle du ministère guinéen de l’enseignement.	2025-11-04 13:53:17.008704
297	parcoursup	difference_parcourpro	peut on passer de parcourpro a parcoursup	Oui, certaines formations professionnelles permettent d’accéder ensuite à des études universitaires via Parcoursup.	2025-11-04 13:53:17.008704
298	parcoursup	difference_parcourpro	est ce que les diplomes parcourpro sont reconnus	Oui, les diplômes professionnels délivrés dans le cadre de ParcourPro sont officiellement reconnus par le Ministère de l’Enseignement Technique.	2025-11-04 13:53:17.008704
299	parcoursup	difference_parcourpro	je veux apprendre la coiffure ou la couture cest ou	Pour des métiers comme la coiffure ou la couture, il faut passer par ParcourPro, pas par Parcoursup.	2025-11-04 13:53:17.008704
300	parcoursup	difference_parcourpro	je veux etre electricien je passe par quoi	Tu dois t’inscrire sur ParcourPro, qui regroupe les centres de formation technique et professionnelle.	2025-11-04 13:53:17.008704
301	parcoursup	difference_parcourpro	je veux faire un bts cest sur parcoursup ou parcourpro	Les BTS sont sur Parcoursup, car ils font partie des formations post-bac reconnues par le Ministère de l’Enseignement Supérieur.	2025-11-04 13:53:17.008704
302	parcoursup	difference_parcourpro	peut on faire un stage avec parcourpro	Oui, la plupart des formations de ParcourPro incluent des stages pratiques en entreprise.	2025-11-04 13:53:17.008704
303	parcoursup	difference_parcourpro	quelle duree font les formations parcourpro	Les formations ParcourPro durent généralement entre 6 mois et 2 ans selon le métier choisi.	2025-11-04 13:53:17.008704
304	parcoursup	difference_parcourpro	je veux etre infirmier cest sur quelle plateforme	Les écoles d’infirmiers et les formations de santé se trouvent sur Parcoursup, pas sur ParcourPro.	2025-11-04 13:53:17.008704
305	parcoursup	difference_parcourpro	je veux me reconvertir cest possible avec parcourpro	Oui, ParcourPro est conçu aussi pour les adultes qui souhaitent se reconvertir dans un nouveau métier.	2025-11-04 13:53:17.008704
306	parcoursup	difference_parcourpro	quelle est la difference entre formation technique et universitaire	La formation technique apprend un métier concret, alors que la formation universitaire développe des connaissances théoriques et académiques.	2025-11-04 13:53:17.008704
307	parcoursup	difference_parcourpro	est ce que parcourpro est gratuit	Certaines formations de ParcourPro sont gratuites, d’autres peuvent demander une petite participation selon le centre.	2025-11-04 13:53:17.008704
308	parcoursup	difference_parcourpro	comment sinscrire sur parcourpro	Tu peux t’inscrire directement sur le site officiel de ParcourPro ou auprès d’un centre de formation agréé.	2025-11-04 13:53:17.008704
309	parcoursup	difference_parcourpro	faut il avoir le bac pour parcourpro	Non, certaines formations ParcourPro sont ouvertes sans le bac, selon le niveau du candidat.	2025-11-04 13:53:17.008704
310	parcoursup	difference_parcourpro	je veux faire des etudes pro apres le bac cest ou	Si tu veux des études professionnalisantes après le bac, tu peux passer par Parcoursup pour un BTS ou un DUT.	2025-11-04 13:53:17.008704
311	parcoursup	difference_parcourpro	je veux travailler vite apres mes etudes cest quoi le mieux	Si tu veux entrer rapidement dans le monde du travail, ParcourPro est le plus adapté.	2025-11-04 13:53:17.008704
312	parcoursup	difference_parcourpro	quelle plateforme est mieux pour les metiers rapides	ParcourPro est la meilleure option pour les métiers rapides et concrets.	2025-11-04 13:53:17.008704
313	parcoursup	difference_parcourpro	quelle plateforme choisir apres le college	Après le collège, tu peux t’orienter vers ParcourPro pour une formation courte et technique.	2025-11-04 13:53:17.008704
314	parcoursup	difference_parcourpro	quelle plateforme choisir apres le bac	Après le bac, Parcoursup est la plateforme officielle pour accéder à l’université ou aux grandes écoles.	2025-11-04 13:53:17.008704
315	parcoursup	difference_parcourpro	est ce que je peux changer de filiere entre parcourpro et parcoursup	Oui, certaines passerelles existent, mais il faut souvent repasser une sélection selon la formation.	2025-11-04 13:53:17.008704
316	parcoursup	difference_parcourpro	cest quoi exactement parcourpro	ParcourPro est la plateforme nationale des formations techniques et professionnelles en Guinée, pour apprendre un métier concret.	2025-11-04 13:53:17.008704
\.


--
-- Name: chatbot_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatbot_user
--

SELECT pg_catalog.setval('public.chatbot_logs_id_seq', 1, false);


--
-- Name: conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatbot_user
--

SELECT pg_catalog.setval('public.conversations_id_seq', 1, false);


--
-- Name: intents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chatbot_user
--

SELECT pg_catalog.setval('public.intents_id_seq', 316, true);


--
-- Name: chatbot_logs chatbot_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: chatbot_user
--

ALTER TABLE ONLY public.chatbot_logs
    ADD CONSTRAINT chatbot_logs_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: chatbot_user
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: intents intents_pkey; Type: CONSTRAINT; Schema: public; Owner: chatbot_user
--

ALTER TABLE ONLY public.intents
    ADD CONSTRAINT intents_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

