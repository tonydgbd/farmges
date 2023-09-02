import 'package:flutter/material.dart';

Widget DateInputField(TextEditingController controller, BuildContext context) {
  DateTime dateSelected = DateTime.now();
 
  openCallendar() async {
    var initialDate = DateTime.now();
    var firstDate = DateTime.now();
    var lastDate = DateTime(2024, 12, 12, 12, 12);
    var date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    controller.text = date!.toString();
    print(date);
    dateSelected = date;
  }

  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          IconButton(
              onPressed: openCallendar, icon: const Icon(Icons.calendar_today)),
          Text("choisir une date $dateSelected"),
          
        ],
      )
      //
      );
}

mixin class DateInputMixin {
  TextEditingController dateController = TextEditingController();

  getDate() {
    // return dateController.text;
    return DateTime.now();
  }

  clearDate() {
    dateController.clear();
  }

  Widget DateInput(BuildContext context) {
    return DateInputField(dateController, context);
  }
}
