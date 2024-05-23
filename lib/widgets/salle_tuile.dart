import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/etage_salle.dart';
import '../models/salle.dart';
import '../vues/salle_detail_page.dart';

class SalleTuile extends StatelessWidget {
  const SalleTuile({
    super.key,
    required this.etage,
    required this.index,
  });

  final Etage etage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Salle>>(
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
        if (salles.isEmpty || index >= salles.length) {
          return Container(); // Or any placeholder widget
        }

        Salle salle = salles[index];

        return Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: salle.disponibilite ? Colors.green[200] : Colors.red[200],
            ),
            child: ListTile(
              leading: const Icon(
                Icons.school,
                size: 24.0,
              ),
              title: Text(
                salle.nom,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalleDetailPage(
                      salle: salle,
                      nomEtage: etage.nom,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}