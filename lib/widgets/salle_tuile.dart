import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: etage.salles[index].disponibilite
              ? Colors.green[200]
              : Colors.red[200],
        ),
        child: ListTile(
          leading: const Icon(
            Icons.school,
            size: 24.0,
          ),
          title: Text(
            etage.salles[index].nom,
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
                  salle: Salle(
                    id: etage.salles[index].id,
                    nom: etage.salles[index].nom,
                    description: etage.salles[index].description,
                    disponibilite: etage.salles[index].disponibilite,
                    qualiteWifi: etage.salles[index].qualiteWifi,
                  ),
                  nomEtage: etage.nom,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
