import 'package:flutter/material.dart';
import 'etage_salle.dart';
import 'choix_salle_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
// Liste d'étages pour l'exemple
final List<Etage> etages = [
  Etage(nom: "Rez-de-chaussée", salles: ["Foyer", "Administration IsFoGEP"]),
  Etage(nom: "1er Étage", salles: ["Salles 100", "Hall d'entrée escaliers"]),
  Etage(
      nom: "2ème Étage",
      salles: ["Salles 200", "Salles des profs", "Scolarité"]),
  Etage(nom: "3ème Étage", salles: ["Salles 300", "Administration"]),
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
                          .map((salle) => Text(salle))
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
