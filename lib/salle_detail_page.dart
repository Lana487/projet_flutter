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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de la salle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ici, ajoutez une redirection ou un bouton pour les salles disponibles si nécessaire
            Text("Nom de la salle: ${widget.salle.nom}", style: const TextStyle(fontSize: 18)),
            Text("Étage: ${widget.salle.etage}", style: const TextStyle(fontSize: 18)),
            Text("Description: ${widget.salle.description}", style: const TextStyle(fontSize: 18)),
            Text("Disponibilité: ${widget.salle.disponibilite}", style: const TextStyle(fontSize: 18)),
            Text("Qualité du WiFi: ${widget.salle.qualiteWifi}", style: const TextStyle(fontSize: 18)),
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
                print("Commentaire: ${_commentController.text}"); // Replace with a logging framework if you have one
              },
              child: const Text("Soumettre le commentaire"),
            ),
          ],
        ),
      ),
    );
  }
}
