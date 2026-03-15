# 🤖 Projet 01 — Automatisation du Nettoyage CSV

## 🎯 Objectif
Automatiser le nettoyage d'un fichier CSV de ventes : détecter les erreurs, corriger les données manquantes, enrichir les colonnes et exporter un fichier propre.

## 🗂️ Structure du projet

```
01_automatisation_csv/
├── nettoyage_csv.py    # Script principal
├── ventes_brut.csv     # Données sources (avec erreurs volontaires)
└── README.md
```

## ⚙️ Ce que fait le script

| Étape | Action |
|-------|--------|
| 1. Chargement | Lit le CSV avec `pandas` |
| 2. Diagnostic | Détecte les valeurs manquantes et doublons |
| 3. Nettoyage | Remplace les manquants, convertit les types, filtre les annulés |
| 4. Enrichissement | Calcule `total_ligne` et extrait le `mois` |
| 5. Résumé | Affiche CA total, CA par région, produits populaires |
| 6. Export | Sauvegarde un nouveau CSV horodaté |

## 📦 Librairies utilisées

```python
import pandas as pd   # Manipulation de données
import os             # Gestion des chemins de fichiers
from datetime import datetime  # Horodatage du fichier de sortie
```

## ▶️ Comment l'utiliser

```bash
# Installer pandas si nécessaire
pip install pandas

# Lancer le script
python nettoyage_csv.py
```

### Résultat attendu dans le terminal :
```
==================================================
  NETTOYAGE AUTOMATIQUE DE FICHIER CSV
==================================================
📂 Fichier chargé : .../ventes_brut.csv
📊 Taille initiale : 25 lignes x 7 colonnes
...
✅ Fichier nettoyé exporté : ventes_propre_20240601_143022.csv
```

## 💡 Ce que j'ai appris
- Charger et inspecter un CSV avec `pandas`
- Détecter et corriger les valeurs manquantes (`fillna`, `isnull`)
- Convertir des types de données (`astype`, `to_datetime`)
- Filtrer des lignes avec des conditions
- Créer de nouvelles colonnes calculées
- Exporter un DataFrame vers un nouveau fichier CSV
