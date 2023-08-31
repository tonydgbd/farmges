import 'package:flutter/material.dart';

Widget DateInputField(Function getValue) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Choisir une date',
        labelText: 'Date',
      ),
      onChanged: (value) => getValue(value),
    ),
  );
}
