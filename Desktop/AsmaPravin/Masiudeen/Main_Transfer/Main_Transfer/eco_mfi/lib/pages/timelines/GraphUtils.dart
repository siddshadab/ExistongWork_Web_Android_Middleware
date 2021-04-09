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
import 'package:shared_preferences/shared_preferences.dart';

class GraphUtils {
  static const JsonCodec JSON = const JsonCodec();

  static String replacekeywords(
      String f, String usercode, int lbrcode, int grpcd, DateTime opernDate) {
    //replace codes here

    f = f.replaceAll("LOGINUSER", usercode);
    f = f.replaceAll("USRBRANCHCODE", lbrcode.toString());
    f = f.replaceAll("OPRNDATE", opernDate.toString());
    f = f.replaceAll("SYSDATE", DateTime.now().toString());
    f = f.replaceAll("USRGROUPPCODE", grpcd.toString());

    return f;
  }

  static Future<List<ChartSampleData>> getChartSampleData(
      ChartsBean charttype) async {
    // double height = MediaQuery.of(context).size.height;
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

        print("User Code is ${pref.getString(TablesColumnFile.musrcode)}");
        print(pref.getInt(TablesColumnFile.musrbrcode));
        print(pref.getInt(TablesColumnFile.grpCd));

        charttype.mquery = await replacekeywords(
            charttype.mquery,
            pref.getString(TablesColumnFile.musrcode),
            pref.getInt(TablesColumnFile.musrbrcode),
            pref.getInt(TablesColumnFile.grpCd),
            operationDate);

        if (charttype.mtype == 'xy') {
          return await AppDatabaseExtended.get().getQuerySimpleChart(charttype);
        } else if (charttype.mtype == 'xyy') {
          return await AppDatabaseExtended.get().getQueryLineChart(charttype);
        } else if (charttype.mtype == 'xyn') {
          return await AppDatabaseExtended.get().getQueryLineChart(charttype);
        }
      } else {
        return await getOnlineData(charttype);
      }
    }
  }

  static Future<String> _tojsonObj(ChartsBean bean) async {
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

    print("User Code is ${pref.getString(TablesColumnFile.musrcode)}");
    print(pref.getInt(TablesColumnFile.musrbrcode));
    print(pref.getInt(TablesColumnFile.grpCd));

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

      // print("xCatogory ki value hai ${RegExp(r'.*:')}");
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

      salesData.xValue = xAxis == null ? 2 : xAxis;
      salesData.yValue = yAxis;
      print("salesData salesData ${salesData}");
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
      print("xcat hai ${xcat}");
      print("ycat hai ${ycat}");
      print("y2cat hai ${ycat}");
      //xcat:  mrefmo 2
      //ycat: custstatus 1
      String xAxis = "";
      int yAxis = 0;
      int y2Axis = 0;
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
      if (y2cat != null && y2cat != 'null') {
        switch (y2cat.runtimeType) {
          case int:
            print("Y2 is  Int");
            y2Axis = y2cat;
            break;
          case String:
            print("Y2 is  String");
            try {
              y2Axis = int.parse(y2cat);
            } catch (_) {
              y2Axis = 0;
            }

            break;
          default:
            print("nothing");
            y2Axis = int.parse(y2cat);
            break;
        }
      } else {
        y2Axis = 0;
      }

      salesData.xValue = xAxis == null ? 2 : xAxis;
      salesData.yValue = yAxis;
      salesData.yValue2 = y2Axis;
      print("salesData salesData ${salesData}");
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
      //print("values ahi ${values} ");
      String xcat = values[0].replaceAll(RegExp(r'.*:'), "").trim();
      String ycat = values[1].replaceAll(RegExp(r'.*:'), "").trim();
      double y2cat = double.parse(values[2].replaceAll(RegExp(r'.*:'), ""));

      //xcat:  mrefmo 2
      //ycat: custstatus 1
      salesData.xValue = xcat == null ? 2 : xcat;
      salesData.yValue = ycat;
      salesData.yValue2 = y2cat;
      //print("salesData salesData ${salesData}");
      //salesDataList.add(salesData);
    }

    return salesData;
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

  static Future<List<ChartSampleData>> getOnlineData(ChartsBean bean) async {
    final _headers = {'Content-Type': 'application/json'};
    var url = "DataSourceResult/getQueryResult";
    List<ChartSampleData> returnedSampleDate = new List<ChartSampleData>();

    //print("Data after UserValutBalance UserValutBalance UserValutBalance  1");
    try {
      String json2 = await _tojsonObj(bean);
      final bodyValue = await NetworkUtil.callPostService(
          json2, Constant.apiURL.toString() + url.toString(), _headers);
      // print(" bodyValue ${bodyValue}");
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

      //print(" ye mera value hai ${configuredRreportsBean}");
      //{ XA: Business Loan, YA Advance Rental, value : 28} , {XA: Business Loan, YA : Advance Rental, value : 28} , }

      var values = configuredRreportsBean[0].values.toString().split("}");
      //[{ XA: Business Loan, YA Advance Rental, value : 28},
      // {XA: Business Loan, YA : Advance Rental, value : 28}]
      // print("values[0] xxxxxxxxxxxxxxxxxx ${values[0]}");
      String str =
          values[0]; //{ XA: Business Loan, YA Advance Rental, value : 28}
      str = str.replaceAll("{", "");
      str = str.replaceAll(
          "}", ""); // XA: Business Loan, YA Advance Rental, value : 28
      var values2 = str.toString().split(","); //[XA: Business Loan
      // YA Advance Rental
      // value : 28 ]
      for (int val = 0; val < values2.length; val++) {
        captions.add(values2[val]);
      }
      var splitedVal =
          configuredRreportsBean[0].values.toString().split("}"); //
      //[{ XA: Business Loan, YA Advance Rental, value : 28},
      // {XA: Business Loan, YA : Advance Rental, value : 28}]

      // print("splitted value hai ${splitedVal}");
      // print("bean.mtype hia ${bean.mtype}.");

      for (int val = 0; val < splitedVal.length - 1; val++) {
        returnedSampleDate.add(setBeanValueHere(bean, splitedVal[val], val));
      }

      return returnedSampleDate;
    } catch (e) {
      //print('Server Exception!!!');

    }
  }
}

class CircularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - size.width / 4,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
