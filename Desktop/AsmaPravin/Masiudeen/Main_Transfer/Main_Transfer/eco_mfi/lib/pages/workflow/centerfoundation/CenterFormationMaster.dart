import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanUtilization/LoanUtilizationBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:toast/toast.dart';

import 'bean/CenterDetailsBean.dart';

class CenterFormationMaster extends StatefulWidget {
  //final savingsListPassedObject;
  //NewAccountOpening({Key key, this.savingsListPassedObject}) : super(key: key);
  final centerDetailsPassedObject;
  final UserRightBean userRightBean;
  CenterFormationMaster(this.centerDetailsPassedObject, this.userRightBean);
  @override
  _CenterFormationMasterState createState() =>
      new _CenterFormationMasterState();
}
//CustomerLoanUtilizationBean cusLoanUtilObj = new CustomerLoanUtilizationBean();

class _CenterFormationMasterState extends State<CenterFormationMaster> {
  /*FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection();
  FullScreenDialogForGroupSelection _myGroupDialog =
  new FullScreenDialogForGroupSelection();*/
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TabController _tabController;
  ProductBean prodObj = new ProductBean();
  LookupBeanData status;
  LookupBeanData freezType;
  DateTime selectedDate = DateTime.now();
  DateTime date;
  TimeOfDay time;
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  String tempYear;
  String tempDay;
  String tempMonth;
  bool boolValidate = false;
  int accountNumber;
  int loanNumber;
  String branch = "";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  FocusNode monthFocus;
  FocusNode yearFocus;
  FocusNode nextMeetingMonthFocus;
  FocusNode nextMeetingYearFocus;
  CenterDetailsBean centerDetailsBean = new CenterDetailsBean();
  bool isNew = false;
  String firstMeetingDate = "__-__-____";
  String nextMeetingDate = "__-__-____";
  String tempNextMeetingYear;
  String tempNextMeetingDay;
  String tempNextMeetingMonth;
  String mCenterRepayFromTo = "";
  int mCenterRepayFrom = 0;
  int mCenterRepayTo = 0;
  SystemParameterBean sysBean = new SystemParameterBean();
  String error;
  DateTime operationDateDateFormat;

  LookupBeanData centerFrequency;
  LookupBeanData centerMeetingDay;
  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);
  String operationDate;
  bool enbledRepayFromTo = false;

  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          centerFrequency = blankBean;
          centerDetailsBean.mmeetingfreq = blankBean.mcode;
          break;
        case 1:
          centerMeetingDay = blankBean;
          centerDetailsBean.mmeetingday = 0;
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      bool isBreak = false;
      for (int k = 0;
          k < globals.dropdownCaptionsValuesCenterFormation[no].length;
          k++) {
        if (globals.dropdownCaptionsValuesCenterFormation[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesCenterFormation[no][k],false);
          isBreak = true;
          break;
        }
        if (isBreak) {
          break;
        }
      }
    }
  }

  setValue(int no, LookupBeanData value,bool frominit) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          centerFrequency = value;
          centerDetailsBean.mmeetingfreq = value.mcode;
          if(frominit==false){
            modifyNxtMtngAccToFreq(centerDetailsBean.mmeetingfreq);
          }
           
          break;
        case 1:
          centerMeetingDay = value;
          centerDetailsBean.mmeetingday = int.parse(value.mcode);
          break;

        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesCenterFormation[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesCenterFormation[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
  }

  Future<bool> callDialog() {
    globals.sessionTimeOut=new SessionTimeOut(context: context);
    globals.sessionTimeOut.SessionTimedOut();
    globals.Dialog.onPop(context, 'Are you sure?',
        'Do you want to Go To Center List without saving data', "CenterFormationMaster");
  }

  @override
  void initState() {
    super.initState();
    
    print("returned aya object  ${widget.centerDetailsPassedObject}");
    if (widget.centerDetailsPassedObject != null &&
        widget.centerDetailsPassedObject.trefno != null &&
        widget.centerDetailsPassedObject.trefno != "" ) {
      centerDetailsBean.trefno = widget.centerDetailsPassedObject.trefno;
      print("centerDetailsBean.mleadsid" + centerDetailsBean.trefno.toString());
      print("widget.centerDetailsPassedObject.trefno" +
          widget.centerDetailsPassedObject.trefno.toString());
      centerDetailsBean = widget.centerDetailsPassedObject;
      print("aate hi valu aaya ${centerDetailsBean.mnextmeetngdt}");
      //firstMeetingDate = centerDetailsBean.mfirstmeetngdt.toString();
    }

    

    
    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues.add(centerDetailsBean.mmeetingfreq.toString());
    tempDropDownValues.add(centerDetailsBean.mmeetingday.toString());

      

    for (int k = 0;
        k < globals.dropdownCaptionsValuesCenterFormation.length;
        k++) {
      for (int i = 0;
          i < globals.dropdownCaptionsValuesCenterFormation[k].length;
          i++) {
        try {
          if (globals.dropdownCaptionsValuesCenterFormation[k][i].mcode
                  .toString()
                  .trim() ==
              tempDropDownValues[k].toString().trim()) {
            print("Matched");
            setValue(k, globals.dropdownCaptionsValuesCenterFormation[k][i],true);
          }
        } catch (_) {
          print("Exception Occured");
        }
      }
    }
    getSessionVariables();
  }

  bool ifNullCheck(String value) {
    bool isNull = false;
    try {
      if (value == null || value == 'null' || value.trim() == '') {
        isNull = true;
      }
    } catch (_) {
      isNull = true;
    }
    return isNull;
  }

  Future<Null> getSessionVariables() async {
    if (widget.centerDetailsPassedObject != null) {
      centerDetailsBean = widget.centerDetailsPassedObject;
    } else {
      AppDatabase.get().generateTrefnoForCenterCreation().then((onValue) {
        setState(() {
          centerDetailsBean.trefno = onValue;
        });
      });
    }

    sysBean = await AppDatabase.get().getSystemParameter('CNTRREPAYFROMTO', 0);
    if (sysBean.mcodevalue != null && sysBean.mcodevalue.trim() != '') {
      mCenterRepayFromTo = sysBean.mcodevalue;
    }
    List ar = mCenterRepayFromTo.split("-");
    print("from " + ar[0]);
    print("from " + ar[1]);
    if(centerDetailsBean.mrepayfrom==0||centerDetailsBean.mrepayfrom==null){
      centerDetailsBean.mrepayfrom = int.parse(ar[0]);
    centerDetailsBean.mrepayto = int.parse(ar[1]);
    }
    
    prefs = await SharedPreferences.getInstance();
    setState(() {
      centerDetailsBean.mlbrcode = prefs.get(TablesColumnFile.musrbrcode);
      branch = prefs.get(TablesColumnFile.branch).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      print("username" + username.toString());
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
      operationDate = prefs.getString(TablesColumnFile.branchOperationalDate);
      print("Center geoLatitude:" +
          geoLatitude +
          " geoLongitude:" +
          geoLongitude);
    });

    try{
      operationDateDateFormat = DateTime.parse(operationDate);

    }catch(_){

    }



    
    if (centerDetailsBean.mEffectiveDt == null ||
        centerDetailsBean.mEffectiveDt == ""){
            centerDetailsBean.mEffectiveDt = DateTime.parse(operationDate);
        }
      

    if (centerDetailsBean.mnextmeetngdt == null ||
        centerDetailsBean.mnextmeetngdt == ""){

    centerDetailsBean.mnextmeetngdt =DateTime.parse(operationDate);
        }


    print("first meeting date is ${firstMeetingDate}");

    DateTime formattedDate;
    try {
      if (firstMeetingDate.contains("_")&&(centerDetailsBean==null||centerDetailsBean.mfirstmeetngdt==null)) {
        if (operationDate != null &&
            operationDate.trim() != '' &&
            operationDate.trim() != 'null'&&(centerDetailsBean.mfirstmeetngdt==null||
            centerDetailsBean.mfirstmeetngdt.toString().trim()!='null'
            )) {
          centerDetailsBean.mfirstmeetngdt = DateTime.parse(operationDate);
        }
      }
      print("First Meeting Date Set hua  ${centerDetailsBean.mfirstmeetngdt}");

      if (centerDetailsBean.mfirstmeetngdt != null &&
          centerDetailsBean.mfirstmeetngdt.toString().trim() != "null" &&
          centerDetailsBean.mfirstmeetngdt.toString().trim() != "") {
        if (centerDetailsBean.mfirstmeetngdt.day.toString().length == 1)
          tempDay = "0" + centerDetailsBean.mfirstmeetngdt.day.toString();
        else
          tempDay = centerDetailsBean.mfirstmeetngdt.day.toString();

        if (centerDetailsBean.mfirstmeetngdt.month.toString().length == 1)
          tempMonth = "0" + centerDetailsBean.mfirstmeetngdt.month.toString();
        else
          tempMonth = centerDetailsBean.mfirstmeetngdt.month.toString();

        tempYear = centerDetailsBean.mfirstmeetngdt.year.toString();
        firstMeetingDate = firstMeetingDate.replaceRange(0, 2, tempDay);
        print("firstMeetingDate= ${firstMeetingDate}");
        firstMeetingDate = firstMeetingDate.replaceRange(3, 5, tempMonth);
        print("firstMeetingDate= ${firstMeetingDate}");
        firstMeetingDate = firstMeetingDate.replaceRange(
            6,
            10,
            centerDetailsBean.mfirstmeetngdt.year
                .toString());
        print("firstMeetingDate= ${firstMeetingDate}");

        if(centerDetailsBean.mmeetingfreq==null||centerDetailsBean.mmeetingfreq.trim()==""){
            if ((tempDay != "" && tempDay != null) &&
                                    (tempMonth != '' && tempMonth != null) &&
                                    (tempYear != '' && tempYear != null)) {
                                  if (validateDate(
                                      tempDay, tempMonth, tempYear)) {
                                    setMeetingDay(DateTime.parse(tempYear +
                                        "-" +
                                        tempMonth +
                                        "-" +
                                        tempDay));
                                  }
                                }

        }

        

      }
    } catch (e) {
      print("Exception Occupred in formatting operation Date");
    }



        try{

        
        if (centerDetailsBean.mnextmeetngdt != null) {
        if (centerDetailsBean.mnextmeetngdt.day.toString().length == 1)
          tempNextMeetingDay = "0" + centerDetailsBean.mnextmeetngdt.day.toString();
        else
          tempNextMeetingDay = centerDetailsBean.mnextmeetngdt.day.toString();

        if (centerDetailsBean.mnextmeetngdt.month.toString().length == 1)
          tempNextMeetingMonth = "0" + centerDetailsBean.mnextmeetngdt.month.toString();
        else
          tempNextMeetingMonth = centerDetailsBean.mnextmeetngdt.month.toString();

        tempNextMeetingYear = centerDetailsBean.mnextmeetngdt.year.toString();
        nextMeetingDate = nextMeetingDate.replaceRange(0, 2, tempNextMeetingDay);
        print("Next Meting DAte= ${nextMeetingDate}");
        nextMeetingDate = nextMeetingDate.replaceRange(3, 5, tempNextMeetingMonth);
        print("Next Meting DAte= ${nextMeetingDate}");
        nextMeetingDate = nextMeetingDate.replaceRange(
            6,
            10,
            centerDetailsBean.mnextmeetngdt.year
                .toString());
        print("next Meeting String = ${nextMeetingDate}");
      }


    
    }catch(_){
           print("Exception Occupred in formatting Next Meeting Date");
        }



    setState(() {
      
    });




  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          callDialog();
        },
        child: new Scaffold(
          key: _scaffoldKey,
         // resizeToAvoidBottomPadding: false,
          appBar: new AppBar(
            elevation: 1.0,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                globals.sessionTimeOut=new SessionTimeOut(context: context);
                globals.sessionTimeOut.SessionTimedOut();;
                callDialog();
              },
            ),
            backgroundColor: Color(0xff07426A),
            brightness: Brightness.light,
            title: new Text(
              Constant.newCenterCreation,
              //textDirection: TextDirection,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.normal),
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

                  if (centerDetailsBean.mCenterId == 0 ||
                      centerDetailsBean.mCenterId ==
                          null) if (widget.userRightBean != null &&
                      (widget.userRightBean.create == 1))
                    proceed();
                  else {
                    showMessage("Update Not Allowed");
                  }
                },
              ),
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
              ),
            ],
          ),
          floatingActionButton: new FloatingActionButton(
              backgroundColor:
                  globals.geoLatitude == null || globals.geoLongitude == null
                      ? Colors.grey
                      : Colors.green,
              child: new Icon(Icons.my_location),
              onPressed: () {
                if (widget.userRightBean != null &&
                    widget.userRightBean.modify == 1) {
                  _showalertToUpdateCenterLocation("Confirmation!",
                      "Are You Sure You want to update this location");
                } else {
                  showMessage("Rights Not allowed");
                }
              }),
          body: new Form(
            key: _formKey,
            autovalidate: false,
            onWillPop: () {
              return Future(() => true);
            },
            onChanged: () async {
              final FormState form = _formKey.currentState;
              form.save();
              //await calculate();
            },
            child: new SingleChildScrollView(
                          child: Column(
               // shrinkWrap: true,
               // padding: EdgeInsets.all(0.0),
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Card(
                    child: new ListTile(
                      title: new Text(Constant.centerNumber),
                      subtitle: centerDetailsBean.mCenterId == null ||
                              centerDetailsBean.mCenterId == ""
                          ? new Text("")
                          : new Text("${centerDetailsBean.mCenterId}"),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  new Container(
                    color: Constant.mandatoryColor,
                    child: new TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Center Name',
                        labelText: Constant.centerName,
                        hintStyle: TextStyle(color: Colors.grey),
                        /*labelStyle: TextStyle(color: Colors.grey),*/
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                        globals.onlyAphaNumeric
                      ],
                      controller: centerDetailsBean.mcentername == null
                          ? TextEditingController(text: "")
                          : TextEditingController(
                              text: centerDetailsBean.mcentername),
                      /*initialValue:
                    centerDetailsBean.mcentername != null ? centerDetailsBean.mcentername : "",*/

                      onSaved: (val) {
                        if (val != null && val != "") {
                          try {
                            centerDetailsBean.mcentername = (val);
                          } catch (e) {}
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Card(
                    child: new ListTile(
                      title: new Text(Constant.centerCreationDate),
                      subtitle: new Text("${operationDate}"),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Constant.mandatoryColor),
                    child: new Row(
                      children: <Widget>[Text(Constant.firstMeetingDate)],
                    ),
                  ),
                  new Container(
                    decoration: BoxDecoration(
                      color: Constant.mandatoryColor,
                    ),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          width: 50.0,
                          child: new TextField(
                              decoration: InputDecoration(hintText: "DD"),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(2),
                                globals.onlyIntNumber
                              ],
                              controller: tempDay == null
                                  ? null
                                  : new TextEditingController(text: tempDay),
                              keyboardType: TextInputType.numberWithOptions(),
                              onChanged: (val) {
                                if (val != "0") {
                                  tempDay = val;
                                  if (int.parse(val) <= 31 &&
                                      int.parse(val) > 0) {
                                    if (val.length == 2) {
                                      firstMeetingDate = firstMeetingDate
                                          .replaceRange(0, 2, val);
                                      FocusScope.of(context)
                                          .requestFocus(monthFocus);
                                    } else {
                                      firstMeetingDate = firstMeetingDate
                                          .replaceRange(0, 2, "0" + val);
                                    }

                                    updateFirstMeetingDate();
                                  } else {
                                    setState(() {
                                      tempDay = "";
                                    });
                                  }
                                  if ((tempDay != "" && tempDay != null) &&
                                      (tempMonth != '' && tempMonth != null) &&
                                      (tempYear != '' && tempYear != null)) {
                                    if (validateDate(
                                        tempDay, tempMonth, tempYear)) {
                                      setMeetingDay(DateTime.parse(tempYear +
                                          "-" +
                                          tempMonth +
                                          "-" +
                                          tempDay));
                                    }
                                  }
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text("/"),
                        ),
                        new Container(
                          width: 50.0,
                          child: new TextField(
                            decoration: InputDecoration(
                              hintText: "MM",
                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(2),
                              globals.onlyIntNumber
                            ],
                            focusNode: monthFocus,
                            controller: tempMonth == null
                                ? null
                                : new TextEditingController(text: tempMonth),
                            onChanged: (val) {
                              if (val != "0") {
                                tempMonth = val;
                                if (int.parse(val) <= 12 && int.parse(val) > 0) {
                                  if (val.length == 2) {
                                    firstMeetingDate =
                                        firstMeetingDate.replaceRange(3, 5, val);

                                    FocusScope.of(context)
                                        .requestFocus(yearFocus);
                                  } else {
                                    firstMeetingDate = firstMeetingDate
                                        .replaceRange(3, 5, "0" + val);
                                  }
                                  updateFirstMeetingDate();
                                } else {
                                  setState(() {
                                    tempMonth = "";
                                  });
                                }

                                if ((tempDay != "" && tempDay != null) &&
                                    (tempMonth != '' && tempMonth != null) &&
                                    (tempYear != '' && tempYear != null)) {
                                  if (validateDate(
                                      tempDay, tempMonth, tempYear)) {
                                    setMeetingDay(DateTime.parse(tempYear +
                                        "-" +
                                        tempMonth +
                                        "-" +
                                        tempDay));
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text("/"),
                        ),
                        Container(
                          width: 80,
                          child: new TextField(
                            decoration: InputDecoration(
                              hintText: "YYYY",
                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(4),
                              globals.onlyIntNumber
                            ],
                            focusNode: yearFocus,
                            controller: tempYear == null
                                ? null
                                : new TextEditingController(text: tempYear),
                            onChanged: (val) {
                              tempYear = val;
                              if (val.length == 4){

                                    firstMeetingDate =
                                    firstMeetingDate.replaceRange(6, 10, val);
                                    updateFirstMeetingDate();

                                    
                              }
                                
                              if ((tempDay != "" && tempDay != null) &&
                                  (tempMonth != '' && tempMonth != null) &&
                                  (tempYear != '' && tempYear != null)) {
                                if (validateDate(tempDay, tempMonth, tempYear)) {
                                  setMeetingDay(DateTime.parse(tempYear +
                                      "-" +
                                      tempMonth +
                                      "-" +
                                      tempDay));
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        IconButton(
                            icon: Icon(Icons.calendar_today),
                             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                              _selectDate(context);
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  new Container(
                    color: Constant.mandatoryColor,
                    child: new TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Center Meeting Location',
                          labelText: Constant.centerMeetingLocation,
                          hintStyle: TextStyle(color: Colors.grey),
                          /*labelStyle: TextStyle(color: Colors.grey),*/
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff07426A),
                          )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xff07426A),
                          )),
                          contentPadding: EdgeInsets.all(20.0),
                        ),
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(50),
                          globals.onlyCharacter
                        ],
                        controller: centerDetailsBean.mmeetinglocn == null
                            ? TextEditingController(text: "")
                            : TextEditingController(
                                text: centerDetailsBean.mmeetinglocn),
                        /*initialValue:
                    centerDetailsBean.mcentername != null ? centerDetailsBean.mcentername : "",*/
                        onSaved: (String value) {
                          globals.firstName = value;
                          centerDetailsBean.mmeetinglocn = value;
                        }),
                  ),
                  Container(
                    color: Constant.mandatoryColor,
                    child: new DropdownButtonFormField(
                      value: centerFrequency == null ? null : centerFrequency,
                      items: generateDropDown(0),
                      onChanged: (LookupBeanData newValue) async {
                        showDropDown(newValue, 0);
                        
                      },
                      validator: (args) {
                        print(args);
                      },
                      //  isExpanded: true,
                      //hint:Text("Select"),
                      decoration:
                          InputDecoration(labelText: Constant.meetingFrequency),
                      // style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  new IgnorePointer(
//              color: Constant.mandatoryColor,
                    ignoring: false,
                    child: new DropdownButtonFormField(
                      value: centerMeetingDay == null ? null : centerMeetingDay,
                      items: generateDropDown(1),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 1);
                      },
                      validator: (args) {
                        print(args);
                      },
                      //  isExpanded: true,
                      //hint:Text("Select"),
                      decoration: InputDecoration(labelText: Constant.meetingDay),
                      // style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: new Row(
                      children: <Widget>[Text(Constant.repayBtwn)],
                    ),
                  ),
                  new Container(
                    decoration: BoxDecoration(
                      color: Constant.mandatoryColor,
                    ),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          width: 50.0,
                          child: new TextField(
                              enabled: enbledRepayFromTo,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                    LengthLimitingTextInputFormatter(2),
                                    //globals.onlyIntNumber
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                              controller: centerDetailsBean.mrepayfrom == null
                                  ? TextEditingController(text: "0")
                                  : TextEditingController(
                                      text: "${centerDetailsBean.mrepayfrom}"),
                                      onChanged:(val){
                                          if(val!=null){
                                            try{
                                                centerDetailsBean.mrepayfrom = int.parse(val);

                                            }catch(_){


                                            }

                                          }


                                      } ,
                                      
                                      ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(" AND "),
                        ),
                        new Container(
                          width: 50.0,
                          child: new TextField(
                              enabled: enbledRepayFromTo,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                    LengthLimitingTextInputFormatter(2),
                                    //globals.onlyIntNumber
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                              controller: centerDetailsBean.mrepayto == null
                                  ? TextEditingController(text: "0")
                                  : TextEditingController(
                                      text: "${centerDetailsBean.mrepayto}"),
                                      
                                      onChanged:(val){
                                          if(val!=null){
                                            try{
                                                centerDetailsBean.mrepayto = int.parse(val);

                                            }catch(_){


                                            }

                                          }


                                      } ,
                                      
                                      ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Card(
                  //   child: new ListTile(
                  //     title: new Text(Constant.nextMeetingDate),
                  //     subtitle: new Text(
                  //         "${formatter.format(centerDetailsBean.mnextmeetngdt)}"),
                  //   ),
                  // ),


                  SizedBox(height: 16.0),





                  Container(
                    decoration: BoxDecoration(color: Constant.mandatoryColor),
                    child: new Row(
                      children: <Widget>[Text(Constant.nextMeetingDate)],
                    ),
                  ),
                  new Container(
                    decoration: BoxDecoration(
                      color: Constant.mandatoryColor,
                    ),
                    child: new Row(
                      children: <Widget>[
                        new Container(
                          width: 50.0,
                          child: new TextField(
                              decoration: InputDecoration(hintText: "DD"),
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(2),
                                globals.onlyIntNumber
                              ],
                              controller: tempNextMeetingDay == null
                                  ? null
                                  : new TextEditingController(text: tempNextMeetingDay),
                              keyboardType: TextInputType.numberWithOptions(),
                              onChanged: (val) {
                                if (val != "0") {
                                  tempNextMeetingDay = val;
                                  if (int.parse(val) <= 31 &&
                                      int.parse(val) > 0) {
                                    if (val.length == 2) {
                                      nextMeetingDate = nextMeetingDate
                                          .replaceRange(0, 2, val);
                                      FocusScope.of(context)
                                          .requestFocus(monthFocus);
                                    } else {
                                      nextMeetingDate = nextMeetingDate
                                          .replaceRange(0, 2, "0" + val);
                                    }

                                    updateNextMeetingDate();
                                    if ((tempNextMeetingDay != "" && tempNextMeetingDay != null) &&
                                    (tempNextMeetingMonth != '' && tempNextMeetingMonth != null) &&
                                    (tempNextMeetingYear != '' && tempNextMeetingYear != null)) {
                                  if (validateDate(
                                      tempNextMeetingDay, tempNextMeetingMonth, tempNextMeetingYear)) {
                                    setMeetingDay(DateTime.parse(tempNextMeetingYear +
                                        "-" +
                                        tempNextMeetingMonth +
                                        "-" +
                                        tempNextMeetingDay));
                                  }
                                }
                                  } else {
                                    setState(() {
                                      tempNextMeetingDay = "";
                                    });
                                  }
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text("/"),
                        ),
                        new Container(
                          width: 50.0,
                          child: new TextField(
                            decoration: InputDecoration(
                              hintText: "MM",
                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(2),
                              globals.onlyIntNumber
                            ],
                            focusNode: nextMeetingMonthFocus,
                            controller: tempNextMeetingMonth == null
                                ? null
                                : new TextEditingController(text: tempNextMeetingMonth),
                            onChanged: (val) {
                              if (val != "0") {
                                tempNextMeetingMonth = val;
                                if (int.parse(val) <= 12 && int.parse(val) > 0) {
                                  if (val.length == 2) {
                                    nextMeetingDate =
                                        nextMeetingDate.replaceRange(3, 5, val);

                                    FocusScope.of(context)
                                        .requestFocus(yearFocus);
                                  } else {
                                    nextMeetingDate = nextMeetingDate
                                        .replaceRange(3, 5, "0" + val);
                                  }
                                  updateNextMeetingDate();
                                  if ((tempNextMeetingDay != "" && tempNextMeetingDay != null) &&
                                    (tempNextMeetingMonth != '' && tempNextMeetingMonth != null) &&
                                    (tempNextMeetingYear != '' && tempNextMeetingYear != null)) {
                                  if (validateDate(
                                      tempNextMeetingDay, tempNextMeetingMonth, tempNextMeetingYear)) {
                                    setMeetingDay(DateTime.parse(tempNextMeetingYear +
                                        "-" +
                                        tempNextMeetingMonth +
                                        "-" +
                                        tempNextMeetingDay));
                                  }
                                }
                                } else {
                                  setState(() {
                                    tempNextMeetingMonth = "";
                                  });
                                }

                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text("/"),
                        ),
                        Container(
                          width: 80,
                          child: new TextField(
                            decoration: InputDecoration(
                              hintText: "YYYY",
                            ),
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(4),
                              globals.onlyIntNumber
                            ],
                            focusNode: nextMeetingYearFocus,
                            controller: tempNextMeetingYear == null
                                ? null
                                : new TextEditingController(text: tempNextMeetingYear),
                            onChanged: (val) {
                              tempNextMeetingYear = val;
                              if (val.length == 4){

                                    nextMeetingDate =
                                    nextMeetingDate.replaceRange(6, 10, val);
                                    updateNextMeetingDate();
                                    if ((tempNextMeetingDay != "" && tempNextMeetingDay != null) &&
                                    (tempNextMeetingMonth != '' && tempNextMeetingMonth != null) &&
                                    (tempNextMeetingYear != '' && tempNextMeetingYear != null)) {
                                  if (validateDate(
                                      tempNextMeetingDay, tempNextMeetingMonth, tempNextMeetingYear)) {
                                    setMeetingDay(DateTime.parse(tempNextMeetingYear +
                                        "-" +
                                        tempNextMeetingMonth +
                                        "-" +
                                        tempNextMeetingDay));
                                  }
                                }
                              }
                                
                            },
                          ),
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        IconButton(
                            icon: Icon(Icons.calendar_today),
                             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                              _selectNextMeetingDate(context);
                            })
                      ],
                    ),
                  ),

                  



                ],
              ),
            ),
          ),
        ));
  }
  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(null, "Loan Application")));
    if (customerdata != null) {
      /*savingsListObj.mcustno =
      customerdata.mcustno != null ? customerdata.mcustno : 0;
      savingsListObj.mcusttrefno =
      customerdata.trefno != null ? customerdata.trefno : 0;
      savingsListObj.mcustmrefno =
      customerdata.mrefno != null ? customerdata.mrefno : 0;
      savingsListObj.mlongname = customerdata.mlongname;
      savingsListObj.mcenterid =
      customerdata.mcenterid != null ? customerdata.mcenterid : 0;
      savingsListObj.mgroupcd = customerdata.mgroupcd != null ? customerdata.mgroupcd : 0;*/
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
                  Text('Done'),
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
                   Navigator.push(
            context,
            new MaterialPageRoute(
                /*builder: (context) =>
                new AddGuarantor()),*/
                builder: (context) =>
                new FullScreenDialogForCenterSelection("Center Creation")), //When Authorized Navigate to the next screen
          );
                
               
                  
                },
              ),
            ],
          );
        });
  }

  proceed() async {

    print("Save krte time value hai ${centerDetailsBean.mnextmeetngdt}");
    if (!validateSubmit()) {
      return;
    }

    if(centerDetailsBean.mCenterId!=null&&centerDetailsBean.mCenterId!=0){
      Toast.show(Translations.of(context).text('Modification Not Allowed'),context);
      return ;
    }

    centerDetailsBean.mcreatedby = username;
    centerDetailsBean.mcrs = username;
    centerDetailsBean.missynctocoresys = 0;
    print("centerDetailsBean.mcreatedby" +
        centerDetailsBean.mcreatedby.toString());
    print("username" + username.toString());
    centerDetailsBean.mlastupdateby = null;
    if ((centerDetailsBean.mcreateddt == 'null') ||
        (centerDetailsBean.mcreateddt == null))
      centerDetailsBean.mcreateddt = DateTime.now();

    centerDetailsBean.mlastupdatedt = DateTime.now();
    centerDetailsBean.mgeolatd = geoLatitude;
    centerDetailsBean.mgeologd = geoLongitude;
    centerDetailsBean.missynctocoresys = 0;
    if ((centerDetailsBean.mCenterId == 'null') ||
        (centerDetailsBean.mCenterId == null)) centerDetailsBean.mCenterId = 0;

    if (centerDetailsBean.mrefno == null) {
      centerDetailsBean.mrefno = 0;
    }
    await AppDatabase.get()
        .updateCenterFoundation(centerDetailsBean)
        .then((val) {
      print("val here is " + val.toString());
    });
    _successfulSubmit();
  }

  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                globals.sessionTimeOut = new SessionTimeOut(context: context);
                globals.sessionTimeOut.SessionTimedOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showalertToUpdateCenterLocation(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () async {
                Navigator.of(context).pop();
                globals.sessionTimeOut = new SessionTimeOut(context: context);
                globals.sessionTimeOut.SessionTimedOut();
                if (globals.geoLongitude != null && globals.geoLongitude != 0) {
                  centerDetailsBean.mgeologd = globals.geoLongitude.toString();
                  centerDetailsBean.mgeolatd = globals.geoLatitude.toString();
                  bool isNetworkAvailable;

                  isNetworkAvailable = await Utility.checkIntCon();
                  if (isNetworkAvailable) {
                    showMessageWithProgress(
                        "Updating Center Location for mrefno ${centerDetailsBean.mrefno}");

                    var mapData = new Map();
                    const JsonCodec JSON = const JsonCodec();
                    mapData[TablesColumnFile.mrefno] = centerDetailsBean.mrefno;
                    mapData[TablesColumnFile.mgeolatd] =
                        centerDetailsBean.mgeolatd;
                    mapData[TablesColumnFile.mgeologd] =
                        centerDetailsBean.mgeologd;
                    String json = JSON.encode(mapData);
                    final _headers = {'Content-Type': 'application/json'};
                    String centerLocationMod =
                        "/createCentersFoundations/updateCenterLocation/";
                    try {
                      String bodyValue = await NetworkUtil.callPostService(
                          json,
                          Constant.apiURL.toString() + centerLocationMod,
                          _headers);
                      print("url " +
                          Constant.apiURL.toString() +
                          centerLocationMod.toString());
                      if (bodyValue == "404") {
                        return null;
                      } else {
                        Map<String, dynamic> map = JSON.decode(bodyValue);
                        print(json +
                            " form jso obj response" +
                            "here is" +
                            map.toString());
                        CenterDetailsBean bean = CenterDetailsBean.fromMap(map);

                        if (bean.missynctocoresys == 1) {
                          await AppDatabaseExtended.get()
                              .updateCenterLocation(centerDetailsBean)
                              .then((int ab) {});
                        }

                        try {
                          _scaffoldKey.currentState.hideCurrentSnackBar();
                        } catch (e) {}
                        _showAlert(
                            "Successfull", "Location Updation Successfull");
                      }
                    } catch (_) {}
                  } else {
                    _showAlert("Network Problem", "Network Not available");
                  }
                } else {
                  _showAlert(
                      "Location Issue", "Location Updation UnsuccessFull");
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != centerDetailsBean.mfirstmeetngdt)
      setState(() {
        centerDetailsBean.mfirstmeetngdt = picked;
        tempDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempDay = "0" + picked.day.toString();
        } else
          tempDay = picked.day.toString();
        firstMeetingDate = firstMeetingDate.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        firstMeetingDate = firstMeetingDate.replaceRange(6, 10, tempYear);
        if (picked.month.toString().length == 1) {
          tempMonth = "0" + picked.month.toString();
        } else
          tempMonth = picked.month.toString();
        firstMeetingDate = firstMeetingDate.replaceRange(3, 5, tempMonth);
        print("Test-" +
            DateTime.parse(tempYear + "-" + tempMonth + "-" + tempDay)
                .toIso8601String());
        setMeetingDay(
            DateTime.parse(tempYear + "-" + tempMonth + "-" + tempDay));
//fsdf
      });
  }


  Future<Null> _selectNextMeetingDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime(2100));
    if (picked != null && picked != centerDetailsBean.mnextmeetngdt)
      setState(() {
        centerDetailsBean.mnextmeetngdt = picked;
        tempDate = formatter.format(picked);
        if (picked.day.toString().length == 1) {
          tempNextMeetingDay = "0" + picked.day.toString();
        } else
          tempNextMeetingDay = picked.day.toString();
        nextMeetingDate = nextMeetingDate.replaceRange(0, 2, tempDay);
        tempNextMeetingYear = picked.year.toString();
        nextMeetingDate = nextMeetingDate.replaceRange(6, 10, tempYear);
        if (picked.month.toString().length == 1) {
          tempNextMeetingMonth = "0" + picked.month.toString();
        } else
          tempNextMeetingMonth = picked.month.toString();
        nextMeetingDate = nextMeetingDate.replaceRange(3, 5, tempMonth);
        print("Test-" +
            DateTime.parse(tempNextMeetingYear + "-" + tempNextMeetingMonth + "-" + tempNextMeetingDay)
                .toIso8601String());


        setMeetingDay(picked);        
//fsdf
      });
  }










  bool validateSubmit() {
    String error = "";
    print("inside mcentername" + centerDetailsBean.mcentername.toString());
    print("inside mmeetingdaymmeetingday" +
        centerDetailsBean.mmeetingday.toString());

    if (centerDetailsBean.mcentername == "" ||
        centerDetailsBean.mcentername == null) {
      _showAlert("Center Name", "Center Name is Mandatory");
      return false;
    }
    if (centerDetailsBean.mfirstmeetngdt == "" ||
        centerDetailsBean.mfirstmeetngdt == null) {
      _showAlert("First Meeting Date", "First Meeting Date is Mandatory");
      return false;
    }
    if (centerDetailsBean.mmeetingfreq == "" ||
        centerDetailsBean.mmeetingfreq == null) {
      _showAlert("Meeting Frequency", "Meeting Frequency is Mandatory");
      return false;
    }

    if (centerDetailsBean.mmeetinglocn == "" ||
        centerDetailsBean.mmeetinglocn == null||
        centerDetailsBean.mmeetinglocn.trim() == ""
        ) {
      _showAlert("Center Meeting Loaction", "Meeting Loaction is Mandatory");
      return false;
    }


if (centerDetailsBean.mrepayfrom==0   ||
        centerDetailsBean.mrepayfrom == null
        ) {
      _showAlert("Repay From", "Repay From is Mandatory");
      return false;
    }


if (centerDetailsBean.mrepayto==0   ||
        centerDetailsBean.mrepayto == null
        ) {
      _showAlert("Repay To", "Repau TO is Mandatory");
      return false;
    }
    

//  if (centerDetailsBean.mrepayto-centerDetailsBean.mrepayfrom!=6) {
//       _showAlert("Repay To Repay From", "Difference should be 6");
//       return false;
//     }   


  if (centerDetailsBean.mnextmeetngdt.isBefore(centerDetailsBean.mfirstmeetngdt)){
      _showAlert("Next Meeting Dt", "Next Meeting Date Should not be less than firs Meeting Date");
      return false;
    }     

    return true;
  }

  bool validateDate(String tmpDay, String tmpMonth, String tmpYear) {
    try {
      String pickedDate = "__-__-____";
      String newMonth;
      pickedDate = pickedDate.replaceRange(0, 2, tmpDay);
      pickedDate = pickedDate.replaceRange(3, 5, tmpMonth);
      pickedDate = pickedDate.replaceRange(6, 10, tmpYear);

      DateTime formattedDt = DateTime.parse(pickedDate.substring(6) +
          "-" +
          pickedDate.substring(3, 5) +
          "-" +
          pickedDate.substring(0, 2));

      newMonth = formattedDt.month.toString();
      if (newMonth.length == 1) newMonth = "0" + newMonth;

      if (newMonth != tmpMonth)
        return false;
      else
        return true;
    } catch (_) {
      print("Exception occurred");
      return false;
    }
  }

  void setMeetingDay(DateTime dt) {
    String dateDay;
    dateDay = dt.weekday.toString();
    dateDay = globals.weekDayArray[int.parse(dateDay)];
    print("dateDay-" + dateDay.toString());
    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues.add(centerDetailsBean.mmeetingfreq.toString());
    tempDropDownValues.add(dateDay);

    // for (int k = 0;
    //     k < globals.dropdownCaptionsValuesCenterFormation.length;
    //     k++) {
      for (int i = 0;
          i < globals.dropdownCaptionsValuesCenterFormation[1].length;
          i++) {
        try {
          if (globals.dropdownCaptionsValuesCenterFormation[1][i].mcode
                  .toString()
                  .trim() ==
              dateDay.toString().trim()) {
            print("Matched");
            setValue(1, globals.dropdownCaptionsValuesCenterFormation[1][i],false);
          }
        } catch (_) {
          print("Exception Occured");
        }
      }
    //}
  }



  void showMessage(String message, [MaterialColor color = Colors.grey]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color != null ? color : null,
        content: new Text(message)));
  }


updateFirstMeetingDate() {

    try{
      print("First meetimg date is ${firstMeetingDate}");
      print(firstMeetingDate.substring(6)+"-"+firstMeetingDate.substring(3,5)+"-"+firstMeetingDate.substring(0,2));
        centerDetailsBean.mfirstmeetngdt = DateTime.parse(firstMeetingDate.substring(6)+"-"+firstMeetingDate.substring(3,5)+"-"+firstMeetingDate.substring(0,2));
    }catch(_){

      
    }
  }



updateNextMeetingDate() {

    try{
      print("Next Meeting date ${nextMeetingDate}");
      print(nextMeetingDate.substring(6)+"-"+nextMeetingDate.substring(3,5)+"-"+nextMeetingDate.substring(0,2));
        centerDetailsBean.mnextmeetngdt = DateTime.parse(nextMeetingDate.substring(6)+"-"+nextMeetingDate.substring(3,5)+"-"+nextMeetingDate.substring(0,2));
    }catch(_){

      
    }
  }


  calculate(){




  }


  void updateAccordingToNextMeetingDate(int passedDays){

          centerDetailsBean.mnextmeetngdt = centerDetailsBean.mfirstmeetngdt.add(Duration(days:passedDays )); 

      
        try{

        
        if (centerDetailsBean.mnextmeetngdt != null) {
        if (centerDetailsBean.mnextmeetngdt.day.toString().length == 1)
          tempNextMeetingDay = "0" + centerDetailsBean.mnextmeetngdt.day.toString();
        else
          tempNextMeetingDay = centerDetailsBean.mnextmeetngdt.day.toString();

        if (centerDetailsBean.mnextmeetngdt.month.toString().length == 1)
          tempNextMeetingMonth = "0" + centerDetailsBean.mnextmeetngdt.month.toString();
        else
          tempNextMeetingMonth = centerDetailsBean.mnextmeetngdt.month.toString();

        tempNextMeetingYear = centerDetailsBean.mnextmeetngdt.year.toString();
        nextMeetingDate = nextMeetingDate.replaceRange(0, 2, tempNextMeetingDay);
        print("Next Meting DAte= ${nextMeetingDate}");
        nextMeetingDate = nextMeetingDate.replaceRange(3, 5, tempNextMeetingMonth);
        print("Next Meting DAte= ${nextMeetingDate}");
        nextMeetingDate = nextMeetingDate.replaceRange(
            6,
            10,
            centerDetailsBean.mnextmeetngdt.year
                .toString());
        print("next Meeting String = ${nextMeetingDate}");
      }


    
    }catch(_){
           print("Exception Occupred in formatting Next Meeting Date");
        }

        setState(() {
          
        });

  }


  void modifyNxtMtngAccToFreq(String freqCode) {
    if (centerDetailsBean != null && centerDetailsBean.mfirstmeetngdt != null &&
        freqCode != "") {
      enbledRepayFromTo = false;
      if (freqCode.trim() == "F") {
        try {
          List ar = mCenterRepayFromTo.split("-");
          centerDetailsBean.mrepayfrom = int.parse(ar[0]);
          centerDetailsBean.mrepayto = int.parse(ar[1]);
        } catch (_) {

        }
        //days==14;
        updateAccordingToNextMeetingDate(14);
      } else if (freqCode.trim() == "L") {
        updateAccordingToNextMeetingDate(28);
        try {
          List ar = mCenterRepayFromTo.split("-");
          centerDetailsBean.mrepayfrom = int.parse(ar[0]);
          centerDetailsBean.mrepayto = int.parse(ar[1]);
        } catch (_) {

        }
        //days==28
      } else if (freqCode.trim() == "M") {
        enbledRepayFromTo = true;
        updateAccordingToNextMeetingDate(30);
        //days==30
      }

      else {
        try {
          List ar = mCenterRepayFromTo.split("-");
          centerDetailsBean.mrepayfrom = int.parse(ar[0]);
          centerDetailsBean.mrepayto = int.parse(ar[1]);
        } catch (_) {

        }
      }
    }
  }
  void showMessageWithProgress(String message) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.black,
      content: new Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          new Text(message)
        ],
      ),
      duration: Duration(seconds: 300),
    ));
  }







}
