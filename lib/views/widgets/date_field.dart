import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateInputController extends GetxController{
  var date = DateTime.now().obs;

  updateValue(DateTime date){
    print(date);
    date = date;
  }
}
class DateInputField extends StatelessWidget{
  Function getDateValue;
  String label;
  late DateTime dateSelected = DateTime.now();
  final DateInputController controller = DateInputController();

  DateInputField({required this.getDateValue,this.label}){
    if(!this.label){
      
    }
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
        controller.updateValue(date!);
        getDateValue(controller.date);
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(children:[
            Text("$label"),
            IconButton(
              onPressed: ()=>openCallendar(context), icon: const Icon(Icons.calendar_today)),

          ]),
          Obx(()=>Text("choisir une date $controller.date")),
          
        ],
      )
      //
      );
  }
}


mixin class DateInputMixin {
  DateTime?  date;
  getDate() {
    // return dateController.text;
    return date;
  }

  clearDate() {
    date=null;
  }

  Widget DateInput() {
    return DateInputField(getDateValue:(DateTime value)=>date=value);
  }
}
