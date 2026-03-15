# ============================================
# PROJET 01 : Automatisation du Nettoyage CSV
# Fichier  : nettoyage_csv.py
# Description : Nettoie et traite automatiquement
#               un fichier CSV de ventes
# ============================================

import pandas as pd
import os
from datetime import datetime

# ---------------------------------
# 1. CHARGEMENT DU FICHIER
# ---------------------------------

# Chemin du fichier source (dans le même dossier que ce script)
dossier_script = os.path.dirname(os.path.abspath(__file__))
fichier_entree = os.path.join(dossier_script, "ventes_brut.csv")

print("=" * 50)
print("  NETTOYAGE AUTOMATIQUE DE FICHIER CSV")
print("=" * 50)

# Chargement avec pandas
df = pd.read_csv(fichier_entree)

print(f"\n📂 Fichier chargé : {fichier_entree}")
print(f"📊 Taille initiale : {len(df)} lignes x {len(df.columns)} colonnes")
print(f"\n🔍 Aperçu des données brutes :")
print(df.head())


# ---------------------------------
# 2. DIAGNOSTIC DES PROBLÈMES
# ---------------------------------

print("\n" + "-" * 40)
print("DIAGNOSTIC")
print("-" * 40)

# Valeurs manquantes par colonne
valeurs_manquantes = df.isnull().sum()
print(f"\n⚠️  Valeurs manquantes :")
print(valeurs_manquantes[valeurs_manquantes > 0])

# Doublons éventuels
nb_doublons = df.duplicated().sum()
print(f"\n🔁 Doublons détectés : {nb_doublons}")


# ---------------------------------
# 3. NETTOYAGE DES DONNÉES
# ---------------------------------

print("\n" + "-" * 40)
print("NETTOYAGE")
print("-" * 40)

df_propre = df.copy()

# --- Lignes avec vendeur manquant : remplacer par "Inconnu"
nb_vendeurs_manquants = df_propre["vendeur"].isnull().sum()
df_propre["vendeur"] = df_propre["vendeur"].fillna("Inconnu")
print(f"✅ Vendeurs manquants remplacés : {nb_vendeurs_manquants}")

# --- Quantité manquante : remplacer par la médiane de la colonne
mediane_qte = df_propre["quantite"].median()
nb_qte_manquants = df_propre["quantite"].isnull().sum()
df_propre["quantite"] = df_propre["quantite"].fillna(mediane_qte)
print(f"✅ Quantités manquantes remplacées par la médiane ({mediane_qte}): {nb_qte_manquants}")

# --- Conversion des types
df_propre["date"]          = pd.to_datetime(df_propre["date"])
df_propre["quantite"]      = df_propre["quantite"].astype(int)
df_propre["prix_unitaire"] = df_propre["prix_unitaire"].astype(float)
print(f"✅ Types de colonnes convertis (date, quantite, prix)")

# --- Suppression des commandes annulées
nb_annulees = len(df_propre[df_propre["statut"] == "annulé"])
df_propre = df_propre[df_propre["statut"] != "annulé"]
print(f"✅ Commandes annulées supprimées : {nb_annulees}")

# --- Ajout d'une colonne "total_ligne"
df_propre["total_ligne"] = df_propre["quantite"] * df_propre["prix_unitaire"]
print(f"✅ Colonne 'total_ligne' calculée (quantite × prix_unitaire)")

# --- Ajout d'une colonne "mois"
df_propre["mois"] = df_propre["date"].dt.to_period("M").astype(str)
print(f"✅ Colonne 'mois' extraite depuis la date")

print(f"\n📊 Taille après nettoyage : {len(df_propre)} lignes")


# ---------------------------------
# 4. RÉSUMÉ STATISTIQUE
# ---------------------------------

print("\n" + "-" * 40)
print("RÉSUMÉ STATISTIQUE")
print("-" * 40)

ca_total = df_propre["total_ligne"].sum()
ca_par_region = df_propre.groupby("region")["total_ligne"].sum().sort_values(ascending=False)
ventes_par_produit = df_propre.groupby("produit")["quantite"].sum().sort_values(ascending=False)

print(f"\n💰 Chiffre d'affaires total : {ca_total:,.2f} €")

print(f"\n🗺️  CA par région :")
for region, ca in ca_par_region.items():
    print(f"   {region:<10} : {ca:>10,.2f} €")

print(f"\n📦 Produits les plus vendus (quantité) :")
for produit, qte in ventes_par_produit.items():
    print(f"   {produit:<12} : {qte} unités")


# ---------------------------------
# 5. EXPORT DU FICHIER NETTOYÉ
# ---------------------------------

horodatage = datetime.now().strftime("%Y%m%d_%H%M%S")
fichier_sortie = os.path.join(dossier_script, f"ventes_propre_{horodatage}.csv")
df_propre.to_csv(fichier_sortie, index=False, encoding="utf-8-sig")

print(f"\n" + "=" * 50)
print(f"✅ Fichier nettoyé exporté :")
print(f"   {fichier_sortie}")
print("=" * 50)
