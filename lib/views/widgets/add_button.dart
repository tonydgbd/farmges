import 'package:flutter/material.dart';

Widget addButton(String label, void Function() onPressed) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: ElevatedButton(onPressed: onPressed, child: Text(label)),
  );
}
