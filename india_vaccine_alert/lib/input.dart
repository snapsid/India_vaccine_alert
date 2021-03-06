import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  static String pincode = "";
  @override
  _MyInputState createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Vaccine Alert'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  MyInput.pincode = value;
                },
                decoration: InputDecoration(
                    filled: true,
                    hintText: "Enter pincode",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.teal,
              elevation: 5,
              child: MaterialButton(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (MyInput.pincode != "") {
                    // Navigator.pushNamed(context, 'result');
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'result', (route) => false);
                  }
                },
                minWidth: 130,
                height: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
