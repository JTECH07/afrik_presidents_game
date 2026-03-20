import 'package:flutter/material.dart';
import 'screens/accueil_page.dart';

void main() {
  runApp(const MonApp());
}

class MonApp extends StatelessWidget {
  const MonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Présidents d'Afrique",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AccueilPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
