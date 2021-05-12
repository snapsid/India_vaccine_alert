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
        backgroundColor: Colors.teal,
        title: Text('Enter details'),
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
                onChanged: (value) {},
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
                onPressed: () {},
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
