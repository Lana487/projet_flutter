import 'package:cloud_firestore/cloud_firestore.dart';

class Commentaire { 
final String id; 
final String contenu;
final DateTime dateCommentaire; 


Commentaire({required this.id,required this.contenu, required this.dateCommentaire}); 


factory Commentaire.fromFireStore(DocumentSnapshot doc){  
  Map <String, dynamic> data= doc.data() as  Map <String, dynamic>; 
  return Commentaire(id:doc.id, contenu:data['contenu'], dateCommentaire: (data['date_commentaire'] as Timestamp).toDate()) ;
}


// an object of type Commentaire to a Json one 
Map<String,dynamic>toJson(String idSalle){ 
 return{ 
  "contenu":contenu, 
  "date_commentaire": Timestamp.fromDate(dateCommentaire), 
  "id_salle" :idSalle 
    }; 
  }


}