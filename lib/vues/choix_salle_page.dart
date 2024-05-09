import 'package:flutter/material.dart';
import 'package:flutter_appchat/models/salle.dart';
import '../models/etage_salle.dart';
import 'salle_detail_page.dart';

class ChoixSallePage extends StatelessWidget {
  final Etage etage;

  const ChoixSallePage({super.key, required this.etage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            //title: Text("Choix de la salle 🧑‍🏫 - ${etage.nom}"),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  etage.nom,
                  style: const TextStyle(
                      fontSize: 14.0, fontStyle: FontStyle.italic, color: Colors.white,),
                ),
                const Text(
                  'Choix de la salle 🧑‍🏫',
                  style: TextStyle(
                    fontSize: 22.0, color: Colors.white,
                  ),
                ),
              ],
            ),
            elevation: 0.7,
            shadowColor: Colors.black,
            backgroundColor: Colors.indigo,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
      body: ListView.builder(
        itemCount: etage.salles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("• ${etage.salles[index].nom}",
                style: const TextStyle(fontSize: 22, color: Colors.green)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SalleDetailPage(
                          salle: Salle(
                            nom: etage.salles[index].nom,
                            description: etage.salles[index].description,
                            disponibilite: etage.salles[index].disponibilite,
                            qualiteWifi:etage.salles[index].qualiteWifi,
                          ),
                          nomEtage: etage.nom,
                        )),
              );
            },
          );
        },
      ),
    );
  }
}
