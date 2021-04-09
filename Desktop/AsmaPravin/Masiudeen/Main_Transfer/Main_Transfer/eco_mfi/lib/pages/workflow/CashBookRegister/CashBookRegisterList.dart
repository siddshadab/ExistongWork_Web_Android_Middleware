import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CashBookRegister/CashBookRegisterbean.dart';
import 'package:eco_mfi/pages/workflow/CashBookRegister/UserActivityList.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/InternalBankTransferStatusList.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/UserActivity/UserActivityBean.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';
import 'package:eco_mfi/pages/workflow/disbursment/bean/DisbursmentBean.dart';
import 'package:eco_mfi/pages/workflow/disbursment/list/disbursmentStatusList.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class CashBookRegisterList extends StatefulWidget {
  DateTime passedDateTime;
  double userVaultBalance;

  CashBookRegisterList({Key key, this.passedDateTime, this.userVaultBalance})
      : super(key: key);

  @override
  _CashBookRegisterListState createState() => _CashBookRegisterListState();
}

class _CashBookRegisterListState extends State<CashBookRegisterList> {
  SharedPreferences prefs;
  int branch;
  String branchName = "";
  String userName = "";
  DateTime operationDate = DateTime.now();
  DateTime findingDate; //= DateTime.now();
  int count = 1;
  var cashBookBuilder;
  int printingCode = 0;
  String companyName = "";
  String musrcode;
  List<CashBookRegisterBean> items = new List<CashBookRegisterBean>();
  List<CashBookRegisterBean> storedItems = new List<CashBookRegisterBean>();
  CashBookRegisterBean cashBookRegisterObj = new CashBookRegisterBean();
  String header = "";

  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  @override
  void initState() {
    super.initState();
    findingDate = widget.passedDateTime;
    getSessionVariables();

    setState(() {});
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      musrcode = prefs.getString(TablesColumnFile.musrcode);
      branch = prefs.get(TablesColumnFile.musrbrcode);
      branchName = prefs.getString(TablesColumnFile.branchname);
      if (branchName == null) {
        branchName = '';
      }
      userName = prefs.getString(TablesColumnFile.musrname);
      try {
        if (widget.passedDateTime == null) {
          operationDate = DateTime.parse(
              prefs.getString(TablesColumnFile.branchOperationalDate));
        } else {
          operationDate = widget.passedDateTime;
          findingDate = operationDate;
        }
      } catch (_) {
        operationDate = DateTime.now();
        findingDate = operationDate;
      }

      if(findingDate==null){
        findingDate = DateTime.now();
      }

      printingCode = prefs.getInt(TablesColumnFile.PrintingCode);
      if (printingCode == 0) {
        companyName = TablesColumnFile.wasasa;
      } else if (printingCode == 1) {
        companyName = TablesColumnFile.fullerton;
      }

      companyName = TablesColumnFile.wasasa;

      header = prefs.getString(TablesColumnFile.PRINTHEADER);
      print("Setting date hai ${operationDate}");
    });
  }

  final formater = DateFormat("yyyy-MM-dd");
  final timeformat = DateFormat("HH:mm:ss");

  Widget getDrCr(bool inflow, [double size]) {
    if (size != null) {
      if (inflow == false) {
        return new Text("Dr",
            style: TextStyle(color: Colors.red, fontSize: size));
      } else {
        return new Text("Cr",
            style: TextStyle(color: Colors.green, fontSize: size));
      }
    } else {
      if (inflow == false) {
        return new Text("Dr", style: TextStyle(color: Colors.red));
      } else {
        return new Text("Cr", style: TextStyle(color: Colors.green));
      }
    }
  }

  getInflowBody(BuildContext context, AsyncSnapshot snapshot) {
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Constant.mandatoryColor),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new GestureDetector(
                      onTap: () {},
                      child: new Row(
                        children: <Widget>[
                          Text(
                            Translations.of(context).text("Inflow") +
                                " (${cashBookRegisterObj.inflowtrnsnos})",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 25.0),
                          ),
                          //Text(" ${cashBookRegisterObj.inflowtrnsnos} Trans", style: TextStyle(color: Colors.blue, fontSize: 15.0) )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        cashBookRegisterObj.inflowcahstransaction.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                      ),
                      getDrCr(true)
                    ],
                  ),
                ),
              ],
            ),
          ),
          new GestureDetector(
            onTap: () async {
              await AppDatabaseExtended.get()
                  .getUserActivityList(
                      20, TablesColumnFile.TDOPENING, findingDate)
                  .then((List<UserActivityBean> userActivityList) {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new UserActivityList(
                            passedScreenName: "TD Account Opening",
                            passedUserActivityList: userActivityList,
                            screenType: 1,
                          )), //When Authorized Navigate to the next screen
                );
              });
            },
            child: new Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue[100]),
                //color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("TD Account opening") +
                              " (${cashBookRegisterObj.tdopngtrnsnos})"),
                          //Text(" ${cashBookRegisterObj.tdopngtrnsnos} Trans", style: TextStyle(color: Colors.blue, fontSize: 15.0) )
                        ],
                      ),
                      new Row(
                        children: <Widget>[
                          new Text(
                              "${cashBookRegisterObj.inflowtdopening ?? 0.0} "),
                          getDrCr(true)
                        ],
                      ),
                    ],
                  ),
                )),
          ),

          new ExpansionTile(
            backgroundColor: Colors.green[100],
            title: new Text(
              Translations.of(context).text("Loan_Collection") +
                  " (${cashBookRegisterObj.onlnloancolltrnsnos + cashBookRegisterObj.oflnloancolltrnsnos})",
              style: TextStyle(fontSize: 12.0),
            ),
            subtitle: new Row(
              children: <Widget>[
                new Text("${cashBookRegisterObj.overallloancollection ?? 0.0}"),
                getDrCr(true)
              ],
            ),
            children: <Widget>[
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getUserActivityList(
                          30, TablesColumnFile.INSTALPAY, findingDate)
                      .then((List<UserActivityBean> userActivityList) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                                passedScreenName: "Online Loan Collection",
                                passedUserActivityList: userActivityList,
                                screenType: 1,
                              )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("Online Loan Collection") +
                              " (${cashBookRegisterObj.onlnloancolltrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.onlineLoanCollection ?? 0.0} "),
                              getDrCr(true)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getOfflineCollectionList(findingDate)
                      .then((List<CollectionMasterBean> loanCollectionList) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                                passedScreenName: Translations.of(context)
                                    .text("Offline Loan Collection"),
                                loanCollectionList: loanCollectionList,
                                screenType: 2,
                              )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("Offline Loan Collection") +
                              " (${cashBookRegisterObj.oflnloancolltrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.offlineLoanCollection ?? 0.0} "),
                              getDrCr(true)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),

          new ExpansionTile(
            backgroundColor: Colors.green[100],
            title: new Text(
              Translations.of(context).text("Savings Collection") +
                  " (${cashBookRegisterObj.onlnnsvngcolltrnsnos + cashBookRegisterObj.oflnsvngcolltrnsnos})",
              style: TextStyle(fontSize: 12.0),
            ),
            subtitle: new Row(
              children: <Widget>[
                new Text(
                    "${cashBookRegisterObj.overallsavingscollection ?? 0.0}"),
                getDrCr(true)
              ],
            ),
            children: <Widget>[
              new GestureDetector(
                onTap: () {
                  print("Print it");
                },
                child: new GestureDetector(
                  onTap: () async {
                    await AppDatabaseExtended.get()
                        .getUserActivityList(
                            11, TablesColumnFile.DEPOSIT, findingDate)
                        .then((List<UserActivityBean> userActivityList) {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new UserActivityList(
                                  passedScreenName: Translations.of(context)
                                      .text("Online Savings Collection"),
                                  passedUserActivityList: userActivityList,
                                  screenType: 1,
                                )), //When Authorized Navigate to the next screen
                      );
                    });
                  },
                  child: new Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue[100]),
                      //color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(Translations.of(context)
                                    .text("Online Savings Collection") +
                                " (${cashBookRegisterObj.onlnnsvngcolltrnsnos})"),
                            new Row(
                              children: <Widget>[
                                new Text(
                                    "${cashBookRegisterObj.onlinesavingsCollection ?? 0.0} "),
                                getDrCr(true)
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getOfflineSavingsCollection(findingDate)
                      .then((List<SavingsListBean> savingsList) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                                passedScreenName: Translations.of(context)
                                    .text("Offline Savings Collection"),
                                savingsList: savingsList,
                                screenType: 3,
                              )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("Offline Savings Collection") +
                              " (${cashBookRegisterObj.oflnsvngcolltrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.offlinesavingscollection ?? 0.0} "),
                              getDrCr(true)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
          new ExpansionTile(
            backgroundColor: Colors.green[100],
            title: new Text(
              Translations.of(context).text("Loan Closure") +
                  " (${cashBookRegisterObj.loanclsrtrnsnos + cashBookRegisterObj.blkloanclsrtrnsnos})",
              style: TextStyle(fontSize: 12.0),
            ),
            subtitle: new Row(
              children: <Widget>[
                new Text("${cashBookRegisterObj.overallloanclosure ?? 0.0}"),
                getDrCr(true)
              ],
            ),
            children: <Widget>[
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getUserActivityList(
                          30, TablesColumnFile.CLOSURE, findingDate)
                      .then((List<UserActivityBean> userActivityList) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                                passedScreenName: Translations.of(context)
                                    .text("Single Loan closure"),
                                passedUserActivityList: userActivityList,
                                screenType: 1,
                              )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("Single Loan closure") +
                              " (${cashBookRegisterObj.loanclsrtrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.onlineloanclosure ?? 0.0} "),
                              getDrCr(true)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getUserActivityList(
                          30, TablesColumnFile.BULKLOANCLOSURE, findingDate)
                      .then((List<UserActivityBean> userActivityList) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                                passedScreenName: Translations.of(context)
                                    .text("Bulk loan pre closure"),
                                passedUserActivityList: userActivityList,
                                screenType: 1,
                              )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("Bulk loan pre closure") +
                              " (${cashBookRegisterObj.blkloanclsrtrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.onlineBulkloanclosure ?? 0.0} "),
                              getDrCr(true)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
          new ExpansionTile(
            backgroundColor: Colors.green[100],
            title: new Text(
              Translations.of(context).text("Other Transaction") +
                  " (${cashBookRegisterObj.oflninflwothrtrnsnos + cashBookRegisterObj.onlninflwothrtrnsnos})",
              style: TextStyle(fontSize: 12.0),
            ),
            subtitle: new Row(
              children: <Widget>[
                new Text("${cashBookRegisterObj.onlninflowoothrtrnsamt ?? 0.0+ cashBookRegisterObj.oflninflowoothrtrnsamt ?? 0.0  }"),
                getDrCr(true)
              ],
            ),
            children: <Widget>[
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getUserActivityList(
                      99, TablesColumnFile.INTERNALBANKTRANSFERCR, findingDate)
                      .then((List<UserActivityBean> userActivityList) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                            passedScreenName: Translations.of(context)
                                .text("Online Inflow Other transaction"),
                            passedUserActivityList: userActivityList,
                            screenType: 1,
                          )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                              .text("Online Inflow Other transaction") +
                              " (${cashBookRegisterObj.onlninflwothrtrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.onlninflowoothrtrnsamt ?? 0.0} "),
                              getDrCr(true)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              new GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new InternalBankTransferStatusList(pageType: "", transactionType: "C", findingDate: findingDate)), //When Authorized Navigate to the next screen
                  );
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                              .text("Offline Inflow Other transaction") +
                              " (${cashBookRegisterObj.oflninflwothrtrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.oflninflowoothrtrnsamt ?? 0.0} "),
                              getDrCr(true)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
          new GestureDetector(
            onTap: () async {


                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DisbursmentStatusList(passedDateTime: findingDate)), //When Authorized Navigate to the next screen
                );

            },
            child: new Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue[100]),
                //color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(Translations.of(context)
                          .text("Offline Disbursment Charges") +
                          " (${cashBookRegisterObj.oflninflwdisbtrnsnos})"),
                      new Row(
                        children: <Widget>[
                          new Text(
                              "${cashBookRegisterObj.oflninflwdisbamt ?? 0.0} "),
                          getDrCr(true)
                        ],
                      ),
                    ],
                  ),
                )),
          ),



          Container(
            decoration: BoxDecoration(color: Constant.mandatoryColor),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Translations.of(context).text("Outflow") +
                        " (${cashBookRegisterObj.outflowtrnsnos})",
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        cashBookRegisterObj.outflowcashtransaction.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 25.0),
                      ),
                      getDrCr(false)
                    ],
                  ),
                ),
              ],
            ),
          ),

          new ExpansionTile(
            backgroundColor: Colors.green[100],
            title: new Text(
              Translations.of(context).text("Disbursment") +
                  " (${cashBookRegisterObj.onlnloandisbtrnsno + cashBookRegisterObj.oflnloandisbtrnsno})",
              style: TextStyle(fontSize: 12.0),
            ),
            subtitle: new Row(
              children: <Widget>[
                new Text(
                    "${cashBookRegisterObj.overallLoanDisbursment ?? 0.0}"),
                getDrCr(false)
              ],
            ),
            children: <Widget>[
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getUserActivityList(
                          30, TablesColumnFile.INSTALPAY, findingDate)
                      .then((List<UserActivityBean> userActivityList) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                                passedScreenName: "Online Loan Disbursment",
                                passedUserActivityList: userActivityList,
                                screenType: 1,
                              )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("Online Loan Disbursment") +
                              " (${cashBookRegisterObj.onlnloancolltrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.onlineLoanCollection ?? 0.0} "),
                              getDrCr(false)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getOfflineDisbursment(findingDate)
                      .then((List<DisbursmentBean> loanDisbursment) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                                passedScreenName: Translations.of(context)
                                    .text("Offline Loan Disbursment"),
                                loanDisbursmentList: loanDisbursment,
                                screenType: 4,
                              )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("Offline Loan Disbursment") +
                              " (${cashBookRegisterObj.oflnloandisbtrnsno})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.offlineLoanDisbursment ?? 0.0} "),
                              getDrCr(false)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
          new GestureDetector(
            onTap: () async {
              await AppDatabaseExtended.get()
                  .getUserActivityList(
                      20, TablesColumnFile.TDCLOSURE, findingDate)
                  .then((List<UserActivityBean> userActivityList) {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new UserActivityList(
                            passedScreenName:
                                Translations.of(context).text("TD Closure"),
                            passedUserActivityList: userActivityList,
                            screenType: 1,
                          )), //When Authorized Navigate to the next screen
                );
              });
            },
            child: new Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue[100]),
                //color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(Translations.of(context).text("TD Closure") +
                          " (${cashBookRegisterObj.tdclsrtrnsnos})"),
                      new Row(
                        children: <Widget>[
                          new Text(
                              "${cashBookRegisterObj.outflowtdclosure ?? 0.0} "),
                          getDrCr(false)
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          new GestureDetector(
            onTap: () async {
              await AppDatabaseExtended.get()
                  .getUserActivityList(
                      11, TablesColumnFile.WITHDRAWAL, findingDate)
                  .then((List<UserActivityBean> userActivityList) {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new UserActivityList(
                            passedScreenName: Translations.of(context)
                                .text("Savings Withdrawal"),
                            passedUserActivityList: userActivityList,
                            screenType: 1,
                          )), //When Authorized Navigate to the next screen
                );
              });
            },
            child: new Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue[100]),
                //color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                          Translations.of(context).text("Savings Withdrawal") +
                              " (${cashBookRegisterObj.onlnsvngwdrwltrnsno})"),
                      new Row(
                        children: <Widget>[
                          new Text(
                              "${cashBookRegisterObj.onlinesavingswithdrawal ?? 0.0} "),
                          getDrCr(false)
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          new ExpansionTile(
            backgroundColor: Colors.green[100],
            title: new Text(
              Translations.of(context).text("Other Transaction") +
                  " (${cashBookRegisterObj.onlnoutflwothrtrnsnos + cashBookRegisterObj.oflnoutflwothrtrnsnos})",
              style: TextStyle(fontSize: 12.0),
            ),
            subtitle: new Row(
              children: <Widget>[
                new Text(
                    "${cashBookRegisterObj.onlnoutflwowoothrtrnsamt ?? 0.0+ cashBookRegisterObj.oflnoutflwowoothrtrnsamt }"),
                getDrCr(false)
              ],
            ),
            children: <Widget>[
              new GestureDetector(
                onTap: () async {
                  await AppDatabaseExtended.get()
                      .getUserActivityList(
                      99, TablesColumnFile.INTERNALBANKTRANSFERDR, findingDate)
                      .then((List<UserActivityBean> userActivityList) {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new UserActivityList(
                            passedScreenName: "Online Outflow Other trans",
                            passedUserActivityList: userActivityList,
                            screenType: 1,
                          )), //When Authorized Navigate to the next screen
                    );
                  });
                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                              .text("Online Outflow Other trans") +
                              " (${cashBookRegisterObj.onlnoutflwothrtrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.onlnoutflwowoothrtrnsamt ?? 0.0} "),
                              getDrCr(false)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              new GestureDetector(
                onTap: () async {

                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new InternalBankTransferStatusList(pageType: "", transactionType: "D", findingDate: findingDate)), //When Authorized Navigate to the next screen
                    );

                },
                child: new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[100]),
                    //color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(Translations.of(context)
                              .text("Offline Outflow Other trans") +
                              " (${cashBookRegisterObj.oflnoutflwothrtrnsnos})"),
                          new Row(
                            children: <Widget>[
                              new Text(
                                  "${cashBookRegisterObj.oflnoutflwowoothrtrnsamt ?? 0.0} "),
                              getDrCr(false)
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),













        ],
      ),
    );
  }

  Widget _getInflowItemUI(BuildContext context, int index) {
    return new GestureDetector(
        // child: new ,
        );
  }

  void makeList() async {
    count = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (count == 1) {
      count++;
      //  print("inside case 1 ");
      print("Build k andar date bheji ${findingDate}");
      cashBookBuilder = new FutureBuilder(
          future: AppDatabaseExtended.get()
              .getUserActivity(findingDate)
              .then((CashBookRegisterBean returnedCashBookRegisterList) {
            items.clear();
            storedItems.clear();
            items.add(returnedCashBookRegisterList);
            if (returnedCashBookRegisterList != null) {
              cashBookRegisterObj = returnedCashBookRegisterList;
            }
            return items;
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Text(
                    Translations.of(context).text('Press_Button_To_Start'));
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child:
                        new CircularProgressIndicator()); // new Text('Awaiting result...');
              default:
                if (snapshot.hasError)
                  return new Text(Translations.of(context).text('error') +
                      "${snapshot.error}");
                else {
                  //  print("trying to run homepage");
                  return getInflowBody(context, snapshot);
                }
            }
          });
    }

    return Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            globals.sessionTimeOut = new SessionTimeOut(context: context);
            globals.sessionTimeOut.SessionTimedOut();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title:
            new Text(Translations.of(context).text("CashBook Register")),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.print),
            onPressed: () async {
              await _callChannelCashBookPrint();
            },
          )
        ],
      ),
      body: new SingleChildScrollView(
          child: new Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                              Translations.of(context).text("name") + " : "),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                              Translations.of(context).text("BRANCH") + " : "),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                              Translations.of(context).text("Operation date") +
                                  " : "),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                              Translations.of(context).text("Current Time") +
                                  " : "),
                        ],
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(Translations.of(context)
                                  .text("current Valult Balance") +
                              " : "),
                        ],
                      ),
                    ]),
                new Column(children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        userName,
                      )
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Text(branchName),
                          new Text(" , "),
                          branch != null
                              ? new Text(branch.toString())
                              : new Text("")
                        ],
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(formater.format(operationDate)),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(timeformat.format(DateTime.now())),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text("${widget.userVaultBalance ?? 0.0}"),
                    ],
                  ),
                ]),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new DateTimeField(
              decoration: InputDecoration(
                  labelText: Translations.of(context).text("Date")),
              format: DateFormat("dd/MM/yyyy"),

              onShowPicker: (context, currentValue) async {
                print("Yhan se change hua");

                findingDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: findingDate ?? DateTime.now(),
                    lastDate: DateTime(2100));
                await makeList();
                return findingDate;
              },
              // onChanged: (DateTime dateHai)async {
              //   print("");
              //   findingDate= dateHai;
              //   await makeList();
              // },
              initialValue: findingDate,
            ),
          ),
          new Container(
            height: 800.0,
            child: cashBookBuilder,
            // height: 800.0,
            // child: new SingleChildScrollView(
            //   child: new Column(
            //     children: <Widget>[
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //       new Text(
            //         "Hello",
            //         style: TextStyle(fontSize: 40.0),
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ],
      )),
    );
  }

  _callChannelCashBookPrint() async {
    String inflowCash = "";

    String outflowCash = "";
    double vaultBalance = widget.userVaultBalance ?? 0.0;

    inflowCash += "  TD Deposit: ${cashBookRegisterObj.inflowtdopening}~";
    inflowCash +=
        "  Saving Collection: ${cashBookRegisterObj.offlinesavingscollection??0.0 + cashBookRegisterObj.onlinesavingsCollection??0.0}~";
    inflowCash +=
        "  Loan Collection  : ${cashBookRegisterObj.offlineLoanCollection??0.0 + cashBookRegisterObj.onlineLoanCollection??0.0}~";
    inflowCash +=
        "  Loan Closure: ${cashBookRegisterObj.onlineloanclosure??0.0 + cashBookRegisterObj.onlineBulkloanclosure??0.0}~";
//    inflowCash +=
//    "  Othr Trans: ${cashBookRegisterObj.onlninflowoothrtrnsamt??0.0 + cashBookRegisterObj.oflninflowoothrtrnsamt??0.0}~";
    inflowCash +=
    "  Disbursment Charges: ${cashBookRegisterObj.oflninflwdisbamt??0.0 }~";


//    inflowCash +=
//        "  Services Charges: ${cashBookRegisterObj.onlineloanclosure + cashBookRegisterObj.onlineBulkloanclosure}~";
//
//    inflowCash +=
//        "  Insurance: ${cashBookRegisterObj.onlineloanclosure + cashBookRegisterObj.onlineBulkloanclosure}~";

    inflowCash +=
        "  Other Transaction: ${cashBookRegisterObj.onlninflowoothrtrnsamt ?? 0.0+ cashBookRegisterObj.oflninflowoothrtrnsamt ?? 0.0}~";

//---------------------------------------------------------------------------------------------------
    outflowCash += "  TD Closure: ${cashBookRegisterObj.outflowtdclosure??0.0}~";
    outflowCash +=
        "  Saving Withdarwal: ${cashBookRegisterObj.onlinesavingswithdrawal??0.0}~";
    outflowCash +=
        "  Disbursment  : ${cashBookRegisterObj.offlineLoanDisbursment??0.0 + cashBookRegisterObj.onlineLoanDisbursment??0.0}~";
    outflowCash +=
        "  Other Transaction: ${cashBookRegisterObj.onlnoutflwowoothrtrnsamt??0.0+ cashBookRegisterObj.oflnoutflwowoothrtrnsamt??0.0}~";

    prefs = await SharedPreferences.getInstance();
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    try {
      if (companyName == TablesColumnFile.fullerton) {
        final String result =
            await platform.invokeMethod("cashbooksummaryprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": branch.toString(),
          "branchName": branchName,
          "date": formater.format(DateTime.now()),
          "time": timeformat.format(DateTime.now()),
          "operationDate": formater.format(findingDate),
          "openCash": vaultBalance.toString(),
          "inflowCash": inflowCash,
          "outflowCash": outflowCash,
          "userCode": musrcode,
          "userName": userName,
          "header": header,
          "companyName": companyName //companyName
        });
      } else if (companyName == TablesColumnFile.wasasa) {
        print("xxxxxxxxxxxxxxxxxxxxsending List");
        print(bluetootthAdd);
        print(branch.toString());
        print(branchName);
        print(formater.format(DateTime.now()));
        print(timeformat.format(DateTime.now()));
        print(formater.format(findingDate));
        print(vaultBalance.toString());
        print(inflowCash);
        print(outflowCash);
        print(musrcode);
        print(userName);
        print(header);
        print(companyName);

        final String result =
            await platform.invokeMethod("cashbooksummaryprint", {
          "BluetoothADD": bluetootthAdd,
          "mlbrcode": branch.toString(),
          "branchName": branchName,
          "date": formater.format(DateTime.now()),
          "time": timeformat.format(DateTime.now()),
          "operationDate": formater.format(findingDate),
          "openCash": vaultBalance.toString(),
          "inflowCash": inflowCash,
          "outflowCash": outflowCash,
          "userCode": musrcode,
          "userName": userName,
          "header": header,
          "companyName": companyName //companyName
        });
      }
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }
}
