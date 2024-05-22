import 'package:flutter/material.dart';
import 'package:flutter_appchat/services/database.dart';
import '../models/etage_salle.dart';
import '../widgets/etage_tuile.dart';

//DatabaseService dbs= DatabaseService();
//final List <Etage> etages=[];

class Menu extends StatelessWidget {
  const Menu({super.key});

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
          //actions: [
            //IconButton(
              //onPressed: () => {},
              //icon: const Icon(Icons.search),
            //),
          //],
          elevation: 7,
          shadowColor: Colors.blueAccent,
        ),
        body: StreamBuilder<List<Etage>>(
          stream: DatabaseService().recuperationEtages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Une erreur est survenue"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return EtageTuile(
                    etage: snapshot.data![index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
