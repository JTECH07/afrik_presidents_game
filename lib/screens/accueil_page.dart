import 'package:flutter/material.dart';
import 'jeu_page.dart';
import 'apprentissage_page.dart';
import '../models/niveau_jeu.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Présidents d'Afrique"),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.yellow.shade50],
          ),
        ),
        child: Column(
          children: [
            // Image et message de bienvenue
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange.shade700,
                          width: 4,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/mandela.jpg",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.orange.shade100,
                              child: Icon(
                                Icons.public,
                                size: 100,
                                color: Colors.orange.shade700,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Bienvenue sur Présidents d'Afrique !",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Testez vos connaissances sur les chefs d'État africains",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Boutons Jouer et Apprendre
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  _boutonAccueil(
                    context,
                    "Jouer",
                    Icons.play_arrow,
                    Colors.orange.shade700,
                    () {
                      _choisirNiveauEtJouer(context);
                    },
                  ),
                  _boutonAccueil(
                    context,
                    "Apprendre",
                    Icons.school,
                    Colors.green.shade700,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApprentissagePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Boutons À propos et Quitter
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  _boutonAccueil(
                    context,
                    "À propos",
                    Icons.info,
                    Colors.blue.shade700,
                    () {
                      _montrerAPropos(context);
                    },
                  ),
                  _boutonAccueil(
                    context,
                    "Quitter",
                    Icons.exit_to_app,
                    Colors.red.shade700,
                    () {
                      _montrerConfirmationQuitter(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boutonAccueil(
    BuildContext context,
    String texte,
    IconData icone,
    Color couleur,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: couleur.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: couleur, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 40, color: couleur),
              SizedBox(height: 8),
              Text(
                texte,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: couleur,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _montrerAPropos(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("À propos"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Présidents d'Afrique v2.0"),
            SizedBox(height: 8),
            Text("Un jeu éducatif pour découvrir les présidents africains."),
            SizedBox(height: 8),
            Text("Développé avec Flutter et Dart par JVL."),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fermer"),
          ),
        ],
      ),
    );
  }

  void _choisirNiveauEtJouer(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("Choisir un niveau"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _optionNiveau(
              dialogContext,
              context,
              NiveauJeu.facile,
              Colors.green.shade700,
            ),
            SizedBox(height: 8),
            _optionNiveau(
              dialogContext,
              context,
              NiveauJeu.moyen,
              Colors.orange.shade700,
            ),
            SizedBox(height: 8),
            _optionNiveau(
              dialogContext,
              context,
              NiveauJeu.avance,
              Colors.red.shade700,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("Annuler"),
          ),
        ],
      ),
    );
  }

  Widget _optionNiveau(
    BuildContext dialogContext,
    BuildContext context,
    NiveauJeu niveau,
    Color couleur,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(dialogContext);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JeuPage(niveau: niveau)),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: couleur.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: couleur.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              niveau.label,
              style: TextStyle(
                color: couleur,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              niveau.description,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  void _montrerConfirmationQuitter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quitter"),
        content: Text("Voulez-vous vraiment quitter l'application ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Non"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fermer la boîte
              Navigator.pop(context); // Quitter l'app (si possible)
            },
            child: Text("Oui"),
          ),
        ],
      ),
    );
  }
}
