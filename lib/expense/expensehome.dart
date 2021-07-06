import 'package:kaia/expense/emain.dart';

import 'package:kaia/expense/offers.dart';
import 'package:flutter/material.dart';

final Color activeColor = Color(0xffFF2E63);
final Color inactiveColor = Color(0xff6C73AE);

class Expensehomepage extends StatefulWidget {
  @override
  _ExpensehomepageState createState() => _ExpensehomepageState();
}

class _ExpensehomepageState extends State<Expensehomepage> {
  int selectedPosition = 0;
  List<Widget> listBottomWidget = [];
  var ress;
  @override
  void initState() {
    super.initState();
    addHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility), label: "Expense"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: "Rewards"),
        ],
        currentIndex: selectedPosition,
        iconSize: 20,
        selectedFontSize: 15,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black26,
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
    listBottomWidget.add(Expensemain());
    listBottomWidget.add(Offerspage());
  }
}
