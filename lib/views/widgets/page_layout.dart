import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:farmges/views/widgets/addPopulation.dart';
import '../widgets/app_drawer.dart';

Widget PageLayout(Widget child,
    {Widget title = const Text("Gestion de ferme")}) {
  return Scaffold(
    appBar: AppBar(
      title: title,
    ),
    drawer: DrawerMenu(),
    body: child,
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        Get.defaultDialog(content: AddPopulation());
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    ),
  );
}
