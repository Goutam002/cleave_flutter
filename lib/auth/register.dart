import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/expense/expense_home.dart';
import 'package:http/http.dart' as http;
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register2 extends StatefulWidget {
  final String phone;
  Register2({this.phone});
  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  FirebaseServices _firebaseServices = FirebaseServices();
  TextEditingController nameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  GlobalKey<FormState> _productFormKey = GlobalKey();
  Future senddata() async {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("dd MMMM,yyyy");
    var datee = dateFormat.format(now);
    // SERVER API URL
    var url = Uri.parse('https://kaiaexp.000webhostapp.com/auth/register.php');
// Store all data with Param Name.
    var data = {
      'name': nameController.text,
      'phone': widget.phone,
      'upi': upiController.text == null ?'':upiController.text.toString(),
      'uid': _firebaseServices.getUserId(),
      'gmail': gmailController.text,
      'point': '0',
      'pts_no': '0',
      'pts_date': datee.toString()
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
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(elevation: 0, backgroundColor: Colors.white,automaticallyImplyLeading: false,
        toolbarHeight: 0,),
        body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Form(
                key: _productFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text("Name",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: nameController,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter your name.';
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
                              hintText: "Name...",
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
                    Text("Email Id",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                                color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: gmailController,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter your email.';
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
                              hintText: "yourname@domain.com",
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
                  ],
                ),
              ),
              SizedBox(
                height:20,
              ),
              Text("upi id",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                          color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: upiController,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter your UPI';
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
                        hintText: "Your UPI Id",
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
                height: 80,
              ),
              MaterialButton(
                  onPressed: () async {
                    if (_productFormKey.currentState.validate()) {
                      await senddata().whenComplete(() {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ExpenseHome(
                    
                        )));
                      });
                    }
                  },
                    color: Colors.indigo[900],
                 shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Done',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
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
                        ),)
            ])));
  }
}

class Register1 extends StatefulWidget {
  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 150,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: <Widget>[
                    Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        margin: EdgeInsets.only(left: 30, right: 30),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: 'We will send you an ',
                                style: TextStyle(
                                    color: Colors.indigo[900],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(
                                text: 'One Time Password ',
                                style: TextStyle(
                                    color: Colors.indigo[900],
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18)),
                            TextSpan(
                                text: 'on this mobile number',
                                style: TextStyle(
                                    color: Colors.indigo[900],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ]),
                        )),
                    SizedBox(height: 15),
                    Container(
                      height: 40,
                      constraints: const BoxConstraints(maxWidth: 500),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: CupertinoTextField(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        controller: nameController,
                        clearButtonMode: OverlayVisibilityMode.editing,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        placeholder: '0000...',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: MaterialButton(
                        onPressed: () async {
                          if (nameController.text.isNotEmpty) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Otp(
                                          phone: "+91${nameController.text}",
                                        )));
                          }
                        },
                        color: Colors.indigo[900],
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Next',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
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
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Otp extends StatefulWidget {
  final String phone;
  final String verificationid;
  Otp({this.phone, this.verificationid});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String text = '';
  String _verificationCode;
  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  var userauth;
  Future getuser() async {
    var data = {
      'uid': widget.phone,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/auth.php'),
        body: json.encode(data));

    if (response.statusCode == 200) {
      print(response.body);
      userauth = json.decode(response.body);
      return userauth;
    }
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.indigo[50],
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.indigo[900],
              size: 16,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                'Enter 6 digits verification code sent to your number',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500))),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              otpNumberWidget(0),
                              otpNumberWidget(1),
                              otpNumberWidget(2),
                              otpNumberWidget(3),
                              otpNumberWidget(4),
                              otpNumberWidget(5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: MaterialButton(
                      onPressed: () async {
                        print("$text");
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode,
                                      smsCode: "$text"))
                              .then((value) async {
                            if (value.user != null) {
                              await getuser().then((value) {
                                if (value == true) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => ExpenseHome()),
                                  );
                                }
                                if (value == false) {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) {
                                      return Register2(phone: widget.phone);
                                    },
                                  ));
                                }
                              });
                            }
                          });
                        } catch (e) {}
                      },
                      color: Colors.indigo[900],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.indigo[50],
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
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: Colors.indigo[900],
                    rightIcon: Icon(
                      Icons.backspace,
                      color: Colors.indigo[500],
                    ),
                    rightButtonFn: () {
                      setState(() {
                        text = text.substring(0, text.length - 1);
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              await getuser().then((value) {
                if (value == true) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ExpenseHome()),
                  );
                }
                if (value == false) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) {
                      return Register2();
                    },
                  ));
                }
              });
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}

class Register3 extends StatefulWidget {
  final String name;
  final String phn;
  final String gmail;
  Register3({this.name, this.phn, this.gmail});
  @override
  _Register3State createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> _productFormKey = GlobalKey();
  var splittype;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF7F8FF),
       appBar: AppBar(automaticallyImplyLeading: false,
       elevation: 0,
       toolbarHeight: 0,),
        body: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Form(
              key: _productFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                      "Please enter your Upi Id.\nIt will help you to setlle your payments.",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your upiaddress!!';
                      }
                    },
                    cursorColor: Colors.black,

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: "aaaaa",
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                      ),
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (_productFormKey.currentState.validate()) {
                          await senddata();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => ExpenseHome()),
                          );
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          height: 50,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ))),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () async {
                          await senddataa();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => ExpenseHome()),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ))
                ],
              ),
            )));
  }

  Future senddata() async {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("dd MMMM,yyyy");
    var datee = dateFormat.format(now);
    // SERVER API URL
    var url = Uri.parse('https://kaiaexp.000webhostapp.com/auth/register.php');
// Store all data with Param Name.
    var data = {
      'name': widget.name,
      'phone': widget.phn,
      'upi': nameController.text,
      'uid': _firebaseServices.getUserId(),
      'gmail': widget.gmail,
      'point': '0',
      'pts_no': '0',
      'pts_date': datee.toString()
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }

  Future senddataa() async {
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat("dd MMMM,yyyy");
    var datee = dateFormat.format(now);
    // SERVER API URL
    var url = Uri.parse('https://kaiaexp.000webhostapp.com/auth/register.php');
// Store all data with Param Name.
    var data = {
      'name': widget.name,
      'phone': widget.phn,
      'upi': '',
      'uid': _firebaseServices.getUserId(),
      'gmail': widget.gmail,
      'point': '0',
      'pts_no': '0',
      'pts_date': datee.toString()
    };
    var responsea = await http.post(url, body: json.encode(data));
    // Getting Server response into variable.
    var messagea = responsea.body;
    // If Web call Success than Hide the CircularProgressIndicator.
    if (responsea.statusCode == 200) {
      print(messagea);
    }
  }
}
