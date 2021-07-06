import 'package:flutter/material.dart';

class Editexpense extends StatefulWidget {
  final String amt;
  final String desc;
  final String paidby;

  Editexpense({this.amt, this.desc, this.paidby});
  @override
  _EditexpenseState createState() => _EditexpenseState();
}

class _EditexpenseState extends State<Editexpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        title: Text("Edit",style: TextStyle(color: Colors.black,fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400], width: 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.attach_money_rounded,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Amount: ₹${widget.amt}',style: TextStyle(color: Colors.black,fontSize: 20),
                  ),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.black),
                ),
                Divider(),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.book, color: Colors.black),
                  title: Text(
                    'Expense For: ${widget.desc}',style: TextStyle(color: Colors.black,fontSize: 20),
                  ),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.black),
                ),
                Divider(),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.card_giftcard, color: Colors.black),
                  title: Text(
                    'Paid By: ${widget.paidby}',style: TextStyle(color: Colors.black,fontSize: 20),
                  ),
                  trailing:
                      Icon(Icons.keyboard_arrow_right, color: Colors.black),
                ),
              ],
            )),
      ),
    );
  }
}
