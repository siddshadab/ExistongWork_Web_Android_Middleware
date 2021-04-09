import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/reports/ConfiguredRreportsBean.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/bar_series/default_bar_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/circular_charts/pie_series/default_pie_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/circular_charts/pie_series/pie_with_grouping.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class ChartsUtils {
  static const JsonCodec JSON = const JsonCodec();

  static void getCharts(ChartsBean charttype) async {
    // double height = MediaQuery.of(context).size.height;
    if (charttype != null) {
      SubItem sample = new SubItem();
     /* sample.chartSampleData = charttype.chartSampleData;
      sample.chartSampleData[0].title = charttype.mtitle;*/

      if (charttype.mdatasource == 'TABLET') {
        if (charttype.mtype == 'xy' ) {
          await AppDatabaseExtended.get()
              .getQuerySimpleChart(charttype)
              .then((onValue) async {
            charttype.chartSampleData = onValue;
            print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
            getChartsType(charttype, sample);
          });
        } else if (charttype.mtype == 'xy' ) {
          await AppDatabaseExtended.get()
              .getQueryLineChart(charttype)
              .then((onValue) async {
            charttype.chartSampleData = onValue;
            getChartsType(charttype, sample);
          });
        } else if (charttype.mtype == 'xyy' ) {
          await AppDatabaseExtended.get()
              .getQueryLineChart(charttype)
              .then((onValue) async {
            charttype.chartSampleData = onValue;
            getChartsType(charttype, sample);
          });
        }
      } else {
        await getOnlineData(charttype);
      }
    }
  }

  static Future<Null> getOnlineData(ChartsBean bean) async {
    final _headers = {'Content-Type': 'application/json'};
    var url = "DataSourceResult/getQueryResult";

    //print("Data after UserValutBalance UserValutBalance UserValutBalance  1");
    try {
      String json2 = await _tojsonObj(bean);
      final bodyValue = await NetworkUtil.callPostService(
          json2, Constant.apiURL.toString() + url.toString(), _headers);
      //print(" bodyValue ${bodyValue}");
      if (bodyValue == null ||
          bodyValue == 'null' ||
          bodyValue == '' ||
          bodyValue == "error") {
        return null;
      }
      //print("Data after System parameter service  " + bodyValue);
      List<ConfiguredRreportsBean> configuredRreportsBean =
      new List<ConfiguredRreportsBean>();
      configuredRreportsBean = await _froJsontoBean(bodyValue);
      //print("obj ${configuredRreportsBean.toString()}");

      List<String> captions = new List<String>();

      // for (var atn in configuredRreportsBean) {
      if(bean.mchartid==1){
        print(" ye mera value hai ${configuredRreportsBean}");
      }
      var values = configuredRreportsBean[0].values.toString().split("}");
      print("values[0] xxxxxxxxxxxxxxxxxx ${values[0]}");
      String str = values[0];
      str = str.replaceAll("{", "");
      str = str.replaceAll("}", "");
      //print("str xxxxxxxxxxxxxxxxxx ${str}");
      var values2 = str.toString().split(",");
      for (int val = 0; val < values2.length; val++) {
        captions.add(values2[val]);
      }
      if(bean.mchartid==1){
        print(" Captions hai  ${captions}");
      }

      var splitedVal = configuredRreportsBean[0].values.toString().split("}");
      print("splitted value hai ${splitedVal}");

      for (int val = 0; val < splitedVal.length - 1; val++) {
        setBeanValueHere(bean, splitedVal[val]);
        // await getTabularDataRowsOnline(splitedVal[val]);
      }

      //}
      //}

    } catch (e) {
      //print('Server Exception!!!');

    }
  }

  static Future<List<ConfiguredRreportsBean>> _froJsontoBean(
      String json) async {
    List<ConfiguredRreportsBean> listBean = new List<ConfiguredRreportsBean>();
    List list = JSON.decode(json);
    for (int i = 0; i < list.length; i++) {
      //print("jsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjsonjson"+list.toString());
      var bean = ConfiguredRreportsBean.fromMapMiddleware(list[i]);
      // var bean = LookupMasterBean.fromJson(list[i]);
      listBean.add(bean);
    }
    return listBean;
  }

  static Future<String> _tojsonObj(ChartsBean bean) async {
    var mapData = new Map();
    mapData[TablesColumnFile.msystemid] = bean.mdatasource;
    mapData[TablesColumnFile.murl] = bean.mquery;

    String json = JSON.encode(mapData);
    //print(json.toString());
    return json;
  }

  static void setBeanValueHere(ChartsBean bean, String splitedVal) {
    List<ChartSampleData> salesDataList = new List<ChartSampleData>();
    var values = splitedVal.toString().split(",");

/*    for(int val =0;val<values.length;val++) {
      String valDisp = values[val].replaceAll(RegExp(r'.*:'), "");
      //print("valDisp  ${valDisp}");

    }*/

    if (bean.mtype == 'xy') {

      print("values ahi ${values} ");
      dynamic xcat = values[0].replaceAll(RegExp(r'.*:'), "");
      dynamic ycat = values[1].replaceAll(RegExp(r'.*:'), "");
      print("xcat hai ${xcat}");
      print("ycat hai ${ycat}");
      //xcat:  mrefmo 2
      //ycat: custstatus 1
      String xAxis = "";
      int yAxis = 0;
      // xcat = || xcat==0?"0":"";
      if (xcat != null) {
        switch (xcat.runtimeType) {
          case int:
            print("X is Int ${xcat}");
            xAxis = xcat.toString();
            break;
          case String:
            print("X is String");
            xAxis = xcat;
            break;
          default:
            print("x is nothing");
            xAxis = xcat.toString();
            break;
        }
      } else {
        xAxis = "";
      }

      if (ycat != null && ycat != 'null') {
        switch (ycat.runtimeType) {
          case int:
            print("Y is  Int");
            yAxis = ycat;
            break;
          case String:
            print("Y is  String");
            try {
              yAxis = int.parse(ycat);
            } catch (_) {
              yAxis = 0;
            }

            break;
          default:
            print("nothing");
            yAxis = int.parse(ycat);
            break;
        }
      } else {
        yAxis = 0;
      }

      ChartSampleData salesData = new ChartSampleData();
      salesData.xValue = xAxis == null ? 2 : xAxis;
      salesData.yValue = yAxis;
      print("salesData salesData ${salesData}");
      salesDataList.add(salesData);
    }
    bean.chartSampleData = salesDataList;
    SubItem sample = new SubItem();
    sample.chartSampleData = bean.chartSampleData;
    //sample.chartSampleData[0].title=charttype.mtitle;
    getChartsType(bean, sample);
    //new  Container(height: 400.0, child: new  ColumnDefault(sample: sample,));
  }

  static void getChartsType(ChartsBean charttype, SubItem sample) {
//    if (charttype != null) {
//      if (charttype.mdefaulttype == '1') {
//        sample.chartSampleData[0].title = charttype.mtitle;
//        print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//        charttype.chartType = new Container(
//            height: 400,
//            child: new ColumnDefault(
//              //sample: sample,
//            ));
//      } else if (charttype.mdefaulttype == '2') {
//        charttype.chartType = new Container(
//            height: 400,
//            child: new LineDefault(
//              sample: sample,
//            ));
//      } else if (charttype.mdefaulttype == '3') {
//        //await AppDatabase.get().getQueryNumTypeBean(charttype).then((onValue) async {
//
////        sample.chartSampleData = charttype.chartSampleData;
////        charttype.chartType =
////        new Container(height: 400.0, child: new BarDefault(sample));
//      } else if (charttype.mdefaulttype == '4') {
//        //sample.chartSampleData[0].title=charttype.mtitle;
//        charttype.chartType = new Container(
//            height: 400.0,
//            child: new PieDefault(
//              sample: sample,
//            ));
//      } else if (charttype.mdefaulttype == '5') {
//        //sample.chartSampleData[0].title=charttype.mtitle;
////        charttype.chartType = new Container(
////            height: 400.0,
////            child: new PieGrouping(
////              sample: sample,
////            ));
//      } else if (charttype == '6') {
//        //sample.chartSampleData[0].title=charttype.mtitle;
//        charttype.chartType = new Container(
//            height: 400.0,
//            child: new ColumnDefault(
//              //sample: sample,
//            ));
//      } else if (charttype == '7') {
//        //sample.chartSampleData[0].title=charttype.mtitle;
//        charttype.chartType = new Container(
//            height: 400.0,
//            child: new ColumnDefault(
//              //sample: sample,
//            ));
//      }
//      /* else if (charttype == '8') {
//        charttype.chartType = Container(height: 400.0, child: getDefaultBubbleChart(true));
//      } else if (charttype == '9') {
//        charttype.chartType = Container(height: 400.0, child: getDefaultColumnChart(true));
//      } else if (charttype == '10') {
//        charttype.chartType = Container(height: 400.0, child: getDefaultSplineChart(true));
//      } else if (charttype == '11') {
//        charttype.chartType = Container(height: 400.0, child: getDefaultStepLineChart(true));
//      } else if (charttype == '12') {
//        charttype.chartType = Container(height: 400.0, child: getDefaultAreaChart(true));
//      } else if (charttype == '13') {
//        charttype.chartType = Container(height: 400.0, child: getDefaultScatterChart(true));
//      } else if (charttype == '14') {
//      } else if (charttype == '15') {
//      } else {
//        charttype.chartType = new Text("Select Charts Type");
//      }
//    } else {
//      charttype.chartType = new Text("Select Charts Type");
//    }*/
//    }
  }
}
