import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateInputField extends StatelessWidget {
  Function? getDateValue;
  String? label;
  final TextEditingController dateController;
  DateInputField({required this.dateController, this.getDateValue, this.label});

  onChangeDate(DateTime date) {
    dateController.text = date.toString();
  }

  openCallendar(BuildContext context) async {
    var initialDate = DateTime.now();
    var firstDate = DateTime.now();
    var lastDate = DateTime(2024, 12, 12, 12, 12);
    var date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    onChangeDate(date!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: dateController,
        readOnly: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text("$label"),
          prefixIcon: IconButton(
              onPressed: () => openCallendar(context),
              icon: const Icon(Icons.calendar_today)),
        ),
      ),
    );
    //
  }
}

mixin class DateInputMixin {
  String? dateInputLabel;
  getDate() {
    // return dateController.text;
    return DateTime.parse(dateController.text);
  }

  clearDate() {
    dateController.clear();
  }

  TextEditingController dateController = TextEditingController();
  Widget DateInput() {
    return DateInputField(
        dateController: dateController, label: dateInputLabel ?? 'Date');
  }
}
