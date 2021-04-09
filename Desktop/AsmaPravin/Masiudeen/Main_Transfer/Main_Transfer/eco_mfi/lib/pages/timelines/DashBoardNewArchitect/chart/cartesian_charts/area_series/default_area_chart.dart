import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/chartsLib/charts.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/checkbox.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/customDropDown.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';

//ignore: must_be_immutable
class AreaDefault extends StatefulWidget {
  AreaDefault({this.chartObject , Key key}) : super(key: key);

  final ChartsBean chartObject;

  @override
  _AreaDefaultState createState() => _AreaDefaultState(chartObject );
}

class _AreaDefaultState extends State<AreaDefault> {
  _AreaDefaultState(this.chartPassedObject);


  final ChartsBean chartPassedObject;
  
  @override
  Widget build(BuildContext context) {

    return PinchZoomingFrontPanel(chartPassedObject);
     return getDefaultAreaChart(false, chartPassedObject);
  }
}


SfCartesianChart getDefaultAreaChart(bool isTileView,ChartsBean sample) {
  return SfCartesianChart(
    legend: Legend( isVisible: sample.islegvis==0?false:true, opacity: 0.7),
//      title: ChartTitle(
//        text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
    isTransposed: false,


    plotAreaBorderWidth: 0,
    primaryXAxis:  CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
      title: AxisTitle(text: sample.xcaption),
      labelRotation:sample.xcaprot??0,
      isVisible: sample.xaxisvsbl==0?false:true,
    ),

//    DateTimeAxis(
//        dateFormat: DateFormat.y(),
//        interval: 1,
//        intervalType: DateTimeIntervalType.years,
//        majorGridLines: MajorGridLines(width: 0),
//        edgeLabelPlacement: EdgeLabelPlacement.shift),
    primaryYAxis: NumericAxis(
        labelFormat: '{value}',
        title: AxisTitle(text: sample.ycaption),
        //interval: sample.yinterval,
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
      labelRotation:sample.ycaprot??0,
      isVisible: sample.yaxisvsbl==0?false:true,

    ),
    series: getDefaultAreaSeries(isTileView,sample),
    tooltipBehavior: TooltipBehavior(enable: true),
      zoomPanBehavior: zoomingBehavior

  );
}

List<AreaSeries<ChartSampleData, String>> getDefaultAreaSeries(bool isTileView,ChartsBean sample) {
//  final List<ChartSampleData> chartData = <ChartSampleData>[
//    ChartSampleData(x:DateTime(2000, 1, 1), y:4, yValue2:2.6),
//    ChartSampleData(x:DateTime(2001, 1, 1), y:3.0, yValue2:2.8),
//    ChartSampleData(x:DateTime(2002, 1, 1), y:3.8, yValue2:2.6),
//    ChartSampleData(x:DateTime(2003, 1, 1), y:3.4, yValue2:3),
//    ChartSampleData(x:DateTime(2004, 1, 1), y:3.2, yValue2:3.6),
//    ChartSampleData(x:DateTime(2005, 1, 1), y:3.9, yValue2:3),
//  ];

    if(sample.mtype=="xy"){
      return <AreaSeries<ChartSampleData, String>>[
        AreaSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          opacity: 0.7,
          name: sample.categoryNames[0]??'',
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        ),
      ];


    }else if(sample.mtype=="xyy"){
      return <AreaSeries<ChartSampleData, String>>[
        AreaSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          opacity: 0.7,
          name: sample.categoryNames[0],
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        ),
        AreaSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          opacity: 0.7,
          name: sample.categoryNames[1],
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
        )
      ];
    }


}



ZoomPanBehavior zoomingBehavior;
class PinchZoomingFrontPanel extends StatefulWidget {
  //ignore: prefer_const_constructors_in_immutables
  PinchZoomingFrontPanel(this.chartObject);
  final ChartsBean chartObject;
  @override
  _PinchZoomingFrontPanelState createState() =>
      _PinchZoomingFrontPanelState(chartObject);
}

class _PinchZoomingFrontPanelState extends State<PinchZoomingFrontPanel> {
  _PinchZoomingFrontPanelState(this.sample);
  final ChartsBean sample;

  final List<String> _zoomModeTypeList = <String>['x', 'y', 'xy'].toList();
  String _selectedModeType = 'x';
  ZoomMode _zoomModeType = ZoomMode.xy;

  @override
  Widget build(BuildContext context) {
    zoomingBehavior = ZoomPanBehavior(
        enablePinching: true, zoomMode: _zoomModeType, enablePanning: true);
    return Container(
      height: sample.isTile==true?350:500.0,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
          child: Container(
              child: getDefaultAreaChart(false ,sample )),
        ),
          floatingActionButton: Container(
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 15, 0, 0),
                          child: Tooltip(
                            message: 'Zoom In',
                            child: IconButton(
                              icon: Icon(Icons.add,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.zoomIn();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Zoom Out',
                            child: IconButton(
                              icon: Icon(Icons.remove,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.zoomOut();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Pan Up',
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_up,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.panToDirection('top');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Pan Down',
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_down,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.panToDirection('bottom');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Pan Left',
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_left,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.panToDirection('left');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Pan Right',
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.panToDirection('right');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Reset',
                            child: IconButton(
                              icon: Icon(Icons.refresh,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.reset();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          )
      ),
    );

  }


}
