import 'dart:convert';
import 'package:kaia/auth/firebase_service.dart';
import 'package:kaia/splitbills/groups_details.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/splitbills/addgrpa.dart';
import 'package:flutter/material.dart';

class Groupsa extends StatefulWidget {
  final String phone;

  Groupsa({this.phone});
  @override
  _GroupsaState createState() => _GroupsaState();
}

class _GroupsaState extends State<Groupsa> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  List dataa = [];
  List dataperson = [];
  bool loading = true;
  String phone;
  String phonea;
  String uid;
  @override
  initState() {
    setState(() {
      uid = _firebaseServices.getUserId();
    });
    super.initState();
    getphone().whenComplete(() {
      fetchData();
    });
    print(_firebaseServices.getUserId());
  }

  Future getphone() async {
    var data = {
      'uid': _firebaseServices.getUserId(),
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuserp.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        if (mounted) {
          return phonea = json.decode(response.body.toString());
        }
      });
    }
  }

  Future fetchData() async {
    var data = {'phone': phonea};

    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/group/getgroup.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        print(response.body);
        if (response.body.isNotEmpty) {
          return dataa = json.decode(response.body);
        }
      });
    } else {
      print("error");
    }
  }

  Future fetchperson(String grpid) async {
    var data = {
      'grp_id': grpid,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/group/getmembers.php'),
        body: json.encode(data));

    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        return dataperson = json.decode(response.body);
      });
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataa.length == 0) {
      return loading
          ? Scaffold(
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Groups",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              backgroundColor: Colors.white,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 100,
                  height: 100,
                ),
              ))
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Groups",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              body: Column(
                children: [
                  Image.asset("assets/images/nodata.png"),
                  Text(
                    "You have no groupss\n create one",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Addgrpa()));
                        },
                        color: Colors.indigo[900],
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(9))),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Create groups',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
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
                      )),
                ],
              ));
    } else {
      return loading
          ? Scaffold(
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Groups",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              backgroundColor: Colors.white,
              body: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 100,
                  height: 100,
                ),
              ))
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    "Groups",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  )),
              body: Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: ListView.builder(
                    itemCount: dataa.length,
                    itemBuilder: (BuildContext context, index) {
                      final item = dataa[index];
                      //get your item data here ...
                      var img = item['avatar'];
                      var grpid = item['id'];
                      return GestureDetector(
                          onTap: () async {
                            await fetchperson(grpid);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Groupdetails(
                                    item['name'],
                                    item['created_by'],
                                    dataperson,
                                    item['avatar'],
                                    item['id'])));
                          },
                          onLongPress: () {},
                          child: Container(
                            height: 80,
                            margin:
                                EdgeInsets.only(left: 30, right: 30, top: 10),
                            padding: EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200],
                                  offset: const Offset(0, 0),
                                  blurRadius: 10,
                                  spreadRadius: 2.0,
                                )
                              ],
                              color: Colors.white,
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    img.toString()))),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("${item['name']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.black))
                                    ],
                                  ),
                                ]),
                          ));
                    },
                  )),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Addgrpa()));
                },
                backgroundColor: Colors.black,
                splashColor: Colors.black,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
            );
    }
  }
}

class Groupsmain extends StatefulWidget {
  final String phone;

  Groupsmain({this.phone});
  @override
  _GroupsmainState createState() => _GroupsmainState();
}

class _GroupsmainState extends State<Groupsmain> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  List dataa = [];
  List dataperson = [];
  bool loading = true;
  String phone;
  String phonea;
  String uid;
  @override
  initState() {
    setState(() {
      uid = _firebaseServices.getUserId();
    });
    super.initState();
    getphone().whenComplete(() {
      fetchData();
    });
    print(_firebaseServices.getUserId());
  }

  Future getphone() async {
    var data = {
      'uid': _firebaseServices.getUserId(),
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuserp.php'),
        body: json.encode(data));
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        if (mounted) {
          return phonea = json.decode(response.body.toString());
        }
      });
    }
  }

  Future fetchData() async {
    var data = {'phone': phonea};

    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/group/getgroup.php'),
        body: json.encode(data),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        loading = false;
        print(response.body);
        if (response.body.isNotEmpty) {
          return dataa = json.decode(response.body);
        }
      });
    } else {
      print("error");
    }
  }

  Future fetchperson(String grpid) async {
    var data = {
      'grp_id': grpid,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/group/getmembers.php'),
        body: json.encode(data));

    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        return dataperson = json.decode(response.body);
      });
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dataa.length == 0) {
      return loading
          ? Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 100,
                  height: 100,
                ),
              )
          : Column(
                children: [
                  Image.asset("assets/images/nodata.png"),
                  Text(
                    "You have no groupss\n create one",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: MaterialButton(
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Addgrpa()));
                        },
                        color: Colors.indigo[900],
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(9))),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Create groups',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
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
                      )),
                ],
              );
    } else {
      return loading
          ?Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 100,
                  height: 100,
                ),
              )
          :  Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: ListView.separated(
                      itemCount: dataa.length,
                      itemBuilder: (BuildContext context, index) {
                        final item = dataa[index];
                        //get your item data here ...
                        var img = item['avatar'];
                        var grpid = item['id'];
                        return Padding(padding: EdgeInsets.only(left: 20,right: 20),
                            
                          child:  ListTile(
                            onTap: ()async{
                                await fetchperson(grpid);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Groupdetails(
                                      item['name'],
                                      item['created_by'],
                                      dataperson,
                                      item['avatar'],
                                      item['id'])));
                            },
                            minVerticalPadding: 20,
                            
                            focusColor: Colors.indigo[100],
                                       leading: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      img.toString()))),
                                        ),
                                        
                                        title:Text("${item['name']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black))
                                      
                            ));
                      },
                      separatorBuilder: (context, index) {
    return Padding(padding: EdgeInsets.only(left: 20,right: 20), 
    child:Divider());
  },));
    }
  }
}
