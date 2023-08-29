class Vaccin {
  String nom_vaccin;
  DateTime date_debut;
  int nbr_jr;

  Vaccin(
      {required this.nom_vaccin,
      required this.date_debut,
      required this.nbr_jr});
}

class Aliment {
  String nom_aliment;
  DateTime date_debut;
  int nbr_jr;
  Aliment(
      {required this.date_debut,
      required this.nom_aliment,
      required this.nbr_jr});
}

class Vitamine {
  String nom_vitamine;
  DateTime date_debut;
  int nbr_jr;
  Vitamine(
      {required this.date_debut,
      required this.nom_vitamine,
      required this.nbr_jr});
}

class Race {
  String nom_de_race;
  List<Vaccin> vaccins;
  List<Aliment> aliments;
  List<Vitamine> vitamines;
  List<String> etapes;

  Race(
      {required this.nom_de_race,
      required this.vaccins,
      required this.aliments,
      required this.vitamines,
      required this.etapes});
}
