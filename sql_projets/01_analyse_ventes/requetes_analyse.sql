-- ============================================
-- PROJET 01 : Analyse des Ventes E-Commerce
-- Fichier  : requetes_analyse.sql
-- Description : Requêtes d'analyse et reporting
-- ============================================


-- -----------------------------------------------
-- 1. CHIFFRE D'AFFAIRES TOTAL PAR MOIS
-- -----------------------------------------------
-- Objectif : voir l'évolution mensuelle des ventes (commandes livrées uniquement)

SELECT
    strftime('%Y-%m', date_commande) AS mois,      -- Format AAAA-MM
    COUNT(id_commande)               AS nb_commandes,
    ROUND(SUM(montant_total), 2)     AS ca_total
FROM commandes
WHERE statut = 'livré'
GROUP BY mois
ORDER BY mois;


-- -----------------------------------------------
-- 2. TOP 5 DES PRODUITS LES PLUS VENDUS
-- -----------------------------------------------
-- Objectif : identifier les meilleures ventes par quantité

SELECT
    p.nom_produit,
    c.nom_categorie,
    SUM(dc.quantite)              AS total_vendu,
    ROUND(SUM(dc.sous_total), 2)  AS revenu_total
FROM details_commandes dc
JOIN produits   p ON dc.id_produit  = p.id_produit
JOIN categories c ON p.id_categorie = c.id_categorie
GROUP BY p.id_produit, p.nom_produit, c.nom_categorie
ORDER BY total_vendu DESC
LIMIT 5;


-- -----------------------------------------------
-- 3. CHIFFRE D'AFFAIRES PAR CATÉGORIE
-- -----------------------------------------------
-- Objectif : comparer la performance de chaque catégorie de produits

SELECT
    c.nom_categorie,
    COUNT(DISTINCT dc.id_commande) AS nb_commandes,
    ROUND(SUM(dc.sous_total), 2)   AS ca_categorie,
    ROUND(
        SUM(dc.sous_total) * 100.0 /
        (SELECT SUM(sous_total) FROM details_commandes), 1
    )                              AS part_pct       -- % du CA total
FROM details_commandes dc
JOIN produits   p ON dc.id_produit  = p.id_produit
JOIN categories c ON p.id_categorie = c.id_categorie
GROUP BY c.id_categorie, c.nom_categorie
ORDER BY ca_categorie DESC;


-- -----------------------------------------------
-- 4. CLIENTS LES PLUS DÉPENSIERS
-- -----------------------------------------------
-- Objectif : identifier les meilleurs clients (commandes livrées)

SELECT
    cl.prenom || ' ' || cl.nom     AS client,
    cl.email,
    COUNT(co.id_commande)          AS nb_commandes,
    ROUND(SUM(co.montant_total), 2) AS total_depense,
    ROUND(AVG(co.montant_total), 2) AS panier_moyen
FROM clients cl
JOIN commandes co ON cl.id_client = co.id_client
WHERE co.statut = 'livré'
GROUP BY cl.id_client, cl.prenom, cl.nom, cl.email
HAVING nb_commandes >= 1
ORDER BY total_depense DESC;


-- -----------------------------------------------
-- 5. TAUX DE COMMANDES PAR STATUT
-- -----------------------------------------------
-- Objectif : suivre les statuts des commandes (livré / en cours / annulé)

SELECT
    statut,
    COUNT(*)                       AS nb_commandes,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM commandes), 1
    )                              AS pourcentage
FROM commandes
GROUP BY statut
ORDER BY nb_commandes DESC;


-- -----------------------------------------------
-- 6. PANIER MOYEN PAR CLIENT
-- -----------------------------------------------
-- Objectif : calculer la valeur moyenne d'une commande par client

SELECT
    cl.prenom || ' ' || cl.nom     AS client,
    ROUND(AVG(co.montant_total), 2) AS panier_moyen
FROM clients cl
JOIN commandes co ON cl.id_client = co.id_client
WHERE co.statut != 'annulé'
GROUP BY cl.id_client
ORDER BY panier_moyen DESC;
