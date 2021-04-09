import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../translations.dart';
import 'DisplayTablesData.dart';

class DisplayTablesSearchByQuery extends StatefulWidget {

  DisplayTablesSearchByQuery();

  @override
  _DisplayTablesSearchByQuery createState() => new _DisplayTablesSearchByQuery();
}

class _DisplayTablesSearchByQuery extends State<DisplayTablesSearchByQuery> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool autovalidateVar  = false;
  String value;
  @override
  void initState() {
    getSessionVariables();
  }
  void getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

    });

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
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Color(0xff01579b),
              brightness: Brightness.light,
              title: new Text(
                'Result',
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
                                maxLines: 10,
                                decoration: InputDecoration(
                                  hintText: 'Enter query here',
                                  labelText: 'Query',
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



                               /* inputFormatters: [
                                  LengthLimitingTextInputFormatter(30),
                                ],*/
                                onSaved: (val) {
                                  value= val;
                                },
                              )),



                          SizedBox(height:40.0),


                          Center(
                            child:  new Container(

                                child: new RaisedButton(
                                    child: Text(
                                      'Devlopers',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {

                                       displayTable();
                                    })),

                          ),
                          Center(
                            child:  new Container(

                                child: new RaisedButton(
                                    child: Text(
                                      'DevlopersUpdate',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      await AppDatabase.get().UpdateByQuery(value);
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
  displayTable(){
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
          new DisplayTablesData(query: value)), //When Authorized Navigate to the next screen
    );
  }

}