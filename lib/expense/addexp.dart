import 'dart:convert';
import 'dart:io';
import 'package:kaia/auth/firebase_service.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/expense/expensehome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Addexpense extends StatefulWidget {
  @override
  _AddexpenseState createState() => _AddexpenseState();
}

class _AddexpenseState extends State<Addexpense> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  var resvalue;
  var ptno;
  var res;
  GlobalKey<FormState> _productFormKey = GlobalKey();
  TextEditingController amtController = TextEditingController();
  TextEditingController descController = TextEditingController();
  var paidby;
  bool adding = true;
  var selectedCategory, selectedType;
  String points = '0';
  File _image;
  final picker = ImagePicker();

  _imgFromCamera() async {
    final image =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(image.path);
    });
  }

  _imgFromGallery() async {
    final image =
        (await picker.getImage(source: ImageSource.gallery, imageQuality: 50));

    setState(() {
      _image = File(image.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool selectcash = false;
  bool selectcard = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7F8FF),
        appBar: AppBar(
          backgroundColor: Color(0xFFF7F8FF),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _productFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text("Add \nExpense",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w900))),
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
                        child: Text("Amount",
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
                    Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Text("Paid By",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600))),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectcash = true;
                                    selectcard = false;
                                    paidby = "Cash";
                                  });
                                  print(paidby);
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: selectcash
                                          ? Border.all(
                                              color: Colors.red[900], width: 2)
                                          : Border.all(
                                              color: Colors.transparent),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Cash 💰",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectcard = true;
                                    selectcash = false;
                                    paidby = "Online";
                                  });
                                  print(paidby);
                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: selectcard
                                          ? Border.all(
                                              color: Colors.red[900], width: 2)
                                          : Border.all(
                                              color: Colors.transparent),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Online 💳",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  ),
                                )),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.indigo[50],
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: FileImage(_image),
                                            fit: BoxFit.fill)),
                                  ))
                              : Container(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  alignment: Alignment.center,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[50],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.indigo,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Attach Bill",
                                        style: TextStyle(
                                            color: Colors.indigo,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 70,
                                      )
                                    ],
                                  ),
                                ),
                        )),
                  ],
                ))),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            if (_productFormKey.currentState.validate()) {
              if (paidby == null) {
                Fluttertoast.showToast(msg: "Please select the paid by option");
              } else {
                setState(() {
                  adding = false;
                });
                await fetchpoints();
                await getptno().whenComplete(() {
                  if (int.parse(ptno) < 9) {
                    updateptno();
                    putpoints();
                    putexpdata().whenComplete(() {
                      Fluttertoast.showToast(msg: "🎊🎊 $res");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Expensehomepage()));
                    });
                  } else {
                    putexpdataa().whenComplete(() {
                      Fluttertoast.showToast(msg: "🎊🎊 $res");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Expensehomepage()));
                    });
                  }
                });
              }
            }
          },
          child: Container(
              height: 70,
              color: Colors.red[900],
              alignment: Alignment.center,
              child: adding
                  ? Text(
                      "Add Expense",
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

  Future updateptno() async {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("dd MMMM,yyyy");
    var dateee = dateFormat.format(now);
    dynamic data = {
      'uid': _firebaseServices.getUserId(),
      "ptno": int.parse(ptno) + 1,
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
  }

  Future getptno() async {
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
    var image = _image.toString();
    dynamic data = {
      "amount": amtController.text,
      "desc": descController.text,
      "paid_by": paidby,
      "month": date,
      "points": "1",
      "uid": _firebaseServices.getUserId(),
      "img_path": image.toString()
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

  Future putexpdataa() async {
    /// User data
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("MMMM,yy");
    var date = dateFormat.format(now);
    var image = _image.toString();
    dynamic data = {
      "amount": amtController.text,
      "desc": descController.text,
      "paid_by": paidby,
      "month": date,
      "points": "0",
      "uid": _firebaseServices.getUserId(),
      "img_path": image.toString()
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
