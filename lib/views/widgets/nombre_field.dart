import 'package:flutter/material.dart';

Widget NombreInputField(TextEditingController controller, String label) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: TextField(
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

  Widget NombreInput(String label) {
    return NombreInputField(nombreController, label);
  }
}
