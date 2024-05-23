
import 'package:flutter/material.dart';
import 'package:flutter_appchat/models/commentaire.dart';
import 'package:flutter_appchat/services/database.dart';

class ListeCommentaires extends StatefulWidget {
  final String idClasse;
  const ListeCommentaires({super.key,required this.idClasse});

  @override
  State<ListeCommentaires> createState() => _ListeCommentairesState();
}
DatabaseService dbs= DatabaseService();

class _ListeCommentairesState extends State<ListeCommentaires> {
 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Commentaire>>(
          stream: DatabaseService().recuperationCommentaire(widget.idClasse),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Une erreur est survenue"));
            } 
            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Aucun commentaire trouvé"));
         } 
            else { 
              final commentaires = snapshot.data!;
              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Commentaire')),
                       DataColumn(label:  Text('Date')),
                    ],
                    rows: commentaires.map((comment) {
                      return DataRow(cells: [
                        DataCell(Text(comment.contenu)),
                        DataCell(Text(comment.dateCommentaire.toString())),
                      ]);
                    }).toList(),
                  ),
                );

            }
          },
        );
    
  }
} 

