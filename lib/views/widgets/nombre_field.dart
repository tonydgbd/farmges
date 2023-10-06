import 'package:flutter/material.dart';

Widget NombreInputField(TextEditingController controller, String label,
    {String defaultNumber = "0", bool editable = true}) {
  controller.text = defaultNumber;
  return Padding(
    padding: const EdgeInsets.all(20),
    child: TextField(
      readOnly: !editable,
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    ),
  );
}

mixin class NombreInputMixin {
  TextEditingController nombreController = TextEditingController();

  int getNombre() {
    return int.parse(nombreController.text);
  }

  clearNombre() {
    nombreController.clear();
  }

  Widget NombreInput(String label,
      {String defaultNumber = "0", bool editable = true}) {
    return NombreInputField(nombreController, label,
        defaultNumber: defaultNumber);
  }
}
