import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget StatCard({children, Color color = Colors.white}) {
  return LayoutBuilder(builder: (context, constraints) {
    return Container(
      // color: color,
      width: constraints.maxWidth > 500 ? Get.width * 0.5 : Get.width * 0.8,
      height: 200,
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
      ),
    );
  });
}
