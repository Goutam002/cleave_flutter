import 'dart:convert';
import 'dart:io';
import 'package:kaia/expense/addexp.dart';
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/expense/expensehome.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// ignore: must_be_immutable
class Allexp extends StatefulWidget {
  String total;
  Allexp({this.total});
  @override
  _AllexpState createState() => _AllexpState();
}

class _AllexpState extends State<Allexp> {
  var delete;
  final FirebaseServices _firebaseServices = FirebaseServices();
  Future fetchData(String uid) async {
    dynamic data = {"uid": _firebaseServices.getUserId()};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/get_exp.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        var dataaa = json.decode(response.body);
        return dataaa;
      }
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFf),
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Color(0xFFffffff),
          elevation: 0,
        ),
        body: Stack(children: [
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    "Total Expense\n${widget.total.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 100, left: 5, right: 5),
              child: FutureBuilder(
                future: fetchData(_firebaseServices.getUserId()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length == 0) {
                      return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            Text("😢 Uhho, you have no expenses.\nAdd one now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Addexpense()));
                                },
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.red[900],
                                      borderRadius: BorderRadius.circular(5)),
                                  alignment: Alignment.center,
                                  child: Text("Create",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white)),
                                )),
                          ]));
                    } else {
                      return GridView.builder(
                        padding: EdgeInsets.only(top: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          final item = snapshot.data[index];
                          //get your item data here ...
                          
                          DateTime now = DateTime.parse(item['created_on']);
                          DateFormat dateFormat = DateFormat("dd MMMM,yyyy");
                          var date = dateFormat.format(now);
                          return GestureDetector(
                              onTap: () => showBarModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.black,
                                  barrierColor: Colors.black.withOpacity(0.8),
                                  enableDrag: true,
                                  builder: (BuildContext context) {
                                    if (item['img_path'] == null || item['img_path'] == "" ) {
                                       return Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 10),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      date.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                    MaterialButton(
                                                        onPressed: () async {
                                                          await delData(
                                                              item['id']);
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "🎊 $delete");
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Expensehomepage()));
                                                        },
                                                        child: Container(
                                                          child: Text("Delete",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: Colors
                                                                          .red[
                                                                      900])),
                                                        )),
                                                  ])),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                                height: 200,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/no-photo.png"),
                                                        fit: BoxFit.cover)),
                                              ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            "₹ ${item['amount']}",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Description\n${item['description']}",
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "Paid by: ${item['paid_by']}",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                           Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color:  Colors.red[900],
                    borderRadius: BorderRadius.circular(150),
                  ),
                  alignment: Alignment.center,
                  child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                item['points'] ,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'K',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      'points',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white),
                                    )
                                  ]),
                            ])),
                                    
                                       
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15, right: 10),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      date.toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                    MaterialButton(
                                                        onPressed: () async {
                                                          await delData(
                                                              item['id']);
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "🎊 $delete");
                                                          Navigator.of(context)
                                                              .pushReplacement(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Expensehomepage()));
                                                        },
                                                        child: Container(
                                                          child: Text("Delete",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: Colors
                                                                          .red[
                                                                      900])),
                                                        )),
                                                  ])),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                              onTap: () =>
                                                  showBarModalBottomSheet(
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.black,
                                                      barrierColor: Colors.black
                                                          .withOpacity(0.8),
                                                      enableDrag: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          height: 400,
                                                          width: 400,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                              image: DecorationImage(
                                                                  image: FileImage(File(item['img_path'])),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        );
                                                      }),
                                              child: Container(
                                                height: 200,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/images/no-photo.png"),
                                                        fit: BoxFit.cover)),
                                              )),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            "₹ ${item['amount']}",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Description\n${item['description']}",
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "Paid by: ${item['paid_by']}",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                           Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color:  Colors.red[900],
                    borderRadius: BorderRadius.circular(150),
                  ),
                  alignment: Alignment.center,
                  child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                item['points'] ,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'K',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      'points',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white),
                                    )
                                  ]),
                            ])),
                                  
                                          
                                        ],
                                      );
                                    }
                                  }),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.indigo[50],
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  padding: EdgeInsets.only(
                                      top: 10, left: 0, right: 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "₹ ${item['amount']}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              date.toString(),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  MaterialButton(
                                                      onPressed: () async {
                                                        await delData(
                                                            item['id']);
                                                        Fluttertoast.showToast(
                                                            msg: "🎊 $delete");
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Expensehomepage()));
                                                      },
                                                      child: Container(
                                                        child: Text("Delete",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .red[900])),
                                                      )),
                                                ])
                                          ])
                                    ],
                                  )));
                        },
                      );
                    }
                  } else {
                    return Center(
                      child: Image.asset(
                        "assets/images/gi.gif",
                        width: 250,
                        height: 250,
                      )
                      ,
                    );
                  }
                },
              ))
        ]));
  }

  Future delData(String id) async {
    dynamic data = {"id": id};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/delete_exp.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        return delete = json.decode(response.body);
      }
    } else {
      print("error");
    }
  }
}

class Latestexpense extends StatefulWidget {
  @override
  _LatestexpenseState createState() => _LatestexpenseState();
}

class _LatestexpenseState extends State<Latestexpense> {
  List data = [];
  var delete;
  bool load = true;
  final FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: FutureBuilder(
          future: fetchData(_firebaseServices.getUserId()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length == 0) {
                return Center(
                    child:
                        Text("😢 Uhho, You have no expenses yet.\n Add one now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            )));
              } else {
                return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data[index];
                      //get your item data here ...

                      DateTime now = DateTime.parse(item['created_on']);
                      DateFormat dateFormat = DateFormat("dd MMMM,yyyy");
                      var date = dateFormat.format(now);

                      return GestureDetector(
                          onTap: () {
                            showBarModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.black,
                                barrierColor: Colors.black.withOpacity(0.8),
                                enableDrag: true,
                                builder: (BuildContext context) {
                                  if (item['img_path'] == "null" || item['img_path'] == "") {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 10),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    date.toString(),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  MaterialButton(
                                                      onPressed: () async {
                                                        await delData(
                                                            item['id']);
                                                        Fluttertoast.showToast(
                                                            msg: "🎊 $delete");
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Expensehomepage()));
                                                      },
                                                      child: Container(
                                                        child: Text("Delete",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .red[900])),
                                                      )),
                                                ])),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 200,
                                          width: 200,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red[900],
                                                width: 5),
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                          child: Image.asset(
                                            "assets/images/no-photo.png",
                                            width: 40,
                                            height: 40,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          "₹ ${item['amount']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Description\n${item['description']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Paid by: ${item['paid_by']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                         Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(150),
                  
                  ),
                  alignment: Alignment.center,
                  child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                item['points'] ,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'K',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      'points',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white),
                                    )
                                  ]),
                            ])),
                                      

                                      ],
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 10),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    date.toString(),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  MaterialButton(
                                                      onPressed: () async {
                                                        await delData(
                                                            item['id']);
                                                        Fluttertoast.showToast(
                                                            msg: "🎊 $delete");
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Expensehomepage()));
                                                      },
                                                      child: Container(
                                                        child: Text("Delete",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .red[900])),
                                                      )),
                                                ])),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                            onTap: () =>
                                                showBarModalBottomSheet(
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.black,
                                                    barrierColor: Colors.black
                                                        .withOpacity(0.8),
                                                    enableDrag: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 400,
                                                        width: 400,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                            image: DecorationImage(
                                                                image: FileImage(
                                                                    File(item[
                                                                        'img_path'])),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      );
                                                    }),
                                            child: Container(
                                              height: 200,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                      image: FileImage(File(
                                                          item['img_path'])),
                                                      fit: BoxFit.cover)),
                                            )),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          "₹ ${item['amount']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Description\n${item['description']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "Paid by: ${item['paid_by']}",
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                  width: 150,
                  height: 45,
                  decoration: BoxDecoration(
                    color:  Colors.red[900],
                    borderRadius: BorderRadius.circular(150),
                  ),
                  alignment: Alignment.center,
                  child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                item['points'] ,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Text(
                                        'K',
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      'points',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white),
                                    )
                                  ]),
                            ])),
                                      
                                      ],
                                    );
                                  }
                                });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.indigo[50],
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              padding: EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "₹ ${item['amount'].toString()}",
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    date.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                ],
                              )));
                    });
              }
            } else {
              return Center(
                      child: Image.asset(
                        "assets/images/gi.gif",
                        width: 150,
                        height: 150,
                      )
                      ,
                    );
            }
          },
        ));
  }

  Future fetchData(String uid) async {
    dynamic data = {"uid": _firebaseServices.getUserId()};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/get_expa.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        var dataaa = json.decode(response.body);
        return dataaa;
      }
    } else {
      print("error");
    }
  }

  Future delData(String id) async {
    dynamic data = {"id": id};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/personal/delete_exp.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        return delete = json.decode(response.body);
      }
    } else {
      print("error");
    }
  }
}
