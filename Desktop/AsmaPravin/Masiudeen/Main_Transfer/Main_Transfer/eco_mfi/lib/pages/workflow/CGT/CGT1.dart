import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/Kyc/beans/KycMasterBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/LoanLevelService.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CGT1 extends StatefulWidget {
  final laonLimitPassedObject;
  CGT1({Key key, this.laonLimitPassedObject}) : super(key: key);

  @override
  _CGT1 createState() => new _CGT1();
}

class _CGT1 extends State<CGT1> {
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String mreportinguser;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  int branch = 0;
  CGT1Bean cgt1bean = new CGT1Bean();
  DateTime startTime = DateTime.now();
  final dateFormat = DateFormat("yyyy, mm, dd");
  DateTime date;
  TimeOfDay time;
  final formKey = new GlobalKey<FormState>();
  bool isRouted = true;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  int isCGT2Needed = 0;
  int loanLevelManadt=0;
  int cgt1LeadNeeded = 0;
  //Position position;
  //var addresses;

  @override
  void initState() {
    super.initState();
    getSessionVariables();
    //String formattedDate =DateFormat("yyyy, mm, dd").format(startTime);
    //cgt1bean.startTime =  DateTime.parse(formattedDate);
    cgt1bean.mstarttime = DateTime.now();
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(()  {

      username = prefs.getString(TablesColumnFile.musrcode);
      mreportinguser = prefs.getString(TablesColumnFile.mreportinguser);
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgroupcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      try{
        geoLatitude = prefs.getDouble(TablesColumnFile.geoLatitude).toString();
        geoLongitude = prefs.getDouble(TablesColumnFile.geoLongitude).toString();
      }catch(_){
        print("Exception in getting loangitude");
      }
      isCGT2Needed = int.parse(prefs.get(TablesColumnFile.isCGT2Needed));
      cgt1LeadNeeded = prefs.getInt(TablesColumnFile.CGT1LEADNEEDED);
      try{
        branch = prefs.getInt(TablesColumnFile.musrbrcode);
      }catch(_){

      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            Translations.of(context).text('CGT1_Check')
            ,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () async {


                /* if(isRouted==false){
                await AppDatabase.get().getLoanApprovalLimit(widget.laonLimitPassedObject.mprdcd,username).then((onValue){

                  if(onValue==0.0){
                    showMessage("Try Syncing Loan limit approval");
                  }

                  else if(onValue >= widget.laonLimitPassedObject.mapprvdloanamt) {
                    _showAlert("Confirm",1);

                  }else {

                    _showAlert("LoanPrrovalLimitAlert",0);
                  }
               });
                }
                else if(isRouted==true){

*/
                if(cgt1LeadNeeded==1&&(widget.laonLimitPassedObject.mleadsid==null||
                widget.laonLimitPassedObject.mleadsid.trim()==""||widget.laonLimitPassedObject.mleadsid.trim()=="null" )){
                    _showAlertMaxGuaranter("Leads ID ","Leads ID not Present");

                }else{
                  _showAlert("Confirm",1);
                }


                
                //}

              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: new SafeArea(
            child: SingleChildScrollView(
                child: new Column(
                  children: getCard(),
                ))));
  }

  List<Widget> getCard() {
    List<Widget> listCard = new List<Widget>();
    print(globals.questionCGT1.length);
    for (int i = 0; i < globals.questionCGT1.length; i++) {
      print("here");
      listCard.add(new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child: CheckboxListTile(
                  value: globals.questionCGT1[i].manschecked == null ||
                      globals.questionCGT1[i].manschecked == 0
                      ? false
                      : true,
                  title: new Text(
                    globals.questionCGT1[i].mquestiondesc,
                    textAlign: TextAlign.left,
                  ),
                  onChanged: (val) {
                    setState(() {
                      globals.questionCGT1[i].manschecked =
                      val == false ? 0 : 1;
                    });
                  })),
        ],
      ));
    }listCard.add(Container(
      child:isCGT2Needed==1?
      null:new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child: CheckboxListTile(
                  value: isRouted,
                  title: new Text(
                    Translations.of(context).text('Route_To_Super_User')
                    ,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight:FontWeight.bold),
                  ),
                  onChanged: (val) {
                    setState(() {
                      isRouted = !isRouted;
                      print("is Routed $isRouted");
                      print("is cgt2needed ${isCGT2Needed}");
                    });
                  })),
        ],
      ),
    ));
    listCard.add(
      new Form(
        key: formKey,
        onChanged: () {
          final FormState form = formKey.currentState;
          form.save();
        },
        child: new TextFormField(
            keyboardType: TextInputType.text,
            decoration:  InputDecoration(
              hintText: Translations.of(context).text('Enter_Remarks_Here'),
              labelText: Translations.of(context).text('Remarks'),
              hintStyle: TextStyle(color: Colors.grey),
              /*labelStyle: TextStyle(color: Colors.grey),*/
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  )),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff5c6bc0),
                  )),
              contentPadding: EdgeInsets.all(20.0),
            ),
            /* controller: cgt1bean.mremarks != null
            ? TextEditingController(text: cgt1bean.mremarks)
            : TextEditingController(text: ""),
       */ inputFormatters: [
          new LengthLimitingTextInputFormatter(60),
          globals.onlyAphaNumeric
        ],
            initialValue:
            cgt1bean.mremarks != null ? cgt1bean.mremarks : "",
            onSaved: (String value) {
              /*globals.firstName = value;*/
              cgt1bean.mremarks =
                  value;
            }
        ),),
    );

    return listCard;
  }

  Future<Null> _submitData() async {

    await checkMinMaxGuaranter().then((onValue)async{

    });

  }

  Future<void> _showAlert(String alertType,int consfirmStatus) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:alertType== "Submit"? new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ):(alertType=="Confirm"?
            new Icon(
              Icons.info,
              color: Colors.yellow
              ,
              size: 60.0,):
            new Icon(
              Icons.warning,
              color: Colors.red,
              size: 60.0,)
            )
            ,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  alertType== "Submit"?
                  Text("Submitted Successfully !")
                      :(alertType=="Confirm"?
                  Text(Translations.of(context).text('Are_You_Sure_You_Want_To_Confirm')):
                  Text(Translations.of(context).text('Please_Route_It_As_Your_Limit_Is_Above_Approval'))
                  ) ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  if(alertType =="Submit" ){

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }
                  else if(alertType =="Confirm" ){
                    Navigator.of(context).pop();
                    _submitData();
                  }
                  else{
                    Navigator.of(context).pop();
                  }
                },
              ),

              alertType!="Submit"?FlatButton(
                child: Text(Translations.of(context).text('Cancel')),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                },
              ):null
            ],
          );
        });
  }



  void showMessage(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Future<Null> checkMinMaxGuaranter() async{
    if(widget.laonLimitPassedObject.mprdcd!=null&&
        widget.laonLimitPassedObject.mprdcd.trim()!='null'&&
        widget.laonLimitPassedObject.mprdcd.trim()!=''){

      await AppDatabase.get().
      getProductOnPrdCd(30,branch,widget.laonLimitPassedObject.mprdcd.trim()).then((ProductBean prdObj)async{
        print("prdObj.mnoofguaranter ${prdObj.mnoofguaranter}");
        if(prdObj.mnoofguaranter>0){
          try{

            String value =  prdObj.mnoofguaranter.toString();

            print(" min ${value.length} value $value");
            int min =int.parse(value.substring(0, 1));
            int max = int.parse(value.substring(1));

            print(" min $min max $max");

            await AppDatabase.get().getGaurantorDetailsList(widget.laonLimitPassedObject.trefno,widget.laonLimitPassedObject.mrefno).then(
                    (List<GuarantorDetailsBean> gaurantorData)async{
                  if(gaurantorData==null || gaurantorData.length < min){
                    _showAlertMaxGuaranter(Translations.of(context).text("Min Guranter"), Translations.of(context).text("Minimum number of")+" $min " + Translations.of(context).text("guaranter is required") );
                    print("ayaya yayaya 3");
                  }else if(gaurantorData.length > max){
                    _showAlertMaxGuaranter(Translations.of(context).text("Min Guranter"), Translations.of(context).text("Maximum number of") +" $max " + Translations.of(context).text("guaranter is required")  );
                    print("ayaya yayaya 2");
                  }else if(await checkIfLoanLevelMandCriteriaMatch(widget.laonLimitPassedObject,1) ==false) {
                       if(loanLevelManadt==1){
                         _showAlertMaxGuaranter(Translations.of(context).text("Guaranter Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }else if(loanLevelManadt==2){
                         _showAlertMaxGuaranter(Translations.of(context).text("Guaranter Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }else if(loanLevelManadt==3){
                         _showAlertMaxGuaranter(Translations.of(context).text("Contact Point Verification Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }else if(loanLevelManadt==4){
                         _showAlertMaxGuaranter(Translations.of(context).text("Social And Enviornment Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }else if(loanLevelManadt==5){
                         _showAlertMaxGuaranter(Translations.of(context).text("Kyc Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }else if(loanLevelManadt==6){
                         _showAlertMaxGuaranter(Translations.of(context).text("Trc And Nrc Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }else if(loanLevelManadt==7){
                         _showAlertMaxGuaranter(Translations.of(context).text("Deviation Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }else if(loanLevelManadt==8){
                         _showAlertMaxGuaranter(Translations.of(context).text("Cash Flow Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }else if(loanLevelManadt==9){
                         _showAlertMaxGuaranter(Translations.of(context).text("Guaranter Form Data"), Translations.of(context).text("It_Is_Mandatory") );
                       }


                  }else {
                    if (await checkIfLoanLevelMandCriteriaMatch(
                        widget.laonLimitPassedObject, 1) == false) {
                      if (loanLevelManadt == 1) {
                        _showAlertMaxGuaranter(
                            Translations.of(context).text("Guaranter Form Data"), Translations.of(context).text("It_Is_Mandatory"));
                      } else if (loanLevelManadt == 2) {
                        _showAlertMaxGuaranter(
                            Translations.of(context).text("Guaranter Form Data"), Translations.of(context).text("It_Is_Mandatory"));
                      } else if (loanLevelManadt == 3) {
                        _showAlertMaxGuaranter(
                            Translations.of(context).text("Contact Point Verification Form Data"),
                            Translations.of(context).text("It_Is_Mandatory"));
                      } else if (loanLevelManadt == 4) {
                        _showAlertMaxGuaranter(
                            Translations.of(context).text("Social And Enviornment Form Data"),
                            Translations.of(context).text("It_Is_Mandatory"));
                      } else if (loanLevelManadt == 5) {
                        _showAlertMaxGuaranter(
                           Translations.of(context).text("Kyc Form Data"), Translations.of(context).text("It_Is_Mandatory"));
                      } else if (loanLevelManadt == 6) {
                        _showAlertMaxGuaranter(
                            Translations.of(context).text("Trc And Nrc Form Data"), Translations.of(context).text("It_Is_Mandatory"));
                      } else if (loanLevelManadt == 7) {
                        _showAlertMaxGuaranter(
                            Translations.of(context).text("Deviation Form Data"), Translations.of(context).text("It_Is_Mandatory"));
                      } else if (loanLevelManadt == 8) {
                        _showAlertMaxGuaranter(
                            Translations.of(context).text("Cash Flow Form Data"), Translations.of(context).text("It_Is_Mandatory"));
                      } else if (loanLevelManadt == 9) {
                        _showAlertMaxGuaranter(
                            Translations.of(context).text("Guaranter Form Data"), Translations.of(context).text("It_Is_Mandatory"));
                      } else {
                        submitDataToDataBase();
                      }
                    }else{
                      submitDataToDataBase();
                    }
                  }
                });

          }catch(_){
            print("ayaya yayaya ");
          }
        }else{
          submitDataToDataBase();
        }
      });
    }
  }

  Future<Null> submitDataToDataBase() async{
    print("ayaya yayaya 1");
    int loanTrefno = widget.laonLimitPassedObject.trefno;
    int loanMrefno = widget.laonLimitPassedObject.mrefno;
    int cgt1Trefno = widget.laonLimitPassedObject.trefno ;
    print("loanTrefno "+ loanTrefno.toString());
    print("loanMrefno "+ loanMrefno.toString());
    // print("loanTrefno "+loanTrefno.toString());
    for (int i = 0; i < globals.questionCGT1.length; i++) {
      int id = widget.laonLimitPassedObject.trefno + i;

                      globals.questionCGT1[i].mleadsid= "0";
                      globals.questionCGT1[i].mclcgt1refno = 0;
                      globals.questionCGT1[i].trefno = cgt1Trefno;
                      globals.questionCGT1[i].mrefno  = 0;
                      await AppDatabase.get().updateCgt1QaMaster(globals.questionCGT1[i], id);
                    }
                    print("remarks " + cgt1bean.mremarks.toString());
                    cgt1bean.trefno = widget.laonLimitPassedObject.trefno;
                    cgt1bean.mrefno = 0;
                    cgt1bean.loanmrefno = loanMrefno;
                    cgt1bean.loantrefno =loanTrefno;
                    cgt1bean.mcreatedby = username.trim();
                    cgt1bean.mcreateddt = DateTime.now();
                    cgt1bean.mlastupdateby = username;
                    cgt1bean.mendtime = DateTime.now();
                    cgt1bean.mlastupdatedt = DateTime.now();
                    cgt1bean.mgeologd = geoLongitude;
                    cgt1bean.mgeolatd = geoLatitude;
                    cgt1bean.mgeolocation = geoLocation;
                    if(widget.laonLimitPassedObject.mleadsid ==null||widget.laonLimitPassedObject.mleadsid.toString().trim() == 'null'){
                      cgt1bean.mleadsid = "0";
                    }
                    else{
                      cgt1bean.mleadsid = widget.laonLimitPassedObject.mleadsid;
                    }

                    cgt1bean.mcgt1doneby = username;
                    if(isCGT2Needed==0){

                      if(isRouted  == true){
                        cgt1bean.mroutefrom = username;
                        cgt1bean.mrouteto = mreportinguser;
                      }
                      else if(isRouted ==false){
                        cgt1bean.mroutefrom = "";
                        cgt1bean.mrouteto = "";
                      }

                    }else{
                      cgt1bean.mroutefrom = username;
                      cgt1bean.mrouteto = mreportinguser;
                    }
                    await AppDatabase.get().updateCGT1Master(cgt1bean);
                    CustomerLoanDetailsBean custLoanBean = new CustomerLoanDetailsBean();
                    if(isCGT2Needed==0){
                      custLoanBean.mleadstatus = 5;
                    }
                    else{
                      custLoanBean.mleadstatus = 6;
                    }

    custLoanBean.mapprovaldesc = cgt1bean.mremarks;
    custLoanBean.mcreatedby = username;
    await AppDatabase.get().updateLoanDetailsStatus(
        loanTrefno, loanMrefno,custLoanBean,DateTime.now(),cgt1bean.mrouteto,cgt1bean.mroutefrom,username);
    _showAlert("Submit",0);
  }


  Future<void> _showAlertMaxGuaranter(arg, error) async {
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

  Future<bool> checkIfLoanLevelMandCriteriaMatch(CustomerLoanDetailsBean items,int stage) async{
    bool retVal=true;

    await AppDatabase.get().getLoanLevelForStage(stage,items.mprdcd).then((List<LoanLevel> loanList)async {

      for(  LoanLevel loanLevel in loanList) {
        if (loanLevel.mbuttonid == 1) {
          //GuarantorDetails


        }
        if (loanLevel.mbuttonid == 2) {
          //GuarantorDetails


        }
        if (loanLevel.mbuttonid == 3) {
          //CustomerLoanCPVBusinessRecord
          if(loanLevel.mismandatory==1) {
            CustomerLoanCPVBusinessRecordBean cpvCashFlowObj = await AppDatabase.get().getLoanCPVValues(items.trefno, items.mrefno);
            if(cpvCashFlowObj==null){
              loanLevelManadt =3;
              retVal=false;

            }
          }
        }
        if (loanLevel.mbuttonid == 4) {
          //SocialAndEnvironmental
          if(loanLevel.mismandatory==1) {
            SocialAndEnvironmentalBean socialCashFlowObj = await AppDatabase.get().getSocialAndEnvValues(items.trefno, items.mrefno);
            if(socialCashFlowObj==null){
              loanLevelManadt =4;
              retVal=false;

            }
          }
        }
        if (loanLevel.mbuttonid == 5) {
          //KycMaster
          if(loanLevel.mismandatory==1) {
            KycMasterBean globalKycMasterObj = await AppDatabase.get().getKycMasterObj(items.trefno, items.mrefno);
            if(globalKycMasterObj==null){
              loanLevelManadt =5;
              retVal=false;

            }
          }
        }
        if (loanLevel.mbuttonid == 6) {
          //TradeAndNeighbourRefCheck
          if(loanLevel.mismandatory==1) {
            TradeAndNeighbourRefCheckBean tradeCashFlowObj = await AppDatabase.get().getTradeAndNeighValues(items.trefno, items.mrefno);
            if(tradeCashFlowObj==null){
              loanLevelManadt =6;
              retVal=false;

            }
          }
        }
        if (loanLevel.mbuttonid == 7) {
          //DeviationForm
          if(loanLevel.mismandatory==1) {
            DeviationFormBean deviationCashFlowObj = await AppDatabase.get().getDeviationFormValues(items.trefno, items.mrefno);
            if(deviationCashFlowObj==null){
              loanLevelManadt =7;
              retVal=false;

            }
          }
        }
        if (loanLevel.mbuttonid == 8) {
          //CustomerLoanCashFlow
          if(loanLevel.mismandatory==1) {
            CustomerLoanCashFlowAnalysisBean customerLoanCashFlowAnalysisBean=  await AppDatabase.get().getCashFlowAnalysis(items.trefno, items.mrefno);
            if(customerLoanCashFlowAnalysisBean==null){
              loanLevelManadt =8;
              retVal=false;

            }
          }
        }
        if (loanLevel.mbuttonid == 9) {
          //GuarantorDetails


        }
      }
     // cehckifStagesFilled();

    });


    return retVal;
  }
}
