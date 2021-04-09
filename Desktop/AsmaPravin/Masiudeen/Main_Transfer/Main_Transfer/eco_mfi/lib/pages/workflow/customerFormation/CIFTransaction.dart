import 'dart:async';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/BiometricCheck.dart';
import 'package:eco_mfi/pages/workflow/UserActivity/UserActivityBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostCIFWithdrawalToOmni.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/PostCIFTranstnToOmni.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CIFTransaction extends StatefulWidget {
  final CIFBean cifBeanPassedObject;
  int transactionType;

  CIFTransaction(this.cifBeanPassedObject, this.transactionType);

  @override
  _CIFTransactionState createState() => new _CIFTransactionState();
}

class _CIFTransactionState extends State<CIFTransaction> {
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  CIFBean cifBeanObj = new CIFBean();
  LookupBeanData narration;
  Utility obj = new Utility();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<CIFBean> cifBean;
  SharedPreferences prefs;
  String username;
  bool circInd = false;
  int lbrCd;
  double withdrwlLimitAmt;
  int isBiometricNeeded = 0;
  String mIsCustomerSelected = "Y";
  bool declCheckBox = false;
  CustomerListBean customerListBean = null;
  double loanPaymntAmt = 0.0;
  String customerName;
  String nrcNo;
  double totBal = 0.0;
  String transactionRef;
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  bool biometricResult = false;
  String companyName = "";
  int printingCode = 0;
  String contactNo="";
  UserActivityBean usrActBean = new UserActivityBean();
  int moduleType;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  int acctLbrCd;
  int isFullerTon=0;
  double amountPaid = 0;
  int stopOverPayment = 0;
  bool  enableAmountEditing = true;
  String header = "";
  String routeto = "";
  String printingUserName = '';
  String currencyCode = "";
  int externalAgentGrpCD;
  int grpCode;

  @override
  void initState() {
    super.initState();

    if (widget.cifBeanPassedObject != null) {
      cifBeanObj.mprdacctid = widget.cifBeanPassedObject.mprdacctid;
      cifBeanObj.mlbrcode = widget.cifBeanPassedObject.mlbrcode;
      cifBeanObj.mactualtotalbal = widget.cifBeanPassedObject.mactualtotalbal;
      cifBeanObj.mlienamt = widget.cifBeanPassedObject.mlienamt;
      withdrwlLimitAmt = double.parse(
          (cifBeanObj.mactualtotalbal - cifBeanObj.mlienamt)
              .toStringAsFixed(2));
      cifBeanObj.mcustno = widget.cifBeanPassedObject.mcustno;

      cifBeanObj.mprinccurrdue = widget.cifBeanPassedObject.mprinccurrdue;
      cifBeanObj.mprincoverdue = widget.cifBeanPassedObject.mprincoverdue;
      cifBeanObj.mintdue = widget.cifBeanPassedObject.mintdue;


      print("cifBeanObj.mpenalprov + ${cifBeanObj.mpenalprov}"  );
      print("cifBeanObj.mpenalpaid + ${cifBeanObj.mpenalpaid}"  );

      if(cifBeanObj.mpenalprov==null){

        cifBeanObj.mpenalprov=0.0;
      }
      if(cifBeanObj.mpenalpaid==null){
        cifBeanObj.mpenalpaid=0.0;
      }
      loanPaymntAmt = double.parse((cifBeanObj.mprinccurrdue +
              cifBeanObj.mprincoverdue +
              cifBeanObj.mintdue+(cifBeanObj.mpenalprov- cifBeanObj.mpenalpaid))
          .toStringAsFixed(2));
      if (widget.transactionType == 3) {
        cifBeanObj.mamt = loanPaymntAmt;
      }
      customerName = widget.cifBeanPassedObject.mlongname;
      nrcNo = widget.cifBeanPassedObject.mpannodesc;
      totBal = widget.cifBeanPassedObject.mactualtotalbal;
      moduleType = widget.cifBeanPassedObject.mmoduletype;
      acctLbrCd = widget.cifBeanPassedObject.mlbrcode;
      print("cifBeanObj.mcustno ${cifBeanObj.mcustno}");
      print("obj is ${cifBeanObj}");
    }
    if( widget.cifBeanPassedObject.macctstat == 3&&widget.transactionType==1){
      enableAmountEditing = false;
      cifBeanObj.mamt = withdrwlLimitAmt;
    }

    getSessionVariables();

    List tempDropDownValues = new List();
    tempDropDownValues.add(cifBeanObj.mnarration);
    print(cifBeanObj.mnarration);
    for (int k = 0; k < globals.dropdownCaptionsValuesCif.length; k++) {
      for (int i = 0; i < globals.dropdownCaptionsValuesCif[k].length; i++) {
        print("k and i is $k $i");
        print(globals.dropdownCaptionsValuesCif[k][i].mcode.length);
        try {
          if (globals.dropdownCaptionsValuesCif[k][i].mcode.toString() ==
              tempDropDownValues[k].toString().trim()) {
            print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesCif[k][i]);
          }
        } catch (_) {
          print("Exception in dropdown");
        }
      }
    }
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.musrcode);
      lbrCd = prefs.getInt(TablesColumnFile.musrbrcode);
      geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
      geoLatitude = prefs.get(TablesColumnFile.mgeolatd).toString();
      geoLongitude = prefs.get(TablesColumnFile.mgeologd).toString();
      stopOverPayment = prefs.getInt(TablesColumnFile.STOPOVERPAYMENT);  
      header = prefs.getString(TablesColumnFile.PRINTHEADER);
      routeto = prefs.getString(TablesColumnFile.mreportinguser);
      printingUserName= prefs.getString(TablesColumnFile.musrname);
      currencyCode= prefs.getString(TablesColumnFile.CURCD);
      grpCode = prefs.getInt(TablesColumnFile.grpCd);
      externalAgentGrpCD = prefs.getInt(TablesColumnFile.EXTRNLAGNTGRPCD);
      print("Header is ${header}");

      try {
        isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
      }catch(_){}
    });
    print(prefs.getString(TablesColumnFile.mIsGroupLendingNeeded));
    isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);

    AppDatabase.get().getCustMrefAndTref(cifBeanObj.mcustno).then((onValue) {
      customerListBean = onValue;
      print("mcustno " + cifBeanObj.mcustno.toString());
      print("customerListBean " + customerListBean.toString());
      print("mref ${customerListBean.mrefno}");
      print("tref ${customerListBean.trefno}");
    });

    printingCode = prefs.getInt(TablesColumnFile.PrintingCode);
      if(printingCode==0){
        companyName = TablesColumnFile.wasasa;
      }else if(printingCode == 1){
        companyName = TablesColumnFile.fullerton;
      }

      contactNo = prefs.getString(TablesColumnFile.ContactNo);
      AppDatabase.get().generateTrefnoUserActivityMaster().then((onValue) {
      setState(() {
        usrActBean.trefno = onValue;
        });
      });
  }

  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          narration = blankBean;
          cifBeanObj.mnarration = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      for (int k = 0; k < globals.dropdownCaptionsValuesCif[no].length; k++) {
        if (globals.dropdownCaptionsValuesCif[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesCif[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          narration = value;
          cifBeanObj.mnarration = value.mcode;
          break;
        default:
          break;
      }
    });
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0; k < globals.dropdownCaptionsValuesCif[no].length; k++) {
      mapData.add(globals.dropdownCaptionsValuesCif[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(
          value.mcodedesc,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  String formatPrdAccId(String prdaccid) {
    try {
      String newprdaccid = int.parse(prdaccid.substring(8, 16)).toString() +
          "/" +
          prdaccid.substring(0, 8).toString().trim() +
          "/" +
          int.parse(prdaccid.substring(16, 24)).toString();
      return newprdaccid;
    } catch (_) {
      print("Error in formatting prdAccId");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text("Transaction"),
        backgroundColor: Color(0xff07426A),
      ),
      body: new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        onChanged: () async {
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
                subtitle: cifBeanObj.mprdacctid == null
                    ? new Text("")
                    : new Text(formatPrdAccId(cifBeanObj.mprdacctid)),
              ),
            ),
            new Card(
              child: new ListTile(
                  title: new Text(Translations.of(context).text('Transaction type')),
                  subtitle: widget.transactionType == 1
                      ? new Text(Translations.of(context).text('Withdrawal'))
                      : widget.transactionType == 2
                          ? new Text(Translations.of(context).text('Deposit'))
                          : widget.transactionType == 3
                              ? new Text(Translations.of(context).text('INSTALPAY'))
                              /*: widget.transactionType == 4
                    ? new Text("Closure")*/
                              : new Text("")),
            ),
            widget.transactionType == 1 &&
                    grpCode != 0 &&
                    externalAgentGrpCD != grpCode
                ? new Card(
                    child: new ListTile(
                      title: new Text(Translations.of(context).text('Withdrawal Limit')),
                      subtitle: new Text(withdrwlLimitAmt.toString()),
                    ),
                  )
                : new Text(""),
            Card(
                child: new TextFormField(
                  enabled: enableAmountEditing,
                 keyboardType:  TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      hintText: 'Amount',
                      labelText: 'Amount',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    initialValue:
                        cifBeanObj.mamt == null ? "" : "${cifBeanObj.mamt}",
                    onSaved: (String value) {
                      if (value.isNotEmpty &&
                          value != "" &&
                          value != null &&
                          value != 'null') {
                        try {
                          cifBeanObj.mamt = double.parse(value);
                        } catch (_) {}
                      }
                    })),
            Container(
              padding: const EdgeInsets.only(left: 20.0),
              child: new DropdownButtonFormField(
                value: narration,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 0);
                },
                validator: (args) {
                  print(args);
                },
                decoration: InputDecoration(
                    labelText: globals.dropdownCaptionsCifDetails[0]),
              ),
            ),
            Card(
                child: new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'User Narration',
                      labelText: 'User Narration',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.black,
                      )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    initialValue: cifBeanObj.mremark == null
                        ? ""
                        : "${cifBeanObj.mremark}",
                    onSaved: (String value) {
                      if (value.isNotEmpty &&
                          value != "" &&
                          value != null &&
                          value != 'null') {
                        cifBeanObj.mremark = value;
                      }
                    })),
            widget.transactionType == 1
                ? isBiometricNeeded == 0
                    ? new Container()
                    : new Text(
                        Translations.of(context).text('Biometric Check'),
                        textAlign: TextAlign.center,
                      )
                : new Text(""),
            widget.transactionType == 1
                ? isBiometricNeeded == 0
                    ? new Container()
                    : new FingerScannerImageAsset(
                        mIsCustomerSelected: mIsCustomerSelected,
                        mrefno: customerListBean != null
                            ? customerListBean.mrefno
                            : 0,
                        trefno: customerListBean != null
                            ? customerListBean.trefno
                            : 0,
                        custno: cifBeanObj.mcustno,
                        isOnline: true,
                        checkResult: (bool val) {
                          updateBiometric(val);
                        })
                : new Text(""),
            widget.transactionType == 1 &&
                    grpCode != 0 &&
                    externalAgentGrpCD != grpCode
                ? isBiometricNeeded == 0
                    ? new Container()
                    : new CheckboxListTile(
                        value: declCheckBox,
                        title: new Text(
                            "I declare that i want to override the biometric result."),
                        onChanged: (val) {
                          setState(() {
                            declCheckBox = val;
                          });
                        })
                : new Text(""),
            new Container(
              height: 20.0,
            ),
            widget.transactionType == 1
                ? /*(declCheckBox == true && isBiometricNeeded == 1) ||
                        (declCheckBox == false && isBiometricNeeded == 0)
                    ?*/
                FloatingActionButton.extended(
                    icon: Icon(Icons.assignment_turned_in),
                    backgroundColor: Color(0xff07426A),
                    label: Text(Translations.of(context).text('Post Transaction')),
                    onPressed: () async {
                      cifBeanObj.mrouteto = routeto;
                      if (isBiometricNeeded == 1 && biometricResult == true) {
                        proceedwithdrawal(cifBeanObj);
                      } else if (isBiometricNeeded != 1) {
                        proceedwithdrawal(cifBeanObj);
                      } else if (isBiometricNeeded == 1 &&
                          declCheckBox == true) {
                        proceedwithdrawal(cifBeanObj);
                      } else {
                        Toast.show(
                            "Please do the BIOMETRIC OR ACCEPT the declaration to ENABLE the SAVE BUTTON!",
                            context);
                      }
                    })
                /*: FloatingActionButton.extended(
                        icon: Icon(Icons.assignment_turned_in),
                        backgroundColor: Color(0xff07426A),
                        label: Text("Post Transaction"),
                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                          Toast.show(
                              "Please do the BIOMETRIC OR ACCEPT the declaration to ENABLE the SAVE BUTTON!",
                              context);
                        })*/
                : FloatingActionButton.extended(
                    icon: Icon(Icons.assignment_turned_in),
                    backgroundColor: Color(0xff07426A),
                    label: Text(Translations.of(context).text('Post Transaction')),
                    onPressed: () async {
                      proceed(cifBeanObj);
                    }),
            new Container(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showAlert(arg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
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

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Future<void> proceed(CIFBean cifBeanObj) async {
    if (cifBeanObj.mamt == "" ||
        cifBeanObj.mamt == null ||
        cifBeanObj.mamt == 0) {
      _showAlert("Please Enter Amount for Transaction");
      return false;
    }

    if ((cifBeanObj.mremark == "" ||
        cifBeanObj.mremark == null ||
        cifBeanObj.mremark == 0)&&isFullerTon!=1) {
      _showAlert("Please Enter User Narration");
      return false;
    }
    if (widget.transactionType == 3&&(cifBeanObj.mamt>loanPaymntAmt)&&stopOverPayment==1) {

      _showAlert("Can not be greater than today's Demand");
      return false;
    }

    Future<bool> onPop(BuildContext context, String agrs1, String args2,
        String pageRoutedFrom) {
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
                    cifBeanObj.mcreatedby = username;

                    setState(() {
                      isDataSynced = true;
                      circIndicatorIsDatSynced = true;
                    });

                    PostCIFTranstnToOmni postCIFTranstnToOmni =
                        new PostCIFTranstnToOmni();
                    postCIFTranstnToOmni
                        .trySave(cifBeanObj)
                        .then((List<CIFBean> cifBean) async {
                      this.cifBean = cifBean;
                      print("cifBean" + cifBean.toString());

                      bool netAvail = false;
                      netAvail = await obj.checkIfIsconnectedToNetwork();
                      if (netAvail == false) {
                        showMessageWithoutProgress("Network Not available");
                        return;
                      } else {
                        transactionRef = cifBean[0].momnitxnrefno;
                        if (cifBean[0].momnitxnrefno == null ||
                            cifBean[0].momnitxnrefno == "null" ||
                            cifBean[0].momnitxnrefno == "") {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                          _CheckIfThere(cifBean[0].merror);
                          circInd = false;
                        } else {

                          try{
                            UpdateUserActivityMaster(cifBean);
                          } catch (e) {}
                          print("yhan momnitxnrefno hai ${cifBean[0].momnitxnrefno}");
                          _successfulSubmit(cifBean);
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

    onPop(
        context,
        Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Do_You_Want_To_Proceed'),
        Translations.of(context).text('CollectionSubmit'));
  }

  Future<void> proceedwithdrawal(CIFBean cifBeanObj) async {
    if (declCheckBox == true)
      cifBeanObj.misbiometricdeclareflagyn = "Y";
    else
      cifBeanObj.misbiometricdeclareflagyn = "N";

    if (cifBeanObj.mamt == "" ||
        cifBeanObj.mamt == null ||
        cifBeanObj.mamt == 0) {
      _showAlert("Please Enter Amount for Transaction");
      return false;
    }

    if (cifBeanObj.mamt > withdrwlLimitAmt) {
      _showAlert("Cannot withdraw more than withdrawal limit");
      return false;
    }

    if ((cifBeanObj.mremark == "" ||
        cifBeanObj.mremark == null ||
        cifBeanObj.mremark == 0)&&isFullerTon!=1) {
      _showAlert("Please Enter User Narration");
      return false;
    }

    Future<bool> onPop(BuildContext context, String agrs1, String args2,
        String pageRoutedFrom) {
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
                    cifBeanObj.mcreatedby = username;

                    setState(() {
                      isDataSynced = true;
                      circIndicatorIsDatSynced = true;
                    });

                    PostCIFWithdrawalToOmni postCIFWithdrawalToOmni =
                        new PostCIFWithdrawalToOmni();
                    postCIFWithdrawalToOmni
                        .trySave(cifBeanObj)
                        .then((List<CIFBean> cifBean) async {
                      this.cifBean = cifBean;
                      print("cifBean" + cifBean.toString());

                      bool netAvail = false;
                      netAvail = await obj.checkIfIsconnectedToNetwork();
                      if (netAvail == false) {
                        showMessageWithoutProgress("Network Not available");
                        return;
                      } else {
                        transactionRef = cifBean[0].momnitxnrefno;
                        if (cifBean[0].momnitxnrefno == null ||
                            cifBean[0].momnitxnrefno == "null" ||
                            cifBean[0].momnitxnrefno == "") {
                          _CheckIfThere(cifBean[0].merror);
                          circInd = false;
                        } else {
                          try{
                            UpdateUserActivityMaster(cifBean);
                          } catch (e) {}
                          _successfulSubmit(cifBean);
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

    onPop(
        context,
        Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Withdrawal_Amt')+ cifBeanObj.mamt.toStringAsFixed(2)+ '\n'+Translations.of(context).text('Do_You_Want_To_Proceed'),
        Translations.of(context).text('CollectionSubmit'));
  }

  Future<void> _CheckIfThere(error) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.cancel,
              color: Colors.red,
              size: 40.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(error??"No Response"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _successfulSubmit(List<CIFBean> cifObj) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 40.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Transaction Posted Successfully , Please Note OMNITxnNo - ' +
                          cifObj[0].momnitxnrefno +
                          ',\n' +acctLbrCd.toString() +
                          '/${cifObj[0].mentrydate.substring(6,8).toString()+'-'+
                          cifObj[0].mentrydate.substring(4,6).toString()+'-'+
                          cifObj[0].mentrydate.substring(0,4).toString()}/' +
                          cifObj[0].mbatchcd +
                          '/'+ cifObj[0].msetno.toString() ),
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
                  Navigator.of(context).pop();

                },
              ),
              FlatButton(
                child: Text('print '),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();

                  if(widget.transactionType==3){
                    List<CIFBean> dummyCIFList = new List<CIFBean>();
                      cifBeanObj.mloanrepayprin = cifObj[0].mloanrepayprin;
                      cifBeanObj.mloanrepayint = cifObj[0].mloanrepayint;
                       cifBeanObj.mothrchrgpen = cifObj[0].mothrchrgpen;
                       cifBeanObj.mexcessamt = cifObj[0].mexcessamt;
	                      cifBeanObj.mloanoutbal = cifObj[0].mloanoutbal;
                      cifBeanObj.momnitxnrefno = cifObj[0].momnitxnrefno;
                      cifBeanObj.moverdueintcoll = cifObj[0].moverdueintcoll;
                      if(cifObj[0].mbatchcd!=null)
                      cifBeanObj.mbatchcd = cifObj[0].mbatchcd;

                    cifBeanObj.msetno = cifObj[0].msetno;
                    dummyCIFList.add(cifBeanObj);
                      _callChannelLoanCollCustNo(dummyCIFList);

                  }else if(widget.transactionType==2&&companyName==TablesColumnFile.wasasa){
                      List<CIFBean> dummyCIFList = new List<CIFBean>();
                     if(cifObj[0].mbatchcd!=null)
                      cifBeanObj.mbatchcd = cifObj[0].mbatchcd;
                      cifBeanObj.msetno = cifObj[0].msetno;

                      dummyCIFList.add(cifBeanObj);

                      _callChannelSvngCollCustNo(dummyCIFList);


                  }
                  else{
                    if(cifObj[0].mbatchcd!=null)
                      cifBeanObj.mbatchcd = cifObj[0].mbatchcd;
                    cifBeanObj.msetno = cifObj[0].msetno;
                    _callChannelWthdrwDpstPrint();
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
          content:
              SingleChildScrollView(child: SpinKitCircle(color: Colors.teal)),
        );
      },
    );
  }

  _callChannelWthdrwDpstPrint() async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    var now = new DateTime.now();
    var formatterDate = new DateFormat('dd-MM-yyyy');
    var formatterTime = new DateFormat('H:m:s');
    var curDate = formatterDate.format(now);
    var curTime = formatterTime.format(now);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    String trnasactionType = "";

    if (widget.transactionType == 1) {
      trnasactionType = "Withdrawal";
    } else if (widget.transactionType == 2) {
      trnasactionType = "Deposit";
    }

    
      String prdAcctFormattedString = "";
        print("items.mprdacctid" + cifBeanObj.mprdacctid);
        if (cifBeanObj.mprdacctid.trim() != '') {
          try{
            prdAcctFormattedString =
                int.parse(cifBeanObj.mprdacctid.substring(8, 16)).toString() +
                    "/" +
                    (cifBeanObj.mprdacctid.substring(0, 8)).toString() +
                    "/" +
                    int.parse(cifBeanObj.mprdacctid.substring(16, 24)).toString();
          }catch(_){


          }

        }
        if (prdAcctFormattedString.trim() == '') {
          prdAcctFormattedString =
              "AccId Not Found" ;
        }
      




    if(companyName==TablesColumnFile.wasasa){
      print("Coming inside wasass");
      print("BluetoothADD"+ bluetootthAdd);
      print("date"+ curDate);
      print("TransactionTime"+ curTime);
      print("VoluntaryCompulsorySavingAC"+ prdAcctFormattedString);
      print("CustomerName"+ customerName);
      print("TransactionReference"+ cifBeanObj.mbatchcd+"/"+cifBeanObj.msetno.toString());
      print("CustomerNRCNo"+ nrcNo);
      print("DepositWithdrawalAmount"+ cifBeanObj.mamt.toStringAsFixed(2));
      print("TotalBalance"+ totBal.toString());
      print("LoanOfficers"+ username);
      print("TransactionType"+ trnasactionType);
      print( "company"+ TablesColumnFile.wasasa); //companyName
      print("lbrcode"+ lbrCd.toString());
      print("username"+ printingUserName);
      print("header " + header);
      try {
        final String result =
        await platform.invokeMethod("withdrawlDepositPrint", {
          "BluetoothADD": bluetootthAdd,
          "date": curDate,
          "TransactionTime": curTime,
          "VoluntaryCompulsorySavingAC": prdAcctFormattedString,
          "CustomerName": customerName,
          "TransactionReference": cifBeanObj.mbatchcd+"/"+cifBeanObj.msetno.toString(),
          "CustomerNRCNo": nrcNo,
          "DepositWithdrawalAmount": cifBeanObj.mamt.toStringAsFixed(2),
          "TotalBalance": totBal.toString(),
          "LoanOfficers": username,
          "TransactionType": trnasactionType,
          "company": TablesColumnFile.wasasa, //companyName
          "lbrcode": lbrCd.toString()+" / "+ branchName??"",
          "username": printingUserName,
          "header": header
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }else if(companyName==TablesColumnFile.fullerton){
      try {
        final String result =
        await platform.invokeMethod("withdrawlDepositPrint", {
          "BluetoothADD": bluetootthAdd,
          "date": curDate,
          "TransactionTime": curTime,
          "VoluntaryCompulsorySavingAC": prdAcctFormattedString,
          "CustomerName": customerName,
          "TransactionReference": transactionRef,
          "CustomerNRCNo": nrcNo,
          "DepositWithdrawalAmount": cifBeanObj.mamt.toString(),
          "TotalBalance": totBal.toString(),
          "ContactPhoneNo": "132",
          "LoanOfficers": username,
          "TransactionType": trnasactionType,
          "company": "fullerton" //companyName
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }


    }

  }

  updateBiometric(bool updateRes) {
    biometricResult = updateRes;
    setState(() {});
  }




  _callChannelLoanCollCustNo(
      List<CIFBean> collectionListBeanList) async {
    String repeatedStringAmount = "";
    double totalAmountCollected = 0.0;
    String repeatedStringCustNo = "";
    print("Loan  Collection ListBeanList" + collectionListBeanList.toString());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    print("bluetoothAddress $bluetootthAdd");
     String mcustno = collectionListBeanList[0].mcustno.toString();
    if (collectionListBeanList != null && collectionListBeanList != "") {
      for (var items in collectionListBeanList) {
        repeatedStringAmount =
            items.mamt.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mamt;
        
        repeatedStringCustNo =
            mcustno + "~" + repeatedStringCustNo;
      }

     
      print("repeatedStringAmount" + repeatedStringAmount);

      String repeatedStringprdAccId = "";
      for (var items in collectionListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid.trim() != '') {
          try{
            repeatedStringprdAccId =
                int.parse(items.mprdacctid.substring(8, 16)).toString() +
                    "/" +
                    (items.mprdacctid.substring(0, 8)).toString() +
                    "/" +
                    int.parse(items.mprdacctid.substring(16, 24)).toString();
          }catch(_){


          }

        }
        if (items.mprdacctid.trim() == '') {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
      print("repeatedStringprdAccId" + repeatedStringprdAccId.toString());
      String mlbrcode = collectionListBeanList[0].mlbrcode.toString() != ""
          ? collectionListBeanList[0].mlbrcode.toString()
          : "";
      
      String mlongname = collectionListBeanList[0].mlongname.toString();

      var formatter = new DateFormat('dd/MMM/yyyy');


      String createdDate = "";
      String createdTime= "";
      String cumpolsarySavingAmt = "";
      String loanRepPrin = "";
      String loanRepInt ="";
      String otherChargesPen="";
      String loanRpeayBal="";
      String totRepAmt  = "";
      String savingBal = "";
      String loanOutBal;
      String projectCode;
      String loanOutstandingBalString = "";
      print("Omni trexno is ${collectionListBeanList[0].momnitxnrefno}  ");

      try{
        createdDate = formatter.format(DateTime.now());
        // formatter = new DateFormat('HH/mm/ss');
        formatter = new DateFormat.jm() ;
        createdTime  = formatter.format(DateTime.now());
      }catch(_){

      }

      try{
          loanOutstandingBalString = collectionListBeanList[0].mloanoutbal.toString();
      }catch(_){


      }

      try {

        if(companyName == TablesColumnFile.wasasa){
          final String result =
          await platform.invokeMethod("loancollcustnoprint", {
            "BluetoothADD": bluetootthAdd,
            "mlbrcode": mlbrcode,
            "date": createdDate,
            "mcustno": mcustno,
            "repeatedStringAmount": repeatedStringAmount,
            "repeatedStringprdAccId": repeatedStringprdAccId,
            "repeatedStringCustomerNumber": repeatedStringCustNo,
            "branchName": branchName,
            "company": companyName,
            "trefno": collectionListBeanList[0].mbatchcd+ "/${collectionListBeanList[0].msetno}",
            "centerName": "centerName",
            "customerName": customerName,
            "total": totalAmountCollected.toStringAsFixed(2),
            "username": printingUserName,
            "header":header
            //header
          });
          String geTest = 'geTest at $result';
          print("FLutter : " + geTest.toString());

        }else if(companyName == TablesColumnFile.fullerton){
          double collectedAmount = collectionListBeanList[0].mamt;
          double loanRepaymentPrin = 0.0;
          double loanRepaymentInt = 0.0;
          double otherChargesPenalty = 0.0;
          if(collectedAmount!=null){
            if(collectionListBeanList[0].mloanrepayprin!=null){
              loanRepaymentPrin = collectionListBeanList[0].mloanrepayprin;
            }
            if(collectionListBeanList[0].mloanrepayint!=null){
              loanRepaymentInt = collectionListBeanList[0].mloanrepayint;
            }
            if(collectionListBeanList[0].moverdueintcoll!=null){
              loanRepaymentInt += collectionListBeanList[0].moverdueintcoll;
            }
            if(collectionListBeanList[0].mothrchrgpen!=null){
              otherChargesPenalty = collectionListBeanList[0].mothrchrgpen;
            }
          print("Loan Repayment principle ${loanRepaymentPrin}");
           print("loanRepaymentInt ${loanRepaymentInt}");
            print("otherChargesPenalty ${otherChargesPenalty}");
             print("Loan Repayment principle ${loanRepaymentPrin}");

            print("Header is ${header}");


          final String result =
          await platform.invokeMethod("loancollcustnoprint", {
            "BluetoothADD": bluetootthAdd,
            "mlbrcode": mlbrcode,
            "date": createdDate,//
            "mcustno": customerName,//Customer ID No
            "repeatedStringAmount": repeatedStringAmount,//
            "repeatedStringprdAccId": repeatedStringprdAccId,//Loan Repayment A/C
            "repeatedStringCustomerNumber": repeatedStringCustNo,//
            "branchName": branchName,//
            "company": companyName,//
            "trefno": collectionListBeanList[0].momnitxnrefno,//Transaction Reference
            "centerName": "printingCenterName",//
            "customerName": collectionListBeanList[0].mcustno.toString(),//Customer Name
            "total": totalAmountCollected.toStringAsFixed(2),//
            "username": username ,//Loan Officers
            "contactNo":contactNo,//Contact Phone No
            "createdDate":createdDate,//Date
            "createdTime" :createdTime,//Transaction Time

            //"CompulsorySavingAmnt": "" ,//Compulsory Saving Amount
            "LoanRepaymentPrin": loanRepaymentPrin.toString() ,//Loan Repayment (Prin)
            "LoanRepaymentInt": loanRepaymentInt.toString(),//Loan Repayment (Int)
            "OtherChargesPenalty": otherChargesPenalty.toString(),//Loan Repayment (Int)
            "TotalRepaymentAmount": totalAmountCollected.toStringAsFixed(2),//Total Repayment Amount
            //"SavingBalanceCompulsory": "",//Saving Balance ( Compulsory)
            "LoanOutstandingBalance": loanOutstandingBalString,//Loan Outstanding Balance
            //header

          });
          String geTest = 'geTest at $result';
          print("FLutter : " + geTest.toString());

        }
        }


      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  UpdateUserActivityMaster(List<CIFBean> cifUsrObj) async {
    print("UpdateUserActivityMaster");
    usrActBean.mcreateddt = DateTime.now();
    usrActBean.musercode  = username;
    usrActBean.mlbrcode  = acctLbrCd;
    usrActBean.mcustno = cifBeanObj.mcustno;
    //usrActBean.mcenterid =
   // usrActBean.mgroupcd =
    usrActBean.mtxnamount = cifBeanObj.mamt;
    usrActBean.msystemnarration = cifBeanObj.mnarration;
    usrActBean.musernarration = cifBeanObj.mremark;
    if (widget.transactionType == 1) {
      usrActBean.mactivity = "WITHDRAWAL";
      usrActBean.screenname = "Saving Withdrawal";
    }
    if (widget.transactionType == 2) {
      usrActBean.mactivity = "DEPOSIT";
      usrActBean.screenname = "Saving Deposit";
    }
    if (widget.transactionType == 3) {
      usrActBean.mactivity = "INSTALPAY";
      usrActBean.screenname = "Loan Payment";
    }
    usrActBean.mmoduletype = moduleType;
    usrActBean.mtxnrefno = cifUsrObj[0].momnitxnrefno;

    print("entry date is ${cifUsrObj[0].mentrydate} " );
    usrActBean.mentrydate = DateTime.parse(cifUsrObj[0].mentrydate);
    usrActBean.mcorerefno = acctLbrCd.toString() + "/" +cifUsrObj[0].mentrydate + "/" + cifUsrObj[0].mbatchcd + "/" + cifUsrObj[0].msetno.toString();
    usrActBean.status = "Success";
    usrActBean.mcreateddt = DateTime.now();
    usrActBean.mcreatedby = username;
    usrActBean.mlastupdatedt = DateTime.now();
    usrActBean.mlastupdateby = null;
    usrActBean.mgeolocation = geoLocation;
    usrActBean.mgeolatd = geoLatitude;
    usrActBean.mgeologd = geoLongitude;
    usrActBean.missynctocoresys=0;
    usrActBean.mlastsynsdate = null;
    usrActBean.mrefno=0;
    usrActBean.mprdacctid = cifUsrObj[0].mprdacctid;
    usrActBean.mprdacctid = cifBeanObj.mprdacctid;
    await AppDatabase.get()
        .updateUserActivityMaster(usrActBean)
        .then((val) {
      //print("val here is " + val.toString());
      });
    String diffInBal;
    if (widget.transactionType == 1) {
      diffInBal = "-${cifBeanObj.mamt}";
    }
    if (widget.transactionType == 2 || widget.transactionType == 3) {
      diffInBal = "+${cifBeanObj.mamt}";
    }

    await AppDatabase.get().updateUserVaultBalance(acctLbrCd,username,cifUsrObj[0].mcurcd,diffInBal);

  }




 _callChannelSvngCollCustNo(List<CIFBean> savingListBeanList) async {
    String repeatedStringAmount = "";
    String repeatedStringCustomerNumber = "";
    double totalAmountCollected = 0.0;
     String repeatedStringprdAccId = "";
   var dateFormat = new DateFormat('dd/MMM/yyyy');
     String date = dateFormat.format(DateTime.now());
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String branchName = prefs.getString(TablesColumnFile.branchname);
    String mlbrcode = savingListBeanList[0].mlbrcode.toString() != ""
          ? savingListBeanList[0].mlbrcode.toString()
          : "";
   String mcustno = savingListBeanList[0].mcustno.toString();
    if (savingListBeanList != null && savingListBeanList != "") {
      for (var items in savingListBeanList) {
        repeatedStringAmount =
            items.mamt.toString() + "~" + repeatedStringAmount;
        totalAmountCollected += items.mamt;
        
        repeatedStringCustomerNumber =
            mcustno + "~" + repeatedStringCustomerNumber;
      }

     
      print("repeatedStringAmount" + repeatedStringAmount);

     
      for (var items in savingListBeanList) {
        print("items.mprdacctid" + items.mprdacctid.toString());
        if (items.mprdacctid.trim() != '') {
          try{
            repeatedStringprdAccId =
                int.parse(items.mprdacctid.substring(8, 16)).toString() +
                    "/" +
                    (items.mprdacctid.substring(0, 8)).toString() +
                    "/" +
                    int.parse(items.mprdacctid.substring(16, 24)).toString();
          }catch(_){


          }

        }
        if (items.mprdacctid.trim() == '') {
          repeatedStringprdAccId =
              "AccId Not Found" + "~" + repeatedStringprdAccId;
        }
      }
    }

      try {
        final String result =
            await platform.invokeMethod("svngcollcustnoprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": mlbrcode,
          "date": date,
          "mcustno": mcustno,
          "repeatedStringAmount": repeatedStringAmount,
          "repeatedStringprdAccId": repeatedStringprdAccId,
          "repeatedStringCustomerNumber": repeatedStringCustomerNumber,
          "branchName": branchName,
          "company": TablesColumnFile.wasasa,
          //companyName
          "trefno": savingListBeanList[0].mbatchcd+"/"+savingListBeanList[0].msetno.toString(),
          "centerName": "printingCenterName",
          "customerName": customerName,
          "total": totalAmountCollected.toStringAsFixed(2),
          "username": printingUserName,
          "header":header
          //totalAmountCollected
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
   
  }


}





