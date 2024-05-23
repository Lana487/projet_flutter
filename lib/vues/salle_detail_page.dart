import 'package:flutter/material.dart';
import 'package:flutter_appchat/services/database.dart';
import 'package:flutter_appchat/widgets/boite_dialogue.dart';
import 'package:flutter_appchat/widgets/liste_com.dart';
import 'package:gap/gap.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/salle.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../widgets/detail_tuile.dart';

class SalleDetailPage extends StatefulWidget {
  final Salle salle;
  final String nomEtage;
  

  const SalleDetailPage({super.key, required this.salle, required this.nomEtage});

  @override
  SalleDetailPageState createState() => SalleDetailPageState();
}

DatabaseService dbs = DatabaseService();

class SalleDetailPageState extends State<SalleDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  int _indiceDispo = 0;
  int _indiceWifi = 0;

  @override
  void initState() {
    super.initState();
    _indiceWifi = widget.salle.qualiteWifi == "Moyenne" ? 1 : (widget.salle.qualiteWifi == "Bonne" ? 2 : 0);
    _indiceDispo = widget.salle.disponibilite ? 1 : 0;
  }

  Future<void> _updateSalleData() async {
    String qualiteWifi;
    if (_indiceWifi == 0) {
      qualiteWifi = "Mauvaise";
    } else if (_indiceWifi == 1) {
      qualiteWifi = "Moyenne";
    } else {
      qualiteWifi = "Bonne";
    }

    bool disponibilite = _indiceDispo == 1;

    try {
      await dbs.updateSalle(widget.salle.id, disponibilite, qualiteWifi);
    } catch (e) {
      print('Error updating salle data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.salle.nom,
              style: const TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Détails sur la salle',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        elevation: 0.7,
        shadowColor: Colors.black,
        centerTitle: true,
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(8.0),
              DetailTuile(
                titre: "Nom de la salle",
                sousTitre: widget.salle.nom,
                icon: Icons.school,
              ),
              const Gap(8.0),
              DetailTuile(
                titre: "Étage",
                sousTitre: widget.nomEtage,
                icon: Icons.stairs,
              ),
              if (widget.salle.description.isNotEmpty) ...[
                const Gap(8.0),
                DetailTuile(
                  titre: "Description",
                  sousTitre: widget.salle.description,
                  icon: Icons.list,
                ),
              ],
              const Gap(8.0),
              DetailTuile(
                titre: "Disponibilité",
                icon: Icons.check,
                select: ToggleSwitch(
                  minWidth: 150.0,
                  minHeight: 35.0,
                  initialLabelIndex: _indiceDispo,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.transparent,
                  inactiveFgColor: Colors.black,
                  totalSwitches: 2,
                  borderWidth: 2.0,
                  borderColor: const [Colors.indigo],
                  activeBgColors: const [
                    [Colors.red],
                    [Colors.green]
                  ],
                  labels: const ['Non Disponible', 'Disponible'],
                  fontSize: 14,
                  onToggle: (index) {
                    setState(() {
                      _indiceDispo = index!;
                    });
                  },
                ),
              ),
              const Gap(8.0),
              DetailTuile(
                titre: "Qualité du WiFi",
                icon: Icons.wifi,
                select: ToggleSwitch(
                  minWidth: 100.0,
                  minHeight: 35.0,
                  initialLabelIndex: _indiceWifi,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.transparent,
                  inactiveFgColor: Colors.black,
                  totalSwitches: 3,
                  borderWidth: 2.0,
                  borderColor: const [Colors.indigo],
                  activeBgColors: const [
                    [Colors.red],
                    [Colors.orange],
                    [Colors.green]
                  ],
                  labels: const ['Mauvaise', 'Moyenne', 'Bonne'],
                  fontSize: 14,
                  onToggle: (index) {
                    setState(() {
                      _indiceWifi = index!;
                    });
                  },
                ),
              ),
              const Gap(16.0),
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Laissez un commentaire...",
                ),
                maxLines: 3,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    dbs.ajoutCommentaire(widget.salle.id, _commentController.text).then(
                          (value) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BoiteDialogue( 
                              titre: "Succès",
                              message: "Votre commentaire a été ajouté!",
                            );
                          },
                        );
                        _commentController.clear();
                      },
                    ).catchError((onError) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return BoiteDialogue(
                            titre: "Erreur",
                            message: "Une erreur s'est produite lors de l'ajout du commentaire.",
                          );
                        },
                      );
                    });
                  }
                },
                child: const Text("Soumettre le commentaire"),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _updateSalleData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Mettre à jour"),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 300,
              child: ListeCommentaires(idClasse: widget.salle.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}