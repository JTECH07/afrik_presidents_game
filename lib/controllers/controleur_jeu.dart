import 'dart:math';
import '../models/president.dart';
import '../data/donnees_presidents.dart';

class ControleurJeu {
  final int viesInitiales;

  // État du jeu
  President? presidentCible;
  List<President> optionsActuelles = [];
  int score = 0;
  late int vies;
  int tempsRestant = 15;
  
  // Statistiques
  int bonnesReponses = 0;
  int mauvaisesReponses = 0;
  
  // Constructeur
  ControleurJeu({this.viesInitiales = 5}) : vies = viesInitiales {
    preparerNouveauTour();
  }
  
  // Prépare un nouveau tour avec 9 présidents
  void preparerNouveauTour() {
    // Mélanger la liste des présidents
    final melange = List<President>.from(tousLesPresidents)..shuffle();
    
    // Prendre les 9 premiers
    optionsActuelles = melange.take(9).toList();
    
    // Choisir un président cible parmi les 9
    presidentCible = optionsActuelles[Random().nextInt(9)];
  }
  
  // Vérifie si la réponse est correcte
  bool verifierReponse(President presidentChoisi) {
    if (presidentChoisi == presidentCible) {
      // Bonne réponse
      score += 10;
      bonnesReponses++;
      return true;
    } else {
      // Mauvaise réponse
      score = max(0, score - 5); // Pas de score négatif
      vies--;
      mauvaisesReponses++;
      return false;
    }
  }
  
  // Vérifie si la partie est terminée
  bool get estTermine => vies <= 0;
  
  // Réinitialiser le jeu
  void recommencer() {
    score = 0;
    vies = viesInitiales;
    bonnesReponses = 0;
    mauvaisesReponses = 0;
    preparerNouveauTour();
  }
  
  // Obtenir un indice sur le président cible
  String obtenirIndice() {
    if (presidentCible == null) return "Pas de président";
    return "Ce président vient de ${presidentCible!.pays}";
  }
  
  // Obtenir le pourcentage de réussite
  int get pourcentageReussite {
    int total = bonnesReponses + mauvaisesReponses;
    if (total == 0) return 0;
    return (bonnesReponses * 100 / total).round();
  }
}
