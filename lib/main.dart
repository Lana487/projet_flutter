import 'package:flutter/material.dart';
import 'package:flutter_appchat/services/database.dart';
import 'models/etage_salle.dart';
import 'vues/choix_salle_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

DatabaseService dbs= DatabaseService(); 
final List <Etage> etages=[];


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
        body: FutureBuilder<List<Etage>>( 
          future: dbs.recuperationEtages(),
          builder: (context, snapshot){ 
            if(snapshot.connectionState==ConnectionState.waiting){ 
              return const Center(child: CircularProgressIndicator());
            }
          else if(snapshot.hasError){ 
              return const Center(child: Text("Une erreur est survenue"));
             }
            else{  
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            //print("Données récupérées" + (snapshot.data!.length).toString()); 
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
                  title: Text(snapshot.data![index].nom),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 15.0), // Décalage vers la droite
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: snapshot.data![index] 
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
                            ChoixSallePage(etage: snapshot.data![index]),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
            } 
  }),
    )
    );
  }
}
