import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

Widget PageLayout(Widget child,
    {Widget title = const Text("Gestion de ferme")}) {
  return Scaffold(
    appBar: AppBar(
      title: title,
    ),
    drawer: DrawerMenu(),
    body: child,
  );
}
