import 'package:flutter/material.dart';

Widget SubmitButton(String label, Function submit) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: ElevatedButton(onPressed: () => submit(), child: Text(label)),
  );
}
