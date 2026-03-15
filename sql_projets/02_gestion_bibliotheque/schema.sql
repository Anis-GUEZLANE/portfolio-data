-- ============================================
-- PROJET 02 : Gestion d'une Bibliothèque
-- Fichier  : schema.sql
-- Description : Création de la base de données
-- ============================================

DROP TABLE IF EXISTS emprunts;
DROP TABLE IF EXISTS membres;
DROP TABLE IF EXISTS exemplaires;
DROP TABLE IF EXISTS livres;
DROP TABLE IF EXISTS auteurs;

-- Auteurs
CREATE TABLE auteurs (
    id_auteur   INTEGER PRIMARY KEY,
    nom         VARCHAR(80) NOT NULL,
    prenom      VARCHAR(80),
    nationalite VARCHAR(50)
);

-- Livres
CREATE TABLE livres (
    id_livre    INTEGER PRIMARY KEY,
    titre       VARCHAR(200) NOT NULL,
    id_auteur   INTEGER NOT NULL,
    genre       VARCHAR(50),
    annee_parution INTEGER,
    isbn        VARCHAR(20) UNIQUE,
    FOREIGN KEY (id_auteur) REFERENCES auteurs(id_auteur)
);

-- Exemplaires physiques d'un livre (un livre peut avoir plusieurs exemplaires)
CREATE TABLE exemplaires (
    id_exemplaire INTEGER PRIMARY KEY,
    id_livre      INTEGER NOT NULL,
    etat          VARCHAR(20) DEFAULT 'bon' CHECK (etat IN ('neuf', 'bon', 'usé', 'perdu')),
    disponible    INTEGER DEFAULT 1 CHECK (disponible IN (0, 1)),  -- 1=oui, 0=non
    FOREIGN KEY (id_livre) REFERENCES livres(id_livre)
);

-- Membres de la bibliothèque
CREATE TABLE membres (
    id_membre    INTEGER PRIMARY KEY,
    prenom       VARCHAR(50) NOT NULL,
    nom          VARCHAR(50) NOT NULL,
    email        VARCHAR(100) UNIQUE NOT NULL,
    date_adhesion DATE NOT NULL,
    actif        INTEGER DEFAULT 1 CHECK (actif IN (0, 1))
);

-- Emprunts
CREATE TABLE emprunts (
    id_emprunt     INTEGER PRIMARY KEY,
    id_exemplaire  INTEGER NOT NULL,
    id_membre      INTEGER NOT NULL,
    date_emprunt   DATE NOT NULL,
    date_retour_prevu DATE NOT NULL,
    date_retour_reel  DATE,               -- NULL si pas encore rendu
    FOREIGN KEY (id_exemplaire) REFERENCES exemplaires(id_exemplaire),
    FOREIGN KEY (id_membre)     REFERENCES membres(id_membre)
);
