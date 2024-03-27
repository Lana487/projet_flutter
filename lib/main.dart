import 'package:flutter/material.dart';
import 'etage_salle.dart';
import 'choix_salle_page.dart';

// Liste d'étages pour l'exemple
final List<Etage> etages = [
  Etage(nom: "Rez-de-chaussée", salles: ["Foyer", "Administration IsFoGEP"]),
  Etage(nom: "1er étage", salles: ["Salles 100", "Hall d'entrée escaliers"]),
  Etage(nom: "2ème étage", salles: ["Salles 200", "Salles des profs", "Scolarité"]),
  Etage(nom: "3ème étage", salles: ["Salles 300", "Administration"]),
];
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Scaffold(
      appBar: AppBar(
        title: const Text("Choix de l'étage"),
      ),
      body: ListView.builder(
        itemCount: etages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(etages[index].nom),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChoixSallePage(etage: etages[index]),
                ),
              );
            },
          );
        },
      ),
       ),
    );
  }
}
