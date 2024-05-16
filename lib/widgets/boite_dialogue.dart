import 'package:flutter/material.dart';

class BoiteDialogue extends StatelessWidget {
  final String titre;
  final String message;

  BoiteDialogue({required this.titre, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titre),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}