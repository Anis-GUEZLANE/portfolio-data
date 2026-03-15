# 📊 Projet 01 — Analyse des Ventes E-Commerce

## 🎯 Objectif
Analyser les ventes d'une boutique e-commerce fictive pour produire des rapports utiles à la prise de décision.

## 🗂️ Structure du projet

```
01_analyse_ventes/
├── schema.sql            # Création des tables
├── data_exemple.sql      # Données de test à insérer
├── requetes_analyse.sql  # Requêtes d'analyse
└── README.md
```

## 🧱 Modèle de données

```
categories ──< produits ──< details_commandes >── commandes >── clients
```

| Table | Description |
|-------|-------------|
| `categories` | Types de produits |
| `produits` | Catalogue avec prix |
| `clients` | Base clients |
| `commandes` | Historique des commandes |
| `details_commandes` | Produits par commande |

## 📋 Requêtes incluses

| # | Requête | Concept SQL utilisé |
|---|---------|---------------------|
| 1 | CA mensuel | `GROUP BY`, `strftime`, `SUM` |
| 2 | Top 5 produits | `JOIN`, `ORDER BY`, `LIMIT` |
| 3 | CA par catégorie avec % | Sous-requête, calcul de pourcentage |
| 4 | Meilleurs clients | `JOIN` multiple, `HAVING` |
| 5 | Taux par statut | `GROUP BY`, sous-requête |
| 6 | Panier moyen | `AVG`, `WHERE` avec filtre |

## ▶️ Comment l'utiliser

1. Ouvre un client SQLite (DB Browser, DBeaver, ou ligne de commande)
2. Exécute `schema.sql` pour créer les tables
3. Exécute `data_exemple.sql` pour insérer les données
4. Lance les requêtes de `requetes_analyse.sql`

```bash
# Avec SQLite en ligne de commande
sqlite3 ventes.db < schema.sql
sqlite3 ventes.db < data_exemple.sql
sqlite3 ventes.db < requetes_analyse.sql
```

## 💡 Ce que j'ai appris
- Concevoir un modèle relationnel avec clés étrangères
- Utiliser les `JOIN` pour croiser plusieurs tables
- Calculer des statistiques avec `SUM`, `AVG`, `COUNT`
- Filtrer les groupes avec `HAVING`
- Utiliser des sous-requêtes pour des calculs relatifs (% du total)
