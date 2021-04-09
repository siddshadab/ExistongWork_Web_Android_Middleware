import 'dart:async';
import 'dart:math' as math;
import 'package:scoped_model/scoped_model.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';import 'package:eco_mfi/pages/timelines/ChartsBean.dart';import 'package:eco_mfi/pages/chartsLib/charts.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/checkbox.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/customDropDown.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/custom_button.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



//ignore: must_be_immutable
class AnnotationWatermark extends StatefulWidget {
  AnnotationWatermark({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

  @override
  _AnnotationWatermarkState createState() => _AnnotationWatermarkState();
}

class StoringData{
  double  yValue;
  String xValue;

  StoringData(this.yValue, this.xValue);
}

class _AnnotationWatermarkState extends State<AnnotationWatermark> {
  _AnnotationWatermarkState();

  @override
  Widget build(BuildContext context) {

    return PinchZoomingFrontPanel(widget.chartObject);
    return getWatermarkAnnotationChart(widget.chartObject);
  }
}

SfCartesianChart getWatermarkAnnotationChart(ChartsBean sample) {
  print("Yhan aaya");
  String xValueForLowestY= "";
  num lowestYValue = 0.0;
  StoringData minStorObj = new  StoringData(0,"");
  StoringData maxStorObj = new  StoringData(0,"");


  minStorObj.xValue = sample.chartSampleData[0].xValue;
  minStorObj.yValue = sample.chartSampleData[0].yValue+0.0;
  maxStorObj.xValue = sample.chartSampleData[0].xValue;
  maxStorObj.yValue = sample.chartSampleData[0].yValue+0.0;
  ChartSampleData item;
  for(int i = 0;i< sample.chartSampleData.length-1 ;i++ ){
    item = new ChartSampleData();
    item = sample.chartSampleData[i];
    if(minStorObj.yValue > item.yValue){
      minStorObj.yValue  = item.yValue+0.0;
      minStorObj.xValue  = item.xValue;
    }

    if(maxStorObj.yValue < item.yValue){
      maxStorObj.yValue  = item.yValue+0.0;
      maxStorObj.xValue  = item.xValue;
    }

  }


  print("X lowest value hai ${minStorObj.xValue} ${maxStorObj.yValue}");

  return SfCartesianChart(
//      title: ChartTitle(
//          text: sample.isTile ? sample.mtitle:''),
      legend: Legend( isVisible: sample.islegvis==0?false:true, opacity: 0.7),
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        title: AxisTitle(text: sample.xcaption),
        labelRotation:sample.xcaprot??0,
        isVisible: sample.xaxisvsbl==0?false:true,
      ),
      primaryYAxis: NumericAxis(
          labelRotation:sample.ycaprot??0,
          isVisible: sample.yaxisvsbl==0?false:true,
          labelFormat: '{value}',
          title: AxisTitle(text: sample.ycaption),
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(width: 0)),

      zoomPanBehavior: zoomingBehavior,
      series: getWatermarkAnnotationSeries(sample),
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: Container(
                height:  sample.isTile==true?50:100,
                width:  sample.isTile==true?50:100,
                child: SfCircularChart(
                  series: <PieSeries<ChartSampleData, String>>[
                    PieSeries<ChartSampleData, String>(
                        radius: '90%',
                        enableSmartLabels: false,
                        dataSource:
                    sample.chartSampleData

//                        <ChartSampleData>[
//                          ChartSampleData(
//                              x: 'Facebook',
//                              y: 90,
//                              xValue: '90%',
//                              pointColor: const Color.fromRGBO(0, 63, 92, 1)),
//                          ChartSampleData(
//                              x: 'Twitter',
//                              y: 60,
//                              xValue: '60%',
//                              pointColor: const Color.fromRGBO(242, 117, 7, 1)),
//                          ChartSampleData(
//                              x: 'Instagram',
//                              y: 51,
//                              xValue: '51%',
//                              pointColor: const Color.fromRGBO(89, 59, 84, 1)),
//                          ChartSampleData(
//                              x: 'Snapchat',
//                              y: 50,
//                              xValue: '50%',
//                              pointColor: const Color.fromRGBO(217, 67, 80, 1)),
//                        ]

//                    ,    dataLabelMapper: (ChartSampleData data, _) =>
//                            data.xValue,
                        ,xValueMapper: (ChartSampleData data, _) => data.xValue,
                        yValueMapper: (ChartSampleData data, _) => data.yValue,
//                      xValueMapper: (ChartSampleData data, _) => data.x,
//                      yValueMapper: (ChartSampleData data, _) => data.y,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelIntersectAction: LabelIntersectAction.none,
                            textStyle: ChartTextStyle(
                                color: Colors.white,
                                fontSize:  10 )),
//                        pointColorMapper: (ChartSampleData data, _) =>
//                            data.pointColor

                    )
                  ],
                )),
            coordinateUnit: CoordinateUnit.point,
            region: AnnotationRegion.plotArea,
            x: minStorObj.xValue,
            y: maxStorObj.yValue

        )
      ]);
}

List<ColumnSeries<ChartSampleData, String>> getWatermarkAnnotationSeries(
    ChartsBean sample) {
//  final dynamic chartData = <ChartSampleData>[
//    ChartSampleData(
//        x: 'Facebook',
//        y: 90,
//        xValue: '90',
//        pointColor: const Color.fromRGBO(0, 63, 92, 1)),
//    ChartSampleData(
//        x: 'Twitter',
//        y: 60,
//        xValue: '60',
//        pointColor: const Color.fromRGBO(242, 117, 7, 1)),
//    ChartSampleData(
//        x: 'Instagram',
//        y: 51,
//        xValue: '51',
//        pointColor: const Color.fromRGBO(89, 59, 84, 1)),
//    ChartSampleData(
//        x: 'Snapchat',
//        y: 50,
//        xValue: '50',
//        pointColor: const Color.fromRGBO(217, 67, 80, 1)),
//  ];

  if(sample.mtype=='xy'){
    print("XY m aya  ${sample.chartSampleData}");
    return <ColumnSeries<ChartSampleData, String>>[


      ColumnSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          //pointColorMapper: (ChartSampleData sales, _) => Colors.red,
          width: 0.8,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: ChartTextStyle(
                  color: Colors.white, fontSize: sample.isTile ? 10 : 12),
              labelAlignment: ChartDataLabelAlignment.top)),
    ];
  }else if(sample.mtype=='xyy'){
    return <ColumnSeries<ChartSampleData, String>>[


      ColumnSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          //pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
          width: 0.8,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: ChartTextStyle(
                  color: Colors.white, fontSize: sample.isTile ? 10 : 12),
              labelAlignment: ChartDataLabelAlignment.top)),

      ColumnSeries<ChartSampleData, String>(
          dataSource: sample.chartSampleData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          //pointColorMapper: (ChartSampleData sales, _) => sales.pointColor,
          width: 0.8,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: ChartTextStyle(
                  color: Colors.white, fontSize: sample.isTile ? 10 : 12),
              labelAlignment: ChartDataLabelAlignment.top)),
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
              child: getWatermarkAnnotationChart(sample)),
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
                                  color: Colors.grey),
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
                                  color: Colors.grey),
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
                                  color: Colors.grey),
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
                                  color: Colors.grey),
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
                                  color: Colors.grey),
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
                                  color: Colors.grey),
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
                                  color: Colors.grey),
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
