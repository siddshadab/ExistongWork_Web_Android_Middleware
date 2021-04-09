import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/UserActivity/UserActivityBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/Beans/TermDepositClosureBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TermDpositClosureServices.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/BiometricCheck.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:toast/toast.dart';

class TDClosureDetail extends StatefulWidget {
  final TermDepositClosureBean tdClosureBeanpassedObject;

  TDClosureDetail(
      {Key key, @required this.tdClosureBeanpassedObject})
      : super(key: key);

  _TDClosureDetail createState() => _TDClosureDetail();
}

class _TDClosureDetail extends State<TDClosureDetail> {

  TermDepositClosureBean tdClosureBean;
  var formatter = new DateFormat('yyyy-MM-dd');
  int isBiometricNeeded =0;
  List  cardList = new List<Widget>();
  int selectedValue = 0;
  double mainBal = 0;
  UserActivityBean usrActBean = new UserActivityBean();
  @override
  void initState() {
    super.initState();
    if(widget.tdClosureBeanpassedObject!=null){


      tdClosureBean = widget.tdClosureBeanpassedObject;
      mainBal = tdClosureBean.mclosmatamt - tdClosureBean.mclosintamt;

    if(tdClosureBean.attachedSavAccts!=null)
      buildcardList();
      getSessionVariables();
    }
  }



  void getSessionVariables() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);
    AppDatabase.get().generateTrefnoUserActivityMaster().then((onValue) {
      setState(() {
        usrActBean.trefno = onValue;
      });
    });

    setState(() {});
  }





  buildcardList(){

    cardList.clear();
    for(int i = 0 ;i<tdClosureBean.attachedSavAccts.length;i++){

      cardList.add(
        new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (){
            print("pressed");
            selectedValue = i;
            print(selectedValue);
            buildcardList();
            setState(() {

            });

          },

          child: new Card(
            child: new ListTile(
              title: new Row(
                children: <Widget>[
                  new Text("Account Number : ${tdClosureBean.attachedSavAccts[i].macctno}" )
                ],

              ),
              subtitle: new Row(
                children: <Widget>[
                  new Text("Account Holder name ${tdClosureBean.attachedSavAccts[i].mlongname}",style: TextStyle(fontSize: 10.0),)
                ],

              ),

              trailing: new Radio(value: i, groupValue: selectedValue, onChanged: (val){
                selectedValue = i;
                print(selectedValue);
                buildcardList();
                setState(() {

                });
              }),
            ),



          ),
        )



      );



    }




  }

  var _radioValue1 = 1;
  bool _isTextFieldAccHolderNameVisible = true;
  bool _isTextFieldAccNumberVisible = true;
  bool _isTextFieldIfscVisible = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new WillPopScope(
        onWillPop: () {
      callDialog();
    },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Term Deposit Closure Detail",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
              Navigator.of(context).pop();
              globals.fingerPrintAuthForTDDone = false;
            },
          ),

          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: new IconButton(
                icon: new Icon(
                  Icons.launch,
                  color:Colors.white,
                  size: 40.0,
                ),
                onPressed: () async {
                  /* CustomerFormationDeclarationFormState obj = new CustomerFormationDeclarationFormState();
                  obj.submit();*/

                  if(isBiometricNeeded==1){
                    if(globals.fingerPrintAuthForTDDone==true){
                      _ShowProgressInd(context);
                      _postTermDepostClosureReuest();

                    }
                    else{

                      _postTermDepostClosureReuest();

                      Toast.show("Please Validate Finger Print ", context);
                    }
                  }
                  else{
                    _postTermDepostClosureReuest();
                  }


                },
              ),
            ),
          ],
        ),
        body: Card(
          elevation: 4.0,
          // color: Constant.mandatoryColor,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(20.0),
            children: <Widget>[

              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Text("Opertional Date : ",style: TextStyle(fontSize: 12.0),),
                  new Text(formatter.format(tdClosureBean.mbranchoperdt),style: TextStyle(fontSize: 12.0),)

                ],


          ),

              SizedBox(height: 20.0,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("Account Number : ",style: TextStyle(fontWeight: FontWeight.bold),),
                      new Text("Name : ",style: TextStyle(fontWeight: FontWeight.bold),),
                      new Text("Main Bal: ",style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),

                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(tdClosureBean.mprdacctid),
                      new Text(tdClosureBean.mlongname),
                      new Text("${tdClosureBean.mclosmatamt- tdClosureBean.mclosintamt}")
                    ],
                  )



                ],
              )

              /* ,new Row(
              children: <Widget>[
                new Text("Account Number : ",style: TextStyle(fontWeight: FontWeight.bold),),
                new Text(tdClosureBean.mprdacctid)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 0.0, bottom: 15.0, right: 0.0),
              child: new Text("Name : Alex bay"),
            ),*/
              ,Row(// for vertical representation starts here
                  children: <Widget>[
                    Expanded(
                        child: Card(
                          elevation: 4.0,
                          // color: Constant.mandatoryColor,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, top: 10.0, bottom: 2.0, right: 0.0),
                                child: new Text(
                                  Translations.of(context).text('TD_Details'),
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic, fontSize: 17.0),
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              new Text(
                                Translations.of(context).text("Maturity_Interest_Amount"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text(tdClosureBean.mmatintamt.toString()),
                              new Text(
                                Translations.of(context).text("Maturity_Date"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text(formatter.format(tdClosureBean.mmatdt)),
                              new Text(
                                Translations.of(context).text("Maturity_Amount"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text(tdClosureBean.mmatamt.toString()),
                              new Text(
                                Translations.of(context).text("Rate_of_Interest"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text("${tdClosureBean.mintrate}%"),
                              new Text(
                                Translations.of(context).text("TDS"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text("${tdClosureBean.mtds}"),
                              new Text(
                                Translations.of(context).text("tdclosureamount"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text("${(mainBal+tdClosureBean.mmatintamt)-tdClosureBean.mtds }"),
                            ],
                          ),
                        )),
                    // VerticalDivider(),

                    Expanded(
                      child: Card(
                        elevation: 4.0,
                        // color: Constant.mandatoryColor,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0.0, top: 10.0, bottom: 2.0, right: 0.0),
                              child: new Text(
                                Translations.of(context).text("Pre_Closure_Detail"),
                                style: TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 17.0),
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            new Text(
                              Translations.of(context).text("Calculated_Int_Amount"),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            new Text("${tdClosureBean.mclosintamt}"),
                            new Text(
                              Translations.of(context).text("Closure_Date"),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            new Text("${formatter.format(tdClosureBean.mclosdt)}"),
                            new Text(
                              Translations.of(context).text("Maturity_Amount"),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            new Text("${tdClosureBean.mclosmatamt}"),
                            new Text(
                              Translations.of(context).text("Rate_of_Interest"),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            new Text("${tdClosureBean.mclosintrate}"),
                            new Text(
                              Translations.of(context).text("TDS"),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            new Text("${tdClosureBean.mclostds}"),
                            new Text(
                                Translations.of(context).text("tdclosureamount"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new Text("${(mainBal+tdClosureBean.mclosintamt)-tdClosureBean.mclostds }"),
                          ],
                        ),
                      ),
                    ),
                  ]),

              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, bottom: 2.0, right: 0.0),
                child: new Text(
                  Translations.of(context).text("Payment_Detail"),
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  new Text(
                    'Cash',
                    // style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                    groupValue: _radioValue1,
                    onChanged: _handleRadioValueChange1,
                  ),
                  new Text(
                    'Saving Account',
                    style: new TextStyle(
                      // fontSize: 16.0,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 5.0,
              ),
              cardList != null &&
                      cardList.isNotEmpty &&
                      _isTextFieldAccHolderNameVisible
                  ? new Column(children: cardList)
                  : new SizedBox(),
              isBiometricNeeded == 0
                  ? new Container()
                  : new FingerScannerImageAsset(
                      mIsCustomerSelected: "Y",
                      mrefno: 0,
                      trefno: 0,
                      isOnline: true,
                      custno: 86),
            ],
          ),
        ),
      ),
    );



  }


  Future<bool> callDialog() {
    globals.fingerPrintAuthForTDDone = false;
    Navigator.of(context).pop();
  }


  void _handleRadioValueChange1(int value) {
    // this is for hiding and showing the view on the click of radio  button for payment detail
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          setState(() => _isTextFieldAccHolderNameVisible =
              !_isTextFieldAccHolderNameVisible);
          setState(() =>
              _isTextFieldAccNumberVisible = !_isTextFieldAccNumberVisible);
          setState(() => _isTextFieldIfscVisible = !_isTextFieldIfscVisible);
          break;
        case 1:
          setState(() => _isTextFieldAccHolderNameVisible =
              !_isTextFieldAccHolderNameVisible);
          setState(() =>
              _isTextFieldAccNumberVisible = !_isTextFieldAccNumberVisible);
          setState(() => _isTextFieldIfscVisible = !_isTextFieldIfscVisible);
          break;
      }
    });
  }

  Future<Null> _postTermDepostClosureReuest()async{

    TermDepositClosureServices tdBean= new TermDepositClosureServices();
    if(_isTextFieldAccHolderNameVisible)
    tdClosureBean.mcshorsav = 1;
    else
      tdClosureBean.mcshorsav = 0;

    await tdBean
        .postTermDepositClosure(tdClosureBean)
        .then((TermDepositClosureBean returnedtermDepostClosureBean) async {
      if (returnedtermDepostClosureBean == null) {
        Navigator.of(context).pop();
        _CheckIfThere("No Account Found");
      } else if (returnedtermDepostClosureBean.mstatus == 0) {
        Navigator.of(context).pop();

        _CheckIfThere(returnedtermDepostClosureBean.merrormessage);
      } else {
        Navigator.of(context).pop();
        try {
          await UpdateUserActivityMaster(returnedtermDepostClosureBean);
        } catch (_) {}
        _showAlert(returnedtermDepostClosureBean.merrormessage);

      }




    });


  }







  Future<void> _CheckIfThere(String msg) async {

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
                      new Text(msg),
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
                  //  Navigator.of(context).pop();
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
          content: SingleChildScrollView(
              child: SpinKitCircle(color: Colors.amber.shade500)
          ),
        );
      },
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
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                globals.fingerPrintAuthForTDDone = false;
              },
            ),
          ],
        );
      },
    );
  }

  UpdateUserActivityMaster(TermDepositClosureBean returnedTdClosureBean) async {
    print("UpdateUserActivityMaster");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lbrCd = prefs.getInt(TablesColumnFile.musrbrcode);

    String operationDate =
        prefs.getString(TablesColumnFile.branchOperationalDate);
    String userCode = prefs.getString(TablesColumnFile.usrCode);

    String geoLocation = prefs.getString(TablesColumnFile.geoLocation);
    String geoLatitude = "";
    String geoLongitude = '';
    try {
      geoLatitude = prefs.getDouble(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.getDouble(TablesColumnFile.geoLongitude).toString();
    } catch (_) {}

    usrActBean.mcreateddt = DateTime.now();
    usrActBean.musercode = userCode;
    usrActBean.mlbrcode = lbrCd;
    usrActBean.mcustno =
        int.parse(widget.tdClosureBeanpassedObject.mprdacctid.substring(8, 24));
    //usrActBean.mcenterid =
    // usrActBean.mgroupcd =
    usrActBean.mtxnamount = returnedTdClosureBean.mmatamt;
    usrActBean.msystemnarration = "TD Closure";
    usrActBean.musernarration = "TC Closure";

    usrActBean.mactivity = TablesColumnFile.TDCLOSURE;
    usrActBean.screenname = "TD Closure";

    usrActBean.mmoduletype = 20;
    usrActBean.mtxnrefno = "N.A.";
    if (operationDate != null) {
      try {
        usrActBean.mentrydate = DateTime.parse(operationDate);
      } catch (_) {}

      usrActBean.mcorerefno = lbrCd.toString() +
          "/" +
          operationDate +
          "/" +
          returnedTdClosureBean.mbatchcd +
          "/" +
          returnedTdClosureBean.msetno.toString();
    } else {
      usrActBean.mentrydate = DateTime.now();
      usrActBean.mcorerefno = lbrCd.toString() +
          "/ /" +
          returnedTdClosureBean.mbatchcd +
          "/" +
          returnedTdClosureBean.msetno.toString();
    }

    usrActBean.status = "Success";
    usrActBean.mcreateddt = DateTime.now();
    usrActBean.mcreatedby = userCode;
    usrActBean.mlastupdatedt = DateTime.now();
    usrActBean.mlastupdateby = null;
    usrActBean.mgeolocation = geoLocation;
    usrActBean.mgeolatd = geoLatitude;
    usrActBean.mgeologd = geoLongitude;
    usrActBean.missynctocoresys = 0;
    usrActBean.mlastsynsdate = null;
    usrActBean.mrefno = 0;

    await AppDatabase.get().updateUserActivityMaster(usrActBean).then((val) {
      //print("val here is " + val.toString());
    });
    String diffInBal;
    diffInBal = "- ${tdClosureBean.mmatamt}";

    await AppDatabase.get()
        .updateUserVaultBalance(lbrCd, userCode, " ", diffInBal);
  }
}
