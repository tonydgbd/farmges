class Population {
  DateTime date_debut;
  int population;
  String race;

  Population(
      {required this.date_debut, required this.population, required this.race});

  toJson() {
    return {"date_debut": date_debut, "population": population, "race": race};
  }
}
