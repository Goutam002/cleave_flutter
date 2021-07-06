import 'package:flutter/material.dart';

class Group extends StatefulWidget {
  final String name;
  Group({this.name});
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                  top: 50,
                ),
                child: Text(widget.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
            SizedBox(
              
              height: 20,
            ),
            Container(
              height: 500,
              margin: EdgeInsets.only(left: 10,right: 10),
              padding: EdgeInsets.only(left: 10,right: 10),
decoration: BoxDecoration(
  border: Border.all(color: Colors.grey[300]),
  borderRadius: BorderRadius.circular(10),
              color: Colors.white10,),
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (BuildContext context, index) {
                return Container(
                   width: 150,
                  margin: EdgeInsets.only(bottom:50,left: 5,right: 5),
                  decoration: BoxDecoration(
                  color: Colors.white,
               
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.grey[100],
      blurRadius: 5,
      spreadRadius: 5
    )
  ]
                  ),
                  height: 100,
                 
                );
              }),
            ),
            SizedBox(
              height: 40,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.only(bottom: 10),

                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 20,right: 20),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: 
                          Text(
                            "New Expense",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )
                        
                      ),
                    ))
          ],
        ),
      ]),
    );
  }
}
