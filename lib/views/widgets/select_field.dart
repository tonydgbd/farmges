import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget SelectField(TextEditingController controller,
    List<Map<String, dynamic>> options, String? label,
    {void Function(String?)? onSelected, bool largeWidth = true}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: DropdownMenu(
        width: largeWidth ? Get.width * 0.8 : null,
        requestFocusOnTap: true,
        onSelected: (value) {
          onSelected!(value.toString());
        },
        controller: controller,
        label: Text(label ?? "Choisir"),
        dropdownMenuEntries: [
          ...(options).map((option) => DropdownMenuEntry(
              value: option['value'], label: option['label']!.toString()))
        ]),
  );
}

mixin class SelectFieldMixin {
  TextEditingController selectionController = TextEditingController();
  late String selectionLabel;
  getSelected() {
    return selectionController.text;
  }

  clearSelection() {
    selectionController.clear();
  }

  Widget Select(List<Map<String, dynamic>> selectionOptions,
      {void Function(String?)? onSelected, bool largestWidth = true}) {
    selectionController.text = selectionOptions[0]['value']!;
    return SelectField(selectionController, selectionOptions, selectionLabel,
        onSelected: onSelected, largeWidth: largestWidth);
  }
}
