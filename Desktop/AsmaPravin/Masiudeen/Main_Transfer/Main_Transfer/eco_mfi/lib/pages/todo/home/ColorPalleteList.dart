import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/todo/home/ColourPalleteGenerater.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanSyncing.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
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
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ColourPalleteList extends StatefulWidget {

  final DateTime passedDateTime;
  ColourPalleteList({Key key, this.passedDateTime})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ColourPalleteList> {
  List<ColorPalleteBean> storedDisList = new List<ColorPalleteBean>();
  List<ColorPalleteBean> items = new List<ColorPalleteBean>();
  Widget appBarTitle = new Text("Colour Pallete List");

  Icon actionIcon = new Icon(Icons.search);
  Icon deleteIcon = new Icon(Icons.delete);
  int selectedTrefNo = 0;



  @override
  void initState() {
    super.initState();
    getSessionVariables();
  }




  Future<Null> getSessionVariables() async {

  }

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  int count = 1;

  @override
  Widget build(BuildContext context) {
    var futureBuilder;

    if (count == 1) {
      count++;

      futureBuilder = new FutureBuilder(
          future: AppDatabaseExtended.get()
              .getColorPallteList()
              .then((List<ColorPalleteBean> result) {
            if (result != null) {
              items.clear();
              result.forEach((obj) {
                if(obj.misselected==1){
                  selectedTrefNo=obj.trefno;
                }

                items.add(obj);
                storedDisList.add(obj);
              });

              if(selectedTrefNo==0){
                selectedTrefNo = 1;
              }

              return storedDisList;
            } else
              return new Container();
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
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                  if (storedDisList == null || storedDisList.isEmpty) {
                    return new Container(child: new Text(""));
                  } else
                    return getHomePageBody(context, snapshot);
                }
            }
          });
    }
    else {
      futureBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {
          return new GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new ColourPalleteGenerater(passedColorPalleteObject: items[position])
                  ), //When Authorized Navigate to the next screen
                );

              },
              child: Container(
                color: Colors.white,
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: items[position].appbar,
                      foregroundColor: Colors.white,
                    ),
                    title: Text('${items[position].mname}'),
                    trailing:
                    items[position].trefno==selectedTrefNo?Container(
                      width: 50.0,
                      child: new Row(
                        children: <Widget>[
                          new IconButton(
                            icon: new Icon(
                              Icons.check,
                              color: Colors.orange[400],

                            ),
                            onPressed: () async {

                            },
                          ),
                        ],
                      ),
                    ):new GestureDetector(
                      child: Container(
                          width: 100.0,
                          child: new Text('Apply', style: TextStyle(color: Colors.blue),)),
                      onTap: ()async{

                        await AppDatabaseExtended.get().updateSelectedColor(items[position].trefno);
                        Constant.loadColorPallete(items[position]);
                        selectedTrefNo = items[position].trefno;
                        setState(() {

                        });

                      },

                    )


                ),
              ));
        },
      );
    }

    return new Scaffold(
        key: _scaffoldHomeState,
        appBar: new AppBar(
          elevation: 3.0,
          leading:
          /*tag: "Buttons",
          child: */new IconButton(
            icon: new Icon(Icons.arrow_back, color: globals.appbaricon??Colors.white,),
            onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
            globals.sessionTimeOut.SessionTimedOut();
            //callDialog();
            Navigator.of(context).pop();
            },
          ),


          backgroundColor:globals.appbar??Color(0xff07426A),
          brightness: Brightness.light,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
                icon: actionIcon,
                onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
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
                      },
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text(
                        Translations.of(context).text('Colour Pallete List'));
                    items.clear();
                    storedDisList.forEach((val) {
                      items.add(val);
                    });
                  }
                });
                }),

          ],
        ),
        floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add)
            ,onPressed: (){
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new ColourPalleteGenerater()
            ), //When Authorized Navigate to the next screen
          );

        })
        ,body: futureBuilder
    );
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null && storedDisList != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI2,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI2(BuildContext context, int index) {
    return new GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                new ColourPalleteGenerater(passedColorPalleteObject: items[index])
            ), //When Authorized Navigate to the next screen
          );

        },
        child:Container(
          color: Colors.white,
          child: ListTile(
              leading: CircleAvatar(
                backgroundColor:items[index].appbar,
                foregroundColor: Colors.white,
              ),
              title: Text('${items[index].mname}'),
              trailing:
              items[index].trefno==selectedTrefNo?Container(
                width: 50.0,
                child: new Row(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.check,
                        color: Colors.orange[400],

                      ),
                      onPressed: () async {

                      },
                    ),
                  ],

                ),
              ):new GestureDetector(
                child: Container(
                  width: 100.0,
                    child: new Text('Apply', style: TextStyle(color: Colors.blue),)),
                onTap: ()async{

                  await AppDatabaseExtended.get().updateSelectedColor(items[index].trefno);
                  Constant.loadColorPallete(items[index]);
                  selectedTrefNo = items[index].trefno;
                  setState(() {

                  });

                },

              )



          ),
        ));
  }




}


