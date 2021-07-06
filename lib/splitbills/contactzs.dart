import 'package:kaia/splitbills/addgrpa.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:kaia/splitbills/splitgroup.dart';

class Contactssss extends StatefulWidget {
  final String id;
  final String friend1;
  final String friend2;
  final String friend3;
  final String friend4;
  final String friend5;
  final String friend6;
  final String friend7;
  final String fphone1;
  final String fphone2;
  final String fphone3;
  final String fphone4;
  final String fphone5;
  final String fphone6;
  final String fphone7;
  final String name;
  final String avtar;
  Contactssss(
      {this.id,
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
      this.avtar,
      this.name});
  @override
  _ContactssssState createState() => _ContactssssState();
}

class _ContactssssState extends State<Contactssss> {
  TextEditingController contactnameController = TextEditingController();
  TextEditingController contactnoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F8FF),
        elevation: 0,
        toolbarHeight: 60,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text("Add Friend",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: contactnameController,
                  cursorColor: Colors.black,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a Code';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    fillColor: Colors.white,
                    hintText: "Name",
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
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: contactnoController,
                  cursorColor: Colors.black,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a Code';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    fillColor: Colors.white,
                    hintText: "Phone Number",
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
          GestureDetector(
              onTap: () {
                if (contactnoController.text.startsWith('+')) {
                  setState(() {
                    contactnoController.text =
                        contactnoController.text.substring(3);
                  });
                  print(contactnoController.text);
                }
                if (contactnoController.text.startsWith('0')) {
                  setState(() {
                    contactnoController.text =
                        contactnoController.text.substring(1);
                  });
                  print(contactnoController.text);
                }
                if (widget.id == "1") {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addgrpa(
                            friend1: contactnameController.text,
                            fphone1: contactnoController.text,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                            name: widget.name,
                            avtar: widget.avtar,
                          )));
                }
                if (widget.id == "2") {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addgrpa(
                            friend2: contactnameController.text,
                            fphone2: contactnoController.text,
                            friend1: widget.friend1,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone1: widget.fphone1,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                            name: widget.name,
                            avtar: widget.avtar,
                          )));
                }
                if (widget.id == "3") {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addgrpa(
                            friend3: contactnameController.text,
                            fphone3: contactnoController.text,
                            friend2: widget.friend2,
                            friend1: widget.friend1,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone1: widget.fphone1,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                            name: widget.name,
                            avtar: widget.avtar,
                          )));
                }
                if (widget.id == "4") {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addgrpa(
                            friend4: contactnameController.text,
                            fphone4: contactnoController.text,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend1: widget.friend1,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone1: widget.fphone1,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                            name: widget.name,
                            avtar: widget.avtar,
                          )));
                }
                if (widget.id == "5") {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addgrpa(
                            friend5: contactnameController.text,
                            fphone5: contactnoController.text,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend1: widget.friend1,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone1: widget.fphone1,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                            name: widget.name,
                            avtar: widget.avtar,
                          )));
                }
                if (widget.id == "6") {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addgrpa(
                            friend6: contactnameController.text,
                            fphone6: contactnoController.text,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend1: widget.friend1,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone1: widget.fphone1,
                            fphone7: widget.fphone7,
                            name: widget.name,
                            avtar: widget.avtar,
                          )));
                }
                if (widget.id == "7") {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addgrpa(
                            friend7: contactnameController.text,
                            fphone7: contactnoController.text,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend1: widget.friend1,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone1: widget.fphone1,
                            name: widget.name,
                            avtar: widget.avtar,
                          )));
                }
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: Text(
                      "Add Contact",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800),
                    ),
                  ))),
          SizedBox(
            height: 60,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20), child: Divider()),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            onPressed: () async {
              bool _hasPermission = await FlutterContactPicker.hasPermission();
              if (!_hasPermission) {
                _hasPermission =
                    await FlutterContactPicker.requestPermission(force: true);
              }
              if (_hasPermission) {
                PhoneContact _contact =
                    await FlutterContactPicker.pickPhoneContact(
                        askForPermission: true);
                setState(() {
                  contactnoController.text = _contact.phoneNumber.number;
                  contactnameController.text = _contact.fullName;
                });
              } else {}
            },
            child: Container(
              height: 50,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.red[800]),
                  borderRadius: BorderRadius.circular(5)),
              child: Text("Pick from Contacts",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Contactselect extends StatefulWidget {
  List data;
  final String id;
  final String friend1;
  final String friend2;
  final String friend3;
  final String friend4;
  final String friend5;
  final String friend6;
  final String friend7;
  final String fphone1;
  final String fphone2;
  final String fphone3;
  final String fphone4;
  String amt;
  String desc;
  final String fphone5;
  final String fphone6;
  final String fphone7;
  final String fphone8;
  final String friend8;
  final String name;
  final String avtar;
  List split = [];
  Contactselect(
      {this.data,
      this.id,
      this.fphone1,
      this.fphone2,
      this.fphone3,
      this.fphone4,
      this.fphone5,
      this.fphone6,
      this.fphone7,
      this.friend8,
      this.fphone8,
      this.friend1,
      this.friend2,
      this.friend3,
      this.friend4,
      this.friend5,
      this.friend6,
      this.friend7,
      this.avtar,
      this.name,
      this.split,this.amt,this.desc});
  @override
  _ContactselectState createState() => _ContactselectState();
}

class _ContactselectState extends State<Contactselect> {
  TextEditingController contactnameController = TextEditingController();
  TextEditingController contactnoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List split = widget.split;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text("Add Friend",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: contactnameController,
                  cursorColor: Colors.black,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a Code';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    fillColor: Colors.white,
                    hintText: "Name",
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
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  controller: contactnoController,
                  cursorColor: Colors.black,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a Code';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 1)),
                    fillColor: Colors.white,
                    hintText: "Phone Number",
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
          GestureDetector(
              onTap: () {
                if (contactnoController.text.startsWith('+')) {
                  setState(() {
                    contactnoController.text =
                        contactnoController.text.substring(3);
                  });
                  print(contactnoController.text);
                }
                if (contactnoController.text.startsWith('0')) {
                  setState(() {
                    contactnoController.text =
                        contactnoController.text.substring(1);
                  });
                  print(contactnoController.text);
                }
                if (widget.id == "1") {
                  if (widget.friend1 == null) {
                    split.add(contactnameController.text);
                  } else {
                    split.remove(widget.friend1);
                    split.add(contactnameController.text);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addpeople(
                            splitdata: split,
                            friend1: contactnameController.text,
                            fphone1: contactnoController.text,
                            friend2: widget.friend2,
                            
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                            amount: widget.amt,
                            description: widget.desc,
                          )));
                }
                if (widget.id == "2") {
                  if (widget.friend2 == null) {
                    split.add(contactnameController.text);
                  } else {
                    split.remove(widget.friend2);
                    split.add(contactnameController.text);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addpeople(
                            splitdata: split,
                            friend2: contactnameController.text,
                            fphone2: contactnoController.text,
                            friend1: widget.friend1,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                             amount: widget.amt,
                            description: widget.desc,
                            fphone1: widget.fphone1,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                          )));
                }
                if (widget.id == "3") {
                  if (widget.friend3 == null) {
                    split.add(contactnameController.text);
                  } else {
                    split.remove(widget.friend3);
                    split.add(contactnameController.text);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addpeople(
                            splitdata: split,
                            friend3: contactnameController.text,
                            fphone3: contactnoController.text,
                            friend2: widget.friend2,
                            friend1: widget.friend1,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                             amount: widget.amt,
                            description: widget.desc,
                            fphone1: widget.fphone1,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                          )));
                }
                if (widget.id == "4") {
                  if (widget.friend4 == null) {
                    split.add(contactnameController.text);
                  } else {
                    split.remove(widget.friend4);
                    split.add(contactnameController.text);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addpeople(
                            splitdata: split,
                            friend4: contactnameController.text,
                            fphone4: contactnoController.text,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend1: widget.friend1,
                             amount: widget.amt,
                            description: widget.desc,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone1: widget.fphone1,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                          )));
                }
                if (widget.id == "5") {
                  if (widget.friend5 == null) {
                    split.add(contactnameController.text);
                  } else {
                    split.remove(widget.friend5);
                    split.add(contactnameController.text);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addpeople(
                            splitdata: split,
                            friend5: contactnameController.text,
                            fphone5: contactnoController.text,
                            friend2: widget.friend2,
                             amount: widget.amt,
                            description: widget.desc,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend1: widget.friend1,
                            friend6: widget.friend6,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                            fphone1: widget.fphone1,
                            fphone6: widget.fphone6,
                            fphone7: widget.fphone7,
                          )));
                }
                if (widget.id == "6") {
                  if (widget.friend6 == null) {
                    split.add(contactnameController.text);
                  } else {
                    split.remove(widget.friend6);
                    split.add(contactnameController.text);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addpeople(
                            splitdata: split,
                            friend6: contactnameController.text,
                            fphone6: contactnoController.text,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend1: widget.friend1,
                            friend7: widget.friend7,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                             amount: widget.amt,
                            description: widget.desc,
                            fphone4: widget.fphone4,
                            fphone5: widget.fphone5,
                            fphone1: widget.fphone1,
                            fphone7: widget.fphone7,
                          )));
                }
                if (widget.id == "7") {
                  if (widget.friend7 == null) {
                    split.add(contactnameController.text);
                  } else {
                    split.remove(widget.friend7);
                    split.add(contactnameController.text);
                  }

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Addpeople(
                            splitdata: split,
                            friend7: contactnameController.text,
                            fphone7: contactnoController.text,
                            friend2: widget.friend2,
                            friend3: widget.friend3,
                            friend4: widget.friend4,
                            friend5: widget.friend5,
                            friend6: widget.friend6,
                            friend1: widget.friend1,
                            fphone2: widget.fphone2,
                            fphone3: widget.fphone3,
                            fphone4: widget.fphone4,
                             amount: widget.amt,
                            description: widget.desc,
                            fphone5: widget.fphone5,
                            fphone6: widget.fphone6,
                            fphone1: widget.fphone1,
                          )));
                }
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.red[800],
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: Text(
                      "Add Contact",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w800),
                    ),
                  ))),
          SizedBox(
            height: 60,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20), child: Divider()),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            onPressed: () async {
              bool _hasPermission = await FlutterContactPicker.hasPermission();
              if (!_hasPermission) {
                _hasPermission =
                    await FlutterContactPicker.requestPermission(force: true);
              }
              if (_hasPermission) {
                PhoneContact _contact =
                    await FlutterContactPicker.pickPhoneContact(
                        askForPermission: true);
                setState(() {
                  contactnoController.text = _contact.phoneNumber.number;
                  contactnameController.text = _contact.fullName;
                });
              } else {}
            },
            child: Container(
              height: 50,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.red[800]),
                  borderRadius: BorderRadius.circular(5)),
              child: Text("Pick from Contacts",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
    );
  }
}
