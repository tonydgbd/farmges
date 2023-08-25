import 'package:farmges/controller/core_controllers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(CoreController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      title: 'Gestion de ferme',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  TextEditingController raceController = TextEditingController();
  TextEditingController nbrController = TextEditingController();
  DateTime selected_date = DateTime.now();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.defaultDialog(
          //     content: Container(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         DropdownMenu(
          //             width: Get.width * 0.5,
          //             controller: raceController,
          //             label: Text("Choisir la race"),
          //             dropdownMenuEntries: [
          //               ...(CoreController.instance.data['races'] as List).map(
          //                   (e) => DropdownMenuEntry(
          //                       value: e['nom_de_races'],
          //                       label: e['nom_de_races']))
          //             ]),
          //         TextField(
          //           controller: nbrController,
          //           keyboardType: TextInputType.number,
          //           decoration: InputDecoration(
          //               labelText: "Nombre de poulet",
          //               border: OutlineInputBorder()),
          //         ),
          //         Text("Selectioner la date du Jour 0"),
          //         DatePickerDialog(
          //             currentDate: selected_date,
          //             initialEntryMode: DatePickerEntryMode.inputOnly,
          //             initialDate: DateTime.now(),
          //             firstDate: DateTime.now(),
          //             lastDate: DateTime.now().copyWith(year: 2025)),
          //         CupertinoButton(
          //             child: Text("Ajouter"),
          //             onPressed: () {
          //               CoreController.instance.addPopulation(
          //                   int.parse(nbrController.text),
          //                   raceController.text,
          //                   selected_date);
          //             })
          //       ],
          //     ),
          //   ),
          // ));
          CoreController.instance
              .addPopulation(100, "bleu d'hollandes", DateTime.now());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
