import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/reports/ConfiguredRreportsBean.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportUtils {
  static const JsonCodec JSON = const JsonCodec();
  DataRecords dataRecords = new DataRecords();

  String replacekeywords(
      String f, String usercode, int lbrcode, int grpcd, DateTime opernDate) {
    //replace codes here

    f = f.replaceAll("LOGINUSER", usercode);
    f = f.replaceAll("USRBRANCHCODE", lbrcode.toString());
    f = f.replaceAll("OPRNDATE", opernDate.toString());
    f = f.replaceAll("SYSDATE", DateTime.now().toString());
    f = f.replaceAll("USRGROUPPCODE", grpcd.toString());
    return f;
  }

  Future<DataRecords> getChartSampleData(ChartsBean charttype) async {
    // double height = MediaQuery.of(context).size.height;

    dataRecords.listRowWidget = null;
    dataRecords.listColumnWidget = null;
    if (charttype != null) {
      //SubItem sample = new SubItem();
      /* sample.chartSampleData = charttype.chartSampleData;
      sample.chartSampleData[0].title = charttype.mtitle;*/

      if (charttype.mdatasource.toLowerCase() == 'tablet') {
        SharedPreferences pref = await SharedPreferences.getInstance();
        DateTime operationDate;

        try {
          operationDate = DateTime.parse(
              pref.getString(TablesColumnFile.branchOperationalDate));
        } catch (_) {
          operationDate = DateTime.now();
        }

        //print("User Code is ${pref.getString(TablesColumnFile.musrcode)}");
        //print(pref.getInt(TablesColumnFile.musrbrcode));
        //print(pref.getInt(TablesColumnFile.grpCd));

        charttype.mquery = await replacekeywords(
            charttype.mquery,
            pref.getString(TablesColumnFile.musrcode),
            pref.getInt(TablesColumnFile.musrbrcode),
            pref.getInt(TablesColumnFile.grpCd),
            operationDate);

//        if (charttype.mtype == 'xy') {
//          return await AppDatabaseExtended.get().getQuerySimpleChart(charttype);
//        } else if (charttype.mtype == 'xyy') {
//          return await AppDatabaseExtended.get().getQueryLineChart(charttype);
//        } else if (charttype.mtype == 'xyn') {
//          return await AppDatabaseExtended.get().getQueryLineChart(charttype);
//        }
      } else {
        return await getOnlineData(charttype);
      }
    }
  }

  Future<String> _tojsonObj(ChartsBean bean) async {
    var mapData = new Map();
    mapData[TablesColumnFile.msystemid] = bean.mdatasource;
    SharedPreferences pref = await SharedPreferences.getInstance();
    DateTime operationDate;

    try {
      operationDate = DateTime.parse(
          pref.getString(TablesColumnFile.branchOperationalDate));
    } catch (_) {
      operationDate = DateTime.now();
    }

    //print("User Code is ${pref.getString(TablesColumnFile.musrcode)}");
    //print(pref.getInt(TablesColumnFile.musrbrcode));
    //print(pref.getInt(TablesColumnFile.grpCd));

    bean.mquery = await replacekeywords(
        bean.mquery,
        pref.getString(TablesColumnFile.musrcode),
        pref.getInt(TablesColumnFile.musrbrcode),
        pref.getInt(TablesColumnFile.grpCd),
        operationDate);
    mapData[TablesColumnFile.murl] = bean.mquery;

    String json = JSON.encode(mapData);
    //print(json.toString());
    return json;
  }

  static ChartSampleData setBeanValueHere(
      ChartsBean bean, String splitedVal, int loopValue) {
    //List<ChartSampleData> salesDataList = new List<ChartSampleData>();
    ChartSampleData salesData = new ChartSampleData();
    //{XA: Business Loan, YA : Advance Rental, value : 28}
    var values = splitedVal.toString().split(",");
    //[{XA: Business Loan ,
    //YA : Advance Rental
    // value : 28}]

//[XA: businnes Loan , YA: Advance for shop rental, Value 2.48]

    if (bean.mtype == 'xy') {
      if (loopValue == 0) {
        bean.categoryNames = new List<String>();
        // bean.categoryNames.add(values[0].substring(values[0].indexOf("{")+1,values[0].indexOf(":") ).trim());
        bean.categoryNames
            .add(values[1].substring(0, values[1].indexOf(":")).trim());
        bean.categoryNames.add(values[0]
            .substring(values[0].indexOf("{") + 1, values[0].indexOf(":"))
            .trim());
      }

      //  //print("xCatogory ki value hai ${RegExp(r'.*:')}");
      dynamic xcat = values[0].replaceAll(RegExp(r'.*:'), "");
      dynamic ycat = values[1].replaceAll(RegExp(r'.*:'), "");

      //print("xcat hai ${xcat}");
      //print("ycat hai ${ycat}");
      //xcat:  mrefmo 2
      //ycat: custstatus 1
      String xAxis = "";
      int yAxis = 0;
      // xcat = || xcat==0?"0":"";
      if (xcat != null) {
        switch (xcat.runtimeType) {
          case int:
            //print("X is Int ${xcat}");
            xAxis = xcat.toString();
            break;
          case String:
            //print("X is String");
            xAxis = xcat;
            break;
          default:
            //print("x is nothing");
            xAxis = xcat.toString();
            break;
        }
      } else {
        xAxis = "";
      }

      if (ycat != null && ycat != 'null') {
        switch (ycat.runtimeType) {
          case int:
            //print("Y is  Int");
            yAxis = ycat;
            break;
          case String:
            //print("Y is  String");
            try {
              yAxis = int.parse(ycat);
            } catch (_) {
              yAxis = 0;
            }

            break;
          default:
            //print("nothing");
            yAxis = int.parse(ycat);
            break;
        }
      } else {
        yAxis = 0;
      }

      salesData.xValue = xAxis == null ? 2 : xAxis;
      salesData.yValue = yAxis;
      //print("salesData salesData ${salesData}");
      //salesDataList.add(salesData);
    }

    if (bean.mtype == 'xyy') {
      if (loopValue == 0) {
        bean.categoryNames = new List<String>();
        bean.categoryNames
            .add(values[1].substring(0, values[0].indexOf(":")).trim());
        bean.categoryNames
            .add(values[2].substring(0, values[1].indexOf(":")).trim());
        bean.categoryNames.add(values[0]
            .substring(values[0].indexOf("{") + 1, values[0].indexOf(":"))
            .trim());
      }

      dynamic xcat = values[0].replaceAll(RegExp(r'.*:'), "");
      dynamic ycat = values[1].replaceAll(RegExp(r'.*:'), "");
      dynamic y2cat = values[2].replaceAll(RegExp(r'.*:'), "");
      //print("xcat hai ${xcat}");
      //print("ycat hai ${ycat}");
      //print("y2cat hai ${ycat}");
      //xcat:  mrefmo 2
      //ycat: custstatus 1
      String xAxis = "";
      int yAxis = 0;
      int y2Axis = 0;
      // xcat = || xcat==0?"0":"";
      if (xcat != null) {
        switch (xcat.runtimeType) {
          case int:
            //print("X is Int ${xcat}");
            xAxis = xcat.toString();
            break;
          case String:
            //print("X is String");
            xAxis = xcat;
            break;
          default:
            //print("x is nothing");
            xAxis = xcat.toString();
            break;
        }
      } else {
        xAxis = "";
      }

      if (ycat != null && ycat != 'null') {
        switch (ycat.runtimeType) {
          case int:
            //print("Y is  Int");
            yAxis = ycat;
            break;
          case String:
            //print("Y is  String");
            try {
              yAxis = int.parse(ycat);
            } catch (_) {
              yAxis = 0;
            }

            break;
          default:
            //print("nothing");
            yAxis = int.parse(ycat);
            break;
        }
      } else {
        yAxis = 0;
      }
      if (y2cat != null && y2cat != 'null') {
        switch (y2cat.runtimeType) {
          case int:
            //print("Y2 is  Int");
            y2Axis = y2cat;
            break;
          case String:
            //print("Y2 is  String");
            try {
              y2Axis = int.parse(y2cat);
            } catch (_) {
              y2Axis = 0;
            }

            break;
          default:
            //print("nothing");
            y2Axis = int.parse(y2cat);
            break;
        }
      } else {
        y2Axis = 0;
      }

      salesData.xValue = xAxis == null ? 2 : xAxis;
      salesData.yValue = yAxis;
      salesData.yValue2 = y2Axis;
      //print("salesData salesData ${salesData}");
      //salesDataList.add(salesData);
    } else if (bean.mtype == 'xyn') {
      bean.categoryNames = new List<String>();
      bean.categoryNames
          .add(values[1].substring(0, values[1].indexOf(":")).trim());
      bean.categoryNames
          .add(values[2].substring(0, values[2].indexOf(":")).trim());
      bean.categoryNames.add(values[0]
          .substring(values[0].indexOf("{") + 1, values[0].indexOf(":"))
          .trim());
      // //print("values ahi ${values} ");
      String xcat = values[0].replaceAll(RegExp(r'.*:'), "").trim();
      String ycat = values[1].replaceAll(RegExp(r'.*:'), "").trim();
      double y2cat = double.parse(values[2].replaceAll(RegExp(r'.*:'), ""));

      //xcat:  mrefmo 2
      //ycat: custstatus 1
      salesData.xValue = xcat == null ? 2 : xcat;
      salesData.yValue = ycat;
      salesData.yValue2 = y2cat;
      // //print("salesData salesData ${salesData}");
      //salesDataList.add(salesData);
    }

    return salesData;
  }

  static Future<List<ConfiguredRreportsBean>> _froJsontoBean(
      String json) async {
    List<ConfiguredRreportsBean> listBean = new List<ConfiguredRreportsBean>();
    List list = JSON.decode(json);
    for (int i = 0; i < list.length; i++) {
      // //print("jsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjson"+list.toString());
      var bean = ConfiguredRreportsBean.fromMapMiddleware(list[i]);
      // var bean = LookupMasterBean.fromJson(list[i]);
      listBean.add(bean);
    }
    return listBean;
  }

  Future<DataRecords> getOnlineData(ChartsBean bean) async {
    final _headers = {'Content-Type': 'application/json'};
    var url = "DataSourceResult/getQueryResult";
    //List<ChartSampleData> returnedSampleDate = new List<ChartSampleData>();

    // //print("Data after UserValutBalance UserValutBalance UserValutBalance  1");
    ///try {
    String json2 = await _tojsonObj(bean);
    final bodyValue = await NetworkUtil.callPostService(
        json2, Constant.apiURL.toString() + url.toString(), _headers);
    //  //print(" bodyValue ${bodyValue}");
    if (bodyValue == null ||
        bodyValue == 'null' ||
        bodyValue == '' ||
        bodyValue == "error") {
      return null;
    }
    // //print("Data after System parameter service  " + bodyValue);
    List<ConfiguredRreportsBean> configuredRreportsBean =
        new List<ConfiguredRreportsBean>();
    configuredRreportsBean = await _froJsontoBean(bodyValue);
    print("Configured Bean Length ${configuredRreportsBean.length}");

    // //print(" ye mera value hai ${configuredRreportsBean}");
    //{ XA: Business Loan, YA Advance Rental, value : 28} , {XA: Business Loan, YA : Advance Rental, value : 28} , }

    List<String> values =
        configuredRreportsBean[0].values.toString().split("}");
    print("Values is  ${values}");

    //[{ XA: Business Loan, YA Advance Rental, value : 28},
    // {XA: Business Loan, YA : Advance Rental, value : 28}]
    //  //print("values[0] xxxxxxxxxxxxxxxxxx ${values[0]}");
    String str =
        values[0]; //{ XA: Business Loan, YA Advance Rental, value : 28}
    str = str.replaceAll("{", "");
    str = str.replaceAll("}", "");

    // XA: Business Loan, YA Advance Rental, value : 28
    List<String> values2 = str.toString().split(","); //[XA: Business Loan
    // YA Advance Rental
    // value : 28 ]
    getTabularDataInColumnsCaptions(values2);
    for (String ab in values) {
      getTabularDataRows(ab);
    }

    return dataRecords;
    //} catch (e) {}
  }

  getTabularDataRows(String rows) {
    if (dataRecords.listRowWidget == null) {
      dataRecords.listRowWidget = new List<List<String>>();
    }
    List<String> addingList = new List<String>();

    if (rows == null || rows.trim() == '') return;
    var values = rows.toString().split(",");
    //print("Inside rows ${values}");
    print(" row length is ${values.length}");
    if (values.length == 1) print(values);

    //List<DataCell> cellList = new List<DataCell>();
    for (int val = 0; val < values.length; val++) {
      //print("Row Values hain ${values[val]}"); //val[0] = {trefno:1
      String valDisp =
          values[val].replaceAll(RegExp(r'.*:'), ""); //rmoving all befire :

      addingList.add(valDisp);
    }

    dataRecords.listRowWidget.add(addingList);
  }

  getTabularDataInColumnsCaptions(List<String> captions /*String variable*/) {
    if (dataRecords.listRowWidget == null) {
      dataRecords.listRowWidget = new List<List<String>>();
    }

    print("Column Length hai ${captions.length}");
    if (dataRecords.listColumnWidget == null) {
      dataRecords.listColumnWidget = new List<String>();
    }

    // List<DataColumn> cellList =new List<DataColumn>();
    print("captions.length captions.length captions.length ${captions.length}");
    for (int capt = 0; capt < captions.length; capt++) {
      String val = captions[capt]
          .replaceAll(RegExp(r':.*'), ""); //remove all After Colon

      dataRecords.listColumnWidget.add(val);
    }
  }
}

class DataRecords {
  List<String> listColumnWidget;
  List<List<String>> listRowWidget;
}

class ReportMasterCompositeEntity {
  int mchartid;
  String mfieldname;

  ReportMasterCompositeEntity({this.mchartid, this.mfieldname});

  factory ReportMasterCompositeEntity.fromMap(Map<String, dynamic> map) {
    return ReportMasterCompositeEntity(
      mchartid: map[TablesColumnFile.mchartid] as int,
      mfieldname: map[TablesColumnFile.mfieldname] as String,
    );
  }

  @override
  String toString() {
    return 'ReportMasterCompositeEntity{mchartid: $mchartid, mfieldname: $mfieldname}';
  }
}

class ReportMasterEntity {
  ReportMasterCompositeEntity reportFilterComposite;
  String mdisplay;
  int mismandatory;
  int mfieldid;
  String mdefaultval;

  ReportMasterEntity(
      {this.reportFilterComposite,
      this.mdisplay,
      this.mismandatory,
      this.mfieldid,
      this.mdefaultval});

  factory ReportMasterEntity.fromMap(Map<String, dynamic> map) {
    return ReportMasterEntity(
      reportFilterComposite: ReportMasterCompositeEntity.fromMap(
          map[TablesColumnFile.reportFilterComposite]),
      mdisplay: map[TablesColumnFile.mdisplay] as String,
      mismandatory: map[TablesColumnFile.mismandatory] as int,
      mfieldid: map[TablesColumnFile.mfieldid] as int,
      mdefaultval: map[TablesColumnFile.mdefaultval] as String,
    );
  }

  factory ReportMasterEntity.fromMapLocalDataBase(Map<String, dynamic> map) {
    return ReportMasterEntity(
      reportFilterComposite: ReportMasterCompositeEntity.fromMap(map),
      mdisplay: map[TablesColumnFile.mdisplay] as String,
      mismandatory: map[TablesColumnFile.mismandatory] as int,
      mfieldid: map[TablesColumnFile.mfieldid] as int,
      mdefaultval: map[TablesColumnFile.mdefaultval] as String,
    );
  }
}
