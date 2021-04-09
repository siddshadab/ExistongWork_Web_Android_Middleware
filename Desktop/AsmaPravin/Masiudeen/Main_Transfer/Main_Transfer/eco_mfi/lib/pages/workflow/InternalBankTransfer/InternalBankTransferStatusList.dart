import 'dart:ui';

import 'package:eco_mfi/Utilities/globals.dart';

import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/GLAccountBean.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/InternalBankTransferBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/disbursment/SyncDisbursmentListToMiddleware.dart';
import 'package:eco_mfi/pages/workflow/disbursment/bean/DisbursmentBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:eco_mfi/db/AppDatabaseExtended.dart';

import 'package:shared_preferences/shared_preferences.dart';

class InternalBankTransferStatusList extends StatefulWidget {

  final String pageType;
  final String transactionType;
  final DateTime findingDate;

  const InternalBankTransferStatusList({Key key, this.pageType, this.transactionType, this.findingDate}) : super(key: key);

  @override
  _InternalBankTransferStatusListState createState() =>
      _InternalBankTransferStatusListState();
}

class _InternalBankTransferStatusListState
    extends State<InternalBankTransferStatusList> {
  List<InternalBankTransferBean> storedDisList =
      new List<InternalBankTransferBean>();
  List<InternalBankTransferBean> items = new List<InternalBankTransferBean>();
  Widget appBarTitle = new Text("Internal Transaction List");
  String username;
  int branch = 0;
  bool circInd = false;
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;

  Icon actionIcon = new Icon(Icons.search);
  Icon deleteIcon = new Icon(Icons.delete);
  var formatter = new DateFormat('dd/MMM/yyyy');
  Widget buildSubtitle;
  String header = "";
  String printingUserName = '';
  String companyName = "";
  int printingCode = 0;
  SharedPreferences prefs;
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  int count = 1;

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);

    });
    header = prefs.getString(TablesColumnFile.PRINTHEADER);
    printingUserName = prefs.getString(TablesColumnFile.musrname);
    printingCode = prefs.getInt(TablesColumnFile.PrintingCode);
    if (printingCode == 0) {
      companyName = TablesColumnFile.wasasa;
    } else if (printingCode == 1) {
      companyName = TablesColumnFile.fullerton;
    }

    companyName = TablesColumnFile.wasasa;
    setState(() {

    });

  }


  @override
  void initState() {
    super.initState();
   // getSessionVariables();


    //print(transactionBeanObj.mcashtr);

  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder;

    if (count == 1) {
      count++;

      futureBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getInternalTransactionList(widget.pageType,widget.transactionType,widget.findingDate)
              .then((List<InternalBankTransferBean> result) {
            if (result != null) {
              items.clear();
              result.forEach((obj) {
                items.add(obj);
                storedDisList.add(obj);
              });

              return storedDisList;
            } else
              return new Container();
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
                else {
                  if (storedDisList == null || storedDisList.isEmpty) {
                    return new Container(child: new Text(""));
                  } else
                    return getHomePageBody(context, snapshot);
                }
            }
          });
    } else {
      futureBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          String transactionType = "";
          if (items[position].mcashtr == 1) {
            for (int i = 0;
                i < globals.dropdownCaptionsValuesTransaction[1].length;
                i++) {
              //print(globals.dropdownCaptionsValuesTransaction[1][i].mcode.length);
              try {
                if (globals.dropdownCaptionsValuesTransaction[1][i].mcode
                        .toString() ==
                    items[position].mcrdr.toString().trim()) {
                  transactionType =
                      globals.dropdownCaptionsValuesTransaction[1][i].mcodedesc;
                }
              } catch (_) {}
            }

            buildSubtitle = new Column(children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        Translations.of(context).text("Account Number"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      new Text(formatPrdAccId(items[position].maccid)),
                      new Text(
                        Translations.of(context).text("name"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      new Text(items[position].mcraccidname),
                    ],
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("Transaction Type",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      new Text(transactionType),
                    ],
                  )
                ],
              ),
              items[position].merrormessage != null && 
                      items[position].merrormessage.trim() != "" &&
                          items[position].merrormessage.trim() != 'null'
                  ? new Row(
                      children: <Widget>[
                        new Text(
                          Translations.of(context).text("error"),
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                        ),
                        new Text(items[position].merrormessage)
                      ],
                    )
                  : new SizedBox()
            ]);
          } else {
            buildSubtitle = new Column(children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        Translations.of(context).text("Debit  Account Number"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      new Text(formatPrdAccId(items[position].mdraccid)),
                      new Text(
                        Translations.of(context).text("name"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      new Text(items[position].mdraccidname),
                    ],
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          Translations.of(context)
                              .text("Credit Account Number"),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      new Text(formatPrdAccId(items[position].mcraccid)),
                      new Text(
                        "Name : ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      new Text(items[position].mcraccidname),
                    ],
                  )
                ],
              ),
              items[position].merrormessage != null &&
                      items[position].merrormessage.trim() != "" &&
                          items[position].merrormessage.trim() != 'null'
                  ? new Row(
                      children: <Widget>[
                        new Text(
                          Translations.of(context).text("error"),
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                        ),
                        new Text(items[position].merrormessage)
                      ],
                    )
                  : new SizedBox()
            ]);
          }

          return new GestureDetector(
              onTap: () {},
              child: 
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child:
                
                 Card(
                  //color: Colors.white,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(formatter.format(items[position].mcreateddt)),
                    ),
                    subtitle: buildSubtitle,
                    trailing:new Container(
                      height: 500.0,
                      child:new Column(
                        children: <Widget>[
                          new Text(items[position].mamt.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          new SizedBox(height: 10.0,),

                          new GestureDetector(
                            onTap: (){
                              callChannelInternalTransactionPrint(items[position]);
                            },

                            child :new Text("Print", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,decorationStyle: TextDecorationStyle.solid),)
                          )
                        ],
                      )

                    )
                    // trailing: new IconButton(
                    //   icon: new Icon(
                    //     FontAwesomeIcons.sync,
                    //     color: Colors.orange[400],
                    //     size: 25.0,
                    //   ),
                    //   onPressed: () async {
                    //     _syncDisbursedListToMoiddleware(
                    //         items[position]);
                    //   },
                    // )
                  ),
                ),
              //)
              );
        },
      );
    }

    return new Scaffold(
        key: _scaffoldHomeState,
        appBar: new AppBar(
          elevation: 3.0,
          leading:
              /*tag: "Buttons",
          child: */
              new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              globals.sessionTimeOut = new SessionTimeOut(context: context);
              globals.sessionTimeOut.SessionTimedOut();
              //callDialog();
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color(0xff01579b),
          brightness: Brightness.light,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
                icon: actionIcon,
                onPressed: () {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
                  globals.sessionTimeOut.SessionTimedOut();
                  setState(() {
                    if (this.actionIcon.icon == Icons.search) {
                      this.actionIcon = new Icon(Icons.close);
                      this.appBarTitle = new TextField(
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                        decoration: new InputDecoration(
                            prefixIcon:
                                new Icon(Icons.search, color: Colors.white),
                            hintText: Translations.of(context).text('Search'),
                            hintStyle: new TextStyle(color: Colors.white)),
                        onChanged: (val) {
                          filterList(val.toLowerCase());
                        },
                      );
                    } else {
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = new Text(Translations.of(context)
                          .text('DisbursmentSearchList'));
                      items.clear();
                      storedDisList.forEach((val) {
                        items.add(val);
                      });
                    }
                  });
                }),
          ],
        ),
        body: futureBuilder);
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null && storedDisList != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI2,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    String transactionType = "";
    if (items[index].mcashtr == 1) {
      for (int i = 0;
          i < globals.dropdownCaptionsValuesTransaction[1].length;
          i++) {
        //print(globals.dropdownCaptionsValuesTransaction[1][i].mcode.length);
        try {
          if (globals.dropdownCaptionsValuesTransaction[1][i].mcode
                  .toString() ==
              items[index].mcrdr.toString().trim()) {
            transactionType =
                globals.dropdownCaptionsValuesTransaction[1][i].mcodedesc;
          }
        } catch (_) {}
      }

      buildSubtitle = new Column(children: [
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  Translations.of(context).text("Account Number"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(formatPrdAccId(items[index].maccid)),
                new Text(
                  Translations.of(context).text("name"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(items[index].mcraccidname),
              ],
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Transaction Type",style: TextStyle(fontWeight: FontWeight.bold),),
                new Text(transactionType),
              ],
            )
          ],
        ),
        items[index].merrormessage != null &&
                items[index].merrormessage.trim() != "" &&
                    items[index].merrormessage.trim() != 'null'
            ? new Row(
                children: <Widget>[
                  new Text(
                    Translations.of(context).text("error"),
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  new Text(items[index].merrormessage)
                ],
              )
            : new SizedBox()
      ]);
    } else {
      buildSubtitle = new Column(children: [
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  Translations.of(context).text("Debit  Account Number"),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(formatPrdAccId(items[index].mdraccid)),
                new Text(
                  "Name : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(items[index].mdraccidname),
              ],
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                    Translations.of(context).text("Credit Account Number"),style: TextStyle(fontWeight: FontWeight.bold),),
                new Text(formatPrdAccId(items[index].mcraccid)),
                new Text(
                  "Name : ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(items[index].mcraccidname),
              ],
            )
          ],
        ),
        items[index].merrormessage != null &&
                items[index].merrormessage.trim() != "" &&
                    items[index].merrormessage.trim() != 'null'
            ? new Row(
                children: <Widget>[
                  new Text(
                    Translations.of(context).text("error"),
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                  new Text(items[index].merrormessage)
                ],
              )
            : new SizedBox()
      ]);
    }

    return new GestureDetector(
        onTap: () {},
        child: new Card(
          color: Colors.white,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(formatter.format(items[index].mcreateddt)),
            ),
            subtitle: buildSubtitle,
              trailing:new Container(
                  height: 450.0,
                  child:new Column(
                    children: <Widget>[
                      new Text(items[index].mamt.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                      new SizedBox(height: 10.0,),
                      new GestureDetector(
                          onTap: (){
                            callChannelInternalTransactionPrint(items[index]);
                          },

                          child :new Text("Print", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,decorationStyle: TextDecorationStyle.solid),)
                      )
                    ],
                  )

              )
          ),
        ));
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

  void getDisbursmentData(DisbursmentBean item) async {
    try {
      bool isNetworkAvalable = await Utility.checkIntCon();
      if (isNetworkAvalable == false) {
        showMessageWithoutProgress("Network not Awailable");
      }

      SyncDisbursedListToMiddleware disbursmentService =
          new SyncDisbursedListToMiddleware();
      await disbursmentService
          .syncSingleDisbursmentToMiddleware(item, DateTime.now())
          .then((DisbursmentCheckBean disChkBean) async {
        if (disChkBean != null) {
          Navigator.of(context).pop();
          _successfulSubmit(disChkBean);
        }
      });
    } catch (_) {
      Navigator.of(context).pop();
    }
  }

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void filterList(String val) async {
    // print("inside filterList");
    items.clear();
    items = new List<InternalBankTransferBean>();

    storedDisList.forEach((obj) {
      if (obj.mcraccidname
              .toString()
              .toUpperCase()
              .contains(val.toUpperCase()) |
          obj.maccid.toString().contains(
              val) /*obj.mcustno!=null && obj.mcustno!='null'?obj.mcustno.toString().toLowerCase().contains(val):false*/) {
        //  print("inside contains");
        //  print(items);
        items.add(obj);
      }
    });

    setState(() {});
  }

  Future<void> _successfulSubmit(DisbursmentCheckBean disChkBean) async {
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
                  Text("Mrefno : ${disChkBean.mrefno}"),
                  Text("Trefno : ${disChkBean.trefno}"),
                  Text('error message : ${disChkBean.merrormessage}'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
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


  callChannelInternalTransactionPrint(
      InternalBankTransferBean intTransbean) async {
    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    String macctName = "";
    await AppDatabase.get().getGlAccountDetails(intTransbean.maccid).then(( GLAccountBean glBean){
      if(glBean!=null&&glBean.mlongname!=null)
      macctName = glBean.mlongname;

    });
    String branchName = prefs.getString(TablesColumnFile.branchname);

    await getSessionVariables();
    var now = new DateTime.now();
    var formatterDate = new DateFormat('dd-MM-yyyy');
    var formatterTime = new DateFormat('H:m:s');
    var curDate = formatterDate.format(now);
    var curTime = formatterTime.format(now);
    String branchCode = "";
    String setNoString = "";
    String printingNarration = "";


    try{
      for (int i = 0;
      i < globals.dropdownCaptionsValuesTransaction[2].length;
      i++) {
        print(globals.dropdownCaptionsValuesTransaction[2][i].mcode.length);
        try {
          if (globals.dropdownCaptionsValuesTransaction[2][i].mcode
              .toString() ==
              intTransbean.mnarration.toString().trim()) {
            printingNarration = globals.dropdownCaptionsValuesTransaction[2][i].mcodedesc;
          }
        } catch (_) {
          print("Exception in dropdown");
        }
      }


    }catch(_){

    }

    try{
      setNoString = intTransbean.msetno.toString();
    }catch(_){
      setNoString= "";
    }
    String tarnsactionRef = intTransbean.mbatchcd??"" + "/" +
        (intTransbean.msetno==null?"":intTransbean.msetno.toString());
    try{
      branchCode = branch.toString();
    }catch(_){


    }
    String transactionType = "";

    if (intTransbean.mcashtr == 1) {
      transactionType = "Cash";
    }
    else{
      transactionType = "Transfer";
    }
    if (companyName == TablesColumnFile.wasasa) {
      try {
        final String result =
        await platform.invokeMethod("InternalTransactionPrint", {
          "BluetoothADD": bluetootthAdd,
          "date": curDate,
          "TransactionTime": curTime,
          "acctId": formatPrdAccId(intTransbean.maccid)??"",
          "creditAcctId": formatPrdAccId(intTransbean.mcraccid)??"",
          "debitAcctId": formatPrdAccId(intTransbean.mcraccid)??"",
          "TransactionReference": tarnsactionRef,
          "amount": intTransbean.mamt.toStringAsFixed(2),
          "acountname":macctName??"",
          "LoanOfficers": username,
          "TransactionType": transactionType,
          "companyName": TablesColumnFile.wasasa, //companyName
          "lbrcode": branchCode+" / "+ branchName??"" ,
          "remarks": printingNarration,
          "username": printingUserName,
          "header": header
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    } else if (companyName == TablesColumnFile.fullerton) {

    }

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

}
