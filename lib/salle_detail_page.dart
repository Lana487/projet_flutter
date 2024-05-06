import 'package:flutter/material.dart';
import 'salle.dart'; 
import 'package:toggle_switch/toggle_switch.dart';

class SalleDetailPage extends StatefulWidget {
  final Salle salle;

  const SalleDetailPage({super.key, required this.salle});

  @override
  SalleDetailPageState createState() => SalleDetailPageState();
}

class SalleDetailPageState extends State<SalleDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int indiceWifi = 0;
    if (widget.salle.qualiteWifi == "Moyenne"){
      indiceWifi = 1;
    }else if (widget.salle.qualiteWifi == "Bonne"){
      indiceWifi = 2;
    }
    int indiceDispo = 0;
    if (widget.salle.disponibilite == "Disponible"){
      indiceDispo = 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              //widget.salle.nom,
              widget.salle.qualiteWifi,
              style: const TextStyle(
                fontSize: 14.0, fontStyle: FontStyle.italic, color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 22.0, color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        elevation: 0.7,
        shadowColor: Colors.black,
        centerTitle: true,
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ici, ajoutez une redirection ou un bouton pour les salles disponibles si nécessaire
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Nom de la salle: ${widget.salle.nom}",
                    style: const TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Étage: ${widget.salle.etage}",
                    style: const TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Description: ${widget.salle.description}",
                    style: const TextStyle(fontSize: 16)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Text("Disponibilité : ",
                        style: TextStyle(fontSize: 16)),
                    ToggleSwitch(
                      minWidth: 110.0,
                      minHeight: 30.0,
                      initialLabelIndex: indiceDispo,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.black,
                      totalSwitches: 2,
                      borderWidth: 2.0,
                      borderColor: const [Colors.blueGrey],
                      activeBgColors: const [
                        [Colors.red],
                        [Colors.green]
                      ],
                      labels: ['Non Disponible','Disponible'],
                      fontSize: 11,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Text("Qualité du WiFi : ",
                        style: TextStyle(fontSize: 16)),
                    ToggleSwitch(
                      minWidth: 72.0,
                      minHeight: 30.0,
                      initialLabelIndex: indiceWifi,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.black,
                      totalSwitches: 3,
                      borderWidth: 2.0,
                      borderColor: const [Colors.blueGrey],
                      activeBgColors: const [
                        [Colors.red],
                        [Colors.orange],
                        [Colors.green]
                      ],
                      labels: ['Mauvaise','Moyenne','Bonne'],
                      fontSize: 11,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Laissez un commentaire...",
                  ),
                  maxLines: 3,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Ajoutez ici la logique pour enregistrer le commentaire
                  // ignore: avoid_print
                  print(
                      "Commentaire: ${_commentController.text}"); // Replace with a logging framework if you have one
                },
                child: const Text("Soumettre le commentaire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
