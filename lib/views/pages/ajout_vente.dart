import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/models/vente.dart';
import 'package:farmges/views/widgets/date_field.dart';
import 'package:farmges/views/widgets/description_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/nombre_field.dart';
import '../widgets/page_layout.dart';
import '../widgets/race_select.dart';
import '../widgets/race_vente.dart';
import '../widgets/submit_btn.dart';

class AjoutVente extends StatelessWidget {
  TextEditingController descriptionController = TextEditingController();

  TextEditingController raceController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  DateTime now = DateTime.now();
  CoreController controller = Get.find();

  saveVente() async {
    var description = descriptionController.text;
    var nombre = nombreController.text;
    var race = raceController.text;
    var vente =
        Vente(date: now, description: description, race: race, nombre: nombre);
    var response = await controller.addVente(vente);
    return response;
  }

  getDate(dynamic value) {}

  getDescription(String value) {
    descriptionController.text = value;
  }

  getRace(String race) {
    raceController.text = race;
  }

  getNombre(String nombre) {
    nombreController.text = nombre;
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(children: [
          DateInputField(getDate),
          RaceSelectField((value) => getRace(value)),
          NombreInputField((value) => getNombre(value), 'Nombre'),
          DescriptionInputField(getDescription),
          SubmitButton("Enregister", saveVente)
        ]),
        title: const Text("Ajout de vente"));
  }
}
