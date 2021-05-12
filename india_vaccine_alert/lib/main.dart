import 'package:flutter/material.dart';
import 'package:india_vaccine_alert/input.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'input',
    routes: {
      'input': (context) => MyInput(),
    },
  ));
}
