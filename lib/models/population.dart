import 'package:farmges/models/etapes_de_croissances.dart';

class Population {
  String? id;
  DateTime date_debut;
  int population;
  String race;

  Population(
      {required this.date_debut,
      required this.population,
      required this.race,
      this.id});

  toJson() {
    return {"date_debut": date_debut, "population": population, "race": race};
  }

  static EtapeCroissance getStep(DateTime startAt) {
    Duration nombreJours = DateTime.now().difference(startAt);
    switch (nombreJours.inDays) {
      case < 21:
        return EtapeCroissance.demarrage;
      case > 21 && < 26 + 21:
        return EtapeCroissance.croissance;
      case > 26 + 21:
        return EtapeCroissance.finalisation;
    }
    return EtapeCroissance.finalisation;
  }
}

class Deces {
  String? id;
  DateTime date;
  int nombre;
  String race;
  String populationReference;
  String cause;
  Deces(
      {required this.date,
      required this.nombre,
      required this.race,
      required this.populationReference,
      required this.cause,
      this.id});
  toJson() {
    return {
      "cause": cause,
      "date": date,
      "nombre": nombre,
      "race": race,
      "populationReference": populationReference,
      "id": id
    };
  }
}
