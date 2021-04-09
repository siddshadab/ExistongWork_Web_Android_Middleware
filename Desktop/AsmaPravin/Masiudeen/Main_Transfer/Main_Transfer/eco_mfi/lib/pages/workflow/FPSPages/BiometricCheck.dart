import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerFingerPrintBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/FPSPages/AgentLeftHandFingureCapture.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentRightHandFingureCapture.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../../translations.dart';

class BiometricCheck extends StatefulWidget {
  // BiometricCheck({this.mIsCustomerSelected});

  @override
  _BiometricCheck createState() => _BiometricCheck();
}

class _BiometricCheck extends State<BiometricCheck> {
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
          new Text(
            "Biometric Check",
            textAlign: TextAlign.center,
          ),
        ]));
  }
}

class FingerScannerImageAsset extends StatefulWidget {
  int trefno;
  int mrefno;
  final String mIsCustomerSelected;
  final bool isButtonDisabled;
  final bool isOnline;
  final int custno;
  final String routeType;
  //bool checkResult = false;
  final ValueChanged<bool> checkResult;

  FingerScannerImageAsset(
      {this.mIsCustomerSelected,
      this.mrefno,
      this.trefno,
      this.isButtonDisabled,
      this.isOnline,
      this.custno,
      this.routeType,
      this.checkResult});

  _FingerScannerImageAsset createState() => _FingerScannerImageAsset();
}

class _FingerScannerImageAsset extends State<FingerScannerImageAsset> {
  List<CustomerFingerPrintBean> bean = new List<CustomerFingerPrintBean>();
  String _myImage = 'assets/fpsImages/finger_scan_logo_grey.png';

  AssetImage assetImage =
      AssetImage('assets/fpsImages/finger_scan_logo_grey.png');

  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  SharedPreferences prefs;

  String LhThumbValue = "";
  String LhIndexFingerValue = "";
  String LhMiddleFingerValue = "";
  String LhRingFingerValue = "";
  String LhPinkyFingerValue = "";

  String RhThumbValue = "";
  String RhIndexFingerValue = "";
  String RhMiddleFingerValue = "";
  String RhRingFingerValue = "";
  String RhPinkyFingerValue = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var assetImage = new AssetImage(_myImage);

    Image image = Image(
      image: assetImage,
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      width: 100.0,
      height: 100.0,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        if (widget.mIsCustomerSelected == "Y") {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String bluetootthAdd =
              prefs.getString(TablesColumnFile.bluetoothAddress);
          print("bT>>> $bluetootthAdd");
          if (bluetootthAdd.toString() != null &&
              bluetootthAdd.toString().length > 7) {
            getFingure();
          } else {
            Toast.show("Please select a bluetooth device!", context);
          }
        } else {
          Toast.show("Please Select Customer First", context);
        }
      },
      child: image,
    );
  }

  Future<Null> getFingure() async {
    prefs = await SharedPreferences.getInstance();
    print("Is Online ${widget.mIsCustomerSelected}");
    print("customer number ${widget.custno}");
    print("customer number ${widget.isOnline}");

    if (widget.mIsCustomerSelected == "Y") {
      //get finger print
      LhThumbValue = "";
      LhIndexFingerValue = "";
      LhMiddleFingerValue = "";
      LhRingFingerValue = "";
      LhPinkyFingerValue = "";
      RhThumbValue = "";
      RhIndexFingerValue = "";
      RhMiddleFingerValue = "";
      RhRingFingerValue = "";
      RhPinkyFingerValue = "";

      if (widget.isOnline == true) {
        await AppDatabaseExtended.get()
            .getFingerListByCustNo(widget.custno)
            .then((List<CustomerFingerPrintBean> fingerPrintBean) async {
          bean = fingerPrintBean;
          if (bean.isNotEmpty) {
            print(" Found in Appdatabase");
            setImage(bean);
          } else {
            print("Not Found in Appdatabase Trying online");
            GetCustomerFromMiddleware getBiometricData =
                GetCustomerFromMiddleware();
            await getBiometricData
                .getFingerPrint(widget.custno)
                .then((List<CustomerFingerPrintBean> fingerPrintBean) {
              bean = fingerPrintBean;
              if (bean.isNotEmpty) {
                print("Returning Bean ${bean}");
                setImage(bean);
              } else {
                Toast.show("Fingure Prints Not Matched!!", context);
                return;
              }
            });
          }
        });
      } else {
        await AppDatabaseExtended.get()
            .getFingerList(widget.trefno, widget.mrefno)
            .then((List<CustomerFingerPrintBean> cutomerFingerPrintList) {
          bean = cutomerFingerPrintList;
          if (bean.isNotEmpty) {
            for (int i = 0; i < bean.length; i++) {
              print("bean" + bean.toString());
              if (bean[i].mimagesubtype == "LhThumb") {
                // prefs.setString("LhThumb", bean[0].imgString);
                LhThumbValue = bean[i].mimagestring;
              }
              if (bean[i].mimagesubtype == "LhIndexFinger") {
                // prefs.setString("LhIndexFinger", bean[0].imgString);
                LhIndexFingerValue = bean[i].mimagestring;
              }
              if (bean[i].mimagesubtype == "LhMiddleFinger") {
                // prefs.setString("LhMiddleFinger", bean[0].imgString);
                LhMiddleFingerValue = bean[i].mimagestring;
              }
              if (bean[i].mimagesubtype == "LhRingFinger") {
                // prefs.setString("LhRingFinger", bean[i].imgString);
                LhRingFingerValue = bean[i].mimagestring;
              }
              if (bean[i].mimagesubtype == "LhPinkyFinger") {
                //  prefs.setString("LhPinkyFinger", bean[i].imgString);
                LhPinkyFingerValue = bean[i].mimagestring;
              }

              if (bean[i].mimagesubtype == "RhThumb") {
                print("Setting RH THUMb");
//            prefs.setString("RhThumb", bean[i].imgString);
                RhThumbValue = bean[i].mimagestring;
              }
              if (bean[i].mimagesubtype == "RhIndexFinger") {
                print("Setting RH Index Fingure");
                // prefs.setString("RhIndexFinger", bean[i].imgString);
                RhIndexFingerValue = bean[i].mimagestring;
              }
              if (bean[i].mimagesubtype == "RhMiddleFinger") {
                print("Setting RH Middle Fingure");
                // prefs.setString("RhMiddleFinger", bean[i].imgString);
                RhMiddleFingerValue = bean[i].mimagestring;
              }
              if (bean[i].mimagesubtype == "RhRingFinger") {
                //  prefs.setString("RhRingFinger", bean[i].imgString);
                RhRingFingerValue = bean[i].mimagestring;
              }
              if (bean[i].mimagesubtype == "RhPinkyFinger") {
                // prefs.setString("RhPinkyFinger", bean[i].imgString);
                RhPinkyFingerValue = bean[i].mimagestring;
              }
            }
          } else {
            Toast.show("Fingure Prints Not Found!!", context);
            return;
          }
        });
      }
    }

    await _callChannelFPSMatch();
  }

  _callChannelFPSMatch() async {
    //  prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("Sending Value is $RhMiddleFingerValue");
    print("Sending Value is $RhIndexFingerValue");
    print("Sending Value is  for LH Index $LhIndexFingerValue");
    print("Sending Value is  LH MIDDle $LhMiddleFingerValue");
    print("Sending Value is  LH Thumb $LhThumbValue");
    try {
      final String result = await platform.invokeMethod("callingForFPSMatch", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "LhThumbValue": LhThumbValue,
        "LhIndexFingerValue": LhIndexFingerValue,
        "LhMiddleFingerValue": LhMiddleFingerValue,
        "LhRingFingerValue": LhRingFingerValue,
        "LhPinkyFingerValue": LhPinkyFingerValue,

        "RhThumbValue": RhThumbValue,
        "RhIndexFingerValue": RhIndexFingerValue,
        "RhMiddleFingerValue": RhMiddleFingerValue,
        "RhRingFingerValue": RhRingFingerValue,
        "RhPinkyFingerValue": RhPinkyFingerValue,
        // TODO pass dynamic blutooth address
      });
      String geTest = '$result';

      if (result == '-5') {
        setState(() {
          if (widget.routeType != "Disbursment")
            _myImage = 'assets/fpsImages/finger_scan_logo_green.png';
          globals.fingerPrintAuthForTDDone = true;
          if (widget.checkResult != null) widget.checkResult(true);

          if (widget.routeType == "Loan Application") {
            print("Setting Value trye");
            globals.fingerPrintAuthForLoanApplicationDone = true;
          }
          // Navigator.pop(context, true);
        });
      } else if (result == '-1') {
        setState(() {
          if (widget.checkResult != null) widget.checkResult(false);
          if (widget.routeType != "Disbursment")
            _myImage = 'assets/fpsImages/finger_scan_logo_black.png';
          //  Navigator.pop(context, false);
          globals.fingerPrintAuthForTDDone = false;
          if (widget.routeType == "Loan Application") {
            globals.fingerPrintAuthForLoanApplicationDone = false;
          }
          _showAlertForFPSMismatch();
        });
      } else if (result == '0') {
        setState(() {
          // widget.checkResult =;
          if (widget.checkResult != null) widget.checkResult(false);
          if (widget.routeType != "Disbursment")
            _myImage = 'assets/fpsImages/finger_scan_logo_black.png';
          //  Navigator.pop(context, false);
          globals.fingerPrintAuthForTDDone = false;
          if (widget.routeType == "Loan Application") {
            globals.fingerPrintAuthForLoanApplicationDone = false;
          }
          _showAlertForFPSMismatch();
        });
      }
      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }

  Future<void> _showAlertForFPSMismatch() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              "Finger Print not Found!! For continuing further Please Accept the Declaration"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            /* FlatButton(
              child: Text(Translations.of(context).text('Yes')),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                //saveData();
                Navigator.of(context).pop();
                setState(() {

                });
              },
            ),*/
            FlatButton(
              child: Text("Ok"),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      setState(() {});
    });
  }
//Your code here

  void setImage(List<CustomerFingerPrintBean> fingerPrintBean) {
    for (int i = 0; i < bean.length; i++) {
      print("bean" + bean.toString());
      if (bean[i].mimagesubtype == "LhThumb") {
        print("Setting fro LHTHUMB");
        // prefs.setString("LhThumb", bean[0].imgString);
        LhThumbValue = bean[i].mimagestring;
      }
      if (bean[i].mimagesubtype == "LhIndexFinger") {
        print("Setting fro Lh Index Fingure");
        // prefs.setString("LhIndexFinger", bean[0].imgString);
        LhIndexFingerValue = bean[i].mimagestring;
      }
      if (bean[i].mimagesubtype == "LhMiddleFinger") {
        // prefs.setString("LhMiddleFinger", bean[0].imgString);
        LhMiddleFingerValue = bean[i].mimagestring;
      }
      if (bean[i].mimagesubtype == "LhRingFinger") {
        // prefs.setString("LhRingFinger", bean[i].imgString);
        LhRingFingerValue = bean[i].mimagestring;
      }
      if (bean[i].mimagesubtype == "LhPinkyFinger") {
        //  prefs.setString("LhPinkyFinger", bean[i].imgString);
        LhPinkyFingerValue = bean[i].mimagestring;
      }

      if (bean[i].mimagesubtype == "RhThumb") {
        print("Setting For Rh Thumb");
//            prefs.setString("RhThumb", bean[i].imgString);
        RhThumbValue = bean[i].mimagestring;
      }
      if (bean[i].mimagesubtype == "RhIndexFinger") {
        // prefs.setString("RhIndexFinger", bean[i].imgString);
        print("Settinh For index Finger");
        print(bean[i].mimagestring);
        RhIndexFingerValue = bean[i].mimagestring;
      }
      if (bean[i].mimagesubtype == "RhMiddleFinger") {
        print("Settinh For middle Finger");
        print(bean[i].mimagestring);
        // prefs.setString("RhMiddleFinger", bean[i].imgString);
        RhMiddleFingerValue = bean[i].mimagestring;
      }
      if (bean[i].mimagesubtype == "RhRingFinger") {
        //  prefs.setString("RhRingFinger", bean[i].imgString);
        RhRingFingerValue = bean[i].mimagestring;
      }
      if (bean[i].mimagesubtype == "RhPinkyFinger") {
        // prefs.setString("RhPinkyFinger", bean[i].imgString);
        RhPinkyFingerValue = bean[i].mimagestring;
      }
    }
  }
}
