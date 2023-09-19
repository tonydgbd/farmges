import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/controller/stock_controller.dart';
import 'package:farmges/models/population.dart';
import 'package:farmges/views/widgets/page_layout.dart';
import 'package:farmges/views/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class StatistiquePopulation extends StatefulWidget {
  @override
  State<StatistiquePopulation> createState() => _StatisquePopulation();
}

class _StatisquePopulation extends State<StatistiquePopulation> {
  StockController stock = StockController();
  CoreController coreController = CoreController();
  dynamic populations = [];

  _StatisquePopulation() {
    getData();
  }
  getData() async {
    var data = await stock.getPopulations();
    setState(() {
      populations = data;
    });
  }

  String format(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(LayoutBuilder(builder: ((context, constraints) {
      int rowCount = 1;
      if (constraints.maxWidth > 800) {
        rowCount = 2;
      }
      if (constraints.maxWidth > 1000) {
        rowCount = 3;
      }
      if (constraints.maxWidth > 1200) {
        rowCount = 4;
      }
      return GridView.count(crossAxisCount: rowCount, children: [
        for (var element in populations)
          StatCard(children: <Widget>[
            ListTile(
              title: Center(child: Text(element["race"])),
            ),
            ListTile(
              title: Text("Date d'arrivee : ${format(element["date_debut"])}"),
            ),
            ListTile(
                title: Text(
                    "Etape de croissance : ${Population.getStep(element['date_debut']).etape}")),
            ListTile(
              title: Text("Population actuelle: ${element["population"]}"),
            ),
          ])
      ]);
    })), title: const Text("Statistiques sur les population"));
  }
}
