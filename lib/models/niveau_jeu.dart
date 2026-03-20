enum NiveauJeu { facile, moyen, avance }

extension NiveauJeuX on NiveauJeu {
  String get label {
    switch (this) {
      case NiveauJeu.facile:
        return "Facile";
      case NiveauJeu.moyen:
        return "Moyen";
      case NiveauJeu.avance:
        return "Avancé";
    }
  }

  String get description {
    switch (this) {
      case NiveauJeu.facile:
        return "Mode classique, 5 vies et 15 secondes par tour.";
      case NiveauJeu.moyen:
        return "3 vies, 5 secondes par tour, grille visuelle rapide.";
      case NiveauJeu.avance:
        return "3 vies, 5 secondes, trouvez le nom via les indices.";
    }
  }

  int get viesInitiales {
    switch (this) {
      case NiveauJeu.facile:
        return 5;
      case NiveauJeu.moyen:
      case NiveauJeu.avance:
        return 3;
    }
  }

  int get tempsParTour {
    switch (this) {
      case NiveauJeu.facile:
        return 15;
      case NiveauJeu.moyen:
      case NiveauJeu.avance:
        return 5;
    }
  }

  bool get modeAvance => this == NiveauJeu.avance;
}
