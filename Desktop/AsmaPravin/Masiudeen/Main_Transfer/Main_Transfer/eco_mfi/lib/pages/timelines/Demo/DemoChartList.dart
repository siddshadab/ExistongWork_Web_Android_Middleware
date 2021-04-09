import 'package:flutter/material.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
//import 'package:eco_mfi/pages/timelines/GraphMasterTab.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:eco_mfi/pages/timelines/GraphUtils.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';


class DemoChartsList extends StatefulWidget {
  @override
  _ChartsListState createState() => _ChartsListState();
}

GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

class _ChartsListState extends State<DemoChartsList> {
  var futureBuilder;

  List<ChartsBean> items = new List<ChartsBean>();
  List<ChartsBean> storedItems = new List<ChartsBean>();
  int count = 0;
  Widget buildSubtitle ;
  Widget appBarTitle = new Text("Graphical Representation");
  Icon actionIcon = new Icon(Icons.search);
  Icon deleteIcon = new Icon(Icons.delete);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(count==0){
      count++;
      futureBuilder = new FutureBuilder (
          future:  AppDatabase.get()
              .getChartsDetailsList('0').then(
                  (List<ChartsBean> chartsBeanList)  {
                if (chartsBeanList != null) {

                  List<ChartsBean> chartBeanListLocal =
                  [
                    new ChartsBean(trefno: 1,mrefno: 2,mtype: "xy",mquery: "Select * from md009011",
                    mtitle: "Number To Loan Creation according to states"),

                    new ChartsBean(trefno: 1,mrefno: 3,mtype: "xy",mquery: "Select * from md009011",
                        mtitle: "Performance for Past 6 months"),

                    new ChartsBean(trefno: 1,mrefno: 4,mtype: "xyy",mquery: "Select * from md009011",
                      mtitle: "Target to Disbursment Comparison"),

                  ];
                  items.clear();
                  storedItems.clear();
                  chartBeanListLocal.forEach((obj) {
                    items.add(obj);
                    storedItems.add(obj);
                  });

                  return storedItems;
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
                  if (storedItems == null || storedItems.isEmpty) {
                    return new Container(child: new Text(""));
                  } else
                    return getHomePageBody(context, snapshot);
                }
            }
          });

    }
    else  if(items!=null){

      futureBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {


          return new GestureDetector(
            onTap: () async{

              _ShowProgressInd(context);

//              GraphUtils grphUtilObj = new GraphUtils();
//              items[position].chartSampleData = await grphUtilObj.getChartSampleData(items[position]);
//
//              print("Chart Sample data hai ${items[position].chartSampleData}");



              Navigator.of(context).pop();


//              Navigator.push(
//                context,
//                new MaterialPageRoute(
//                    builder: (context) => GraphMasterTab(chartPassedObject: items[position] )), //When Authorized Navigate to the next screen
//              );
            },
            child:
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child:

            Card(
              //color: Colors.white,
              child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(items[position].mtitle),
                  ),
                  subtitle:
                  new Text(items[position].mquery,style: TextStyle(fontSize: 12.0),)

                //buildSubtitle,
                //trailing: new Text(items[position].mamt.toString(),style: TextStyle(fontWeight: FontWeight.bold),),


                // trailing: new IconButton(
                //   icon: new Icon(
                //     FontAwesomeIcons.sync,
                //     color: Colors.orange[400],
                //     size: 25.0,
                //   ),
                //   onPressed: () async {
                //     _syncDisbursedListToMoiddleware(
                //         items[position]);
                //   },
                // )
              ),
            ),
            //)
          );
        },
      );

      setState(() {

      });




    }


    return new Scaffold(
        key: _scaffoldHomeState,
        appBar: new AppBar(
          elevation: 3.0,
          leading:
          /*tag: "Buttons",
          child: */
          new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              globals.sessionTimeOut = new SessionTimeOut(context: context);
              globals.sessionTimeOut.SessionTimedOut();
              //callDialog();
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Color(0xff01579b),
          brightness: Brightness.light,
          title: appBarTitle,
          actions: <Widget>[
            new IconButton(
                icon: actionIcon,
                onPressed: () {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
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
                          filterList(val.toLowerCase());
                        },
                      );
                    } else {
                      this.actionIcon = new Icon(Icons.search);
                      this.appBarTitle = new Text(Translations.of(context)
                          .text('DisbursmentSearchList'));
                      items.clear();
                      storedItems.forEach((val) {
                        items.add(val);
                      });
                    }
                  });
                }),
          ],
        ),
        body: futureBuilder);
  }



  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () async{


        _ShowProgressInd(context);

//        GraphUtils grphUtilObj = new GraphUtils();
//        items[index].chartSampleData = await grphUtilObj.getChartSampleData(items[index]);
//
//        print("Chart Sample data hai ${items[index].chartSampleData}");



        Navigator.of(context).pop();


//        Navigator.push(
//          context,
//          new MaterialPageRoute(
//              builder: (context) => GraphMasterTab(chartPassedObject: items[index] )), //When Authorized Navigate to the next screen
//        );

      },
      child:


      Card(
        //color: Colors.white,
        child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(items[index].mtitle),
            ),
            subtitle:
            new Row(
              children: <Widget>[

              ],
            )
        ),
      ),
      //)
    );
  }


  void filterList(String val) async {
    // print("inside filterList");
    items.clear();
    items = new List<ChartsBean>();

    storedItems.forEach((obj) {
      if (obj.mtitle
          .toString()
          .toUpperCase()
          .contains(val.toUpperCase()) |
      obj.mtitle.toString().contains(
          val) /*obj.mcustno!=null && obj.mcustno!='null'?obj.mcustno.toString().toLowerCase().contains(val):false*/) {
        //  print("inside contains");
        //  print(items);
        items.add(obj);
      }
    });

    setState(() {});
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

}
