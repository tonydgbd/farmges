import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DateInputField extends StatelessWidget {
  Function? getDateValue;
  String? label;
  final TextEditingController dateController;
  DateInputField({required this.dateController, this.getDateValue, this.label});

  onChangeDate(DateTime date) {
    dateController.text = DateFormat('yyyy-MM-dd').format(date);
  }

  openCallendar(BuildContext context) async {
    var initialDate = DateTime.now();
    var firstDate = DateTime(2020);
    var lastDate = DateTime.now();;
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
        keyboardType: TextInputType.none,
        controller: dateController,
        readOnly: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text("$label"),
          hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          suffixIcon: IconButton(
              onPressed: () => openCallendar(context),
              icon: const Icon(Icons.calendar_month,size: 30,)),
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
