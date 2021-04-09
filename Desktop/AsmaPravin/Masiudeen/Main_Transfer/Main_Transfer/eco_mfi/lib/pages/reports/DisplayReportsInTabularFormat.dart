
import 'package:eco_mfi/Utilities/globals.dart' as globals;

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';

class DisplayReportsInTabularFormat extends StatefulWidget {
  // final query;
  var listWidget ;
  var listColumnWidget ;
  var dummyRow ;
  var dummyColumn ;

  DisplayReportsInTabularFormat({this.listWidget,this.listColumnWidget,this.dummyRow,this.dummyColumn});

  @override
  _DisplayReportsInTabularFormat createState() => new _DisplayReportsInTabularFormat();
}

class _DisplayReportsInTabularFormat extends State<DisplayReportsInTabularFormat> {

  var listWidget =null;
  var listColumnWidget =null;
  var dummyRow =null;
  var dummyColumn =null;



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getSet();
  }
  getSet() async{

    dummyRow =new List<DataRow>();
    dummyRow.add(DataRow( cells: [
      DataCell( new Text("ssss ",
        style: new TextStyle(color: Colors.black),),
      ),

    ]));

    dummyRow =widget.dummyRow;

    dummyColumn =new List<DataColumn>();


    dummyColumn.add( new DataColumn(
      label: const Text('Sr No'),
    ),);

    listWidget =widget.listWidget;
    listColumnWidget =widget.listColumnWidget;
    dummyColumn =widget.dummyColumn;

  }

  String value="";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   new WillPopScope(
      /*   onWillPop: () {
        //  callDialog();
        },*/
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          elevation: 1.0,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                // callDialog();
              }),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            'Reports Display Format',
            //textDirection: TextDirection,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.normal),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                // proceed();
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(0.0),
            children: <Widget>[

              new SingleChildScrollView(
                // physics: new AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child:new DataTable(
                  dataRowHeight: 100.0,
                  rows: listWidget!=null?listWidget:dummyRow,
                  columns:  listColumnWidget!=null?listColumnWidget:dummyColumn,
                ),

              ),

            ]),

      ),
    );


  }






}


