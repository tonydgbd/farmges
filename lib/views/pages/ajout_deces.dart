import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/views/widgets/description_field.dart';
import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:farmges/views/widgets/race_select.dart';
import 'package:farmges/views/widgets/submit_btn.dart';
import 'package:flutter/cupertino.dart';
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
  CoreController controller = Get.find();

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

    await controller.addDeces(data);
    clear();
    Get.snackbar('Enregistrement de deces', 'Deces ajoute aves succes');
  }

  clear() {
    clearDate();
    clearRace();
    clearDescription();
    clearNombre();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(
          children: [
            DateInput(context),
            RaceSelect(),
            NombreInput('Nombre'),
            DescriptionInput(),
            SubmitButton('Enregister', submit)
          ],
        ),
        title: const Text("Enregister un deces"));
  }
}
