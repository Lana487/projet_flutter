import 'package:flutter/material.dart';
import 'package:flutter_appchat/models/commentaire.dart';
import 'package:flutter_appchat/services/database.dart';
import 'package:intl/intl.dart';

class CommentairesTuile extends StatefulWidget {
  final String idClasse;
  const CommentairesTuile({super.key, required this.idClasse});

  @override
  State<CommentairesTuile> createState() => _CommentairesTuileState();
}

DatabaseService dbs = DatabaseService();

class _CommentairesTuileState extends State<CommentairesTuile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Commentaire>>(
      stream: dbs.recuperationCommentaire(widget.idClasse),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Une erreur est survenue"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Aucun commentaire trouvé"));
        } else {
          final commentaires = snapshot.data!;
          return ListView.builder(
            itemCount: commentaires.length,
            itemBuilder: (context, index) {
              final comment = commentaires[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    comment.contenu,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy, HH:mm').format(comment.dateCommentaire),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}