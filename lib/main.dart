import 'package:flutter/material.dart';
import 'models/etage_salle.dart';
import 'vues/choix_salle_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'models/salle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
// Liste d'étages pour l'exemple
final List<Etage> etages = [
  Etage(nom: "Rez-de-chaussée", salles: [Salle(nom: "Foyer", description:"", disponibilite: "disponible", qualiteWifi:"bonne"),  Salle(nom: "Administration IsFoGEP", description:"", disponibilite: "disponible", qualiteWifi: "Bonne")]), 
  Etage(nom: "1er Étage", salles: [Salle(nom: "Salles 100", description:"Salle de cours", disponibilite: "Disponible", qualiteWifi: "Moyenne"), Salle(nom: "Hall d'entrée escaliers", description: "", disponibilite: "Disponible", qualiteWifi: "Moyenne")]), 
  Etage(nom: "2ème Étage", salles: [Salle(nom: "Salles 200", description:" Salle de cours ", disponibilite: "Non Disponible", qualiteWifi: "Mauvaise"), Salle(nom: "Scolarité", description: "", disponibilite: "Disponible", qualiteWifi: "Moyenne"), Salle(nom: "Salles des profs", description: "", disponibilite: "Disponible", qualiteWifi: "Bonne")]),
  Etage(nom: "3ème Étage", salles: [ Salle(nom: "Salles 300", description: "Salle de cours", disponibilite: "Disponible", qualiteWifi: "Moyenne"), Salle(nom: "Administration", description:"", disponibilite: "Disponible", qualiteWifi: "Bonne")]), 
];


class MyApp extends StatelessWidget {
  //pourquoi StatelessWidget et non StatefulWidget ?
  // Parce que cette page n'a pas besoin de changer d'état
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Choix de l'étage 📋",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: const Icon(Icons.home),
          actions: [
            IconButton(onPressed: () => {}, icon: const Icon(Icons.search)),
          ],
          elevation: 7,
          shadowColor: Colors.blueAccent,
        ),
        body: ListView.builder(
          itemCount: etages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Espacement vertical entre chaque ListTile
              child: Container(
                color: Colors.indigo[100],
                child: ListTile(
                  leading: Image.asset(
                    'images/test.png',
                    width: 75,
                    height: 55,
                    fit: BoxFit.fill,
                  ),
                  title: Text(etages[index].nom),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 15.0), // Décalage vers la droite
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: etages[index]
                          .salles
                          .map((salle) => Text(salle.nom)) 
                          .toList(),
                    ),
                  ),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChoixSallePage(etage: etages[index]),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
