import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../models/population.dart';
import '../utils/add_to_callendar.dart';

class StockController extends GetxController {
  // controller les entrees de poulets, les deces
  // suivre les populations de poulet
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  var data = {
    'races': [
      {
        'nom_de_race': "bleu d'hollandes",
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

  void onAddEnd(int nombre_poulet, String race, DateTime date_debut) {
    firebase.collection("poulets").add(
        {'race': race, 'population': nombre_poulet, 'date_debut': date_debut});

    EasyLoading.showSuccess("Ajout reussit");
  }

  addPopulation(int nombre_poulet, String race, DateTime date_debut) async {
    add_to_callendar(data, race, date_debut,
        () => onAddEnd(nombre_poulet, race, date_debut));
  }

  Future<List<dynamic>> getPopulations() async {
    var collection = await firebase.collection('poulets').get();
    var populations = [];
    for (var document in collection.docs) {
      Map<String, dynamic> data = document.data();
      Timestamp date_debut = document.get('date_debut');
      data['date_debut'] = date_debut.toDate();
      populations.add(data);
    }
    return populations;
  }

  addDeces(Deces data) async {
    var jsonData = data.toJson();
    var response = await firebase.collection("deces").add(jsonData);
    var doc = await response.get();
    var popRef = doc.data()?['populationReference'];
    var r = Timestamp.fromDate(DateTime.parse(popRef));
    var population = await firebase
        .collection('poulets')
        .where("date_debut", isEqualTo: r)
        .get();
    for (var pop in population.docs) {
      print(pop.data());
      try {
        await firebase
            .collection('poulets')
            .doc(pop.id)
            .update({"population": pop['population'] - data.nombre});
        print('successfuly updated');
      } catch (err) {
        print("update res : $err");
      }
    }
    return response;
  }
}
