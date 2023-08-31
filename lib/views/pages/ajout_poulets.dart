import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/submit_btn.dart';

class AjoutPoulet extends StatelessWidget {
  TextEditingController raceController = TextEditingController();
  TextEditingController nbrController = TextEditingController();
  DateTime selected_date = DateTime.now();
  CoreController controller = Get.find();

  saveChickens() async {
    var race = raceController.text;
    var nombre = nbrController.text;
    print("$race $nombre $selected_date");
    var response = await controller.addPopulation(
        nombre as int, race as String, selected_date);
    print(response);

    raceController.text = "";
    nbrController.text = "";
  }

  getPouletNombre(String nombre) {
    nbrController.text = nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Ajout de poulets")),
        body: ListView(children: [
          DropdownMenu(
              width: Get.width * 0.5,
              controller: raceController,
              label: Text("Choisir la race"),
              dropdownMenuEntries: [
                ...(CoreController.instance.data['races'] as List).map((e) =>
                    DropdownMenuEntry(
                        value: e['nom_de_race'], label: e['nom_de_race']))
              ]),
          NombreInputField(getPouletNombre, 'Nombre'),
          SubmitButton('Enregister', saveChickens),
        ]));
  }
}
