import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/models/vente.dart';
import 'package:farmges/views/widgets/date_field.dart';
import 'package:farmges/views/widgets/description_field.dart';
import 'package:farmges/views/widgets/form_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/nombre_field.dart';
import '../widgets/page_layout.dart';
import '../widgets/race_select.dart';
import '../widgets/submit_btn.dart';

class AjoutVente extends StatelessWidget
    with
        DateInputMixin,
        DescriptionInputMixin,
        NombreInputMixin,
        RaceSelectMixin {
  DateTime now = DateTime.now();
  CoreController controller = Get.find();

  TextEditingController sommeController = TextEditingController();
  saveVente() async {
    var description = getDescription();
    var nombre = getNombre();
    var race = getRace();
    var montant = double.parse(sommeController.text);
    var vente = Vente(
        date: now,
        description: description,
        race: race,
        nombre: nombre,
        montant: montant);
    await controller.addVente(vente);
    clear();
    Get.snackbar('Ajout de vente', 'La vente a ete ajoutee avec succes');
  }

  clear() {
    clearRace();
    clearDescription();
    clearDate();
    clearNombre();
    sommeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(children: [
          FormCard([
            DateInput(),
            RaceSelect(),
            NombreInput('Nombre de poulets'),
            NombreInputField(sommeController, "Somme Totale"),
            DescriptionInput(),
            SubmitButton("Enregister", saveVente)
          ])
        ]),
        title: const Text("Ajout de vente"));
  }
}
