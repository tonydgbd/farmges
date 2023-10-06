
import 'package:device_calendar/device_calendar.dart';
import 'package:farmges/controller/core_controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

add_to_callendar(Map<String, dynamic> data, String race, DateTime date_debut,
    Function onAddEnd) async {
  data = CoreController.instance.data;
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
       var hasPermissions= await DeviceCalendarPlugin().hasPermissions();
       while(hasPermissions.data !=true){
         hasPermissions= await DeviceCalendarPlugin().hasPermissions();
        if(hasPermissions==true){
          break;
        }
        await DeviceCalendarPlugin().requestPermissions();
       }
       
      
      //  var calendar = await DeviceCalendarPlugin().createCalendar('ferme');
      //  print(calendar.data);
    if (data["races"]!
            .where((element) => element['nom_de_race'] == race)
            .length ==
        0) {
      data["races"]!.where((element) {
        print(element['nom_de_race']);
        print(race);
        print(element['nom_de_race'] == race);
        return element['nom_de_race'] == race;
      }).length;

      return;
    } else {
      var race_data = data["races"]!
          .where((element) => element['nom_de_race'] == race)
          .first;

      for (var element in (race_data['vaccin'] as List)) {
        element as Map;
        try{
     
       var val = await DeviceCalendarPlugin().createOrUpdateEvent( Event("8", title: "Achat de vaccin ${element['nom_vaccin']}",
            start: TZDateTime.from(DateUtils.addDaysToDate(
                date_debut.copyWith(hour: 6), (element['date_debut'] - 2)), getLocation('Africa/Abidjan') ) ,
            end: TZDateTime.from( DateUtils.addDaysToDate(
                date_debut.copyWith(
                  hour: 6,
                ),
                (element['date_debut'] - 1)),getLocation('Africa/Abidjan')),
                reminders: [ Reminder(minutes: 120),Reminder(minutes: 240)]
                ));
            print(val!.data!);
        }catch(e){
          print("######Error");
          print(e);
        }
        // await Add2Calendar.addEvent2Cal(Event(
        //     title: "Achat de vaccin ${element['nom_vaccin']}",
        //     startDate: DateUtils.addDaysToDate(
        //         date_debut.copyWith(hour: 6), (element['date_debut'] - 2)),
        //     endDate: DateUtils.addDaysToDate(
        //         date_debut.copyWith(
        //           hour: 6,
        //         ),
        //         (element['date_debut'] - 1))
        //         ));
      }
      for (var element in (race_data['vitamines'] as List)) {
        element as Map;
        await DeviceCalendarPlugin().createOrUpdateEvent (Event("1",
            title: "Achat de vitamine ${element['nom_vitamine']}",
            start: TZDateTime.from(DateUtils.addDaysToDate(
                date_debut.copyWith(hour: 6), (element['date_debut'] - 2)),getLocation('Africa/Abidjan')),
            end:TZDateTime.from( DateUtils.addDaysToDate(
                date_debut.copyWith(
                  hour: 6,
                ),
                (element['date_debut'] - 1)),getLocation('Africa/Abidjan')),
                         reminders: [ Reminder(minutes: 120),Reminder(minutes: 240)]
                ),
                );
      }

      // for (var element in (race_data['aliments'] as List)) {
      //   element as Map;
      //   await Add2Calendar.addEvent2Cal(Event(
      //       title: "Achat d'aliment ${element['nom_aliment']}",
      //       startDate: DateUtils.addDaysToDate(
      //           date_debut.copyWith(hour: 6), (element['date_debut'] - 2)),
      //       endDate: DateUtils.addDaysToDate(
      //           date_debut.copyWith(
      //             hour: 6,
      //           ),
      //           (element['date_debut'] - 1))));
      // }
      onAddEnd();
    }
    // }
  }
}
