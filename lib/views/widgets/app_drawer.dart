import 'package:farmges/views/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/nav_controller.dart';

Widget DrawerMenu() {
  List<Map> pages = [
    {'label': 'home', "route": HomePage()}
  ];
  DrawerNavController controller = Get.find();

  void onSelect(dynamic page) {
    controller.selectPage(page['label']);
    Get.to(page['route']);
  }

  return Drawer(
    child: ListView(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.lightBlue,
          ),
          child: Text('Gestion de ferme '),
        ),
        for (final page in pages)
          ListTile(
            title: Text(page['label']!),
            selected: controller.activePage == page['label'],
            onTap: () => onSelect(page),
          )
      ],
    ),
  );
}
