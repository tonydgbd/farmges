import 'package:dart_date/dart_date.dart';
import 'package:farmges/controller/stock_controller.dart';
import 'package:farmges/controller/transactions_controller.dart';
import 'package:farmges/models/vente.dart';
import 'package:farmges/views/widgets/date_field.dart';
import 'package:farmges/views/widgets/description_field.dart';
import 'package:farmges/views/widgets/form_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:farmges/views/widgets/nombre_field.dart';
import 'package:farmges/views/widgets/select_field.dart';
import 'package:farmges/views/widgets/submit_btn.dart';

import '../widgets/page_layout.dart';
import '../widgets/race_select.dart';

class AjoutVente extends StatefulWidget {
  @override
  State<AjoutVente> createState() => _AjoutVenteState();
}

class _AjoutVenteState extends State<AjoutVente>
    with
        DateInputMixin,
        DescriptionInputMixin,
        NombreInputMixin,
        RaceSelectMixin {
  DateTime now = DateTime.now();
  TransactionsController controller = Get.find();
  StockController stock = Get.find();
  TextEditingController sommeController = TextEditingController();
  saveVente() async {
    var description = getDescription();
    var nombre = getNombre();
    var race = getRace();
    var montant = double.parse(sommeController.text);
    var vente = Vente(
        date: now,
        description: description,
        race: race,
        nombre: nombre,
        montant: montant,
        provenances: provenances);
    await controller.addVente(vente);
    clear();
    Get.snackbar('Ajout de vente', 'La vente a ete ajoutee avec succes');
  }

  clear() {
    setState(() {
      provenances.clear();
    });
    clearRace();
    clearDescription();
    clearDate();
    clearNombre();
    sommeController.clear();
  }

  List<Map<String, String>> provenances = [];
  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(children: [
          FormCard([
            DateInput(),
            RaceSelect(),
            NombreInput('Nombre de poulets'),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ajouter un prelevement"),
              subtitle: Text("${provenances.length} provenances"),
              onTap: () async {
                var s = await stock.getPopulations();
                List<Map<String, String>> options = [];
                for (var el in s) {
                  DateTime date = el['date_debut'];
                  var sdate = date.format("d MMMM y H:m", "fr_FR");
                  options.add({"label": sdate, "value": sdate});
                }
                Get.defaultDialog(
                    title: "Ajout de prelevement",
                    content:
                        ProvenanceForm(options, (Map<String, String> data) {
                      setState(() {
                        provenances.add(data);
                      });
                    }));
              },
            ),
            NombreInputField(sommeController, "Somme Totale"),
            DescriptionInput(),
            SubmitButton("Enregister", saveVente)
          ])
        ]),
        title: const Text("Ajout de vente"));
  }
}

class ProvenanceForm extends StatelessWidget
    with SelectFieldMixin, NombreInputMixin {
  final List<Map<String, dynamic>> selectionOptions;
  void Function(Map<String, String>) getData;
  ProvenanceForm(this.selectionOptions, this.getData, {super.key});

  String selectionLabel = "Date d'arrivee du lot";
  submit() {
    var data = {
      "date": getSelected().toString(),
      "nombre": getNombre().toString()
    };
    getData(data);
    clear();
  }

  clear() {
    clearNombre();
    clearSelection();
  }

  @override
  Widget build(BuildContext context) {
    return FormCard([
      Select(selectionOptions, largestWidth: false, onSelected: ((p0) {})),
      NombreInput("nombre preleve"),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SubmitButton('Ajouter', submit),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Ok"))
        ],
      )
    ]);
  }
}
