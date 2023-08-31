import 'package:flutter/material.dart';

Widget StatCard(String title, int amount) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title),
          const Padding(padding: EdgeInsets.all(10)),
          Text("$amount FCFA")
        ],
      ),
    ),
  );
}
