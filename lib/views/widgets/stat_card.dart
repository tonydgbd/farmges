import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget StatCard(String title, int amount) {
  return LayoutBuilder(builder: (context, constraints) {
    return Container(
      width: constraints.maxWidth > 500 ? Get.width * 0.5 : Get.width * 0.8,
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title),
              const Padding(padding: EdgeInsets.all(10)),
              Text("$amount FCFA")
            ],
          ),
        ),
      ),
    );
  });
}
