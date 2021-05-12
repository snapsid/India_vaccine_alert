import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyResult extends StatefulWidget {
  @override
  _MyResultState createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  var pincode = "457001";
  var date = "12-05-21";
  getVac(pin, date) async {
    var url = Uri.parse(
        'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=${pincode}&date=${date}');

    try {
      var response = await http.get(url);
      var code = response.statusCode;
      print(code);
      var body = response.body;
      print(body);
      parseVac(body);
    } catch (e) {
      print(e);
    }
  }

  parseVac(body) {
    var session = [];
    var result = body;
    var decode = jsonDecode(result);
    print(decode);
    session = decode['sessions'];
    var sessionCount = session.length;
    print(sessionCount);

    if (sessionCount > 0) {
      var centerId = session[0]['center_id'];
      var nameCenter = session[0]['name'];
      var address = session[0]['address'];
      var state = session[0]['state_name'];
      var district = session[0]['district_name'];
      var block = session[0]['block_name'];
      var minAge = session[0]['min_age_limit'];
      var availableCapacity = session[0]['available_capacity'];
      var vaccineType = session[0]['vaccine'];

      print(minAge);
      print(vaccineType);
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
                getVac(pincode, date);
              })
        ],
        backgroundColor: Colors.teal,
      ),
    );
  }
}
