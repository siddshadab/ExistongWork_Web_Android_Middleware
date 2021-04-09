
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';import 'package:eco_mfi/pages/chartsLib/charts.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/checkbox.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/customDropDown.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/custom_button.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
//ignore: must_be_immutable
class MultipleAxis extends StatefulWidget {
  MultipleAxis({this.chartObject, Key key}) : super(key: key);

  final ChartsBean chartObject;

  @override
  _MultipleAxisState createState() => _MultipleAxisState();
}

class _MultipleAxisState extends State<MultipleAxis> {


  @override
  Widget build(BuildContext context) {
//    const String sourceLink =
//        'https://www.accuweather.com/en/us/new-york-ny/10007/month/349727?monyr=5/01/2019';
//    const String source = 'www.accuweather.com';
    return PinchZoomingFrontPanel(widget.chartObject);
    return getMultipleAxisLineChart(widget.chartObject);
  }
}

SfCartesianChart getMultipleAxisLineChart(ChartsBean sample) {
  return SfCartesianChart(
//      title: ChartTitle(
//        text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
    legend: Legend( isVisible: sample.islegvis==0?false:true,),
//    axes: <ChartAxis>[
//      NumericAxis(
//          opposedPosition: true,
//          name: 'yAxis1',
//          majorGridLines: MajorGridLines(width: 0),
//          minimum: 40,
//          maximum: 100,
//          interval: 10)
//    ],
    primaryXAxis:  CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
      title: AxisTitle(text: sample.xcaption),
      labelRotation:sample.xcaprot??0,
      isVisible: sample.xaxisvsbl==0?false:true,
    ),
    primaryYAxis: NumericAxis(
        labelFormat: '{value}',
        title: AxisTitle(text: sample.ycaption),
        //interval: sample.yinterval,
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0)
      ,
      labelRotation:sample.ycaprot??0,
      isVisible: sample.yaxisvsbl==0?false:true,
    ),
    series: getMultipleAxisLineSeries(sample),
    tooltipBehavior: TooltipBehavior(enable: true),
      zoomPanBehavior: zoomingBehavior
  );
}

List<ChartSeries<ChartSampleData, String>> getMultipleAxisLineSeries( ChartsBean sample) {
//  final List<ChartSampleData> chartData = <ChartSampleData>[
//    ChartSampleData(x: DateTime(2019, 5, 1), y: 13, yValue2: 69.8),
//    ChartSampleData(x: DateTime(2019, 5, 2), y: 26, yValue2: 87.8),
//    ChartSampleData(x: DateTime(2019, 5, 3), y: 13, yValue2: 78.8),
//    ChartSampleData(x: DateTime(2019, 5, 4), y: 22, yValue2: 75.2),
//    ChartSampleData(x: DateTime(2019, 5, 5), y: 14, yValue2: 68),
//    ChartSampleData(x: DateTime(2019, 5, 6), y: 23, yValue2: 78.8),
//    ChartSampleData(x: DateTime(2019, 5, 7), y: 21, yValue2: 80.6),
//    ChartSampleData(x: DateTime(2019, 5, 8), y: 22, yValue2: 73.4),
//    ChartSampleData(x: DateTime(2019, 5, 9), y: 16, yValue2: 78.8),
//  ];

  if(sample.mtype=="xyy"){
    return <ChartSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: sample.categoryNames[0]),
      LineSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          name: sample.categoryNames[1])
    ];
  }
  else if(sample.mtype=='xy'){
    return <ChartSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: sample.categoryNames[0]),
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
              child: getMultipleAxisLineChart(sample)),
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