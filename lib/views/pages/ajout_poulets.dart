import 'package:farmges/controller/stock_controller.dart';
import 'package:farmges/views/widgets/form_card.dart';
import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:farmges/views/widgets/race_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/date_field.dart';
import '../widgets/description_field.dart';
import '../widgets/page_layout.dart';
import '../widgets/submit_btn.dart';

class AjoutPoulet extends StatelessWidget
    with
        NombreInputMixin,
        RaceSelectMixin,
        DateInputMixin,
        DescriptionInputMixin {
  StockController controller = Get.find();

  saveChickens() async {
    var race = getRace();
    var nombre = getNombre();

    await controller.addPopulation(nombre, race as String, getDate());
    clear();
    Get.snackbar('Ajout de poulets', 'Poulets ajoutes avec succes');
  }

  clear() {
    clearDate();
    clearRace();
    clearNombre();
    clearDescription();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(children: [
          FormCard([
            RaceSelect(),
            NombreInput('Nombre'),
            SubmitButton('Enregister', saveChickens),
          ])
        ]),
        title: Text("Ajout de poulets"));
  }
}
