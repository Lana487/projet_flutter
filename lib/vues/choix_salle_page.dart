import 'package:flutter/material.dart';
import '../models/etage_salle.dart';
import '../models/salle.dart';
import '../services/database.dart';
import '../widgets/salle_tuile.dart';

class ChoixSallePage extends StatelessWidget {
  final Etage etage;

  const ChoixSallePage({super.key, required this.etage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              etage.nom,
              style: const TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            const Text(
              'Choix de la salle 🧑‍🏫',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        elevation: 0.7,
        shadowColor: Colors.black,
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<Salle>>(
        stream: DatabaseService().recuperationSalles(etage.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Une erreur est survenue"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,//etage.salles?.length,
              itemBuilder: (context, index) {
                return SalleTuile(
                  etage: etage,
                  index: index,
                );
              },
            );
          }
        },
      ),
    );
  }
}
