import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget SelectField(TextEditingController controller,
    List<Map<String, String>> options, String? label) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: DropdownMenu(
        width: Get.width * 0.8,
        controller: controller,
        label: Text(label ?? "Choisir"),
        dropdownMenuEntries: [
          ...(options).map((option) => DropdownMenuEntry(
              value: option['value'], label: option['label']!))
        ]),
  );
}

mixin class SelectFieldMixin {
  TextEditingController selectionController = TextEditingController();
  List<Map<String, String>>? selectionOptions;
  late String selectionLabel;
  getSelected() {
    return selectionController.text;
  }

  clearSelection() {
    selectionController.clear();
  }

  Widget Select() {
    return SelectField(
        selectionController, selectionOptions ?? [], selectionLabel);
  }
}
