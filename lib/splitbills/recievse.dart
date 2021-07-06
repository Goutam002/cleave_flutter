import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/splitbills/home.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:convert';
import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/splitbills/splitgroup.dart';

class RSettlements extends StatefulWidget {
  @override
  _RSettlementsState createState() => _RSettlementsState();
}

class _RSettlementsState extends State<RSettlements> {
  final telephony = Telephony.instance;
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  void initState() {
    super.initState();
    getphone().whenComplete(() {
      gettotal();
    });
  }

  List dataaa = [];
  var payto;
  var phone;
  Future getphone() async {
    var data = {
      'uid': _firebaseServices.getUserId(),
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuserp.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      setState(() {
        if (mounted) {
          phone = json.decode(response.body.toString());
          print(phone);
        }
      });
    }
  }

  Future getpayto({String phn, String id}) async {
    var data = {'phone': phn, 'id': id};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getpay_to.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      dataaa = json.decode(response.body);
      return data;
    }
  }

  List dataa = [];
  bool loading = true;
  var pay;
  Future gettotal() async {
    dynamic data = {"uid": _firebaseServices.getUserId(), 'phone': phone};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getrto.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        loading = false;
        return dataa = json.decode(response.body);
      });
    }
  }

  var uupi;

  Future getupi(String upi) async {
    dynamic data = {
      "uid": upi,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getupi.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        return uupi = json.decode(response.body);
      });
    }
  }

  final SmsSendStatusListener listener = (SendStatus status) {
    // Handle the status
    print(status);
    if (status == SendStatus.SENT) {
      Fluttertoast.showToast(msg: "Message sent");
    } else if (status == SendStatus.DELIVERED) {
      Fluttertoast.showToast(msg: "Message delivered");
    }
  };
  @override
  Widget build(BuildContext context) {
    if (dataa.length == 0) {
      return loading
          ? Scaffold(
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Settlements",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              backgroundColor: Colors.white,
              body: Center(
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 200,
                  height: 200,
                ),
              ))
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Settlements",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              body: Column(
                children: [
                  Image.asset("assets/images/nodata.png"),
                  Text(
                    "You have nothing to pay\n create one",
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
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Splitgrpaa()));
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
                                'Split expenses',
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
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Settlements",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              backgroundColor: Colors.white,
              body: Center(
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 200,
                  height: 200,
                ),
              ))
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Settlements",
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
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 10),
                                  child: GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                          height: 180,
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
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(children: [
                                                  Container(
                                                    height: 45,
                                                    width: 45,
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
                                                  Text(
                                                      "₹ ${item['amount']}\n${item['name']}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.black))
                                                ]),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 30, right: 30),
                                                  child: Divider(),
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      MaterialButton(
                                                        onPressed: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Sttlefinal(
                                                                      reciever: item[
                                                                              'name']
                                                                          .split(
                                                                              " ")
                                                                          .sublist(
                                                                              0,
                                                                              1)
                                                                          .join(
                                                                              ""),
                                                                      amt: item[
                                                                          'amount'],
                                                                      id: item[
                                                                          'id'],
                                                                      expid: item[
                                                                          'exp_id'],
                                                                      refernce:
                                                                          "Recieving from ${item['name'].split(" ").sublist(0, 1).join(" ")}")));
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 100,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .red[900],
                                                                  width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Text("Settle",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        onPressed: () async {
                                                          if (item[
                                                                  'is_member'] ==
                                                              "No") {
                                                            telephony.sendSms(
                                                                to:
                                                                    "${item['phone_no']}",
                                                                message:
                                                                    "Hello ${item['name'].split(" ").sublist(0, 1).join(" ")}, REMINDER:Please settle ₹ ${item['amount']} owed by you to $phone as soon as possible. Download our app to manage your expenses easily and earn rewards.DOWNLOAD NOW!! -Team क्लीve",
                                                                statusListener:
                                                                    listener);
                                                          } else {
                                                            telephony.sendSms(
                                                                to:
                                                                    "${item['phone_no']}",
                                                                message:
                                                                    "Hello ${item['name'].split(" ").sublist(0, 1).join(" ")},\n \nREMINDER:\n Please settle ₹ ${item['amount']} owed by you to $phone as soon as possible.Open your app and settle all your expenses now\n \n-Team क्लीve",
                                                                statusListener:
                                                                    listener);
                                                          }
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 100,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .red[900],
                                                                  width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Text("Remind",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      )
                                                    ]),
                                              ]))),
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

class Sttlefinal extends StatefulWidget {
  final String amt;
  final String refernce;
  final String reciever;
  final String id;
  final String expid;
  Sttlefinal({this.amt, this.refernce, this.reciever, this.expid, this.id});
  @override
  _SttlefinalState createState() => _SttlefinalState();
}

class _SttlefinalState extends State<Sttlefinal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          title: Text(
            "Settle Manually",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text("₹ ${widget.amt}",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800)),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.refernce,
                style: TextStyle(fontSize: 19.2, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/avatarb.png"))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(widget.reciever.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: AssetImage("assets/images/paying.png"))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/avatarb.png"))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("You",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              MaterialButton(
                onPressed: () async {
                  showBarModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          height: 180,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text("Do you want to proceed?",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                height: 35,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                      onPressed: () async {
                                        settle();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Splithomepage()),
                                            (Route<dynamic> route) => false);
                                        Fluttertoast.showToast(
                                            msg:
                                                "Payment Successful\n Amount settled");
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.indigo[900],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text("Proceed",
                                              style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              )))),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.indigo[900],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text("Go back",
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ))),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    margin: EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Settle",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ))),
              )
            ],
          ),
        ));
  }

  var phone;
  Future settle() async {
    var data = {
      'id': widget.id,
      'exp': widget.expid,
      'amt': widget.amt,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/settle.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      setState(() {
        if (mounted) {
          return response.body;
        }
      });
    }
  }
}
