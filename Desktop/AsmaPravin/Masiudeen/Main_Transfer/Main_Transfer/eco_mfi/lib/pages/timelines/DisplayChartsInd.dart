//
//import 'package:eco_mfi/Utilities/ThemeDesign.dart';
//import 'package:eco_mfi/Utilities/app_constant.dart';
//import 'package:eco_mfi/db/AppDatabase.dart';
//import 'package:eco_mfi/db/TablesColumnFile.dart';
//import 'package:eco_mfi/pages/timelines/ChartsUtils.dart';
//import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_column_chart.dart';
//import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_line_chart.dart';
//import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
//
//import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
//import 'package:eco_mfi/Utilities/globals.dart' as globals;
//import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_circular_chart/flutter_circular_chart.dart';
//import 'package:eco_mfi/Utilities/globals.dart' as globals;
//import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_sparkline/flutter_sparkline.dart';
//import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:intl/intl.dart';
//import 'package:eco_mfi/Utilities/globals.dart' as globals;
//import 'package:scoped_model/scoped_model.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//
//import 'ChartsBean.dart';
//import 'DashBoardNewArchitect/chart/circular_charts/pie_series/default_pie_chart.dart';
///*import 'SimpleScatterPlotCharts.dart';
//import 'SimpleTimeSeriesCharts.dart';*/
//
//
//class DisplayChartsInd extends StatefulWidget {
//
//  ChartsBean chartsBean;
//
//  DisplayChartsInd({Key key, this.title,this.chartsBean}) : super(key: key);
//
//  static Container _get(Widget child,
//      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
//      new Container(
//        padding: pad,
//        child: child,
//      );
//  final String title;
//
//  @override
//  _DisplayChartsIndState createState() => new _DisplayChartsIndState();
//}
//
//class _DisplayChartsIndState extends State<DisplayChartsInd> {
//
//  bool _dialVisible =true;
//  static final List<String> chartDropdownItems = [ 'Last 7 days', 'Last month', 'Last year' ];
//  String actualDropdown = chartDropdownItems[0];
//  int actualChart = 0;
//
//  @override
//  Widget build(BuildContext context)
//  {
//    return Scaffold
//      (
//        floatingActionButton:  SpeedDial(
//          //animatedIcon: AnimatedIcons.menu_close,
//          //animatedIconTheme: IconThemeData(size: 22.0),
//          // this is ignored if animatedIcon is non null
//          child: Icon(Icons.add),
//          visible: _dialVisible,
//          curve: Curves.bounceIn,
//          overlayColor: Colors.black,
//          overlayOpacity: 0.5,
//          onOpen: () => print('OPENING DIAL'),
//          onClose: () => print('DIAL CLOSED'),
//          tooltip: 'Change Charts Type',
//          heroTag: 'Type',
//          backgroundColor: Colors.white,
//          foregroundColor: Colors.black,
//          elevation: 8.0,
//          shape: CircleBorder(),
//          children: [
//            SpeedDialChild(
//                child: IconButton(
//                  icon: Icon(
//                    FontAwesomeIcons.chartBar,
//                    color: Colors.grey,
//                    size: 30.0,
//                  ), onPressed: (){
//
//                  // ChartsBean tempBean = widget.chartsBean;
//                  widget.chartsBean.mdefaulttype ='3';
//                  ChartsUtils.getCharts(widget.chartsBean);
//                  //widget.chartsBean =tempBean ;
//                  setState(() {
//
//                  });
//                },),
//                backgroundColor: Colors.red,
//                label: 'Bar Charts',
//                // labelStyle: TextTheme(fontSize: 18.0),
//                onTap: (){
//
//                  // ChartsBean tempBean = widget.chartsBean;
//                  widget.chartsBean.mdefaulttype ='3';
//                  ChartsUtils.getCharts(widget.chartsBean);
//                  //widget.chartsBean =tempBean ;
//                  setState(() {
//
//                  });
//                }
//            ),
//            SpeedDialChild(
//                child: IconButton(
//                  icon: Icon(
//                    FontAwesomeIcons.solidChartBar,
//                    color: Colors.grey,
//                    size: 30.0,
//                  ), onPressed: (){
//
//                  // ChartsBean tempBean = widget.chartsBean;
//                  widget.chartsBean.mdefaulttype ='2';
//                  ChartsUtils.getCharts(widget.chartsBean);
//                  //widget.chartsBean =tempBean ;
//                  setState(() {
//
//                  });
//                },),
//                backgroundColor: Colors.blue,
//                label: 'Line Chart',
//                //   labelStyle: TextTheme(fontSize: 18.0),
//                onTap: () {
//
//                  // ChartsBean tempBean = widget.chartsBean;
//                  widget.chartsBean.mdefaulttype ='2';
//                  ChartsUtils.getCharts(widget.chartsBean);
//                  //widget.chartsBean =tempBean ;
//                  setState(() {
//
//                  });
//                }
//            ),
//
//            SpeedDialChild(
//                child: IconButton(
//                  icon: Icon(
//                    FontAwesomeIcons.chartArea,
//                    color: Colors.grey,
//                    size: 30.0,
//                  ),  onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                globals.sessionTimeOut.SessionTimedOut();
//
//                // ChartsBean tempBean = widget.chartsBean;
//                widget.chartsBean.mdefaulttype ='1';
//                ChartsUtils.getCharts(widget.chartsBean);
//                //widget.chartsBean =tempBean ;
//                setState(() {
//
//                });
//                },),
//                backgroundColor: Colors.blue,
//                label: 'Column Chart',
//                //   labelStyle: TextTheme(fontSize: 18.0),
//                onTap: () {
//
//                  // ChartsBean tempBean = widget.chartsBean;
//                  widget.chartsBean.mdefaulttype ='1';
//                  ChartsUtils.getCharts(widget.chartsBean);
//                  //widget.chartsBean =tempBean ;
//                  setState(() {
//
//                  });
//                }
//            ),
//            SpeedDialChild(
//                child: IconButton(
//                  icon: Icon(
//                    FontAwesomeIcons.chartLine,
//                    color: Colors.grey,
//                    size: 30.0,
//                  ),  onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                globals.sessionTimeOut.SessionTimedOut();
//
//                // ChartsBean tempBean = widget.chartsBean;
//                widget.chartsBean.mdefaulttype ='4';
//                ChartsUtils.getCharts(widget.chartsBean);
//                //widget.chartsBean =tempBean ;
//                setState(() {
//
//                });
//                },),
//                backgroundColor: Colors.green,
//                label: 'Pie Default Chart',
//                // labelStyle: TextTheme(fontSize: 18.0),
//                onTap: () {
//
//                  // ChartsBean tempBean = widget.chartsBean;
//                  widget.chartsBean.mdefaulttype ='4';
//                  ChartsUtils.getCharts(widget.chartsBean);
//                  //widget.chartsBean =tempBean ;
//                  setState(() {
//
//                  });
//                }
//            ),
//
//            SpeedDialChild(
//                child: IconButton(
//                  icon: Icon(
//                    FontAwesomeIcons.chartPie,
//                    color: Colors.grey,
//                    size: 30.0,
//                  ),  onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                globals.sessionTimeOut.SessionTimedOut();
//
//                // ChartsBean tempBean = widget.chartsBean;
//                widget.chartsBean.mdefaulttype ='5';
//                ChartsUtils.getCharts(widget.chartsBean);
//                //widget.chartsBean =tempBean ;
//                setState(() {
//
//                });
//                },),
//                backgroundColor: Colors.green,
//                label: 'Pie Grouping Chart',
//                // labelStyle: TextTheme(fontSize: 18.0),
//                onTap: () {
//
//                  // ChartsBean tempBean = widget.chartsBean;
//                  widget.chartsBean.mdefaulttype ='5';
//                  ChartsUtils.getCharts(widget.chartsBean);
//                  //widget.chartsBean =tempBean ;
//                  setState(() {
//
//                  });
//                }
//            ),
//          ],
//        ),
//        appBar: AppBar
//          (
//          elevation: 2.0,
//          backgroundColor: Colors.white,
//          title: Text(widget.chartsBean.mtitle, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
//          actions: <Widget>
//          [
//            Container
//              (
//              margin: EdgeInsets.only(right: 8.0),
//              child: Row
//                (
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>
//                [
//                  /*  Text('beclothed.com', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 14.0)),
//                  Icon(Icons.arrow_drop_down, color: Colors.black54)*/
//                ],
//              ),
//            )
//          ],
//        ),
//        body: StaggeredGridView.count(
//          crossAxisCount: 2,
//          crossAxisSpacing: 12.0,
//          mainAxisSpacing: 12.0,
//          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//          children: <Widget>[
//            _buildTile(
//              Padding
//                (
//                padding: const EdgeInsets.all(24.0),
//                child: Row
//                  (
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>
//                    [
//                      Column
//                        (
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>
//                        [
//                          Text(widget.chartsBean.mkey, style: TextStyle(color: Colors.blueAccent)),
//                          Text('265K', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
//                        ],
//                      ),
//                      Material
//                        (
//                          color: Colors.blue,
//                          borderRadius: BorderRadius.circular(24.0),
//                          child: Center
//                            (
//                              child: Padding
//                                (
//                                padding: const EdgeInsets.all(16.0),
//                                child: Icon(Icons.timeline, color: Colors.white, size: 30.0),
//                              )
//                          )
//                      )
//                    ]
//                ),
//              ),
//            ),
//            _buildTile(
//              Padding(
//                padding: const EdgeInsets.all(24.0),
//                child: Column
//                  (
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>
//                    [
//                      Material
//                        (
//                          color: Colors.teal,
//                          shape: CircleBorder(),
//                          child: Padding
//                            (
//                            padding: const EdgeInsets.all(16.0),
//                            child: Icon(Icons.settings_applications, color: Colors.white, size: 30.0),
//                          )
//                      ),
//                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
//                      Text(widget.chartsBean.mxcatg, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
//                      Text(widget.chartsBean.mxcatg, style: TextStyle(color: Colors.black45)),
//                    ]
//                ),
//              ),
//            ),
//            _buildTile(
//              Padding
//                (
//                padding: const EdgeInsets.all(24.0),
//                child: Column
//                  (
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>
//                    [
//                      Material
//                        (
//                          color: Colors.amber,
//                          shape: CircleBorder(),
//                          child: Padding
//                            (
//                            padding: EdgeInsets.all(16.0),
//                            child: Icon(Icons.notifications, color: Colors.white, size: 30.0),
//                          )
//                      ),
//                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
//                      Text(widget.chartsBean.mycatg, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24.0)),
//                      Text(widget.chartsBean.mycatg, style: TextStyle(color: Colors.black45)),
//                    ]
//                ),
//              ),
//            ),
//            _buildTile(
//              Padding
//                (
//                  padding: const EdgeInsets.all(24.0),
//                  child: Column
//                    (
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>
//                    [
//                      Row
//                        (
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>
//                        [
//                          Column
//                            (
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>
//                            [
//                              Text(widget.chartsBean.mtype, style: TextStyle(color: Colors.green)),
//                              Text(widget.chartsBean.mxcatg, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
//                            ],
//                          ),
//                          DropdownButton
//                            (
//                              isDense: true,
//                              value: actualDropdown,
//                              onChanged: (String value) => setState(()
//                              {
//                                actualDropdown = value;
//                                actualChart = chartDropdownItems.indexOf(value); // Refresh the chart
//                              }),
//                              items: chartDropdownItems.map((String title)
//                              {
//                                return DropdownMenuItem
//                                  (
//                                  value: title,
//                                  child: Text(title, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 14.0)),
//                                );
//                              }).toList()
//                          )
//                        ],
//                      ),
//                      Padding(padding: EdgeInsets.only(bottom: 4.0)),
//                      /*Sparkline
//                        (
//                        data: charts[actualChart],
//                        lineWidth: 5.0,
//                        lineColor: Colors.greenAccent,
//                      )*/
//                      widget.chartsBean.chartType
//                    ],
//                  )
//              ),
//            ),
//
//          ],
//          staggeredTiles: [
//            StaggeredTile.extent(2, 150.0),
//            StaggeredTile.extent(1, 250.0),
//            StaggeredTile.extent(1, 250.0),
//            StaggeredTile.extent(2, 700.0),
//            //StaggeredTile.extent(2, 110.0),
//          ],
//        )
//    );
//  }
//
//  Widget _buildTile(Widget child, {Function() onTap}) {
//    return Material(
//        elevation: 14.0,
//        borderRadius: BorderRadius.circular(12.0),
//        shadowColor: Color(0x802196F3),
//        child: InkWell
//          (
//          // Do onTap() if it isn't null, otherwise do print()
//            onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
//            child: child
//        )
//    );
//  }
//}