import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DescriptionInputField(Function getValue) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) => getValue(value),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Description',
      ),
    ),
  );
}
