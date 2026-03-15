# 📈 Projet 02 — Dashboard de Visualisation des Ventes

## 🎯 Objectif
Créer un dashboard de 4 graphiques pour analyser les ventes par mois, par produit et par région.

## 🗂️ Structure du projet

```
02_visualisation_donnees/
├── visualisation.py        # Script principal
├── dashboard_ventes.png    # Graphique généré (après exécution)
└── README.md
```

## 📊 Graphiques générés

| # | Graphique | Type | Données |
|---|-----------|------|---------|
| 1 | CA mensuel | Barres verticales | Chiffre d'affaires par mois |
| 2 | Répartition produits | Camembert | % des ventes par produit |
| 3 | CA par région | Barres horizontales | CA comparé entre régions |
| 4 | Évolution top 3 produits | Courbes | Tendance sur 5 mois |

## 📦 Librairies utilisées

```python
import pandas as pd            # Manipulation des données
import matplotlib.pyplot as plt  # Création des graphiques
import matplotlib.ticker as mticker  # Formatage des axes
```

## ▶️ Comment l'utiliser

```bash
# Installer les dépendances
pip install pandas matplotlib

# Lancer le script
python visualisation.py
```

Le fichier `dashboard_ventes.png` sera généré dans le même dossier.

## 🖼️ Aperçu

> *Le dashboard s'affiche à l'écran et est automatiquement sauvegardé en PNG.*

## 💡 Ce que j'ai appris
- Créer une figure multi-graphiques avec `subplots`
- Utiliser différents types de graphiques (`bar`, `pie`, `plot`)
- Personnaliser les couleurs, polices et marges
- Formater les axes avec des unités (€)
- Annoter les barres avec leurs valeurs
- Exporter un graphique en image PNG
