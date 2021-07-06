import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:kaia/auth/firebase_service.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/splitbills/addgrpa.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Groupss extends StatefulWidget {
  final String phone;

  Groupss({this.phone});
  @override
  _GroupssState createState() => _GroupssState();
}

class _GroupssState extends State<Groupss> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  List dataa = [];
  List dataperson = [];
  bool loading = true;
  String phone;
  String phonea;
  String uid;
  List videodata = [[]];
  @override
  initState() {
    setState(() {
      uid = _firebaseServices.getUserId();
    });
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    super.initState();
    getphone().whenComplete(() {
      fetchvideo();
      fetchData();
    });
    print(_firebaseServices.getUserId());
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
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

  Future fetchvideo() async {
    try {
      dynamic data = {"uid": _firebaseServices.getUserId()};
      var response = await http.post(
          Uri.parse('https://kaiaexp.000webhostapp.com/auth/getvideou.php'),
          body: json.encode(data),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          setState(() {
            videodata = json.decode(response.body);
            print(videodata);
          });
        }
      } else {
        print("error");
      }
    } catch (e) {
      print("connection problem");
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Addgrpa()));
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
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
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/images/gi.gif",
                width: 100,
                height: 100,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: ListView.separated(
                itemCount: dataa.length,
                itemBuilder: (BuildContext context, index) {
                  final item = dataa[index];
                  //get your item data here ...
                  var img = item['avatar'];
                  return Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: ListTile(
                        onTap: () async {
                          showBarModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 370,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey[300],
                                                offset: const Offset(0, 0),
                                                blurRadius: 1,
                                                spreadRadius: 1.0,
                                              )
                                            ],
                                          ),
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  item['name'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 23),
                                                ),
                                                Text(
                                                  "Drop-In",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 19),
                                                ),
                                              ])),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Image.asset(
                                        "assets/images/join.png",
                                        width: 280,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          fetchvideo().whenComplete(
                                            () {
                                              _joinMeeting(
                                                  item['name'],
                                                  videodata[0]['name'],
                                                  videodata[0]['gmail_id']);
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 55,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              color: Colors.indigo[100],
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300],
                                                  offset: const Offset(0, 0),
                                                  blurRadius: 1,
                                                  spreadRadius: 1.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: Text("Join Audio",
                                              style: TextStyle(
                                                  color: Colors.indigo[900],
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        minVerticalPadding: 20,
                        focusColor: Colors.indigo[100],
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: AssetImage(img.toString()))),
                        ),
                        title: Text("${item['name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black)),
                        trailing:
                            IconButton(icon: Icon(Icons.call), onPressed: null),
                      ));
                },
                separatorBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Divider());
                },
              ));
    }
  }
}

_joinMeeting(String roomname, String name, String email) async {
  // Enable or disable any feature flag here
  // If feature flag are not provided, default values will be used
  // Full list of feature flags (and defaults) available in the README
  Map<FeatureFlagEnum, bool> featureFlags = {
    FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    FeatureFlagEnum.INVITE_ENABLED: false,
    FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
    FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
    FeatureFlagEnum.CALL_INTEGRATION_ENABLED: true,
    FeatureFlagEnum.CALENDAR_ENABLED: true,
    FeatureFlagEnum.KICK_OUT_ENABLED: true,
    FeatureFlagEnum.RECORDING_ENABLED: false,
    FeatureFlagEnum.VIDEO_MUTE_BUTTON_ENABLED: false,
    FeatureFlagEnum.LOBBY_MODE_ENABLED: true,
    FeatureFlagEnum.TILE_VIEW_ENABLED: false,
    FeatureFlagEnum.VIDEO_SHARE_BUTTON_ENABLED: false,
    FeatureFlagEnum.HELP_BUTTON_ENABLED: false,
  };
  if (!kIsWeb) {
    // Here is an example, disabling features for each platform
    if (Platform.isAndroid) {
      // Disable ConnectionService usage on Android to avoid issues (see README)
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = true;
    } else if (Platform.isIOS) {
      // Disable PIP on iOS as it looks weird
      featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    }
  }
  // Define meetings options here
  var options = JitsiMeetingOptions(room: "cleave-kaia-$roomname")
    ..serverURL = null
    ..subject = '$roomname-Drop-in'
    ..userDisplayName = name
    ..userEmail = email
    ..iosAppBarRGBAColor = null
    ..audioOnly = true
    ..userAvatarURL =
        "https://kaiaexp.000webhostapp.com/assets/images/avatarb.png"
    ..audioMuted = false
    ..videoMuted = true
    ..featureFlags.addAll(featureFlags)
    ..webOptions = {
      "roomName": "cleave-kaia-$roomname",
      "width": "100%",
      "height": "100%",
      "enableWelcomePage": false,
      "chromeExtensionBanner": null,
      "userInfo": {"displayName": ''}
    };

  debugPrint("JitsiMeetingOptions: $options");
  await JitsiMeet.joinMeeting(
    options,
    listener: JitsiMeetingListener(
      onConferenceWillJoin: (message) {
        debugPrint("${options.room} will join with message: $message");
      },
      onConferenceJoined: (message) {
        debugPrint("${options.room} joined with message: $message");
      },
      onConferenceTerminated: (message) {},
      genericListeners: [
        JitsiGenericListener(
            eventName: 'readyToClose',
            callback: (dynamic message) {
              debugPrint("readyToClose callback");
            }),
      ],
    ),
  );
}

void _onConferenceWillJoin(message) {
  debugPrint("_onConferenceWillJoin broadcasted with message: $message");
}

void _onConferenceJoined(message) {
  debugPrint("_onConferenceJoined broadcasted with message: $message");
}

void _onConferenceTerminated(message) {
  debugPrint("_onConferenceTerminated broadcasted with message: $message");
}

_onError(error) {
  debugPrint("_onError broadcasted: $error");
}

class Dropin extends StatefulWidget {
  @override
  _DropinState createState() => _DropinState();
}

class _DropinState extends State<Dropin> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            actions: [
              IconButton(onPressed: null, icon: Icon(Icons.add_circle_outline_outlined))
            ],
          ),
          body: Column(children: [
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  height: 50,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.transparent, width: 1)),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white),
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.transparent, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Friends",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.transparent, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Rooms",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.transparent, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Groups",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 15),
                    child: Getfriends(),
                  ),
                  // second tab bar viiew widget
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 15),
                    child: Rooms(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 20),
                    child: Groupss(),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}

class Rooms extends StatefulWidget {
  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/rr.png",
          fit: BoxFit.fitHeight,
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 10,
        ),
        Text("Coming Soon...",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class Getfriends extends StatefulWidget {
  @override
  _GetfriendsState createState() => _GetfriendsState();
}

class _GetfriendsState extends State<Getfriends> {
  List data = [];
  List videodata = [];
  var delete;
  bool load = true;
  final FirebaseServices _firebaseServices = FirebaseServices();
  Future fetchvideo() async {
    try {
      dynamic data = {"uid": _firebaseServices.getUserId()};
      var response = await http.post(
          Uri.parse('https://kaiaexp.000webhostapp.com/auth/getvideou.php'),
          body: json.encode(data),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          setState(() {
            videodata = json.decode(response.body);
            print(videodata);
          });
        }
      } else {
        print("error");
      }
    } catch (e) {
      print("connection problem");
    }
  }

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
                    child: Text("😢 Uhho, You have no friends connected yet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        )));
              } else {
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: ListTile(
                          onTap: () async {
                            if (snapshot.data[index]['uid'] ==
                                snapshot.data[index]['s_uid'])
                              Fluttertoast.showToast(
                                  msg: "Sorry, Its your own personal account.You can't drop-In with this account");
                                  else
                            showBarModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: 370,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300],
                                                  offset: const Offset(0, 0),
                                                  blurRadius: 1,
                                                  spreadRadius: 1.0,
                                                )
                                              ],
                                            ),
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot.data[index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 23),
                                                  ),
                                                  Text(
                                                    "Drop-In",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 19),
                                                  ),
                                                ])),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Image.asset(
                                          "assets/images/join.png",
                                          width: 280,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              MaterialButton(
                                                onPressed: () async {
                                                  fetchvideo().whenComplete(
                                                    () {
                                                      _joinMeeting(
                                                          snapshot.data[index]
                                                              ['name'],
                                                          videodata[0]['name'],
                                                          videodata[0]
                                                              ['gmail_id']);
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  height: 55,
                                                  width: 280,
                                                  decoration: BoxDecoration(
                                                      color: Colors.indigo[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  alignment: Alignment.center,
                                                  child: Text("Join Audio",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .indigo[900],
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 18)),
                                                ),
                                              ),
                                              MaterialButton(
                                                onPressed: () async {
                                                  fetchvideo().whenComplete(
                                                    () {
                                                      _joinvideoMeeting(
                                                          snapshot.data[index]
                                                              ['name'].split(
                                                                              " ")
                                                                          .sublist(
                                                                              0,
                                                                              1)
                                                                          .join(
                                                                              ""),
                                                          videodata[0]['name'],
                                                          videodata[0]
                                                              ['gmail_id']);
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                    height: 55,
                                                    width: 55,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.indigo[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.video_call,
                                                      color: Colors.indigo[900],
                                                    )),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  );
                                });
                          },
                          minVerticalPadding: 20,
                          focusColor: Colors.indigo[100],
                          leading: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/avatarb.png"))),
                          ),
                          title: Row(children: [
                            Text("${snapshot.data[index]['name']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black)),
                            SizedBox(
                              width: 20,
                            ),
                            if (snapshot.data[index]['uid'] ==
                                snapshot.data[index]['s_uid'])
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 5, bottom: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.orange[50],
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text("Personal",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black)))
                            else
                              Text("")
                          ]),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider());
                  },
                );
              }
            } else {
              return Center(
                child: Image.asset(
                  "assets/images/gi.gif",
                  width: 150,
                  height: 150,
                ),
              );
            }
          },
        ));
  }

  Future fetchData(String uid) async {
    dynamic data = {"uid": _firebaseServices.getUserId()};
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/group/getfriend.php'),
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
}

Future fetchexp(String id) async {
  var dat = {
    'id': id,
  };
  var response = await http.post(
      Uri.parse('https://kaiaexp.000webhostapp.com/split/getsplitfriend.php'),
      body: json.encode(dat),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    print(response.body);
    if (response.body.isNotEmpty) {
      // ignore: unused_local_variable
      List data = [];
      return data = json.decode(response.body);
    }
  } else {
    print("error");
  }
}

_joinvideoMeeting(String roomname, String name, String email) async {
  // Enable or disable any feature flag here
  // If feature flag are not provided, default values will be used
  // Full list of feature flags (and defaults) available in the README
  Map<FeatureFlagEnum, bool> featureFlags = {
    FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    FeatureFlagEnum.INVITE_ENABLED: false,
    FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
    FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: false,
    FeatureFlagEnum.CALL_INTEGRATION_ENABLED: true,
    FeatureFlagEnum.CALENDAR_ENABLED: true,
    FeatureFlagEnum.KICK_OUT_ENABLED: false,
    FeatureFlagEnum.RECORDING_ENABLED: false,
    FeatureFlagEnum.VIDEO_MUTE_BUTTON_ENABLED: true,
    FeatureFlagEnum.LOBBY_MODE_ENABLED: false,
    FeatureFlagEnum.TILE_VIEW_ENABLED: true,
    FeatureFlagEnum.VIDEO_SHARE_BUTTON_ENABLED: true,
    FeatureFlagEnum.HELP_BUTTON_ENABLED: false,
  };
  if (!kIsWeb) {
    // Here is an example, disabling features for each platform
    if (Platform.isAndroid) {
      // Disable ConnectionService usage on Android to avoid issues (see README)
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = true;
    } else if (Platform.isIOS) {
      // Disable PIP on iOS as it looks weird
      featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    }
  }
  // Define meetings options here
  var options = JitsiMeetingOptions(room: "cleave-kaia-$roomname")
    ..serverURL = null
    ..subject = 'Video Call'
    ..userDisplayName = name
    ..userEmail = email
    ..iosAppBarRGBAColor = null
    ..audioOnly = false
    ..userAvatarURL =
        "https://kaiaexp.000webhostapp.com/assets/images/avatarb.png"
    ..audioMuted = false
    ..videoMuted = false
    ..featureFlags.addAll(featureFlags)
    ..webOptions = {
      "roomName": "cleave-kaia-$roomname",
      "width": "100%",
      "height": "100%",
      "enableWelcomePage": false,
      "chromeExtensionBanner": null,
      "userInfo": {"displayName": ''}
    };

  debugPrint("JitsiMeetingOptions: $options");
  await JitsiMeet.joinMeeting(
    options,
    listener: JitsiMeetingListener(
      onConferenceWillJoin: (message) {
        debugPrint("${options.room} will join with message: $message");
      },
      onConferenceJoined: (message) {
        debugPrint("${options.room} joined with message: $message");
      },
      onConferenceTerminated: (message) {},
      genericListeners: [
        JitsiGenericListener(
            eventName: 'readyToClose',
            callback: (dynamic message) {
              debugPrint("readyToClose callback");
            }),
      ],
    ),
  );
}
