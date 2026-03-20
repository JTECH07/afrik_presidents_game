import 'package:flutter/material.dart';
import '../data/donnees_presidents.dart';
import 'package:afrik_presidents_game/models/president.dart';
import '../widgets/carte_president.dart';

class ApprentissagePage extends StatelessWidget {
  const ApprentissagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Découvrir les Présidents"),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade100, Colors.blue.shade50],
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(8),
          children: tousLesPresidents.map((president) {
            return CartePresident(
              president: president,
              onTap: () {
                _montrerDetailsPresident(context, president);
              },
              afficherDetails: true,
            );
          }).toList(),
        ),
      ),
    );
  }
  
  void _montrerDetailsPresident(BuildContext context, President president) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(president.nom),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green.shade700, width: 3),
                ),
                child: ClipOval(
                  child: Image.asset(
                    president.cheminImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, error, stackTrace) => Container(
                      color: Colors.grey.shade300,
                      child: Icon(Icons.person, size: 80),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _infoRow("Pays", president.pays),
              _infoRow("Période", president.periode),
              SizedBox(height: 8),
              Text(
                "Fait intéressant :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                president.faitInteressant,
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
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
  
  Widget _infoRow(String label, String valeur) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$label : ", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(valeur),
        ],
      ),
    );
  }
}
