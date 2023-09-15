import 'package:flutter/material.dart';

Widget FormCard(List<Widget> fields) {
  return Card(
    child: Column(children: [
      SizedBox(height: 20),
      for (var field in fields) field,
      SizedBox(height: 20)
    ]),
  );
}
