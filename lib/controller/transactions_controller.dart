import 'package:farmges/controller/core_controllers.dart';
import '../models/depenses.dart';
import '../models/population.dart';
import '../models/vente.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  // manage depenses and vente
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  late final data;
  CoreController coreController = CoreController();
  TransactionsController() {
    data = coreController.data;
  }
  Future<double> getDepenseTotal() async {
    double total = 0;
    var depenses = await firebase.collection('depenses').get();
    for (var dep in depenses.docs) {
      total += dep['montant'];
    }
    return total;
  }

  Future<double> getVenteTotal() async {
    double total = 0;
    var depenses = await firebase.collection('ventes').get();
    for (var dep in depenses.docs) {
      total += dep['montant'];
    }
    return total;
  }

  Future<double> getDepenseMensuelle() async {
    double total = 0;
    var now = DateTime.now();
    var thisYear = now.year;
    var thisMonth = now.month;
    var startAt = DateTime(thisYear, thisMonth, 0);
    var depenses = await firebase
        .collection('depenses')
        .where("date", isLessThan: now, isGreaterThan: startAt)
        .get();
    for (var dep in depenses.docs) {
      var data = dep.data();
      var montant = data['montant'] ?? 0;

      try {
        if (montant.toString().isNum) {
          double toAdd = double.parse(montant);
          total += toAdd;
        }
      } on Error catch (e) {}
    }
    return total;
  }

  Future<double> getVenteMensuelle() async {
    double total = 0;
    var now = DateTime.now();
    var thisYear = now.year;
    var thisMonth = now.month;
    var startAt = DateTime(thisYear, thisMonth, 0);
    var depenses = await firebase
        .collection('ventes')
        .where("date", isLessThan: now, isGreaterThan: startAt)
        .get();
    for (var dep in depenses.docs) {
      var data = dep.data();
      var montant = data['montant'] ?? 0;
      total += montant;
    }
    return total;
  }

  addDepense(Depense data) async {
    final created = await firebase.collection("depenses").add(data.toJson());
    return created;
  }

  addVente(Vente data) async {
    var jsonData = data.toJson();
    final created = await firebase.collection("ventes").add(jsonData);
    return created;
  }

  addDeces(Deces data) async {
    var jsonData = data.toJson();
    var response = await firebase.collection("deces").add(jsonData);
    return response;
  }
}
