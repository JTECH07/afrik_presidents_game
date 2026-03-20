import 'dart:async';
import 'package:flutter/material.dart';
import '../controllers/controleur_jeu.dart';
import '../widgets/carte_president.dart';
import '../models/president.dart';
import '../models/niveau_jeu.dart';

class JeuPage extends StatefulWidget {
  final NiveauJeu niveau;

  const JeuPage({required this.niveau, super.key});

  @override
  State<JeuPage> createState() => _JeuPageState();
}

class _JeuPageState extends State<JeuPage> {
  late final ControleurJeu _controleur;
  Timer? _timer;
  String _message = "";
  Color _couleurMessage = Colors.transparent;
  int get _tempsParTour => widget.niveau.tempsParTour;

  @override
  void initState() {
    super.initState();
    _controleur = ControleurJeu(viesInitiales: widget.niveau.viesInitiales);
    _demarrerTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _demarrerTimer() {
    _timer?.cancel();
    _controleur.tempsRestant = _tempsParTour;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_controleur.tempsRestant > 0) {
          _controleur.tempsRestant--;
        } else {
          // Temps écoulé = perte d'une vie
          _controleur.vies--;
          _afficherMessage("Temps écoulé !", Colors.red);

          if (_controleur.estTermine) {
            timer.cancel();
            _montrerFinDePartie();
          } else {
            _controleur.preparerNouveauTour();
            _controleur.tempsRestant = _tempsParTour;
          }
        }
      });
    });
  }

  void _afficherMessage(String message, Color couleur) {
    setState(() {
      _message = message;
      _couleurMessage = couleur;
    });

    // Effacer le message après 1.5 secondes
    Future.delayed(Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _message = "";
          _couleurMessage = Colors.transparent;
        });
      }
    });
  }

  void _montrerFinDePartie() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Partie terminée !"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Score final: ${_controleur.score}"),
            Text("Bonnes réponses: ${_controleur.bonnesReponses}"),
            Text("Précision: ${_controleur.pourcentageReussite}%"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _controleur.recommencer();
                _demarrerTimer();
              });
              Navigator.pop(context);
            },
            child: Text("Rejouer"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fermer la boîte
              Navigator.pop(context); // Retour à l'accueil
            },
            child: Text("Accueil"),
          ),
        ],
      ),
    );
  }

  void _gererClic(President presidentChoisi) {
    if (_controleur.estTermine) return;

    bool correct = _controleur.verifierReponse(presidentChoisi);

    if (correct) {
      _afficherMessage("Bravo ! +10 points", Colors.green);
    } else {
      _afficherMessage("Dommage ! -5 points", Colors.red);
    }

    setState(() {
      if (_controleur.estTermine) {
        _timer?.cancel();
        _montrerFinDePartie();
      } else {
        _controleur.preparerNouveauTour();
        _controleur.tempsRestant = _tempsParTour;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jeu - ${widget.niveau.label}"),
        backgroundColor: Colors.orange.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade100, Colors.yellow.shade50],
          ),
        ),
        child: Column(
          children: [
            // En-tête avec score, vies, temps
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.orange.shade800,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _enTeteItem(Icons.star, "Score", "${_controleur.score}"),
                  _enTeteItem(Icons.favorite, "Vies", "${_controleur.vies}"),
                  _enTeteItem(
                    Icons.timer,
                    "Temps",
                    "${_controleur.tempsRestant}s",
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: Colors.orange.shade100,
              child: Text(
                "Niveau ${widget.niveau.label} - ${widget.niveau.description}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.orange.shade900,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Message de feedback
            if (_message.isNotEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                color: _couleurMessage.withValues(alpha: 0.3),
                child: Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _couleurMessage == Colors.green
                        ? Colors.green.shade900
                        : Colors.red.shade900,
                  ),
                ),
              ),

            _questionWidget(),

            Expanded(
              child: widget.niveau.modeAvance
                  ? _listeChoixNoms()
                  : _grilleImagesPresidents(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionWidget() {
    final presidentCible = _controleur.presidentCible;

    if (presidentCible == null) {
      return Padding(padding: EdgeInsets.all(16), child: Text("Chargement..."));
    }

    if (!widget.niveau.modeAvance) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Trouvez :",
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            Text(
              presidentCible.nom,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
            Text(
              presidentCible.pays,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        children: [
          Text(
            "Qui est ce président ?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            height: 95,
            width: 95,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange.shade700, width: 3),
            ),
            child: ClipOval(
              child: Image.asset(
                presidentCible.cheminImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey.shade600,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Période: ${presidentCible.periode}",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            presidentCible.faitInteressant,
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _grilleImagesPresidents() {
    return GridView.count(
      crossAxisCount: 3,
      padding: EdgeInsets.all(8),
      children: _controleur.optionsActuelles.map((president) {
        return CartePresident(
          president: president,
          afficherDetails: false,
          afficherIdentite: false,
          onTap: () => _gererClic(president),
        );
      }).toList(),
    );
  }

  Widget _listeChoixNoms() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(12),
      childAspectRatio: 2.3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: _controleur.optionsActuelles.map((president) {
        return ElevatedButton(
          onPressed: () => _gererClic(president),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.orange.shade900,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.orange.shade200),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  president.nom,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _enTeteItem(IconData icone, String label, String valeur) {
    return Column(
      children: [
        Icon(icone, color: Colors.white),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
        Text(
          valeur,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
