import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/controller/stock_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPopulation extends StatelessWidget {
  AddPopulation({super.key});
  StockController stockController = StockController();
  TextEditingController raceController = TextEditingController();
  TextEditingController nbrController = TextEditingController();
  DateTime selected_date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownMenu(
              width: Get.width * 0.5,
              controller: raceController,
              label: const Text("Choisir la race"),
              dropdownMenuEntries: [
                ...(CoreController.instance.data['races'] as List).map((e) =>
                    DropdownMenuEntry(
                        value: e['nom_de_race'], label: e['nom_de_race']))
              ]),
          TextField(
            controller: nbrController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                labelText: "Nombre de poulet", border: OutlineInputBorder()),
          ),
          const Text("Selectioner la date du Jour 0"),
          DatePickerDialog(
              currentDate: selected_date,
              initialEntryMode: DatePickerEntryMode.inputOnly,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().copyWith(year: 2025)),
          CupertinoButton(
              child: const Text("Ajouter"),
              onPressed: () {
                stockController.addPopulation(int.parse(nbrController.text),
                    raceController.text, selected_date);
              })
        ],
      ),
    );
  }
}
