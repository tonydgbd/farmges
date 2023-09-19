import 'package:farmges/controller/core_controllers.dart';
import 'package:farmges/controller/transactions_controller.dart';
import 'package:farmges/models/depenses.dart';
import 'package:farmges/views/widgets/date_field.dart';
import 'package:farmges/views/widgets/form_card.dart';
import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/description_field.dart';
import '../widgets/submit_btn.dart';
import '../widgets/page_layout.dart';

class AjoutDepense extends StatelessWidget
    with NombreInputMixin, DescriptionInputMixin, DateInputMixin {
  DateTime now = DateTime.now();
  TransactionsController controller = Get.find();

  AjoutDepense({super.key});

  saveDepense() async {
    var montant = getNombre();
    String description = getDescription();
    var depense = Depense(
        date: getDate(), montant: montant as String, description: description);
    await controller.addDepense(depense);
    clear();
    Get.snackbar('Ajout de depense', 'Depense ajoute avec succes');
  }

  clear() {
    clearDate();
    clearDescription();
    clearNombre();
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(children: [
          FormCard([
            DateInput(),
            NombreInput('Montant'),
            DescriptionInput(),
            SubmitButton('Enregister', saveDepense),
          ])
        ]),
        title: const Text("Ajout d'une depense"));
  }
}
