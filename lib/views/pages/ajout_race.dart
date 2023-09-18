import 'package:farmges/views/widgets/add_button.dart';
import 'package:farmges/views/widgets/page_layout.dart';
import 'package:flutter/material.dart';

class AjoutRace extends StatelessWidget {
  const AjoutRace({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(
          children: [],
        ),
        title: const Text("Ajout d'une race"));
  }
}

Widget Field(
  String title,
  String subtitle,
) {
  return Row(
    children: [
      Column(children: [ListTile()]),
      addButton("Ajouter", () {})
    ],
  );
}
