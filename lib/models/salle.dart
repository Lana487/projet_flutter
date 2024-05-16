import 'package:cloud_firestore/cloud_firestore.dart';

class Salle {
  final String id;
  final String nom;
  final String description;
  final bool  disponibilite;
  final String qualiteWifi;

  Salle({
    required this.id,
    required this.nom,
    required this.description,
    required this.disponibilite,
    required this.qualiteWifi,
    
  });

  
  factory Salle.fromFireStore(DocumentSnapshot doc){  
  Map <String, dynamic> data= doc.data() as  Map <String, dynamic>; 
  return Salle(id: doc.id, nom:data['nom_salle'], description: data['description'], disponibilite: data['disponibilite'], qualiteWifi: data['qualite_wifi']) ;
  } 

  Map<String,dynamic>toJson(){ 
 return{ 
  "nom_salle": nom, 
  "description": description, 
  "disponibilite":disponibilite, 
   "qualite_wifi": qualiteWifi
    }; 
  }

}
