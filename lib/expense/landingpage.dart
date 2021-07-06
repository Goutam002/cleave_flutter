import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/auth/register.dart';
import 'package:kaia/expense/expense_home.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // ignore: unused_field
  final FirebaseServices _firebaseServices = FirebaseServices();
  String user;

  @override
  Widget build(BuildContext context) {
    if (_firebaseServices.getUserId() == null) {
      return Register1();
    } else {
      return ExpenseHome();
    }
  }
}
