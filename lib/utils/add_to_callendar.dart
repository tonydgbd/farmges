import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';

add_to_callendar(Map<String, dynamic> data, String race, DateTime date_debut,Function onAddEnd) async {
  if (data["races"]!
          .where((element) => element['nom_de_races'] == race)
          .length ==
      0) {
    return;
  } else {
    var race_data = data["races"]!
        .where((element) => element['nom_de_races'] == race)
        .first;

    for (var element in (race_data['vaccin'] as List)) {
      element as Map;
      await Add2Calendar.addEvent2Cal(Event(
          title: "Achat de vaccin ${element['nom_vaccin']}",
          startDate: DateUtils.addDaysToDate(
              date_debut.copyWith(hour: 6), (element['date_debut'] - 2)),
          endDate: DateUtils.addDaysToDate(
              date_debut.copyWith(
                hour: 6,
              ),
              (element['date_debut'] - 1))));
    }
    for (var element in (race_data['vitamines'] as List)) {
      element as Map;
      await Add2Calendar.addEvent2Cal(Event(
          title: "Achat de vitamine ${element['nom_vitamine']}",
          startDate: DateUtils.addDaysToDate(
              date_debut.copyWith(hour: 6), (element['date_debut'] - 2)),
          endDate: DateUtils.addDaysToDate(
              date_debut.copyWith(
                hour: 6,
              ),
              (element['date_debut'] - 1))));
     }

    for (var element in (race_data['aliments'] as List)) {
      element as Map;
      await Add2Calendar.addEvent2Cal(Event(
          title: "Achat d'aliment ${element['nom_aliment']}",
          startDate: DateUtils.addDaysToDate(
              date_debut.copyWith(hour: 6), (element['date_debut'] - 2)),
          endDate: DateUtils.addDaysToDate(
              date_debut.copyWith(
                hour: 6,
              ),
              (element['date_debut'] - 1))));
    }
    onAddEnd();
  }
}
