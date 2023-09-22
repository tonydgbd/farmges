import 'package:farmges/controller/transactions_controller.dart';
import 'package:farmges/views/pages/ajout_depense.dart';
import 'package:farmges/views/pages/historiques.dart';
import 'package:farmges/views/pages/statistiques.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/page_layout.dart';
import '../widgets/stat_card.dart';
import 'ajout_deces.dart';
import 'ajout_poulets.dart';
import 'ajout_vente.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> actions = [
    {'page': AjoutVente, 'label': 'Ajouter une vente'},
    {'page': AjoutPoulet, "label": 'Ajouter des poulets'},
    {"page": AjoutDepense, "label": "Enregister une depense"},
    {"page": AjoutDeces, "label": "Enregister un deces"},
    {"page": StatistiquePopulation, "label": "Stats populations"},
    {"page": Historiques, "label": "Historiques"}
  ];

  final TransactionsController transactions = TransactionsController();
  double depenseDuMois = 0;
  double venteDuMois = 0;

  _HomePageState() {
    fetchData();
  }

  fetchData() async {
    transactions.getDepenseMensuelle().then((value) => setState(() {
          depenseDuMois = value;
        }));
    transactions.getVenteMensuelle().then((value) => setState(() {
          venteDuMois = value;
        }));
  }

  final months = [
    {"label": "janvier", "value": 1},
    {"label": "fevrier", "value": 2},
    {"label": "mars", "value": 3},
    {"label": "avril", "value": 4},
    {"label": "mais", "value": 5},
    {"label": "juin", "value": 6},
    {"label": "juillet", "value": 7},
    {"label": "août", "value": 8},
    {"label": "septembre", "value": 9},
    {"label": "octobre", "value": 10},
    {"label": "nomvembre", "value": 11},
    {"label": "decembre", "value": 12},
  ];

  TextEditingController controller = TextEditingController();
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
                  // SelectField(controller, months, 'mois', largeWidth: false),
                  const Text(
                    'Ventes Mensuelles',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${venteDuMois.toString()} FCFA',
                    style: const TextStyle(fontSize: 18),
                  )
                ]),
                StatCard(children: [
                  // uSelectField(controller, months, 'mois', largeWidth: false),
                  const Text(
                    'Depenses mensuelles',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${depenseDuMois.toString()} FCFA',
                    style: const TextStyle(fontSize: 18),
                  )
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
                            case Historiques:
                              pageWidget = Historiques();
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
