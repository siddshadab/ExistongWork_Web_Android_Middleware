import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/AdminModule/AccessRightModuleBean.dart';
import 'package:eco_mfi/pages/workflow/AdminModule/AccessRightModuleSyncing.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomerModificationAccess extends StatefulWidget {
  @override
  _CustomerModificationAccessState createState() => _CustomerModificationAccessState();
}

class _CustomerModificationAccessState extends State<CustomerModificationAccess> {


  CustomerModificationAccessBean custAccessModBean = new CustomerModificationAccessBean();
    bool autovalidateVar  = false;
  


  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "/customerData/CustomerModifyAccess/";
  static final _headers = {'Content-Type': 'application/json'};
  
   void initState() {
    getSessionVariables();
  }
  void getSessionVariables() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     custAccessModBean.mlbrcode= prefs.get(TablesColumnFile.musrbrcode);
  }


  callDialog(){
    Navigator.of(context).pop();
  }
  
  
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(onWillPop: () {
      callDialog();
    },
        child: new Scaffold(

            key: _scaffoldKey,
            appBar: new AppBar(
              elevation: 1.0,
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  callDialog();
                },
              ),
              backgroundColor: Color(0xff01579b),
              brightness: Brightness.light,
              title: new Text(
                Translations.of(context).text('Customer_access'),
                //textDirection: TextDirection,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.normal),
              ),
            ),

            body: new SafeArea(top: false,
              bottom: false,
              child: new Form(
                key: _formKey,
                onWillPop: () {
                  Navigator.of(context).pop();
                },
                onChanged: () {
                  final FormState _form2 = _formKey.currentState;
                  _form2.save();
                },
                autovalidate:  autovalidateVar,
                child: SingleChildScrollView(
                    child: new Column(
                        children: <Widget>[
                          SizedBox(height: 20.0,),
                          Container(
                              decoration:
                              BoxDecoration(color: Constant.mandatoryColor),
                              child: new TextFormField(
                                decoration:  InputDecoration(
                                  hintText: Translations.of(context).text('custnum'),
                                  labelText: Translations.of(context).text('custnum'),
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      decorationColor: Colors.red),
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      )),
                                  contentPadding: EdgeInsets.all(20.0),
                                ),

                                validator: (String arg) {
                                  if (arg==null)
                                    return Translations.of(context).text('shold_not_blank');
                                  else
                                    return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                controller: custAccessModBean.mcustno == null
                                    ? TextEditingController(text: null)
                                    : TextEditingController(
                                    text: custAccessModBean.mcustno.toString()),
                                onSaved: (val) {
                                  if(val!=null){
                                    try{

                                        custAccessModBean.mcustno  = int.parse(val);
                                    }catch(_){
                                          print("Yhan fta");

                                    }


                                  } 
                                },
                              )),



                          SizedBox(height:40.0),


                          Center(
                            child:  new Container(

                                child: new RaisedButton(
                                    child: Text(
                                      Translations.of(context).text('grant_access'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {

                                      _ShowProgressInd(context);

                                      tryChangeAccess();
                                    })),

                          )




                        ]
                    )
                ),

              ),

            )
        )
    );
  }





   Future<Null> tryChangeAccess() async {

    final FormState form = _formKey.currentState;

    bool netAvail = false;
    Utility obj = new Utility();
    netAvail = await obj.checkIfIsconnectedToNetwork();
    if (netAvail == false) {
      showInSnackBar(Translations.of(context).text('Network_Not_Available'));
      return;
    }


    if (form.validate()) {
      form.save();
      _performChangeAccess();
    } else {
      setState(() => autovalidateVar = true);
      showInSnackBar(Translations.of(context).text('Please_Fix_The_Errors_In_Red_Before_Submitting'));
    }

  }



  Future _performChangeAccess() async {

    //try {
      var mapData = new Map();
    mapData[TablesColumnFile.mcustno] = custAccessModBean.mcustno==null?0:custAccessModBean.mcustno;
    mapData[TablesColumnFile.mlbrcode] = custAccessModBean.mlbrcode==null?0:custAccessModBean.mlbrcode;

    String json = JSON.encode(mapData);
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
    print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
    print("returned value is "+bodyValue.toString());
    if (bodyValue == "404"|| bodyValue ==null) {
      return null;
    } else {
      print("trying to parse");
      CustomerModificationAccessBean   custAccessModBean = await _fromLoginJson(bodyValue);

      if(custAccessModBean.missynctocoresys==1){

        Navigator.of(context).pop();
        success(custAccessModBean.merrormessage, context);

      }
      else{
        Navigator.of(context).pop();
        showErrorDialog( custAccessModBean.merrormessage);
      }

    }
    /*} catch(error){
    }*/



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



  showErrorDialog( String message) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
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
                  Text(message)],
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


  Future<CustomerModificationAccessBean> _fromLoginJson(String json) async{
    Map<String, dynamic> map = JSON.decode(json);
    print(json + " form jso obj response" + "here is" + map.toString());
    CustomerModificationAccessBean custBean = CustomerModificationAccessBean.fromMap(map);
    return custBean;
  }


  void showInSnackBar(String value, [Color color]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: color != null ? color : null,
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





}


class CustomerModificationAccessBean{

  int mcustno;
  int missynctocoresys;
  String merrormessage;
  int mlbrcode;

  CustomerModificationAccessBean(
      {this.mcustno,
      this.missynctocoresys,
      this.merrormessage,
      this.mlbrcode,

      });




factory CustomerModificationAccessBean.fromMap(Map<String, dynamic> map) {
    return CustomerModificationAccessBean(
        mcustno: map[TablesColumnFile.mcustno] as int,
         missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
         merrormessage: map[TablesColumnFile.merrormessage] as String,
         mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        

    );
    
    }


}