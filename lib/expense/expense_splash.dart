import 'dart:async';
import 'package:kaia/auth/register.dart';
import 'package:kaia/expense/expense_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class SplashScreena extends StatefulWidget {
  @override
  _SplashScreenaState createState() => _SplashScreenaState();
}

class _SplashScreenaState extends State<SplashScreena>
    with TickerProviderStateMixin {
  var connected;
  @override
  void initState() {
    super.initState();
   
    Timer(Duration(seconds: 2), () async {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => Register1(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (ctx) => ExpenseHome(),
              ));
        }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [       
                   Image.asset("assets/images/logo.png",width: 230,),
                      ])),
            ]));
  }
}

