import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:india_vaccine_alert/input.dart';
import 'package:locally/locally.dart';

class MyResult extends StatefulWidget {
  @override
  _MyResultState createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  var pincode = "";
  var date = "12-05-21";
  var body1 = "";

  var totalAvailableCount = 0;

  bgService() async {
    try {
      await FlutterBackground.enableBackgroundExecution();
    } catch (e) {
      print(e);
    }
    //
    var androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "Title of the notification",
      notificationText: "Text of the notification",

      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon: AndroidResource(
          name: 'background_icon',
          defType: 'drawable'), // Default is ic_launcher from folder mipmap
    );
    bool success =
        await FlutterBackground.initialize(androidConfig: androidConfig);

    bool hasPermissions = await FlutterBackground.hasPermissions;
  }

  getVac(pin, date) async {
    totalAvailableCount = 0;
    var url = Uri.parse(
        'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=${pincode}&date=${date}');

    try {
      var response = await http.get(url);
      var code = response.statusCode;
      print(code);
      var body = response.body;
      print(body);
      body1 = body;
      var decode = jsonDecode(body);
      var session = [];
      session = decode['sessions'];
      setState(() {
        listCount = session.length;
        print("llllll $listCount");
        if (listCount == 0) {
          myToast("Not available", Colors.red);
          myNoti();
        } else {
          getTotalCount();
          myNoti();
        }
      });
      // parseVac();
    } catch (e) {
      print(e);
    }
  }

  getTotalCount() {
    var session = [];
    var decode = jsonDecode(body1);
    session = decode['sessions'];
    print("lc $listCount");
    for (int i = 0; i < listCount; i++) {
      var availableCapacity1 = session[i]['available_capacity'];
      totalAvailableCount = totalAvailableCount + availableCapacity1.floor();
    }

    print("tttt $totalAvailableCount");

    // myToast("Avaiable: $totalAvailableCount", Colors.teal);
  }

  parseVac(index) {
    var body = body1;
    var session = [];
    var result = body;
    var decode = jsonDecode(result);
    print(decode);
    session = decode['sessions'];
    var sessionCount = session.length;
    print(sessionCount);

    // setState(() {
    //   listCount = sessionCount;
    // });

    if (sessionCount > 0) {
      var centerId1 = session[index]['center_id'].toString();
      var nameCenter1 = session[index]['name'];
      var address1 = session[index]['address'];
      var state1 = session[index]['state_name'];
      var district1 = session[index]['district_name'];
      var block1 = session[index]['block_name'];
      var minAge1 = session[index]['min_age_limit'];
      var availableCapacity1 = session[index]['available_capacity'];
      var vaccineType1 = session[index]['vaccine'];
      var pincode1 = session[index]['pincode'];

      vacType = vaccineType1;
      name = nameCenter1;
      minAge = minAge1;
      address = address1;
      state = state1;
      district = district1;
      pinC = pincode;
      id = centerId1;

      available = availableCapacity1.floor();

      print(available);
      // setState(() {
      //   vacType = vaccineType1;
      //   name = nameCenter1;
      //   minAge = minAge1;
      //   available = availableCapacity1;
      //   print(available);
      // });
      return myListView(
          vacType, available, minAge, name, address, state, district, pinC, id);
    } else {
      print("list count 0");
      return Container(
        alignment: Alignment.center,
        child: Text('Not Available...'),
      );
    }
  }

  myToast(mymsg, color) {
    Fluttertoast.showToast(
        msg: mymsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: color,
        textColor: Colors.white,
        webPosition: "center",
        fontSize: 16.0);
  }

  loopFetch() async {
    // while (1 > 0) {
    //   getVac(pincode, date);
    //   print('heyy');
    //   sleep(Duration(seconds: 5));
    // }
    Future.delayed(Duration(seconds: 5), () {
      getVac(pincode, date);
      print('hey');

      loopFetch();
      // Do something
    });
  }

  @override
  void initState() {
    pincode = MyInput.pincode;
    getVac(pincode, date);

    bgService();

    // TODO: implement initState
    super.initState();
  }

  myNoti() {
    Locally locally = Locally(
      context: context,
      payload: 'test',
      // pageRoute: MaterialPageRoute(builder: (context) => SecondScreen(title: title.text, message: message.text)),
      appIcon: 'mipmap/ic_launcher',
    );

    locally.show(
      title: 'Pincode: $pincode',
      message: 'Total Available: $totalAvailableCount',
    );
  }

  myListView(
      vacType, available, minAge, name, address, state, district, pinC, id) {
    return Card(
      elevation: 5,
      child: Container(
          margin: EdgeInsets.only(left: 30, top: 20, bottom: 20),
          height: 180,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(right: 100),
                child: Column(
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
                      'Name: $name',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Address: $address',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'District: $district $pinC',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'State: $state',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10, right: 20),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Min Age: $minAge',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 10, right: 20),
                  alignment: Alignment.topRight,
                  child: Text(
                    'ID: $id',
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
                        '$available',
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
  var name = "";
  var minAge = 0;
  var available = 0;
  var address = "";
  var state = "";
  var district = "";
  var pinC = "";
  var id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available vaccines'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'input', (route) => false);
              },
            );
          },
        ),
        actions: [
          // IconButton(
          //     icon: Icon(Icons.add),
          //     onPressed: () {
          //       loopFetch();
          //     }),
          // IconButton(
          //     icon: Icon(Icons.play_circle_filled_sharp),
          //     onPressed: () async {
          //       // await FlutterBackground.enableBackgroundExecution();
          //
          //       // loopFetch();
          //     }),
          IconButton(
              icon: Icon(Icons.stop),
              onPressed: () async {
                await FlutterBackground.disableBackgroundExecution();
                // loopFetch();
              }),
          // IconButton(
          //     icon: Icon(Icons.notifications_active),
          //     onPressed: () async {
          //       loopFetch();
          //       await FlutterBackground.enableBackgroundExecution();
          //
          //       // await FlutterBackground.disableBackgroundExecution();
          //       // loopFetch();
          //     }),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                getVac(pincode, date);
              }),
        ],
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: IconButton(
            icon: Icon(Icons.notifications_active),
            onPressed: () async {
              loopFetch();
              await FlutterBackground.enableBackgroundExecution();
              // await FlutterBackground.disableBackgroundExecution();
              // loopFetch();
            }),
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          // controller: scrollcontorller,

          padding: EdgeInsets.only(bottom: 20),
          itemCount: listCount,
          itemBuilder: (BuildContext context, int index) {
            if (listCount == 0) {
              return Container(
                alignment: Alignment.center,
                child: Text('Not Available...'),
              );
            } else {
              print("list count 0");
              return parseVac(index);
            }
          },
        ),
      ),
    );
  }
}
