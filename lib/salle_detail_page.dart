import 'package:flutter/material.dart';
import 'salle.dart'; // Assurez-vous d'avoir créé le fichier salle.dart

class SalleDetailPage extends StatefulWidget {
  final Salle salle;

  const SalleDetailPage({super.key, required this.salle});

  @override
  SalleDetailPageState createState() => SalleDetailPageState();
}

class SalleDetailPageState extends State<SalleDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  List<bool> isDispo = [true, false];
  List<bool> qualiteWifi = [false, true, false];

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
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 22.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        elevation: 0.7,
        shadowColor: Colors.black,
        centerTitle: true,
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
                    style: const TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Étage: ${widget.salle.etage}",
                    style: const TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Description: ${widget.salle.description}",
                    style: const TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Disponible: ${widget.salle.disponibilite}",
                    style: const TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Text("Qualité du WiFi : ",
                        style: TextStyle(fontSize: 18)),
                    ToggleButtons(
                      isSelected: qualiteWifi,
                      selectedColor: Colors.white,
                      color: Colors.black,
                      fillColor: Colors.green,
                      splashColor: Colors.greenAccent,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      renderBorder: true,
                      borderColor: Colors.black,
                      borderWidth: 1.5,
                      borderRadius: BorderRadius.circular(5),
                      selectedBorderColor: Colors.greenAccent,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(7),
                          child:
                              Text('Mauvaise', style: TextStyle(fontSize: 15)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(7),
                          child:
                              Text('Moyenne', style: TextStyle(fontSize: 15)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(7),
                          child: Text('Bonne', style: TextStyle(fontSize: 15)),
                        ),
                      ],
                      onPressed: (int newIndex) {
                        setState(() {
                          // looping through the list of booleans values
                          for (int index = 0;
                              index < qualiteWifi.length;
                              index++) {
                            qualiteWifi[index] = index == newIndex;
                          }
                        });
                      },
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
