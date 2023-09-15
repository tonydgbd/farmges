import 'package:farmges/controller/stock_controller.dart';
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
        DateInputMixin {
  StockController controller = Get.find();

  submit() async {
    var race = getRace();
    var nombre = getNombre();
    var description = getDescription();
    var date = getDate();
    Deces data = Deces(
        date: date,
        nombre: nombre,
        race: race,
        populationReference: 'cnjasdklcka',
        description: description);
    print(data.toJson());
    var response = await controller.addDeces(data.toJson());
    print(response);
    clear();
    Get.snackbar('Enregistrement de deces', 'Deces ajoute aves succes');
  }

  clear() {
    clearDate();
    clearRace();
    clearDescription();
    clearNombre();
  }

  String? dateInputLabel = 'Date de Deces';

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(
          children: [
            FormCard([
              RaceSelect(),
              DateInput(),
              NombreInput('Nombre'),
              DescriptionInput(),
              SubmitButton('Enregister', submit)
            ])
          ],
        ),
        title: const Text("Enregister un deces"));
  }
}
