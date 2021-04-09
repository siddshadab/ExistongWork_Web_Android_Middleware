import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/reports/ConfiguredRreportsBean.dart';
import 'package:eco_mfi/pages/reports/DisplayReportsInTabularFormat.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/tablesDisplay/DisplayTablesData.dart';
import 'package:flutter/cupertino.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/AddGuarantor.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'package:eco_mfi/Utilities/globals.dart' as globals;


class ConfiguredReportsList extends StatefulWidget {

  ConfiguredReportsList();
  @override
  _ConfiguredReportsList createState() => new _ConfiguredReportsList();
}

class _ConfiguredReportsList extends State<ConfiguredReportsList> {
  static const JsonCodec JSON = const JsonCodec();

  var listWidget =null;
  var listColumnWidget =null;
  var dummyRow =null;
  var dummyColumn =null;

  ChartsBean chartsBean = new ChartsBean();
  List<ChartsBean> items = new List<ChartsBean>();
  List<ChartsBean> storedItems =  new List<ChartsBean>();
  Widget appBarTitle = new Text("Configured Reports");
  List<bool> questionCheck;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrCode;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  int branch = 0;
  CustomerListBean customerListBean;
  int count=1;

  Icon actionIcon = new Icon(Icons.search);
  @override
  void initState() {
    items.clear();
    super.initState();
    getSessionVariables();
  }

  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(TablesColumnFile.usrCode);
      usrCode = prefs.getString(TablesColumnFile.usrCode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      branch = prefs.getInt(TablesColumnFile.musrbrcode);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
    });
  }

  getHomePageBody(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data != null) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: _getItemUI,
        padding: EdgeInsets.all(0.0),
      );
    }
  }

  Widget _getItemUI(BuildContext context, int index) {
    double c_width = MediaQuery.of(context).size.width * 10;


    return new GestureDetector(
      onTap: () {
        _onTapItem(items[index]);
      },
      child: new Card(
        //color Color(0xff2f1f4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 25.0,
        child: new Padding(
          padding: new EdgeInsets.only(
            left: 3.0,
            right: 3.0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 3.0),

                // width: c_width,
                child: Container(
                  decoration: new BoxDecoration(
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
                  ),
                  //color: color,
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "  ${items[index].mtitle.toUpperCase()}",
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
                            children: <Widget>[
                              Text(
                                Translations.of(context).text('trefNo')+
                                    items[index].trefno.toString() +
                                    "   ",
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                              ),

                              Padding(
                                padding: new EdgeInsets.only(
                                    left: 30.0, right: 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      items[index].mtitle,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellowAccent),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      new Container(
                          padding: EdgeInsets.only(left: 5.0),
                          //color: Colors.green,
                          child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              Padding(
                                  padding: new EdgeInsets.only(
                                      left: 1.0, right: 10.0),
                                  child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceAround,

                                    children: <Widget>[
                                      Text(
                                        Translations.of(context).text('National_ID') +
                                            items[index]
                                                .mtitle
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              new Container (
                child: new Row (
                  children: [
                    new Expanded(
                      child: new Text (items[index].mtitle!=null&&items[index].mtitle.toString()!=""&&items[index].mtitle.toString()!="null"?items[index].mtitle.toString():'',
                        style: TextStyle(
                            fontSize: 12.0, color: Colors.red[500]),
                      ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration (
                  // backgroundColor: Colors.grey[300],
                ),
                width: 400.0,
              ),
              new Container(
                width: c_width,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 8.0,
                            ),
                            new Padding(
                              padding: new EdgeInsets.only(
                                top: 1.0,
                                bottom: 1.0,
                              ),
                              child: new Row(
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  new Text(
                                    Translations.of(context).text('CUSTOMERNUMBER') +"${items[index].mtitle}",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    Translations.of(context).text('contactNo')+"${items[index].mtitle}" ,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    var loanDetailsBuilder;

    if (/*storedItems.isEmpty||storedItems==null*/ count == 1 || count == 2) {
      count++;
      //  //print("inside case 1 ");
      loanDetailsBuilder = new FutureBuilder(

          future: AppDatabase.get().getChartsDetailsList('999').then(
                  (List<ChartsBean> chartsBean) async{
                items.clear();
                storedItems.clear();
                chartsBean.forEach((f) async{
                  storedItems.add(f);
                  items.add(f);
                  setState(() {

                  });
                  //storedItems.add(f);
                });
                return items;
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
                  return new Text(Translations.of(context).text('error') +"${snapshot.error}");
                else {
                  //  print("trying to run homepage");
                  return getHomePageBody(context, snapshot);
                }
            }
          });
    } else if (storedItems != null) {
      loanDetailsBuilder = ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, position) {
            double c_width = MediaQuery.of(context).size.width * 10;

            return new GestureDetector(
              onTap: () {
                _onTapItem(items[position]);
              },
              child: new Card(
                //color Color(0xff2f1f4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 25.0,
                child: new Padding(
                  padding: new EdgeInsets.only(
                    left: 3.0,
                    right: 3.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 3.0),

                        // width: c_width,
                        child: Container(
                          decoration: new BoxDecoration(
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
                          ),
                          //color: color,
                          child: Column(
                            children: <Widget>[
                              new Text(
                                "  ${items[position].mtitle.toUpperCase()}",
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              new Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  //color: Colors.green,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        Translations.of(context).text('trefNo') +
                                            items[position].trefno.toString() +
                                            "   ",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white),
                                      ),

                                      Padding(
                                        padding: new EdgeInsets.only(
                                            left: 30.0, right: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              items[position].mtitle ,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.yellowAccent),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                              new Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  //color: Colors.green,
                                  child: Row(
                                    children: <Widget>[

                                      Padding(
                                          padding: new EdgeInsets.only(
                                              left: 1.0, right: 10.0),
                                          child: Row(

                                            children: <Widget>[

                                            ],
                                          )
                                      ),

                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                      new Container (
                        child: new Row (
                          children: [
                            new Expanded(
                              child: new Text (items[position].mquery!=null&&items[position].mquery.toString()!=""&&items[position].mquery.toString()!="null"?items[position].mquery.toString():'',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.red[500]),
                              ),
                            ),
                          ],
                        ),
                        decoration: new BoxDecoration (
                          // backgroundColor: Colors.grey[300],
                        ),
                        width: 400.0,
                      ),
                      new Container(
                        width: c_width,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(
                                        top: 1.0,
                                        bottom: 1.0,
                                      ),
                                      child: new Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                        children: <Widget>[
                                          new Text(
                                            Translations.of(context).text('CUSTOMERNUMBER')+"${items[position].mkey}" ,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            Translations.of(context).text('contactNo')+"${items[position].mkey}" ,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    // TODO: implement build
    return new Scaffold(
      key: _scaffoldHomeState,
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff07426A),
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
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: Translations.of(context).text('Search'),
                        hintStyle: new TextStyle(color: Colors.white)),
                    onChanged: (val) {
                      filterList(val.toLowerCase());
                    },
                  );
                }
                else {
                  String svngListLeng = storedItems != null &&
                      storedItems.length != null &&
                      storedItems.length > 0
                      ? "/" + storedItems.length.toString()
                      : "";
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle =
                  new Text(Translations.of(context).text('Savings_List') + svngListLeng);
                  items = new List<ChartsBean>();
                  items.clear();
                  storedItems.forEach((val) {
                    items.add(val);
                  });
                }
              });
            },
          ),
        ],
      ),

      body: loanDetailsBuilder,
    );
  }

  void _onTapItem(ChartsBean item)  async{
    await generateDataListToDisplay(item);
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new DisplayReportsInTabularFormat(listWidget:listWidget,listColumnWidget:listColumnWidget ,dummyRow:dummyRow ,dummyColumn:dummyColumn )), //When Authorized Navigate to the next screen
    );
  }

  void filterList(String val) async {
    items.clear();
    storedItems.forEach((obj) {

    });
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

  Future<Null> getTabularDataInColumnsCaptions(List<String> captions/*String variable*/) async{
    // if(listWidget==null){
    listWidget =new List<DataRow>();
    //}

    //if(listColumnWidget ==null){
    listColumnWidget=new List<DataColumn>();
    //}

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

  Future<Null> getTabularDataRows(String rows) async{
    if(listWidget==null){
      listWidget =new List<DataRow>();
    }


    var values = rows.toString().split(",");
    print("valuesxxxxxxxxxxxxx  ${values}");
    List<DataCell> cellList =new List<DataCell>();
    for(int val =0;val<values.length;val++){
      String valDisp = values[val].replaceAll(RegExp(r'.*:'), "");
      print("valDisp  ${valDisp}");
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


  Future<Null> generateDataListToDisplay(ChartsBean bean) async{

    if(bean.mdatasource=='TABLET') {
      await AppDatabase.get()
          .selectTableName(
          bean.mquery != null && bean.mquery != 'null' && bean.mquery != ''
              ? bean.mquery
              : "select * from customerFoundationMasterDetails")
          .then((var customerData) async{
        List<String> captions = new List<String>();
        for (var atn in customerData) {
          var values = atn.toString().split("}");
          // print("values[0] xxxxxxxxxxxxxxxxxx ${values[0]}");
          String str = values[0];
          str = str.replaceAll("{", "");
          str = str.replaceAll("}", "");
          ////print("str xxxxxxxxxxxxxxxxxx ${str}");
          var values2 = str.toString().split(",");
          for (int val = 0; val < values2.length; val++) {
            captions.add(values2[val]);
          }
          //print("captions xxxxxxxxxxxxxxxxxx ${captions}");
          break;
        }
        await getTabularDataInColumnsCaptions(captions);

        for (var items in customerData) {
          //print(" items ${items}");
          //var values = items.toString().split(",");
          //for(int val =0;val<values.length;val++){
          await  getTabularDataRows(items.toString());

          //}
        }

        setState(() {

        });
      });
    }else{
      await getOnlineData(bean);
    }
  }
  static final _headers = {'Content-Type': 'application/json'};
  var url = "DataSourceResult/getQueryResult";

  Future<Null> getOnlineData(ChartsBean bean) async{
    //print("Data after UserValutBalance UserValutBalance UserValutBalance  1");
    //try {
    String json2 = await _tojsonObj(bean);
    final bodyValue = await NetworkUtil.callPostService(json2,Constant.apiURL.toString()+url.toString(),_headers);
    //print(" bodyValue ${bodyValue}");
    if(bodyValue==null ||bodyValue=='null'|| bodyValue == '' || bodyValue == "error"){
      return null;
    }
    //print("Data after System parameter service  " + bodyValue);
    List<ConfiguredRreportsBean> configuredRreportsBean = new List<ConfiguredRreportsBean>();
    configuredRreportsBean=  await _froJsontoBean(bodyValue);
    //print("obj ${configuredRreportsBean.toString()}");

    List<String> captions = new List<String>();
    // for (var atn in configuredRreportsBean) {
    var values = configuredRreportsBean[0].values.toString().split("}");
    //print("values[0] xxxxxxxxxxxxxxxxxx ${values[0]}");
    String str = values[0];
    str = str.replaceAll("{", "");
    str = str.replaceAll("}", "");
    //print("str xxxxxxxxxxxxxxxxxx ${str}");
    var values2 = str.toString().split(",");
    for (int val = 0; val < values2.length; val++) {
      captions.add(values2[val]);
    }
    //print("captions xxxxxxxxxxxxxxxxxx ${captions}");
    // break;
    //}
    await  getTabularDataInColumnsCaptions(captions);

    //for (var items in configuredRreportsBean) {
    //print(" configuredRreportsBean[0].values ${configuredRreportsBean[0].values}");
    //var values = items.toString().split(",");
    //for(int val =0;val<values.length;val++){
    var splitedVal = configuredRreportsBean[0].values.toString().split("}");


    for(int val =0;val<splitedVal.length-1;val++) {
      await getTabularDataRowsOnline(splitedVal[val]);
    }


    //}
    //}

    /*} catch (e) {
      //print('Server Exception!!!');

    }*/

  }


  Future<String> _tojsonObj(ChartsBean bean) async{
    var mapData = new Map();
    mapData[TablesColumnFile.msystemid] = bean.mdatasource;
    mapData[TablesColumnFile.murl] = bean.mquery;

    String json = JSON.encode(mapData);
    //print(json.toString());
    return json;
  }


  Future<List<ConfiguredRreportsBean>> _froJsontoBean(String json) async{

    List<ConfiguredRreportsBean> listBean = new List<ConfiguredRreportsBean>();
    List list = JSON.decode(json);
    for (int i = 0; i < list.length; i++) {
      //print("jsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjson"+list.toString());
      var bean  =  ConfiguredRreportsBean.fromMapMiddleware(list[i]);
      // var bean = LookupMasterBean.fromJson(list[i]);
      listBean.add(bean);
    }
    return listBean;
  }



  Future<Null> getTabularDataRowsOnline(String rows) async{
    if(listWidget==null){
      listWidget =new List<DataRow>();
    }


    var values = rows.toString().split(",");
    //print("valuesxxxxxxxxxxxxx  ${values}");
    List<DataCell> cellList =new List<DataCell>();
    for(int val =0;val<values.length;val++){
      String valDisp = values[val].replaceAll(RegExp(r'.*:'), "");
      //print("valDisp  ${valDisp}");
      cellList.add( new DataCell(
        new Text(
          valDisp,
          style: TextStyle(),
        ),
      ),);
      //  }

      //getTabularDataRows();
    }

    //print("cellList.length cellList.length cellList.length ${cellList.length}");
    listWidget.add(new DataRow(cells:cellList,));


    //  listColumnWidget.add(cellList);

    setState(() {

    });
  }



}




