import 'package:eco_mfi/Utilities/globals.dart';
import 'dart:async';
import 'package:eco_mfi/db/AppDatabaseExtended.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/InternalBankTransferBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/UserActivity/UserActivityBean.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';
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
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserActivityList extends StatefulWidget {
  String passedScreenName;
  List<UserActivityBean> passedUserActivityList = new List<UserActivityBean>();
  List<CollectionMasterBean> loanCollectionList =
      new List<CollectionMasterBean>();
  List<SavingsListBean> savingsList = new List<SavingsListBean>();
  List<DisbursmentBean> loanDisbursmentList = new List<DisbursmentBean>();
  int screenType;
  //1--> online transactions
  //2--> Offline Loan Collection
  //3--> Offline Savings collection
  UserActivityList(
      {Key key,
      this.passedScreenName,
      this.passedUserActivityList,
      this.screenType,
      this.loanCollectionList,
      this.savingsList,
      this.loanDisbursmentList})
      : super(key: key);
  @override
  _UserActivityListState createState() => _UserActivityListState();
}

class _UserActivityListState extends State<UserActivityList> {
  List<UserActivityBean> storedDisList = new List<UserActivityBean>();

  //UserActivityBean usrActBean = new UserActivityBean();
  List<UserActivityBean> items = new List<UserActivityBean>();
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  List<int> selectedItems = new List<int>();
  Widget appBarTitle;

  Icon actionIcon = new Icon(Icons.search);
  Icon deleteIcon = new Icon(Icons.delete);
  var formatter = new DateFormat('dd/MMM/yyyy');
  var formatterWithTime = new DateFormat('dd/MMM/yyyy HH:mm:ss');
  Widget buildSubtitle;
  bool selectionMode = false;
  String batchCode = "";
  int setno = 0;
  List<String> splittedString = new List<String>();
  String setNo = "";
  SharedPreferences prefs;
  int lbrCd;
  String companyName = "";
  int printingCode = 0;
  String contactNo="";
  String muserCode;
  String header = "";
  int isFullerTon=0;
  String printingUserName = "";
  String branchName = "";

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  int count = 1;

  @override
  void initState() {
    print("Screen type ${widget.screenType} ");
    super.initState();
    appBarTitle = new Text("${widget.passedScreenName}");

    if (widget.screenType == 1 && widget.passedUserActivityList != null) {
      int itemsCount = 0;
      widget.passedUserActivityList.forEach((UserActivityBean obj) {
        itemsCount++;
        obj.srno = itemsCount;
        items.add(obj);
        storedDisList.add(obj);
      });
    }
    print(widget.loanCollectionList);
    getSessionVariables();

    setState(() {});
  }


  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      muserCode = prefs.getString(TablesColumnFile.musrcode);
      lbrCd = prefs.getInt(TablesColumnFile.musrbrcode);

      header = prefs.getString(TablesColumnFile.PRINTHEADER);
      printingUserName= prefs.getString(TablesColumnFile.musrname);
      branchName = prefs.getString(TablesColumnFile.branchname);
      print("Header is ${header}");

      try {
        isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
      }catch(_){}
    });
    print(prefs.getString(TablesColumnFile.mIsGroupLendingNeeded));


    printingCode = prefs.getInt(TablesColumnFile.PrintingCode);
    if(printingCode==0){
      companyName = TablesColumnFile.wasasa;
    }else if(printingCode == 1){
      companyName = TablesColumnFile.fullerton;
    }
    contactNo = prefs.getString(TablesColumnFile.ContactNo);
  }



  onTap(int position) {
    print("Selected items hai ${selectedItems}");
    if (selectionMode == true) {
      if (selectedItems.isNotEmpty&&selectedItems.contains(items[position].srno)) {
        selectedItems.remove(items[position].srno);
      } else {
        if (selectedItems.length <= 10)
          selectedItems.add(items[position].srno);
        else {
          Toast.show("Only 10 Items allowed", context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder;

    if (widget.screenType == 1) {
      futureBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          String transactionType = "";
          bool isSelected = false;

          if (selectedItems.isNotEmpty) {
            if (selectedItems.contains(items[position].srno)) {}
          }
          if (items[position].mcorerefno != null &&
              items[position].mcorerefno.trim() != '') {
            splittedString = items[position].mcorerefno.split("/");
            if (splittedString != null && splittedString.isNotEmpty) {
              batchCode = splittedString[2];
              setNo = splittedString[3];
            }
          }
          return new GestureDetector(
            onTap: () {
              if (selectionMode == true) {
                onTap(position);
              }
              setState(() {});
            },
            onLongPress: () {
              setState(() {
                if (selectionMode == false) {
                  selectionMode = true;
                  onTap(position);
                }
              });
              setState(() {});
            },
            child: Card(
              color: selectedItems.contains(items[position].srno)
                  ? Colors.grey[300]
                  : Colors.white,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(formatter.format(items[position].mcreateddt)),
                ),
                subtitle: new Column(children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            Translations.of(context).text("CustNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text("${items[position].mcustno}"),
                          new Text(
                            Translations.of(context).text("setNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(setNo),
                          new Text(
                            Translations.of(context).text("Module Type"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text("${items[position].mmoduletype}"),
                          new Text(
                            Translations.of(context).text("Transaction_Type"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(items[position].mactivity),
                        ],
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("Batch Code",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(batchCode),
                          new Text("Created Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(formatterWithTime
                              .format(items[position].mcreateddt)),
                          new IconButton( icon: new Icon(Icons.print),onPressed: ()async{
                            print("TryingPrint");

                            printTransaction(items[position]);

                          },)
                        ],
                      )
                    ],
                  ),
                  new SizedBox()
                ]),
                trailing: new Text(
                  items[position].mtxnamount.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //)
          );
        },
      );
    } else if (widget.screenType == 2) {
      futureBuilder = ListView.builder(
        itemCount: widget.loanCollectionList.length,
        itemBuilder: (context, position) {
          String transactionType = "";
          bool isSelected = false;
          widget.loanCollectionList[position].srno = position;

          if (selectedItems.isNotEmpty) {
            if (selectedItems
                .contains(widget.loanCollectionList[position].srno)) {}
          }

          batchCode = widget.loanCollectionList[position].mbatchcd;
          setNo = "--";

          return new GestureDetector(
            onTap: () {
              if (selectionMode == true) {
                onTap(position);
              }
              setState(() {});
            },
            onLongPress: () {
              setState(() {
                if (selectionMode == false) {
                  selectionMode = true;
                  onTap(position);
                }
              });
              setState(() {});
            },
            child: Card(
              color: selectedItems
                      .contains(widget.loanCollectionList[position].srno)
                  ? Colors.grey[300]
                  : Colors.white,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${formatPrdAccId(widget.loanCollectionList[position].mprdacctid) ?? widget.loanCollectionList[position].mprdacctid}"),
                ),
                subtitle: new Column(children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            Translations.of(context).text("CustNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(
                              "${widget.loanCollectionList[position].mcustno}"),
                          new Text(
                            Translations.of(context).text("setNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(setNo),
                          new Text(
                            Translations.of(context).text("name"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(
                              "${widget.loanCollectionList[position].mlongname}"),
                        ],
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("Batch Code",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(batchCode),
                          new Text("Created Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(formatterWithTime.format(
                              widget.loanCollectionList[position].mcreateddt)),
                          new Text("Module Type",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text("20"),
                        ],
                      )
                    ],
                  ),
                  new SizedBox()
                ]),
                trailing: Column(

                  children: <Widget>[
                    new Text(
                      widget.loanCollectionList[position].mcollAmt.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    new SizedBox(height:2.0 ,),
                    new IconButton(
                      icon: new Icon(Icons.print, color: Colors.white),
                      onPressed: () {
                        globals.sessionTimeOut = new SessionTimeOut(context: context);
                        globals.sessionTimeOut.SessionTimedOut();
                        //callDialog();
                        Navigator.of(context).pop();
                      },
                    ),

                  ],
                ),
              ),
            ),
            //)
          );
        },
      );
    } else if (widget.screenType == 3) {
      futureBuilder = ListView.builder(
        itemCount: widget.savingsList.length,
        itemBuilder: (context, position) {
          widget.savingsList[position].srno = position;
          batchCode = widget.savingsList[position].mbatchcd;
          setNo = "--";

          return new GestureDetector(
            onTap: () {
              if (selectionMode == true) {
                onTap(position);
              }
              setState(() {});
            },
            onLongPress: () {
              setState(() {
                if (selectionMode == false) {
                  selectionMode = true;
                  onTap(position);
                }
              });
              setState(() {});
            },
            child: Card(
              color: selectedItems.contains(widget.savingsList[position].srno)
                  ? Colors.grey[300]
                  : Colors.white,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${formatPrdAccId(widget.savingsList[position].mprdacctid) ?? widget.savingsList[position].trefno}"),
                ),
                subtitle: new Column(children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            Translations.of(context).text("CustNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text("${widget.savingsList[position].mcustno}"),
                          new Text(
                            Translations.of(context).text("setNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(setNo),
                          new Text(
                            Translations.of(context).text("Amount"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(
                              "${widget.savingsList[position].mcollectedamount}"),
                        ],
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("Batch Code",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(batchCode),
                          new Text("Created Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(formatterWithTime
                              .format(widget.savingsList[position].mcreateddt)),
                          new Text("Module Type",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text("30"),
                        ],
                      )
                    ],
                  ),
                  new SizedBox()
                ]),
                trailing: new Text(
                  widget.savingsList[position].mcollectedamount.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //)
          );
        },
      );
    } else if (widget.screenType == 4) {
      futureBuilder = ListView.builder(
        itemCount: widget.loanDisbursmentList.length,
        itemBuilder: (context, position) {
          widget.savingsList[position].srno = position;
          batchCode = widget.loanDisbursmentList[position].mbatchcd;
          setNo = "--";

          return new GestureDetector(
            onTap: () {
              if (selectionMode == true) {
                onTap(position);
              }
              setState(() {});
            },
            onLongPress: () {
              setState(() {
                if (selectionMode == false) {
                  selectionMode = true;
                  onTap(position);
                }
              });
              setState(() {});
            },
            child: Card(
              color: selectedItems
                      .contains(widget.loanDisbursmentList[position].srno)
                  ? Colors.grey[300]
                  : Colors.white,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "${formatPrdAccId(widget.loanDisbursmentList[position].mprdacctid) ?? widget.loanDisbursmentList[position].mprdacctid}"),
                ),
                subtitle: new Column(children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            Translations.of(context).text("CustNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(
                              "${widget.loanDisbursmentList[position].mcustno}"),
                          new Text(
                            Translations.of(context).text("setNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(setNo),
                          new Text(
                            Translations.of(context).text("Amount"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(
                              "${widget.loanDisbursmentList[position].mamttodisb}"),
                        ],
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("Batch Code",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(batchCode),
                          new Text("Created Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(formatterWithTime.format(
                              widget.loanDisbursmentList[position].mcreateddt)),
                          new Text("Module Type",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text("15"),
                        ],
                      )
                    ],
                  ),
                  new SizedBox()
                ]),
                trailing: new Text(
                  widget.savingsList[position].mcollectedamount.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //)
          );
        },
      );
    } else {
      futureBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          if (selectedItems.isNotEmpty) {
            if (selectedItems.contains(items[position].srno)) {}
          }
          if (items[position].mcorerefno != null &&
              items[position].mcorerefno.trim() != '') {
            splittedString = items[position].mcorerefno.split("/");
            if (splittedString != null && splittedString.isNotEmpty) {
              batchCode = splittedString[2];
              setNo = splittedString[3];
            }
          }
          return new GestureDetector(
            onTap: () {
              if (selectionMode == true) {
                onTap(position);
              }
              setState(() {});
            },
            onLongPress: () {
              setState(() {
                if (selectionMode == false) {
                  selectionMode = true;
                  onTap(position);
                }
              });
              setState(() {});
            },
            child: Card(
              color: selectedItems.contains(items[position].srno)
                  ? Colors.grey[300]
                  : Colors.white,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(formatter.format(items[position].mcreateddt)),
                ),
                subtitle: new Column(children: [
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            Translations.of(context).text("CustNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text("${items[position].mcustno}"),
                          new Text(
                            Translations.of(context).text("setNo"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(setNo),
                          new Text(
                            Translations.of(context).text("Amount"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text("${items[position].mtxnamount}"),
                          new Text(
                            Translations.of(context).text("Transaction_Type"),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          new Text(items[position].mactivity),
                        ],
                      ),
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("Batch Code",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(batchCode),
                          new Text("Created Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text(formatterWithTime
                              .format(items[position].mcreateddt)),
                          new Text("Module Type",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text("${items[position].mmoduletype}"),
                          new Text("Module Type",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          new Text("${items[position].mmoduletype}"),
                        ],
                      )
                    ],
                  ),
                  new SizedBox()
                ]),
                trailing: new Text(
                  items[position].mtxnamount.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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

            new IconButton(
                icon:new Icon(Icons.print),
              onPressed: ()async{
                  if(widget.passedScreenName == Translations.of(context)
                      .text("Savings Withdrawal") && widget.screenType== 1){

                    await printDaysWithdrawal();
                  }
              },

            )
          ],
        ),
        floatingActionButton: selectionMode == true
            ? Center(
                heightFactor: 1.0,
                child: new FloatingActionButton(
                    child: new Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.grey,
                    onPressed: () {
                      // globals.sessionTimeOut =
                      //     new SessionTimeOut(context: context);
                      // globals.sessionTimeOut.SessionTimedOut();
                      setState(() {
                        selectedItems.clear();
                        selectionMode = false;
                      });
                    }))
            : null,
        body: futureBuilder);
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
    items = new List<UserActivityBean>();

    storedDisList.forEach((obj) {
      if (obj.mcustno.toString().toUpperCase().contains(val.toUpperCase()) |
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
      return null;
    }
  }

  String formatCustNumbers(String prdaccid) {
    try {
      String newprdaccid = int.parse(prdaccid.substring(8, 16)).toString() ;
      return newprdaccid;
    } catch (_) {
      print("Error in formatting prdAccId");
      return "null";
    }
  }

  printTransaction(UserActivityBean userActObj)async {



    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    var now = new DateTime.now();
    var formatterDate = new DateFormat('dd-MM-yyyy');
    var formatterTime = new DateFormat('HH:mm:ss');
    var curDate = formatterDate.format(now);
    var curTime = formatterTime.format(now);
    String trnasactionType = "";
    String bacthNo = "";
    String setNo = "";
    String mentryDate;
    try{
      List<String> coreRefNoList = userActObj.mcorerefno.split("/");
      mentryDate = coreRefNoList[1];
      bacthNo = coreRefNoList[2];
      setNo = coreRefNoList[3];
    }catch(_){

    }


    print("${printingUserName}");
    print("${widget.passedScreenName+ " Receipt"}");
    print("${companyName}");
    print("${header}");
    print("${printingUserName}");
    print("${branchName}");
    print("${lbrCd.toString()}");



    if(companyName==TablesColumnFile.wasasa){
      try {
        final String result =
        await platform.invokeMethod("cashbooktransactionprint", {
          "BluetoothADD": bluetootthAdd,
          "date": curDate,
          "time":curTime,
          "operationDate":userActObj.mentrydate.toString(),
          "TransactionTime": userActObj.mcreateddt.toString(),
          "CustomerNumber": userActObj.mcustno.toString(),
          "Accountid": formatPrdAccId(userActObj.mprdacctid),
          "referenceNumber": bacthNo+"/"+setNo,
          "Amount": userActObj.mtxnamount.toStringAsFixed(2),
          "TransactionType": widget.passedScreenName+ " Receipt",
          "companyName": companyName ,//companyName
          "header":header,
          "userName":printingUserName,
          "branchName":branchName,
          "mlbrcode":lbrCd.toString()
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }else if(companyName==TablesColumnFile.fullerton){



    }


  }


  printDaysWithdrawal()async {



    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    var now = new DateTime.now();
    var formatterDate = new DateFormat('dd-MM-yyyy');
    var formatterTime = new DateFormat('HH:mm:ss');
    var curDate = formatterDate.format(now);
    var curTime = formatterTime.format(now);
    String mergedprdAcctId ="";
    String mergedtotals = "";
    double totalAmount = 0.0;
    String mergedCustomerNumbers = "";

    for(int i = 0 ;i< widget.passedUserActivityList.length;i++){
      mergedprdAcctId = mergedprdAcctId + formatPrdAccId(widget.passedUserActivityList[i].mprdacctid)+ "~";
      mergedtotals = mergedtotals +  widget.passedUserActivityList[i].mtxnamount.toString()+"~";
      totalAmount+= widget.passedUserActivityList[i].mtxnamount??0.0;
      mergedCustomerNumbers = mergedCustomerNumbers+  formatCustNumbers(widget.passedUserActivityList[i].mprdacctid)+"~";

    }


    print("${bluetootthAdd}");
    print("${curDate}");
    print("${curTime}");
    print(formatterDate.format(widget.passedUserActivityList[0].mentrydate));
    print("${mergedprdAcctId}");
    print("${mergedtotals}");
    print("${totalAmount.toStringAsFixed(2)}");
    print("${header}");
    print("${printingUserName}");
    print("${branchName}");
    print("${lbrCd.toString()}");
    print(mergedCustomerNumbers);



    if(companyName==TablesColumnFile.wasasa){
      try {
        final String result =
        await platform.invokeMethod("withdrawaltodaysprint", {
          "BluetoothADD": bluetootthAdd,
          "date": curDate,
          "time":curTime,
          "operationDate": formatterDate.format(widget.passedUserActivityList[0].mentrydate),
          //"CustomerNumber": userActObj.mcustno.toString(),
          "Accountid": mergedprdAcctId,
          "Amount":  mergedtotals,
          "TotalAmount": totalAmount.toStringAsFixed(2),
          "header":header,
          "userName":printingUserName,
          "branchName":branchName,
          "mlbrcode":lbrCd.toString(),
            "companyName":companyName,
            "CustomerNumbers":mergedCustomerNumbers
        });
        String geTest = 'geTest at $result';
        print("FLutter : " + geTest.toString());
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }else if(companyName==TablesColumnFile.fullerton){



    }


  }




}
