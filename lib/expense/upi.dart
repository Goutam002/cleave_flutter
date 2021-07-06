import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/expense/expense_home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Upi extends StatefulWidget {
  final String data;
  Upi({this.data});
  @override
  _UpiState createState() => _UpiState();
}

class _UpiState extends State<Upi> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  TextEditingController amtController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool adding = true;
  String points = '0';
  var res;
  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse('${widget.data}');
    print(url.queryParametersAll['pa'][0]);
    print(url.queryParametersAll['pn'][0]);
    print(widget.data);
    return Scaffold(
        backgroundColor: Color(0xFFF7F8FF),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFF7F8FF),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          'Kaia',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                      ),
                      Text(
                        'pay',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ])),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  color: Colors.grey[900],
                  height: 5,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text("Name",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '      ${url.queryParametersAll['pn'][0]}',
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
                child: Text("Receiver Upi Address",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    '      ${url.queryParametersAll['pa'][0]}',
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
                child: Text("Amount",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
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
                    controller: amtController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please add the amount';
                      }
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
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text("Description",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
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
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      fillColor: Colors.transparent,
                      hintText: "Describe your expense",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 15.0,
                      ),
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
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            await fetchpoints();
            await putpoints();
            await putexpdata();
            Fluttertoast.showToast(msg: "🎊🎊 $res");
            await launch(
                    '${widget.data}&am=${amtController.text}&tn=${descController.text}')
                .whenComplete(() => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ExpenseHome())));
          },
          child: Container(
              height: 70,
              color: Colors.red[900],
              alignment: Alignment.center,
              child: adding
                  ? Text(
                      "Add and pay",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )
                  : Image.asset(("assets/images/gi.gif"),
                      fit: BoxFit.fitHeight)),
        ));
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

  Future putpoints() async {
    int pts = int.parse(points) + 1;
    dynamic data = {
      "points": pts.toString(),
      "uid": _firebaseServices.getUserId()
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/addpoints.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
      });
    } else {
      print("error");
    }
  }

  Future putexpdata() async {
    /// User data
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("MMMM,yy");
    var date = dateFormat.format(now);
    dynamic data = {
      "amount": amtController.text,
      "desc": descController.text,
      "paid_by": 'Online',
      "month": date,
      "points": "1",
      "uid": _firebaseServices.getUserId(),
      "img_path": 'null'
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/create_exp.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        return res = response.body;
      });
    } else {
      print("error");
    }
  }
}

class Upimanual extends StatefulWidget {
  @override
  _UpimanualState createState() => _UpimanualState();
}

class _UpimanualState extends State<Upimanual> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  TextEditingController amtController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  bool adding = true;
  String points = '0';
  var res;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7F8FF),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFFF7F8FF),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          'Kaia',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 26),
                        ),
                      ),
                      Text(
                        'pay',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )
                    ])),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  color: Colors.grey[900],
                  height: 5,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text(" Receiver's Name",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
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
                      controller: nameController,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add some name!';
                        }
                      },

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
                        hintText: "John..",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 15.0,
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ))),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text("Receiver Upi Address",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
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
                      controller: upiController,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add correct upi address!';
                        }
                      },

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
                        hintText: "reciever@kaia",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 15.0,
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ))),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text("Amount",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
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
                    controller: amtController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please add the amount';
                      }
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
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Text("Description",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600))),
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
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1)),
                      fillColor: Colors.transparent,
                      hintText: "Describe your expense",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 15.0,
                      ),
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
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            await fetchpoints();
            await putpoints();
            await putexpdata();
            Fluttertoast.showToast(msg: "🎊🎊 $res");
            await launch(
                    'upi://pay?pa=${upiController.text}&pn=${nameController.text}&am=${amtController.text}&tn=${descController.text}')
                .whenComplete(() => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ExpenseHome())));
          },
          child: Container(
              height: 70,
              color: Colors.red[900],
              alignment: Alignment.center,
              child: adding
                  ? Text(
                      "Add and pay",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    )
                  : Image.asset(("assets/images/gi.gif"),
                      fit: BoxFit.fitHeight)),
        ));
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

  Future putpoints() async {
    int pts = int.parse(points) + 1;
    dynamic data = {
      "points": pts.toString(),
      "uid": _firebaseServices.getUserId()
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/addpoints.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
      });
    } else {
      print("error");
    }
  }

  Future putexpdata() async {
    /// User data
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("MMMM,yy");
    var date = dateFormat.format(now);
    dynamic data = {
      "amount": amtController.text,
      "desc": descController.text,
      "paid_by": 'online',
      "month": date,
      "points": "1",
      "uid": _firebaseServices.getUserId(),
      "img_path": 'null'
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/create_exp.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        return res = response.body;
      });
    } else {
      print("error");
    }
  }
}
