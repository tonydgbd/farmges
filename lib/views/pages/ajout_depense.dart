import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/models/depenses.dart';
import 'package:farmges/views/widgets/date_field.dart';
import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/description_field.dart';
import '../widgets/submit_btn.dart';

class AjoutDepense extends StatelessWidget {
  String description = '';
  String montant = '';

  TextEditingController montantController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime now = DateTime.now();
  CoreController controller = Get.find();

  saveDepense() async {
    var montant = montantController.text;
    String description = descriptionController.text;
    var depense =
        Depense(date: now, montant: montant, description: description);
    var response = await controller.addDepense(depense);
    montantController.dispose();
    descriptionController.dispose();
  }

  getDescription(String desc) {
    descriptionController.text = desc;
    description = desc;
  }

  getMontant(String mont) {
    montantController.text = mont;
    montant = mont;
  }

  getDate(dynamic value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajout d'une depense")),
      body: ListView(children: [
        DateInputField(getDate),
        NombreInputField(getMontant, 'Montant'),
        DescriptionInputField(getDescription),
        SubmitButton('Enregister', saveDepense),
      ]),
    );
  }
}
