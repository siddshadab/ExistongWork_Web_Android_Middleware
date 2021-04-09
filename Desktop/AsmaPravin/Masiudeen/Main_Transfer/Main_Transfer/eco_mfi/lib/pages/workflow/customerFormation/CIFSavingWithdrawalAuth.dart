import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CIFSavingWithdrawalAuthService.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFSavingWithdrawalAuthBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CIFSavingWithdarwalAuth extends StatefulWidget {
  final List<CIFSavingWithdrawalAuthBean> passedCIFSavingWithdrawalAuthBean;
  String mprdaccid;
  CIFSavingWithdarwalAuth(this.passedCIFSavingWithdrawalAuthBean);

  @override
  _CIFSavingWithdarwalAuthState createState() =>
      new _CIFSavingWithdarwalAuthState();
}

class _CIFSavingWithdarwalAuthState extends State<CIFSavingWithdarwalAuth> {
  int count = 0;
  var authenticationList;
  List<CIFSavingWithdrawalAuthBean> cifSavingWaithdrawalAuthObj =
      new List<CIFSavingWithdrawalAuthBean>();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  DateFormat formater = new DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    super.initState();
    cifSavingWaithdrawalAuthObj = widget.passedCIFSavingWithdrawalAuthBean;
    makeList();
  }

  void makeList() async {
    authenticationList = ListView.builder(
        itemCount: cifSavingWaithdrawalAuthObj.length,
        itemBuilder: (context, position) {
          return new GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 25.0,
                  child: new ListTile(
                    title: new Row(
                      children: <Widget>[
                        new Text(
                          cifSavingWaithdrawalAuthObj[position].mcustname,
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ],
                    ),

                    subtitle: new Column(children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                Translations.of(context)
                                    .text("Savings_Account_Number"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text(formatPrdAccId(
                                  cifSavingWaithdrawalAuthObj[position]
                                      .msavingacctno)),
                              new Text(
                                Translations.of(context).text("Withdrawal_Amt"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text(cifSavingWaithdrawalAuthObj[position]
                                  .mwithdrawalamt
                                  .toString()),
                              new Text(
                                Translations.of(context).text("BatchCd"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text(cifSavingWaithdrawalAuthObj[position]
                                  .mbatchcd),
                            ],
                          ),
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                  Translations.of(context).text("CreatedBy"),
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              new Text(cifSavingWaithdrawalAuthObj[position]
                                  .mcreatedby),
                              new Text(
                                Translations.of(context).text("Entry_Date"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text(formater.format(
                                  cifSavingWaithdrawalAuthObj[position]
                                      .mentrydate)),
                              new Text(
                                Translations.of(context).text("setNo"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text(cifSavingWaithdrawalAuthObj[position]
                                  .msetno
                                  .toString()),
                            ],
                          )
                        ],
                      ),
                      cifSavingWaithdrawalAuthObj[position].mremarks != null &&
                              cifSavingWaithdrawalAuthObj[position]
                                      .mremarks
                                      .trim() !=
                                  "" &&
                              cifSavingWaithdrawalAuthObj[position]
                                      .mremarks
                                      .trim() !=
                                  'null'
                          ? new Row(
                              children: <Widget>[
                                new Text(
                                  Translations.of(context).text("Remarks") +
                                      " : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                new Text(cifSavingWaithdrawalAuthObj[position]
                                    .mremarks)
                              ],
                            )
                          : new SizedBox()
                    ]),

                    // new Column(
                    //   //crossAxisAlignment: CrossAxisAlignment.start,
                    //   children:[
                    //   new Text(  Translations.of(context).text("CreatedBy")+": ${cifSavingWaithdrawalAuthObj[position].mcreatedby}"),
                    //   new Text(  Translations.of(context).text("Amount")+": ${cifSavingWaithdrawalAuthObj[position].msubmitamt}"),

                    //   ]
                    // ),
                    trailing: new IconButton(
                        icon: Icon(
                          Icons.check,
                        ),
                        onPressed: () async {
                          await showConfirmationAlert(
                              position, cifSavingWaithdrawalAuthObj[position]);
                          setState(() {});
                        }),

                    // trailing: new Row(
                    //   children: <Widget>[
                    //     new Container(
                    //       width: 40.0,
                    //       child: new MaterialButton(
                    //         onPressed: null,
                    //         child: new Text("Accept"),
                    //       ),
                    //     ),
                    //     new Container(
                    //       width: 40.0,
                    //       child: new MaterialButton(
                    //           onPressed: null, child: Text("Decline")),
                    //     )
                    //   ],
                    // ),
                  )));
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
      return "";
    }
  }

  void submitResponse(
      int position, CIFSavingWithdrawalAuthBean cifAuthBean) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(TablesColumnFile.musrcode);
    bool netAvail = false;
    Utility utilityObj = new Utility();
    Navigator.of(context).pop();
    _ShowProgressInd(context);
    netAvail = await utilityObj.checkIfIsconnectedToNetwork();
    if (netAvail == false) {
      _showAlert(Translations.of(context).text("Network Not available"));
      return;
    }

    const JsonCodec JSON = const JsonCodec();
    final _headers = {'Content-Type': 'application/json'};

    var mapData = new Map();
    mapData[TablesColumnFile.mentrydate] =
        cifAuthBean.mentrydate.toIso8601String();
    mapData[TablesColumnFile.musercode1] = username;
    mapData[TablesColumnFile.mbatchcd] = cifAuthBean.mbatchcd;
    mapData[TablesColumnFile.mentrydate] =
        cifAuthBean.mentrydate.toIso8601String();

    mapData[TablesColumnFile.msetno] = cifAuthBean.msetno;
    String json = JSON.encode(mapData);
    print("json is ${json}");
    final bodyValue = await NetworkUtil.callPostService(
        json, Constant.apiURL + "CIFSvingWdrawAuth/submitresponse/", _headers);
    print(bodyValue);
    if (bodyValue == null || bodyValue == '') {
      Navigator.of(context).pop();
      _showAlert("No response");
      return null;
    } else {
      print("Iske andar ghusa");
      Map<String, dynamic> map = JSON.decode(bodyValue);
      CIFSavingWithdrawalAuthBean bean =
          CIFSavingWithdrawalAuthBean.fromMap(map);
      print("missynctocoresys ki value hai ${bean.missynctocoresys}");
      if (bean.missynctocoresys == 1) {
        cifSavingWaithdrawalAuthObj.removeAt(position);
        Navigator.of(context).pop();
        makeList();
        setState(() {});
      } else if (bean.missynctocoresys == 0) {
        Navigator.of(context).pop();
        _showAlert(bean.merrormessage);
      } else {
        Navigator.of(context).pop();
        _showAlert(Translations.of(context).text('somethingWentWrong'));
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldHomeState,
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: new Text("Transaction Authorization "),
        ),
        body: SafeArea(child: authenticationList));
    //return null;
  }

  Future<void> _showAlert(String error) async {
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
                      new Text(error),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> showConfirmationAlert(
      int position, CIFSavingWithdrawalAuthBean cifAuthBean) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(Translations.of(context)
                .text("Transaction Authorize Confirmation")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Translations.of(context)
                      .text("Are you sure you Want to authorize")),
                  Text(Translations.of(context).text("name") +
                      " : " +
                      cifAuthBean.mcustname),
                  Text(Translations.of(context).text("Savings_Account_Number") +
                      " : " +
                      formatPrdAccId(cifAuthBean.msavingacctno)),
                  Text(Translations.of(context).text("Withdrawal_Amt") +
                      " : " +
                      cifAuthBean.mwithdrawalamt.toString()),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Yes')),
                onPressed: () {
                  submitResponse(position, cifAuthBean);
                },
              ),
              FlatButton(
                child: Text(Translations.of(context).text('No')),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
