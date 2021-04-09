import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterBean.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/BiometricCheck.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/UserActivity/UserActivityBean.dart';
import 'package:eco_mfi/pages/workflow/disbursment/bean/DisbursmentBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/CIFDisbursmentSyncing.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class CIFDisbursment extends StatefulWidget {
  final DisbursmentBean disbBeanPassedObject;

  CIFDisbursment({Key key, @required this.disbBeanPassedObject})
      : super(key: key);

  @override
  _CIFDisbursmentState createState() => new _CIFDisbursmentState();
}

class _CIFDisbursmentState extends State<CIFDisbursment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int isBiometricNeeded = 1;
  SharedPreferences prefs;
  int printingCode = 0;
  String companyName = "";
  int isWasasa = 0;
  List<int> rsfLbrCodes = new List<int>();
  int lbrCode = 0;
  String username;
  List chargsList = new List();
  int mcustNoInt = 0;
  int mprcdAcctIdInt = 0;
  String mprdcd = "";
  String custNo = "";
  List<Widget> dynamicCharges = new List<Widget>();
  Utility obj = new Utility();
  final _headers = {'Content-Type': 'application/json'};
  String disbCreateUrl = "CIF/postDisbursmentCreate/";
  String disbAuthUrl = "CIF/postDisbursmentAuth/";
  double amountToBeCollected = 0.0;
  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');
  final dateFormat = DateFormat("yyyy/MM/dd hh:mm:ss");
  bool activeDisburseButton = true;
  JsonCodec JSON = const JsonCodec();
  UserActivityBean usrActBean = new UserActivityBean();
  String geoLocation;
  String geoLatitude;
  String geoLongitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try{
     mcustNoInt = int.parse(widget.disbBeanPassedObject.mprdacctid.substring(8,16));
     mprdcd = widget.disbBeanPassedObject.mprdacctid.substring(0,8).trim();
     mprcdAcctIdInt= int.parse(widget.disbBeanPassedObject.mprdacctid.substring(16,24));


    }catch(_){
        print("Exception in parsing");

    }
    if(widget.disbBeanPassedObject.mchargesamt==null){

      widget.disbBeanPassedObject.mchargesamt = 0.0;
    }

    if(widget.disbBeanPassedObject.mamttodisb==null){
      widget.disbBeanPassedObject.mamttodisb=0.0;
    }
    getSessionVariables();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    lbrCode = prefs.getInt(TablesColumnFile.musrbrcode);
    username = prefs.getString(TablesColumnFile.musrcode);
    isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);
	  printingCode = prefs.getInt(TablesColumnFile.PrintingCode);
    geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
    geoLatitude = prefs.get(TablesColumnFile.mgeolatd).toString();
    geoLongitude = prefs.get(TablesColumnFile.mgeologd).toString();

    setState(() {
      isWasasa = prefs.getInt(TablesColumnFile.isWASASA);
      print("IsWasasa = ${isWasasa}");
    });
    if (printingCode == 0) {
      companyName = TablesColumnFile.wasasa;
    } else if (printingCode == 1) {
      companyName = TablesColumnFile.fullerton;
    }

    AppDatabase.get().generateTrefnoUserActivityMaster().then((onValue) {
      setState(() {
        usrActBean.trefno = onValue;
      });
    });

    try {
      for (String items
          in prefs.getString(TablesColumnFile.rsfLbrCodes).split("~")) {
        rsfLbrCodes.add(int.parse(items));
      }
    } catch (_) {}

    try {
      for (String items
          in prefs.getString(TablesColumnFile.chargesCodes).split("~")) {
        chargsList.add(items);
      }
    } catch (_) {}
    

    if (chargsList.isNotEmpty) {
      for (int chargesNo = 0; chargesNo < chargsList.length; chargesNo++) {
        for (int i = 0;
            i < globals.dropdownCaptionsValuesDisbursment[0].length;
            i++) {
          try {
            if (globals.dropdownCaptionsValuesDisbursment[0][i].mcode
                    .toString() ==
                chargsList[chargesNo].trim()) {
              print("matched for ${chargsList[chargesNo]}");
              String chargeSTring =
                  globals.dropdownCaptionsValuesDisbursment[0][i].mcodedesc;
              double charge = 0.0;
              switch (chargesNo) {
                case 0:
                  charge = widget.disbBeanPassedObject.mchargesamt0;
                  break;
                case 1:
                  charge = widget.disbBeanPassedObject.mchargesamt1;
                  break;
                case 2:
                  charge = widget.disbBeanPassedObject.mchargesamt2;
                  break;
                case 3:
                  charge = widget.disbBeanPassedObject.mchargesamt3;
                  break;
                case 4:
                  charge = widget.disbBeanPassedObject.mchargesamt4;
                  break;
                case 5:
                  charge = widget.disbBeanPassedObject.mchargesamt5;
                  break;
                case 6:
                  charge = widget.disbBeanPassedObject.mchargesamt6;
                  break;
                case 7:
                  charge = widget.disbBeanPassedObject.mchargesamt7;
                  break;
                case 8:
                  charge = widget.disbBeanPassedObject.mchargesamt8;
                  break;
                case 9:
                  charge = widget.disbBeanPassedObject.mchargesamt9;
                  break;
                default:
                  charge = 0.0;
                  break;
              }
              if (charge > 0) {
                dynamicCharges.add(
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(chargeSTring)
                          //Translations.of(context).text('disb_Amt')),
                          ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                          "${charge}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );

                widget.disbBeanPassedObject.mchargesamt+=charge;
              }
            }


           widget.disbBeanPassedObject.mamttodisb = widget.disbBeanPassedObject.mdisbamount ;

            if( widget.disbBeanPassedObject.msdcollectiontype==0){

              widget.disbBeanPassedObject.mamttodisb -=widget.disbBeanPassedObject.msdamt;
            }
            if(widget.disbBeanPassedObject.mchargescollectiontype==0){
              widget.disbBeanPassedObject.mamttodisb -=widget.disbBeanPassedObject.mchargesamt;
            }


            widget.disbBeanPassedObject.mamttodisb-=widget.disbBeanPassedObject.mthirdpartyamount;












          } catch (_) {
            print("Exception in dropdown");
          }
        }
      }
    }

    if (isWasasa == 1 && (rsfLbrCodes == null || rsfLbrCodes.isEmpty)) {
      //todo Show popup to sync System Paramter
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
        },
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(
            elevation: 1.0,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                 Navigator.of(context).pop();
              },
            ),
            backgroundColor: Color(0xff01579b),
            brightness: Brightness.light,
            title: new Text(
              Translations.of(context).text('Disbursment'),
              //textDirection: TextDirection,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.normal),
            ),
          ),
          body: Column(
            children: <Widget>[
              /*new Card(
                //color Color(0xff2f1f4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 25.0,
                child:*/
              new Padding(
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
                              colors: [Colors.cyan, Colors.indigo],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        //color: color,
                        child: Column(
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Text(
                                  widget.disbBeanPassedObject.mlongname.trim(),
                                  overflow: TextOverflow.fade,
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      fontStyle: FontStyle.normal,
                                      // color: Colors.grey[700]
                                      color: Colors.white),
                                ),
                                // new IconButton(
                                //     icon:
                                //         Icon(Icons.print, color: Colors.green),
                                //      onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                                //       /*if (isSaved == true &&
                                //           widget.disbBeanPassedObject.mdisbstatus == 1)
                                //         _callChannelDisbursmentIndvPrint(
                                //             widget.disbBeanPassedObject);*/

                                //       //_callChannelDisbursmentIndvPrint(widget.disbBeanPassedObject);
                                //     }),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  Translations.of(context).text('CNO') +
                                      " ${widget.disbBeanPassedObject.mcenterid}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  Translations.of(context).text('GNO') +
                                      " ${widget.disbBeanPassedObject.mgroupcd}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
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
                              SizedBox(),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('mSancAmt')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "${widget.disbBeanPassedObject.mdisbamount}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('mleadsid')),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "${widget.disbBeanPassedObject.mleadsid.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          new Column(
                            children: dynamicCharges,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('chargesamt'),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text("${widget.disbBeanPassedObject.mchargesamt}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                    Translations.of(context).text('sdamt'),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  "${widget.disbBeanPassedObject.msdamt.toString()}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
                                  "${widget.disbBeanPassedObject.mamttodisb}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          new Row(
                            children: <Widget>[
                              Center(
                                child: Container(
                                    width: 400.0,
                                    child: new TextField(
                                      controller: widget.disbBeanPassedObject
                                                      .mremarks ==
                                                  null ||
                                              widget.disbBeanPassedObject
                                                      .mremarks
                                                      .trim() ==
                                                  'null'
                                          ? new TextEditingController(text: "")
                                          : new TextEditingController(
                                              text:
                                                  "${widget.disbBeanPassedObject.mremarks}"),
                                      keyboardType: TextInputType.multiline,
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
                                      onChanged: (String val) {
                                        widget.disbBeanPassedObject.mremarks =
                                            val;
                                      },
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Center(
                            child: isBiometricNeeded == 0
                                ? new Container()
                                : new Text(
                                    "Biometric Check",
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          Container(
                            child: isBiometricNeeded == 0
                                ? SizedBox(height: 1.0)
                                : new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Center(
                                          child: widget.disbBeanPassedObject
                                                      .isFingPrintDone ==
                                                  true
                                              ? new Icon(
                                                  Icons.offline_pin,
                                                  color: Colors.green,
                                                  size: 60.0,
                                                )
                                              : new FingerScannerImageAsset(
                                                  mIsCustomerSelected: "Y",
                                                  isOnline: true,
                                                  custno: widget
                                                      .disbBeanPassedObject
                                                      .mcustno,
                                                  routeType:
                                                      "Online Disbursment",
                                                  checkResult: (bool val) {
                                                    updateBiometric(val);
                                                  },
                                                )),
                                    ],
                                  ),
                          ),
                          widget.disbBeanPassedObject.isFingPrintDone == true
                              ? SizedBox(height: 1.0)
                              : isBiometricNeeded == 0
                                  ? SizedBox(height: 1.0)
                                  : new CheckboxListTile(
                                      value: widget.disbBeanPassedObject
                                                      .mcheckbiometric ==
                                                  null ||
                                              widget.disbBeanPassedObject
                                                      .mcheckbiometric ==
                                                  0
                                          ? false
                                          : true,
                                      title: new Text(
                                          "I declare that i want to override the biometric result."),
                                      onChanged: (val) {
                                        setState(() {
                                          if (val == true) {
                                            widget.disbBeanPassedObject
                                                .mcheckbiometric = 1;
                                          } else {
                                            widget.disbBeanPassedObject
                                                .mcheckbiometric = 0;
                                          }
                                          print("${widget.disbBeanPassedObject
                                                .mcheckbiometric}");
                                        });
                                      }),
                          SizedBox(
                            height: 10.0,
                          ),
                          // new CheckboxListTile(
                          //     value:
                          //         widget.disbBeanPassedObject.misauthorized ==
                          //                     null ||
                          //                 widget.disbBeanPassedObject
                          //                         .misauthorized ==
                          //                     0
                          //             ? false
                          //             : true,
                          //     title: new Text(
                          //         Translations.of(context).text('authorize')),
                          //     onChanged: (val) {
                          //       print(val);
                          //       setState(() {
                          //         if (val == true) {
                          //           widget.disbBeanPassedObject.misdisbursed =
                          //               1;
                          //         } else if (val == false) {
                          //           widget.disbBeanPassedObject.misdisbursed =
                          //               0;
                          //         } else {
                          //           Toast.show("Read Mode Only", context);
                          //         }
                          //       });
                          //     }),
                          /*: new CheckboxListTile(
                    value: widget.disbBeanPassedObject.misdisbursed == null ||
                        widget.disbBeanPassedObject.misdisbursed == 0
                        ? false
                        : true,
                    title: new Text(Translations.of(context)
                        .text('Disbursed')),
                    onChanged: (val) {
                      setState(() {
                        if (widget.disbBeanPassedObject.isFingPrintDone ==
                            true ||
                            widget.disbBeanPassedObject.mcheckbiometric ==
                                1) {
                          if (val == true && isSaved == false) {
                            widget.disbBeanPassedObject.misdisbursed = 1;
                          } else if (val == false &&
                              isSaved == false) {
                            widget.disbBeanPassedObject.misdisbursed = 0;
                          } else {
                            Toast.show(
                                Translations.of(context)
                                    .text('ReadMode'),
                                context);
                          }
                        } else {
                          Toast.show(
                              Translations.of(context)
                                  .text('validateFingerPrint'),
                              context);
                        }
                      });
                    })*/
                          
                          Center(
                            child: FloatingActionButton.extended(
                                icon: Icon(Icons.assignment_turned_in),
                                backgroundColor:(isBiometricNeeded==1&&(widget.disbBeanPassedObject.isFingPrintDone==false||
                                widget.disbBeanPassedObject.isFingPrintDone==null)&&(
                                    widget.disbBeanPassedObject.mcheckbiometric==0||
                                    widget.disbBeanPassedObject.mcheckbiometric==null

                                )
                                && widget.disbBeanPassedObject.mdisbursedamtflag==1
                                )?
                                Colors.grey:Color(0xff07426A),
                                label: widget.disbBeanPassedObject
                                            .mdisbursedamtflag ==
                                        1
                                    ? new Text(
                                        Translations.of(context).text('disburse'))
                                    : new Text(Translations.of(context)
                                        .text('authorize')),
                                onPressed: () async {
                                  if (isBiometricNeeded == 1 &&
                                      (widget.disbBeanPassedObject.isFingPrintDone ==true ||
                                          widget.disbBeanPassedObject.mcheckbiometric ==1)) {
                                      
                                    onPop(
                                        context,
                                        Translations.of(context)
                                            .text('Are_You_Sure'),
                                        Translations.of(context)
                                            .text('Do_You_Want_To_Proceed'),
                                        Translations.of(context)
                                            .text('CollectionSubmit'));
                                  } else if (isBiometricNeeded != 1) {
                                    onPop(
                                        context,
                                        Translations.of(context)
                                            .text('Are_You_Sure'),
                                        Translations.of(context)
                                            .text('Do_You_Want_To_Proceed'),
                                        Translations.of(context)
                                            .text('CollectionSubmit'));
                                  } else {
                                    Toast.show(
                                        "Please do the BIOMETRIC OR ACCEPT the declaration to ENABLE the SAVE BUTTON!",
                                        context);
                                  }
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ],
          ),
        ));
  }

  updateBiometric(bool updateRes) {
    widget.disbBeanPassedObject.isFingPrintDone = updateRes;
    setState(() {});
  }

  Future<bool> onPop(
      BuildContext context, String agrs1, String args2, String pageRoutedFrom) {
    return showDialog(
      barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text(agrs1),
                content: new Text(args2),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                child: new Text('No',style: TextStyle(color: Colors.black),),
              ),
              new FlatButton(
                onPressed: () async {
                  if(activeDisburseButton==false){
                    Toast.show(
                        Translations.of(context)
                            .text('Request already in Process'),
                        context);
                    return;
                  }
                  setState(() {
                    activeDisburseButton=false;
                  });
                      bool netAvail = false;
                      netAvail = await obj.checkIfIsconnectedToNetwork();
                      if (netAvail == false) {
                        Navigator.of(context).pop();
                        showMessageWithoutProgress("Network Not available");
                        return;
                      } else {
                        _ShowProgressInd(context);
                        DisbursmentBean returnedBean ;
                        CIFDisbursmentSyncing cifSyncingObj =
                            new CIFDisbursmentSyncing();
                        if (widget.disbBeanPassedObject.mdisbursedamtflag ==
                            1) {
                          returnedBean = await cifSyncingObj.postDisbursmentCreate(
                              widget.disbBeanPassedObject);
                      setState(() {

                        activeDisburseButton = true;
                      });
                              Navigator.of(context).pop();
                              if(returnedBean!=null&&returnedBean.missynctocoresys==1){
                                try{
                                  UpdateUserActivityMaster(returnedBean);
                                } catch (e) {}
                                _successfulSubmit("");

                              }else if(returnedBean!=null&&returnedBean.missynctocoresys==2){
                                Navigator.of(context).pop();
                                 _CheckIfThere(returnedBean.merrormessage);

                              }
                              else{
                                Navigator.of(context).pop();
                                _CheckIfThere("Something went wrong");
                              }
                        } else {
                         returnedBean  = await cifSyncingObj
                              .postDisbursmentAuth(widget.disbBeanPassedObject);
                      setState(() {

                        activeDisburseButton = true;
                      });
                              Navigator.of(context).pop();
                               if(returnedBean!=null&&returnedBean.missynctocoresys==1){
                                 try{
                                   UpdateUserActivityMaster(returnedBean);
                                 } catch (e) {}
                                  _successfulSubmit("");
                                  

                              }else if(returnedBean!=null&&returnedBean.missynctocoresys==2){
                                Navigator.of(context).pop();
                                  _CheckIfThere(returnedBean.merrormessage);
                              }
                              else{
                                Navigator.of(context).pop();
                                _CheckIfThere("Something went wrong");
                              }

                        }

                          


                      }
                    },
                child: new Text('Yes',style: TextStyle(color: activeDisburseButton==true?Colors.black:Colors.grey),),
                  ),
                ],
              ),
        ) ??
        false;
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

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }


  Future<void> _successfulSubmit(omnitxnrefno) async {
    return showDialog<void>(
      barrierDismissible: false,
        context: context,
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
                      'Disbursed SccessFully' +
                          omnitxnrefno),
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
                },
              ),
              FlatButton(
                child: Text('Print'),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  _callChannelDisbursmentIndvPrint(widget.disbBeanPassedObject);
                },
              ),
            ],
          );
        });
  }



  Future<void> _CheckIfThere(error) async {
    return showDialog<void>(
      barrierDismissible: false,
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
                  Text(error),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
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

  _callChannelDisbursmentIndvPrint(DisbursmentBean disbursmentBean) async {
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
    print("Company Name aay $companyName");

    String productCode = "";
    try {
      productCode = disbursmentBean.mprdacctid.substring(0, 8);
    } catch (_) {}
    print("productCode = ${productCode}");
    print("Product acctId  = ${disbursmentBean.mprdacctid}");

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
    print("Contact No : ${contactNo}");
    try {
      insuranceCharges = disbursmentBean.mchargesamt2.toString();
      documentationfees = disbursmentBean.mchargesamt0.toString();
      if( disbursmentBean.mdisburseddate!="null"&& disbursmentBean.mdisburseddate!=null&& disbursmentBean.mdisburseddate!=""){
        disbursedDate =dateFormat.format(disbursmentBean.mdisburseddate);}
      if( disbursmentBean.mcustno!="null"&& disbursmentBean.mcustno!=null&& disbursmentBean.mcustno!=""){
        mcustno = disbursmentBean.mcustno.toString();}
      if( disbursmentBean.mamttodisb!="null"&& disbursmentBean.mamttodisb!=null&& disbursmentBean.mamttodisb!=""){
      disbAmount = disbursmentBean.mamttodisb;}
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
              branchMasterBean.mlastopendate != null)
            branchName = branchMasterBean.mname;
          print("branch " + branch.toString());
          print("branchName " + branchName.toString());
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

    print("bluetoothAddress $bluetootthAdd");


    if (disbursmentBean != null && disbursmentBean != "") {
      String repeatedStringEntryDate = "";
      print("repeatedStringEntryDate" + repeatedStringEntryDate);
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
            "companyName": companyName //companyName
          });
          String geTest = 'geTest at $result';
          print("FLutter : " + geTest.toString());
        } else if (companyName == TablesColumnFile.wasasa) {
          final String result =
          await platform.invokeMethod("disbursmentIndvPrint", {
            "BluetoothADD": bluetootthAdd,
            "mlbrcode": lbrcd,
            "date": disbursedDate,
            "branchName": branchName,
            "trefno": trefno,
            "batchno": batchno,
            "setno": setno,
            "loanRepaymentAccount": loanRepaymnetAcc,
            "disbursedAmount": disbAmount.toStringAsFixed(2),
            "contactNo": contactNo,
            "loanOfficer": username,
            "custName": disbursmentBean.mlongname!="null"&&disbursmentBean.mlongname!=null&&disbursmentBean.mlongname!="",
            "companyName": companyName //companyName
          });
        }
      } on PlatformException catch (e) {
        print("FLutter : " + e.message.toString());
      }
    }
  }

  UpdateUserActivityMaster(DisbursmentBean disbursmentBeanObj) async {
    print("UpdateUserActivityMaster");

    usrActBean.mcreateddt = DateTime.now();
    usrActBean.musercode  = username;
    usrActBean.mlbrcode  = lbrCode;
    usrActBean.mcustno = disbursmentBeanObj.mcustno;
    //usrActBean.mcenterid =
    // usrActBean.mgroupcd =
    usrActBean.mtxnamount = widget.disbBeanPassedObject.mamttodisb;
    usrActBean.msystemnarration = disbursmentBeanObj.mnarration;
    usrActBean.musernarration =  widget.disbBeanPassedObject.mremarks;
    usrActBean.mactivity = "DISBURSE";
    usrActBean.screenname = "Disbursement";
    usrActBean.mmoduletype = 30;
    //usrActBean.mtxnrefno = disbursmentBeanObj.momnitxnrefno;
    print("entry date is ${disbursmentBeanObj.mentrydate} " );
    usrActBean.mentrydate = disbursmentBeanObj.mentrydate;
    usrActBean.mcorerefno = lbrCode.toString() + "/" +disbursmentBeanObj.mentrydate.toString() + "/" + disbursmentBeanObj.mbatchcd + "/" + disbursmentBeanObj.msetno.toString();
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

    await AppDatabase.get()
        .updateUserActivityMaster(usrActBean)
        .then((val) {
      //print("val here is " + val.toString());
    });
    String diffInBal;

    diffInBal = "+${widget.disbBeanPassedObject.mamttodisb}";


    await AppDatabase.get().updateUserVaultBalance(lbrCode,username,disbursmentBeanObj.mcurcd,diffInBal);

  }


}
