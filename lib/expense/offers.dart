import 'dart:convert';
import 'package:kaia/auth/firebase_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Offerspage extends StatefulWidget {
  @override
  _OfferspageState createState() => _OfferspageState();
}

class _OfferspageState extends State<Offerspage> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  @override
  void initState() {
    fetchpoints();
    super.initState();
  }

  bool load = true;
  String points = '0';
  Future fetchpoints() async {
    dynamic data = {"uid": _firebaseServices.getUserId()};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getpoints.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        setState(() {
          load = false;
        });
        return points = json.decode(response.body);
      }
    } else {
      print("error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFFFFFFFF),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 0, right: 10),
                  child: IconButton(
                      icon: Image.asset(
                        "assets/images/arrow.png",
                        width: 20,
                      ),
                      iconSize: 15,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    'Kaia',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.black),
                  ),
                ),
                Text(
                  'points',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                )
              ]),
            ],
          ),
          toolbarHeight: 70,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 200,
                  height: 55,
                  decoration: BoxDecoration(
                    color: load ? Colors.indigo[50] : Colors.red[900],
                    borderRadius: BorderRadius.circular(150),
                  ),
                  alignment: Alignment.center,
                  child: load
                      ? Center(
                          child: Image.asset(
                            "assets/images/gi.gif",
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                "$points ",
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'K',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      'points',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white),
                                    )
                                  ]),
                            ]))
            ]),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider()),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rewards",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      IconButton(
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: Colors.red[900],
                            size: 30,
                          ),
                          onPressed: () => showBarModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.black,
                              barrierColor: Colors.black.withOpacity(0.8),
                              enableDrag: true,
                              builder: (BuildContext context) {
                                return Container(
                                    height: 400,
                                    color: Color(0xFFfffbf2),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    alignment: Alignment.center,
                                    child: Column(children: [
                                      Image.asset(
                                        "assets/images/sorry.jpg",
                                        width: 250,
                                        height: 250,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Kaia rewards program will start soon.\nAs of now your points are recorded, so that you dont miss your rewards. Thank you for the cooperation\n- Team Kaia",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]));
                              }))
                    ])),
            SizedBox(
              height: 70,
            ),
            Image.asset(
              "assets/images/rr.png",
              fit: BoxFit.fitHeight,
              width: 200,
              height: 200,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Coming Soon...",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ));
  }
}
