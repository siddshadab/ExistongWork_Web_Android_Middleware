import 'dart:async';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ContactPointVerificationBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerFingerPrintBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/Verhoeff.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/ProspectView.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/SMSVerification.dart';
import 'package:permission/permission.dart';
//import 'package:speech_recognition/speech_recognition.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationPersonalInfo.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationSocialFinancialDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CIFList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/PPIBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/CheckExistingCustomerFromMiddleware.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCIFInfoFromOmni.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingCustomerToMiddleware.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/GeoPointsLocator.dart';

class CustomerList extends StatefulWidget {
  final firstParms;

  //CustomerList(this.cameras);
  final String type;
  CustomerList(this.firstParms, this.type);

  @override
  _CustomerList createState() => new _CustomerList();
}

class _CustomerList extends State<CustomerList> {
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  DateTime lastSyncedToServerDaeTime = null;
  Utility obj = new Utility();

  Future<bool> callDialog() {
    globals.Dialog.onPop(context, Translations.of(context).text('Are_You_Sure'),
        'Do you want to Go To DashBoard', "CustomerList");
  }

  List<int> indicesList = new List<int>();
  List<CustomerListBean> customerBeanList = new List<CustomerListBean>();
  Widget appBarTitle = new Text("Customer List");
  Icon actionIcon = new Icon(Icons.search);
  Icon actionIconMic = new Icon(Icons.mic);
  int count = 1;
  int highmarkValidity = 0;
  List<CIFBean> cifBean;
  int mIsProspectRepeatNeeded = 0;
  final String nidPaddingSpaces = "                              ";
  bool circInd = false;
  //SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  String resultText = "";
  String resultTextSearch = "";
  String getPermission = '';
  String username;


  @override
  void initState() {
    items.clear();
    super.initState();
    requestPermission();
    //initSpeechRecognizer();
    getsharedPreferences();
    setState(() {

    });
  }
 /* void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );
    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );
    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );
    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );
    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }*/

 /* void cancel() =>
      _speechRecognition.cancel().then((result) => setState(() => _isListening = result));

  void stop() =>
      _speechRecognition.stop().then((result) => setState(() => _isListening = result));
*/
  getsharedPreferences() async {
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1, false)
        .then((onValue) async {
      lastSyncedToServerDaeTime = onValue;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(TablesColumnFile.mValidity) != null &&
        prefs.getString(TablesColumnFile.mValidity).trim() != "")
      highmarkValidity = int.parse(prefs.getString(TablesColumnFile.mValidity));
    if (prefs.getString(TablesColumnFile.mIsProspectRepeatNeeded) != null &&
        prefs.getString(TablesColumnFile.mIsProspectRepeatNeeded).trim() != "")
      mIsProspectRepeatNeeded =
          int.parse(prefs.getString(TablesColumnFile.mIsProspectRepeatNeeded));
    /*SystemParameterBean  sysBean = await AppDatabase.get().getSystemParameter(1,101);*/
    // print(highmarkValidity);
    setState(() {
      username = prefs.getString(TablesColumnFile.musrcode);
    });

  }

  List<CustomerListBean> items = new List<CustomerListBean>();
  List<CustomerListBean> storedItems = new List<CustomerListBean>();

  /* void filterList(String val) async{
    print("inside filterList");
    items.clear();
    items = new List<CustomerListBean>();


    storedItems.forEach((obj) {
      if (obj.mmobno.toString().contains(val) |
          obj.trefno.toString().toLowerCase().contains(val) |
          obj.mcenterid.toString().contains(val) |
          obj.mgroupcd.toString().contains(val) |
          obj.mlongname.toString().contains(val) |
          //obj.mmobno.toString().contains(val) |
          obj.mcustno.toString().contains(val)*/ /*obj.mcustno!=null && obj.mcustno!='null'?obj.mcustno.toString().toLowerCase().contains(val):false*/ /* ) {
        print("inside contains");
        print(items);
        items.add(obj);
      }
    });

    setState(() {});
  }*/

  void filterList(String val) async {
    // print("inside filterList");
    items.clear();
    items = new List<CustomerListBean>();

    storedItems.forEach((obj) {
      if (obj.mmobno.toString().contains(val) |
      obj.trefno.toString().toLowerCase().contains(val) |
      obj.mcenterid.toString().contains(val) |
      obj.mgroupcd.toString().contains(val) |
      obj.mlongname.toString().toUpperCase().contains(val.toUpperCase()) |
      obj.mpannodesc.toString().toUpperCase().contains(val.toUpperCase()) |
      obj.mIdDesc.toString().toUpperCase().contains(val.toUpperCase()) |
      //obj.mmobno.toString().contains(val) |
      obj.mcustno.toString().contains(
          val) /*obj.mcustno!=null && obj.mcustno!='null'?obj.mcustno.toString().toLowerCase().contains(val):false*/) {
        //  print("inside contains");
        //  print(items);
        items.add(obj);
      }
    });

    setState(() {});
  }

  getHomePageBody2(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {

      return new RefreshIndicator(
        child: new ListView.builder(
          itemCount: items.length,
          itemBuilder: _getItemUI2,
          padding: EdgeInsets.all(0.0),
        ),
        onRefresh:()async{ await _onRefresh().then((onValue){
          setState(() {

          });
        });},
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    //print(items);
    double c_width = MediaQuery.of(context).size.width * 10;
    bool isSyncOn = false;
    String longName = items[index].mlongname.toString() != null &&
            items[index].mlongname.toString() != 'null'
        ? items[index].mlongname.toString()
        : "";
    String mlastupdatedt ="";
    try{
       mlastupdatedt = items[index].mlastupdatedt != null &&
          items[index].mlastupdatedt.toString() != 'null'
          ? items[index].mlastupdatedt.toString()
          : "";
    }catch(_){}
    bool isSyncedIndex = false;

    if (/*items[index].mmobilelastsynsdate == null ||
        items[index].mmobilelastsynsdate== 'null' ||
        (items[index].mcreateddt != null &&
            items[index].mcreateddt != 'null' &&
            items[index].mcreateddt.isAfter(items[index].mmobilelastsynsdate)) ||
        (items[index].mlastupdatedt != null &&
            items[index].mlastupdatedt != 'null' &&
            items[index].mlastupdatedt.isAfter(items[index].mmobilelastsynsdate)) ||*/
        (items[index].missynctocoresys == null || items[index].missynctocoresys == 0)) {
      isSyncedIndex = true;
    }

    //TODO applicant DOB hai bhai created dt nahi
    DateTime applicantDob =
    items[index].mcreateddt != null && items[index].mcreateddt != 'null'
        ? items[index].mcreateddt
        : DateTime.now();
    String centerNumber = items[index].mcenterid.toString() != null &&
        items[index].mcenterid.toString() != 'null'
        ? items[index].mcenterid.toString()
        : "";
    String groupNumber = items[index].mgroupcd.toString() != null &&
        items[index].mgroupcd.toString() != 'null'
        ? items[index].mgroupcd.toString()
        : "";
    String errorMsg = "";
    if(items[index].merrormessage != null &&
        items[index].merrormessage.toString() != "" &&
        items[index].merrormessage.toString() != "null"
    ){

      try{
        int.parse(items[index].merrormessage.trim());
        errorMsg = "System Busy Please try again ${items[index].merrormessage.trim()}";
        isSyncOn = true;
      }catch(_){
        errorMsg = items[index].merrormessage;
      }
    }

    String cycle = items[index].mtier.toString() != 'null'
        ? items[index].mtier.toString()
        : "";

    bool showErrMsg = true;
    if (errorMsg == "null" || errorMsg == "" || errorMsg == null) {
      showErrMsg = false;
    }
    String tempCustStatus = "";

    try{

      for(int i=0;i<globals.dropdownCaptionsValuesProfileDetails[2].length;i++){
        if(items[index].mcuststatus.toString()==globals.dropdownCaptionsValuesProfileDetails[2][i].mcode.toString()){
          tempCustStatus =  globals.dropdownCaptionsValuesProfileDetails[2][i].mcodedesc;
        }

      }
    }catch(_){

    }
    bool mappingAwailable = true;
    if(items[index].mgeolatd==null||items[index].mgeologd==null||
        items[index].mgeolatd.trim()=='null'||items[index].mgeologd.trim()=='null'
        ||items[index].mgeolatd.trim()==''||items[index].mgeologd.trim()==''
    ){
      mappingAwailable=false;
    }
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        globals.customerNumber = items[index].trefno.toString();
        _onTapItem(context, items[index]);
      },
      child: new Card(
        //color Color(0xff2f1f4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 25.0,
        child: new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 3.0),

                // width: c_width,
                child: Container(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          ThemeDesign.loginGradientEnd,
                          ThemeDesign.loginGradientStart,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  //color: color,
                  child: Column(
                    children: <Widget>[
                      new Text(
                        //firstName+" "+middleName+" "+lastName,
                        longName,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                "Trefno:" +
                                    items[index].trefno.toString() +
                                    "   ",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              Text(
                                "Mrefno:" + items[index].mrefno.toString() !=
                                    null
                                    ? items[index].mrefno.toString()
                                    : "Sync To get Mrefno",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    new Icon(
                                      FontAwesomeIcons.user,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                    Text(
                                      items[index].mcustno.toString() != null &&
                                          items[index].mcustno.toString() !=
                                              'null'
                                          ? items[index].mcustno.toString()
                                          : "",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),

                                    Padding(
                                      padding: new EdgeInsets.only(
                                          left: 30.0, right: 30.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          new Text(
                                            tempCustStatus,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.yellowAccent),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              new Container (
                child: new Row (
                  children: [
                    new Expanded(
                      child: new Text (errorMsg,
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.red[500]),
                          ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration (
                  // backgroundColor: Colors.grey[300],
                ),
                width: 400.0,
              ),
              new Container(
                width: c_width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5.0,
                            ),

                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              children: <Widget>[


                                items[index].mpannodesc.toString() != null ||
                                    items[index].mpannodesc.toString() != ""
                                    ? Text(
                                  "NID :" +
                                      items[index].mpannodesc.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                )
                                    : Text(
                                  "NID :" + nidPaddingSpaces.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                ),
                                Padding(
                                  padding: new EdgeInsets.only(
                                      left: 10.0, right: 8.0),
                                  child: new Text(
                                    DateFormat("yyyy, MM, dd")
                                        .format(applicantDob),
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                SizedBox(
                  height: 8.0,
                ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: new EdgeInsets.only(
                                      left: 10.0, right: 8.0),
                                  child: new Text(
                                    mlastupdatedt,
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(
                                /*   top: 1.0,
                                  bottom: 1.0,*/
                              ),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  Text(
                                    "   GNO: ${groupNumber}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "CNO: ${centerNumber}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  Text(
                                    "    Cycle: ${cycle}",
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.grey[500]),
                                  ),

                                ],
                              ),
                            ),


                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(
                                /* top: 1.0,
                                  bottom: 1.0,*/
                              ),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                //crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  new Icon(Icons.phone,
                                      color: Colors.green, size: 18.0),
                                  new Text(
                                    items[index].mmobno.toString(),
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                    new ButtonTheme.bar(
                      padding: new EdgeInsets.all(2.0),
                      child: new ButtonBar(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          widget.type == "Loan Application" ||widget.type == "Others" ||
                              widget.type == "Loan collection"||widget.type == "Saving Collection"
                              ? null
                              : new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.mapPin,
                              color: mappingAwailable==true?Colors.orange[400]:Colors.grey,
                              size: 25.0,
                            ),
                             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                              if(mappingAwailable==true){
                                viewonMap(items[index].mgeolatd,items[index].mgeologd);
                              }
                              else{
                                showMessageWithoutProgress("Geo-Cordinates Not Available");
                              }
                            },
                          ), widget.type == "Loan Application" ||widget.type == "Others" ||
                              widget.type == "Loan collection" ||
                              mIsProspectRepeatNeeded == 0||widget.type == "Saving Collection"
                              ? null
                              : new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.clipboardCheck,
                              color: (items[index].misCbCheckDone == 1 ||
                                  items[index].misCbCheckDone ==
                                      2) &&
                                  DateTime.now().difference(
                                      items[index]
                                          .mcbcheckrprtdt) <=
                                      Duration(days: highmarkValidity)
                                  ? Colors.grey
                                  : Colors.green,
                              size: 25.0,
                            ),
                            onPressed: () async {
                              if ((items[index].misCbCheckDone == 1 ||
                                  items[index].misCbCheckDone == 2) &&
                                  DateTime.now().difference(
                                      items[index].mcbcheckrprtdt) <
                                      Duration(days: highmarkValidity)) {
                                showMessageWithoutProgress(
                                    "Highmark Result is "
                                        "${items[index].misCbCheckDone == 1 ? 'Pass' : 'Fail'}");
                              } else {
                                _cnfrmCreateProspect(items[index]);
                              }
                            },
                          ),
                          widget.type == "Loan Application" ||widget.type == "Others" ||
                              widget.type == "Loan collection"||widget.type == "Saving Collection"
                              ? null
                              : new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.chartPie,
                              color: Colors.orange[400],
                              size: 25.0,
                            ),
                            /*onPressed: () async {
                              showMessageWithoutProgress(
                                  "Customer 360 will be developed later on");
                            },*/

                            onPressed: () /*{ loadCIFPage(items[index].mcustno, items[index].mpannodesc.toString());},*/
                            async {
                              circInd = true;
                              _ShowProgressInd(context);
                              loadCIFPage(items[index].mcustno, items[index].mpannodesc.toString());
                            },

                          ),
                          widget.type == "Loan Application" ||widget.type == "Others" ||
                              widget.type == "Loan collection"||widget.type == "Saving Collection"
                              ? null
                              : isSyncedIndex
                              ? new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.sync,
                              color: Colors.orange[400],
                              size: 25.0,
                            ),
                            onPressed: () async {
                              _syncCustomerToMiddleware(items[index]);
                            },
                          )
                              : new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.sync,
                              color: Colors.grey,
                              size: 25.0,
                            ),
                            onPressed: () async {
                              showMessageWithoutProgress(
                                  Translations.of(context).text("Customer Already Synced"));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var futureBuilderNotSynced;
    if (count == 1) {
      count++;
      try {
        //print(CustomerListBean);
        futureBuilderNotSynced = new FutureBuilder(
            future: AppDatabase.get()
                .selectCustomerList()
                .then((List<CustomerListBean> customerData) {
              items.clear();
              storedItems.clear();
              customerData.forEach((f) {
                if (widget.type == "Loan Application") {
                  if ((f.mcuststatus==1||f.mcustno==0||f.mcustno==null)&&f.misCbCheckDone == 1) {
                    items.add(f);
                    storedItems.add(f);
                  } else if ((f.mcuststatus==1||f.mcustno==0||f.mcustno==null)&&mIsProspectRepeatNeeded == 0) {
                    items.add(f);
                    storedItems.add(f);
                  }
                }else if (widget.type == "Others") {

                  if (f.misCbCheckDone == 1) {
                    items.add(f);
                    storedItems.add(f);
                  } else if (mIsProspectRepeatNeeded == 0) {
                    items.add(f);
                    storedItems.add(f);
                  }
                  }
                  else if (widget.type == "Loan collection") {
                  if (f.mcustno !=null  && f.mcustno > 0) {
                    if (widget.firstParms == false) {
                      if (f.mcenterid == 0) {
                        items.add(f);
                        storedItems.add(f);
                      }
                    } else {
                      items.add(f);
                      storedItems.add(f);
                    }
                  }
                }else if (widget.type == "Saving Collection") {

                  if(f.mcustno==0||f.mcustno==null){
                    if (widget.firstParms == false) {
                      print("Coming inside this");
                      if (f.mcenterid == 0||f.mcenterid==null) {
                        items.add(f);
                        storedItems.add(f);
                      }
                    } else {
                      if(f.mcenterid != 0&&f.mcenterid!=null){
                        items.add(f);
                        storedItems.add(f);
                      }

                    }
                  }

                }


                else {
                  items.add(f);
                  storedItems.add(f);
                }

              });
              return storedItems;
            }).then((onValue){
              String custListLeng = storedItems != null &&
                  storedItems.length != null &&
                  storedItems.length > 0
                  ? "/" + storedItems.length.toString()
                  : "";
              this.appBarTitle =
              new Text("Customer List" + custListLeng);

              setState(() {

              });
            }),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('Press button to start');
                case ConnectionState.waiting:
                  return new Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      child:
                      new CircularProgressIndicator()); // new Text('Awaiting result...');
                default:
                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');
                  else
                    return getHomePageBody2(context, snapshot);
              }
            });
      } catch (e) {
        futureBuilderNotSynced = new Text("Nothing To display");
      }
    } else if (items != null) {
      futureBuilderNotSynced =  new RefreshIndicator(
        child: new ListView.builder(
          // Must have an item count equal to the number of items!
          itemCount: items.length,
          // A callback that will return a widget.
          itemBuilder: (context, position) {
            /*      Color color;
          if (position % 2 == 1) {
            // color = Color(0xffe8eaf6);
            color = Colors.brown[50];
          } else {
            color = Colors.white;
          }*/
          double c_width = MediaQuery.of(context).size.width * 10;
          String longName = items[position].mlongname.toString() != null &&
              items[position].mlongname.toString() != 'null'
              ? items[position].mlongname.toString()
              : "";
          String firstName = items[position].mfname.toString() != null &&
              items[position].mfname.toString() != 'null'
              ? items[position].mfname.toString()
              : "";
          String middleName = items[position].mmname.toString() != null &&
              items[position].mmname.toString() != 'null'
              ? items[position].mmname.toString()
              : "";
          String lastName = items[position].mlname.toString() != null &&
              items[position].mlname.toString() != 'null'
              ? items[position].mlname.toString()
              : "";
          DateTime applicantDob = items[position].mcreateddt != null &&
              items[position].mcreateddt != 'null'
              ? items[position].mcreateddt
              : DateTime.now();
          String centerNumber = items[position].mcenterid.toString() != null &&
              items[position].mcenterid.toString() != 'null'
              ? items[position].mcenterid.toString()
              : "";
          String groupNumber = items[position].mgroupcd.toString() != null &&
              items[position].mgroupcd.toString() != 'null'
              ? items[position].mgroupcd.toString()
              : "";
          String errorMsg = "";


          if(items[position].merrormessage != null &&
              items[position].merrormessage.toString() != "" &&
              items[position].merrormessage.toString() != "null"
          ){

            try{
              int.parse(items[position].merrormessage.trim());
              errorMsg = "System Busy Please try again ${items[position].merrormessage.trim()}";
            }catch(_){
              errorMsg = items[position].merrormessage;
            }
          }
          bool showErrMsg = true;
          if (errorMsg == "null" || errorMsg == "" || errorMsg == null) {
            showErrMsg = false;
          }

          bool isSyncedPosition = false;

            String mlastupdatedt ="";
            try{
              mlastupdatedt = items[position].mlastupdatedt != null &&
                  items[position].mlastupdatedt.toString() != 'null'
                  ? items[position].mlastupdatedt.toString()
                  : "";
            }catch(_){}
            if (/*items[position].mmobilelastsynsdate == null ||
                items[position].mmobilelastsynsdate== 'null' ||
                (items[position].mcreateddt != null &&
                    items[position].mcreateddt != 'null' &&
                    items[position]
                        .mcreateddt
                        .isAfter(items[position].mmobilelastsynsdate)) ||
                (items[position].mlastupdatedt != null &&
                    items[position].mlastupdatedt != 'null' &&
                    items[position]
                        .mlastupdatedt
                        .isAfter(items[position].mmobilelastsynsdate)) ||*/
                (items[position].missynctocoresys == null || items[position].missynctocoresys == 0)||
                
                (items[position].merrormessage!=null&&items[position].merrormessage!="null"&&items[position].merrormessage.trim()!="")
                ) {
              isSyncedPosition = true;
            }


          String tempCustStatus = "";

          try{
            for(int i=0;i<globals.dropdownCaptionsValuesProfileDetails[2].length;i++){
              if(items[position].mcuststatus.toString()==globals.dropdownCaptionsValuesProfileDetails[2][i].mcode.toString()){
                tempCustStatus =  globals.dropdownCaptionsValuesProfileDetails[2][i].mcodedesc;
              }

            }
          }catch(_){

          }


          bool mappingAwailable = true;
          if(items[position].mgeolatd==null||items[position].mgeologd==null||
              items[position].mgeolatd.trim()=='null'||items[position].mgeologd.trim()=='null'
              ||items[position].mgeolatd.trim()==''||items[position].mgeologd.trim()==''
          ){
            mappingAwailable=false;
          }

          String cycle = items[position].mtier.toString() != 'null'
              ? items[position].mtier.toString()
              : "";

          // In our case, a DogCard for each doggo.
          return new GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              globals.customerNumber = items[position].trefno.toString();
              _onTapItem(context, items[position]);
            },
            child: new Card(
              //color Color(0xff2f1f4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 25.0,
              child: new Padding(
                padding: new EdgeInsets.only(
                  left: 3.0,
                  right: 3.0,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 3.0),

                      // width: c_width,
                      child: Container(
                        decoration: new BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [
                                ThemeDesign.loginGradientEnd,
                                ThemeDesign.loginGradientStart,
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        //color: color,
                        child: Column(
                          children: <Widget>[
                            new Text(
                              //firstName+" "+middleName+" "+lastName,
                              longName,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Container(
                                padding: EdgeInsets.only(left: 5.0),
                                //color: Colors.green,
                                child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      "Trefno:" +
                                          items[position].trefno.toString() +
                                          "  ",
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    Text(
                                      "Mrefno:" +
                                                  items[position]
                                                      .mrefno
                                                      .toString() !=
                                              null
                                          ? items[position].mrefno.toString()
                                          : "Sync To get Mrefno",
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    Padding(
                                      padding: new EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          new Icon(
                                            FontAwesomeIcons.user,
                                            color: Colors.white,
                                            size: 18.0,
                                          ),
                                          Text(
                                            items[position]
                                                            .mcustno
                                                            .toString() !=
                                                        null &&
                                                    items[position]
                                                            .mcustno
                                                            .toString() !=
                                                        'null'
                                                ? items[position]
                                                    .mcustno
                                                    .toString()
                                                : "",
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                            ),
                                          ),

                                          Padding(
                                            padding: new EdgeInsets.only(
                                                left: 30.0, right: 30.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                new Text(
                                                  tempCustStatus,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.yellowAccent),
                                                ),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    new Container (
                      child: new Row (
                        children: [
                          new Expanded(
                            child: new Text (errorMsg,
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.red[500]),
                            ),
                          ),
                        ],
                      ),
                      decoration: new BoxDecoration (
                        // backgroundColor: Colors.grey[300],
                      ),
                      width: 400.0,
                    ),
                    new Container(
                      width: c_width,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),

                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: <Widget>[



                                      items[position].mpannodesc.toString() !=
                                                  null ||
                                              items[position]
                                                      .mpannodesc
                                                      .toString() !=
                                                  ""
                                          ? Text(
                                              "NID :" +
                                                  items[position]
                                                      .mpannodesc
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[500],
                                              ),
                                            )
                                          : Text(
                                              "NID :" +
                                                  nidPaddingSpaces.toString(),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 10.0, right: 8.0),
                                        child: new Text(
                                          DateFormat("yyyy, MM, dd")
                                              .format(applicantDob),
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 10.0, right: 8.0),
                                        child: new Text(
                                          mlastupdatedt,
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.only(
                                        /*   top: 1.0,
                                  bottom: 1.0,*/
                                        ),
                                    child: new Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      children: <Widget>[
                                        Text(
                                          "   GNO: ${groupNumber}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          "CNO: ${centerNumber}",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                        Text(
                                          "    Cycle: ${cycle}",
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.grey[500]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.only(
                                        /* top: 1.0,
                                  bottom: 1.0,*/
                                        ),
                                    child: new Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                                      children: <Widget>[
                                        new Icon(Icons.phone,
                                            color: Colors.green, size: 18.0),
                                        new Text(
                                          items[position].mmobno.toString(),
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),





                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          new ButtonTheme.bar(
                            padding: new EdgeInsets.all(2.0),
                            child: new ButtonBar(
                              children: <Widget>[
                                widget.type == "Loan Application" ||widget.type == "Others" ||
                                    widget.type == "Loan collection"||widget.type == "Saving Collection"
                                    ? null
                                    : new IconButton(
                                  icon: new Icon(
                                    FontAwesomeIcons.mapPin,
                                    color: mappingAwailable==true?Colors.orange[400]:Colors.grey,
                                    size: 25.0,
                                  ),
                                   onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                    if(mappingAwailable==true){
                                      viewonMap(items[position].mgeolatd,items[position].mgeologd);
                                    }
                                    else{
                                      showMessageWithoutProgress("Geo-Cordinates Not Available");
                                    }
                                  },
                                ),
                                widget.type == "Loan Application" ||widget.type == "Others" ||
                                    widget.type == "Loan collection" ||
                                    mIsProspectRepeatNeeded == 0||widget.type == "Saving Collection"
                                    ? null
                                    : new IconButton(
                                  icon: new Icon(
                                    FontAwesomeIcons.clipboardCheck,
                                    color: (items[position]
                                        .misCbCheckDone ==
                                        1 ||
                                        items[position]
                                            .misCbCheckDone ==
                                            2) &&
                                        DateTime.now().difference(
                                            items[position]
                                                .mcbcheckrprtdt) <=
                                            Duration(
                                                days:
                                                highmarkValidity)
                                        ? Colors.grey
                                        : Colors.green,
                                    size: 25.0,
                                  ),
                                  onPressed: () async {
                                    if ((items[position].misCbCheckDone ==
                                        1 ||
                                        items[position]
                                            .misCbCheckDone ==
                                            2) &&
                                        DateTime.now().difference(
                                            items[position]
                                                .mcbcheckrprtdt) <
                                            Duration(
                                                days: highmarkValidity)) {
                                      showMessageWithoutProgress(
                                          "Highmark Result is "
                                              "${items[position].misCbCheckDone == 1 ? 'Pass' : 'Fail'}");
                                    } else {
                                      _cnfrmCreateProspect(
                                          items[position]);
                                    }
                                  },
                                ),
                                widget.type == "Loan Application" ||widget.type == "Others" ||
                                    widget.type == "Loan collection"||widget.type == "Saving Collection"
                                    ? null
                                    : new IconButton(
                                  icon: new Icon(
                                    FontAwesomeIcons.chartPie,
                                    color: Colors.orange[400],
                                    size: 25.0,
                                  ),
                                  /*onPressed: () async {
                                    showMessageWithoutProgress(
                                        "Customer 360 will be devloped lateron");
                                  },*/
                                  onPressed: () /*{ loadCIFPage(items[position].mcustno , items[position].mpannodesc.toString());},*/
                                  async {
                                    circInd = true;
                                    _ShowProgressInd(context);
                                    loadCIFPage(items[position].mcustno, items[position].mpannodesc.toString());
                                  },
                                ),
                                widget.type == "Loan Application" ||widget.type == "Others" ||
                                    widget.type == "Loan collection"||widget.type == "Saving Collection"
                                    ? null
                                    : isSyncedPosition
                                    ? new IconButton(
                                  icon: new Icon(
                                    FontAwesomeIcons.sync,
                                    color: Colors.orange[400],
                                    size: 25.0,
                                  ),
                                  onPressed: () async {
                                    _syncCustomerToMiddleware(
                                        items[position]);
                                  },
                                )
                                    : new IconButton(
                                  icon: new Icon(
                                    FontAwesomeIcons.sync,
                                    color: Colors.grey,
                                    size: 25.0,
                                  ),
                                  onPressed: () async {
                                    showMessageWithoutProgress(
                                        "Customer Already Synced");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        ),
        onRefresh:()async{ await _onRefresh().then((onValue){
          setState(() {

          });
        });},
      );
    } else
      futureBuilderNotSynced = new Text("nothing to display");
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
        },
        child: new Scaffold(
          key: _scaffoldHomeState,
          appBar: new AppBar(
              elevation: 3.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Color(0xff07426A),
              brightness: Brightness.light,
              title: appBarTitle,
              actions: <Widget>[
                new IconButton(
                  icon: actionIcon,
                   onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                    setState(() {
                      String custListLeng = storedItems != null &&
                          storedItems.length != null &&
                          storedItems.length > 0
                          ? "/" + storedItems.length.toString()
                          : "";
                      this.appBarTitle =
                      new Text("Customer List" + custListLeng);
                      if (this.actionIcon.icon == Icons.search) {
                        this.actionIcon = new Icon(Icons.close);
                        this.appBarTitle = new TextField(
                          style: new TextStyle(
                            color: Colors.white,
                          ),
                          decoration: new InputDecoration(
                              prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                              hintText: "Search...",
                              hintStyle: new TextStyle(color: Colors.white)),
                          onChanged: (val) {
                            filterList(val.toLowerCase());
                          },
                        );
                      } else {
                        String custListLeng = storedItems != null &&
                            storedItems.length != null &&
                            storedItems.length > 0
                            ? "/" + storedItems.length.toString()
                            : "";
                        this.actionIcon = new Icon(Icons.search);
                        // this.actionIcon = new Icon(Icons.mic);
                        this.appBarTitle =
                        new Text("Customer List" + custListLeng.toString());
                        items = new List<CustomerListBean>();
                        items.clear();
                        storedItems.forEach((val) {
                          items.add(val);
                        });
                      }
                    });
                  },
                ),
                new IconButton(
                  icon: actionIconMic,
                  onPressed: () async{

                    setState(() {
                      if (this.actionIconMic.icon == Icons.mic) {
                        this.actionIconMic = new Icon(Icons.close);
                        if (_isAvailable && !_isListening) {
                         /* _speechRecognition.listen(locale: "en_US").then(
                                  (result) async{
                                _speechRecognition.setRecognitionResultHandler(
                                      (String speech) => setState(() {
                                    this.appBarTitle = new ListTile(
                                      title: new Text(
                                        "Searching..",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                        ),),
                                      subtitle: speech ==
                                          null
                                          ? new Text("")
                                          : new Text(
                                        "${speech}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                        ),),
                                    );
                                    speech!=null && speech!=''?filterList(speech!=null?speech.toLowerCase():""):null;
                                  }),
                                );

                              }
                          );*/
                        }
                      }else if( this.actionIconMic.icon  == Icons.close){
                       /* _isListening ?stop():null;
                        _isListening ? cancel() : null;*/
                        String custListLeng = storedItems != null &&
                            storedItems.length != null &&
                            storedItems.length > 0
                            ? "/" + storedItems.length.toString()
                            : "";
                        this.actionIconMic = new Icon(Icons.mic);
                        this.appBarTitle =
                        new Text("Customer List" + custListLeng.toString());
                        items = new List<CustomerListBean>();
                        items.clear();
                        storedItems.forEach((val) {
                          items.add(val);
                        });
                      } else{
                        String custListLeng = storedItems != null &&
                            storedItems.length != null &&
                            storedItems.length > 0
                            ? "/" + storedItems.length.toString()
                            : "";
                        this.actionIconMic = new Icon(Icons.mic);
                        this.appBarTitle =
                        new Text("Customer List" + custListLeng.toString());
                        items = new List<CustomerListBean>();
                        items.clear();
                        storedItems.forEach((val) {
                          items.add(val);
                        });
                      }
                    }

                    );
                  },
                ),
              ]),
          floatingActionButton: widget.type == "Loan Application" ||widget.type == "Others" ||
              widget.type == "Loan Utilization" ||
              widget.type == "Loan collection"||widget.type == "Saving Collection"
              ? null
              : new FloatingActionButton(
              child: new Icon(
                Icons.add,
                color: Colors.black,
              ),
              //backgroundColor: Color(0xff07426A),
              backgroundColor: Colors.green,
              onPressed: //_insertDummies
              loadNewCustomerRequestPage),
          body: new Container(
              color: const Color(0xff07426A), child: futureBuilderNotSynced),
        ));
  }

  void loadNewCustomerRequestPage() async {AppDatabase.get()
      .selectCustomerList()
      .then((List<CustomerListBean> customerData) {});
    isCustFoundInDedup=false;
    Constant.assetsVisible(false,null);
    await AppDatabase.get().generateCustomerNumber().then((onValue) {
      //  print("Setting Customer Number ${onValue}");
      CustomerFormationMasterTabsState.custListBean.trefno = onValue;
      CustomerFormationMasterTabsState.custListBean.mismodify  = 1 ;
      globals.customerType = "new customer";
      /*ImageBean img = new ImageBean();
      CustomerFormationMasterTabsState.custListBean.imageMaster =  new List<ImageBean>();
      CustomerFormationMasterTabsState.custListBean.imageMaster.add(img);*/
      /*CustomerFormationMasterTabsState.custListBean.imageMaster =
      new List<ImageBean>();
*/
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      CustomerFormationMasterTabsState.custListBean.mpanno = prefs.getInt(TablesColumnFile.NIDDEFAULTTYPE);
      setState(() {
      });
    }catch(_){}

    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new CustomerFormationMasterTabs(
              widget.firstParms,
              null)), //When Authorized Navigate to the next screen
    );
  }

  Future<void> loadCIFPage(int custno , String nid) async {

    setState(() {
      //isDataSynced = true;
      //circIndicatorIsDatSynced = true;
    });

    GetCIFInfoFromOmni getCIFInfoFromOmni =
    new GetCIFInfoFromOmni();
    await getCIFInfoFromOmni.trySave(custno, nid).then((List<CIFBean> cifBean) async {
      this.cifBean = cifBean;
      // print("cifBean" + cifBean.toString());

      bool netAvail = false;
      netAvail = await obj.checkIfIsconnectedToNetwork();
      if (netAvail == false) {
        showMessageWithoutProgress(Translations.of(context).text("Network Not available"));
        return;
      }
      else{
        if (cifBean.isEmpty) {

          _CheckIfThere();
        }
        else
        {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new CIFList(cifBean)),
            // When Authorized Navigate to the next screen
          );
        }
      }
    });
  }

  Future<void> _CheckIfThere() async {

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.cancel,
              color: Colors.red,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(Translations.of(context).text("accountnotfound")),
                    ],
                  ),
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
                },
              ),
            ],
          );
        });
  }




  IconData getIcon(bool isNegative) {
    IconData icon;
    isNegative ? icon = Icons.arrow_drop_down : icon = Icons.arrow_drop_up;
    return icon;
  }

  void printIt(String ab) {
    // print(ab);
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(new SnackBar(
      backgroundColor: color,
      content: new Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          new Text(message)
        ],
      ),
      duration: Duration(seconds: 20),
    ));
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }


  void showMessageWithoutProgressGreen(String message,
      [MaterialColor color = Colors.green]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }
  void _onTapItem(BuildContext context, CustomerListBean bean) async {
    isCustFoundInDedup=false;
    isDedupDone=true;
    if (widget.type == "Loan Application" || widget.type == "Others" ||widget.type == "Loan collection"||widget.type == "Saving Collection") {
      Navigator.of(context).pop(bean);
    } else if (widget.type == "Loan Utilization") {
      Navigator.of(context).pop(bean);
    } else if (widget.type == "Savings List") {
      Navigator.of(context).pop(bean);
    } else {
      //check later if cb is done



      await AppDatabase.get().getCenterName(bean.mcenterid).then((val) async {
        bean.mcentername = val;
      });
      // print(bean.mcentername);
      await AppDatabase.get().getGroupName(bean.mgroupcd).then((val) async {
        bean.mgroupname = val;
      });
      //   print(bean.mgroupname);
      //bean.misCbCheckDone =1;
      bean.addressDetails = new List<AddressDetailsBean>();
      bean.familyDetailsList = new List<FamilyDetailsBean>();
      bean.pPIMasterBean = new List<PPIMasterBean>();
      bean.borrowingDetailsBean = new List<BorrowingDetailsBean>();
      bean.imageMaster = new List<ImageBean>();
      bean.businessExpendDetailsList =
      new List<BusinessExpenditureDetailsBean>();
      bean.householdExpendDetailsList =
      new List<HouseholdExpenditureDetailsBean>();
      bean.assetDetailsList = new List<AssetDetailsBean>();
      bean.customerfingerprintlist = new List<CustomerFingerPrintBean>();

      for (int i = 0; i < 13; i++) {
        bean.imageMaster.add(new ImageBean());
      }

      for (int i = 0; i < 10; i++) {
        bean.customerfingerprintlist.add(new CustomerFingerPrintBean());
      }

      await AppDatabase.get()
          .selectCustomerFamilyDetailsListIsDataSynced(bean.trefno, bean.mrefno)
          .then((List<FamilyDetailsBean> familyDetailsBean) async {
        for (int i = 0; i < familyDetailsBean.length; i++) {
          bean.familyDetailsList.add(familyDetailsBean[i]);
        }
        // print("Family Details list is ${bean.familyDetailsList}");
      });

      await AppDatabase.get()
          .selectCustomerBorrowingDetailsListIsDataSynced(
          bean.trefno, bean.mrefno)
          .then((List<BorrowingDetailsBean> borrowingDetailsBean) async {
        for (int i = 0; i < borrowingDetailsBean.length; i++) {
          bean.borrowingDetailsBean.add(borrowingDetailsBean[i]);
        }

        //  print("Borrowing  Details list is ${bean.borrowingDetailsBean}");
      });

      await AppDatabase.get()
          .selectCustomerAddressDetailsListIsDataSynced(
          bean.trefno, bean.mrefno)
          .then((List<AddressDetailsBean> addressDetails) async {
        for (int i = 0; i < addressDetails.length; i++) {
          bean.addressDetails.add(addressDetails[i]);
        }

        // print("Addres  Details list is ${bean.addressDetails}");
      });

      await AppDatabase.get()
          .selectImagesListIsDataSynced(bean.trefno, bean.mrefno)
          .then((List<ImageBean> imageBean) async {

            print("image bean jo return aai hai vo hai ${imageBean}");
            print("Image Bean ki length hai ${imageBean.length}");

            if((imageBean==null||imageBean.length==0)&&bean.mrefno!=0&&bean.mrefno!=null){
              _ShowProgressInd(context);

                bool isNetworkAvailable;

              isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
              if(isNetworkAvailable){

               

                GetCustomerFromMiddleware getCustObj = new GetCustomerFromMiddleware(); 
                await getCustObj.getCustomerImages(bean.mrefno,bean.trefno);
                print("xxYe paar kar gya");


                await AppDatabase.get().selectImagesListIsDataSynced(bean.trefno, bean.mrefno)
                      .then((List<ImageBean> imageRepeatBean) async {
                          imageBean= imageRepeatBean;
                      });
              }
                Navigator.of(context).pop();
            }


                for (int i = 0; i < imageBean.length; i++) {
                    bean.imageMaster[imageBean[i].tImgrefno] = imageBean[i];

                
            }
        
      });

      await AppDatabase.get()
          .selectCustomerBussinessDetails(bean.trefno, bean.mrefno)
          .then(
              (CustomerBusinessDetailsBean customerBusinessDetailsBean) async {
            bean.customerBusinessDetailsBean = customerBusinessDetailsBean;
            /* print(
            "customerBusinessDetailsBean list is ${bean.customerBusinessDetailsBean}");*/
          });

      await AppDatabase.get()
          .selectCustomerCpvDetails(bean.trefno, bean.mrefno)
          .then(
              (ContactPointVerificationBean contactPointVerificationBean) async {
            bean.contactPointVerificationBean = contactPointVerificationBean;
            try {
              await setAssetsVisible(bean.contactPointVerificationBean);
            }catch(_){}


          });
      await AppDatabase.get()
          .selectCustomerBusinessExpenseListIsDataSynced(
          bean.trefno, bean.mrefno)
          .then(
              (List<BusinessExpenditureDetailsBean> businessExpenseBean) async {
            for (int i = 0; i < businessExpenseBean.length; i++) {
              bean.businessExpendDetailsList.add(businessExpenseBean[i]);
            }
            // print("business expenditure list is ${bean.businessExpendDetailsList}");
          });

      await AppDatabase.get()
          .selectCustomerHouseholdExpenseListIsDataSynced(
          bean.trefno, bean.mrefno)
          .then((List<HouseholdExpenditureDetailsBean>
      householdExpenseBean) async {
        for (int i = 0; i < householdExpenseBean.length; i++) {
          bean.householdExpendDetailsList.add(householdExpenseBean[i]);
        }
        /*print(
            "household expenditure list is ${bean.householdExpendDetailsList}");*/
      });

      await AppDatabase.get()
          .selectCustomerAssetDetailListIsDataSynced(bean.trefno, bean.mrefno)
          .then((List<AssetDetailsBean> assetDetailsBean) async {
        for (int i = 0; i < assetDetailsBean.length; i++) {
          bean.assetDetailsList.add(assetDetailsBean[i]);
        }
        //  print("asset detail list is ${bean.assetDetailsList}");
      });

      await AppDatabase.get()
          .selectCustomerPPIListIsDataSynced(bean.trefno, bean.mrefno)
          .then((List<PPIMasterBean> pPIMasterBean) async {
        for (int i = 0; i < pPIMasterBean.length; i++) {
          bean.pPIMasterBean.add(pPIMasterBean[i]);
        }
        // print("PPI  list is ${bean.pPIMasterBean}");
      });




      await AppDatabaseExtended.get()
          .selectFingerPrintList(bean.trefno, bean.mrefno)
          .then((List<CustomerFingerPrintBean> fingerPrintBean) async {

        print("Finger Print bean jo return aai hai vo hai ${fingerPrintBean}");
        print("Finger Print Bean ki length hai ${fingerPrintBean.length}");


        for (int i = 0; i < fingerPrintBean.length; i++) {
          bean.customerfingerprintlist[fingerPrintBean[i].timagerefno] = fingerPrintBean[i];


        }

      });



      await routeToCustomerScreenForModificationOfData(bean);
    }
  }

  routeToCustomerScreenForModificationOfData(CustomerListBean bean) {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
          new CustomerFormationMasterTabs(widget.firstParms, bean),
        ));
  }

/*
  Future getUsrCodeBranchCode() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      beanObj.mlbrcode = globals.branchId;
      beanObj.mcreatedby = globals.agentUserName;
      beanObj.mcreateddt = DateTime.now();
      beanObj.mlastupdateby = prefs.get("${TablesColumnFile.usrCode}");
      beanObj.mlastupdatedt = DateTime.now();

    });
  }
*/
  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }

  void submitProspectForCustomer(CustomerListBean item) async {
    CreditBereauBean cbbObj = await AppDatabase.get()
        .getLastProspectFromId(item.mpannodesc, item.mIdDesc);
    if (cbbObj != null) {
      if (item.misCbCheckDone == 1 || item.misCbCheckDone == 2) {
        if (DateTime.now().difference(cbbObj.mcreateddt) <
            Duration(days: highmarkValidity)) {
          showConfrmAlrt(cbbObj, item);
        } else {
          await createNewProspect(item);
        }
      } else {
        await createNewProspect(item);
      }
    } else {
      await createNewProspect(item);
    }
  }

  Future<void> createNewProspect(CustomerListBean item) async {
    CreditBereauBean beanObj = new CreditBereauBean();
    item.addressDetails = new List<AddressDetailsBean>();
    await AppDatabase.get()
        .selectCustomerAddressDetailsListIsDataSynced(item.trefno, item.mrefno)
        .then((List<AddressDetailsBean> addressDetails) async {
      for (int i = 0; i < addressDetails.length; i++) {
        item.addressDetails.add(addressDetails[i]);
      }

      if (addressDetails.isEmpty) {
        showMessageWithoutProgress("Add atleast 1 contact details ");
        return;
      }

      //  print("Addres  Details list is ${item.addressDetails}");
    });

    if (item.addressDetails.isNotEmpty) {
      beanObj.mhouse = item.addressDetails.last.maddr1;

      beanObj.mstreet = item.addressDetails.last.maddr2;

      beanObj.mpincode = item.addressDetails.last.mpinCd;
      StateDropDownList stateBean =
      await AppDatabase.get().getState(item.addressDetails.last.mState);
      DistrictDropDownList distBean =
      await AppDatabase.get().getdist(item.addressDetails.last.mDistCd);
      if (distBean != null && distBean != "null" && distBean != "") {
        beanObj.mcity = distBean.distDesc.trim();
      }
      beanObj.mstate = stateBean.stateDesc;

      // print(item.addressDetails.last.mstatedesc);
      beanObj.mmobno = int.parse(item.addressDetails.last.mMobile);
    }

    try {
      if (item.mpannodesc != null && item.mpannodesc.trim != "") {
        Verhoeff vObj = new Verhoeff();
        bool result = vObj.validateVerhoeff(item.mpannodesc.trim());
        if (result == false) {
          showMessageWithoutProgress(Translations.of(context).text("Adhaar Not valid"));
          return;
        }
      } else {
        showMessageWithoutProgress(Translations.of(context).text("Adhaar Not valid"));
        return;
      }
    } catch (_) {
      showMessageWithoutProgress(Translations.of(context).text("Adhaar Not valid"));
      return;
    }

    await AppDatabase.get().getMaxTrefNo().then((val) async {
      beanObj.trefno = val;
    });
    if (beanObj.mmobno != null && beanObj.mmobno == item.motpvrfdno) {
      beanObj.motpverified = 1;
    } else
      beanObj.motpverified = 0;
    beanObj.mrefno = 0;
    beanObj.missynctocoresys = 0;
    beanObj.mprospectstatus = 0;
    beanObj.miscustcreated = 1;
    beanObj.misuploaded = 0;
    beanObj.mprospectname = ifNullCheck(item.mfname) +
        " " +
        ifNullCheck(item.mmname) +
        ifNullCheck(item.mlname);

    beanObj.mlbrcode = item.mlbrcode;
    beanObj.mprospectdt = null;
    beanObj.mdob = item.mdob;
    beanObj.mcbcheckstatus = "";
    beanObj.mprospectstatus = 0;
    beanObj.madd1 = item.mAdd1;
    beanObj.madd2 = item.mAdd2;
    beanObj.madd3 = item.mAdd3;
    beanObj.mhomeloc = item.mHouse;
    beanObj.mareacd = item.mArea;
    beanObj.mpanno = item.mpannodesc;
    beanObj.mspousename = item.mhusbandname;
    beanObj.mid1 = item.mTypeOfId.toString();
    beanObj.mid1desc = item.mIdDesc;
    beanObj.mnomineename = item.mhusbandname;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.get("${TablesColumnFile.musrcode}") == null ||
          prefs.get("${TablesColumnFile.musrcode}").toString().trim() == "")
        showMessageWithoutProgress("User Code not valid");
      beanObj.mcreatedby = prefs.get("${TablesColumnFile.musrcode}");
    } catch (_) {
      // print("Exception");
      showMessageWithoutProgress("User Code not valid");
    }

    beanObj.mcreateddt = DateTime.now();
    beanObj.mlastupdatedt = DateTime.now();
    beanObj.mlastupdateby = item.mlastupdateby;
    beanObj.mgeolocation = item.mgeolocation;
    beanObj.mgeolatd = item.mgeolatd;
    beanObj.mgeologd = item.mgeologd;
    beanObj.missynctocoresys = item.missynctocoresys;
    beanObj.mlastsynsdate = item.mlastsynsdate;
    beanObj.mtier = item.mtier;
    beanObj.mcustno = item.mcustno;

    //  print(beanObj);
    if (beanObj.mprospectname == null || beanObj.mprospectname.trim() == "") {
      showMessageWithoutProgress("Add a valid name");
      return;
    }
    if (beanObj.mmobno == null || beanObj.mmobno.toString().length != 10) {
      showMessageWithoutProgress("Add  a valid mobile number");
      return;
    }

    if (item.mIdDesc == null ||
        item.mIdDesc.trim() == "" ||
        item.mIdDesc.trim() == "null") {
      showMessageWithoutProgress("Add  a valid ID 2");
      return;
    }
    if (item.mTypeOfId == null || item.mTypeOfId == 0) {
      showMessageWithoutProgress("Add  a valid ID 2 Type ");
      return;
    }

    await AppDatabase.get().updateCreditBereauMaster(beanObj).then((value) {});

    _successfulSubmit(beanObj.mprospectname, beanObj.motpverified);
  }

  Future<void> _successfulSubmit(String applicantName, int otpVerified) async {
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
                  Text('Prospect Created  Named: ${applicantName}')
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  globals.OTP = null;
                  if (otpVerified == 0) {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new SMSVerification()));
                  } else {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ProspectView()));
                  }
                },
              ),
            ],
          );
        });
  }

  Future<void> showConfrmAlrt(
      CreditBereauBean cbObj, CustomerListBean item) async {
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
                  Text('Prospect Alredy  Created  on : ${cbObj.mcreateddt}'),
                  Text('Name is: ${cbObj.mprospectname}')
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Create New'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await createNewProspect(item);
                },
              ),
              FlatButton(
                child: Text('Ok'),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _cnfrmCreateProspect(CustomerListBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Prospect'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want create new prospect')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                Navigator.of(context).pop();
                submitProspectForCustomer(item);
              },
            ),
            FlatButton(
              child: Text(
                'No',
              ),
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

  Future<void> _syncCustomerToMiddleware(CustomerListBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('CustomerSync'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want Sync this Customer')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                circInd = true;
                Navigator.of(context).pop();
                syncCustomerToMiddleware(item);
                _ShowCircInd(item);
              },
            ),
            FlatButton(
              child: Text(
                'No',
              ),
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

  Future<void> _ShowCircInd(CustomerListBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('CustomerSync'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[CircularProgressIndicator()],
            ),
          ),
        );
      },
    );
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
  void syncCustomerToMiddleware(CustomerListBean item) async {
    // try {
    SyncingCustomertoMiddleware syncingCustomerToMiddleware =
    new SyncingCustomertoMiddleware();
    await syncingCustomerToMiddleware.SyncSingleCustomerToMiddleware(
        item, lastSyncedToServerDaeTime)
        .then((onValue) {
      /*setState(() {
          circInd == false;
        });*/

      Navigator.of(context).pop();
      //Navigator.of(context).pop();

      if(onValue!=null) {
        _successfulSinglecustomerSyncedToServer(onValue);
      }else{


        showMessageWithoutProgress("SomeThing Went Wrong Syncing Customer");
      }
    });
    /*} catch (_) {
      showMessageWithoutProgress("Server Exception");
    }*/
  }

  void getAcccountFromOmni(int custno) async {
    // print("getAcccountFromOmni");

    try {

      GetCIFInfoFromOmni getCIFInfoFromOmni = new GetCIFInfoFromOmni();


      /*//SyncingCustomertoMiddleware syncingCustomerToMiddleware = new SyncingCustomertoMiddleware();
      await syncingCustomerToMiddleware.SyncSingleCustomerToMiddleware(item,lastSyncedToServerDaeTime).then((onValue){
        setState(() {
          circInd == false;
        });

        print("Something not right");
        Navigator.of(context).pop();
        //Navigator.of(context).pop();

        if(onValue>0) {
          _successfulSinglecustomerSyncedToServer(onValue, item.trefno);
        }else{


          showMessageWithoutProgress("SomeThing wentWrong Syncing Customer");

        }
      });*/


    }catch(_){
      showMessageWithoutProgress("Server Exception");
    }
  }

  Future<void> _successfulSinglecustomerSyncedToServer(
      CustomerCheckBean custCheckBean) async {
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
                  Text('Customer Synced to server for mrefno : ${custCheckBean.mrefno} And trefno : ${custCheckBean.trefno},'),
                  Text('Please Note Customer No : ${custCheckBean.mcustno} '),
                  Text(custCheckBean.merrormessage!=null && custCheckBean.merrormessage!=''?'error Message : ${custCheckBean.merrormessage}':"")
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  setState(() {
                    count = 1;
                  });
                },
              ),
            ],
          );
        });
  }

  requestPermission() async {

    var permissionNames =  Permission.requestPermissions([PermissionName.Microphone]);

    // print(permissionNames);
  }



  viewonMap(String geoLatitude,String geoLongitude)async {
    bool isNetworkAvailable;
    Utility obj = new Utility();
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if(isNetworkAvailable==true){
      if(geoLatitude!=null&&geoLongitude!=null&&geoLatitude.trim()!='null'&&
          geoLongitude.trim()!='null'
      ){
        try{
          Geocordinates geoObject = new Geocordinates();
          geoObject.geoLatitude = double.parse(geoLatitude);
          geoObject.geolongitude  = double.parse(geoLongitude);
          List<Geocordinates> geoList = [
            geoObject
          ];
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                //new CustomerFormationMasterTabs(widget.cameras)), //When Authorized Navigate to the next screen
                new GeoPointsLocator(geoList)),
          );
        }catch(_){
          showMessageWithoutProgress("GeoCordinates Are Not Right");
        }
      }
    }
    else{
      showMessageWithoutProgress("Network Not Awailable");
    }
  }

  Future<void> setAssetsVisible(ContactPointVerificationBean contactPointVerificationBean) async{
    if(contactPointVerificationBean !=null) {
      globals.dropdownCaptionsValuesCpvMuliselect=null;
      Constant.assetsVisible(
          true, contactPointVerificationBean.massetvissiblecode);
    }else{
      Constant.assetsVisible(
          false,  null);
    }
   // print("contactPointVerificationBean.massetvissiblecode"+contactPointVerificationBean.massetvissiblecode);
  }

  Future<Null> _onRefresh() async{
    GetCustomerFromMiddleware getCustomerFromMiddleware =  new GetCustomerFromMiddleware();
    await getCustomerFromMiddleware.trySave(username);
    setState(() {

        count = 1;

      showMessageWithoutProgressGreen("Customer syncing done sucessfully");
    });
  }
}