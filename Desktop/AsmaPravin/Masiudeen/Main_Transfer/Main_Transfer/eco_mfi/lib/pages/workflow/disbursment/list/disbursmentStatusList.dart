import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class DisbursmentStatusList extends StatefulWidget {

  final DateTime passedDateTime;
  DisbursmentStatusList({Key key, this.passedDateTime})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DisbursmentStatusList> {
  List<DisbursmentBean> storedDisList = new List<DisbursmentBean>();
  List<DisbursmentBean> items = new List<DisbursmentBean>();
  Widget appBarTitle = new Text("Disbursment Status List");
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  Icon actionIcon = new Icon(Icons.search);
  Icon deleteIcon = new Icon(Icons.delete);

  int lbrCode = 0;
  String username;
  SharedPreferences prefs;
  int printingCode = 0;
  String companyName = "";
  String header = "";
  String currencyCode = "";
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
  int isWasasa = 0;

  @override
  void initState() {
    super.initState();
    getSessionVariables();
  }




  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);
    username = prefs.getString(TablesColumnFile.musrcode);
    printingCode = prefs.getInt(TablesColumnFile.PrintingCode);
    header = prefs.getString(TablesColumnFile.PRINTHEADER);
    currencyCode= prefs.getString(TablesColumnFile.CURCD);
   // isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
    setState(() {
     isWasasa = prefs.getInt(TablesColumnFile.isWASASA);
      print("IsWasasa = ${isWasasa}");
    });
    isWasasa = 1;
    if (printingCode == 0) {
      companyName = TablesColumnFile.wasasa;
    } else if (printingCode == 1) {
      companyName = TablesColumnFile.fullerton;
    }

    companyName = TablesColumnFile.wasasa;


  }

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  int count = 1;

  @override
  Widget build(BuildContext context) {
    var futureBuilder;

    if (count == 1) {
      count++;

      futureBuilder = new FutureBuilder(
          future: AppDatabase.get()
              .getDisbursmentStatusList(widget.passedDateTime)
              .then((List<DisbursmentBean> result) {
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
    }
    else {
      futureBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          return new GestureDetector(
              onTap: () {},
              child: Container(
                color: Colors.white,
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      child: Text(
                          '${items[position].mlongname.substring(
                              0, 1)}'),
                      foregroundColor: Colors.white,
                    ),
                    title: Text('${items[position].mlongname}'),
                    subtitle: new Column(
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                  Translations.of(context)
                                      .text('amttobedisb'),
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                "${items[position].mamttodisb}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: new Text(items[position].missynctocoresys==1?
                                  Translations.of(context)
                                      .text('message'):Translations.of(context)
                                  .text('error'),
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child:
                                  new Text(
                                    "${items[position].merrormessage}",
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                        color:items[position].missynctocoresys==1?Colors.green: Colors.red),
                                  )

                            )

                          ],
                        ),
                      ],
                    ),
                    trailing:
                    Container(
                      width: 100.0,
                      child: new Row(
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(
                              FontAwesomeIcons.sync,
                              color: Colors.orange[400],

                            ),
                            onPressed: () async {
                              _syncDisbursedListToMoiddleware(
                                  items[position]);
                            },
                          ),

                          new IconButton(
                            icon: new Icon(
                              Icons.print,

                              size: 25.0,
                            ),
                            onPressed: () async {
                              if(isWasasa==1){
                                _TypesOfPrint(items[position]);
                              }else{
                                _callChannelDisbursmentIndvPrint(items[position],"");
                              }



                            },
                          )
                        ],
                      ),
                    )


                ),
              ));
        },
      );
    }

    return new Scaffold(
      key: _scaffoldHomeState,
        appBar: new AppBar(
          elevation: 3.0,
          leading:
          /*tag: "Buttons",
          child: */new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
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
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
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
                      this.appBarTitle = new Text(
                          Translations.of(context).text('DisbursmentSearchList'));
                      items.clear();
                      storedDisList.forEach((val) {
                        items.add(val);
                      });
                    }
                  });
                }),
            /*new IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 44.0,
                ),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();},
                splashColor: Colors.blueAccent),*/
          ],
        ),
        body: futureBuilder
    );
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
    return new GestureDetector(
        onTap: () {},
        child:Container(
          color: Colors.white,
          child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigoAccent,
                child: Text(
                    '${items[index].mlongname.substring(
                        0, 1)}'),
                foregroundColor: Colors.white,
              ),
              title: Text('${items[index].mlongname}'),
              subtitle: new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                            Translations.of(context)
                                .text('amttobedisb'),
                            style:
                            TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "${items[index].mamttodisb}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(items[index].missynctocoresys==1?
                        Translations.of(context)
                            .text('message'):Translations.of(context)
                            .text('error'),
                            style:
                            TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "${items[index].merrormessage}",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              color:items[index].missynctocoresys==1?Colors.green: Colors.red),
                        ),
                      )

                    ],
                  ),
                ],
              ),
              trailing:
                  Container(
                    child: new Row(
                      children: <Widget>[

                        new IconButton(
                          icon: new Icon(
                            FontAwesomeIcons.sync,
                            color: Colors.orange[400],

                          ),
                          onPressed: () async {
                            _syncDisbursedListToMoiddleware(
                                items[index]);
                          },
                        ),

                        new IconButton(
                          icon: new Icon(
                            Icons.print,

                          ),
                          onPressed: () async {

                            if(isWasasa==1){

                              _TypesOfPrint(
                                  items[index]);
                            }else{
                              _callChannelDisbursmentIndvPrint(items[index],"");
                            }


                          },
                        )


                      ],

                    ),
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
          content: SingleChildScrollView(
              child: SpinKitCircle(color: Colors.teal)
          ),
        );
      },
    );
  }


  Future<void> _syncDisbursedListToMoiddleware(DisbursmentBean item) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loan Syncing'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want Sync this Loan')
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
                getDisbursmentData(item);
                _ShowProgressInd(context);
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


  void getDisbursmentData(DisbursmentBean item) async {
    try {
      bool isNetworkAvalable = await Utility.checkIntCon();
      if (isNetworkAvalable == false) {
        showMessageWithoutProgress("Network not Awailable");
      }

      SyncDisbursedListToMiddleware disbursmentService = new SyncDisbursedListToMiddleware();
      await disbursmentService.syncSingleDisbursmentToMiddleware(
          item, DateTime.now())
          .then((DisbursmentCheckBean disChkBean) async {


            if(disChkBean!=null){
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
    items = new List<DisbursmentBean>();

    storedDisList.forEach((obj) {
      if (
      obj.mlongname.toString().toUpperCase().contains(val.toUpperCase()) |
      obj.mcustno.toString().contains(
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
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  setState(() {
                  count=1;
                  });
                },
              ),
            ],
          );
        });
  }




  _callChannelDisbursmentIndvPrint(DisbursmentBean disbursmentBean,String transactionType) async {
    Navigator.of(context).pop();

    String disbursedDate = "";
    String mcustno = "";
    double disbAmount = 0.0;
    String disbAmountToString = "";
    String mcenterid;
    String productType = "";
    String leadsId = "";
    String trefno;
    String batchno;
    String setno;
    String loanRepaymnetAcc = "";
    String documentationfees = "";
    String insuranceCharges = "";
    String contactNo = "";
    String loanOfficerCode = "";
    BranchMasterBean branchMasterBean = null;
    //print("Company Name aay $companyName");

    String productCode = "";
    try {
      productCode = disbursmentBean.mprdacctid.substring(0, 8);
    } catch (_) {}
    // print("productCode = ${productCode}");
    //print("Product acctId  = ${disbursmentBean.mprdacctid}");

    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    contactNo = prefs.getString(TablesColumnFile.ContactNo);
    int branch = prefs.get(TablesColumnFile.musrbrcode);
    String branchName;
    String lbrcd;
    try{
      lbrcd=lbrCode.toString();
    }catch(_){

    }
    //print("Contact No : ${contactNo}");
    try {
      insuranceCharges = disbursmentBean.mchargesamt2.toString();
      documentationfees = disbursmentBean.mchargesamt0.toString();
      if( disbursmentBean.mdisburseddate!="null"&& disbursmentBean.mdisburseddate!=null&& disbursmentBean.mdisburseddate!=""){
        disbursedDate =dateFormat.format(disbursmentBean.mdisburseddate);}
      if( disbursmentBean.mcustno!="null"&& disbursmentBean.mcustno!=null&& disbursmentBean.mcustno!=""){
        mcustno = disbursmentBean.mcustno.toString();}
      if( disbursmentBean.mdisbursedamt!="null"&& disbursmentBean.mdisbursedamt!=null&& disbursmentBean.mdisbursedamt!=""){
        disbAmount = disbursmentBean.mdisbursedamt;}
      try {
        if (disbursmentBean.mprdacctid.trim() != '') {

          disbAmountToString = disbAmount.toString();
          loanRepaymnetAcc =
              int.parse(disbursmentBean.mprdacctid.substring(8, 16))
                  .toString() +
                  "/" +
                  (disbursmentBean.mprdacctid.substring(0, 8)).toString() +
                  "/" +
                  int.parse(disbursmentBean.mprdacctid.substring(16, 24))
                      .toString() +
                  "~" +
                  loanRepaymnetAcc;


        }
      } catch (_) {}

      if (companyName == TablesColumnFile.wasasa) {
        await AppDatabase.get().getBranchNameOnPbrCd(branch).then((onValue) {
          branchMasterBean = onValue;
          if (branchMasterBean != null &&
              branchMasterBean.mname != null){
            branchName = branchMasterBean.mname;
          }else{
            branchName= "not available";
          }

          // print("branch " + branch.toString());
          // print("branchName " + branchName.toString());
        });
      } else {
        await AppDatabase.get()
            .getProductOnPrdCd(30, lbrCode, productCode.trim())
            .then((ProductBean prdBean) {
          productType = prdBean.mname;
        });
      }
      leadsId = disbursmentBean.mleadsid;
      trefno = disbursmentBean.trefno.toString();


    } catch (e) {
      e.printStackTrace();
    }

    //print("bluetoothAddress $bluetootthAdd");


    if (disbursmentBean != null && disbursmentBean != "") {
      String repeatedStringEntryDate = "";
      //print("repeatedStringEntryDate" + repeatedStringEntryDate);
      try {
        if (disbursmentBean.mcenterid != "null" &&
            disbursmentBean.mcenterid != null &&
            disbursmentBean.mcenterid != "") {
          mcenterid = disbursmentBean.mcenterid.toString();
        }
        if (disbursmentBean.mbatchcd != "null" &&
            disbursmentBean.mbatchcd != null &&
            disbursmentBean.mbatchcd != "") {
          batchno = disbursmentBean.mbatchcd.toString();
        }
        if (disbursmentBean.msetno != "null" &&
            disbursmentBean.msetno != null &&
            disbursmentBean.msetno != "") {
          setno = disbursmentBean.msetno.toString();
        }
      }catch(_){}


      try {
        if (companyName == TablesColumnFile.fullerton) {

          print(bluetootthAdd);
          print(lbrCode);

          final String result =
          await platform.invokeMethod("disbursmentIndvPrint", {
            "BluetoothADD": bluetootthAdd,
            "mlbrcode": lbrCode.toString(),
            "date": disbursedDate,
            "mcenterid": mcenterid,
            "customername": disbursmentBean.mlongname.toString(),
            "productType": productType,
            "leadsid": leadsId,
            "loanRepaymentAccount": loanRepaymnetAcc,
            "disbursedAmount": disbAmountToString,
            "documentationFees": documentationfees,
            "insuranceCharges": insuranceCharges,
            "contactNo": contactNo,
            "loanOfficer": username,
            "custNumber": disbursmentBean.mcustno.toString(),
            "companyName": companyName ,//companyName

            "receipttype": transactionType,
          });
          String geTest = 'geTest at $result';
          print("FLutter : " + geTest.toString());
        }
        else if (companyName == TablesColumnFile.wasasa) {
          String passbookFee = "";
          String processingFee  = "";
          String premiumAmount = "";
          double totalFees = 0.00;

          print("Printing for ${transactionType} ");
          print(totalFees.toStringAsFixed(2));


          if(disbursmentBean.mchargesamt0!=null){
            passbookFee = disbursmentBean.mchargesamt0.toString();
            totalFees+=disbursmentBean.mchargesamt0;
          }

          if(disbursmentBean.mchargesamt1!=null){
            processingFee = disbursmentBean.mchargesamt1.toString();
            totalFees+=disbursmentBean.mchargesamt1;
          }


          if(disbursmentBean.mchargesamt2!=null){
            premiumAmount = disbursmentBean.mchargesamt2.toString();
            totalFees+=disbursmentBean.mchargesamt2;
          }
          print("tttt ${passbookFee}  ${processingFee} ${premiumAmount}  ${totalFees}");

          final String result =
          await platform.invokeMethod("disbursmentIndvPrint", {
            "BluetoothADD": bluetootthAdd,
            "mlbrcode": lbrCode.toString(),
            "branchName": branchName,
            "date": disbursedDate,
            "trefno": trefno,
            "batchno": batchno,
            "setno": setno,
            "loanRepaymentAccount": loanRepaymnetAcc,
            "custName":disbursmentBean.mlongname.trim(),
            "disbursedAmount": disbAmount.toStringAsFixed(2),
            "loanOfficer": username,
            "passbookFee":passbookFee,
            "processingFee":processingFee,
            "premiumAmount":premiumAmount,
            "totalFee":"7500.00",//totalFees.toStringAsFixed(2),
            "header":header,
            "receipttype": transactionType,
            // "mcenterid": 0,//new
            // "customername": " ",//new
            // "productType": "",//new
            // "leadsid": "",//new
            // "documentationFees": " ",//new
            // "insuranceCharges": " " ,//new



            "companyName": companyName //companyName
          });
        }
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }


  Future<void> _TypesOfPrint(DisbursmentBean disbursmentBean) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.touch_app,
              color: Colors.blue[800],
              size: 40.0,
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[

                  Card(
                    child: new ListTile(
                        title: new Text(Translations.of(context)
                            .text('Loan Officer Receipt')),
                        onTap: () => _callChannelDisbursmentIndvPrint(disbursmentBean, "Loan Officer")


                    ),
                  ),

                  Card(
                    child: new ListTile(
                        title: new Text(Translations.of(context)
                            .text('Customer Receipt')),
                        onTap: () => _callChannelDisbursmentIndvPrint(disbursmentBean, "Customer")),
                  ),



                ],
              ),
            ),
          );
        });
  }



}


