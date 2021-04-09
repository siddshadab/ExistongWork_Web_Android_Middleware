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

class LicenseMaster extends StatefulWidget {
  @override
  _LicenseMaster createState() => _LicenseMaster();
}

class _LicenseMaster extends State<LicenseMaster> {


  LicenseMasterBean licenseMasterBean = new LicenseMasterBean();
    bool autovalidateVar  = false;
  


  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "/LicenseController/add/";
  static final _headers = {'Content-Type': 'application/json'};
  
   void initState() {
    getSessionVariables();
  }
  void getSessionVariables() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     licenseMasterBean.mlastupdateby=prefs.getString(TablesColumnFile.musrcode);
      licenseMasterBean.mgeolocation = prefs.getString(TablesColumnFile.geoLocation);
      try{
        licenseMasterBean.mgeolatd = prefs.getDouble(TablesColumnFile.geoLatitude).toString();
       licenseMasterBean.mgeologd = prefs.getDouble(TablesColumnFile.geoLongitude).toString();
      }catch(_){
        print("Exception in getting loangitude");
      }
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
                Translations.of(context).text('License Master'),
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
                                  hintText: Translations.of(context).text('license Key'),
                                  labelText: Translations.of(context).text('license Key'),
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
                                  if (arg==null||arg.trim()==''||arg.trim()=='null')
                                    return Translations.of(context).text('shold_not_blank');
                                  else
                                    return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(30)
                                ],
                                controller: licenseMasterBean.mlicensekey == null
                                    ? TextEditingController(text: null)
                                    : TextEditingController(
                                    text: licenseMasterBean.mlicensekey),
                                onSaved: (val) {
                                  if(val!=null){
                                    try{

                                        licenseMasterBean.mlicensekey  = val;
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
                                      Translations.of(context).text('updateLicense'),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {

                                      final FormState form = _formKey.currentState;

                                      if (form.validate()) {
                                       form.save();
                                     _showConfAlert();
                                      }  else {
                                      setState(() => autovalidateVar = true);
                                     showInSnackBar(Translations.of(context).text('Please_Fix_The_Errors_In_Red_Before_Submitting'));
                                      }
                                      
                                      
                                      

                                     
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





   Future<Null> tryChangeLicense() async {

    //final FormState form = _formKey.currentState;

    bool netAvail = false;
    Utility obj = new Utility();
    netAvail = await obj.checkIfIsconnectedToNetwork();
    if (netAvail == false) {
      showInSnackBar(Translations.of(context).text('Network_Not_Available'));
      return;
    }

      _performChangeAccess();
    

  }



  Future _performChangeAccess() async {

    //try {
      var mapData = new Map();
    mapData[TablesColumnFile.srno]   = 1;
    mapData[TablesColumnFile.mlicensekey] = licenseMasterBean.mlicensekey;
    mapData[TablesColumnFile.mlastupdateby] = licenseMasterBean.mlastupdateby;
    mapData[TablesColumnFile.mlastmeetngdt] = DateTime.now().toIso8601String();
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(licenseMasterBean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(licenseMasterBean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(licenseMasterBean.mgeologd);


    String json = JSON.encode(mapData);
    print("sending json is ${json}");
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
    print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
    print("returned value is "+bodyValue.toString());
    if (bodyValue == "404"|| bodyValue ==null) {
      Navigator.of(context).pop();
        showErrorDialog( "Error Received");
        return null;
    } else {
      print("trying to parse");
      LicenseMasterBean   retLicMastBean = await _fromLoginJson(bodyValue);

      if(retLicMastBean!=null){

        Navigator.of(context).pop();
        success("Update Successfully", context);

      }
      else{
        Navigator.of(context).pop();
        showErrorDialog( "Error Received");
      }

    }
    /*} catch(error){
    }*/



  }

   String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value;
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


  Future<LicenseMasterBean> _fromLoginJson(String json) async{
    Map<String, dynamic> map = JSON.decode(json);
    print(json + " form jso obj response" + "here is" + map.toString());
    LicenseMasterBean licenseBean = LicenseMasterBean.fromMap(map);
    return licenseBean;
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



  Future<void> _showConfAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Icon(
              Icons.info,
              color: Colors.yellow
              ,
              size: 60.0,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Translations.of(context).text('Are you sure you want ot update License Key')),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Yes')),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                Navigator.of(context).pop();
                _ShowProgressInd(context);
                 tryChangeLicense();
              },
            ),
            FlatButton(
              child: Text(Translations.of(context).text('No')),
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






class LicenseMasterBean{

    DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  String mlicensekey;

   LicenseMasterBean(  //numeric(8)
          {
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.mlicensekey});


   factory LicenseMasterBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return LicenseMasterBean(
      mlicensekey: map[TablesColumnFile.mlicensekey] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:	map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:	map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:	map[TablesColumnFile.mgeolatd] as String,
      mgeologd:	map[TablesColumnFile.mgeologd] as String  );
   } 





}