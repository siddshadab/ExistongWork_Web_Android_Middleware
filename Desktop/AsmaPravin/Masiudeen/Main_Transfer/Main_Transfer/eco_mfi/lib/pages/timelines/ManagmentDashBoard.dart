import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/chartsLib/charts.dart';
import 'package:eco_mfi/pages/timelines/ChartList.dart';
import 'package:eco_mfi/pages/timelines/ChartsUtils.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/axis_features/multiple_axis_chart/multiple_axis_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/area_series/default_area_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/bar_series/default_bar_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/column_series/column_width_and_spacing.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/column_series/column_with_rounded_corners.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/line_series/customized_line_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/stacked_series/stacked_area_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/stacked_series/stacked_bar_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/stacked_series/stacked_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/circular_charts/Export/export.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/circular_charts/pie_series/pie_with_grouping.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_line_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/funnel_charts/funnel_with_smart_labels.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/pyramid_charts/pyramid_with_smart_labels.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoGraphMasterTab.dart';
import 'package:eco_mfi/pages/timelines/DisplayChartsInd.dart';
import 'package:eco_mfi/pages/timelines/GraphUtils.dart';
import 'package:eco_mfi/pages/todo/home/ColorPalleteList.dart';
import 'package:eco_mfi/pages/todo/home/ColourPalleteGenerater.dart';

import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:flutter/cupertino.dart';

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
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChartsBean.dart';
import 'DashBoardNewArchitect/chart/circular_charts/Export/export.dart';
import 'DashBoardNewArchitect/chart/circular_charts/pie_series/default_pie_chart.dart';
/*import 'SimpleScatterPlotCharts.dart';
import 'SimpleTimeSeriesCharts.dart';*/
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoBarDefault.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoColumnDefault.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoCustomizedLine.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoMultipleAxis.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoPieGrouping.dart';
import 'package:toast/toast.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:screenshot/screenshot.dart';

import 'DashBoardNewArchitect/chart/series_features/Gradient/Vertical_Gradient.dart';
import 'DashBoardNewArchitect/chart/series_features/annotation/chart_with_annotation.dart';

class ManagmentDashBoard extends StatefulWidget {
  @override
  _ManagmentDashBoardState createState() => _ManagmentDashBoardState();
}

class _ManagmentDashBoardState extends State<ManagmentDashBoard> {
  SharedPreferences prefs;
  String userCode;
  SubItem sampleClass = new SubItem();
  Widget chartWidget;
  List<Widget> chartListWidget = new List<Widget>();
  Utility obj = new Utility();
  int selectedIndex = 0;

  //[new Column()];

  List<ChartsBean> chartBeanList = new List();
  List<String> favouriteTypes = ["Home"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSessionVariables();
    getFavouriteType();
  }

  getFavouriteType() async {
    await AppDatabaseExtended.get()
        .getFavouriteTypes()
        .then((List<ChartFavouriteTypes> beanList) {
      if (beanList != null && beanList.isNotEmpty) {
        favouriteTypes.clear();
        for (ChartFavouriteTypes item in beanList) {
          favouriteTypes.add(item.typeName);
        }
        getChartTypes();
      }
    });
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userCode = prefs.getString(TablesColumnFile.musrcode);
    });

    //favouriteTypes.addAll(['Online','Offline','synced']);
  }

  replacekeywords(ChartsBean f) async {
    //replace codes here
    try {
      f.mquery = f.mquery.replaceAll("LOGINUSER", userCode);
    } catch (_) {}
  }

  getChartTypes() async {
    bool netAvail = false;
    netAvail = await obj.checkIfIsconnectedToNetwork();
    if (netAvail == false || netAvail == null) {
      Toast.show("Offline Mode", context);
    }
    print("Calling This");

    await AppDatabaseExtended.get()
        .getFavouriteChartTypes(favouriteTypes[selectedIndex])
        .then((List<ChartsBean> returnedChartList) async {
//       for(int i= 0;i< returnedChartList.length;i++){
//         chartListWidget.add(new Card(
//           child: new CircularProgressIndicator(),
//
//         ));
//       }

      if (returnedChartList.isNotEmpty) {
        chartBeanList = returnedChartList;
      } else {
        setState(() {});
        return;
      }

      int i = 0;
      for (ChartsBean chartsBean in returnedChartList) {
        print("Returned List is ${chartsBean} ");
        if (chartsBean.mdatasource.toLowerCase() != 'tablet' &&
            (netAvail == false || netAvail == null)) {
          continue;
        }
//        replacekeywords(chartsBean);
        Widget ab = await getDataFromMiddleware(chartsBean, i);
        chartListWidget.add(ab);
        i++;
        setState(() {});
//        chartListWidget.add(new Card(
////          child: new Text("${items.mrefno}"),
////        ));
////        setState(() {
////
////        });
      }
    });
  }

  Future<Widget> getDataFromMiddleware(ChartsBean chartBean, int i) async {
    return new FutureBuilder(
        future: GraphUtils.getChartSampleData(chartBean)
            .then((List<ChartSampleData> chartSample) {
          chartBean.chartSampleData = chartSample;
          chartBean.isTile = true;
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Center(
                  child: new Text('Please wait while list gets load'));
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
              } else {
                switch (chartBean.mcharttype) {
                  case (TablesColumnFile.customizedline):
                    print("Iske andar aya");
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child:
                                    new CustomizedLine(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;
                  case (TablesColumnFile.linedashed):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child:
                                    new CustomizedLine(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;
                  case (TablesColumnFile.columndefault):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child:
                                    new ColumnDefault(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;
                  case (TablesColumnFile.columnrounded):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child:
                                    new ColumnRounded(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;
                  case (TablesColumnFile.areadefault):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new AreaDefault(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  case (TablesColumnFile.multipleaxis):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child:
                                    new MultipleAxis(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  case (TablesColumnFile.piegrouping):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                              height: 375.0,
                              child: new PieGrouping(
                                chartObject: chartBean,
                              ),
                            ),
                          )
                        ],
                      ),
                    );

                    break;

                  case (TablesColumnFile.columnwidthspace):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child:
                                    new ColumnSpacing(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  case (TablesColumnFile.stackedarea):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new StackedAreaChart(
                                    chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  case (TablesColumnFile.stackedcolumn):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new StackedColumnChart(
                                    chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                    break;

                  case (TablesColumnFile.defaultbar):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new BarDefault(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;
                  case (TablesColumnFile.stackedbar):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new StackedBarChart(
                                    chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  case (TablesColumnFile.verticalgradient):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new VerticalGradient(
                                    chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  case (TablesColumnFile.funnelwithsmartlabel):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new FunnelSmartLabels(
                                    chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  case (TablesColumnFile.pyramidlwithsmartlabel):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new PyramidSmartLabels(
                                    chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;
                  case (TablesColumnFile.exporting):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child:
                                    new ExportCircular(chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  case (TablesColumnFile.chartwithannotation):
                    chartWidget = new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 25.0,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            color: globals.chrttitleborder ?? Colors.yellow,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new SizedBox(),
                                new Text(
                                  chartBean.mtitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: globals.chrttitle ?? Colors.black),
                                ),
                                new IconButton(
                                    icon: Icon(Icons.clear),
                                    color: globals.chrtnavbtn ?? Colors.black,
                                    onPressed: () async {
                                      deleteSpecific(chartBean, i);
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Container(
                                height: 375.0,
                                child: new AnnotationWatermark(
                                    chartObject: chartBean)),
                          )
                        ],
                      ),
                    );
                    break;

                  default:
                    chartWidget = new Row();
                }

                return chartWidget;

//              return new Card(
//                  child:new ListTile(
//                  title: new Text(chartBean.mtitle),
//                )
//
//              );
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: "hh",
                          child: new ClipRect(
                            child: new Image(
                              image: new AssetImage("assets/graph7.png"),
                              alignment: Alignment.center,
                              height: 125.0,
                              width: 200.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Text(
                            "Graphical Analysis",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ChartsList(
                              requestedPage:
                                  "graphlist")), //When Authorized Navigate to the next screen
                    );
                  },
                ),
                GestureDetector(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new ClipRect(
                          child: new Image(
                            image: new AssetImage("assets/report7.png"),
                            alignment: Alignment.center,
                            height: 125.0,
                            width: 200.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Text(
                            "Reports",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      ]),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ChartsList(
                              requestedPage:
                                  "reportlist")), //When Authorized Navigate to the next screen
                    );
                  },
                ),
              ],
            ),
          ),

//          Divider(),
//          Container(
//
//            child: new Row(
//
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                new SizedBox(
//                  width: 10.0,
//                ),
//                new Text(
//                  "Favourites",
//                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                ),
//                new Row(
//                  children: <Widget>[
//                    new IconButton(
//                        icon: Icon(Icons.clear), color: Colors.black,
//                        onPressed: () async {
//                          ShowAlertToClearAllFav();
//                        }),
//                    new IconButton(
//                        icon: Icon(Icons.refresh),
//                        onPressed: () {
//                          refreshAllList();
//                        })
//                  ],
//                )
//              ],
//            ),
//          ),

          new Card(
            color: globals.subappbar ?? Color(0xff07426A),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new SizedBox(
                  width: 10.0,
                ),
                new Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            color: selectedIndex == 0
                                ? Colors.grey
                                : (globals.subappbartext ?? Colors.white),
                            onPressed: () {
                              if (selectedIndex > 0) {
                                selectedIndex = selectedIndex - 1;
                                chartListWidget = new List<Widget>();
                                getChartTypes();
                                setState(() {});
                              }
                            }),
                      ),
                      new Text(
                        favouriteTypes[selectedIndex],
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: globals.subappbartext ?? Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color:
                                  selectedIndex == (favouriteTypes.length - 1)
                                      ? Colors.grey
                                      : globals.subappbartext ?? Colors.white,
                            ),
                            onPressed: () {
                              if (selectedIndex < favouriteTypes.length - 1) {
                                selectedIndex++;
                                chartListWidget = new List<Widget>();
                                getChartTypes();

                                setState(() {});
                              }
                            }),
                      )
                    ],
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new IconButton(
                        icon: Icon(Icons.clear),
                        color: globals.subappbaricon ?? Colors.white,
                        onPressed: () async {
                          ShowAlertToClearAllFav();
                        }),
                    new IconButton(
                        icon: Icon(Icons.refresh),
                        color: globals.subappbaricon ?? Colors.white,
                        onPressed: () async {
                          await AppDatabaseExtended.get()
                              .getFavouriteTypes()
                              .then((List<ChartFavouriteTypes> beanList) {
                            if (beanList != null && beanList.isNotEmpty) {
                              favouriteTypes.clear();
                              for (ChartFavouriteTypes item in beanList) {
                                favouriteTypes.add(item.typeName);
                              }
                            }
                          });

                          refreshAllList();
                        }),
                    new IconButton(
                        icon: Icon(Icons.settings),
                        color: globals.subappbaricon ?? Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new ColourPalleteList()), //When Authorized Navigate to the next screen
                          );
                        })
                  ],
                )
              ],
            ),
          ),

          new Column(
            children: chartListWidget,
          )

//        new Column(children :chartBeanList.map(( ChartsBean  chartIndObject){
//
//          return getCards(chartIndObject);
//
//        }).toList()
//
//
//        )

//          Container(
//            height: 300.0,
//            child: new Card(
//                child: DemoPieGrouping(
//                  sample: null,
//                )
//            ),
//          ),
//
//          new Card(
//              child: DemoBarDefault(
//                sample: null,
//              )
//          ),
//          new Card(
//              child: DemoColumnDefault(
//                sample: null,
//              )
//          ),
//          new Card(
//              child: DemoCustomizedLine(
//                sample: null,
//              )
//          ),
//          new Card(
//              child: DemoMultipleAxis(
//                sample: null,
//              )
//          )
        ],
      ),
    );
  }

  Future<void> ShowAlertToClearAllFav() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.delete,
              color: Colors.black,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                          "Are you sure you want to clear all favourites ?"),
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Text(
                          "After clearing the favourites Top 5 charts will be visble on screen")
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
                onPressed: () {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
                  globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  clearFavourites();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
                  globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  refreshAllList() {
    chartListWidget = new List<Widget>();

    //[new Column()];

    getChartTypes();
  }

  clearFavourites() async {
    await AppDatabaseExtended.get()
        .deleteChartsFavouriteBean(0, "", true)
        .then((_) {
      refreshAllList();
    });
  }

  deleteSpecific(ChartsBean chartObj, int index) async {
    print(index);
    print("${chartObj.mchartid}  ${chartObj.mcharttype}");
    await AppDatabaseExtended.get()
        .deleteChartsFavouriteBean(chartObj.mchartid, chartObj.mcharttype)
        .then((_) {
      chartListWidget.removeAt(index);
      setState(() {});
    });
  }
}

class ChartFavouriteTypes {
  int id;
  String typeName;

  ChartFavouriteTypes({this.id, this.typeName});

  factory ChartFavouriteTypes.fromMap(Map<String, dynamic> map) {
    return ChartFavouriteTypes(
        id: map["id"] as int, typeName: map["typeName"] as String);
  }

  @override
  String toString() {
    return 'ChartFavouriteTypes{id: $id, typeName: $typeName}';
  }
}
