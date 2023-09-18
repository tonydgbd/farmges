import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DescriptionInputField(TextEditingController controller,
    {String label = 'Description'}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: TextField(
      keyboardType: TextInputType.text,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
      ),
    ),
  );
}

mixin class DescriptionInputMixin {
  TextEditingController descriptionController = TextEditingController();

  getDescription() {
    return descriptionController.text;
  }

  clearDescription() {
    descriptionController.clear();
  }

  Widget DescriptionInput({String? label}) {
    return DescriptionInputField(descriptionController,
        label: label ?? 'Description');
  }
}
