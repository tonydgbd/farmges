import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/core_controllers.dart';

Widget RaceSelectField(TextEditingController controller) {
  CoreController controllerInstance = Get.find();

  return Padding(
    padding: const EdgeInsets.all(20),
    child: DropdownMenu(
        width: Get.width * 0.8,
        controller: controller,
        label: const Text("Choisir la race"),
        dropdownMenuEntries: [
          ...(controllerInstance.data['races'] as List).map((e) =>
              DropdownMenuEntry(
                  value: e['nom_de_race'], label: e['nom_de_race']))
        ]),
  );
}

mixin class RaceSelectMixin {
  TextEditingController raceController = TextEditingController();

  getRace() {
    return raceController.text;
  }

  clearRace() {
    raceController.clear();
  }

  Widget RaceSelect() {
    return RaceSelectField(raceController);
  }
}
