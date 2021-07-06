import 'dart:convert';
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/splitbills/contactzs.dart';
import 'package:kaia/splitbills/groupsa.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class Addgrpa extends StatefulWidget {
  String friend1;
  String friend2;
  String friend3;
  String friend4;
  String friend5;
  String friend6;
  String friend7;
  String fphone1;
  String fphone2;
  String fphone3;
  String fphone4;
  String fphone5;
  String fphone6;
  String fphone7;
  String name;
  String avtar;
  Addgrpa(
      {this.fphone1,
      this.fphone2,
      this.fphone3,
      this.fphone4,
      this.fphone5,
      this.fphone6,
      this.fphone7,
      this.friend1,
      this.friend2,
      this.friend3,
      this.friend4,
      this.friend5,
      this.friend6,
      this.friend7,
      this.avtar,
      this.name});
  @override
  _AddgrpaState createState() => _AddgrpaState();
}

class _AddgrpaState extends State<Addgrpa> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  GlobalKey<FormState> _productFormKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  String avtar;
  bool selecteda = false;
  bool sb = false;
  bool sc = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.name;
    });
    if (widget.friend1 == null) {
      setState(() {
        widget.friend1 = "Select Friend";
      });
    }
    if (widget.friend2 == null) {
      setState(() {
        widget.friend2 = "Select Friend";
      });
    }
    if (widget.friend3 == null) {
      setState(() {
        widget.friend3 = "Select Friend";
      });
    }
    if (widget.friend4 == null) {
      setState(() {
        widget.friend4 = "Select Friend";
      });
    }
    if (widget.friend5 == null) {
      setState(() {
        widget.friend5 = "Select Friend";
      });
    }
    if (widget.friend6 == null) {
      setState(() {
        widget.friend6 = "Select Friend";
      });
    }
    if (widget.friend7 == null) {
      setState(() {
        widget.friend7 = "Select Friend";
      });
    }
  }

  bool loading = false;
  String datauser;
  String lastid;
  String name;
  String phone;
  String ismema;
  String ismemb;
  String ismemc;
  String ismemd;
  String ismeme;
  String ismemf;
  String ismemg;
  var resvalue;
  String friend1;
  String fphone1 = "";
  String friend2;
  String fphone2 = "";
  String friend3;
  String fphone3 = "";
  String friend4;
  String fphone4 = "";
  String friend5;
  String fphone5 = "";
  String friend6;
  String fphone6 = "";
  String friend7;
  String fphone7 = "";
  Future senddata() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/group_create.php');
// Store all data with Param Name.
    var data = {
      'name': nameController.text,
      'avatar': avtar,
      'uid': _firebaseServices.getUserId(),
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
      setState(() {
        lastid = messagea;
      });
    }
  }

  Future sendpyou() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/create_members.php');
// Store all data with Param Name.
    var data = {
      'is_mem': 'yes',
      'uid': _firebaseServices.getUserId(),
      'grp_id': lastid,
      'name': name,
      'phone': phone
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future getname(
    String uid,
  ) async {
    var data = {
      'uid': uid,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuser.php'),
        body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        name = json.decode(response.body);
      });
    }
    return response.body;
  }

  Future getphone(
    String uid,
  ) async {
    var data = {
      'uid': uid,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuserp.php'),
        body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        phone = json.decode(response.body.toString());
      });
    }
    return response.body;
  }

  Future sendpad(
    String phone,
    String ismem,
  ) async {
    var data = {
      'phone': phone,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuserd.php'),
        body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.body);
      if (ismem == 'a') {
        setState(() {
          ismema = json.decode(response.body) ;
        });
      }
      if (ismem == 'b') {
        setState(() {
          ismemb = json.decode(response.body);
        });
      }
      if (ismem == 'c') {
        setState(() {
          ismemc = json.decode(response.body);
        });
      }
      if (ismem == 'd') {
        setState(() {
          ismemd =json.decode(response.body) ;
        });
      }
      if (ismem == 'e') {
        setState(() {
          ismeme = json.decode(response.body);
        });
      }
      if (ismem == 'f') {
        setState(() {
          ismemf = json.decode(response.body);
        });
      }
      if (ismem == 'g') {
        setState(() {
          ismemg = json.decode(response.body);
        });
      }
    }
    return response.body;
  }

  Future sendpa() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/create_members.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismema == "No"?"No":"Yes",
      'uid': ismema == "No"?"": ismema,
      'grp_id': lastid,
      'name': widget.friend1,
      'phone': widget.fphone1
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpb() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/create_members.php');
// Store all data with Param Name.
    var data = {
       'is_mem': ismemb == "No"?"No":"Yes",
      'uid': ismemb == "No"?"": ismemb,
      'grp_id': lastid,
      'name': widget.friend2,
      'phone': widget.fphone2
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpc() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/create_members.php');
// Store all data with Param Name.
    var data = {
       'is_mem': ismemc == "No"?"No":"Yes",
      'uid': ismemc == "No"?"": ismemc,
      'grp_id': lastid,
      'name': widget.friend3,
      'phone': widget.fphone3
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpd() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/create_members.php');
// Store all data with Param Name.
    var data = {
       'is_mem': ismemd == "No" ?"No":"Yes",
      'uid': ismemd == "No"? "": ismemd,
      'grp_id': lastid,
      'name': widget.friend4,
      'phone': widget.fphone4
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpe() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/create_members.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismeme == "No"?"No":"Yes",
      'uid': ismeme == "No"?"": ismeme.toString(),
      'grp_id': lastid,
      'name': widget.friend5,
      'phone': widget.fphone5
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpf() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/create_members.php');
// Store all data with Param Name.
    var data = {
        'is_mem': ismemf == "No"?"No":"Yes",
      'uid': ismemf == "No"?"": ismemf.toString(),
      'grp_id': lastid,
      'name': widget.friend6,
      'phone': widget.fphone6
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpg() async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/group/create_members.php');
// Store all data with Param Name.
    var data = {
     'is_mem': ismemg == "No"?"No":"Yes",
      'uid': ismemg == "No"?"":ismemg.toString(),
      'grp_id': lastid,
      'name': widget.friend7,
      'phone': widget.fphone7,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F8FF),
        elevation: 0,
        title: Text("Add Group"),
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _productFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(" Group Name",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600))),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          controller: nameController,
                          cursorColor: Colors.black,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a group name';
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1)),
                            fillColor: Colors.white,
                            hintText: "Expense...",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 10.0,
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text("Select Avatar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600))),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        selecteda
                            ? MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    avtar = 'assets/images/avatara.png';
                                    print(avtar);
                                  });
                                },
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Colors.red[900], width: 5),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/avatara.png"))),
                                ))
                            : MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    avtar = 'assets/images/avatara.png';
                                    selecteda = true;
                                    sb = false;
                                    sc = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Avatar Selected");
                                },
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/avatara.png"))),
                                )),
                        SizedBox(
                          width: 15,
                        ),
                        sb
                            ? MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    avtar = 'assets/images/avatarb.png';
                                  });
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Colors.red[900], width: 5),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/avatarb.png"))),
                                ))
                            : MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    avtar = 'assets/images/avatarb.png';
                                    selecteda = false;
                                    sb = true;
                                    sc = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Avatar Selected");
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/avatarb.png"))),
                                )),
                        SizedBox(
                          width: 15,
                        ),
                        sc
                            ? MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    avtar = 'assets/images/avatarc.png';
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Avatar Selected");
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Colors.red[900], width: 5),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/avatarc.png"))),
                                ))
                            : MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    avtar = 'assets/images/avatarc.png';
                                    sc = true;
                                    selecteda = false;
                                    sb = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Avatar Selected");
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/avatarc.png"))),
                                )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('You',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.friend1.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Contactssss(
                                                id: "1",
                                                friend1: widget.friend1,
                                                friend2: widget.friend2,
                                                friend3: widget.friend3,
                                                friend4: widget.friend4,
                                                friend5: widget.friend5,
                                                friend6: widget.friend6,
                                                friend7: widget.friend7,
                                                fphone1: widget.fphone1,
                                                fphone2: widget.fphone2,
                                                fphone3: widget.fphone3,
                                                fphone4: widget.fphone4,
                                                fphone5: widget.fphone5,
                                                fphone6: widget.fphone6,
                                                fphone7: widget.fphone7,
                                                name: nameController.text,
                                                avtar: avtar,
                                              )));
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.red[900]),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.friend2.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Contactssss(
                                                id: "2",
                                                friend1: widget.friend1,
                                                friend2: widget.friend2,
                                                friend3: widget.friend3,
                                                friend4: widget.friend4,
                                                friend5: widget.friend5,
                                                friend6: widget.friend6,
                                                friend7: widget.friend7,
                                                fphone1: widget.fphone1,
                                                fphone2: widget.fphone2,
                                                fphone3: widget.fphone3,
                                                fphone4: widget.fphone4,
                                                fphone5: widget.fphone5,
                                                fphone6: widget.fphone6,
                                                fphone7: widget.fphone7,
                                                name: nameController.text,
                                                avtar: avtar,
                                              )));
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.red[900]),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.friend3.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Contactssss(
                                                id: "3",
                                                friend1: widget.friend1,
                                                friend2: widget.friend2,
                                                friend3: widget.friend3,
                                                friend4: widget.friend4,
                                                friend5: widget.friend5,
                                                friend6: widget.friend6,
                                                friend7: widget.friend7,
                                                fphone1: widget.fphone1,
                                                fphone2: widget.fphone2,
                                                fphone3: widget.fphone3,
                                                fphone4: widget.fphone4,
                                                fphone5: widget.fphone5,
                                                fphone6: widget.fphone6,
                                                fphone7: widget.fphone7,
                                                name: nameController.text,
                                                avtar: avtar,
                                              )));
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.red[900]),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.friend4.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Contactssss(
                                                id: "4",
                                                friend1: widget.friend1,
                                                friend2: widget.friend2,
                                                friend3: widget.friend3,
                                                friend4: widget.friend4,
                                                friend5: widget.friend5,
                                                friend6: widget.friend6,
                                                friend7: widget.friend7,
                                                fphone1: widget.fphone1,
                                                fphone2: widget.fphone2,
                                                fphone3: widget.fphone3,
                                                fphone4: widget.fphone4,
                                                fphone5: widget.fphone5,
                                                fphone6: widget.fphone6,
                                                fphone7: widget.fphone7,
                                                name: nameController.text,
                                                avtar: avtar,
                                              )));
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.red[900]),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.friend5.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Contactssss(
                                                id: "5",
                                                friend1: widget.friend1,
                                                friend2: widget.friend2,
                                                friend3: widget.friend3,
                                                friend4: widget.friend4,
                                                friend5: widget.friend5,
                                                friend6: widget.friend6,
                                                friend7: widget.friend7,
                                                fphone1: widget.fphone1,
                                                fphone2: widget.fphone2,
                                                fphone3: widget.fphone3,
                                                fphone4: widget.fphone4,
                                                fphone5: widget.fphone5,
                                                fphone6: widget.fphone6,
                                                fphone7: widget.fphone7,
                                                name: nameController.text,
                                                avtar: avtar,
                                              )));
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.red[900]),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.friend6.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Contactssss(
                                                id: "6",
                                                friend1: widget.friend1,
                                                friend2: widget.friend2,
                                                friend3: widget.friend3,
                                                friend4: widget.friend4,
                                                friend5: widget.friend5,
                                                friend6: widget.friend6,
                                                friend7: widget.friend7,
                                                fphone1: widget.fphone1,
                                                fphone2: widget.fphone2,
                                                fphone3: widget.fphone3,
                                                fphone4: widget.fphone4,
                                                fphone5: widget.fphone5,
                                                fphone6: widget.fphone6,
                                                fphone7: widget.fphone7,
                                                name: nameController.text,
                                                avtar: avtar,
                                              )));
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.red[900]),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.friend7.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => Contactssss(
                                                id: "7",
                                                friend1: widget.friend1,
                                                friend2: widget.friend2,
                                                friend3: widget.friend3,
                                                friend4: widget.friend4,
                                                friend5: widget.friend5,
                                                friend6: widget.friend6,
                                                friend7: widget.friend7,
                                                fphone1: widget.fphone1,
                                                fphone2: widget.fphone2,
                                                fphone3: widget.fphone3,
                                                fphone4: widget.fphone4,
                                                fphone5: widget.fphone5,
                                                fphone6: widget.fphone6,
                                                fphone7: widget.fphone7,
                                                name: nameController.text,
                                                avtar: avtar,
                                              )));
                                },
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: Colors.red[900]),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text("*You can select max 7 people and min 1 friend",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.indigo[500],
                            fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ))),
      bottomNavigationBar: GestureDetector(
          onTap: () async {
            if (_productFormKey.currentState.validate()) {
              if (avtar == null) {
                Fluttertoast.showToast(msg: 'Please select an avatar');
              } else {
                setState(() {
                  loading = true;
                });
                await senddata();
                await getname(_firebaseServices.getUserId());
                await getphone(_firebaseServices.getUserId());
                await sendpyou();
                if (widget.friend1 == 'Select Friend') {
                } else {
                  await sendpad(widget.fphone1, 'a');
                  await sendpa();
                }
                if (widget.friend2 == 'Select Friend') {
                } else {
                  await sendpad(widget.fphone2, 'b');
                  await sendpb();
                }
                if (widget.friend3 == 'Select Friend') {
                } else {
                  await sendpad(widget.fphone3, 'c');
                  await sendpc();
                }
                if (widget.friend4 == 'Select Friend') {
                } else {
                  await sendpad(widget.fphone4, 'd');
                  await sendpd();
                }
                if (widget.friend5 == 'Select Friend') {
                } else {
                  await sendpad(widget.fphone5, 'e');
                  await sendpe();
                }
                if (widget.friend6 == 'Select Friend') {
                } else {
                  await sendpad(widget.fphone6, 'f');
                  await sendpf();
                }
                if (widget.friend7 == 'Select Friend') {
                } else {
                  await sendpad(widget.fphone7, 'g');
                  await sendpg();
                }

                Fluttertoast.showToast(msg: "Group created");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Groupsa()));
              }
            } else {
              Fluttertoast.showToast(msg: 'Please fill all details');
            }
          },
          child: loading
              ? Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/gi.gif"),
                        fit: BoxFit.fitHeight),
                    color: Colors.indigo,
                  ),
                )
              : Container(
                  height: 60,
                  color: Colors.red[900],
                  alignment: Alignment.center,
                  child: Text(
                    "Add Group",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                )),
    );
  }
}
