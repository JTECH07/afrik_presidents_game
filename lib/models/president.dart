// Modèle pour représenter un président
class President {
  final String nom;
  final String pays;
  final String cheminImage;
  final String periode;  // Exemple: "2010 - présent"
  final String faitInteressant;

  President({
    required this.nom,
    required this.pays,
    required this.cheminImage,
    required this.periode,
    required this.faitInteressant,
  });
}