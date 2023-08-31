class VenteRace {
  String race;
  int nombre;

  toJson() {
    return {"race": race, "nombre": nombre};
  }

  VenteRace(this.race, this.nombre);
  static List<VenteRace> multiple(List<Map<String, dynamic>> data) {
    List<VenteRace> created = [];
    for (final value in data) {
      VenteRace vente = VenteRace(value['race'], value['nombre']);
      created.add(vente);
    }
    return created;
  }
}

class Vente {
  String description;
  DateTime date;
  String race;
  String nombre;

  Vente(
      {required this.date,
      required this.description,
      required this.race,
      required this.nombre});
  toJson() {
    return {
      "description": description,
      "date": date,
      "race": race,
      "nombre": nombre
    };
  }
}
