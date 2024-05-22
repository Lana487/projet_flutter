import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailTuile extends StatelessWidget {
  const DetailTuile({
    super.key,
    required this.titre,
    this.sousTitre,
    required this.icon,
    this.select,
  });

  final String titre;
  final String? sousTitre;
  final Widget? select;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const Gap(16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titre,
              style: const TextStyle(fontSize: 20),
            ),
            if (sousTitre != null)
              Text(
                sousTitre!,
                style: const TextStyle(fontSize: 16),
              ),
            if (select != null) select!,
          ],
        ),
      ],
    );
  }
}