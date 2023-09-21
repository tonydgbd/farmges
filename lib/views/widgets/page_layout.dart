import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmges/views/widgets/addPopulation.dart';

Widget PageLayout(Widget child,
    {Widget title = const Text("Gestion de ferme"), showAddButton = true}) {
  return Scaffold(
    appBar: AppBar(
      title: title,
    ),
    body: child,
    floatingActionButton: showAddButton
        ? FloatingActionButton(
            onPressed: () {
              Get.defaultDialog(content: AddPopulation());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        : null,
  );
}
