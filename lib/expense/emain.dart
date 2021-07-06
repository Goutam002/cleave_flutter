import 'dart:convert';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:kaia/expense/addexp.dart';
import 'package:kaia/expense/allexpense.dart';
import 'package:kaia/auth/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/expense/expensehome.dart';
import 'package:kaia/expense/qrscan.dart';
import 'package:kaia/expense/upi.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Expensemain extends StatefulWidget {
  final String totalmonth;
  Expensemain({this.totalmonth});
  @override
  _ExpensemainState createState() => _ExpensemainState();
}

class _ExpensemainState extends State<Expensemain> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  String totala = "Click Here";
  String totalab = "Click Here";

  @override
  void initState() {
    gettotalm();
    super.initState();
  }

  Future gettotalm() async {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("MMMM,yy");
    String date = dateFormat.format(now);
    dynamic data = {"uid": _firebaseServices.getUserId(), "month": date};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/get_month.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (json.decode(response.body) == null) {
        setState(() {
          return totala = "₹ 0";
        });
      } else {
        setState(() {
          return totala = "₹ ${json.decode(response.body).toString()}";
        });
      }
    } else {
      print("error");
    }
  }

  var ress;
  Future gettotal() async {
    dynamic data = {"uid": _firebaseServices.getUserId()};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/get_total.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (json.decode(response.body) == null) {
        setState(() {
          return ress = "0";
        });
      } else {
        setState(() {
          return ress = "₹ ${json.decode(response.body).toString()}";
        });
      }
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
      if (connectivity == ConnectivityResult.none) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset("assets/images/nointernet.png",
                          width: 250, height: 250)),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'No Internet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                        fontSize: 21),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please check your internet connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (connectivity == ConnectivityResult.none) {
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Expensehomepage()));
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 130,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Try Again",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                    ),
                  )
                ]));
      } else {
        return child;
      }
    }, builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "क्लीve",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QRViewExample()));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo[200],
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Image.asset(
                                        "assets/images/scan.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Upimanual()));
                                    },
                                    child: Container(
                                        height: 40,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
border: Border.all(color: Colors.indigo[900]),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text("Scan your code")),
                                  ),
                                ],
                              ),
                            ));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                                        height: 40,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.orange[50],
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Text("Scan your code",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),)),
                ),

            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(height: 20),
            GestureDetector(
                onTap: () async {
                  setState(() {
                    totala = "Loading...";
                  });
                  await gettotalm();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 60,
                    width: 500,
                    padding: EdgeInsets.only(left: 1, right: 1),
                    decoration: BoxDecoration(
                        color: Colors.red[800],
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 20,
                              spreadRadius: 10)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Monthly Expense",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        Text(" ${totala.toString()}",
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white))
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Latest Expenses",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: MaterialButton(
                      onPressed: () async {
                        await gettotal();
                        if (ress == null) {
                          Fluttertoast.showToast(msg: 'error');
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Allexp(
                                    total: ress.toString(),
                                  )));
                        }
                      },
                      child: Container(
                        child: Text("All",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.red[900])),
                      ))),
            ]),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                color: Colors.black,
                height: 3,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  child: Latestexpense(),
                ))
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Addexpense()));
          },
          backgroundColor: Colors.black,
          splashColor: Colors.black,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
