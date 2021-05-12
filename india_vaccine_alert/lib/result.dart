import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyResult extends StatefulWidget {
  @override
  _MyResultState createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  var pincode = "452001";
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

    setState(() {
      listCount = sessionCount;
    });

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

      setState(() {
        vacType = vaccineType;
      });
      print(minAge);
      print(vaccineType);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  myListView(vacType) {
    return Card(
      elevation: 5,
      child: Container(
          margin: EdgeInsets.only(left: 30, top: 20),
          height: 150,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '$vacType',
                    style: TextStyle(
                        color: Colors.teal,
                        fontSize: 21,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Name:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Address:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'City:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'State:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10, right: 20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Min Age: ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 10, right: 20),
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Available',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        '5',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 28,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )),
            ],
          )),
    );
  }

  var listCount = 0;
  var vacType = "";

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
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          // controller: scrollcontorller,

          padding: EdgeInsets.only(bottom: 20),
          itemCount: listCount,
          itemBuilder: (BuildContext context, int index) {
            return myListView(vacType);
          },
        ),
      ),
    );
  }
}
