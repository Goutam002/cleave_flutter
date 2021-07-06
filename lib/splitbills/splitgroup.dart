import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/splitbills/contactzs.dart';
import 'package:kaia/splitbills/home.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Splitgrpaa extends StatefulWidget {
  String paidby;
  String friend1;
  String friend2;
  String friend3;
  String friend4;
  String amt;
  String desc;
  String friend5;
  String friend6;
  String friend7;
  String fphone1;
  String fphone2;
  String grpid;
  String fphone3;
  String fphone4;
  String fphone5;
  String fphone6;
  String fphone7;
  String friend8;
  String fphone8;
  String username;
  List splitdata;
  Splitgrpaa(
      {this.paidby,
      this.fphone1,
      this.grpid,
      this.fphone2,
      this.fphone3,
      this.fphone4,
      this.fphone5,
      this.fphone6,
      this.splitdata,
      this.fphone7,
      this.friend1,
      this.friend2,
      this.friend3,
      this.friend4,
      this.friend5,
      this.friend6,
      this.friend7,
      this.username,
      this.fphone8,
      this.friend8,
      this.amt,
      this.desc});
  @override
  _SplitgrpaaState createState() => _SplitgrpaaState();
}

class _SplitgrpaaState extends State<Splitgrpaa> {
  FirebaseServices _firebaseServices = FirebaseServices();

  var points;
  var lastid;
  String splittype = "Equally";
  @override
  void initState() {
    super.initState();
    print(widget.paidby);
    setState(() {
      if (widget.amt != null) {
        amtController.text = widget.amt;
      }
      if (widget.desc != null) {
        descController.text = widget.desc;
      }
    });
  }

  Future fetchpoints() async {
    dynamic data = {"uid": _firebaseServices.getUserId()};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getpoints.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        return points = json.decode(response.body);
      }
    } else {
      print("error");
    }
  }

  String ismema;
  String ismemb;
  String ismemc;
  String ismemd;
  String ismeme;
  String ismemf;
  String ismemg;
  String ismemh;
  String fa;
  String fb;
  String fc;
  String fd;
  String fe;
  String ff;
  String fg;
  String fh;
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
          ismema = json.decode(response.body);
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
          ismemd = json.decode(response.body);
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
      if (ismem == 'h') {
        setState(() {
          ismemh = json.decode(response.body);
        });
      }
    }
    return response.body;
  }

  Future getFriend(String phone, String f) async {
    var data = {
      'uid': _firebaseServices.getUserId(),
      'phone': phone,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getfriendslist.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      print(response.body);
      if (f == 'a') {
        setState(() {
          fa = json.decode(response.body);
        });
      }
      if (f == 'b') {
        setState(() {
          fb = json.decode(response.body);
        });
      }
      if (f == 'c') {
        setState(() {
          fc = json.decode(response.body);
        });
      }
      if (f == 'd') {
        setState(() {
          fd = json.decode(response.body);
        });
      }
      if (f == 'e') {
        setState(() {
          fe = json.decode(response.body);
        });
      }
      if (f == 'f') {
        setState(() {
          ff = json.decode(response.body);
        });
      }
      if (f == 'g') {
        setState(() {
          fg = json.decode(response.body);
        });
      }
      if (f == 'h') {
        setState(() {
          fh = json.decode(response.body);
        });
      }
    }
    return response.body;
  }

  Future sendpa(String fid) async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_amt.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismema,
      'exp_id': lastid,
      'name': widget.friend1,
      'phone_no': widget.fphone1,
      'amount': splittype == "Equally" ? splt.toString() : amt1Controller.text,
      'pay_to': widget.paidby == widget.fphone1 ? "" : widget.paidby,
      'settlement': widget.paidby == widget.fphone1 ? "done" : "due",
      'friendno': fa == "No" ? fid : fa,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpb(String fid) async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_amt.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismemb,
      'exp_id': lastid,
      'name': widget.friend2,
      'phone_no': widget.fphone2,
      'amount': splittype == "Equally" ? splt.toString() : amt2Controller.text,
      'pay_to': widget.paidby == widget.fphone2 ? "" : widget.paidby,
      'settlement': widget.paidby == widget.fphone2 ? "done" : "due",
      'friendno': fb == "No" ? fid : fb,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpc(String fid) async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_amt.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismemc,
      'exp_id': lastid,
      'name': widget.friend3,
      'phone_no': widget.fphone3,
      'amount': splittype == "Equally" ? splt.toString() : amt3Controller.text,
      'pay_to': widget.paidby == widget.fphone3 ? "" : widget.paidby,
      'settlement': widget.paidby == widget.fphone3 ? "done" : "due",
      'friendno': fc == "No" ? fid : fc,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpd(String fid) async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_amt.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismemd,
      'exp_id': lastid,
      'name': widget.friend4,
      'phone_no': widget.fphone4,
      'amount': splittype == "Equally" ? splt.toString() : amt4Controller.text,
      'pay_to': widget.paidby == widget.fphone4 ? "" : widget.paidby,
      'settlement': widget.paidby == widget.fphone4 ? "done" : "due",
      'friendno': fd == "No" ? fid : fd,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpe(String fid) async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_amt.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismeme,
      'exp_id': lastid,
      'name': widget.friend5,
      'phone_no': widget.fphone5,
      'amount': splittype == "Equally" ? splt.toString() : amt5Controller.text,
      'pay_to': widget.paidby == widget.fphone5 ? "" : widget.paidby,
      'settlement': widget.paidby == widget.fphone5 ? "done" : "due",
      'friendno': fe == "No" ? fid : fe,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpf(String fid) async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_amt.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismemf,
      'exp_id': lastid,
      'name': widget.friend6,
      'phone_no': widget.fphone6,
      'amount': splittype == "Equally" ? splt.toString() : amt6Controller.text,
      'pay_to': widget.paidby == widget.fphone6 ? "" : widget.paidby,
      'settlement': widget.paidby == widget.fphone6 ? "done" : "due",
      'friendno': ff == "No" ? fid : ff,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendpg(String fid) async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_amt.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismemg.toString(),
      'exp_id': lastid,
      'name': widget.friend7,
      'phone_no': widget.fphone7,
      'amount': splittype == "Equally" ? splt.toString() : amt7Controller.text,
      'pay_to': widget.paidby == widget.fphone7 ? "" : widget.paidby,
      'settlement': widget.paidby == widget.fphone7 ? "done" : "due",
      'friendno': fg == "No" ? fid : fg,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future sendph(String fid) async {
    // SERVER API URL
    var url =
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_amt.php');
// Store all data with Param Name.
    var data = {
      'is_mem': ismemh.toString(),
      'exp_id': lastid.toString(),
      'name': widget.friend8,
      'phone_no': widget.fphone8,
      'amount': splittype == "Equally" ? splt.toString() : amt8Controller.text,
      'pay_to': widget.paidby == widget.fphone8 ? "" : widget.paidby,
      'settlement': widget.paidby == widget.fphone8 ? "done" : "due",
      'friendno': fh == "No" ? fid : fh,
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  String lastidd;
  Future createfriend(String name, String phone, String suid) async {
    /// User data
    dynamic data = {
      "name": name,
      "phone": phone,
      "uid": suid,
      "suid": _firebaseServices.getUserId(),
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/createfriend.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        lastidd = json.decode(response.body).toString();
      });
      print(lastidd);
      return json.decode(response.body).toString();
    } else {
      print("error");
    }
  }

  Future putexpdata() async {
    /// User data
    dynamic data = {
      "amount": amtController.text.toString(),
      "grp_id": widget.grpid.toString(),
      "splittype": splittype,
      "desc": descController.text.toString(),
      "paid_by": widget.paidby,
      "points": "1",
      "uid": _firebaseServices.getUserId(),
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/create_exp.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        lastid = json.decode(response.body);
      });
      print(lastid);
      return lastid;
    } else {
      print("error");
    }
  }

  Future putexpdataa() async {
    /// User data
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("MMMM,yy");
    var date = dateFormat.format(now);
    dynamic data = {
      "amount": amtController.text.toString(),
      "desc": descController.text,
      "paid_by": "Cash",
      "month": date,
      "points": "1",
      "uid": _firebaseServices.getUserId(),
      "img_path": null
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/create_exp.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        return response.body;
      });
    } else {
      print("error");
    }
  }

  bool adding = true;
  var spt;
  String splt;
  GlobalKey<FormState> _productFormKey = GlobalKey();
  TextEditingController amtController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amt1Controller = TextEditingController();
  TextEditingController amt2Controller = TextEditingController();
  TextEditingController amt3Controller = TextEditingController();
  TextEditingController amt4Controller = TextEditingController();
  TextEditingController amt5Controller = TextEditingController();
  TextEditingController amt6Controller = TextEditingController();
  TextEditingController amt7Controller = TextEditingController();
  TextEditingController amt8Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return adding == false
        ? Scaffold(
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image.asset(
                    "assets/images/gi.gif",
                    fit: BoxFit.fitHeight,
                    width: 80,
                  ),
                  SizedBox(height: 0),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.indigo[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                        "Do not press the back button.\nPlease wait until we process your expense.\nIt may take few seconds.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  )
                ])),
          )
        : Scaffold(
            backgroundColor: Colors.indigo[50],
            appBar: AppBar(
              backgroundColor: Colors.indigo[50],
              toolbarHeight: 60,
              title: Text("Details"),
              elevation: 0,
            ),
            body: SingleChildScrollView(
                child: Form(
              key: _productFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  if (splittype == "Equally")
                    Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Text("Amount",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)))
                  else
                    SizedBox(height: 0),
                  SizedBox(
                    height: 10,
                  ),
                  if (splittype == "Equally")
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: amtController,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please add the amount';
                              }
                            },
                            onChanged: (value) {
                              spt = int.parse(value) / widget.splitdata.length;
                              setState(() {
                                splt = spt.toStringAsFixed(2);
                                print(splt);
                                amt1Controller.text = spt.toStringAsFixed(2);
                                amt2Controller.text = spt.toStringAsFixed(2);
                                amt3Controller.text = spt.toStringAsFixed(2);
                                amt4Controller.text = spt.toStringAsFixed(2);
                                amt5Controller.text = spt.toStringAsFixed(2);
                                amt6Controller.text = spt.toStringAsFixed(2);
                                amt7Controller.text = spt.toStringAsFixed(2);
                                amt8Controller.text = spt.toStringAsFixed(2);
                              });
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.red[900],
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0)),
                                fillColor: Colors.transparent,
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                hintText: "1000",
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 15.0,
                                ),
                                prefixText: "₹"),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          )),
                    )
                  else
                    SizedBox(height: 0),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Text("Description",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: descController,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please describe your expense';
                            }
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 2)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 1)),
                            fillColor: Colors.transparent,
                            hintText: "Describe your expense",
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Text("Paid by",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600))),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: GestureDetector(
                          onTap: () {
                            if (widget.splitdata == null) {
                            } else {
                              showBarModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: SingleChildScrollView(
                                          child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          
                                          if (widget.friend1 == null)
                                            Container(height: 0, width: 0)
                                          else
                                            ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    widget.paidby =
                                                        widget.fphone1;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/avatarb.png"))),
                                                ),
                                                title: Text(
                                                  widget.friend1 ==
                                                          widget.username
                                                      ? "You"
                                                      : widget.friend1,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                trailing: widget.paidby ==
                                                        widget.fphone1
                                                    ? Container(
                                                        height: 40,
                                                        width: 90,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          "₹ ${amtController.text.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 90,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                          if (widget.friend2 == null)
                                            Container(height: 0, width: 0)
                                          else
                                            ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    widget.paidby =
                                                        widget.fphone2;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/avatarb.png"))),
                                                ),
                                                title: Text(
                                                  widget.friend2 ==
                                                          widget.username
                                                      ? "You"
                                                      : widget.friend2,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                trailing: widget.paidby ==
                                                        widget.fphone2
                                                    ? Container(
                                                        height: 40,
                                                        width: 90,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          "₹ ${amtController.text.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 90,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                          if (widget.friend3 == null)
                                            Container(height: 0, width: 0)
                                          else
                                            ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    widget.paidby =
                                                        widget.fphone3;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/avatarb.png"))),
                                                ),
                                                title: Text(
                                                  widget.friend3 ==
                                                          widget.username
                                                      ? "You"
                                                      : widget.fphone3,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                trailing: widget.paidby ==
                                                        widget.friend3
                                                    ? Container(
                                                        height: 40,
                                                        width: 90,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          "₹ ${amtController.text.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 90,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                          if (widget.friend4 == null)
                                            Container(height: 0, width: 0)
                                          else
                                            ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    widget.paidby =
                                                        widget.fphone4;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/avatarb.png"))),
                                                ),
                                                title: Text(
                                                  widget.friend4 ==
                                                          widget.username
                                                      ? "You"
                                                      : widget.fphone4,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                trailing: widget.paidby ==
                                                        widget.friend4
                                                    ? Container(
                                                        height: 40,
                                                        width: 90,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          "₹ ${amtController.text.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 90,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                          if (widget.friend5 == null)
                                            Container(height: 0, width: 0)
                                          else
                                            ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    widget.paidby =
                                                        widget.fphone5;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/avatarb.png"))),
                                                ),
                                                title: Text(
                                                  widget.friend5 ==
                                                          widget.username
                                                      ? "You"
                                                      : widget.friend5,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                trailing: widget.paidby ==
                                                        widget.fphone5
                                                    ? Container(
                                                        height: 40,
                                                        width: 90,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          "₹ ${amtController.text.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 90,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                          if (widget.friend6 == null)
                                            Container(height: 0, width: 0)
                                          else
                                            ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    widget.paidby =
                                                        widget.fphone6;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/avatarb.png"))),
                                                ),
                                                title: Text(
                                                  widget.friend6 ==
                                                          widget.username
                                                      ? "You"
                                                      : widget.fphone6,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                trailing: widget.paidby ==
                                                        widget.friend6
                                                    ? Container(
                                                        height: 40,
                                                        width: 90,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          "₹ ${amtController.text.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 90,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                          if (widget.friend7 == null)
                                            Container(height: 0, width: 0)
                                          else
                                            ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    widget.paidby =
                                                        widget.fphone7;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/avatarb.png"))),
                                                ),
                                                title: Text(
                                                  widget.friend7 ==
                                                          widget.username
                                                      ? "You"
                                                      : widget.friend7,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                trailing: widget.paidby ==
                                                        widget.fphone7
                                                    ? Container(
                                                        height: 40,
                                                        width: 90,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          "₹ ${amtController.text.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 90,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                          if (widget.friend8 == null)
                                            Container(height: 0, width: 0)
                                          else
                                            ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    widget.paidby =
                                                        widget.fphone8;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                leading: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/avatarb.png"))),
                                                ),
                                                title: Text(
                                                  widget.friend8 ==
                                                          widget.username
                                                      ? "You"
                                                      : widget.friend8,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                trailing: widget.paidby ==
                                                        widget.fphone8
                                                    ? Container(
                                                        height: 40,
                                                        width: 90,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .indigo[50],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text(
                                                          "₹ ${amtController.text.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        width: 90,
                                                        color:
                                                            Colors.transparent,
                                                      )),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      )),
                                    );
                                  });
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 600,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                child: Row(children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/avatarb.png"))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              if (widget.paidby == 'You')
                                Text(
                                  'Please select',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.paidby == widget.fphone1)
                                Text(
                                  widget.friend1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.paidby == widget.fphone2)
                                Text(
                                  widget.friend2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.paidby == widget.fphone3)
                                Text(
                                  widget.friend3,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.paidby == widget.fphone4)
                                Text(
                                  widget.friend4,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.paidby == widget.fphone5)
                                Text(
                                  widget.friend5,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.paidby == widget.fphone6)
                                Text(
                                  widget.friend6,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.paidby == widget.fphone7)
                                Text(
                                  widget.friend7,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              if (widget.paidby == widget.fphone8)
                                Text(
                                  widget.friend8,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                            ])),
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("People",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                          GestureDetector(
                            onTap: () {
                              showBarModalBottomSheet(
                                  context: context,
                                  builder: (ctx) {
                                    return Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                splittype = "Equally";
                                              });
                                              Navigator.pop(context);
                                            },
                                            leading: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/avatarb.png"))),
                                            ),
                                            title: Text("Equally",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                splittype = "Unequally";
                                                amtController.clear();
                                              });
                                              Navigator.pop(context);
                                            },
                                            leading: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/avatarb.png"))),
                                            ),
                                            title: Text("Unequally",
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.indigo[50],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Text(splittype,
                                        style: TextStyle(
                                            color: Colors.indigo[900],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                    Icon(
                                      Icons.arrow_downward_sharp,
                                      size: 20,
                                      color: Colors.indigo[900],
                                    )
                                  ],
                                )),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        width: 600,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            if (widget.friend8 == null)
                              Container(
                                height: 0,
                                width: 0,
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.friend8 == widget.username
                                        ? "You"
                                        : widget.friend8,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  if (splittype == "Equally")
                                    Container(
                                      height: 40,
                                      width: amt8Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          spt == null
                                              ? "₹ 0"
                                              : "₹ ${splt.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  else
                                    Container(
                                      height: 40,
                                      width: amt8Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        controller: amt8Controller,
                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please describe your expense';
                                          }
                                        },
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,

                                        decoration: InputDecoration(
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
                                          fillColor: Colors.transparent,
                                          prefixText: "₹",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),

                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ],
                              ),
                            SizedBox(
                              height: widget.friend1 == null ? 0 : 17,
                            ),
                            if (widget.friend1 == null)
                              Container(
                                height: 0,
                                width: 0,
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.friend1 == widget.username
                                        ? "You"
                                        : widget.friend1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  if (splittype == "Equally")
                                    Container(
                                      height: 40,
                                      width: amt1Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          spt == null
                                              ? "₹ 0"
                                              : "₹ ${splt.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  else
                                    Container(
                                        height: 40,
                                        width: amt1Controller.text.length >= 4
                                            ? 120
                                            : 90,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.indigo[50],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: TextFormField(
                                          controller: amt1Controller,

                                          // ignore: missing_return
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please describe your expense';
                                            }
                                          },
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
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
                                            fillColor: Colors.transparent,
                                            prefixText: "₹",
                                            hintStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ))
                                ],
                              ),
                            SizedBox(
                              height: widget.friend2 == null ? 0 : 17,
                            ),
                            if (widget.friend2 == null)
                              Container(
                                height: 0,
                                width: 0,
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    widget.friend2 == widget.username
                                        ? "You"
                                        : widget.friend2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (splittype == "Equally")
                                    Container(
                                      height: 40,
                                      width: amt2Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          spt == null
                                              ? "₹ 0"
                                              : "₹ ${splt.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  else
                                    Container(
                                      height: 40,
                                      width: amt2Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        controller: amt2Controller,
                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please describe your expense';
                                          }
                                        },
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
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
                                          fillColor: Colors.transparent,
                                          prefixText: "₹",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ],
                              ),
                            SizedBox(height: widget.friend3 == null ? 0 : 17),
                            if (widget.friend3 == null)
                              Container(
                                height: 0,
                                width: 0,
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    widget.friend3 == widget.username
                                        ? "You"
                                        : widget.friend3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  if (splittype == "Equally")
                                    Container(
                                      height: 40,
                                      width: amt3Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          spt == null
                                              ? "₹ 0"
                                              : "₹ ${splt.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  else
                                    Container(
                                      height: 40,
                                      width: amt3Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        controller: amt3Controller,
                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please describe your expense';
                                          }
                                        },
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
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
                                          fillColor: Colors.transparent,
                                          prefixText: "₹",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ],
                              ),
                            SizedBox(
                              height: widget.friend4 == null ? 0 : 17,
                            ),
                            if (widget.friend4 == null)
                              Container(
                                height: 0,
                                width: 0,
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    widget.friend4 == widget.username
                                        ? "You"
                                        : widget.friend4,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  if (splittype == "Equally")
                                    Container(
                                      height: 40,
                                      width: amt4Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          spt == null
                                              ? "₹ 0"
                                              : "₹ ${splt.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  else
                                    Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: amt4Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        controller: amt4Controller,
                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please describe your expense';
                                          }
                                        },
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
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
                                          fillColor: Colors.transparent,
                                          prefixText: "₹",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ],
                              ),
                            SizedBox(
                              height: widget.friend5 == null ? 0 : 17,
                            ),
                            if (widget.friend5 == null)
                              Container(
                                height: 0,
                                width: 0,
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    widget.friend5 == widget.username
                                        ? "You"
                                        : widget.friend5,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  if (splittype == "Equally")
                                    Container(
                                      height: 40,
                                      width: amt5Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          spt == null
                                              ? "₹ 0"
                                              : "₹ ${splt.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  else
                                    Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      width: amt5Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        controller: amt5Controller,
                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please describe your expense';
                                          }
                                        },
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
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
                                          fillColor: Colors.transparent,
                                          prefixText: "₹",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ],
                              ),
                            SizedBox(
                              height: widget.friend6 == null ? 0 : 17,
                            ),
                            if (widget.friend6 == null)
                              Container(
                                height: 0,
                                width: 0,
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    widget.friend6 == widget.username
                                        ? "You"
                                        : widget.friend6,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  if (splittype == "Equally")
                                    Container(
                                      height: 40,
                                      width: amt6Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          spt == null
                                              ? "₹ 0"
                                              : "₹ ${splt.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  else
                                    Container(
                                      height: 40,
                                      width: amt6Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        controller: amt6Controller,
                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please describe your expense';
                                          }
                                        },
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
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
                                          fillColor: Colors.transparent,
                                          prefixText: "₹",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ],
                              ),
                            SizedBox(
                              height: widget.friend7 == null ? 0 : 17,
                            ),
                            if (widget.friend7 == null)
                              Container(
                                height: 0,
                                width: 0,
                              )
                            else
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Text(
                                    widget.friend7 == widget.username
                                        ? "You"
                                        : widget.friend7,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  if (splittype == "Equally")
                                    Container(
                                      height: 40,
                                      width: amt7Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          spt == null
                                              ? "₹ 0"
                                              : "₹ ${splt.toString()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  else
                                    Container(
                                      height: 40,
                                      width: amt7Controller.text.length >= 4
                                          ? 120
                                          : 90,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.indigo[50],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextFormField(
                                        controller: amt7Controller,
                                        // ignore: missing_return
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please describe your expense';
                                          }
                                        },
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
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
                                          fillColor: Colors.transparent,
                                          prefixText: "₹",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                ],
                              ),
                            SizedBox(
                              height: 17,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Addpeople(
                                          amount: amtController.text,
                                          description: descController.text,
                                        )));
                              },
                              child: Text(
                                "Add people",
                                style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        )),
                      ))
                ],
              ),
            )),
            bottomNavigationBar: GestureDetector(
              onTap: () async {
                if (_productFormKey.currentState.validate()) {
                  if (widget.paidby == null) {
                    Fluttertoast.showToast(msg: "Please select Payee.");
                  } else {
                    setState(() {
                      adding = false;
                    });
                    await fetchpoints();
                    await putexpdata().then((value) async {
                      await putexpdataa();
                      if (widget.friend1 == null) {
                      } else {
                        await sendpad(widget.fphone1, 'a')
                            .whenComplete(() async {
                          await getFriend(widget.fphone1, 'a').then((id) async {
                            if (fa == 'No') {
                              await createfriend(
                                      widget.friend1, widget.fphone1, ismema)
                                  .then((userid) async {
                                await sendpa(userid);
                              });
                            } else {
                              await sendpa(fa);
                            }
                          });
                        });
                      }
                      if (widget.friend2 == null) {
                      } else {
                        sendpad(widget.fphone2, 'b').then((u) async {
                          await getFriend(widget.fphone2, 'b').then((id) async {
                            print(id);
                            if (fb == 'No') {
                              await createfriend(
                                      widget.friend2, widget.fphone2, ismemb)
                                  .then((userid) async {
                                await sendpb(userid);
                              });
                            } else {
                              await sendpb(fb);
                            }
                          });
                        });
                      }
                      if (widget.friend3 == null) {
                      } else {
                        await sendpad(widget.fphone3, 'c')
                            .whenComplete(() async {
                          await getFriend(widget.fphone1, 'c').then((id) async {
                            if (fc == 'No') {
                              await createfriend(
                                      widget.friend3, widget.fphone3, ismemc)
                                  .then((userid) async {
                                await sendpc(userid);
                              });
                            } else {
                              await sendpc(fc);
                            }
                          });
                        });
                      }
                      if (widget.friend4 == null) {
                      } else {
                        await sendpad(widget.fphone4, 'd')
                            .whenComplete(() async {
                          await getFriend(widget.fphone1, 'd').then((id) async {
                            if (fd == 'No') {
                              await createfriend(
                                      widget.friend4, widget.fphone4, ismemd)
                                  .then((userid) async {
                                await sendpd(userid);
                              });
                            } else {
                              await sendpd(fd);
                            }
                          });
                        });
                      }
                      if (widget.friend5 == null) {
                      } else {
                        await sendpad(widget.fphone5, 'e')
                            .whenComplete(() async {
                          await getFriend(widget.fphone1, 'e').then((id) async {
                            if (fe == 'No') {
                              await createfriend(
                                      widget.friend5, widget.fphone5, ismema)
                                  .then((userid) async {
                                await sendpe(userid);
                              });
                            } else {
                              await sendpe(fe);
                            }
                          });
                        });
                      }
                      if (widget.friend6 == null) {
                      } else {
                        await sendpad(widget.fphone6, 'f')
                            .whenComplete(() async {
                          await getFriend(widget.fphone1, 'f').then((id) async {
                            if (ff == 'No') {
                              await createfriend(
                                      widget.friend6, widget.fphone6, ismemf)
                                  .then((userid) async {
                                await sendpf(userid);
                              });
                            } else {
                              await sendpf(ff);
                            }
                          });
                        });
                      }
                      if (widget.friend7 == null) {
                      } else {
                        await sendpad(widget.fphone7, 'g')
                            .whenComplete(() async {
                          await getFriend(widget.fphone1, 'g').then((id) async {
                            if (fg == 'No') {
                              await createfriend(
                                      widget.friend7, widget.fphone7, ismemg)
                                  .then((userid) async {
                                await sendpg(userid);
                              });
                            } else {
                              await sendpg(fg);
                            }
                          });
                        });
                      }
                      if (widget.friend8 == null) {
                      } else {
                        await sendpad(widget.fphone8, 'h')
                            .whenComplete(() async {
                          await getFriend(widget.fphone1, 'h').then((id) async {
                            if (fh == 'No') {
                              await createfriend(
                                      widget.friend8, widget.fphone8, ismemh)
                                  .then((userid) async {
                                await sendph(userid);
                              });
                            } else {
                              await sendph(fh);
                            }
                          });
                        });
                      }
                    }).then((value) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Splithomepage()));
                    });
                  }
                }
              },
              child: Container(
                  height: 50,
                  color: Colors.red[900],
                  alignment: Alignment.center,
                  child: adding
                      ? Text(
                          "Split",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )
                      : Image.asset(("assets/images/gi.gif"),
                          fit: BoxFit.fitHeight)),
            ));
  }
}

// ignore: must_be_immutable
class Addpeople extends StatefulWidget {
  List splitdata;
  String amount;
  String description;
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
  String friend8;
  String fphone8;

  Addpeople(
      {this.splitdata,
      this.fphone1,
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
      this.friend8,
      this.fphone8,
      this.amount,
      this.description});
  @override
  _AddpeopleState createState() => _AddpeopleState();
}

class _AddpeopleState extends State<Addpeople> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  List dataa = [];
  List dataaa = [];
  List splitd = ['You'];
  String user;
  bool loading = true;
  String phone;
  void initState() {
    super.initState();
    getphonea().whenComplete(() {
      fetchDataa();
    });
  }

  Future fetchDataa() async {
    dynamic data = {"phone": phone};
    final response = await http.post(
      Uri.parse('https://kaiaexp.000webhostapp.com/group/getgroup.php'),
      body: json.encode(data),
      headers: {"accept": "application/json"},
    );
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        dataaa = json.decode(response.body);
      });
      print(response.body);
      return "success";
    }
  }

  Future fetchData(String grpid) async {
    final response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/group/getmembers.php'),
        body: json.encode({'grp_id': grpid}),
        headers: {"accept": "application/json"});
    if (response.statusCode == 200) {
      setState(() {
        dataa = json.decode(response.body);
      });
      print(response.body);
      return "success";
    }
  }

  Future getphone() async {
    var data = {
      'uid': _firebaseServices.getUserId(),
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuser.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      setState(() {
        user = json.decode(response.body);
      });
      print(response.body);
    }
  }

  Future getphonea() async {
    var data = {
      'uid': _firebaseServices.getUserId(),
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuserp.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      setState(() {
        phone = json.decode(response.body);
      });
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    List split = widget.splitdata == null ? splitd : widget.splitdata;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        title: Text(split.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text("Groups",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 100,
                width: 600,
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: loading == false
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dataaa.length,
                            itemBuilder: (BuildContext context, index) {
                              final item = dataaa[index];
                              var img = item['avatar'];
                              var grpidd = item['id'];
                              return Column(
                                children: [
                                  GestureDetector(
                                      onTap: () async {
                                        await getphone();
                                        await fetchData(grpidd)
                                            .whenComplete(() {
                                          if (dataa.length == 1) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splitgrpaa(
                                                          grpid: grpidd,
                                                          friend1: dataa[0]
                                                              ['name'],
                                                          friend2: null,
                                                          friend3: null,
                                                          friend4: null,
                                                          friend5: null,
                                                          friend6: null,
                                                          splitdata: dataa,
                                                          amt: widget.amount,
                                                          desc: widget
                                                              .description,
                                                          friend7: null,
                                                          friend8: null,
                                                          fphone1: dataa[0]
                                                              ['phone_no'],
                                                          fphone2: null,
                                                          fphone3: null,
                                                          fphone4: null,
                                                          fphone5: null,
                                                          fphone6: null,
                                                          fphone7: null,
                                                          fphone8: null,
                                                          username: user,
                                                          paidby: "You",
                                                        )));
                                          }
                                          if (dataa.length == 2) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splitgrpaa(
                                                          grpid: grpidd,
                                                          friend1: dataa[0]
                                                              ['name'],
                                                          friend2: dataa[1]
                                                              ['name'],
                                                          friend3: null,
                                                          friend4: null,
                                                          friend5: null,
                                                          friend6: null,
                                                          splitdata: dataa,
                                                          friend7: null,
                                                          fphone1: dataa[0]
                                                              ['phone_no'],
                                                          fphone2: dataa[1]
                                                              ['phone_no'],
                                                          amt: widget.amount,
                                                          desc: widget
                                                              .description,
                                                          fphone3: null,
                                                          fphone4: null,
                                                          fphone5: null,
                                                          friend8: null,
                                                          fphone8: null,
                                                          fphone6: null,
                                                          fphone7: null,
                                                          username: user,
                                                          paidby: "You",
                                                        )));
                                          }
                                          if (dataa.length == 3) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splitgrpaa(
                                                          grpid: grpidd,
                                                          friend1: dataa[0]
                                                              ['name'],
                                                          friend2: dataa[1]
                                                              ['name'],
                                                          friend3: dataa[2]
                                                              ['name'],
                                                          friend4: null,
                                                          friend5: null,
                                                          splitdata: dataa,
                                                          friend6: null,
                                                          friend7: null,
                                                          amt: widget.amount,
                                                          desc: widget
                                                              .description,
                                                          friend8: null,
                                                          fphone8: null,
                                                          fphone1: dataa[0]
                                                              ['phone_no'],
                                                          fphone2: dataa[1]
                                                              ['phone_no'],
                                                          fphone3: dataa[2]
                                                              ['phone_no'],
                                                          fphone4: null,
                                                          fphone5: null,
                                                          fphone6: null,
                                                          fphone7: null,
                                                          username: user,
                                                          paidby: "You",
                                                        )));
                                          }
                                          if (dataa.length == 4) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splitgrpaa(
                                                          grpid: grpidd,
                                                          friend1: dataa[0]
                                                              ['name'],
                                                          friend2: dataa[1]
                                                              ['name'],
                                                          friend3: dataa[2]
                                                              ['name'],
                                                          friend4: dataa[3]
                                                              ['name'],
                                                          friend5: null,
                                                          friend6: null,
                                                          amt: widget.amount,
                                                          desc: widget
                                                              .description,
                                                          splitdata: dataa,
                                                          friend7: null,
                                                          friend8: null,
                                                          fphone8: null,
                                                          fphone1: dataa[0]
                                                              ['phone_no'],
                                                          fphone2: dataa[1]
                                                              ['phone_no'],
                                                          fphone3: dataa[2]
                                                              ['phone_no'],
                                                          fphone4: dataa[3]
                                                              ['phone_no'],
                                                          fphone5: null,
                                                          fphone6: null,
                                                          fphone7: null,
                                                          paidby: "You",
                                                          username: user,
                                                        )));
                                          }
                                          if (dataa.length == 5) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splitgrpaa(
                                                          grpid: grpidd,
                                                          friend1: dataa[0]
                                                              ['name'],
                                                          friend2: dataa[1]
                                                              ['name'],
                                                          friend3: dataa[2]
                                                              ['name'],
                                                          friend4: dataa[3]
                                                              ['name'],
                                                          friend5: dataa[4]
                                                              ['name'],
                                                          friend6: null,
                                                          amt: widget.amount,
                                                          desc: widget
                                                              .description,
                                                          friend7: null,
                                                          friend8: null,
                                                          splitdata: dataa,
                                                          fphone8: null,
                                                          fphone1: dataa[0]
                                                              ['phone_no'],
                                                          fphone2: dataa[1]
                                                              ['phone_no'],
                                                          fphone3: dataa[2]
                                                              ['phone_no'],
                                                          fphone4: dataa[3]
                                                              ['phone_no'],
                                                          fphone5: dataa[4]
                                                              ['phone_no'],
                                                          fphone6: null,
                                                          fphone7: null,
                                                          paidby: "You",
                                                          username: user,
                                                        )));
                                          }
                                          if (dataa.length == 6) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splitgrpaa(
                                                          grpid: grpidd,
                                                          friend1: dataa[0]
                                                              ['name'],
                                                          friend2: dataa[1]
                                                              ['name'],
                                                          friend3: dataa[2]
                                                              ['name'],
                                                          friend4: dataa[3]
                                                              ['name'],
                                                          friend5: dataa[4]
                                                              ['name'],
                                                          friend6: dataa[5]
                                                              ['name'],
                                                          friend7: null,
                                                          friend8: null,
                                                          fphone8: null,
                                                          splitdata: dataa,
                                                          fphone1: dataa[0]
                                                              ['phone_no'],
                                                          amt: widget.amount,
                                                          desc: widget
                                                              .description,
                                                          fphone2: dataa[1]
                                                              ['phone_no'],
                                                          fphone3: dataa[2]
                                                              ['phone_no'],
                                                          fphone4: dataa[3]
                                                              ['phone_no'],
                                                          fphone5: dataa[4]
                                                              ['phone_no'],
                                                          fphone6: dataa[5]
                                                              ['phone_no'],
                                                          fphone7: null,
                                                          username: user,
                                                          paidby: "You",
                                                        )));
                                          }
                                          if (dataa.length == 7) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splitgrpaa(
                                                          grpid: grpidd,
                                                          friend1: dataa[0]
                                                              ['name'],
                                                          friend2: dataa[1]
                                                              ['name'],
                                                          friend3: dataa[2]
                                                              ['name'],
                                                          friend4: dataa[3]
                                                              ['name'],
                                                          friend5: dataa[4]
                                                              ['name'],
                                                          friend6: dataa[5]
                                                              ['name'],
                                                          friend7: dataa[6]
                                                              ['name'],
                                                          friend8: null,
                                                          splitdata: dataa,
                                                          fphone8: null,
                                                          amt: widget.amount,
                                                          desc: widget
                                                              .description,
                                                          fphone1: dataa[0]
                                                              ['phone_no'],
                                                          fphone2: dataa[1]
                                                              ['phone_no'],
                                                          fphone3: dataa[2]
                                                              ['phone_no'],
                                                          fphone4: dataa[3]
                                                              ['phone_no'],
                                                          fphone5: dataa[4]
                                                              ['phone_no'],
                                                          fphone6: dataa[5]
                                                              ['phone_no'],
                                                          fphone7: dataa[6]
                                                              ['phone_no'],
                                                          username: user,
                                                          paidby: "You",
                                                        )));
                                          }
                                          if (dataa.length == 8) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Splitgrpaa(
                                                          grpid: grpidd,
                                                          friend1: dataa[0]
                                                              ['name'],
                                                          friend2: dataa[1]
                                                              ['name'],
                                                          friend3: dataa[2]
                                                              ['name'],
                                                          amt: widget.amount,
                                                          desc: widget
                                                              .description,
                                                          friend4: dataa[3]
                                                              ['name'],
                                                          friend5: dataa[4]
                                                              ['name'],
                                                          splitdata: dataa,
                                                          friend6: dataa[5]
                                                              ['name'],
                                                          friend7: dataa[6]
                                                              ['name'],
                                                          friend8: dataa[7]
                                                              ['name'],
                                                          fphone8: dataa[7]
                                                              ['phone_no'],
                                                          fphone1: dataa[0]
                                                              ['phone_no'],
                                                          fphone2: dataa[1]
                                                              ['phone_no'],
                                                          fphone3: dataa[2]
                                                              ['phone_no'],
                                                          fphone4: dataa[3]
                                                              ['phone_no'],
                                                          fphone5: dataa[4]
                                                              ['phone_no'],
                                                          fphone6: dataa[5]
                                                              ['phone_no'],
                                                          fphone7: dataa[6]
                                                              ['phone_no'],
                                                          username: user,
                                                          paidby: "You",
                                                        )));
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    img.toString()))),
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item['name'],
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              );
                            })
                        : Center(
                            child: Image.asset(
                              "assets/images/gi.gif",
                              width: 50,
                            ),
                          ))),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 600,
              alignment: Alignment.center,
              child: Text("Or",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.friend1 == null)
                          Text("Select Friend",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600))
                        else
                          Text(widget.friend1.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Contactselect(
                                        id: "1",
                                        split: split,
                                        friend1: widget.friend1,
                                        friend2: widget.friend2,
                                        friend3: widget.friend3,
                                        amt: widget.amount,
                                        desc: widget.description,
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
                                        fphone8: widget.fphone8,
                                        friend8: widget.friend8)));
                          },
                          child: Container(
                            height: 35,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red[900]),
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
                        if (widget.friend2 == null)
                          Text("Select Friend",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600))
                        else
                          Text(widget.friend2.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Contactselect(
                                        id: "2",
                                        split: split,
                                        friend1: widget.friend1,
                                        friend2: widget.friend2,
                                        friend3: widget.friend3,
                                        friend4: widget.friend4,
                                        friend5: widget.friend5,
                                        friend6: widget.friend6,
                                        friend7: widget.friend7,
                                        amt: widget.amount,
                                        desc: widget.description,
                                        fphone1: widget.fphone1,
                                        fphone2: widget.fphone2,
                                        fphone3: widget.fphone3,
                                        fphone4: widget.fphone4,
                                        fphone5: widget.fphone5,
                                        fphone6: widget.fphone6,
                                        fphone7: widget.fphone7,
                                        fphone8: widget.fphone8,
                                        friend8: widget.friend8)));
                          },
                          child: Container(
                            height: 35,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red[900]),
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
                        if (widget.friend3 == null)
                          Text("Select Friend",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600))
                        else
                          Text(widget.friend3.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Contactselect(
                                        id: "3",
                                        split: split,
                                        friend1: widget.friend1,
                                        friend2: widget.friend2,
                                        friend3: widget.friend3,
                                        friend4: widget.friend4,
                                        friend5: widget.friend5,
                                        friend6: widget.friend6,
                                        friend7: widget.friend7,
                                        amt: widget.amount,
                                        desc: widget.description,
                                        fphone1: widget.fphone1,
                                        fphone2: widget.fphone2,
                                        fphone3: widget.fphone3,
                                        fphone4: widget.fphone4,
                                        fphone5: widget.fphone5,
                                        fphone6: widget.fphone6,
                                        fphone7: widget.fphone7,
                                        fphone8: widget.fphone8,
                                        friend8: widget.friend8)));
                          },
                          child: Container(
                            height: 35,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red[900]),
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
                        if (widget.friend4 == null)
                          Text("Select Friend",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600))
                        else
                          Text(widget.friend4.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Contactselect(
                                        id: "4",
                                        split: split,
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
                                        amt: widget.amount,
                                        desc: widget.description,
                                        fphone8: widget.fphone8,
                                        friend8: widget.friend8)));
                          },
                          child: Container(
                            height: 35,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red[900]),
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
                        if (widget.friend5 == null)
                          Text("Select Friend",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600))
                        else
                          Text(widget.friend5.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Contactselect(
                                        id: "5",
                                        split: split,
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
                                        amt: widget.amount,
                                        desc: widget.description,
                                        fphone4: widget.fphone4,
                                        fphone5: widget.fphone5,
                                        fphone6: widget.fphone6,
                                        fphone7: widget.fphone7,
                                        fphone8: widget.fphone8,
                                        friend8: widget.friend8)));
                          },
                          child: Container(
                            height: 35,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red[900]),
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
                        if (widget.friend6 == null)
                          Text("Select Friend",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600))
                        else
                          Text(widget.friend6.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Contactselect(
                                        id: "6",
                                        split: split,
                                        friend1: widget.friend1,
                                        friend2: widget.friend2,
                                        friend3: widget.friend3,
                                        friend4: widget.friend4,
                                        friend5: widget.friend5,
                                        friend6: widget.friend6,
                                        amt: widget.amount,
                                        desc: widget.description,
                                        friend7: widget.friend7,
                                        fphone1: widget.fphone1,
                                        fphone2: widget.fphone2,
                                        fphone3: widget.fphone3,
                                        fphone4: widget.fphone4,
                                        fphone5: widget.fphone5,
                                        fphone6: widget.fphone6,
                                        fphone7: widget.fphone7,
                                        fphone8: widget.fphone8,
                                        friend8: widget.friend8)));
                          },
                          child: Container(
                            height: 35,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red[900]),
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
                        if (widget.friend7 == null)
                          Text("Select Friend",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600))
                        else
                          Text(widget.friend7.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Contactselect(
                                        id: "7",
                                        split: split,
                                        friend1: widget.friend1,
                                        friend2: widget.friend2,
                                        friend3: widget.friend3,
                                        friend4: widget.friend4,
                                        friend5: widget.friend5,
                                        friend6: widget.friend6,
                                        friend7: widget.friend7,
                                        amt: widget.amount,
                                        desc: widget.description,
                                        fphone1: widget.fphone1,
                                        fphone2: widget.fphone2,
                                        fphone3: widget.fphone3,
                                        fphone4: widget.fphone4,
                                        fphone5: widget.fphone5,
                                        fphone6: widget.fphone6,
                                        fphone7: widget.fphone7,
                                        fphone8: widget.fphone8,
                                        friend8: widget.friend8)));
                          },
                          child: Container(
                            height: 35,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.red[900]),
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
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          await getphone().whenComplete(() {
            getphonea().whenComplete(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Splitgrpaa(
                            fphone1: widget.fphone1,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                            fphone8: phone,
                            splitdata: split,
                            friend8: user,
                            amt: widget.amount,
                            desc: widget.description,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            friend1: widget.friend1,
                            username: user,
                            paidby: phone,
                          )));
            });
          });
        },
        child: Container(
          height: 60,
          color: Colors.red[900],
          alignment: Alignment.center,
          child: Text("Add",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
