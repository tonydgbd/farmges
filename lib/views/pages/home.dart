import 'package:farmges/views/pages/ajout_depense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../widgets/page_layout.dart';
import '../widgets/stat_card.dart';
import 'ajout_deces.dart';
import 'ajout_poulets.dart';
import 'ajout_vente.dart';

class HomePage extends StatelessWidget {
  final List<Map> actions = [
    {'page': AjoutVente(), 'label': 'Ajouter une vente'},
    {'page': AjoutPoulet(), "label": 'Ajouter des poulets'},
    {"page": AjoutDepense(), "label": "Enregister une depense"},
    {"page": AjoutDeces(), "label": "Enregister un deces"}
  ];

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      ListView(
        children: [
          Center(
            child: Row(
              children: [
                StatCard('Ventes Mensuelles', 100000),
                StatCard('Depenses mensuelles', 50000),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50)),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final action in actions)
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        onPressed: () => Get.to(action['page']),
                        child: Text(action['label'])),
                  ),
              ]),
        ],
      ),
    );
  }
}
