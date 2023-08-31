import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/models/vente.dart';
import 'package:farmges/views/widgets/date_field.dart';
import 'package:farmges/views/widgets/description_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/page_layout.dart';
import '../widgets/race_vente.dart';
import '../widgets/submit_btn.dart';

class AjoutVente extends StatelessWidget {
  TextEditingController descriptionController = TextEditingController();
  DateTime now = DateTime.now();
  CoreController controller = Get.find();

  getValue(Map<String, dynamic> data) {
    print(data);
  }

  saveVente() async {
    var description = descriptionController.text;
    var vr = [
      {'race': "blue d'hollande", "nombre": 3000},
      {'race': "blue d'hollande", "nombre": 3000},
      {'race': "blue d'hollande", "nombre": 3000},
      {'race': "blue d'hollande", "nombre": 3000},
      {'race': "blue d'hollande", "nombre": 3000}
    ];
    var sorties = VenteRace.multiple(vr);
    var vente = Vente(date: now, description: description, sorties: sorties);
    var response = await controller.addVente(vente);
    return response;
  }

  getDate(dynamic value) {}

  getDescription(String value) {
    descriptionController.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(children: [
          raceVenteInput(getValue),
          DateInputField(getDate),
          DescriptionInputField(getDescription),
          SubmitButton("Enregister", saveVente)
        ]),
        title: const Text("Ajout de vente"));
  }
}
