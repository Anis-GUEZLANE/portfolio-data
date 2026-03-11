-- ============================================
-- PROJET 02 : Gestion d'une Bibliothèque
-- Fichier  : requetes_gestion.sql
-- Description : CRUD + requêtes de gestion
-- ============================================


-- -----------------------------------------------
-- CRUD — CREATE : Ajouter un nouveau livre
-- -----------------------------------------------

INSERT INTO auteurs (id_auteur, nom, prenom, nationalite)
VALUES (1, 'Hugo', 'Victor', 'Française');

INSERT INTO livres (id_livre, titre, id_auteur, genre, annee_parution, isbn)
VALUES (1, 'Les Misérables', 1, 'Roman', 1862, '978-2070409228');

-- Ajouter 2 exemplaires de ce livre
INSERT INTO exemplaires (id_exemplaire, id_livre, etat, disponible)
VALUES (1, 1, 'bon', 1),
       (2, 1, 'neuf', 1);


-- -----------------------------------------------
-- CRUD — READ : Lire / Rechercher des livres
-- -----------------------------------------------

-- Tous les livres disponibles avec leur auteur
SELECT
    l.titre,
    a.prenom || ' ' || a.nom AS auteur,
    l.genre,
    l.annee_parution,
    COUNT(e.id_exemplaire)   AS exemplaires_disponibles
FROM livres l
JOIN auteurs    a ON l.id_auteur  = a.id_auteur
JOIN exemplaires e ON l.id_livre  = e.id_livre
WHERE e.disponible = 1
GROUP BY l.id_livre
ORDER BY l.titre;


-- -----------------------------------------------
-- CRUD — UPDATE : Enregistrer un emprunt
-- -----------------------------------------------

-- Un membre emprunte un exemplaire
INSERT INTO emprunts (id_emprunt, id_exemplaire, id_membre, date_emprunt, date_retour_prevu)
VALUES (1, 1, 1, '2024-05-01', '2024-05-22');

-- Marquer l'exemplaire comme non disponible
UPDATE exemplaires
SET disponible = 0
WHERE id_exemplaire = 1;


-- -----------------------------------------------
-- CRUD — UPDATE : Enregistrer un retour
-- -----------------------------------------------

-- Mettre à jour la date de retour réel
UPDATE emprunts
SET date_retour_reel = '2024-05-20'
WHERE id_emprunt = 1;

-- Rendre l'exemplaire disponible
UPDATE exemplaires
SET disponible = 1
WHERE id_exemplaire = 1;


-- -----------------------------------------------
-- RAPPORT 1 : Livres en retard
-- -----------------------------------------------
-- Objectif : lister les emprunts non rendus dont la date prévue est dépassée

SELECT
    m.prenom || ' ' || m.nom   AS membre,
    m.email,
    l.titre,
    e.date_retour_prevu,
    CAST(julianday('now') - julianday(e.date_retour_prevu) AS INTEGER) AS jours_retard
FROM emprunts e
JOIN exemplaires ex ON e.id_exemplaire = ex.id_exemplaire
JOIN livres       l ON ex.id_livre     = l.id_livre
JOIN membres      m ON e.id_membre     = m.id_membre
WHERE e.date_retour_reel IS NULL
  AND e.date_retour_prevu < date('now')
ORDER BY jours_retard DESC;


-- -----------------------------------------------
-- RAPPORT 2 : Membres les plus actifs
-- -----------------------------------------------

SELECT
    m.prenom || ' ' || m.nom  AS membre,
    COUNT(e.id_emprunt)       AS total_emprunts,
    SUM(CASE WHEN e.date_retour_reel IS NULL THEN 1 ELSE 0 END) AS en_cours
FROM membres m
LEFT JOIN emprunts e ON m.id_membre = e.id_membre
GROUP BY m.id_membre
ORDER BY total_emprunts DESC;


-- -----------------------------------------------
-- RAPPORT 3 : Livres les plus empruntés
-- -----------------------------------------------

SELECT
    l.titre,
    a.nom                  AS auteur,
    l.genre,
    COUNT(em.id_emprunt)   AS fois_emprunte
FROM livres l
JOIN auteurs     a  ON l.id_auteur    = a.id_auteur
JOIN exemplaires ex ON l.id_livre     = ex.id_livre
LEFT JOIN emprunts em ON ex.id_exemplaire = em.id_exemplaire
GROUP BY l.id_livre
ORDER BY fois_emprunte DESC
LIMIT 10;


-- -----------------------------------------------
-- CRUD — DELETE : Désactiver un membre
-- -----------------------------------------------
-- On ne supprime pas les données historiques, on désactive le compte

UPDATE membres
SET actif = 0
WHERE id_membre = 3;
