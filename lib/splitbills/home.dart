import 'dart:convert';
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/splitbills/addgrpa.dart';
import 'package:kaia/splitbills/fchat.dart';
import 'package:kaia/splitbills/groupsa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/splitbills/recievse.dart';
import 'package:kaia/splitbills/settle.dart';
import 'package:kaia/splitbills/splitgroup.dart';
import 'package:kaia/splitbills/transactions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

final Color activeColor = Color(0xffFF2E63);
final Color inactiveColor = Color(0xff6C73AE);

class Splithomepage extends StatefulWidget {
  @override
  _SplithomepageState createState() => _SplithomepageState();
}

class _SplithomepageState extends State<Splithomepage> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  int selectedPosition = 0;
  List<Widget> listBottomWidget = [];
  String phone;
  var ress;

  @override
  void initState() {
    super.initState();

    getphone();
    print(phone);
    addHomePage();
  }

  void getphone() async {
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

  var pay;
  Future gettotal() async {
    dynamic data = {"uid": _firebaseServices.getUserId(), "phone": phone};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getpay.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (json.decode(response.body) == null) {
        setState(() {
          if (mounted) {
            return pay = "0";
          }
        });
      } else {
        setState(() {
          if (mounted) {
            return pay = "₹ ${json.decode(response.body).toString()}";
          }
        });
      }
    } else {
      print("error");
    }
  }

  var recieve;
  Future gettotala() async {
    dynamic data = {"uid": _firebaseServices.getUserId(), "phone": phone};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getpay.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (json.decode(response.body) == null) {
        setState(() {
          if (mounted) {
            return recieve = "0";
          }
        });
      } else {
        setState(() {
          if (mounted) {
            return recieve = "₹ ${json.decode(response.body).toString()}";
          }
        });
      }
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.call_split_outlined), label: "Split"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Groups"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page), label: "Transactions"),
        ],
        currentIndex: selectedPosition,
        iconSize: 20,
        selectedFontSize: 13,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        onTap: (position) {
          setState(() {
            selectedPosition = position;
          });
        },
      ),
      body: Builder(builder: (context) {
        return listBottomWidget[selectedPosition];
      }),
    );
  }

  void addHomePage() {
    listBottomWidget.add(Splithome());
    listBottomWidget.add(Groupsa(
      phone: phone,
    ));
    listBottomWidget.add(Transactions());
  }
}

class Splithome extends StatefulWidget {
  @override
  _SplithomeState createState() => _SplithomeState();
}

class _SplithomeState extends State<Splithome> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  void initState() {
    super.initState();
    getphone().whenComplete(() {
      gettotal();
      gettotala();
    });
  }

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

  var pay;
  Future gettotal() async {
    dynamic data = {"uid": _firebaseServices.getUserId(), 'phone': phone};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getpay.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (json.decode(response.body) == null) {
        setState(() {
          if (mounted) {
            return pay = "0";
          }
        });
      } else {
        setState(() {
          if (mounted) {
            return pay = "₹ ${json.decode(response.body).toString()}";
          }
        });
      }
    } else {
      print("error");
    }
  }

  var recieve;
  Future gettotala() async {
    dynamic data = {"uid": _firebaseServices.getUserId(), 'phone': phone};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getrecieve.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (json.decode(response.body) == null) {
        setState(() {
          if (mounted) {
            return recieve = "0";
          }
        });
      } else {
        setState(() {
          if (mounted) {
            return recieve = "₹ ${json.decode(response.body).toString()}";
          }
        });
      }
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 60,
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
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Nunito'),
                ),
              ],
            ),
          ),
          body: Column(children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 60,
                    width: 500,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Color(0xFF9cffca),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(pay == null ? "Loading" : "You will pay\n$pay",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settlements()));
                            },
                            child: Text("Pay",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 60,
                    width: 500,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        color: Color(0xFF9cffca),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            recieve == null
                                ? "Loading..."
                                : "You will receive\n$recieve",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        MaterialButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RSettlements()));
                            },
                            child: Text("Settle",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  height: 50,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.orange[200],
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.transparent, width: 1)),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white),
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.transparent, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Friends",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.transparent, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Groups",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Padding(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 15),
                      child: Getfriends()),
                  // second tab bar viiew widget
                  Padding(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 15),
                      child: Groupsmain())
                ],
              ),
            )
          ]),
          floatingActionButton: MaterialButton(
            onPressed: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 150,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Addgrpa()));
                            },
                            title: Text(
                              'Create Group',
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Splitgrpaa(
                                        paidby: "You",
                                        username: "d",
                                      )));
                            },
                            title: Text(
                              'Split Expense',
                              style: TextStyle(
                                  color: Colors.red[900],
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
                height: 40,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.transparent)),
                child: Text("Create",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.black))),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}

class Getfriends extends StatefulWidget {
  @override
  _GetfriendsState createState() => _GetfriendsState();
}

class _GetfriendsState extends State<Getfriends> {
  List data = [];
  var delete;
  bool load = true;
  final FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: FutureBuilder(
          future: fetchData(_firebaseServices.getUserId()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                    child: Text("😢 Uhho, You have no friends connected yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        )));
              } else {
                return Container(height:300,
                child:
                ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: ListTile(
                          
                            onTap: () async {
                              fetchexp(snapshot.data[index]['id'])
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Fchat(
                                            snapshot.data[index]['name'],
                                            value,
                                            "assets/images/avatarb.png",
                                            snapshot.data[index]['id'])));
                              });
                            },
                            minVerticalPadding: 20,
                            focusColor: Colors.indigo[100],
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/avatarb.png"))),
                            ),
                            title: Row(children: [
                              Text("${snapshot.data[index]['name']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                              SizedBox(
                                width: 20,
                              ),
                              if (snapshot.data[index]['uid'] ==
                                  snapshot.data[index]['s_uid'])
                                Container(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 5, bottom: 5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.orange[50],
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Text("You",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black)))
                              else
                                Text("")
                            ]),
                           
                            ));
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider());
                  },
                ));
              }
            } else {
              return Center(
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 150,
                  height: 150,
                ),
              );
            }
          },
        ));
  }

  Future fetchData(String uid) async {
    dynamic data = {"uid": _firebaseServices.getUserId()};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/group/getfriend.php'),
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
  }
}

Future fetchexp(String id) async {
  var dat = {
    'id': id,
  };
  var response = await http.post(
      Uri.parse('https://kaiaexp.000webhostapp.com/split/getsplitfriend.php'),
      body: json.encode(dat),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    print(response.body);
    if (response.body.isNotEmpty) {
       // ignore: unused_local_variable
       List data = [];
      return data = json.decode(response.body);
    }
  } else {
    print("error");
  }
}
