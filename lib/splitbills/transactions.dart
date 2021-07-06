import 'dart:convert';
import 'package:kaia/auth/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kaia/splitbills/splitgroup.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List dataa = [];
  List data = [];
  bool loading = true;
  var phone;
  bool load = true;
  @override
  void initState() {
    super.initState();
    getphone().whenComplete(() {
      fetchData();
    });
  }

  Future fetchexpmem(String grp) async {
    var dat = {
      'grpid': grp,
    };

    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getsplitmem.php'),
        body: json.encode(dat),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        setState(() {
          load = false;
        });
        return data = json.decode(response.body);
      }
    } else {
      print("error");
    }
  }

  Future getphone() async {
    var data = {
      'uid': _firebaseServices.getUserId(),
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuserp.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        if (mounted) {
          return phone = json.decode(response.body.toString());
        }
      });
    }
  }

  FirebaseServices _firebaseServices = FirebaseServices();
  Future fetchData() async {
    var data = {'phone': phone};

    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/gettransact.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        print(response.body);
        if (response.body.isNotEmpty) {
          return dataa = json.decode(response.body);
        }
      });
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataa.length == 0) {
      return loading
          ? Scaffold(
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Color(0xFFF7F8FF),
                  elevation: 0,
                  title: Text(
                    "Transactions",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              backgroundColor: Color(0xFFF7F8FF),
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 100,
                  height: 100,
                ),
              ))
          : Scaffold(
              backgroundColor: Color(0xFFF7F8FF),
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Color(0xFFF7F8FF),
                  elevation: 0,
                  title: Text(
                    "Transactions",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              body: Column(
                children: [
                  Image.asset("assets/images/nodata.png"),
                  Text(
                    "You have no recent transactions\n create one",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context)=>Splitgrpaa()));
                        },
                        color: Colors.indigo[900],
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(9))),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Split Expense',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Colors.indigo[500],
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ));
    } else {
      return loading
          ? Scaffold(
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Color(0xFFF7F8FF),
                  elevation: 0,
                  title: Text(
                    "Transactions",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              backgroundColor: Color(0xFFF7F8FF),
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 100,
                  height: 100,
                ),
              ))
          : Scaffold(
              backgroundColor: Color(0xFFF7F8FF),
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Color(0xFFF7F8FF),
                  elevation: 0,
                  title: Text(
                    "Transactions",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              body: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: loading == false
                          ? ListView.builder(
                              itemCount: dataa.length,
                              itemBuilder: (BuildContext context, index) {
                                final item = dataa[index];
                                DateTime now =
                                    DateTime.parse(item['timestamp']);
                                DateFormat dateFormat =
                                    DateFormat("dd MMMM,yyyy\nhh:MM");
                                DateFormat dateformat =
                                    DateFormat("dd MMMM,yyyy");
                                var date = dateFormat.format(now);
                                var datte = dateformat.format(now);

                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 15),
                                  child: GestureDetector(
                                      onTap: () async {
                                        await fetchexpmem(item['id']);
                                        showBarModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text("₹ ${item['amount']}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 35,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text(item['description'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    Text("${item['splittype']}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    Text(
                                                        "Paid by: ${item['paid_by']}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    Text(datte,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 30, right: 30),
                                                      child: Divider(),
                                                    ),
                                                    Expanded(
                                                        child: ListView.builder(
                                                            itemCount:
                                                                data.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    index) {
                                                              final ite =
                                                                  data[index];
                                                              return Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15,
                                                                        top: 5,
                                                                        bottom:
                                                                            5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                  color: Colors
                                                                      .indigo[50],
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        "${ite['name']}\n₹ ${ite['amount']}",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w700)),
                                                                    Text(
                                                                        ite['settlement'] ==
                                                                                'done'
                                                                            ? "Settled"
                                                                            : "Due",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.red[700],
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w800))
                                                                  ],
                                                                ),
                                                              );
                                                            })),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    MaterialButton(
                                                        onPressed: null,
                                                        child: Container(
                                                            width: 200,
                                                            height: 55,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .red[900],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          150),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Settle Payments",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            )))
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: Container(
                                        height: 80,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey[200],
                                              offset: const Offset(0, 0),
                                              blurRadius: 10,
                                              spreadRadius: 2.0,
                                            )
                                          ],
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "assets/images/avatarb.png"))),
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                  Text("₹ ${item['amount']}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black))
                                                ],
                                              ),
                                              Text(
                                                date,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              )
                                            ]),
                                      )),
                                );
                              })
                          : Center(
                              child: Image.asset(
                                "assets/images/gi.gif",
                                width: 200,
                                height: 200,
                              ),
                            ))
                ],
              ),
            );
    }
  }
}
