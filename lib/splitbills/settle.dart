import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/splitbills/home.dart';
import 'package:kaia/splitbills/recievse.dart';
import 'package:kaia/splitbills/splitgroup.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class Settlements extends StatefulWidget {
  @override
  _SettlementsState createState() => _SettlementsState();
}

class _SettlementsState extends State<Settlements> {
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
        Uri.parse('https://kaiaexp.000webhostapp.com/split/payment.php'),
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
                                'Create groups',
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
                                      left: 20, right: 20, bottom: 15),
                                  child: GestureDetector(
                                      onTap: () async {},
                                      child: Container(
                                        height: 100,
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
                                              MaterialButton(
                                                onPressed: () async {
                                                  await getpayto(
                                                          id: item['exp_id'],
                                                          phn: item['pay_to'])
                                                      .whenComplete(() {
                                                    if (dataaa[index]
                                                            ['is_member'] ==
                                                        "No") {
                                                      showBarModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/images/payment.png",
                                                                    width: 300,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 50,
                                                                  ),
                                                                  Text(
                                                                      "₹ ${item['amount']}\n Paying to: ${dataaa[index]['name']}",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              22,
                                                                          color:
                                                                              Colors.black)),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            40,
                                                                        right:
                                                                            40),
                                                                    child:
                                                                        Divider(),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  MaterialButton(
                                                                      onPressed:
                                                                          null,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            45,
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                80,
                                                                            right:
                                                                                80),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.red[900],
                                                                            border: Border.all(color: Colors.red[900], width: 2),
                                                                            borderRadius: BorderRadius.circular(12)),
                                                                        child: Text(
                                                                            "Settle Manually",
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 18,
                                                                                color: Colors.white)),
                                                                      ))
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    } else {
                                                      showBarModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/images/payment.png",
                                                                    width: 300,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 50,
                                                                  ),
                                                                  Text(
                                                                      "₹ ${item['amount']}\n Paying to: ${dataaa[index]['name']}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              26,
                                                                          color:
                                                                              Colors.black)),
                                                                  Text(
                                                                      "${item['pay_to']}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.black)),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            40,
                                                                        right:
                                                                            40),
                                                                    child:
                                                                        Divider(),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 25,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                    children: [
                                                                      MaterialButton(
                                                                          onPressed:
                                                                              () async {
                                                                            await getupi(item['is_member']).whenComplete(() {
                                                                              if (uupi == '') {
                                                                                showBarModalBottomSheet(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return Container();
                                                                                    });
                                                                              } else {
                                                                                launch("upi://pay?pa=$uupi&pn=${dataaa[index]['name']}&tn='क्लीve'&cu=INR&am=${item['amount']}").whenComplete(() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Splithomepage())));
                                                                              }
                                                                              
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                100,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.red[900],
                                                                                border: Border.all(color: Colors.red[900], width: 2),
                                                                                borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                Text("UPI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                                                                          )),
                                                                      MaterialButton(
                                                                          onPressed: () async {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => Sttlefinal(
                                                                      reciever: dataaa[index]['name']
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
                                                                      expid:item[
                                                                          'exp_id'],
                                                                      refernce:
                                                                          "Paying to ${dataaa[index]['name'].split(" ").sublist(0, 1).join(" ")}")));
                                                        
                                                                              },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                50,
                                                                            width:
                                                                                100,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.red[900],
                                                                                border: Border.all(color: Colors.red[900], width: 2),
                                                                                borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                Text("Manual", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                                                                          ))
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 80,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.red[900],
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Text("Settle",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black)),
                                                ),
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
