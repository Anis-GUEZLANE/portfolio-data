# 📚 Projet 02 — Gestion d'une Bibliothèque Municipale

## 🎯 Objectif
Concevoir et gérer une base de données complète pour une bibliothèque : gestion des livres, des membres et des emprunts.

## 🗂️ Structure du projet

```
02_gestion_bibliotheque/
├── schema.sql           # Création des tables
├── requetes_gestion.sql # CRUD + rapports
└── README.md
```

## 🧱 Modèle de données

```
auteurs ──< livres ──< exemplaires ──< emprunts >── membres
```

| Table | Description |
|-------|-------------|
| `auteurs` | Auteurs des livres |
| `livres` | Catalogue général |
| `exemplaires` | Copies physiques (état, disponibilité) |
| `membres` | Adhérents de la bibliothèque |
| `emprunts` | Historique des prêts |

## 📋 Opérations couvertes

| Catégorie | Opération | Description |
|-----------|-----------|-------------|
| **CREATE** | Ajout livre/auteur | Intégrer de nouveaux ouvrages |
| **READ**   | Recherche disponibilité | Livres disponibles avec auteur |
| **UPDATE** | Emprunt / Retour | Gérer le cycle de prêt |
| **UPDATE** | Désactivation membre | Soft delete (pas de suppression) |
| **REPORT** | Livres en retard | Avec calcul du nombre de jours |
| **REPORT** | Membres actifs | Nombre d'emprunts par personne |
| **REPORT** | Livres populaires | Top 10 des plus empruntés |

## 💡 Concepts clés démontrés

- **Modélisation relationnelle** : séparation logique des entités
- **Contraintes** : `CHECK`, `UNIQUE`, `NOT NULL`, `FOREIGN KEY`
- **Soft delete** : désactiver plutôt que supprimer (colonne `actif`)
- **Calcul de dates** : `julianday()` pour les retards
- **LEFT JOIN** : inclure les membres sans emprunts dans les stats
- **CASE WHEN** : logique conditionnelle dans une requête

## ▶️ Comment l'utiliser

```bash
sqlite3 bibliotheque.db < schema.sql
sqlite3 bibliotheque.db < requetes_gestion.sql
```
