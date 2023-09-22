class Depense {
  DateTime date;
  String montant;
  String description;
  String? id;

  Depense(
      {required this.date,
      required this.montant,
      required this.description,
      this.id});

  toJson() {
    return {"date": date, "montant": montant, "description": description};
  }
}
