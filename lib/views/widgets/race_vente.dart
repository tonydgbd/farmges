import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:farmges/views/widgets/race_select.dart';
import 'package:flutter/material.dart';

Widget raceVenteInput(Function getValue) {
  TextEditingController raceController = TextEditingController();

  handleChange(String nombre) {
    String race = raceController.text;
    if (race.isNotEmpty && nombre.isNotEmpty) {
      getValue({"race": race, "nombre": nombre as int});
    }
  }

  return Container(
    child: Row(children: [
      RaceSelectField((value) => raceController.text = value),
      NombreInputField(handleChange, 'Nombre')
    ]),
  );
}
