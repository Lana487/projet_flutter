import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appchat/models/salle.dart';

class Etage {
   String nom;
   List<Salle> salles;
   String image;

  Etage({required this.nom, required this.salles, required this.image});


factory Etage.fromFireStore(DocumentSnapshot doc){  
  Map <String, dynamic> data= doc.data() as  Map <String, dynamic>; 
  return Etage(nom:data['nom_etage'], salles: [], image:data['image']) ;
  
  }

//   Map<String,dynamic>toJson(){ 
//  return{ 
//   "nom_etage":nom
//     };  
//   }  
}
