import 'package:farmges/controller/stock_controller.dart';
import 'package:farmges/controller/transactions_controller.dart';
import 'package:farmges/views/widgets/page_layout.dart';
import 'package:farmges/views/widgets/select_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Historiques extends StatefulWidget {
  @override
  State<Historiques> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historiques> with SelectFieldMixin {
  final options = [
    {
      "label": 'ventes',
      "value": 'ventes',
    },
    {
      "label": 'depenses',
      "value": 'depenses',
    },
    {
      "label": 'deces',
      "value": 'deces',
    }
  ];

  String selectedOption = "ventes";
  List<Map<String, dynamic>> ventes = [];
  List<Map<String, dynamic>> deces = [];
  List<Map<String, dynamic>> depenses = [];

  StockController stock = StockController();
  TransactionsController trans = TransactionsController();
  late TextEditingController monthController;

  getData() async {
    List<Map<String, dynamic>> dep = await trans.getDepenses();
    List<Map<String, dynamic>> vent = await trans.getVentes();
    List<Map<String, dynamic>> dec = await stock.getDeces();

    setState(() {
      ventes = vent;
      depenses = dep;
      deces = dec;
    });
  }

  _HistoriqueState() {
    int thisMonth = DateTime.now().month;
    var month = months.firstWhere((element) => element["value"] == thisMonth);
    monthController = TextEditingController(text: month['label']!.toString());
    getData();
  }

  @override
  final String selectionLabel = 'historique a voir';
  var data = [];
  Widget fieldSelect() {
    return Select(options, onSelected: (String? value) {
      setState(() {
        selectedOption = value!;
      });
    }, largestWidth: false);
  }

  Widget getTable() {
    if (selectedOption == 'depenses') {
      return depensesHistoriqueTable(depenses);
    }
    if (selectedOption == 'deces') {
      return decesHistoriqueTable(deces);
    }
    return ventesHistoriqueTable(ventes);
  }

  final months = [
    {"label": "janvier", "value": 1},
    {"label": "fevrier", "value": 2},
    {"label": "mars", "value": 3},
    {"label": "avril", "value": 4},
    {"label": "mais", "value": 5},
    {"label": "juin", "value": 6},
    {"label": "juillet", "value": 7},
    {"label": "août", "value": 8},
    {"label": "septembre", "value": 9},
    {"label": "octobre", "value": 10},
    {"label": "nomvembre", "value": 11},
    {"label": "decembre", "value": 12},
  ];
  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(
          children: [
            Row(
              children: [
                fieldSelect(),
                SelectField(monthController, months, "choisir un mois",
                    largeWidth: false)
              ],
            ),
            getTable(),
          ],
        ),
        title: const Text("Historiques"),
        showAddButton: false);
  }
}

Widget decesHistoriqueTable(List<Map<String, dynamic>> data) =>
    PaginatedDataTable(
      rowsPerPage: 10,
      columns: const <DataColumn>[
        DataColumn(label: Text("date")),
        DataColumn(label: Text("race")),
        DataColumn(label: Text("nombre")),
        DataColumn(label: Text("date d'arrivee")),
      ],
      source: _DataSource(field: 'deces', data: data),
    );

Widget ventesHistoriqueTable(List<Map<String, dynamic>> data) =>
    PaginatedDataTable(
      rowsPerPage: 10,
      columns: const <DataColumn>[
        DataColumn(label: Text("date")),
        DataColumn(label: Text("race")),
        DataColumn(label: Text("nombre")),
        DataColumn(label: Text("montant")),
      ],
      source: _DataSource(field: 'ventes', data: data),
    );

Widget depensesHistoriqueTable(List<Map<String, dynamic>> data) =>
    PaginatedDataTable(
      rowsPerPage: 10,
      columns: const <DataColumn>[
        DataColumn(label: Text("date")),
        DataColumn(label: Text("montant")),
      ],
      source: _DataSource(field: 'depenses', data: data),
    );

class _DataSource extends DataTableSource {
  final String field;

  final List<Map<String, dynamic>> data;

  _DataSource({required this.field, this.data = const []});

  @override
  DataRow? getRow(int index) {
    var rowData = data[index];
    var columsKeys = <String>[];
    if (field == 'depenses') {
      columsKeys = ["date", "montant"];
    }
    if (field == 'deces') {
      columsKeys = ['date', "race", "nombre", "populationReference"];
    }
    if (field == 'ventes') {
      columsKeys = ['date', "race", "nombre", "montant"];
    }
    return DataRow(
      cells: [
        for (var key in columsKeys) DataCell(Text(rowData[key].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
