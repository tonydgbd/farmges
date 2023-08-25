import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CoreController extends GetxController {
  static CoreController instance = Get.find();
  var data = {
    'races': [
      {
        'nom_de_races': "bleu d'hollandes",
        'vaccin': [
          {'nom_vaccin': 'eau sucree', 'date_debut': 1, 'nbr_jour': 1},
          {
            'nom_vaccin': 'Bronchite infectieuse',
            'date_debut': 5,
            'nbr_jour': 1
          },
          {
            'nom_vaccin': 'vaccin new casthle infectable',
            'date_debut': 10,
            'nbr_jour': 1
          },
          {'nom_vaccin': 'eau simple', 'date_debut': 12, 'nbr_jour': 2},
          {'nom_vaccin': 'oxy 50%', 'date_debut': 16, 'nbr_jour': 5},
          {'nom_vaccin': 'pevalap', 'date_debut': 28, 'nbr_jour': 1},
          {'nom_vaccin': 'anticose', 'date_debut': 23, 'nbr_jour': 5},
          {
            'nom_vaccin': 'rappel vaccin new casthel infectable',
            'date_debut': 30,
            'nbr_jour': 1
          },
          {'nom_vaccin': 'tetracilivit', 'date_debut': 40, 'nbr_jour': 3},
          {'nom_vaccin': 'eau simple', 'date_debut': 32, 'nbr_jour': 7},
          {'nom_vaccin': 'levalap', 'date_debut': 46, 'nbr_jour': 1},
          {'nom_vaccin': 'anticose', 'date_debut': 47, 'nbr_jour': 5},
        ],
        'vitamines': [
          {'nom_vitamine': 'tetravit', 'date_debut': 2, 'nbr_jour': 3},
          {'nom_vitamine': 'Conboro simple', 'date_debut': 7, 'nbr_jour': 1},
          {'nom_vitamine': 'vitamine', 'date_debut': 8, 'nbr_jour': 2},
          {'nom_vitamine': 'Conboro fort', 'date_debut': 14, 'nbr_jour': 1}
        ],
        'aliments': [
          {'nom_aliment': "Galdus", "date_debut": 1, "nbr_jour": 21},
          {'nom_aliment': "Croissance", "date_debut": 22, "nbr_jour": 26},
          {'nom_aliment': "finition", "date_debut": 47, "nbr_jour": 51}
        ]
      }
    ]
  };

  addPopulation(int nombre_poulet, String race, DateTime date_debut) async {
    EasyLoading.show();

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
        var rs = await Add2Calendar.addEvent2Cal(Event(
            title: "Achat de vitamine ${element['nom_vitamine']}",
            startDate: DateUtils.addDaysToDate(
                date_debut.copyWith(hour: 6), (element['date_debut'] - 2)),
            endDate: DateUtils.addDaysToDate(
                date_debut.copyWith(
                  hour: 6,
                ),
                (element['date_debut'] - 1))));
        print(rs);
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
      FirebaseFirestore.instance.collection("poulets").add({
        'race': race,
        'population': nombre_poulet,
        'date_debut': date_debut
      });
    }
    EasyLoading.showSuccess("Ajout reussit");
  }

  addDepense() {}
}
