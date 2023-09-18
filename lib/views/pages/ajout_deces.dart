import 'package:farmges/controller/stock_controller.dart';
import 'package:farmges/views/widgets/select_field.dart';
import 'package:farmges/views/widgets/description_field.dart';
import 'package:farmges/views/widgets/form_card.dart';
import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:farmges/views/widgets/race_select.dart';
import 'package:farmges/views/widgets/submit_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/population.dart';
import '../widgets/date_field.dart';
import '../widgets/page_layout.dart';

class AjoutDeces extends StatelessWidget
    with
        RaceSelectMixin,
        NombreInputMixin,
        DescriptionInputMixin,
        DateInputMixin,
        SelectFieldMixin {
  StockController controller = Get.find();
  List<dynamic>? availablePopulations;

  AjoutDeces({super.key});

  getOptions() async {
    controller.getPopulations().then((value) {
      var op = value.map((e) {
        var value = e['date_debut'].toString();
        return {"label": value, "value": value};
      });
      selectionOptions = op.toList();
      availablePopulations = value;
    }).catchError((err) {
      print(err);
    });
  }

  submit() async {
    var race = getRace();
    var nombre = getNombre();
    var description = getDescription();
    var date = getDate();
    Deces data = Deces(
        date: date,
        nombre: nombre,
        race: race,
        populationReference: getSelected(),
        description: description);
    await controller.addDeces(data);
    clear();
    Get.snackbar('Enregistrement de deces', 'Deces ajoute aves succes');
  }

  clear() {
    clearDate();
    clearRace();
    clearDescription();
    clearNombre();
    clearSelection();
  }

  String? dateInputLabel = 'Date de Deces';
  String selectionLabel = "Date d'ajout des poulets";

  @override
  Widget build(BuildContext context) {
    getOptions();
    return EachPage(
        Container(
          width: 400,
          height: 600,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormCard([
                  RaceSelect(),
                  Select(),
                  DateInput(),
                  NombreInput('Nombre'),
                  DescriptionInput('Cause de décès'),
                  SubmitButton('Enregister', submit)
                ])
              ],
            ),
          ),
        ),
        title: const Text("Enregister un deces"));
  }
}
