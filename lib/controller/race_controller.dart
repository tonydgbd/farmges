import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmges/models/race.dart';
import 'package:get/get.dart';

class RaceController extends GetxController {
  final raceCollection = FirebaseFirestore.instance.collection('races');

  addRace(Race raceData) async {
    await raceCollection.add(raceData.toJson());
  }
}
