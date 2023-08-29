import 'package:farmges/controller/core_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPopulation extends StatelessWidget {
  TextEditingController raceController = TextEditingController();
  TextEditingController nbrController = TextEditingController();
  DateTime selected_date = DateTime.now();

  AddPopulation({super.key});
  @override
  build(BuildContext context) {
    print("hi");
    print("$raceController.value $nbrController.value $selected_date.value");
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownMenu(
                width: Get.width * 0.5,
                controller: raceController,
                label: Text("Choisir la race"),
                dropdownMenuEntries: [
                  ...(CoreController.instance.data['races'] as List).map((e) =>
                      DropdownMenuEntry(
                          value: e['nom_de_races'], label: e['nom_de_races']))
                ]),
            TextField(
              controller: nbrController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Nombre de poulet", border: OutlineInputBorder()),
            ),
            Text("Selectioner la date du Jour 0"),
            DatePickerDialog(
                currentDate: selected_date,
                initialEntryMode: DatePickerEntryMode.inputOnly,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().copyWith(year: 2025)),
            CupertinoButton(
                child: Text("Ajouter"),
                onPressed: () {
                  CoreController.instance.addPopulation(
                      int.parse(nbrController.text),
                      raceController.text,
                      selected_date);
                })
          ],
        ),
      ),
    );
  }
}
