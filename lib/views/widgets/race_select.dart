import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/core_controllers.dart';

Widget RaceSelectField(Function getValue) {
  CoreController controller = Get.find();

  return DropdownMenu(
      width: Get.width * 0.5,
      onSelected: (value) => getValue(value),
      label: const Text("Choisir la race"),
      dropdownMenuEntries: [
        ...(controller.data['races'] as List).map((e) =>
            DropdownMenuEntry(value: e['nom_de_race'], label: e['nom_de_race']))
      ]);
}
