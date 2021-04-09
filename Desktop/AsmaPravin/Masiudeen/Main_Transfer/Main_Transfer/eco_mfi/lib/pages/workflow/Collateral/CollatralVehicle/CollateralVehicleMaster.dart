import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

import 'package:eco_mfi/pages/workflow/GRT/GRTDocumentVerification.dart';
import 'package:eco_mfi/pages/workflow/GRT/GRTQuestions.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/GRTBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Arrangments.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Basics.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_ExtraInformation.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_Farming.dart';
import 'package:eco_mfi/pages/workflow/villageservey/Village_Servey_MicroEnterprises.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

import 'CollateralVehicleAcceptanceCriteriaTab.dart';
import 'CollateralVehicleBean.dart';
import 'CollateralVehicleBuyingCarTab.dart';
import 'CollateralVehicleCarPricingTab.dart';
import 'CollateralVehicleOrignalOwnerTab.dart';
import 'CollateralVehicleValuationTab.dart';
import 'CollateralVehicleValuationTab2.dart';
import 'CollateralVehicleValuationTab3.dart';
import 'CollateralVehicleValuationTab4.dart';

class CollateralVehicleMaster extends StatefulWidget {
  final collateralPassedObject;
  final collateralVehiclePassedObject;
  CollateralVehicleMaster(
      this.collateralPassedObject, this.collateralVehiclePassedObject);

  @override
  CollateralVehicleMasterState createState() =>
      new CollateralVehicleMasterState();
}

class CollateralVehicleMasterState extends State<CollateralVehicleMaster>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String branch = "";
  DateTime startTime = DateTime.now();
  final dateFormat = DateFormat("yyyy, mm, dd");
  DateTime date;
  TimeOfDay time;
  String approvalAmtLimit = "0.0";
  String mreportinguser = "";
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;

  static CollateralVehicleBean collateralVehicleBean;
  static List<int> carAcceptanceRadio = new List<int>(1);

  int tabState = 8;
  static const List<String> tabNames = const <String>[
    'Buying Car From',
    'Buying Car',
    'Car Pricing',
    'Acceptance Criteria',
    'Vehicle Valuation 1',
    'Vehicle Valuation 2',
    'Vehicle Valuation 3',
    'Vehicle Valuation 4'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 0, length: 8);

    print("widget.collateralPassedObject.loanmrefno" +
        widget.collateralPassedObject.loanmrefno.toString());
    print("widget.collateralPassedObject.loantrefno" +
        widget.collateralPassedObject.loantrefno.toString());
    print("widget.collateralPassedObject.mrefno" +
        widget.collateralPassedObject.mrefno.toString());
    print("widget.collateralPassedObject.colleteraltrefno" +
        widget.collateralPassedObject.trefno.toString());

    if (widget.collateralVehiclePassedObject != null) {
      collateralVehicleBean = widget.collateralVehiclePassedObject;
    } else {
      collateralVehicleBean = new CollateralVehicleBean();
      if (widget.collateralPassedObject.loanmrefno != "null" ||
          widget.collateralPassedObject.loanmrefno != "" ||
          widget.collateralPassedObject.loanmrefno != null) {
        collateralVehicleBean.mloanmrefno =
            widget.collateralPassedObject.loanmrefno;
      }

      if (widget.collateralPassedObject.loantrefno != "null" ||
          widget.collateralPassedObject.loantrefno != "" ||
          widget.collateralPassedObject.loantrefno != null) {
        collateralVehicleBean.mloantrefno =
            widget.collateralPassedObject.loantrefno;
      }

      if (widget.collateralPassedObject.mrefno != "null" ||
          widget.collateralPassedObject.mrefno != "" ||
          widget.collateralPassedObject.mrefno != null) {
        collateralVehicleBean.colleteralmrefno =
            widget.collateralPassedObject.mrefno;
      }

      if (widget.collateralPassedObject.trefno != "null" ||
          widget.collateralPassedObject.trefno != "" ||
          widget.collateralPassedObject.trefno != null) {
        collateralVehicleBean.colleteraltrefno =
            widget.collateralPassedObject.trefno;
      }
    }

    getSessionVariables();

    if (widget.collateralVehiclePassedObject != null) {
      collateralVehicleBean = widget.collateralVehiclePassedObject;
      CollateralVehicleMasterState.collateralVehicleBean.msrno =
          widget.collateralVehiclePassedObject.msrno;
      CollateralVehicleMasterState.collateralVehicleBean.mprdacctid =
          widget.collateralVehiclePassedObject.mprdacctid;
      CollateralVehicleMasterState.collateralVehicleBean.mlbrcode =
          widget.collateralVehiclePassedObject.mlbrcode;
      CollateralVehicleMasterState.collateralVehicleBean.msectype =
          widget.collateralVehiclePassedObject.msectype;
    } else {
      CollateralVehicleMasterState.collateralVehicleBean.msrno = 0;
      CollateralVehicleMasterState.collateralVehicleBean.mprdacctid = "0";
      CollateralVehicleMasterState.collateralVehicleBean.mlbrcode = 0;
      CollateralVehicleMasterState.collateralVehicleBean.msectype = "0";

      CollateralVehicleMasterState.collateralVehicleBean.mrefno = 0;
    }
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    if (widget.collateralVehiclePassedObject == null) {
      // if(widget.collateralVehiclePassedObject.trefno==null||widget.collateralVehiclePassedObject.trefno=="null"||widget.collateralVehiclePassedObject.trefno==0){
      await AppDatabaseExtended.get().getMaxCollateralVehicleTrefNo().then((val) {
        collateralVehicleBean.trefno = val;
      });
    }
    // }
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
      if (widget.collateralVehiclePassedObject == null) {
        CollateralVehicleMasterState.collateralVehicleBean.mcreatedby =
            username;
        CollateralVehicleMasterState.collateralVehicleBean.mcreateddt =
            DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        //callDialog();

        callBackDialog(context);
      },
      child: new Scaffold(
        //key: _scaffoldKeyMaster,
        appBar: new AppBar(
          title: new Text(
            "Vehicle Collateral",
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
            CollateralVehicleOrignalOwner(),
            CollateralVehicleBuying(),
            CollateralVehicleCarPricing(),
            CollateralVehicleAcceptanceCriteria(),
            CollateralVehicleValuation(),
            CollateralVehicleValuation2(),
            CollateralVehicleValuation3(),
            CollateralVehicleValuation4()
          ],
        ),
      ),
    );
  }

  Future<Null> _submitData() async {
    bool isValidated = await validateTabs();

    if (CollateralVehicleMasterState.collateralVehicleBean != null) {
      if (CollateralVehicleMasterState.collateralVehicleBean.mcreateddt ==
          null) {
        CollateralVehicleMasterState.collateralVehicleBean.mcreateddt =
            DateTime.now();
      }
      CollateralVehicleMasterState.collateralVehicleBean.mrefno =
          CollateralVehicleMasterState.collateralVehicleBean.mrefno != null
              ? CollateralVehicleMasterState.collateralVehicleBean.mrefno
              : 0;
      if (CollateralVehicleMasterState.collateralVehicleBean.mcreatedby ==
              null ||
          CollateralVehicleMasterState.collateralVehicleBean.mcreatedby == '' ||
          CollateralVehicleMasterState.collateralVehicleBean.mcreatedby ==
              'null') {
        CollateralVehicleMasterState.collateralVehicleBean.mcreatedby =
            username;
      }

      CollateralVehicleMasterState.collateralVehicleBean.mlastupdatedt =
          DateTime.now();
      CollateralVehicleMasterState.collateralVehicleBean.mgeolocation =
          geoLocation;
      CollateralVehicleMasterState.collateralVehicleBean.mgeologd =
          geoLongitude;
      CollateralVehicleMasterState.collateralVehicleBean.mgeolatd = geoLatitude;

      CollateralVehicleMasterState.collateralVehicleBean.missynctocoresys = 0;

      CollateralVehicleMasterState.collateralVehicleBean.mlastupdateby =
          username;
      CollateralVehicleMasterState.collateralVehicleBean.mlastsynsdate = null;

      await AppDatabaseExtended.get().updateCollateralVehicleMaster(
          CollateralVehicleMasterState.collateralVehicleBean);

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
                  Text('Vehicle Collatral Submitted Successfully'),
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
                  collateralVehicleBean = new CollateralVehicleBean();
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

  Future<bool> validateTabs() async {
    return true;

    /*  if (CollateralVehicleMasterState.collateralVehicleBean.mid == "" ||
        custListBean.imageMaster[0].imgString == null) {
      _showAlert("Customer Picture", "It is Mandatory");
      _tabController.animateTo(0);
      return false;
    }*/
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
              child: Text('ok'),
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

  bool validateSubmit() {
    String error = "";
    print("inside validate");

    if (CollateralVehicleMasterState.collateralVehicleBean.mbusinessname ==
            "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mbusinessname ==
            null) {
      _showAlert("Company Name Or Bussiness", "It is Mandatory");
      _tabController.animateTo(0);
      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mownername == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mownername == null) {
      _showAlert("Owner NAme", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mtel == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mtel == null) {
      _showAlert("Mobile Number", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.maddress1 == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.maddress1 == null) {
      _showAlert("Address Line 1", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mcountry == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mcountry == null) {
      _showAlert("Country", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mstate == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mstate == null) {
      _showAlert("Province", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mdist == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mdist == null) {
      _showAlert("District", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.msubdist == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.msubdist == null) {
      _showAlert("Communce", "It is Mandatory");
      _tabController.animateTo(0);

      return false;
    }

    if (CollateralVehicleMasterState.collateralVehicleBean.mtype == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mtype == null) {
      _showAlert("Type", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }

    if (CollateralVehicleMasterState.collateralVehicleBean.mcolor == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mcolor == null) {
      _showAlert("Color", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }

    if (CollateralVehicleMasterState.collateralVehicleBean.mbodyno == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mbodyno == null) {
      _showAlert("Body Number", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mengineno == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mengineno == null) {
      _showAlert("Engine Number", "It is Mandatory");
      _tabController.animateTo(1);

      _tabController.animateTo(1);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mchassisno == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mchassisno == null) {
      _showAlert("Chassis No", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mmadeby == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mmadeby == null) {
      _showAlert("Made by", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.midentitycarno ==
            "" ||
        CollateralVehicleMasterState.collateralVehicleBean.midentitycarno ==
            null) {
      _showAlert("Car No", "It is Mandatory");
      _tabController.animateTo(1);

      return false;
    }

    if (CollateralVehicleMasterState.collateralVehicleBean.mcarpricing == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mcarpricing ==
            null) {
      _showAlert("Car Pricing", "It is Mandatory");
      _tabController.animateTo(2);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mstdpricing == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mstdpricing ==
            null) {
      _showAlert("Standard Pricing", "It is Mandatory");
      _tabController.animateTo(2);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.minsurancepricing ==
            "" ||
        CollateralVehicleMasterState.collateralVehicleBean.minsurancepricing ==
            null) {
      _showAlert("Insurance pricing", "It is Mandatory");
      _tabController.animateTo(2);

      return false;
    }
    if (CollateralVehicleMasterState
                .collateralVehicleBean.mpriceafterevaluation ==
            "" ||
        CollateralVehicleMasterState
                .collateralVehicleBean.mpriceafterevaluation ==
            null) {
      _showAlert("Pricing After Evaluated By Branch", "It is Mandatory");
      _tabController.animateTo(2);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mltv == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mltv == null) {
      _showAlert("LTV(%)", "It is Mandatory");
      _tabController.animateTo(2);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mcartype == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mcartype == null) {
      _showAlert("Car Type", "It is Mandatory");
      _tabController.animateTo(3);

      return false;
    }
    if (CollateralVehicleMasterState.collateralVehicleBean.mltvdd == "" ||
        CollateralVehicleMasterState.collateralVehicleBean.mltvdd == null) {
      _showAlert("Loan to Value LTV", "It is Mandatory");
      _tabController.animateTo(3);

      return false;
    }

    return true;
  }
}
