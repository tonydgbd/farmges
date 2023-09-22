import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmges/controller/core_controllers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../models/population.dart';
import '../utils/add_to_callendar.dart';

class StockController extends GetxController {
  // controller les entrees de poulets, les deces
  // suivre les populations de poulet
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  CoreController coreController = CoreController();
  late final data;

  StockController() {
    data = coreController.data;
  }

  void onAddEnd(int nombre_poulet, String race, DateTime date_debut) {
    firebase.collection("poulets").add(
        {'race': race, 'population': nombre_poulet, 'date_debut': date_debut});

    EasyLoading.showSuccess("Ajout reussit");
  }

  addPopulation(int nombre_poulet, String race, DateTime date_debut) async {
    add_to_callendar(data, race, date_debut,
        () => onAddEnd(nombre_poulet, race, date_debut));
  }

  Future<List<Map<String, dynamic>>> getPopulations() async {
    var collection = await firebase
        .collection('poulets')
        .where("population", isGreaterThan: 0)
        .get();
    List<Map<String, dynamic>> populations = [];
    for (var document in collection.docs) {
      Map<String, dynamic> data = document.data();
      Timestamp dateDebut = document.get('date_debut');
      data['date_debut'] = dateDebut.toDate();
      populations.add(data);
    }
    return populations;
  }

  addDeces(Deces data) async {
    var jsonData = data.toJson();
    var response = await firebase.collection("deces").add(jsonData);
    var doc = await response.get();
    var popRef = doc.data()?['populationReference'];
    if (popRef != "") {
      var r = Timestamp.fromDate(DateTime.parse(popRef));
      var population = await firebase
          .collection('poulets')
          .where("date_debut", isEqualTo: r)
          .get();
      for (var pop in population.docs) {
        try {
          await firebase
              .collection('poulets')
              .doc(pop.id)
              .update({"population": pop['population'] - data.nombre});
        } catch (err) {
          print("update res : $err");
        }
      }
    }
    return response;
  }

  Future<List<Map<String, dynamic>>> getDeces({int? month}) async {
    var now = DateTime.now();
    var date = DateTime(now.year, month = month ?? now.month);
    var res = await firebase.collection('deces').get();
    List<Map<String, dynamic>> ret = [];
    for (var d in res.docs) {
      Map<String, dynamic> data = d.data();
      Timestamp dateDebut = d.get('date');
      data['date'] = dateDebut.toDate();

      ret.add(data);
    }
    return ret;
  }
}
