import 'package:flutter/material.dart';
import '../models/president.dart';

class CartePresident extends StatelessWidget {
  final President president;
  final VoidCallback onTap;
  final bool afficherDetails; // Pour le mode apprentissage
  final bool afficherIdentite; // Nom + pays

  const CartePresident({
    required this.president,
    required this.onTap,
    this.afficherDetails = false,
    this.afficherIdentite = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(4),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.amber.shade50, Colors.orange.shade50],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image (avec gestion d'erreur si l'image n'existe pas)
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange.shade300, width: 2),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      president.cheminImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              if (afficherIdentite) ...[
                // Nom
                Text(
                  president.nom,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // Pays
                Text(
                  president.pays,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                ),
              ],

              // Détails supplémentaires (pour mode apprentissage)
              if (afficherDetails) ...[
                Divider(height: 8),
                Text(
                  president.periode,
                  style: TextStyle(fontSize: 9, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 2),
                Text(
                  president.faitInteressant,
                  style: TextStyle(fontSize: 8),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
