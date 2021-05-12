import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyResult extends StatefulWidget {
  @override
  _MyResultState createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  getVac(pin, date) async {
    var url = Uri.parse(
        'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=457001&date=12-05-21');

    try {
      var response = await http.get(url);
      var code = response.statusCode;
      print(code);
      var body = response.body;
      print(body);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available vaccines'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                getVac(45, 44);
              })
        ],
        backgroundColor: Colors.teal,
      ),
    );
  }
}
