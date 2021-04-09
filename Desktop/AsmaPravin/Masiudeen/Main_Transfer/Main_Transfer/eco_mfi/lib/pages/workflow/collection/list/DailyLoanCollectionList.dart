import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/translations.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';

import 'dart:convert';
import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/collection/DailyCollectionSearchScreen.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyLoanCollectionList extends StatefulWidget {
  final int mcenterid;
  final int mgroupid;
  final DateTime toDate;
  final DateTime fromDate;
  final int custNo;
  final int productNo;
  final int paginationCount;
  final bool memOfGrpYN;
  final int skipAlredyColl;
  final int todaysDueOnly;
  DailyLoanCollectionList(
      this.mcenterid,
      this.mgroupid,
      this.fromDate,
      this.toDate,
      this.custNo,
      this.productNo,
      this.paginationCount,
      this.memOfGrpYN,
      this.skipAlredyColl,
      this.todaysDueOnly);

  @override
  _DailyLoanCollectionList createState() => new _DailyLoanCollectionList();
}

class _DailyLoanCollectionList extends State<DailyLoanCollectionList> {
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  List<CollectionMasterBean> items = new List<CollectionMasterBean>();
  List<CollectionMasterBean> storedItems = new List<CollectionMasterBean>();
  List<CollectionMasterBean> tempSummaryBean ;
  Widget appBarTitle = new Text("Collection List");
  Icon actionIcon = new Icon(Icons.save);
  int count = 1;
  int cardsCount = 0;
  int pageCount = 0;
  int forwardClicks = 1;
  int paginationCount;
  int lastPagelistCount;
  bool dontIncForwrd = false;
  SharedPreferences prefs;
  String mIsGroupLendingNeeded = "Y";
  var formatter = new DateFormat('dd/MM/yyyy');
  int savedItemsLen = 0;
  int isWasasa= 1;
  bool alreadyCollected = false;
  int stopOverPayment = 0;
  int TRNSMSG = 0;
  String agentName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.paginationCount " + widget.paginationCount.toString());
    paginationCount = widget.paginationCount;
    print("widget.paginationCount " + paginationCount.toString());
    if (paginationCount == null || paginationCount == '') {
      paginationCount = 1;
    }
    getSessionVariables();

  }


  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        isWasasa = prefs.getInt(TablesColumnFile.isWASASA);
        stopOverPayment = prefs.getInt(TablesColumnFile.STOPOVERPAYMENT);
        TRNSMSG = prefs.getInt(TablesColumnFile.TRNSMSG);
        agentName = prefs.getString(TablesColumnFile.musrname);
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilderNotSynced;
    if (count == 1) {
      count++;
      try {
        //print(CustomerListBean);
        futureBuilderNotSynced = new FutureBuilder(
            future: AppDatabase.get()
                .getCollectionMasterDataFromLocalDb(
                widget.mcenterid,
                widget.mgroupid,
                widget.fromDate,
                widget.toDate,
                widget.custNo,
                widget.productNo,
                widget.memOfGrpYN,
                widget.skipAlredyColl)
                .then((List<CollectionMasterBean> collectionMasterBean) {
              items.clear();
              storedItems.clear();
              print("Pahla vala chala");
              collectionMasterBean.forEach((f) {

                if(isWasasa==1){
                  f.mcollAmt = (f.mintos+
                      (f.modamt)+
                      f.mcurrentdue
                  ).roundToDouble();


                }else{
                  if ( f.mcurrentdue != null) {

                    f.mcollAmt = double.parse(f.mcurrentdue.toStringAsFixed(2));
                  }

                }


                if( widget.todaysDueOnly==1){
                  if(f.mlastopendate!=null && f.mlastopendate!='null' &&  f.mlastopendate!='' &&
                      f.mlastopendate.difference(DateTime.now()).inDays==0){
                    storedItems.add(f);
                  }
                }else{
                  storedItems.add(f);
                }

              });
              if (paginationCount > 1 && storedItems.length > paginationCount) {
                double tempPagination = storedItems.length / paginationCount;
                pageCount = tempPagination.toInt();
                lastPagelistCount = storedItems.length % paginationCount;
                if (lastPagelistCount > 0) {
                  pageCount += 1;
                }

                for (int showItems = 0;showItems < paginationCount;showItems++) {
                  items.add(storedItems[showItems]);

                }
              } else {
                items.addAll(storedItems);
              }
              setState(() {});
              return storedItems;
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
                  if (snapshot.hasError) {
                    print('Error: ${snapshot.error}');
                    return new Center(
                      child: new Text("Nothing to display on your filter"),
                    );
                  } else
                    return getHomePageBody2(context, snapshot);
              }
            });
      } catch (e) {
        futureBuilderNotSynced = new Text("Nothing To display");
      }
    } else if (items != null) {
      futureBuilderNotSynced = ListView.builder(
        // Must have an item count equal to the number of items!
        itemCount: items.length,
        // A callback that will return a widget.
        itemBuilder: (context, position) {
          Color color;
          if (position % 2 == 1) {
            color = Colors.grey;
          } else {
            color = Colors.grey;
          }
          int mcustNoInt;
          int mprcdAcctIdInt;
          String mprdcd = items[position].mprdacctid.substring(0, 8).trim();
          String custNo = items[position].mprdacctid.substring(9, 16);
          String prcdAcctId = items[position].mprdacctid.substring(17, 24);
          double totalBalance = 0.0;
          double excesbal=0.0;
          double msdbal=0.0;
          //double collectionAmt = 0.0;
          try {
            if (custNo != null && custNo != 'null') {
              mcustNoInt = int.parse(custNo);
            }
            if (prcdAcctId != null && prcdAcctId != 'null') {
              mprcdAcctIdInt = int.parse(prcdAcctId);
            }
            if (items[position].mprnos != null) {
              totalBalance = items[position].mprnos;
            }
            print("dusri baar chalen se value"+items[position].mcollAmt.toString());
            print("dusri baar chalne se current due"+items[position].mcurrentdue.toString());

            if(items[position].mexcesspaid!=null){
              excesbal= items[position].mexcesspaid;
            }

            if(items[position].msdbal!=null){
              msdbal= items[position].msdbal;
            }
          } catch (_) {}
          return new GestureDetector(
              behavior: HitTestBehavior.opaque,
              
              child: Column(
                children: <Widget>[
                  new Card(
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
                            child: Container(
                              width: MediaQuery.of(context).size.width,
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
                                    items[position].mlongname.trim(),
                                    overflow: TextOverflow.fade,
                                    style: new TextStyle(
                                        fontSize: 18.0,
                                        fontStyle: FontStyle.normal,
                                        // color: Colors.grey[700]
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Text(
                                          mcustNoInt.toString() +
                                              "/" +
                                              mprdcd.toString() +
                                              "/" +
                                              mprcdAcctIdInt.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text(
                                        "      CNO: ${items[position].mcenterid}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        "   GNO: ${items[position].mgroupid}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      Text(
                                        "AsOnDate: ${formatter.format(items[position].mlastopendate)}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      new IconButton(
                                        icon: new Icon(Icons.sync_problem),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          _CheckUnsyncedAmTBalance(
                                              items[position].mprdacctid);
                                        },
                                      ),
                                      Text(
                                        "   Collected",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      new Checkbox(
                                          activeColor: Colors.orange[200],
                                          value: items[position].isSubmit == null ||
                                              items[position].isSubmit == 0
                                              ? false
                                              : true,
                                          onChanged: (val) {
                                            setState(() {
                                              items[position].isSubmit =
                                              val == false ? 0 : 1;
                                            });
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          new Container(
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
                                        new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            isWasasa==1?Container(
                                              // width:  100.0,
                                              child: Text(
                                                "   Int OS: ${ items[position].mintos.roundToDouble() }\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ):new Container(
                                              // width: 100.0,
                                              child: Text(
                                                "OD: ${items[position].modamt.roundToDouble()}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: items[position].modamt > 0
                                                      ? Colors.red
                                                      : Colors.grey[500],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.0,
                                            ),


                                            isWasasa==1?Container(
                                              // width:  100.0,
                                              child: Text(
                                                "   PRN OD: ${items[position].modamt}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ):Container(
                                              // width:  100.0,
                                              child: Text(
                                                "   Curr Due: ${items[position].mcurrentdue}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ),

                                            isWasasa==1?Container(
                                              // width:  100.0,
                                              child: Text(
                                                "   Curr Due: ${ items[position].mcurrentdue}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ):Container(
                                              // width:  100.0,
                                              child: Text(
                                                "   Total OS: ${totalBalance.roundToDouble()}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ),

                                            isWasasa==1?Container(
                                              // width:  100.0,
                                              child: Text(
                                                "   Total OS: ${totalBalance.roundToDouble()}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ):new SizedBox(

                                              width: 20.0,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: <Widget>[

                                            Container(
                                              // width:  100.0,
                                              child: Text(
                                                " SD Bal: ${msdbal.roundToDouble()}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // width:  100.0,
                                              child: Text(
                                                " Excess Bal: ${excesbal.roundToDouble()}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // width:  100.0,
                                              child: Text(
                                                " Exp Dt: ${formatter.format(items[position].mexpdate)}\n",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),
                                        new Row(
                                          children: <Widget>[
                                            new Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    msdbal >0?new Checkbox(
                                                        activeColor:
                                                        Colors.orange[200],
                                                        value: items[position]
                                                            .madjFrmSD ==
                                                            null ||
                                                            items[position]
                                                                .madjFrmSD ==
                                                                0
                                                            ? false
                                                            : true,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            items[position]
                                                                .madjFrmSD =
                                                            val == false
                                                                ? 0
                                                                : 1;
                                                          });
                                                        }):Container(),
                                                    //adjFrmSD
                                                    msdbal >0?new Icon(
                                                      FontAwesomeIcons.piggyBank,
                                                      //color: Colors.teal[200],
                                                      //color: Color(0xff07426A),
                                                      color: color,
                                                      size: 20.0,
                                                    ):Container(),

                                                    excesbal>0? new Checkbox(
                                                        activeColor:
                                                        Colors.orange[200],
                                                        value: items[position]
                                                            .madjfrmexcss ==
                                                            null ||
                                                            items[position]
                                                                .madjfrmexcss ==
                                                                0
                                                            ? false
                                                            : true,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            items[position]
                                                                .madjfrmexcss =
                                                            val == false
                                                                ? 0
                                                                : 1;
                                                          });
                                                        }):Container(),
                                                    //Adjfromexcss
                                                    excesbal >0?new Icon(
                                                      FontAwesomeIcons.balanceScale,
                                                      color: color,
                                                      size: 20.0,
                                                    ):Container(),
                                                    new Checkbox(
                                                        activeColor:
                                                        Colors.orange[200],
                                                        value: items[position]
                                                            .mpaidByGrp ==
                                                            null ||
                                                            items[position]
                                                                .mpaidByGrp ==
                                                                0
                                                            ? false
                                                            : true,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            items[position]
                                                                .mpaidByGrp =
                                                            val == false
                                                                ? 0
                                                                : 1;
                                                          });
                                                        }),
                                                    //paidByGrp
                                                    new Icon(
                                                      FontAwesomeIcons.userFriends,
                                                      //color: Colors.teal[200],
                                                      //color: Color(0xff07426A),
                                                      color: color,

                                                      size: 20.0,
                                                    ),

                                                    new Checkbox(
                                                        activeColor:
                                                        Colors.orange[200],
                                                        value: items[position]
                                                            .mattendence ==
                                                            null ||
                                                            items[position]
                                                                .mattendence ==
                                                                0
                                                            ? false
                                                            : true,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            items[position]
                                                                .mattendence =
                                                            val == false
                                                                ? 0
                                                                : 1;
                                                          });
                                                        }),
                                                    //attendence
                                                    new Icon(
                                                      FontAwesomeIcons.userCheck,
                                                      //color: Colors.teal[200],
                                                      //color: Color(0xff07426A),
                                                      color: color,
                                                      size: 20.0,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            new Container(
                                              width: 190.0,
                                              child: new TextFormField(
                                                controller:
                                                items[position].mremarks != null
                                                    ? TextEditingController(
                                                    text: items[position]
                                                        .mremarks)
                                                    : TextEditingController(
                                                    text: ""),
                                                /* initialValue:
                                                items[position].remarks != null
                                                    ? items[position].remarks
                                                    : "",*/
                                                onSaved: (String value) {
                                                  items[position].mremarks = value;
                                                },
                                                keyboardType:
                                                TextInputType.multiline,
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText: 'Enter Rremarks Here',
                                                    //helperText: 'Keep it short, this is just a demo.',
                                                    labelText: 'Remarks',
                                                    /*  prefixIcon: const Icon(
                                                      Icons.person,
                                                      color: Colors.green,
                                                    ),*/
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Container(
                                              width: 140.0,
                                              child: new TextFormField(
                                                controller:
                                                items[position].mcollAmt != null
                                                    ? TextEditingController(
                                                    text:items[position]
                                                        .mcollAmt
                                                        .toString())
                                                    : TextEditingController(
                                                    text:""),
                                                 //initialValue:collectionAmt==null? collectionAmt.toString():null,
                                                onSaved: (String value) {
                                                  try {

                                                    print("returned val ${value}");
                                                    items[position].mcollAmt =
                                                    double.parse(double.parse(value).toStringAsFixed(2));

                                                   
                                                    print(" Trying to save  ${items[position].mcollAmt } ");
                                                  } catch (_) {}

                                                },
                                                keyboardType: TextInputType
                                                    .numberWithOptions(),
                                                decoration: new InputDecoration(
                                                    border: new OutlineInputBorder(
                                                        borderSide: new BorderSide(
                                                            color: Colors.teal)),
                                                    hintText:
                                                    'Enter Collection Amt Here',
                                                    //helperText: 'Keep it short, this is just a demo.',
                                                    labelText: 'Collection Amt',
                                                    /* prefixIcon: const Icon(
                                                      Icons.person,
                                                      color: Colors.green,
                                                    ),*/
                                                    suffixIcon: IconButton(
                                                        icon: Icon(Icons.clear),
                                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                                          setState(() {
                                                            items[position].mcollAmt=null;
                                                          });

                                                        }),
                                                    prefixText: '',
                                                    suffixText: '',
                                                    suffixStyle: const TextStyle(
                                                        color: Colors.green)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                new ButtonTheme.bar(
                                  padding: new EdgeInsets.all(2.0),
                                  child: new ButtonBar(
                                    children: <Widget>[],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )

            //  ),
          );
        },
      );
    } else
      futureBuilderNotSynced = new Text("nothing to display");
    return WillPopScope(
        onWillPop: () {
//          globals.isMemberOfGroupListColl = [0];
//          globals.isMemeberOfGroupForColl = true;
//          globals.memberOfGroupColl = 'Yes';
          Navigator.of(context).pop();
        },
        child: new Scaffold(
          key: _scaffoldHomeState,
          bottomNavigationBar: Container(
            color: Color(0xff07426A),
            child: paginationCount > 1 && storedItems.length > paginationCount
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(FontAwesomeIcons.backward,
                      color: Colors.green),
                   onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                    _cardsCountReverse();
                  },
                ),
                Text(
                  forwardClicks.toString() + "/" + pageCount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                new IconButton(
                  icon: new Icon(FontAwesomeIcons.forward,
                      color: Colors.red),
                   onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                    forwardClicks == pageCount
                        ? _LastClick()
                        : _cardsCountForward();
                    //  _cardsCountForward();
                  },
                ),
              ],
            )
                : SizedBox(),
          ), //key: _
          appBar: new AppBar(
              elevation: 10.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                 /* globals.isMemeberOfGroupForColl = true;
                  globals.memberOfGroupColl = 'Yes';
                  globals.isMemberOfGroupListColl = [0];*/
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Color(0xff07426A),
              brightness: Brightness.light,
              title: appBarTitle,
              actions: <Widget>[
                new IconButton(
                  icon: actionIcon,
                  onPressed: () async{
                    double totalAmtCollect = 0.0;
                    double totalOs = 0.0;
                    //print("PageCount is  $paginationCount");
                    //print('forward clicks ${forwardClicks}');
                   

/*
                    for (int indexCount= 0; indexCount < items.length; indexCount++) {
                      if(items[indexCount].mcollAmt!=null && items[indexCount].isSubmit == 1 ) {
                        totalAmtCollect += items[indexCount].mcollAmt;

                      }

                    }

                    if(forwardClicks>1){
                      for (int saveData = 0; saveData < storedItems.length; saveData++) {
                        if(storedItems[saveData].mcollAmt!=null && storedItems[saveData].isSubmit == 1 ) {
                          totalAmtCollect += storedItems[saveData].mcollAmt;
                        }
                      }
                    }*/

                    List<Widget> columnChildre = new List<Widget>();
                    Widget submittingColumn = new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: columnChildre,
                    );



                    await setTempListToDisplaySummary();


                    int count = 0;
                    double amt = 0;
                     alreadyCollected = false;

                    

                    //print("tempBean ki length hai ${tempSummaryBean.length}     ${tempSummaryBean}");


                    for (int saveData = 0;saveData < tempSummaryBean.length;saveData++) {
                     
                        if (tempSummaryBean[saveData].isSubmit == 1 ) {

                          if(stopOverPayment==1){
                               amt = await AppDatabase.get()
                              .getUnsyncedDailyCollectedLaonAmt(tempSummaryBean[saveData].mprdacctid); 
                                  if(amt!=null&&amt>0.0){
                                    if((tempSummaryBean[saveData].mcollAmt + amt)>tempSummaryBean[saveData].mcurrentdue ) {
                                      _showAlert("Extra Payment Alert", "Extra Payment not allowed \n\n Name : ${tempSummaryBean[saveData].mlongname} "  
                                      " \n Collected Amount :  ${tempSummaryBean[saveData].mcollAmt} \n Already Coll : ${amt} "
                                      " \n Already to be Coll : ${tempSummaryBean[saveData].mcurrentdue} ");
                                      return;
                                    }
                                   alreadyCollected  =true;
                                   
                            
                          }else{
                            amt= 0.0;
                            if((tempSummaryBean[saveData].mcollAmt + amt)>tempSummaryBean[saveData].mcurrentdue ) {
                                      _showAlert("Extra Payment Alert", "Extra Payment not allowed \n\n Name : ${tempSummaryBean[saveData].mlongname} "  
                                      " \n Collected Amount :  ${tempSummaryBean[saveData].mcollAmt} \n Already Coll : ${amt} "
                                      " \n Already to be Coll : ${tempSummaryBean[saveData].mcurrentdue} ");
                                      return;
                                    }

                          }
                          }else{

                              if(alreadyCollected  ==false){
                                amt = await AppDatabase.get()
                              .getUnsyncedDailyCollectedLaonAmt(tempSummaryBean[saveData].mprdacctid); 
                                  if(amt!=null&&amt>0.0){
                                   alreadyCollected  =true;
                              }
                            
                          }
                          }
                            

                      
                          count++;
                          totalAmtCollect += tempSummaryBean[saveData].mcollAmt;
                          
                          columnChildre.add(SizedBox(height: 10.0));
                          columnChildre.add(new Text(
                              "${count})   ${tempSummaryBean[saveData].mlongname}  ${tempSummaryBean[saveData].mcollAmt} "));
                          if(isWasasa==1){
                            if(tempSummaryBean[saveData].mcollAmt>tempSummaryBean[saveData].mintos)
                              totalOs =(tempSummaryBean[saveData].mprnos)-(tempSummaryBean[saveData].mcollAmt-tempSummaryBean[saveData].mintos);
                              else
                            totalOs = (tempSummaryBean[saveData].mprnos);
                              columnChildre.add(new Text("Remaining Os : ${totalOs.toStringAsFixed(2)}"));

                          }    
                        }
                      
                      
                             
            

                    }
                    
                    columnChildre.add(SizedBox(height: 10.0));
                    columnChildre.add(new Text(
                      "Total :        ${totalAmtCollect} ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ));



                    //print('total amount ${totalAmtCollect}');

                    if(count==0){
                        
                      _showAlert(Translations.of(context).text('No Loan Collected'), (Translations.of(context).text('Collect Some Loan to save')));
                      return;
                    }



                    

                    if(alreadyCollected==true){
                        alreadyCollectedAlert(context,
                        'Are you sure?',
                        'Do you want Submit Collection List ',submittingColumn);

                    }
                    else{
                          onPop( context,
                        'Are you sure?',
                        'Do you want Submit Collection List ',submittingColumn);
                    }
                  
                  },
                ),

              ]),

          body: new Container(
              color: const Color(0xff07426A),
              child: Form(
                key: _formKey,
                onChanged: () {
                  final FormState form = _formKey.currentState;
                  print("Try save");
                  form.save();
                },
                child: futureBuilderNotSynced,
              )),
        ));
  }

  getHomePageBody2(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI2,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    String subs = items[index].mprdacctid.substring(8);
    print("subs " + subs.toString());

    Color color;
    if (index % 2 == 1) {
      // color = Color(0xffe8eaf6);
      //color = Colors.brown[50];
      color = Colors.grey;
    } else {
      //color = Colors.white;
      color = Colors.grey;
    }

    int mcustNoInt;
    int mprcdAcctIdInt;
    double totalBalance = 0.0;
    double excesbal=0.0;
    double msdbal=0.0;

    String mprdcd = items[index].mprdacctid.substring(0, 8).trim();
    String custNo = items[index].mprdacctid.substring(9, 16);
    String prcdAcctId = items[index].mprdacctid.substring(17, 24);
    //double collectionAmt = 0.0;

    try {
      if (custNo != null && custNo != 'null') {
        mcustNoInt = int.parse(custNo);
      }
      if (prcdAcctId != null && prcdAcctId != 'null') {
        mprcdAcctIdInt = int.parse(prcdAcctId);
      }

      if (items[index].mprnos != null) {
        totalBalance = items[index].mprnos;
      }

      print("ssssssssssssssqqqqqqqqqqqqqqqqqqq"+items[index].mcollAmt.toString());
      print("ssssssssssssss"+items[index].mcurrentdue.toString());

      if(isWasasa==1){
        if(items[index].mexpprnpaid - items[index].mpaidprn>0){
          items[index].mcollAmt = (items[index]
              .mintos+
              (items[index].modamt)+
              items[index].mcurrentdue
          ).roundToDouble();
        }else{

          print("Changing from index wasasa due");
          items[index].mcollAmt = (items[index]
              .mintos+
              items[index].mcurrentdue
          ).roundToDouble();
        }


      }
      else if (items[index].mcurrentdue != null) {
        print("Changing from index current due");
        items[index].mcollAmt= double.parse("0"+items[index].mcurrentdue.toString());
      }

      if(items[index].mexcesspaid!=null){
        excesbal= items[index].mexcesspaid;
      }

      if(items[index].msdbal!=null){
        msdbal= items[index].msdbal;
      }
    } catch (_) {}
    print("prdcd " + mprdcd.toString());
    print("custNo " + custNo.toString());
    print("prcdAcctId " + prcdAcctId.toString());

    return new GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: <Widget>[
            new Card(
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
                      child: Container(
                        /* decoration: new BoxDecoration(borderRadius:
                      BorderRadius.circular(6.0),
                        color: Colors.grey,),*/
                        //color: color,
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
                        child: Column(
                          children: <Widget>[
                            new Text(
                              items[index].mlongname.trim(),
                              overflow: TextOverflow.fade,
                              style: new TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.normal,
                                  // color: Colors.grey[700]
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              children: <Widget>[
                                new Text(
                                    mcustNoInt.toString() +
                                        "/" +
                                        mprdcd.toString() +
                                        "/" +
                                        mprcdAcctIdInt.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                Text(
                                  "      CNO: ${items[index].mcenterid}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "   GNO: ${items[index].mgroupid}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "AsOnDate: ${formatter.format(items[index].mlastopendate)}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                new IconButton(
                                  icon: new Icon(Icons.sync_problem),
                                   onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                    _CheckUnsyncedAmTBalance(
                                        items[index].mprdacctid);
                                  },
                                ),
                                Text(
                                  "   Collected",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                                new Checkbox(
                                    activeColor: Colors.orange[200],
                                    value: items[index].isSubmit == null ||
                                        items[index].isSubmit == 0
                                        ? false
                                        : true,
                                    onChanged: (val) {
                                      setState(() {
                                        items[index].isSubmit =
                                        val == false ? 0 : 1;
                                      });
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    new Container(
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
                                  new Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      isWasasa==1?Container(
                                        // width:  100.0,
                                        child: Text(
                                          "   Int OS: ${ items[index].mintos.roundToDouble() }\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ):new Container(
                                        // width: 100.0,
                                        child: Text(
                                          "OD: ${items[index].modamt.roundToDouble()}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: items[index].modamt > 0
                                                ? Colors.red
                                                : Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.0,
                                      ),

                                      isWasasa==1?Container(
                                        // width:  100.0,
                                        child: Text(
                                          "   PRN OD: ${items[index].mexpprnpaid}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ):Container(
                                        // width:  100.0,
                                        child: Text(
                                          "   Curr Due: ${items[index].mcurrentdue.roundToDouble()}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                      isWasasa==1?Container(
                                        // width:  100.0,
                                        child: Text(
                                          " Curr Due: ${ items[index].mcurrentdue}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ):Container(
                                        // width:  100.0,
                                        child: Text(
                                          "   Total OS: ${totalBalance.roundToDouble()}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),

                                      isWasasa==1?Container(
                                        // width:  100.0,
                                        child: Text(
                                          "   Total OS: ${totalBalance.roundToDouble()}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ):new SizedBox(
                                        width: 20.0,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      Container(
                                        // width:  100.0,
                                        child: Text(
                                          " SD Bal: ${msdbal.roundToDouble()}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // width:  100.0,
                                        child: Text(
                                          " Excess Bal: ${excesbal.roundToDouble()}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // width:  100.0,
                                        child: Text(
                                          " Exp Dt: ${formatter.format(items[index].mexpdate)}\n",
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              msdbal >0?new Checkbox(
                                                  activeColor:
                                                  Colors.orange[200],
                                                  value: items[index]
                                                      .madjFrmSD ==
                                                      null ||
                                                      items[index]
                                                          .madjFrmSD ==
                                                          0
                                                      ? false
                                                      : true,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      items[index]
                                                          .madjFrmSD =
                                                      val == false
                                                          ? 0
                                                          : 1;
                                                    });
                                                  }):Container(),
                                              //adjFrmSD
                                              msdbal >0?new Icon(
                                                FontAwesomeIcons.piggyBank,
                                                //color: Colors.teal[200],
                                                //color: Color(0xff07426A),
                                                color: color,
                                                size: 20.0,
                                              ):Container(),

                                              excesbal>0? new Checkbox(
                                                  activeColor:
                                                  Colors.orange[200],
                                                  value: items[index]
                                                      .madjfrmexcss ==
                                                      null ||
                                                      items[index]
                                                          .madjfrmexcss ==
                                                          0
                                                      ? false
                                                      : true,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      items[index]
                                                          .madjfrmexcss =
                                                      val == false
                                                          ? 0
                                                          : 1;
                                                    });
                                                  }):Container(),
                                              //Adjfromexcss
                                              excesbal >0?new Icon(
                                                FontAwesomeIcons.balanceScale,
                                                color: color,
                                                size: 20.0,
                                              ):Container(),
                                              new Checkbox(
                                                  activeColor: Colors.orange[200],
                                                  value: items[index].mpaidByGrp ==
                                                      null ||
                                                      items[index].mpaidByGrp ==
                                                          0
                                                      ? false
                                                      : true,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      items[index].mpaidByGrp =
                                                      val == false ? 0 : 1;
                                                    });
                                                  }),
                                              //paidByGrp
                                              new Icon(
                                                FontAwesomeIcons.userFriends,
                                                //color: Colors.teal[200],
                                                //color: Color(0xff07426A),
                                                color: color,

                                                size: 20.0,
                                              ),

                                              new Checkbox(
                                                  activeColor: Colors.orange[200],
                                                  value: items[index].mattendence ==
                                                      null ||
                                                      items[index]
                                                          .mattendence ==
                                                          0
                                                      ? false
                                                      : true,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      items[index].mattendence =
                                                      val == false ? 0 : 1;
                                                    });
                                                  }),
                                              //attendence
                                              new Icon(
                                                FontAwesomeIcons.userCheck,
                                                //color: Colors.teal[200],
                                                //color: Color(0xff07426A),
                                                color: color,
                                                size: 20.0,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Container(
                                        width: 190.0,
                                        child: new TextFormField(
                                          controller: items[index].mremarks != null
                                              ? TextEditingController(
                                              text: items[index]
                                                  .mremarks
                                                  .toString())
                                              : TextEditingController(text: ""),
                                          /* initialValue:
                                      items[index].remarks !=
                                          null
                                          ? items[index]
                                          .remarks
                                          .toString()
                                          : "",*/
                                          onSaved: (String value) {
                                            items[index].mremarks = value;
                                          },
                                          keyboardType: TextInputType.multiline,
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.teal)),
                                              hintText: 'Enter Rremarks Here',
                                              // helperText: 'Keep it short, this is just a demo.',
                                              labelText: 'Remarks',
                                              /* prefixIcon: const Icon(
                                                Icons.person,
                                                color: Colors.green,
                                              ),*/
                                              prefixText: '',
                                              suffixText: '',
                                              suffixStyle: const TextStyle(
                                                  color: Colors.green)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Container(
                                        width: 140.0,
                                        child: new TextFormField(
                                          controller: items[index].mcollAmt != null
                                              ? TextEditingController(
                                              text: items[index]
                                                  .mcollAmt
                                                  .toString())
                                              : TextEditingController(text: ""),


                                          onSaved: (String value) {

                                            print("Trying to from other  ${items[index].mcollAmt}");
                                            items[index].mcollAmt =
                                                double.parse(double.parse(value).toStringAsFixed(2))
                                            ;
                                          },
                                          keyboardType:
                                          TextInputType.numberWithOptions(),
                                          decoration: new InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: Colors.teal)),
                                              hintText: 'Enter Collection Amt Here',
                                              //helperText: 'Collected Amount',
                                              labelText: 'Collection Amt',
                                              /*  prefixIcon: const Icon(
                                                Icons.monetization_on,
                                                color: Colors.green,
                                              ),*/
                                              suffixIcon: IconButton(
                                                  icon: Icon(Icons.clear),
                                                   onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                                    setState(() {
                                                      items[index].mcollAmt=null;
                                                    });
                                                  }),

                                              prefixText: '',
                                              suffixText: '',
                                              suffixStyle: const TextStyle(
                                                  color: Colors.green)),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          new ButtonTheme.bar(
                            padding: new EdgeInsets.all(2.0),
                            child: new ButtonBar(
                              children: <Widget>[],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void showInSnackBar(String message) {
    _scaffoldHomeState.currentState
        .showSnackBar(SnackBar(content: Text(message)));
    //globals._mockService();
  }

  void _cardsCountForward() {
    if (!dontIncForwrd) {
      forwardClicks += 1;
      cardsCount += paginationCount;
    }

    if (forwardClicks == pageCount) {
      items.clear();
      items.addAll(
          storedItems.getRange(cardsCount, cardsCount + lastPagelistCount));
      if (items.length == 0) {
        items.clear();
        items.addAll(
            storedItems.getRange(cardsCount, cardsCount + paginationCount));
      }
    } else {
      storedItems.setAll(cardsCount - paginationCount, items);
      items.clear();
      items.addAll(
          storedItems.getRange(cardsCount, cardsCount + paginationCount));
    }
    setState(() {});
  }

  void _cardsCountReverse() {
    dontIncForwrd = false;

    if (cardsCount != 0) {
          forwardClicks -= 1;
      cardsCount -= paginationCount;
      if (!(forwardClicks == pageCount)) {
        storedItems.setAll(cardsCount + paginationCount, items);
      }
      items.clear();
      items.addAll(
          storedItems.getRange(cardsCount, cardsCount + paginationCount));
    } else {}

    setState(() {});
  }

  Future<void> _LastClick() async {
    dontIncForwrd = true;

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.clear,
              color: Colors.red,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('No Further Records Found'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  //Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  success(String message, BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(message)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(true);
                  /* Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new DailyCollectionSearchScreen()), //When Authorized Navigate to the next screen
                  );*/
                },
              ),
            ],
          );
        });
  }



  Future<bool> onPop(BuildContext context, String agrs1, String args2,
      Widget columnWidget) {
    TextEditingController(text: "5");
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(agrs1),
        content: SingleChildScrollView(
            //       child: Container(
            // height: 100.0 + count * 40.0,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[new Text(args2 + " :")],
                ),
                columnWidget
              ],
            ),
          //),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () async{
              List<CustomerListWithAmt> cusList =
                  new List<CustomerListWithAmt>();
              CustomerListWithAmt cusObj = new CustomerListWithAmt();
              int maxtref = 0 ;
              
               maxtref = await AppDatabase.get().getMaxTrefNoCollection();
              if(maxtref!=0&&maxtref!=null){
                  double totalAmountCollected = 0.0;
              if (forwardClicks == pageCount &&
                  paginationCount > 1 &&
                  storedItems.length > paginationCount) {
                storedItems.setAll(cardsCount, items);
              }
              if (!(paginationCount > 1 &&
                  storedItems.length > paginationCount)) {
                storedItems.clear();
                storedItems.addAll(items);
              }
              String batchCd = DateTime.now().year.toString()+DateTime.now().
              month.toString()+DateTime.now().day.toString()+DateTime.now().
              minute.toString()+DateTime.now().second.toString()+DateTime.now().millisecond.toString();

              for (int saveData = 0;
              saveData < storedItems.length;
              saveData++) {
                if (storedItems[saveData].isSubmit == 1) {

                  print("tref no hai  ${maxtref+saveData}");
                  totalAmountCollected+=storedItems[saveData].mcollAmt;
                  savedItemsLen++;
                  storedItems[saveData].trefno = maxtref+saveData;
                  storedItems[saveData].mrefno = 0;
                  storedItems[saveData].mfocode.trim();
                  storedItems[saveData].mcreateddt = DateTime.now();
                  storedItems[saveData].mlastupdatedt = DateTime.now();
                  storedItems[saveData].mcreatedby =   storedItems[saveData].mfocode.trim();
                  storedItems[saveData].mlastupdateby =  storedItems[saveData].mfocode.trim();
                  storedItems[saveData].malmeffdate =
                      storedItems[saveData].malmeffdate;
                  storedItems[saveData].masondate =
                      storedItems[saveData].masondate;
                  storedItems[saveData].midealbaldate =
                      storedItems[saveData].midealbaldate;
                  storedItems[saveData].mbatchcd = batchCd;
                  storedItems[saveData].missynctocoresys = 0;


                  try{
                         storedItems[saveData].loanoutbal =  storedItems[saveData].mprnos
                         +storedItems[saveData].mintos+storedItems[saveData].mpenalos-storedItems[saveData].mexcesspaid;
                        storedItems[saveData].mintos = storedItems[saveData].mintos;

                  }catch(_){

                  }
                 print("Loan Out bal hai ${storedItems[saveData].loanoutbal}");
                    cusObj = new CustomerListWithAmt();
                    cusObj.mcustno = storedItems[saveData].mcustno;
                    cusObj.mAmount = storedItems[saveData].mcollAmt;
                    cusObj.customerName = storedItems[saveData].mlongname;
                    cusList.add(cusObj);

                  AppDatabase.get()
                      .createCollectedAmtInsert(storedItems[saveData]);
                }
              }
              success(
                  'Collection is Submitted sucessfully '
                      '${savedItemsLen.toString()} Collection items have submitted sucesfully with total ${totalAmountCollected} ',
                  context);
              }

              if (TRNSMSG == 1) {
                try{
                  for (CustomerListWithAmt custListBj in cusList) {
                    AppDatabaseExtended.get()
                        .getCustomerFromNumbers(custListBj.mcustno)
                        .then((String MobNo) {
                      if (MobNo != null &&
                          MobNo.trim() != 'null' &&
                          MobNo.trim() != '') {
                        if (MobNo.length > 10) {
                          if (MobNo.length == 12) {
                            MobNo = MobNo.substring(2);
                          } else if (MobNo.length == 11) {
                            MobNo = MobNo.substring(1);
                          }
                        }
                        MobNo = MobNo.trim();
                        String str =
                            "Transaction For customer Number ${custListBj.mcustno}  for Amount Rs.${custListBj.mAmount} is initiated . Thank You For Choosing Saija !!";

                        str = "Dear ${custListBj.customerName},"
                            " EMI payment of Rs. ${custListBj.mAmount}/- for your Saija Loan has been successfully received "
                            "Thank you. ";
                        NetworkUtil.postSaijaMessage(str, MobNo);
                      }
                    });
                  }
                }catch(_){

                }

              }
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> _CheckUnsyncedAmTBalance(String mprdacctid) async {
    double unsyncedAmt = 0.0;
    await AppDatabase.get()
        .getUnsyncedDailyCollectedLaonAmt(mprdacctid)
        .then((onValue) {
      unsyncedAmt = onValue;
    });

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.account_balance,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text("  Unsynced Amout  :" + unsyncedAmt.toString()),
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
                },
              ),
            ],
          );
        });
  }

   Future<void> setTempListToDisplaySummary() async{
     tempSummaryBean=  new List<CollectionMasterBean>();
    tempSummaryBean.addAll(storedItems);
    print("tempSummaryBean ${tempSummaryBean}");
    if (forwardClicks == pageCount &&
        paginationCount > 1 &&
        tempSummaryBean.length > paginationCount) {
      tempSummaryBean.setAll(cardsCount, items);
    }
    if (!(paginationCount > 1 &&
        tempSummaryBean.length > paginationCount)) {
      tempSummaryBean.clear();
      tempSummaryBean.addAll(items);
    }

      


  }










    Future<bool> alreadyCollectedAlert(BuildContext context, String agrs1, String args2,
      Widget columnWidget) {
    TextEditingController(text: "5");
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Already Collected Alert"),
        content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('One or more Already collected Are you sure you want to continue  '),
              ],
            ),
          ),
        
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () async{
              Navigator.of(context).pop();
              onPop( context,
                        'Are you sure?',
                        'Do you want Submit Collection List ',columnWidget);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    );
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
                Text('$error.'),
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
      },
    );
  }
}

class CustomerListWithAmt {
  int mcustno;
  double mAmount;
  String customerName;
  String agentName;

  CustomerListWithAmt({this.mcustno, this.mAmount, customerName, agentName});
}
