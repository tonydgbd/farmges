import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/models/vente.dart';
import 'package:farmges/views/widgets/date_field.dart';
import 'package:farmges/views/widgets/description_field.dart';
import 'package:farmges/views/widgets/form_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmges/views/widgets/select_field.dart';
import '../widgets/nombre_field.dart';
import '../widgets/page_layout.dart';
import '../widgets/race_select.dart';
import '../widgets/submit_btn.dart';

class AjoutVente extends StatelessWidget
    with
        DateInputMixin,
        DescriptionInputMixin,
        NombreInputMixin,
        RaceSelectMixin, 
        SelectFieldMixin{
  DateTime now = DateTime.now();
  CoreController controller = Get.find();

  saveVente() async {
    var description = getDescription();
    var nombre = getNombre();
    var race = getRace();
    var vente =
        Vente(date: now, description: description, race: race, nombre: nombre);
    await controller.addVente(vente);
    clear();
    Get.snackbar('Ajout de vente', 'La vente a ete ajoutee avec succes');
  }

  clear() {
    clearRace();
    clearDescription();
    clearDate();
    clearNombre();
  }

  @override
  Widget build(BuildContext context) {
    return EachPage(
        Container(
          height: 600,
          width: 400,
          child: SingleChildScrollView(
            child: Column(children: [
              FormCard([
                DateInput(),
                RaceSelect(),
                // Select(),
                NombreInput('Nombre'),
                NombreInput('Montant'),
                DescriptionInput('Description'),
                SubmitButton("Enregister", saveVente)
              ])
            ]),
          ),
        ),
        title: const Text("Ajout de vente"));
  }
}
