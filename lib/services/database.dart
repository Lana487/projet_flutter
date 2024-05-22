import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appchat/models/commentaire.dart';
import 'package:flutter_appchat/models/etage_salle.dart';
import 'package:flutter_appchat/models/salle.dart';

class DatabaseService {
  final CollectionReference salleCollection =
      FirebaseFirestore.instance.collection('Salle');
  final CollectionReference etageCollection =
      FirebaseFirestore.instance.collection('Etage');

  //Récupération de tous les étages
  Stream<List<Etage>> recuperationEtages() async* {
    List<Etage> listEtages = [];
    QuerySnapshot etagesSnapshot =
        await FirebaseFirestore.instance.collection('Etage').get();
    for (var etageDoc in etagesSnapshot.docs) {
      Etage etage = Etage.fromFireStore(etageDoc);
      List<Salle> salles = await recuperationSalles(etageDoc.id);
      etage.salles = salles;
      listEtages.add(etage);
      yield listEtages; // Emets la liste partiellement remplie à chaque itération
    }
  }

  //Récupération des salles rattachées à l'id de l'étage passé en paramètre
  Future<List<Salle>> recuperationSalles(String idEtage) async {
    List<Salle> salles = [];
    QuerySnapshot sallesSnapshot =
        await salleCollection.where('id_etage', isEqualTo: idEtage).get();
    for (var salle in sallesSnapshot.docs) {
      salles.add(Salle.fromFireStore(salle));
    }
    return salles;
  }

  /// *****Commentaires**************
  //Récupération des commentaires fait sur une salle dont l'id est passé en paramètre
  Future<List<Commentaire>> recuperationCommentaire(String idClasse) async {
    List<Commentaire> commentaires = [];
    QuerySnapshot commentaireSnapshot = await FirebaseFirestore.instance
        .collection('Commentaire')
        .where('id_salle', isEqualTo: idClasse)
        .get();
    for (var commentaire in commentaireSnapshot.docs) {
      commentaires.add(Commentaire.fromFireStore(commentaire));
    }
    return commentaires;
  }

  // Ajout des commentaires dans la  base de données
  Future<void> ajoutCommentaire(
      String idSalle, String contenuCommentaire) async {
    try {
      if (idSalle.isNotEmpty) {
        Commentaire com = Commentaire(
            id: "",
            contenu: contenuCommentaire,
            dateCommentaire: DateTime.now());
        Map<String, dynamic> commentaireJson = com.toJson(idSalle);
        CollectionReference commentaireCollection =
            FirebaseFirestore.instance.collection("Commentaire");
        commentaireCollection.add(commentaireJson);
      }
    } catch (e) {
      // handle the error here
    }
  }

  // Mise à jour de la salle
  Future<void> updateSalle(
      String idSalle, bool disponibilite, String qualiteWifi) async {
    try {
      await salleCollection.doc(idSalle).update({
        'disponibilite': disponibilite,
        'qualite_wifi': qualiteWifi,
      });
    } catch (e) {
      // handle the error here
      throw e;
    }
  }
}
