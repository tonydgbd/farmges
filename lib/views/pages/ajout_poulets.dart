import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:farmges/views/widgets/race_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/page_layout.dart';
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

    raceController.clear();
    nbrController.clear();

    Get.snackbar('Ajout de poulets', 'Poulets ajoutes avec succes');
  }

  getPouletNombre(String nombre) {
    nbrController.text = nombre;
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(children: [
          RaceSelectField((value) => raceController.text = value),
          NombreInputField(getPouletNombre, 'Nombre'),
          SubmitButton('Enregister', saveChickens),
        ]),
        title: Text("Ajout de poulets"));
  }
}
