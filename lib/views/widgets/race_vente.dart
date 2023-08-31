import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:flutter/material.dart';

Widget raceVenteInput(Function getValue) {
  TextEditingController raceController = TextEditingController();

  handleChange(String nombre) {
    String race = raceController.text;
    if (race.isNotEmpty && nombre.isNotEmpty) {
      getValue({"race": race, "nombre": nombre as int});
    }
  }

  return Row(children: [
    TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Entrez la race',
        labelText: 'Race',
      ),
      controller: raceController,
    ),
    NombreInputField(handleChange, 'Nombre')
  ]);
}
