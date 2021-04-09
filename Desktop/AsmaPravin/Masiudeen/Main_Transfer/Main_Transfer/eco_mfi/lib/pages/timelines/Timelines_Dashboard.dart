
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/ChartsUtils.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_line_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
import 'package:eco_mfi/pages/timelines/DisplayChartsInd.dart';

import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

import 'package:shared_preferences/shared_preferences.dart';


import 'ChartsBean.dart';
import 'DashBoardNewArchitect/chart/circular_charts/pie_series/default_pie_chart.dart';
/*import 'SimpleScatterPlotCharts.dart';
import 'SimpleTimeSeriesCharts.dart';*/
import 'package:eco_mfi/Utilities/app_constant.dart';


class Timelines_Dashboard extends StatefulWidget {
  Timelines_Dashboard({Key key, this.title}) : super(key: key);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  final String title;

  @override
  _Timelines_DashboardState createState() => new _Timelines_DashboardState();
}

class _Timelines_DashboardState extends State<Timelines_Dashboard> {

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  String _view = 'Month';
  int loanNumber;
  int branch;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usercode;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
   bool _dialVisible =true;
  int count=1;
  List<ChartsBean> items = new List<ChartsBean>();
  List<ChartsBean> storedItems =  new List<ChartsBean>();
  Widget appBarTitle = new Text("Charts Details");

  Icon actionIcon = new Icon(Icons.search);
  List chartsList = new List();
  LookupBeanData chartType;

  var currentTime = DateFormat('dd/MM/yyyy').format(DateTime.now());
  int selection = 0;
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {



    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropDownCaptionValuesCOdeKeysChartsType[no].length;
    k++) {
      mapData.add(globals.dropDownCaptionValuesCOdeKeysChartsType[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(
          value.mcodedesc,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    }).toList();

    return _dropDownMenuItems1;
  }


  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0),
        child: new Row(
          children: <Widget>[
            new Text(
              textName[i],
              textAlign: TextAlign.right,
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontStyle: FontStyle.normal,
                fontSize: 12.0,
              ),
            ),
            new Radio(
              value: i,
              groupValue: chartsTypeRadios[position],
              onChanged: (selection) => _onRadioSelected(selection, position),
              activeColor: Color(0xff07426A),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ));
    }
    return radios;
  }

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        //textDirection: TextDirection,
        textAlign: TextAlign.start,
        /*overflow: TextOverflow.ellipsis,*/
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
      ),
    );
  }

  static List<int> chartsTypeRadios = new List<int>(1);

  _onRadioSelected(int selection, int position) {
    setState(() => chartsTypeRadios[position] = selection);
    if (position == 0) {
      selection = selection;
    }
  }

  @override
  void initState() {
    super.initState();
    getSessionVariables();

  }





  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode);
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      usercode = prefs.getString(TablesColumnFile.musrcode);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      try{
        geoLatitude = prefs.getDouble(TablesColumnFile.geoLatitude).toString();
        geoLongitude = prefs.getDouble(TablesColumnFile.geoLongitude).toString();
      }catch(_){
        print("Exception in getting loangitude");
      }


    });
  }


  LookupBeanData blankBean =
  new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);
  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      switch (no) {
        case 0:
          chartType = blankBean;
          //CustomerFormationMasterTabsState.custListBean.mHouse = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {});
    } else {
      for (int k = 0;
      k < globals.dropDownCaptionValuesCOdeKeysChartsType[no].length;
      k++) {
        if (globals.dropDownCaptionValuesCOdeKeysChartsType[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropDownCaptionValuesCOdeKeysChartsType[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      switch (no) {
        case 0:
          chartType = blankBean;
          break;
        default:
          break;
      }
    });
  }



  @override
  Widget build(BuildContext context) {

    var chartsBuilder;

    if (count == 1 ) {
      count++;
      chartsBuilder = new FutureBuilder(
          future: AppDatabase.get().getChartsDetailsList('0').then(
                  (List<ChartsBean> chartsBean) async{
                items.clear();
                storedItems.clear();
                chartsBean.forEach((f) async{


                  print("fffffffffffffffffffff ${f}");
                  await replacekeywords(f);
                  await ChartsUtils.getCharts(f);
                  print("f.chartType ${f.chartType}");
                  if(f.chartType !=null) {
                    items.add(f);
                    setState(() {

                    });
                  }
                  if(f.chartType !=null) {
                    storedItems.add(f);
                  }
                  //storedItems.add(f);
                });
                return items;
              }).then((onValue){
            setState(() {
            });
          }),

          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new Center(child:new Text('Please wait while list gets load'));
              case ConnectionState.waiting:
                return new Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child:
                    new CircularProgressIndicator()); // new Text('Awaiting result...');
              default:
                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return new Center(
                    child: new Text("Nothing to display on your filter"),
                  );
                }      else {
                  return getHomePageBody(context, snapshot);
                }
            }
          });
    } else if (storedItems != null) {
      chartsBuilder = ListView.builder(
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, position) {
            //  double c_width = MediaQuery.of(context).size.width * 10;


            return  new Padding(
                padding: new EdgeInsets.only(
                    left: 3.0,
                    right: 3.0,
                    bottom: 5.0,
                    top: 20.0
                ),
              //new Card(
              child:_buildTileWid(
                items[position],
                new Padding(
                    padding: new EdgeInsets.only(
                        left: 3.0,
                        right: 3.0,
                        bottom: 5.0,
                        top: 5.0
                    ),
                    child: Column(

                      children: <Widget>[


                        Container(
                          padding: EdgeInsets.only(top: 3.0),

                          // width: c_width,
                          child: Container(
                          /*  decoration: new BoxDecoration(
                              gradient: new LinearGradient(
                                  colors: [
                                    ThemeDesign.loginGradientEnd,
                                    ThemeDesign.loginGradientStart,
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.circular(6.0),
                            ),*/
                            //color: color,
                            child: Column(
                              children: <Widget>[
                                new Text(
                                  items[position].mtitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                new Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    //color: Colors.green,
                                    child: new Row(

                                      children: <Widget>[
                                        Text("xx",

                                          //items[position].status,
                                            style: TextStyle(
                                                fontSize: 12.0, color: Colors.black),
                                          ),

                                        Text("yy",

                                          //items[position].mquerydesc ,
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black),
                                        ),
                                        Padding(
                                          padding: new EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Row(
                                            children: <Widget>[

                                              Text(
                                                items[position].mdatasource,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                              ),

                                              Padding(
                                                padding: new EdgeInsets.only(
                                                    left: 30.0, right: 30.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    new Text(
                                                      items[position].mchartid.toString(),
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),

                    SingleChildScrollView(child: new Container(

                    child: items[position].chartType,
                    ),

                    ),

                    ],)
                ),

              ),

            );
          });
    }

    // TODO: implement build
    return   new Scaffold(
        key: _scaffoldHomeState,
      floatingActionButton:  SpeedDial(
        child: Icon(Icons.add),
        visible: _dialVisible,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.accessibility),
              backgroundColor: Colors.red,
              label: 'First',
              // labelStyle: TextTheme(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: Colors.blue,
            label: 'Second',
            //   labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Colors.green,
            label: 'Third',
            // labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
      body:chartsBuilder,);
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
    double c_width = MediaQuery.of(context).size.width * 10;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return _buildTileWid(
        items[index],
        new Padding(
          padding: new EdgeInsets.only(
              left: 3.0,
              right: 3.0,
              bottom: 5.0,
              top: 5.0
          ),

        child: new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[
           /* new Container(child: Text("DataHereIs"),),
            new Container(child: Text("DataHereIs"),),
            new Container(child: Text("DataHereIs"),),
            new Container(child: Text("DataHereIs"),),*/
              new Container(
                width: width,
                height: height,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                        width: c_width,
                        child: Column(children: <Widget>[
                          items[index].chartType,
                          //new Text("Something")
                        ],)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  void filterList(String val) async {


  }




  replacekeywords(ChartsBean f) async{
    //replace codes here
    try {
      f.mquery = f.mquery.replaceAll("LOGINUSER", usercode);
      f.mquery = f.mquery.replaceAll("BRANCHUSER", branch.toString());
      f.mquery = f.mquery.replaceAll("LOGINUSER", usercode);
      f.mquery = f.mquery.replaceAll("LOGINUSER", usercode);
      f.mquery = f.mquery.replaceAll("LOGINUSER", usercode);
    }catch(_){}

  }


  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 20.0,
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
              print('Not set yet');
            },
            child: child));
  }


  Widget getDataRowHere(ChartsBean bean){
    return


      Container(
          height: 100.0,
          child: SingleChildScrollView(

            scrollDirection: Axis.vertical,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: bean.dataTextForm!=null?bean.dataTextForm:new Text(""),

            ),));



  }

  /*List<Widget> wid ;
  addSimpleList(ChartsBean bean) async{

    wid = new List<Widget>();
    wid.add( Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[

        new Text(bean.mycatg.toString()),
        SizedBox(width: 10.0,),
        new  Text(bean.mycatg.toString()),
      ],

    ));


    for(int listItem=0;listItem<bean.simpleBarChartBean.length;listItem++){
      wid.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              new Text(bean.simpleBarChartBean[listItem].yAxis.toString()),
              SizedBox(width: 10.0,),
              new  Text(bean.simpleBarChartBean[listItem].xAxis.toString()),
            ],

          )


      );
    }


    bean.dataTextForm=wid;

  }
*/



 /* addNumList(ChartsBean bean) async{

    wid = new List<Widget>();
    wid.add( Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[

        new Text(bean.mycatg.toString()),
        SizedBox(width: 10.0,),
        new  Text(bean.mycatg.toString()),
      ],

    ));
    for(int listItem=0;listItem<bean.numTypeBean.length;listItem++){
      wid.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              new Text(bean.numTypeBean[listItem].yAxis.toString()),
              SizedBox(width: 10.0,),
              new  Text(bean.numTypeBean[listItem].xAxis.toString()),
            ],

          )


      );
    }


    bean.dataTextForm=wid;

  }*/


  void _onTapItem(BuildContext context, ChartsBean item) async{



//      Navigator.push<Widget>(
//        context,
//        // ignore: always_specify_types
//        MaterialPageRoute(builder: (BuildContext context) => DisplayChartsInd(chartsBean: item)),
//      );

  }

  Widget _buildTileWid(ChartsBean bean,Widget child) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell
          (
            onTap: () {
              // globals.customerNumber = items[position].trefno.toString();
              _onTapItem(context, bean);
            },
            child: child
        )
    );
  }

}


final List<String> _viewList =
<String>[
  'Day',
  'Week',
  'Work week',
  'Month',
  'Timeline day',
  'Timeline week',
  'Timeline work week'
].toList();
