import 'package:flutter_appchat/salle.dart';

class Etage {
  final String nom;
  final List<Salle> salles;


  Etage({required this.nom, required this.salles});


  /// Fonction pour récupérer l'étage contenant la salle dont le nom est passé en paramètre  
  Salle? chercherSalleParNom(String nomSalle) {
    return salles.firstWhere(
      (salle) => salle.nom == nomSalle  
    );
  } 

}
