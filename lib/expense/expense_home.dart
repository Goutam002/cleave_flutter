import 'dart:convert';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/auth/register.dart';
import 'package:kaia/chat/groups.dart';
import 'package:kaia/expense/expensehome.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kaia/expense/offers.dart';
import 'package:kaia/splitbills/home.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share/share.dart';

final Color activeColor = Color(0xffFF2E63);
final Color inactiveColor = Color(0xff6C73AE);

class ExpenseHome extends StatefulWidget {
  @override
  _ExpenseHomeState createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  var date;
  var ptno;
  bool timer = true;
  bool loaddd = true;
  var update;
  bool loada = true;
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
          loada = false;
        });
        return points = json.decode(response.body);
      }
    } else {
      print("error");
    }
  }

  bool load = true;
  TextEditingController descController = TextEditingController();
  // ignore: unused_field
  final FirebaseServices _firebaseServices = FirebaseServices();

  Future fetchData(String uid) async {
    try {
      dynamic data = {"uid": _firebaseServices.getUserId()};
      var response = await http.post(
          Uri.parse('https://kaiaexp.000webhostapp.com/auth/getu.php'),
          body: json.encode(data),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.isNotEmpty) {
          var dataaa = json.decode(response.body);
          return dataaa;
        }
      } else {
        print("error");
      }
    } catch (e) {
      print("connection problem");
    }
  }

  Future uupi(String upi) async {
    try {
      dynamic data = {"uid": _firebaseServices.getUserId(), "upi": upi};
      var response = await http.post(
          Uri.parse('https://kaiaexp.000webhostapp.com/auth/u_upi.php'),
          body: json.encode(data),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.isNotEmpty) {
          update = json.decode(response.body);
          return update;
        }
      } else {
        print("error");
      }
    } catch (e) {
      print("connection problem");
    }
  }

  share(BuildContext context) async {
    await Share.share(
        "Hey, download this fantastic app and manage your daily life expenses at one go. Get rewarded too.\nDownload now",
        subject: 'Download kaia-your expense app');
  }

  RewardedAd reward;
  @override
  void initState() {
    fetchpoints();
    getdatept().whenComplete(() {
      getptno().whenComplete(() {
        DateTime now = DateTime.now();
        DateFormat dateFormat = DateFormat("dd MMMM,yyyy");
        var datee = dateFormat.format(now).toString();
        if ("$datee" == date) {
          getptno();
        } else if ("$datee" != date) {
          updateptno();
        }
      });
    });
    super.initState();
  }
  Future getdatept() async {
    try {
      dynamic data = {'uid': _firebaseServices.getUserId()};
      var response = await http.post(
          Uri.parse('https://kaiaexp.000webhostapp.com/auth/getdate.php'),
          body: json.encode(data),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.isNotEmpty) {
          date = json.decode(response.body).toString();
          return date;
        }
      } else {
        print("error");
      }
    } catch (e) {
      print("connection problem");
    }
  }

  Future getptno() async {
    try {
      dynamic data = {'uid': _firebaseServices.getUserId()};
      var response = await http.post(
          Uri.parse('https://kaiaexp.000webhostapp.com/auth/get_ptno.php'),
          body: json.encode(data),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.isNotEmpty) {
          ptno = json.decode(response.body);
          return ptno;
        }
      } else {
        print("error");
      }
    } catch (e) {
      print("connection problem");
    }
  }

  Future updateptno() async {
    try {
      DateTime now = DateTime.now();
      DateFormat dateFormat = DateFormat("dd MMMM,yyyy");
      var dateee = dateFormat.format(now);
      dynamic data = {
        'uid': _firebaseServices.getUserId(),
        "ptno": '0',
        "date": dateee.toString()
      };
      var response = await http.post(
          Uri.parse('https://kaiaexp.000webhostapp.com/auth/updatep.php'),
          body: json.encode(data),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.isNotEmpty) {
          ptno = json.decode(response.body);
          return ptno;
        }
      } else {
        print("error");
      }
    } catch (e) {
      print("connection problem");
    }
  }

  @override
  Widget build(BuildContext context) {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 18000;

    void onEnd() {
      print('onEnd');
      setState(() {
        timer = true;
      });
    }

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
                            builder: (context) => ExpenseHome()));
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
      return loaddd
          ? Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: 70,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    ),
                    GestureDetector(
                      onTap: () {
                        showBarModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return FutureBuilder(
                                  future:
                                      fetchData(_firebaseServices.getUserId()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 45,
                                          ),
                                          Container(
                                            height: 110,
                                            width: 110,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/avatarb.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            snapshot.data['name'],
                                            style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            snapshot.data['gmail_id'],
                                            style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data['phone_no'],
                                            style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          ListTile(
                                            onTap: () {
                                              showBarModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    if (snapshot
                                                        .data['upi_address']
                                                        .toString()
                                                        .isEmpty) {
                                                      return Container(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 35,
                                                            ),
                                                            Text(
                                                              "Add your upi address",
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 50,
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25,
                                                                        right:
                                                                            25),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        descController,
                                                                    // ignore: missing_return
                                                                    validator:
                                                                        // ignore: missing_return
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Please add your upi address';
                                                                      }
                                                                    },
                                                                    cursorColor:
                                                                        Colors
                                                                            .black,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 2)),
                                                                      border: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 2)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 1)),
                                                                      fillColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hintText:
                                                                          "abcd@kaia",
                                                                      hintStyle: TextStyle(
                                                                          color: Colors.grey[
                                                                              400],
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            24.0,
                                                                        vertical:
                                                                            15.0,
                                                                      ),
                                                                    ),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              height: 40,
                                                            ),
                                                            MaterialButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (descController
                                                                      .text
                                                                      .isEmpty) {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                "Please add you upi address");
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      load =
                                                                          false;
                                                                    });
                                                                    await uupi(
                                                                        descController
                                                                            .text);
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                "🎊 Updated 🎊");
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width: 80,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: load
                                                                      ? Text(
                                                                          "Add",
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  17,
                                                                              fontWeight: FontWeight
                                                                                  .w900,
                                                                              color: Colors
                                                                                  .white))
                                                                      : Image.asset(
                                                                          ("assets/images/gi.gif"),
                                                                          fit: BoxFit
                                                                              .fitHeight),
                                                                )),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                  "*We do not verify user's upi address. Please check it twice before adding it to your account and start accepting payments.",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          500],
                                                                      fontSize:
                                                                          12),
                                                                ))
                                                          ],
                                                        ),
                                                      );
                                                    } else {
                                                      return Container(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 35,
                                                            ),
                                                            Text(
                                                              "Your previous UPI address",
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            Text(
                                                              snapshot.data[
                                                                  'upi_address'],
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Colors
                                                                      .red[900],
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "\nChange:",
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25,
                                                                        right:
                                                                            25),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        descController,
                                                                    // ignore: missing_return
                                                                    validator:
                                                                        // ignore: missing_return
                                                                        (value) {
                                                                      if (value
                                                                          .isEmpty) {
                                                                        return 'Please add your upi address';
                                                                      }
                                                                    },
                                                                    cursorColor:
                                                                        Colors
                                                                            .black,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 2)),
                                                                      border: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 2)),
                                                                      focusedBorder: OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 1)),
                                                                      fillColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hintText:
                                                                          "abcd@kaia",
                                                                      hintStyle: TextStyle(
                                                                          color: Colors.grey[
                                                                              400],
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            24.0,
                                                                        vertical:
                                                                            15.0,
                                                                      ),
                                                                    ),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                )),
                                                            SizedBox(
                                                              height: 40,
                                                            ),
                                                            MaterialButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (descController
                                                                      .text
                                                                      .isEmpty) {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                "Please add you upi address");
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      load =
                                                                          false;
                                                                    });
                                                                    await uupi(
                                                                        descController
                                                                            .text);
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                "🎊 Updated 🎊");
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                ExpenseHome()));
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width: 100,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: load
                                                                      ? Text(
                                                                          "Change",
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  17,
                                                                              fontWeight: FontWeight
                                                                                  .w900,
                                                                              color: Colors
                                                                                  .white))
                                                                      : Image.asset(
                                                                          ("assets/images/gi.gif"),
                                                                          fit: BoxFit
                                                                              .fitHeight),
                                                                )),
                                                            SizedBox(
                                                              height: 30,
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                  "*We do not verify user's upi address. Please check it twice before adding it to your account and start accepting payments.",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          500],
                                                                      fontSize:
                                                                          12),
                                                                ))
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  });
                                            },
                                            title: Text(
                                              "Manage Upi",
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            leading: Container(
                                                height: 40,
                                                width: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo[100],
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.payment_outlined,
                                                  color: Colors.black,
                                                  size: 25,
                                                )),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                              size: 14,
                                            ),
                                          ),
                                          Divider(),
                                          ListTile(
                                            onTap: () => share(context),
                                            title: Text(
                                              "Share",
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            leading: Container(
                                                height: 40,
                                                width: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo[100],
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.share_outlined,
                                                  color: Colors.black,
                                                  size: 25,
                                                )),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                              size: 14,
                                            ),
                                          ),
                                          Divider(),
                                          ListTile(
                                            onTap: () {},
                                            title: Text(
                                              "Support",
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            leading: Container(
                                                height: 40,
                                                width: 40,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.indigo[100],
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.support_agent_outlined,
                                                  color: Colors.black,
                                                  size: 25,
                                                )),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.black,
                                              size: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 60,
                                          ),
                                          MaterialButton(
                                              onPressed: () {
                                              
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Register1()));
                                              },
                                              child: Container(
                                                child: Text("Log Out",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color:
                                                            Colors.red[900])),
                                              ))
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: Image.asset(
                                          "assets/images/gi.gif",
                                          width: 200,
                                          height: 200,
                                        ),
                                      );
                                    }
                                  });
                            });
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: AssetImage("assets/images/avatarb.png"),
                                fit: BoxFit.fill)),
                      ),
                    )
                  ],
                ),
              ),
              body: SingleChildScrollView(
                  child: Column(children: [
                
                Container(

                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                    decoration: BoxDecoration(
                      color: Colors.indigo[0],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: loada
                                      ? Colors.indigo[50]

                                      : Colors.red[900],
                                  borderRadius: BorderRadius.circular(150),
                                ),
                                alignment: Alignment.center,
                                child: loada
                                    ? Center(
                                        child: Image.asset(
                                          "assets/images/gi.gif",
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 0.0),
                                                    child: Text(
                                                      'K',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Text(
                                                    'points',
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  )
                                                ]),
                                          ]))
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                    ])),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 20, right: 10),
                  margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                  decoration: BoxDecoration(
                    color: Color(0xFF9cffca),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: timer
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                child: Text(
                                  "Earn\nextra points",
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                            MaterialButton(
                              onPressed: () async {
                                setState(() {
                                  loaddd = false;
                                });
                                await RewardedAd.load(
                                    adUnitId:
                                        "ca-app-pub-3940256099942544/5224354917",
                                    request: AdRequest(),
                                    rewardedAdLoadCallback:
                                        RewardedAdLoadCallback(
                                      onAdLoaded: (RewardedAd ad) {
                                        Fluttertoast.showToast(
                                            msg: "Add loaded");
                                        print('$ad loaded.');
                                        // Keep a reference to the ad so you can show it later.
                                        setState(() {
                                          reward = ad;
                                        });
                                        reward.show(onUserEarnedReward:
                                            (RewardedAd ad,
                                                RewardItem rewardItem) {
                                          setState(() {
                                            loaddd = true;
                                            timer = false;
                                          });
                                          showBarModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                    height: 200,
                                                    child: Column(
                                                      children: [
                                                        Text("Wohoo",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[900],
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800)),
                                                        Text(
                                                            "You got extra k-points",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800)),
                                                      ],
                                                    ));
                                              });
                                        });
                                      },
                                      onAdFailedToLoad: (LoadAdError error) {
                                        setState(() {
                                          loaddd = true;
                                        });
                                        Fluttertoast.showToast(
                                            msg:
                                                'RewardedAd failed to load: $error');
                                        print(
                                            'RewardedAd failed to load: $error');
                                      },
                                    ));
                              },
                              child: Text(
                                "Get now",
                                style: TextStyle(
                                    color: Colors.red[900],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800),
                              ),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                child: Text(
                                  "Earn\nextra points",
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                                CountdownTimer(
                          endTime: endTime,
                          onEnd: onEnd,
                          textStyle: TextStyle(
                                      color: Colors.red[900],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,)
                        )]),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          offset: const Offset(0, 0),
                          blurRadius: 20,
                          spreadRadius: 2.0,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) => Grids(
                              index: index,
                            ))),              
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  padding: EdgeInsets.all(10),
                  child: Swiper(
                    itemBuilder: (ctx, idx) => Card(
                      indexb: idx,
                    ),
                    curve: Curves.ease,
                    pagination: new SwiperPagination(
                      builder: SwiperPagination.rect,
                    ),
                    itemCount: cardList.length,
                  ),
                ), SizedBox(
                  height: 20,
                ),
                 Container(
                    height: 50,
                   alignment: Alignment.center,
                   padding: EdgeInsets.only(left: 20,right: 20),
                    margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          offset: const Offset(0, 0),
                          blurRadius: 20,
                          spreadRadius: 2.0,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                      Text("Have any queries",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,)),
                      IconButton(icon: Image.asset("assets/images/send.png",width: 27,), onPressed: null)
                    ],),
                            ),
              ])))
          : Scaffold(
              body: Center(
              child:
                  Image.asset(("assets/images/gi.gif"), fit: BoxFit.fitHeight),
            ));
    });
  }
}

//Styling

class Cards {
  String image;
  String name;
  double amount;
  int cardNumber;

  Cards({this.amount, this.cardNumber, this.image, this.name});
}

List<Cards> cardList = [
  Cards(
    image: "assets/images/card1.png",
    amount: 4500.87,
    cardNumber: 4536,
    name: "Master Card",
  ),
  Cards(
    image: "assets/images/card2.png",
    amount: 532.71,
    cardNumber: 8137,
    name: "Visa Card",
  ),
];

// ignore: must_be_immutable
class Card extends StatelessWidget {
  int indexb;

  Card({this.indexb});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 600,
      padding: EdgeInsets.only(bottom: 0, left: 0, right: 0, top: 0),
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(cardList[indexb].image),
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }
}

class Grid {
  String image;
  String name;
  final Function onpressed;
  Grid({this.image, this.name, this.onpressed});
}

List<Grid> gridaList = [
  Grid(
      image: "assets/images/expense.png",
      name: "Expense",
      onpressed: () => Expensehomepage()),
      Grid(
    image: "assets/images/split.png",
    name: "Split",
  ),
  Grid(
    image: "assets/images/debt.png",
    name: "Drop-In",
  ),
  
  Grid(
    image: "assets/images/reward.png",
    name: "Rewards",
  ),
];

// ignore: must_be_immutable
class Grids extends StatelessWidget {
  int index;

  Grids({this.index});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MaterialButton(
          onPressed: () {
            if (gridaList[index].name == 'Expense') {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Expensehomepage()));
            }
            if (gridaList[index].name == 'Split') {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Splithomepage()));
            }
            if (gridaList[index].name == 'Rewards') {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>Offerspage()));
            }
             if (gridaList[index].name == 'Drop-In') {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>Dropin()));
            }
          },
          child: Container(
            padding: EdgeInsets.all(0),
              child: Column(children: [
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: Colors.white,
              ),
              height: 32,
              width: 32,
              child: Image.asset(
                gridaList[index].image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 0),
              child: Text(
                gridaList[index].name,
                maxLines: 1,
                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700),
              ),
            )
          ])))
    ]);
  }
}
