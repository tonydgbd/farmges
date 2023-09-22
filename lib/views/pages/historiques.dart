import 'package:farmges/controller/stock_controller.dart';
import 'package:farmges/controller/transactions_controller.dart';
import 'package:farmges/views/widgets/page_layout.dart';
import 'package:farmges/views/widgets/select_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Historiques extends StatefulWidget {
  const Historiques({super.key});

  @override
  State<Historiques> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historiques> with SelectFieldMixin {
  int month = DateTime.now().month;
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

  StockController stock = Get.find();
  TransactionsController trans = Get.find();
  late TextEditingController monthController;
  TextEditingController fieldController = TextEditingController(text: "ventes");

  getData() async {
    if (selectedOption == 'depenses') {
      List<Map<String, dynamic>> dep = await trans.getDepenses(month: month);
      setState(() {
        depenses = dep;
      });
    }
    if (selectedOption == 'ventes') {
      List<Map<String, dynamic>> vent = await trans.getVentes(month: month);
      setState(() {
        ventes = vent;
      });
    }
    if (selectedOption == 'deces') {
      List<Map<String, dynamic>> dec = await stock.getDeces(month: month);
      setState(() {
        deces = dec;
      });
    }
  }

  _HistoriqueState() {
    int thisMonth = DateTime.now().month;
    var month = months.firstWhere((element) => element["value"] == thisMonth);
    monthController = TextEditingController(text: month['label']!.toString());
    getData();
  }

  var data = [];
  Widget fieldSelect() {
    String selectionLabel = 'historique a voir';
    return Expanded(
        child: SelectField(
      fieldController,
      options,
      selectionLabel,
      largeWidth: false,
      onSelected: (String? value) {
        setState(() {
          selectedOption = value!;
        });

        getData();
      },
    ));
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
    {"label": "novembre", "value": 11},
    {"label": "decembre", "value": 12},
  ];

  Widget monthSelect() {
    return Expanded(
        child: SelectField(monthController, months, "choisir un mois",
            largeWidth: false, onSelected: (value) async {
      if (value!.isNotEmpty && int.parse(value) != month) {
        setState(() {
          var p = int.parse(value);
          month = p;
        });
        await getData();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        ListView(
          children: [
            Row(
              children: [
                fieldSelect(),
                monthSelect(),
              ],
            ),
            getTable(),
          ],
        ),
        title: const Text("Historiques"),
        showAddButton: false);
  }
}

Widget decesHistoriqueTable(List<Map<String, dynamic>> data) => data.isNotEmpty
    ? PaginatedDataTable(
        rowsPerPage: 10,
        columns: const <DataColumn>[
          DataColumn(label: Text("date de deces")),
          DataColumn(label: Text("race")),
          DataColumn(label: Text("nombre de deces")),
          DataColumn(label: Text("date d'arrivee")),
        ],
        source: _DataSource(field: 'deces', data: data),
      )
    : EmptyDataMessage;

Widget ventesHistoriqueTable(List<Map<String, dynamic>> data) => data.isNotEmpty
    ? PaginatedDataTable(
        rowsPerPage: 10,
        columns: const <DataColumn>[
          DataColumn(label: Text("date de la vente")),
          DataColumn(label: Text("race")),
          DataColumn(label: Text("nombre vendu")),
          DataColumn(label: Text("montant de la vente")),
        ],
        source: _DataSource(field: 'ventes', data: data),
      )
    : EmptyDataMessage;

Widget depensesHistoriqueTable(List<Map<String, dynamic>> data) =>
    data.isNotEmpty
        ? PaginatedDataTable(
            rowsPerPage: 10,
            columns: const <DataColumn>[
              DataColumn(label: Text("date de depense")),
              DataColumn(label: Text("montant depense")),
            ],
            source: _DataSource(field: 'depenses', data: data),
          )
        : EmptyDataMessage;

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

Widget EmptyDataMessage = const Center(
  child: Padding(
    padding: EdgeInsets.all(20),
    child: Text("Aucune donne pour ce moiss"),
  ),
);
