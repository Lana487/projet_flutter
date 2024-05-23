import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/etage_salle.dart';
import '../models/salle.dart';
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
            child: StreamBuilder<List<Salle>>(
              stream: FirebaseFirestore.instance
                  .collection('Salle')
                  .where('id_etage', isEqualTo: etage.id)
                  .snapshots()
                  .map((snapshot) => snapshot.docs
                  .map((doc) => Salle.fromFireStore(doc))
                  .toList()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Salle> salles = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: salles.map((salle) => Text(
                    salle.nom,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )).toList(),
                );
              },
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
