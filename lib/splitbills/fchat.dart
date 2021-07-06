import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:kaia/auth/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kaia/splitbills/splitgroup.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// ignore: must_be_immutable
class Fchat extends StatefulWidget {
  String title;
  String friendid;
  List data;
  String assetimg;
  Fchat(this.title, this.data, this.assetimg, this.friendid);
  @override
  _FchatState createState() => _FchatState();
}

class _FchatState extends State<Fchat> {
  Stream<http.Response> getmsg() async* {
    await Future.delayed(Duration(seconds: 0));
    yield await getmsga(widget.friendid);
  }

  final ScrollController _scrollController = ScrollController();
  String name;
  int scroll = 0;
  var length;
  List data = [];
  List dataa = [];
  List dataaa = [];

  @override
  void initState() {
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    fetchvideo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  Future fetchperson() async {
    var data = {
      'uid': "",
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/auth/getuser.php'),
        body: json.encode(data));

    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        name = json.decode(response.body);
      });
    } else {
      print("error");
    }
  }

  Future fetchexp() async {
    var dat = {
      'id': widget.friendid,
    };
    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getsplitfriend.php'),
        body: json.encode(dat),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        return data = json.decode(response.body);
      }
    } else {
      print("error");
    }
  }

  Future fetchexpmem(String grp) async {
    var dat = {
      'grpid': grp,
    };

    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/split/getsplitmem.php'),
        body: json.encode(dat),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.isNotEmpty) {
        return dataa = json.decode(response.body);
      }
    } else {
      print("error");
    }
  }

  Future getmsga(String grp) async {
    var dat = {
      'grpid': widget.friendid,
    };

    var response = await http.post(
        Uri.parse('https://kaiaexp.000webhostapp.com/chats/getmsg.php'),
        body: json.encode(dat),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          length = dataaa.length;
          print(length);
        });
      }
      print(response.body);
      if (response.body.isNotEmpty) {
        if (mounted) {
          setState(() {
            dataaa = json.decode(response.body);
            print(dataaa.length);
            scroll++;
            print(scroll);
          });
        }
        return response;
      }
    } else {
      print("error");
    }
  }

  List videodata = [];
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

  bool loadingvideo = false;
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    if (scroll == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.bounceIn,
          );
        }
      });
    }
    if (scroll >= 1) {
      if (dataaa.length > length) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.bounceIn,
            );
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                        image: AssetImage(widget.assetimg.toString()),
                        fit: BoxFit.fill)),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.title,
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              )
            ]),
        actions: [
          IconButton(
            icon:Image.asset("assets/images/call.png",width: 25,),
            
            onPressed: () async {
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
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 23),
                                    ),
                                    Text(
                                      "Drop-In",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
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
                                      widget.title,
                                      videodata[0]['name'],
                                      videodata[0]['gmail_id']);
                                },
                              );
                            },
                            child: Container(
                              height: 55,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.indigo[200],
                                  borderRadius: BorderRadius.circular(8)),
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
          ),
           IconButton(
            icon:Image.asset("assets/images/videocall.png",width: 25,),
            
            onPressed: () async {
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
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 23),
                                    ),
                                    Text(
                                      "Join Call",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
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
                                  _joinvideoMeeting(
                                      widget.title,
                                      videodata[0]['name'],
                                      videodata[0]['gmail_id']);
                                },
                              );
                            },
                            child: Container(
                              height: 55,
                              width: 400,
                              decoration: BoxDecoration(
                                  color: Colors.indigo[200],
                                  borderRadius: BorderRadius.circular(8)),
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
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.orange[50]),
        child: new Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: data == null
                    ? Text("loading")
                    : Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: widget.data.length,
                            reverse: true,
                            itemBuilder: (BuildContext context, index) {
                              final item = widget.data[index];
                              print(widget.data.length);
                              DateTime timee =
                                  DateTime.parse(item['timestamp']);
                              String formatDate =
                                  DateFormat('dd MMMM | hh:mm').format(timee);
                              return GestureDetector(
                                  onTap: () async {
                                   
                                    showBarModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: 350,
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text("₹ ${item['amount']}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w800)),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(item['description'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text("${item['splittype']}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text(
                                                    "Paid by: ${item['paid_by']}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                             Text(
                                                    item['grp_id']== null?"non-group":"",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text(formatDate,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 30, right: 30),
                                                  child: Divider(),
                                                ),
                                            
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                MaterialButton(
                                                    onPressed: null,
                                                    child: Container(
                                                        width: 180,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.red[900],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      150),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Settle Payments",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )))
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: 200,
                                            height: 150,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text("₹ ${item['amount']}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30, right: 30),
                                                    child: Divider(),
                                                  ),
                                                  Text(item['description'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(
                                                      "Paid by: ${item['paid_by']}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ])),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(formatDate.toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        SizedBox(
                                          height: 30,
                                        )
                                      ]));
                            }))),
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    height: 70,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        new Container(
                            width: 50.0,
                            height: 50.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Splitgrpaa()));
                              },
                            )),
                      ],
                    ))),
          ],
        ),
      ),
    );
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
    FeatureFlagEnum.LOBBY_MODE_ENABLED: false,
    FeatureFlagEnum.TILE_VIEW_ENABLED: false,
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
    FeatureFlagEnum.TILE_VIEW_ENABLED: false,
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


class Groupdetaailsa extends StatefulWidget {
  final String title;
  final String uid;
  final String admin;
  final List grpperson;
  final String assetimg;
  Groupdetaailsa(
      this.title, this.uid, this.grpperson, this.assetimg, this.admin);
  @override
  _GroupdetaailsaState createState() => _GroupdetaailsaState();
}

class _GroupdetaailsaState extends State<Groupdetaailsa> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(children: [
            Text(
              "Group Details",
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            )
          ]),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2000),
                        image: DecorationImage(
                            image: AssetImage(widget.assetimg.toString()),
                            fit: BoxFit.fill)),
                  )),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                    onPressed: null,
                    icon: Image.asset(
                      "assets/images/edit.png",
                      color: Colors.black,
                      height: 20,
                      width: 20,
                    ))
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 10,
                color: Colors.indigo[100].withOpacity(0.8),
              ),
              SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Members",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${widget.grpperson.length} People",
                  style: TextStyle(color: Colors.indigo, fontSize: 15),
                  textAlign: TextAlign.center,
                )
              ]),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: widget.grpperson.length,
                      itemBuilder: (BuildContext context, index) {
                        final item = widget.grpperson[index];

                        if (widget.admin == item['name']) {
                          return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.indigo[50]))),
                              margin: EdgeInsets.only(bottom: 5, top: 5),
                              padding: EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/avatarb.png"))),
                                  ),
                                  title: Text(item['name']),
                                  trailing: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.green[600],
                                            width: 1.5)),
                                    child: Text(
                                      'admin',
                                      style:
                                          TextStyle(color: Colors.green[500]),
                                    ),
                                  )));
                        } else {
                          return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.indigo[50]))),
                              margin: EdgeInsets.only(bottom: 5, top: 5),
                              padding: EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/avatarb.png"))),
                                ),
                                title: Text(item['name']),
                              ));
                        }
                      })),
              MaterialButton(
                  onPressed: () {
                    if (widget.admin == "") {
                      if (widget.grpperson.length == 2) {
                      } else {}
                    } else {}
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Leave Group',
                        style: TextStyle(
                            color: Colors.red[800],
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ))
            ],
          ),
        )));
  }
}
