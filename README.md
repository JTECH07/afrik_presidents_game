# Présidents d'Afrique - Rapport de projet

Application Flutter éducative pour apprendre et tester ses connaissances sur les présidents africains.

## Membres de l'équipe

- Membre 1: **ALAYE Joseph** - Développement Flutter (UI, logique de jeu)
- Membre 2: **DOHOU Valérie** - Données, tests
- Membre 3: **SAPHOU Latifath** - Design, documentation

## Thème du projet

Le thème choisi est: **Jeu sur les présidents d'Afrique**.

Le jeu permet:
- d'identifier des présidents à partir de leur photo;
- d'apprendre leurs périodes de mandat;
- de découvrir un fait intéressant sur chacun.

## Rapport de travail

### 1) Personnaliser le jeu

Nous avons adapté l'application au thème des présidents africains:
- textes traduits et contextualisés en français;
- couleurs personnalisées (palette orange/jaune/vert selon les écrans);
- ajout d'images de présidents dans les assets;
- messages adaptés au joueur (bravo, erreur, temps écoulé, fin de partie).

### 2) Modifier le fonctionnement du jeu

Nous avons amélioré la logique du jeu au-delà de la version de base:
- score dynamique (`+10` bonne réponse, `-5` mauvaise réponse, score minimum à `0`);
- gestion des vies et du timer par tour;
- écran de fin de partie avec score final, nombre de bonnes réponses et précision;
- bouton **Rejouer**;
- système de **niveaux**:
  - **Facile**: 5 vies, 15 secondes, grille visuelle (images)
  - **Moyen**: 3 vies, 5 secondes, grille visuelle plus rapide
  - **Avancé**: 3 vies, 5 secondes, choix du **nom** à partir d'indices (période + fait intéressant)

### 3) Améliorer l'interface

Nous avons travaillé l'aspect visuel et l'organisation des écrans:
- gradients de fond sur les pages principales;
- hiérarchie visuelle claire (barre de score/vies/temps, zone question, zone réponses);
- cartes présidents retravaillées (image, nom/pays optionnels selon le mode);
- popup de détails en mode apprentissage.

### 4) Observer et corriger des problèmes dans le code

Exemples de corrections réalisées:
- correction d'un conflit de `GestureDetector` empêchant l'ouverture du popup au tap;
- nettoyage de warnings Flutter Analyzer (constructeurs, couleur, paramètres inutiles);
- amélioration de la configuration des widgets pour éviter les comportements ambigus entre écrans.

## Façon de travailler

Nous avons travaillé de manière **itérative**:
1. définition des besoins par écran (accueil, jeu, apprentissage),
2. implémentation par petites tâches,
3. tests réguliers et corrections,
4. revue et amélioration de l'ergonomie.

Cette méthode nous a permis d'ajouter des fonctionnalités sans casser l'existant.

## Difficultés rencontrées

- équilibrer la difficulté du jeu (temps, vies, clarté des indices);
- garder une interface lisible sur différents formats d'écran;
- assurer la cohérence entre plusieurs modes de jeu avec des règles différentes;
- gérer proprement les interactions utilisateur (taps, transitions, dialogues).

## Préoccupations à cette étape du projet

- enrichir encore la base de données (plus de présidents, sources vérifiées, mises à jour);
- améliorer l'accessibilité (tailles de texte, contraste, feedback audio);
- éventuellement intégrer des sons/animations et un système de meilleurs scores.

## Lancer le projet

```bash
flutter pub get
flutter run
```

## État actuel

Le projet est fonctionnel avec plusieurs niveaux et une expérience d'apprentissage + jeu.
Les prochaines étapes portent surtout sur la qualité (tests), l'accessibilité, et l'enrichissement du contenu.
