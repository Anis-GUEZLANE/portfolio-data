-- ============================================
-- PROJET 01 : Analyse des Ventes E-Commerce
-- Fichier  : schema.sql
-- Description : Création des tables
-- ============================================

-- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS details_commandes;
DROP TABLE IF EXISTS commandes;
DROP TABLE IF EXISTS produits;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS clients;

-- Table des catégories
CREATE TABLE categories (
    id_categorie  INTEGER PRIMARY KEY,
    nom_categorie VARCHAR(50) NOT NULL
);

-- Table des produits
CREATE TABLE produits (
    id_produit    INTEGER PRIMARY KEY,
    nom_produit   VARCHAR(100) NOT NULL,
    id_categorie  INTEGER NOT NULL,
    prix_unitaire DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_categorie) REFERENCES categories(id_categorie)
);

-- Table des clients
CREATE TABLE clients (
    id_client   INTEGER PRIMARY KEY,
    prenom      VARCHAR(50) NOT NULL,
    nom         VARCHAR(50) NOT NULL,
    email       VARCHAR(100) UNIQUE NOT NULL,
    date_inscription DATE NOT NULL
);

-- Table des commandes
CREATE TABLE commandes (
    id_commande   INTEGER PRIMARY KEY,
    id_client     INTEGER NOT NULL,
    date_commande DATE NOT NULL,
    montant_total DECIMAL(10, 2) NOT NULL,
    statut        VARCHAR(20) CHECK (statut IN ('livré', 'en cours', 'annulé')),
    FOREIGN KEY (id_client) REFERENCES clients(id_client)
);

-- Table de liaison : détails des commandes
CREATE TABLE details_commandes (
    id_detail   INTEGER PRIMARY KEY,
    id_commande INTEGER NOT NULL,
    id_produit  INTEGER NOT NULL,
    quantite    INTEGER NOT NULL CHECK (quantite > 0),
    sous_total  DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commande),
    FOREIGN KEY (id_produit)  REFERENCES produits(id_produit)
);
