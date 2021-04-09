import 'dart:async';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/UserActivity/UserActivityBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFSavingAcctClosureBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostCIFSavingAcctClosureTranstnToOmni.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CIFSavingAcctClosure extends StatefulWidget {

  final CIFBean cifBeanPassedObj;
  String mprdaccid;
  final List<CIFBean> cifBeanPassedObject;
  CIFSavingAcctClosure(this.cifBeanPassedObject, this.cifBeanPassedObj);

  @override
  _CIFSavingAcctClosureState createState() => new _CIFSavingAcctClosureState();
}

class _CIFSavingAcctClosureState extends State<CIFSavingAcctClosure> {

  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CIFSavingAcctClosureBean cifSavingAcctClosureObj = new CIFSavingAcctClosureBean();
  Utility obj = new Utility();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<CIFSavingAcctClosureBean> cifSavingAcctClosureBean;
  SharedPreferences prefs;
  String username;
  String error;
  int branch;
  bool circInd = false;
  UserActivityBean usrActBean = new UserActivityBean();
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  int custNo;
  double amt;
  String batchCd;
  int setno;
  String curCd;
  int isWasasa = 0;

  @override
  void initState() {
    super.initState();

    if (widget.cifBeanPassedObject != null) {

      cifSavingAcctClosureObj.mprdacctid = widget.cifBeanPassedObj.mprdacctid;
      cifSavingAcctClosureObj.mlbrcode = widget.cifBeanPassedObj.mlbrcode;
      cifSavingAcctClosureObj.macctstat = widget.cifBeanPassedObject[0].macctstat;
      cifSavingAcctClosureObj.mopendate = widget.cifBeanPassedObject[0].mopendate;
      cifSavingAcctClosureObj.mshadowclearbal = widget.cifBeanPassedObject[0].mshadowclearbal;
      cifSavingAcctClosureObj.mshadowtotalbal = widget.cifBeanPassedObject[0].mshadowtotalbal;
      cifSavingAcctClosureObj.mactualclearbal = widget.cifBeanPassedObject[0].mactualclearbal;
      cifSavingAcctClosureObj.mactualtotalbal = widget.cifBeanPassedObject[0].mactualtotalbal;
      cifSavingAcctClosureObj.mlcybal = widget.cifBeanPassedObject[0].mlcybal;
      cifSavingAcctClosureObj.mtotallien = widget.cifBeanPassedObject[0].mtotallien;
      cifSavingAcctClosureObj.mintapplied = widget.cifBeanPassedObject[0].mintapplied;
      cifSavingAcctClosureObj.macctstatdesc = widget.cifBeanPassedObject[0].macctstatdesc;
      custNo = widget.cifBeanPassedObj.mcustno;
      print("obj is ${cifSavingAcctClosureObj}");

    }
    getSessionVariables();

  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.musrcode);
      branch = prefs.get(TablesColumnFile.musrbrcode);
      geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
      geoLatitude = prefs.get(TablesColumnFile.mgeolatd).toString();
      geoLongitude = prefs.get(TablesColumnFile.mgeologd).toString();
      cifSavingAcctClosureObj.mcreatedby = username;
      isWasasa = prefs.getInt(TablesColumnFile.isWASASA);
    });
    AppDatabase.get().generateTrefnoUserActivityMaster().then((onValue) {
      setState(() {
        usrActBean.trefno = onValue;
      });
    });
  }

  String formatPrdAccId(String prdaccid) {
    try {
      String newprdaccid = int.parse(prdaccid.substring(8, 16)).toString() +
          "/" +
          prdaccid.substring(0, 8).toString().trim() +
          "/" +
          int.parse(prdaccid.substring(16, 24)).toString();
      return newprdaccid;
    }
    catch (_){
      print("Error in formatting prdAccId");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final body = new  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {Navigator.of(context).pop(),Navigator.of(context).pop(), }
        ),
        title: new Text(Translations.of(context).text("Saving Acct Closure")),
        backgroundColor: Color(0xff07426A),
      ),
      body:  new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        onChanged: () async{
          final FormState form = _formKey.currentState;
          form.save();
          setState(() {});
        },
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            new Container(
              height: 20.0,
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('PrdAccId')),
                subtitle: cifSavingAcctClosureObj.mprdacctid == null
                    ? new Text("")
                    : new Text(formatPrdAccId(cifSavingAcctClosureObj.mprdacctid)
                ),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('BRANCH')),
                subtitle: cifSavingAcctClosureObj.mlbrcode == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mlbrcode}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Status')),
                subtitle: cifSavingAcctClosureObj.macctstat == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.macctstat}-${cifSavingAcctClosureObj.macctstatdesc}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Open Date')),
                subtitle: cifSavingAcctClosureObj.mopendate == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mopendate.substring(6,8).toString()+"-"+
                    cifSavingAcctClosureObj.mopendate.substring(4,6).toString()+"-"+
                    cifSavingAcctClosureObj.mopendate.substring(0,4).toString()}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Shadow Clear Balance')),
                subtitle: cifSavingAcctClosureObj.mshadowclearbal == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mshadowclearbal}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Shadow Total Balance')),
                subtitle: cifSavingAcctClosureObj.mshadowtotalbal == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mshadowtotalbal}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Actual Clear Balance')),
                subtitle: cifSavingAcctClosureObj.mactualclearbal == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mactualclearbal}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Actual Toatal Balance')),
                subtitle: cifSavingAcctClosureObj.mactualtotalbal == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mactualtotalbal}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('LCY Balance')),
                subtitle: cifSavingAcctClosureObj.mlcybal == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mlcybal}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Total Lein')),
                subtitle: cifSavingAcctClosureObj.mtotallien == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mtotallien}"),
              ),
            ),
            new Card(
              child: new ListTile(
                title: new Text(Translations.of(context).text('Interest Applied')),
                subtitle: cifSavingAcctClosureObj.mintapplied == null
                    ? new Text("")
                    : new Text("${cifSavingAcctClosureObj.mintapplied}"),
              ),
            ),
            new Container(
              height: 20.0,
            ),
            FloatingActionButton.extended(
                heroTag: "btn2",
                icon: Icon(Icons.assignment_returned),
                backgroundColor: Color(0xff07426A),
                label: Text("Submit"),
                onPressed: () async {
                  if (cifSavingAcctClosureObj.mactualtotalbal != 0.0 &&
                      cifSavingAcctClosureObj.mactualtotalbal != null &&
                      isWasasa == 1) {
                    _ShowOmniMsg("Account Balance Should be 0.0", 9);
                    return;
                  }

                  submit(cifSavingAcctClosureObj);
                }),
          ],
        ),
      ),
    );
    return new WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();Navigator.of(context).pop();
      },
      child : new Container(
        decoration: new BoxDecoration(
          color: const Color(0xFF273A48),
        ),
        child: new Stack(
          children: <Widget>[
            new CustomPaint(
              size: new Size(_width, _height),
            ),
            body,
          ],
        ),
      ),
    );

  }


  Future<void> submit(CIFSavingAcctClosureBean cifSavingAcctClosureObj)  async{

    Future<bool> onPop(BuildContext context, String agrs1, String args2,String pageRoutedFrom) {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(agrs1),
          content: new Text(args2),
          actions: <Widget>[
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: new Text('No'),
            ),
            new FlatButton(
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                circInd = true;
                _ShowProgressInd(context);

                setState(() {
                  isDataSynced = true;
                  circIndicatorIsDatSynced = true;
                });

                PostCIFSavingAcctClosureTranstnToOmni postCIFSavingAcctClosureTranstnToOmni = new PostCIFSavingAcctClosureTranstnToOmni();
                postCIFSavingAcctClosureTranstnToOmni.trySave(cifSavingAcctClosureObj).then((List<CIFSavingAcctClosureBean> cifSavingAcctClosureBean) async {

                  this.cifSavingAcctClosureBean = cifSavingAcctClosureBean;
                  print("cifSavingAcctClosureBean" + cifSavingAcctClosureBean.toString());

                  bool netAvail = false;
                  netAvail = await obj.checkIfIsconnectedToNetwork();
                  if (netAvail == false) {
                    showMessageWithoutProgress("Network Not available");
                    return;
                  }
                  else{
                    print('omnimsg');
                    print(cifSavingAcctClosureBean[0].momnimsg);
                    bool isSuccess = false;

                    if(cifSavingAcctClosureBean[0].momnimsg != null || cifSavingAcctClosureBean[0].momnimsg != "null" || cifSavingAcctClosureBean[0].momnimsg != ""){

                      if(cifSavingAcctClosureBean[0].momnimsg.toLowerCase().contains("success"))isSuccess=true;
                      try{
                        UpdateUserActivityMaster(cifSavingAcctClosureBean);
                      } catch (e) {}
                          _ShowOmniMsg(
                              cifSavingAcctClosureBean[0].momnimsg, isSuccess);
                      circInd = false;
                    }
                  }
                });
              },
              child: new Text('Yes'),
            ),
          ],
        ),
      ) ??
          false;
    }

    onPop(context, Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Do_You_Want_To_Proceed'), Translations.of(context).text('CollectionSubmit'));
  }


  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Future<void> _ShowOmniMsg(String momnimsg, isSuccess) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Text(momnimsg)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
                  globals.sessionTimeOut.SessionTimedOut();
                  if (isSuccess == 9) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> _ShowProgressInd(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).text('Please_Wait')),
          content: SingleChildScrollView(
              child: SpinKitCircle(color: Colors.teal)
          ),
        );
      },
    );
  }

  UpdateUserActivityMaster(List<CIFSavingAcctClosureBean> cifSavingAcctClosureUsrObj) async {
    print("UpdateUserActivityMaster");
    usrActBean.mcreateddt = DateTime.now();
    usrActBean.musercode = username;
    usrActBean.mlbrcode = cifSavingAcctClosureObj.mlbrcode;
    usrActBean.mcustno = custNo;
    print("cifSavingAcctClosureUsrObj[0].mval : ${cifSavingAcctClosureUsrObj[0]
        .mval}");
    amt = 0.0;
    batchCd = "";
    setno = 0;

    if (cifSavingAcctClosureUsrObj[0].momnimsg != null &&
        cifSavingAcctClosureUsrObj[0].momnimsg != "" &&
        cifSavingAcctClosureUsrObj[0].momnimsg != 'N') {
      setno = int.parse(cifSavingAcctClosureUsrObj[0].momnimsg.substring(7, 9));
    }
    if (cifSavingAcctClosureUsrObj[0].mval != null &&
        cifSavingAcctClosureUsrObj[0].mval != "") {
      //D!1702!99999999~M6000~120~0!MMK!DR!10!Closure Int!TR!10!1
      List mvalList = cifSavingAcctClosureUsrObj[0].mval.split("!");
      curCd = mvalList[3];
      amt = double.parse(mvalList[5]);
      batchCd = mvalList[7];
    }
    //usrActBean.mcenterid =
    // usrActBean.mgroupcd =
    usrActBean.mtxnamount = amt;
    //usrActBean.msystemnarration = cifBeanObj.mnarration;
    //usrActBean.musernarration = cifBeanObj.mremark;
    usrActBean.mactivity = "CLOSURE";
    usrActBean.screenname = "Saving Closure";
    usrActBean.mmoduletype = 11;
    //usrActBean.mtxnreno = cifUsrObj[0].momnitxnrefno;
    print("cifSavingAcctClosureObj.mentrydate : ${cifSavingAcctClosureObj.mentrydate}");
    usrActBean.mcorerefno =
        cifSavingAcctClosureObj.mlbrcode.toString() + "/" + cifSavingAcctClosureUsrObj[0].mentrydate + "/" + batchCd +
            "/" + setno.toString();
    usrActBean.status = "Success";
    usrActBean.mcreateddt = DateTime.now();
    usrActBean.mcreatedby = username;
    usrActBean.mlastupdatedt = DateTime.now();
    usrActBean.mlastupdateby = null;
    usrActBean.mgeolocation = geoLocation;
    usrActBean.mgeolatd = geoLatitude;
    usrActBean.mgeologd = geoLongitude;
    usrActBean.missynctocoresys = 0;
    usrActBean.mlastsynsdate = null;
    usrActBean.mrefno = 0;
    if (setno != 0){
      await AppDatabase.get()
          .updateUserActivityMaster(usrActBean)
          .then((val) {
        //print("val here is " + val.toString());
      });
      if (batchCd == 'CASH') {
        String diffInBal = "+${amt}";
        await AppDatabase.get().updateUserVaultBalance(
            cifSavingAcctClosureObj.mlbrcode, username, curCd, diffInBal);
      }
    }


  }

}
