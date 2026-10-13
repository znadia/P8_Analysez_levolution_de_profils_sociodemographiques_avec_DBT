# P8 Analysez l'évolution du profil sociodémographique des étudiants Data d'OpenClassrooms

## Contexte

OpenClassrooms souhaite mieux comprendre l'évolution du profil de ses étudiants inscrits aux parcours Data sur 4 ans (âge, genre, région).
L'objectif est d'alimenter les réflexions de l'entreprise sur l'accessibilité et l'égalité des chances.
J'ai construit un pipeline de transformation avec dbt et Snowflake, puis j'ai enrichi les données internes avec des données publiques de l'INSEE.

## Objectifs

- Vérifier la qualité des données et leur conformité au RGPD
- Construire un pipeline de transformation fiable, documenté et reproductible
- Comparer le profil des étudiants avec la population française
- Présenter les résultats à un public non technique

## Réalisations

- Import des données internes et des données INSEE dans Snowflake
- Déclaration et documentation des sources dans dbt
- Modèles dbt pour nettoyer, transformer et agréger les données
- Tests dbt sur chaque modèle (valeurs non nulles, tranches d'âge et genres autorisés) et test personnalisé contre les doublons
- Vérification du respect du RGPD
- Export du jeu de données final au format CSV
- Présentation des indicateurs, de la méthode et des enseignements

## Outils

Snowflake, dbt, SQL, Powerbi(graphique)

## Compétences

- Construire un pipeline de données avec dbt
- Écrire des transformations SQL dans un entrepôt de données
- Mettre en place des tests de qualité des données
- Documenter un projet pour le rendre reproductible
- Appliquer les principes du RGPD

## Fichiers

- `dbt/` projet dbt complet
  - `dbt_project.yml` configuration du projet
  - `models/sources/` déclaration et documentation des sources (données internes et INSEE)
  - `models/staging/` nettoyage et mise en forme des données
  - `models/intermediate/` harmonisation et pré-agrégation des données
  - `models/mart/` tables finales prêtes pour l'analyse
  - `tests/` test personnalisé qui vérifie l'absence de doublons par étudiant et par année
- `workflow.pdf` schéma du pipeline dbt, de la source aux tables finales
- `donnees_finales.csv` jeu de données final nettoyé
