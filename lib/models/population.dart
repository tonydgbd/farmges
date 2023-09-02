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
}

class Deces {
  String? id;
  DateTime date;
  int nombre;
  String race;
  String populationReference;
  String description;
  Deces(
      {required this.date,
      required this.nombre,
      required this.race,
      required this.populationReference,
      required this.description,
      this.id});
  toJson() {
    return {
      "date": date,
      "nombre": nombre,
      "race": race,
      "populationReference": populationReference,
      "id": id
    };
  }
}
