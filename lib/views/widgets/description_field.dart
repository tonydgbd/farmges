import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DescriptionInputField(TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: TextField(
      keyboardType: TextInputType.number,
      controller:controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Description',
      ),
    ),
  );
}

mixin class DescriptionInputMixin {
  TextEditingController descriptionController = TextEditingController();

  getDescription() {
    return descriptionController.text;
  }

  clearDescription(){
    descriptionController.clear();
  }

  Widget DescriptionInput(){
    return DescriptionInputField(descriptionController);
  }
}
