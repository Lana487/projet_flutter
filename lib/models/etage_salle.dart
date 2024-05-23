import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appchat/models/salle.dart';
import 'package:flutter_appchat/services/database.dart';

class Etage {
  String nom;
  Stream<List<Salle>> salles;
  String image;
  String id;

  Etage({
    required this.nom,
    required this.salles,
    required this.image,
    required this.id,
  });

  factory Etage.fromFireStore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Etage(
      nom: data['nom_etage'],
      salles: DatabaseService().recuperationSalles(doc.id),
      image: data['image'],
      id : data['id_etage'],
    );
  }
}
