import 'package:farmges/views/widgets/cancel_button.dart';
import 'package:farmges/views/widgets/date_field.dart';
import 'package:farmges/views/widgets/description_field.dart';
import 'package:farmges/views/widgets/form_card.dart';
import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:farmges/views/widgets/submit_btn.dart';
import 'package:flutter/material.dart';

class VaccinForm extends StatelessWidget
    with DateInputMixin, NombreInputMixin, DescriptionInputMixin {
  submit() {}

  clear() {}

  cancel() {}
  @override
  Widget build(BuildContext context) {
    dateInputLabel = "Date de debut";
    return FormCard([
      DescriptionInput(),
      NombreInput("Nombre de jours"),
      DateInput(),
      Row(
        children: [
          SubmitButton("Ajouter", submit),
          cancelButton("Annuler", cancel)
        ],
      )
    ]);
  }
}
