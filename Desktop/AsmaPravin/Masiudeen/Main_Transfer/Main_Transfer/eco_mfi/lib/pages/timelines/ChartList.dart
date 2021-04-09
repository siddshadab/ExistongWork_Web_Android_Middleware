import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoCustomizedLine.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoPieGrouping.dart';
import 'package:eco_mfi/pages/timelines/ReportMasterTab.dart';
import 'package:eco_mfi/pages/timelines/ReportUtils.dart';
import 'package:eco_mfi/pages/timelines/Reports/ReportGeneration.dart';
import 'package:eco_mfi/pages/timelines/testingPage.dart';
import 'package:eco_mfi/pages/todo/home/WebViewTest.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ChartsBean.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/pages/timelines/GraphMasterTab.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eco_mfi/pages/timelines/GraphUtils.dart';
import 'package:eco_mfi/Utilities/globals.dart';


class ChartsList extends StatefulWidget {
  ChartsList({this.requestedPage,key}):super(key:key);
  final String requestedPage;
  @override
  _ChartsListState2 createState() => _ChartsListState2();
}

GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();



class _ChartsListState2 extends State<ChartsList> {
  var futureBuilder;
  Map<String, DateTime> dateMap = new Map<String, DateTime>();
  DateTime date = DateTime.now();

  List<UserRightBean> items = new List<UserRightBean>();
  List<UserRightBean> storedItems = new List<UserRightBean>();
  int count = 0;
  Widget buildSubtitle ;
  Widget appBarTitle = new Text("Graphical Representation" ,style: TextStyle(color: Colors.black),);
  Icon actionIcon = new Icon(Icons.search,color: Colors.black,);
  Icon deleteIcon = new Icon(Icons.delete,color: Colors.black,);
  Utility obj = new Utility();
  //double height;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // height= MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {

    if(count==0){
      count++;
      futureBuilder = new FutureBuilder (
          future:  AppDatabaseExtended.get()
              .getUserRights(UserRightBean(),widget.requestedPage=="graphlist"?"Charts":"Reports").then(
                  (List<UserRightBean> chartsBeanList)  {

                if (chartsBeanList != null) {
                  items.clear();
                  storedItems.clear();
                  chartsBeanList.forEach((obj) {
                    print(obj);
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
    else  if(false){

      futureBuilder = ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, position) {

         if(items[position].userSubRightBean==null){
           return getContainer(items[position]);
         }
         else{
           return getExpansionParentTile(items[position]);
         }

//          return new GestureDetector(
//            onTap: () async{
//
//              _ShowProgressInd(context);
//              bool netAvail = false;
//              netAvail = await obj.checkIfIsconnectedToNetwork();
//              if (netAvail == false) {
//                showMessageWithoutProgress("Network Not available");
//                Navigator.of(context).pop();
//                return;
//              }
//
//              GraphUtils grphUtilObj = new GraphUtils();
//
////              items[position].chartSampleData = await GraphUtils.getChartSampleData(items[position]);
////              print("x caption ki value hai  ${items[position].xcaption}");
////              print("y caption ki value hai  ${items[position].ycaption}");
////              print("Chart Sample data hai ${items[position].chartSampleData}");
////
////
////
////              Navigator.of(context).pop();
////
////
////              Navigator.push(
////                context,
////                new MaterialPageRoute(
////                    builder: (context) => GraphMasterTab(chartPassedObject: items[position] )), //When Authorized Navigate to the next screen
////              );
//            },
//            child:
//            // Padding(
//            //   padding: const EdgeInsets.all(8.0),
//            //   child:
//
//            Card(
//              //color: Colors.white,
//              child: ListTile(
//                  title: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: new Text(items[position].menuDesc),
//                  ),
//                  subtitle:
//                  new Text(items[position].menuid.toString(),style: TextStyle(fontSize: 12.0),)
//
//                //buildSubtitle,
//                //trailing: new Text(items[position].mamt.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
//
//
//                // trailing: new IconButton(
//                //   icon: new Icon(
//                //     FontAwesomeIcons.sync,
//                //     color: Colors.orange[400],
//                //     size: 25.0,
//                //   ),
//                //   onPressed: () async {
//                //     _syncDisbursedListToMoiddleware(
//                //         items[position]);
//                //   },
//                // )
//              ),
//            ),
//            //)
//          );
        },
      );

      setState(() {

      });




    }




      return Scaffold(
        key: _scaffoldHomeState,
        drawerScrimColor: Colors.white,
        backgroundColor: Colors.white,
          body:
//          new Container(
//            height: 400.0,
//            child:
        new SingleChildScrollView(
          child: new Column(
                //scrollDirection: Axis.vertical,

                children: <Widget>[

                  Stack(

                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        transform: Matrix4.translationValues(0.0, -50.0, 0.0)
                        ,child: Hero(
                          tag: "hh",
                          child: ClipShadowPath(

                            clipper: CircularClipper(),
                           shadow: Shadow(blurRadius: 5.0),
                            child: Image(
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              image:widget.requestedPage=="graphlist"? AssetImage("assets/graph8.png"):AssetImage("assets/report8.jpg"),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.only(left: 30.0),
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back),
                            iconSize: 30.0,
                            color: Colors.black,
                          ),
                          widget.requestedPage=="graphlist"?
                              new Text("Graphical Representaion",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0), ):
                          new Text("Report Analysis",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.black), ),
                          IconButton(
                            padding: EdgeInsets.only(left: 30.0),
                            onPressed: () => print('Add to Favorites'),
                            icon: Icon(Icons.search),
                            iconSize: 30.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Positioned.fill(
                        bottom: 10.0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: RawMaterialButton(
                            padding: EdgeInsets.all(10.0),
                            elevation: 12.0,
                            onPressed: () {
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (_) => VideoList(),
//                            ),
//                          );

                            },
                            shape: CircleBorder(),
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.pie_chart,
                              size: 60.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 20.0,
                        child: IconButton(
                          onPressed: () => print('Add to My List'),
                          icon: Icon(Icons.refresh),
                          iconSize: 40.0,
                          color: Colors.black,
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 25.0,
                        child: IconButton(
                          onPressed: () => print('Share'),
                          icon: Icon(Icons.share),
                          iconSize: 35.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                      Container(
                        height :(MediaQuery.of(context).size.height-200.0),
                        child: new Scaffold(
                          body :futureBuilder
                        ),
                      )




                ],

          ),
        ),
         // )
      );
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

    if(items[index].userSubRightBean==null){
      return getContainer(items[index]);
    }
    else{
      return getExpansionParentTile(items[index]);
    }

  }


  void filterList(String val) async {
    // print("inside filterList");
    items.clear();
    items = new List<UserRightBean>();

    storedItems.forEach((obj) {
      if (obj.menuDesc
          .toString()
          .toUpperCase()
          .contains(val.toUpperCase()) |
      obj.menuid.toString().contains(
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

  void showMessageWithoutProgress(String message,
      [MaterialColor color = Colors.red]) {
    try {
      _scaffoldHomeState.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldHomeState.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }



  Widget getContainer(UserRightBean userRightBean){
    return     new GestureDetector(
      onTap: () async {

        if(userRightBean.mchartid==0||userRightBean.mchartid==null){
          showMessageWithoutProgress("Chart ID Not Available");
          return;
        }
        _ShowProgressInd(context);
              bool netAvail = false;

        await AppDatabaseExtended.get()
            .getSelectedChartDetails(userRightBean.mchartid)
            .then((ChartsBean ChartBeanObj) async {
          netAvail = await obj.checkIfIsconnectedToNetwork();

          if (widget.requestedPage == "graphlist") {
            if (netAvail == false &&
                ChartBeanObj.mdatasource.toLowerCase() != 'tablet') {
              showMessageWithoutProgress("Network Not available");
              Navigator.of(context).pop();
              return;
            }
            ChartBeanObj.chartSampleData =
                await GraphUtils.getChartSampleData(ChartBeanObj);
            Navigator.of(context).pop();
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => GraphMasterTab(
                      chartPassedObject:
                          ChartBeanObj)), //When Authorized Navigate to the next screen
            );
          } else {
            dateMap = new Map<String, DateTime>();
            if (netAvail == false &&
                ChartBeanObj.mdatasource.toLowerCase() != 'tablet') {
              showMessageWithoutProgress("Network Not available");
              Navigator.of(context).pop();
              return;
            }
            if (userRightBean.menutype == 'Reports') {
              ReportUtils reportUtilsObj = new ReportUtils();

              DataRecords dataRecords =
                  await reportUtilsObj.getChartSampleData(ChartBeanObj);

              Navigator.of(context).pop();
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => ReportMasterTab(
                        chartBean: ChartBeanObj,
                        dataRecords:
                            dataRecords)), //When Authorized Navigate to the next screen
              );
            } else {
              createWidget(userRightBean, ChartBeanObj);
            }
          }
        });
      },
      child: new Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              //color: Colors.blue[100]


          ),
          //color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                    " ${userRightBean.menuDesc}",style: TextStyle(fontSize: 20.0,color: Color(0xff07426A)),),
                new Row(
                  children: <Widget>[
                    new IconButton(icon: Icon(Icons.arrow_forward_ios ,size: 20.0,), onPressed: null,iconSize: 10.0,)
                    //new Text(" ${userRightBean.menuid}")
                  ],
                ),
              ],
            ),
          )),
    );

  }


  Widget getExpansionParentTile(UserRightBean userRightBean){
    bool isExpansionTileNeeded= false;
    List<Widget> widgetList =new List<Widget>();

    if(userRightBean.userSubRightBean!=null){
      for(UserRightBean userSingleObj in userRightBean.userSubRightBean ){
        if(userSingleObj.userSubRightBean==null){
          widgetList.add(getContainer(userSingleObj));
        }else{

          widgetList.add(getExpansionParentTile(userSingleObj));
        }

      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xff07426A),
          child: Text('${userRightBean.menuDesc.substring(0, 1)}'),
          foregroundColor: Colors.white,
        ),
        title: new Text(
          userRightBean.menuDesc,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        children: widgetList,
      ),
    );
  }

  String _RadioButtons = TablesColumnFile.EXCEL;
  createWidget(UserRightBean userRightBean, ChartsBean chartBeanObj) {
    List<String> keyList = new List<String>();

    chartBeanObj.mquery.splitMapJoin((new RegExp(r'(?<=#{)(.*?)(?=})')),
        onMatch: (m) {
      keyList.add(m.group(0));
      return '${m.group(0)}';
    }, onNonMatch: (n) {
      //print(n);
      return ('*');
    });

    AppDatabaseExtended.get()
        .getReportFilterList(keyList, chartBeanObj.mchartid)
        .then((List<ReportMasterEntity> reportFilterList) {
      if (reportFilterList.length != keyList.length) {
        showMessageWithoutProgress("Not Matching Length");
      }

      Navigator.of(context).pop();
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => ReportGeneration(
                  reportMasterList: reportFilterList,
                  chartBeanpassedObj: chartBeanObj)));

      return;

      List<Widget> widgetList2 = new List<Widget>();
      for (int i = 0; i < reportFilterList.length; i++) {
        Widget temp = getWidget(reportFilterList[i], chartBeanObj);
        if (temp != null) widgetList2.add(temp);
      }

      widgetList2.add(Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: new Container(
          child: new RaisedButton(
            onPressed: () async {
              final FormState form = _formKey.currentState;
              form.save();
              //print("Replacing #{FORMAT}  from  $_RadioButtons ");
              chartBeanObj.mquery =
                  chartBeanObj.mquery.replaceFirst("#{FORMAT}", _RadioButtons);
              // print(chartBeanObj.mquery);

              print(dateMap);
              dateMap.forEach((String val, DateTime date) {
                chartBeanObj.mquery = chartBeanObj.mquery.replaceFirst(
                    "#{" + val + "}",
                    TablesColumnFile.secondFormat.format(date));
              });

              print(chartBeanObj.mquery);

              if (_RadioButtons == TablesColumnFile.HTML) {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            webViewTester(url: chartBeanObj.mquery)));
              } else {
                await launch(chartBeanObj.mquery);
              }
            },
            child: const Text(
              "Generate",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ));

      showAlert(context, widgetList2, chartBeanObj.mtitle);
    });
  }

  Widget getWidget(ReportMasterEntity repoEntity, ChartsBean chartBean) {
    var func = (String val, String FieldName) {
      print("Replacing ${val}  from  $FieldName ");
      chartBean.mquery =
          chartBean.mquery.replaceFirst("#{" + FieldName + "}", val);
    };

    if (repoEntity.mfieldid == 1) return getTextField(repoEntity, func);
    if (repoEntity.mfieldid == 2) {
      try {
        date = DateTime.parse(repoEntity.mdefaultval);
      } catch (_) {
        date = DateTime.now();
      }
      dateMap[repoEntity.reportFilterComposite.mfieldname] = date;
      return getDateTiemField(repoEntity, func, date);
    }

    //else if (repoEntity.mfieldid == 3) return getRadioButtons(repoEntity);
  }

  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  Future<void> showAlert(
      BuildContext context, List<Widget> widgetList2, String chartTitle) async {
    print("widgetList is ${widgetList2}");
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(chartTitle),
          content: SingleChildScrollView(
              child: new Form(
                  key: _formKey,
                  child: new Column(
                    children: <Widget>[
                      RadioListTile<String>(
                        title: const Text("PDF"),
                        value: TablesColumnFile.PDF,
                        groupValue: _RadioButtons,
                        onChanged: (String value) {
                          setState(() {
                            print("Setting Radio Button to PDF");
                            _RadioButtons = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text("EXCEL (Download)"),
                        value: TablesColumnFile.EXCEL,
                        groupValue: _RadioButtons,
                        onChanged: (String value) {
                          print("Setting Radio Button to PDF");
                          setState(() {
                            _RadioButtons = value;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text('HTML'),
                        value: TablesColumnFile.HTML,
                        groupValue: _RadioButtons,
                        onChanged: (String value) {
                          setState(() {
                            print("Setting Radio Button to PDF");
                            _RadioButtons = value;
                          });
                        },
                      ),
                      new Column(children: widgetList2)
                    ],
                  ))),
        );
      },
    );
  }

  Widget getTextField(ReportMasterEntity repo, func) {
    return new TextFormField(
      onSaved: (String val) {
        func(val, repo.reportFilterComposite.mfieldname);
      },
      initialValue: repo.mdefaultval,
      decoration:
          InputDecoration(labelText: repo.mdisplay, hintText: repo.mdisplay),
    );
  }

//  Widget getRadioButtons(ReportMasterEntity repo) {
//    return Column(
//      children: <Widget>[
//        RadioListTile<String>(
//          title: const Text("PDF"),
//          value: TablesColumnFile.PDF,
//          groupValue: _RadioButtons,
//          onChanged: (String value) {
//            setState(() {
//              print("Setting Radio Button to PDF");
//              _RadioButtons = value;
//            });
//          },
//        ),
//        RadioListTile<String>(
//          title: const Text("EXCEL (Download)"),
//          value: TablesColumnFile.EXCEL,
//          groupValue: _RadioButtons,
//          onChanged: (String value) {
//            print("Setting Radio Button to PDF");
//            setState(() {
//              _RadioButtons = value;
//            });
//          },
//        ),
//        RadioListTile<String>(
//          title: const Text('HTML'),
//          value: TablesColumnFile.HTML,
//          groupValue: _RadioButtons,
//          onChanged: (String value) {
//            setState(() {
//              print("Setting Radio Button to PDF");
//              _RadioButtons = value;
//            });
//          },
//        ),
//      ],
//    );
//  }

  Widget getDateTiemField(ReportMasterEntity repo, func, DateTime defaultdate) {
    return DateTimeField(
      format: TablesColumnFile.format,
      initialValue: defaultdate,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: defaultdate,
            lastDate: DateTime.now());
      },
      onChanged: (DateTime val) {
        if (val != null) {
          dateMap[repo.reportFilterComposite.mfieldname] = val;
        }
      },
    );
  }
}
