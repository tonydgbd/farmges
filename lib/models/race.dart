typedef JsonData = Map<String, dynamic>;
typedef JsonDataList = List<JsonData>;

class Vaccin {
  String nom_vaccin;
  DateTime date_debut;
  int nombre_jours;

  Vaccin(
      {required this.nom_vaccin,
      required this.date_debut,
      required this.nombre_jours});

  JsonData toJson() {
    return {
      "nom_vaccin": nom_vaccin,
      "date_debut": date_debut,
      "nombre_jours": nombre_jours
    };
  }

  static JsonDataList multipleVaccinsToJson(List<Vaccin> data) {
    JsonDataList res = [];
    for (Vaccin vaccin in data) {
      res.add(vaccin.toJson());
    }
    return res;
  }
}

class Aliment {
  String nom_aliment;
  DateTime date_debut;
  int nombre_jours;
  Aliment(
      {required this.date_debut,
      required this.nom_aliment,
      required this.nombre_jours});

  JsonData toJson() {
    return {
      "date_debut": date_debut,
      "nom_aliment": nom_aliment,
      "nombre_jours": nombre_jours
    };
  }

  static JsonDataList multipleAlimentsToJson(List<Aliment> data) {
    JsonDataList res = [];
    for (Aliment al in data) {
      res.add(al.toJson());
    }
    return res;
  }
}

class Vitamine {
  String nom_vitamine;
  DateTime date_debut;
  int nombre_jours;
  Vitamine(
      {required this.date_debut,
      required this.nom_vitamine,
      required this.nombre_jours});

  JsonData toJson() {
    return {
      "date_debut": date_debut,
      "nom_vitamine": nom_vitamine,
      "nombre_jours": nombre_jours
    };
  }

  static JsonDataList multipleVitaminesToJson(List<Vitamine> data) {
    JsonDataList res = [];
    for (Vitamine vit in data) {
      res.add(vit.toJson());
    }
    return res;
  }
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

  toJson() {
    return {
      "nom_de_race": nom_de_race,
      "vaccins": Vaccin.multipleVaccinsToJson(vaccins),
      "aliments": Aliment.multipleAlimentsToJson(aliments),
      "vitamines": Vitamine.multipleVitaminesToJson(vitamines),
      "etapes": [],
    };
  }
}
