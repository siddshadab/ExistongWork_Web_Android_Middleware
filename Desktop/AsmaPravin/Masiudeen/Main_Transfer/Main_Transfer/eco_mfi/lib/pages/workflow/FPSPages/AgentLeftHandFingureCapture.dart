import 'dart:convert';

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../../LoginBean.dart';
import '../../../translations.dart';

class AgentLeftHandFingureCapture extends StatefulWidget {
  @override
  _AgentLeftHandFingureCapture createState() => _AgentLeftHandFingureCapture();
}

class _AgentLeftHandFingureCapture extends State<AgentLeftHandFingureCapture> {
  static int counterLeftHandFinger = 0;
  static int counterAgentLHRegist = 0;
  static String agentbioRegLHDATA = "";
  int isCalledfrmAgent = null;
  SharedPreferences prefs;
  LoginBean beanObj = new LoginBean();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      String userType = prefs.get(TablesColumnFile.userType);
      beanObj.musrcode = prefs.get(TablesColumnFile.musrcode);
      if (userType == "CUSTOMER") {
        isCalledfrmAgent = 0;
      } else if (userType == "AGENT") {
        isCalledfrmAgent = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
      onWillPop: () {
        counterLeftHandFinger = 0;
        counterAgentLHRegist = 0;
        agentbioRegLHDATA = "";
        Navigator.pop(context);
      },
      child: Center(
        child: Container(
            padding: EdgeInsets.only(
                left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
            alignment: Alignment.center,
            // color: Colors.white70,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/background_finger_capture.png"),
                fit: BoxFit.fill,
              ),
            ),

//        width: 200.0,
//        height: 100.0,
//      margin: EdgeInsets.only(left: 35.0,top:50.0),
            child: Column(
              children: <Widget>[
                new Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Constant.label_biometric_scan,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black87
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    Constant.label_please_select_lt_hand_fngr,
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                        color: Colors.black38
                        //          fontStyle: FontStyle.italic
                        ),
                  ),
                ),
                new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: LeftHandThumb(),
                      ),
                      Expanded(
                        child: LeftHandIndexFinger(),
                      ),
                      Expanded(
                        child: LeftHandMiddleFinger(),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Constant.label_thumb_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Constant.label_index_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Constant.label_middle_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: LeftHandRingFinger(),
                      ),
                      Expanded(
                        child: LeftHandPinkyFinger(),
                      ),
                      /* Expanded(
                        child: LeftHandThumb(),
                      ),*/
                    ],
                  ),
                  flex: 3,
                ),
                new Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Constant.label_ring_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Constant.label_pinky_finger,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              color: Colors.black38
                              //          fontStyle: FontStyle.italic
                              ),
                        ),
                      ),
                    ],
                  ),
                  flex: 3,
                ),
                isCalledfrmAgent == 0
                    ? new Container()
                    : new Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: new RaisedButton(
                                  child: Text(
                                    Translations.of(context).text('Register'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    await AppDatabase.get()
                                        .updateAgentBiometric(
                                            beanObj.musrcode,
                                            "LH",
                                            _AgentLeftHandFingureCapture
                                                .agentbioRegLHDATA
                                                .toString(),
                                            "")
                                        .then((int val) {
                                      print("LHDATAAA" +
                                          _AgentLeftHandFingureCapture
                                              .agentbioRegLHDATA
                                              .toString());
                                      if (val == 0) {
                                        Toast.show(
                                            "Something went wrong!!", context);
                                      } else {
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
                        flex: 3,
                      )
              ],
            )),
      ),
    );
  }
}

//  class for left hand thumb
class LeftHandThumb extends StatefulWidget {
  @override
  _LeftHandThumb createState() => new _LeftHandThumb();
}

class _LeftHandThumb extends State<LeftHandThumb> {
  String _myImage = 'assets/fpsImages/lft_hand_thumb.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.customerfingerprintlist[0].mimagesubtype !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.customerfingerprintlist[0].mimagesubtype !=
                "") {
          _myImage = 'assets/fpsImages/lft_hand_thumb_selected.png';
          _AgentLeftHandFingureCapture.counterLeftHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/lft_hand_thumb.png';
        }
      } else if (userType == "AGENT") {
        //

      }
    });
  }

  void _onClicked() {
    if (userType == "CUSTOMER") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterLeftHandFinger.toString());
      if (_AgentLeftHandFingureCapture.counterLeftHandFinger < 6) {
        _callChannelLHThumb("LhThumb");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterAgentLHRegist.toString());
      if (_AgentLeftHandFingureCapture.counterAgentLHRegist < 1) {
        _callChannelLHThumb("LhThumb");
      } else {
        Toast.show("you have already captured Left hand fingers", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );

    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHThumb(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });

        // String geTest = '$result';
        var json = JSON.decode(result);
        var LHThumbdata = json['FINGERDATA'];
        var LHThumbimagedata = json['IMAGEDATA'];

        if (LHThumbdata != null && LHThumbdata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[0].mimagesubtype = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[0].mimagestring = LHThumbdata;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[0].mimagetype = "FingerPrint";
              prefs.setString("LhThumb", LHThumbdata);

              _myImage = 'assets/fpsImages/lft_hand_thumb_selected.png';
              _AgentLeftHandFingureCapture.counterLeftHandFinger++;
            } else if (userType == "AGENT") {
              _AgentLeftHandFingureCapture.counterAgentLHRegist++;
              _AgentLeftHandFingureCapture.agentbioRegLHDATA = LHThumbdata;
              _myImage = 'assets/fpsImages/lft_hand_thumb_selected.png';

            }

            // Navigator.pop(context,fingerType+"#"+geTest );
          });
        } else {
          _myImage = 'assets/fpsImages/lft_hand_thumb.png';
        }

        print("LHThumbdata : " + LHThumbdata.toString());
        print("LHThumbimagedata : " + LHThumbimagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }

    }else{
      Toast.show("Please select a bluetooth device!", context);
    }


  }
}

// class for Index finger
class LeftHandIndexFinger extends StatefulWidget {
  @override
  _LeftHandIndexFinger createState() => new _LeftHandIndexFinger();
}

class _LeftHandIndexFinger extends State<LeftHandIndexFinger> {
  String _myImage = 'assets/fpsImages/lft_hand_index.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.customerfingerprintlist[1].mimagesubtype !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.customerfingerprintlist[1].mimagesubtype !=
                "") {
          _myImage = 'assets/fpsImages/lft_hand_index_selected.png';
          _AgentLeftHandFingureCapture.counterLeftHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/lft_hand_index.png';
        }
      } else if (userType == "AGENT") {}
    });
  }

  void _onClicked() {
    if (userType == "CUSTOMER") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterLeftHandFinger.toString());
      if (_AgentLeftHandFingureCapture.counterLeftHandFinger < 6) {
        _callChannelLHIndexFinger("LhIndexFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterAgentLHRegist.toString());
      if (_AgentLeftHandFingureCapture.counterAgentLHRegist < 1) {
        _callChannelLHIndexFinger("LhIndexFinger");
      } else {
        Toast.show("you have already captured Left hand fingers", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHIndexFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        // String geTest = '$result';
        var json = JSON.decode(result);
        var LHIndexdata = json['FINGERDATA'];
        var LHIndeximagedata = json['IMAGEDATA'];

        if (LHIndexdata != null && LHIndexdata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[1].mimagesubtype = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[1].mimagestring = LHIndexdata;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[1].mimagetype = "FingerPrint";

              _myImage = 'assets/fpsImages/lft_hand_index_selected.png';
              _AgentLeftHandFingureCapture.counterLeftHandFinger++;
            } else if (userType == "AGENT") {
              _AgentLeftHandFingureCapture.counterAgentLHRegist++;
              _AgentLeftHandFingureCapture.agentbioRegLHDATA = LHIndexdata;
              _myImage = 'assets/fpsImages/lft_hand_index_selected.png';
            }

            // Navigator.pop(context,fingerType+"#"+geTest );
          });
        } else {
          _myImage = 'assets/fpsImages/lft_hand_index.png';
        }

        print("LHIndexdata : " + LHIndexdata.toString());
        print("LHIndeximagedata : " + LHIndeximagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

  }
}

// class for middle finger
class LeftHandMiddleFinger extends StatefulWidget {
  @override
  _LeftHandMiddleFinger createState() => new _LeftHandMiddleFinger();
}

class _LeftHandMiddleFinger extends State<LeftHandMiddleFinger> {
  String _myImage = 'assets/fpsImages/lft_hand_middle.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
                    .custListBean.customerfingerprintlist[2].mimagesubtype !=
                null &&
            CustomerFormationMasterTabsState
                    .custListBean.customerfingerprintlist[2].mimagesubtype !=
                "") {
          _myImage = 'assets/fpsImages/lft_hand_middle_selected.png';
          _AgentLeftHandFingureCapture.counterLeftHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/lft_hand_middle.png';
        }
      } else if (userType == "AGENT") {}
    });
  }

  //String _myImage1 ='assets/fpsImages/lft_hand_thumb_selected.png';

  void _onClicked() {
    if (userType == "CUSTOMER") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterLeftHandFinger.toString());
      if (_AgentLeftHandFingureCapture.counterLeftHandFinger < 6) {
        _callChannelLHMiddleFinger("LhMiddleFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterAgentLHRegist.toString());
      if (_AgentLeftHandFingureCapture.counterAgentLHRegist < 1) {
        _callChannelLHMiddleFinger("LhMiddleFinger");
      } else {
        Toast.show("you have already captured Left hand fingers", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHMiddleFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        // String geTest = '$result';
        var json = JSON.decode(result);
        var LHMiddledata = json['FINGERDATA'];
        var LHMiddleimagedata = json['IMAGEDATA'];
        if (LHMiddledata != null && LHMiddledata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[2].mimagesubtype = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[2].mimagestring = LHMiddledata;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[2].mimagetype = "FingerPrint";

              _myImage = 'assets/fpsImages/lft_hand_middle_selected.png';
              _AgentLeftHandFingureCapture.counterLeftHandFinger++;
            } else if (userType == "AGENT") {
              _AgentLeftHandFingureCapture.counterAgentLHRegist++;
              _AgentLeftHandFingureCapture.agentbioRegLHDATA = LHMiddledata;
              _myImage = 'assets/fpsImages/lft_hand_middle_selected.png';
            }
          });
        } else {
          _myImage = 'assets/fpsImages/lft_hand_middle.png';
        }

        print("LHMiddledata : " + LHMiddledata.toString());
        print("LHMiddleimagedata : " + LHMiddleimagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

  }
}

// class for Ring finger
class LeftHandRingFinger extends StatefulWidget {
  @override
  _LeftHandRingFinger createState() => new _LeftHandRingFinger();
}

class _LeftHandRingFinger extends State<LeftHandRingFinger> {
  String _myImage = 'assets/fpsImages/lft_hand_ring.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
            .custListBean.customerfingerprintlist[3].mimagesubtype !=
            null &&
            CustomerFormationMasterTabsState
                .custListBean.customerfingerprintlist[3].mimagesubtype !=
                "") {
          _myImage = 'assets/fpsImages/lft_hand_ring_selected.png';
          _AgentLeftHandFingureCapture.counterLeftHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/lft_hand_ring.png';
        }
      } else if (userType == "AGENT") {}
    });
  }

  void _onClicked() {
    if (userType == "CUSTOMER") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterLeftHandFinger.toString());
      if (_AgentLeftHandFingureCapture.counterLeftHandFinger < 6) {
        _callChannelLHRingFinger("LhRingFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterAgentLHRegist.toString());
      if (_AgentLeftHandFingureCapture.counterAgentLHRegist < 1) {
        _callChannelLHRingFinger("LhRingFinger");
      } else {
        Toast.show("you have already captured Left hand fingers", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHRingFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        // String geTest = '$result';
        var json = JSON.decode(result);
        var LHRingdata = json['FINGERDATA'];
        var LHRingimagedata = json['IMAGEDATA'];

        if (LHRingdata != null && LHRingdata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[3].mimagesubtype = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[3].mimagestring = LHRingdata;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[3].mimagetype = "FingerPrint";

              _myImage = 'assets/fpsImages/lft_hand_ring_selected.png';
              _AgentLeftHandFingureCapture.counterLeftHandFinger++;
            } else if (userType == "AGENT") {
              _AgentLeftHandFingureCapture.counterAgentLHRegist++;
              _AgentLeftHandFingureCapture.agentbioRegLHDATA = LHRingdata;
              _myImage = 'assets/fpsImages/lft_hand_ring_selected.png';
            }

            // Navigator.pop(context,fingerType+"#"+geTest );
          });
        } else {
          _myImage = 'assets/fpsImages/lft_hand_ring.png';
        }

        print("LHRingdata : " + LHRingdata.toString());
        print("LHRingimagedata : " + LHRingimagedata.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

  }
}

// class for pinky finger
class LeftHandPinkyFinger extends StatefulWidget {
  @override
  _LeftHandPinkyFinger createState() => new _LeftHandPinkyFinger();
}

class _LeftHandPinkyFinger extends State<LeftHandPinkyFinger> {
  String _myImage = 'assets/fpsImages/lft_hand_pinky.png';
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;
  static const JsonCodec JSON = const JsonCodec();
  String userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.get(TablesColumnFile.userType);
      if (userType == "CUSTOMER") {
        if (CustomerFormationMasterTabsState
            .custListBean.customerfingerprintlist[4].mimagesubtype !=
            null &&
            CustomerFormationMasterTabsState
                .custListBean.customerfingerprintlist[4].mimagesubtype !=
                "") {
          _myImage = 'assets/fpsImages/lft_hand_pinky_slected.png';
          _AgentLeftHandFingureCapture.counterLeftHandFinger++;
        } else {
          _myImage == 'assets/fpsImages/lft_hand_pinky.png';
        }
      } else if (userType == "AGENT") {}
    });
  }

  void _onClicked() {
    if (userType == "CUSTOMER") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterLeftHandFinger.toString());
      if (_AgentLeftHandFingureCapture.counterLeftHandFinger < 6) {
        _callChannelLHPinkyFinger("LhPinkyFinger");
      } else {
        Toast.show("you have already captured 3 fingers", context);
      }
    } else if (userType == "AGENT") {
      print("lhcv" +
          _AgentLeftHandFingureCapture.counterAgentLHRegist.toString());
      if (_AgentLeftHandFingureCapture.counterAgentLHRegist < 1) {
        _callChannelLHPinkyFinger("LhPinkyFinger");
      } else {
        Toast.show("you have already captured Left hand fingers", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = new AssetImage(_myImage);
    var image = new Image(
      image: assetImage,
      fit: BoxFit.fitHeight,
    );
    return new Container(
      child: new FlatButton(
        onPressed: _onClicked,
        child: image,
      ),
    );
  }

  _callChannelLHPinkyFinger(String fingerType) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String userType = prefs.getString(TablesColumnFile.userType);
    if(bluetootthAdd.toString() !=null&& bluetootthAdd.toString().length >7 ){
      try {
        final String result = await platform.invokeMethod("callingForFPS", {
          "callValue": 0,
          "BluetoothADD": bluetootthAdd,
          "TYPEofFINGER": fingerType,
          "UserType": userType
        });
        // String geTest = '$result';
        var json = JSON.decode(result);
        var LHPinkydata = json['FINGERDATA'];
        var LHPinkyimagedata = json['IMAGEDATA'];

        if (LHPinkydata != null && LHPinkydata != 'null') {
          setState(() {
            if (userType == "CUSTOMER") {
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[4].mimagesubtype = fingerType;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[4].mimagestring = LHPinkydata;
              CustomerFormationMasterTabsState
                  .custListBean.customerfingerprintlist[4].mimagetype = "FingerPrint";

              _myImage = 'assets/fpsImages/lft_hand_pinky_slected.png';
              _AgentLeftHandFingureCapture.counterLeftHandFinger++;
            } else if (userType == "AGENT") {
              _AgentLeftHandFingureCapture.counterAgentLHRegist++;
              _AgentLeftHandFingureCapture.agentbioRegLHDATA = LHPinkydata;
              _myImage = 'assets/fpsImages/lft_hand_pinky_slected.png';
            }

            // Navigator.pop(context,fingerType+"#"+geTest );
          });
        } else {
          _myImage = 'assets/fpsImages/lft_hand_pinky.png';
        }

        print("LHPinkydata : " + LHPinkydata.toString());
        print("LHPinkyimagedata : " + LHPinkyimagedata.toString());
      } on PlatformException catch (e) {
        print("Flutter : " + e.message.toString());
      }
    }else{
      Toast.show("Please select a bluetooth device!", context);
    }

  }
}
