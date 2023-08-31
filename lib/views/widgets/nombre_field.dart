import 'package:flutter/material.dart';

Widget NombreInputField(Function getValue, String label) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) => getValue(value),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    ),
  );
}
