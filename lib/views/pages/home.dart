import 'package:farmges/controller/transactions_controller.dart';
import 'package:farmges/views/pages/ajout_depense.dart';
import 'package:farmges/views/pages/ajout_race.dart';
import 'package:farmges/views/pages/statistiques.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/page_layout.dart';
import '../widgets/stat_card.dart';
import 'ajout_deces.dart';
import 'ajout_poulets.dart';
import 'ajout_vente.dart';

class HomePage extends StatelessWidget {
  final List<Map> actions = [
    {'page': AjoutVente, 'label': 'Ajouter une vente'},
    {'page': AjoutPoulet, "label": 'Ajouter des poulets'},
    {"page": AjoutDepense, "label": "Enregister une depense"},
    {"page": AjoutDeces, "label": "Enregister un deces"},
    {"page": AjoutRace, "label": "Ajouter une race"},
    {"page": StatistiquePopulation, "label": "Stats populations"}
  ];

  final TransactionsController transactions = TransactionsController();

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      ListView(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatCard(children: [
                  const Text('Ventes Mensuelles'),
                  const Text('100000 FCFA')
                ]),
                StatCard(children: [
                  const Text('Depenses mensuelles'),
                  const Text('50000 FCFA')
                ]),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 50)),
          Card(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                for (final action in actions)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                        onPressed: () {
                          var page = action['page'];
                          var pageWidget;
                          switch (page) {
                            case AjoutDeces:
                              pageWidget = AjoutDeces();
                              Get.to(pageWidget);
                              break;
                            case AjoutDepense:
                              pageWidget = AjoutDepense();
                              break;
                            case AjoutPoulet:
                              pageWidget = AjoutPoulet();
                              break;
                            case AjoutVente:
                              pageWidget = AjoutVente();
                              break;
                            case StatistiquePopulation:
                              pageWidget = StatistiquePopulation();
                              break;
                          }
                          Get.to(pageWidget);
                        },
                        child: Text(action['label'])),
                  ),
              ])),
        ],
      ),
    );
  }
}
