# ============================================
# PROJET 02 : Dashboard de Visualisation
# Fichier  : visualisation.py
# Description : Génère 4 graphiques d'analyse
#               à partir des données de ventes
# ============================================

import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import os

# ---------------------------------
# DONNÉES (simulées directement)
# ---------------------------------

donnees = {
    "mois": [
        "Jan", "Jan", "Jan",
        "Fév", "Fév", "Fév",
        "Mar", "Mar", "Mar",
        "Avr", "Avr", "Avr",
        "Mai", "Mai", "Mai",
    ],
    "produit": [
        "Laptop", "Souris", "Clavier",
        "Laptop", "Écran",  "Souris",
        "Laptop", "Webcam", "Clavier",
        "Écran",  "Souris", "Laptop",
        "Clavier","Webcam", "Souris",
    ],
    "region": [
        "Nord", "Sud",   "Est",
        "Ouest","Nord",  "Sud",
        "Nord", "Est",   "Ouest",
        "Nord", "Sud",   "Est",
        "Ouest","Nord",  "Sud",
    ],
    "quantite": [5, 20, 12, 3, 4, 30, 7, 6, 8, 2, 25, 4, 10, 5, 18],
    "ca":       [
        4499.95, 499.80, 599.88,
        2699.97, 1199.96, 749.70,
        6299.93, 479.94, 399.92,
        599.98,  624.75, 3599.96,
        499.90,  399.95, 449.82
    ],
}

df = pd.DataFrame(donnees)

# ---------------------------------
# CONFIGURATION DU STYLE
# ---------------------------------

COULEURS = ["#2E86AB", "#A23B72", "#F18F01", "#C73E1D", "#3B1F2B"]
plt.rcParams.update({
    "font.family": "DejaVu Sans",
    "axes.spines.top":   False,
    "axes.spines.right": False,
    "axes.grid":         True,
    "grid.alpha":        0.3,
})

fig, axes = plt.subplots(2, 2, figsize=(14, 10))
fig.suptitle("📊 Dashboard des Ventes — T1 2024", fontsize=16, fontweight="bold", y=1.01)
fig.tight_layout(pad=4.0)


# ---------------------------------
# GRAPHIQUE 1 : CA par mois (barres)
# ---------------------------------

ax1 = axes[0, 0]
ca_mois = df.groupby("mois")["ca"].sum().reindex(["Jan", "Fév", "Mar", "Avr", "Mai"])
barres = ax1.bar(ca_mois.index, ca_mois.values, color=COULEURS[0], alpha=0.85, edgecolor="white")

# Ajouter les valeurs sur les barres
for barre in barres:
    hauteur = barre.get_height()
    ax1.text(
        barre.get_x() + barre.get_width() / 2,
        hauteur + 100,
        f"{hauteur:,.0f} €",
        ha="center", va="bottom", fontsize=9
    )

ax1.set_title("CA mensuel (€)", fontweight="bold")
ax1.set_ylabel("Chiffre d'affaires (€)")
ax1.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f"{x:,.0f}"))


# ---------------------------------
# GRAPHIQUE 2 : Ventes par produit (camembert)
# ---------------------------------

ax2 = axes[0, 1]
ventes_produit = df.groupby("produit")["quantite"].sum().sort_values(ascending=False)
wedges, texts, autotexts = ax2.pie(
    ventes_produit.values,
    labels=ventes_produit.index,
    autopct="%1.1f%%",
    colors=COULEURS,
    startangle=90,
    pctdistance=0.80,
)
for text in autotexts:
    text.set_fontsize(9)
ax2.set_title("Répartition des ventes par produit", fontweight="bold")


# ---------------------------------
# GRAPHIQUE 3 : CA par région (barres horizontales)
# ---------------------------------

ax3 = axes[1, 0]
ca_region = df.groupby("region")["ca"].sum().sort_values()
barres_h = ax3.barh(ca_region.index, ca_region.values, color=COULEURS[2], alpha=0.85, edgecolor="white")

for barre in barres_h:
    largeur = barre.get_width()
    ax3.text(
        largeur + 50,
        barre.get_y() + barre.get_height() / 2,
        f"{largeur:,.0f} €",
        va="center", fontsize=9
    )

ax3.set_title("CA par région (€)", fontweight="bold")
ax3.set_xlabel("Chiffre d'affaires (€)")
ax3.xaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f"{x:,.0f}"))


# ---------------------------------
# GRAPHIQUE 4 : Évolution par produit (courbes)
# ---------------------------------

ax4 = axes[1, 1]
top_produits = df.groupby("produit")["ca"].sum().nlargest(3).index  # Les 3 meilleurs
ordre_mois = ["Jan", "Fév", "Mar", "Avr", "Mai"]

for i, produit in enumerate(top_produits):
    sous_df = df[df["produit"] == produit].groupby("mois")["ca"].sum().reindex(ordre_mois).fillna(0)
    ax4.plot(
        ordre_mois,
        sous_df.values,
        marker="o",
        label=produit,
        color=COULEURS[i],
        linewidth=2,
        markersize=6
    )

ax4.set_title("Évolution CA — Top 3 produits", fontweight="bold")
ax4.set_ylabel("CA (€)")
ax4.legend(title="Produit", loc="upper left")
ax4.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f"{x:,.0f}"))


# ---------------------------------
# EXPORT DU GRAPHIQUE
# ---------------------------------

dossier_script = os.path.dirname(os.path.abspath(__file__))
chemin_sortie = os.path.join(dossier_script, "dashboard_ventes.png")

plt.savefig(chemin_sortie, dpi=150, bbox_inches="tight")
print(f"✅ Dashboard exporté : {chemin_sortie}")

plt.show()
