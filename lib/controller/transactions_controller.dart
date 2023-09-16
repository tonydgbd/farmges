import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  // manage depenses and vente
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

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
}
