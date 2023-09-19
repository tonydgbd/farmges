enum EtapeCroissance {
  demarrage(nombreJours: 21, aliment: '', etape: "demarrage"),
  croissance(nombreJours: 26, aliment: '', etape: "croissance"),
  finalisation(nombreJours: 56, aliment: '', etape: "finalisation");

  final int nombreJours;
  final String aliment;
  final String etape;
  const EtapeCroissance(
      {required this.nombreJours, required this.aliment, required this.etape});
}
