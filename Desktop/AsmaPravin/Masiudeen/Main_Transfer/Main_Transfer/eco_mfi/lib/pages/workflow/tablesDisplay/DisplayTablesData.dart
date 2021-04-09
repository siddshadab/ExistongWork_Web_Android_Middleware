

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:flutter/cupertino.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';

class DisplayTablesData extends StatefulWidget {
  final query;
  DisplayTablesData({this.query});

  @override
  _DisplayTablesData createState() => new _DisplayTablesData();
}

class _DisplayTablesData extends State<DisplayTablesData> {

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

      dummyColumn =new List<DataColumn>();
      dummyColumn.add( new DataColumn(
        label: const Text('Sr No'),
      ),);

    await  AppDatabase.get()
          .selectTableName(widget.query!=null && widget.query!='null' && widget.query!=''?widget.query:"select * from customerFoundationMasterDetails")
          .then((var customerData){
             List<String> captions = new List<String>();
            for(var atn in customerData){
              var values = atn.toString().split("}");
              print("values[0] xxxxxxxxxxxxxxxxxx ${values[0]}");
              String str = values[0];
              str = str.replaceAll("{", "");
              str = str.replaceAll("}", "");
              print("str xxxxxxxxxxxxxxxxxx ${str}");
              var values2 = str.toString().split(",");
              for(int val =0;val<values2.length;val++){
                captions.add(values2[val]);
              }
              print("captions xxxxxxxxxxxxxxxxxx ${captions}");
              break;

            }
             getTabularDataInColumnsCaptions(captions);

     for(var items in customerData){
            print(" items ${items}");
         //var values = items.toString().split(",");
          //for(int val =0;val<values.length;val++){
            getTabularDataRows(items);

          //}
        }

        setState(() {

        });
      });
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
                Navigator.of(context).pop();
                 // callDialog();
                }),
            backgroundColor: Color(0xff07426A),
            brightness: Brightness.light,
            title: new Text(
              'Devlopers',
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


   getTabularDataInColumnsCaptions(List<String> captions/*String variable*/){
      if(listWidget==null){
        listWidget =new List<DataRow>();
      }

      if(listColumnWidget ==null){
        listColumnWidget=new List<DataColumn>();
      }

     // List<DataColumn> cellList =new List<DataColumn>();
      print("captions.length captions.length captions.length ${captions.length}");
      for(int capt=0;capt<captions.length;capt++){
        String val = captions[capt].replaceAll(RegExp(r':.*'), "");
        listColumnWidget.add(new DataColumn(
          label:  Text(val),
        ),);

      }

      //listColumnWidget.add(cellList);

      setState(() {

      });
  }

  getTabularDataRows(Map rows){
    if(listWidget==null){
      listWidget =new List<DataRow>();
    }


      var values = rows.toString().split(",");
    List<DataCell> cellList =new List<DataCell>();
      for(int val =0;val<values.length;val++){
        String valDisp = values[val].replaceAll(RegExp(r'.*:'), "");
          cellList.add( new DataCell(
            new Text(
              valDisp,
              style: TextStyle(),
            ),
          ),);
      //  }

        //getTabularDataRows();
      }

    print("cellList.length cellList.length cellList.length ${cellList.length}");
    listWidget.add(new DataRow(cells:cellList,));


  //  listColumnWidget.add(cellList);

    setState(() {

    });
  }




}


