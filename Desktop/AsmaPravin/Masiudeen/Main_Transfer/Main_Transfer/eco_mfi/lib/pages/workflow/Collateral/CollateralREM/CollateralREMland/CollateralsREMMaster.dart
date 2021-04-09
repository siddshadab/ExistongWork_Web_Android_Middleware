import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/workflow/Collateral/CollateralREM/Bean/CollateralREMlandandhouseBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../translations.dart';
import 'CollateralREMlandandbuilding.dart';
import 'CollateralREMlandandhouse.dart';

class CollateralsREMMaster extends StatefulWidget {
  final collateralPassedObject;
  final collateralREMPassedObject;
  //CollateralsREMMaster({Key key, this.collateralPassedObject}) : super(key: key);

  CollateralsREMMaster(
      this.collateralPassedObject, this.collateralREMPassedObject);
  @override
  CollateralsREMMasterState createState() => new CollateralsREMMasterState();
}

class CollateralsREMMasterState extends State<CollateralsREMMaster>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String branch = "";
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;

  DateTime startTime = DateTime.now();
  final dateFormat = DateFormat("yyyy, mm, dd");
  DateTime date;
  TimeOfDay time;
  String approvalAmtLimit = "0.0";
  String mreportinguser = "";

  static CollateralREMlandandhouseBean collateralREMlandandhouseBean =
      CollateralREMlandandhouseBean();

  int tabState = 2;
  static const List<String> tabNames = const <String>[
    'REM Land And House',
    'REM Land And Building'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 2);

    if (widget.collateralREMPassedObject != null) {
      collateralREMlandandhouseBean = widget.collateralREMPassedObject;
    } else {
      collateralREMlandandhouseBean = new CollateralREMlandandhouseBean();
      if (widget.collateralPassedObject.loanmrefno != "null" ||
          widget.collateralPassedObject.loanmrefno != "" ||
          widget.collateralPassedObject.loanmrefno != null) {
        collateralREMlandandhouseBean.mloanmrefno =
            widget.collateralPassedObject.loanmrefno;
      }

      if (widget.collateralPassedObject.loantrefno != "null" ||
          widget.collateralPassedObject.loantrefno != "" ||
          widget.collateralPassedObject.loantrefno != null) {
        collateralREMlandandhouseBean.mloantrefno =
            widget.collateralPassedObject.loantrefno;
      }

      if (widget.collateralPassedObject.mrefno != "null" ||
          widget.collateralPassedObject.mrefno != "" ||
          widget.collateralPassedObject.mrefno != null) {
        collateralREMlandandhouseBean.colleteralmrefno =
            widget.collateralPassedObject.mrefno;
      }

      if (widget.collateralPassedObject.trefno != "null" ||
          widget.collateralPassedObject.trefno != "" ||
          widget.collateralPassedObject.trefno != null) {
        collateralREMlandandhouseBean.colleteraltrefno =
            widget.collateralPassedObject.trefno;
      }

      collateralREMlandandhouseBean.mfname =
          widget.collateralPassedObject.mfname;
      collateralREMlandandhouseBean.mmname =
          widget.collateralPassedObject.mmname;
      collateralREMlandandhouseBean.mlname =
          widget.collateralPassedObject.mlname;
      collateralREMlandandhouseBean.mtitle =
          widget.collateralPassedObject.nametitle;
    }

    getSessionVariables();

    if (widget.collateralREMPassedObject != null) {
      collateralREMlandandhouseBean = widget.collateralREMPassedObject;
      CollateralsREMMasterState.collateralREMlandandhouseBean.msrno =
          widget.collateralREMPassedObject.msrno;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mprdacctid =
          widget.collateralREMPassedObject.mprdacctid;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mlbrcode =
          widget.collateralREMPassedObject.mlbrcode;
    } else {
      CollateralsREMMasterState.collateralREMlandandhouseBean.msrno = 0;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mprdacctid = "00";
      CollateralsREMMasterState.collateralREMlandandhouseBean.mlbrcode = 0;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mcreatedby =
          username;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mcreateddt =
          DateTime.now();
    }
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    if (widget.collateralREMPassedObject == null) {
      //if(widget.collateralREMPassedObject.trefno==null||widget.collateralREMPassedObject.trefno=="null"||widget.collateralREMPassedObject.trefno==0){
      await AppDatabase.get()
          .getMaxCollateralREMlandandhouseTrefNo()
          .then((val) {
        CollateralsREMMasterState.collateralREMlandandhouseBean.trefno = val;
        // print("trefno"+CollateralsREMMasterState.collateralREMlandandhouseBean.trefno.toString());
      });
      //    }
    }

    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      reportingUser = prefs.getString(TablesColumnFile.reportingUser);
      if (widget.collateralREMPassedObject == null) {
        CollateralsREMMasterState.collateralREMlandandhouseBean.mcreatedby =
            username;
        CollateralsREMMasterState.collateralREMlandandhouseBean.mcreateddt =
            DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        callBackDialog(context);
      },
      child: new Scaffold(
        //key: _scaffoldKeyMaster,
        appBar: new AppBar(
          title: new Text(
            "Collateral Land And Property",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
              callBackDialog(context);
            },
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          bottom: new TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: new List.generate(tabNames.length, (index) {
              return new Tab(text: tabNames[index].toUpperCase());
            }),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                if (!validateSubmit()) {
                  return;
                }
                _submitData();
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: new TabBarView(
          controller: _tabController,
          children: <Widget>[
            CollateralREMlandandhouse(),
            CollateralREMLandAndBuilding()
          ],
        ),
      ),
    );
  }

  Future<Null> _submitData() async {
    if (CollateralsREMMasterState.collateralREMlandandhouseBean != null) {
      if (CollateralsREMMasterState.collateralREMlandandhouseBean.mcreateddt ==
          null) {
        CollateralsREMMasterState.collateralREMlandandhouseBean.mcreateddt =
            DateTime.now();
      }
      CollateralsREMMasterState.collateralREMlandandhouseBean.mrefno =
          CollateralsREMMasterState.collateralREMlandandhouseBean.mrefno != null
              ? CollateralsREMMasterState.collateralREMlandandhouseBean.mrefno
              : 0;
      if (CollateralsREMMasterState.collateralREMlandandhouseBean.mcreatedby ==
              null ||
          CollateralsREMMasterState.collateralREMlandandhouseBean.mcreatedby ==
              '' ||
          CollateralsREMMasterState.collateralREMlandandhouseBean.mcreatedby ==
              'null') {
        CollateralsREMMasterState.collateralREMlandandhouseBean.mcreatedby =
            username;
      }

      CollateralsREMMasterState.collateralREMlandandhouseBean.mlastupdatedt =
          DateTime.now();
      CollateralsREMMasterState.collateralREMlandandhouseBean.mgeolocation =
          geoLocation;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mgeologd =
          geoLongitude;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mgeolatd =
          geoLatitude;

      CollateralsREMMasterState.collateralREMlandandhouseBean.missynctocoresys =
          0;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mlastupdateby =
          username;
      CollateralsREMMasterState.collateralREMlandandhouseBean.mlastsynsdate =
          null;

      await AppDatabaseExtended.get().updateCollateralREMlandandhouseMaster(
          CollateralsREMMasterState.collateralREMlandandhouseBean);

      _successfulSubmit();
    }
  }

  Future<void> _successfulSubmit() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('REM Collatral Submitted Successfully'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<bool> onPop(BuildContext context, String agrs1, String args2) async {
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
                  _submitData();
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> callBackDialog(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content:
                new Text('Do you want to Go To Loan List without saving data'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('No'),
              ),
              new FlatButton(
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  collateralREMlandandhouseBean =
                      new CollateralREMlandandhouseBean();
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);

//                CustomerFormationMasterTabsState.applicantDob ="__-__-____";
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  bool validateSubmit() {
    String error = "";
    print("inside validate");

    if (CollateralsREMMasterState.collateralREMlandandhouseBean.maddress1 ==
            "" ||
        CollateralsREMMasterState.collateralREMlandandhouseBean.maddress1 ==
            null) {
      _showAlert("Address Line 1", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralsREMMasterState.collateralREMlandandhouseBean.mcountry ==
            "" ||
        CollateralsREMMasterState.collateralREMlandandhouseBean.mcountry ==
            null) {
      _showAlert("Country", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralsREMMasterState.collateralREMlandandhouseBean.mstate == "" ||
        CollateralsREMMasterState.collateralREMlandandhouseBean.mstate ==
            null) {
      _showAlert("Province", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralsREMMasterState.collateralREMlandandhouseBean.mdist == "" ||
        CollateralsREMMasterState.collateralREMlandandhouseBean.mdist == null) {
      _showAlert("District", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralsREMMasterState.collateralREMlandandhouseBean.msubdist ==
            "" ||
        CollateralsREMMasterState.collateralREMlandandhouseBean.msubdist ==
            null) {
      _showAlert("Commune", "It is Mandatory");
      return false;
    }

    if (CollateralsREMMasterState
                .collateralREMlandandhouseBean.msizeofproperty ==
            "" ||
        CollateralsREMMasterState
                .collateralREMlandandhouseBean.msizeofproperty ==
            null) {
      _showAlert("Size of Property", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    /*   if (CollateralsREMMasterState.collateralREMlandandhouseBean.msizeofpropertyl == "" ||CollateralsREMMasterState.collateralREMlandandhouseBean.msizeofpropertyl== null) {
      _showAlert("Size of Property For Land", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }*/
    if (CollateralsREMMasterState.collateralREMlandandhouseBean.mltitleowener ==
            "" ||
        CollateralsREMMasterState.collateralREMlandandhouseBean.mltitleowener ==
            null) {
      _showAlert("Title Owner For Land", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }
    if (CollateralsREMMasterState.collateralREMlandandhouseBean.mhtitleowener ==
            "" ||
        CollateralsREMMasterState.collateralREMlandandhouseBean.mhtitleowener ==
            null) {
      _showAlert("Title Owner For House", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }
    /*  if (CollateralsREMMasterState.collateralREMlandandhouseBean.mlsizeprop == "" ||CollateralsREMMasterState.collateralREMlandandhouseBean.mlsizeprop== null) {
      _showAlert("Size Property For LAnd", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }*/

    if (CollateralsREMMasterState
                .collateralREMlandandhouseBean.mlsumonvalprop ==
            "" ||
        CollateralsREMMasterState
                .collateralREMlandandhouseBean.mlsumonvalprop ==
            null) {
      _showAlert("Summary on value property for land", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }
    if (CollateralsREMMasterState
                .collateralREMlandandhouseBean.mhsumonvalprop ==
            "" ||
        CollateralsREMMasterState
                .collateralREMlandandhouseBean.mhsumonvalprop ==
            null) {
      _showAlert("Summary on value property for house", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }
    return true;
  }

  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('ok')),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
