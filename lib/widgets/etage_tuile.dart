import 'package:flutter/material.dart';
import '../models/etage_salle.dart';
import '../vues/choix_salle_page.dart';

class EtageTuile extends StatelessWidget {
  const EtageTuile({
    super.key,
    required this.etage,
  });

  final Etage etage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      // Espacement vertical entre chaque ListTile
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.cyan[100],
        ),
        child: ListTile(
          leading: Image.asset(
            'images/${etage.image}',
            width: 95,
            height: 85,
            fit: BoxFit.fill,
          ),
          title: Text(
            etage.nom,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            // Décalage vers la droite
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: etage.salles
                  .map((salle) => Text(
                        salle.nom,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ))
                  .toList(),
            ),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChoixSallePage(etage: etage),
              ),
            );
          },
        ),
      ),
    );
  }
}
