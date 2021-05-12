import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter details'),
      ),
    );
  }
}
