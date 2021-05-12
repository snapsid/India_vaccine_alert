import 'package:flutter/material.dart';
import 'package:india_vaccine_alert/input.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: 'input',
    routes: {
      'input': (context) => MyInput(),
    },
  ));
}
