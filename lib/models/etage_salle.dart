import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appchat/models/salle.dart';

class Etage {
   String nom;
   List<Salle> salles;

  Etage({required this.nom, required this.salles}); 


factory Etage.fromFireStore(DocumentSnapshot doc){  
  Map <String, dynamic> data= doc.data() as  Map <String, dynamic>; 
  return Etage(nom:data['nom_etage'], salles: []) ; 
  
  }

//   Map<String,dynamic>toJson(){ 
//  return{ 
//   "nom_etage":nom
//     };  
//   }  
}
