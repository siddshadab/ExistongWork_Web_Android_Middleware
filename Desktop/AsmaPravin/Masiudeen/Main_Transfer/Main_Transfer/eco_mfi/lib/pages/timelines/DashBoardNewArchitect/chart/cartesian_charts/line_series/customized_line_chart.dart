import 'dart:math';
import 'dart:ui';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
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

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
//ignore: must_be_immutable
class CustomizedLine extends StatefulWidget {
  CustomizedLine({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

  @override
  _LineDefaultState createState() => _LineDefaultState();
}

List<num> xValues;
List<num> yValues;

class _LineDefaultState extends State<CustomizedLine> {

  @override
  Widget build(BuildContext context) {
    return PinchZoomingFrontPanel(widget.chartObject);
    return getCustomizedLineChart(true,widget.chartObject);
  }
}

SfCartesianChart getCustomizedLineChart(bool isTileView,ChartsBean sample) {


  return SfCartesianChart(
//    title: ChartTitle(
//      text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),

    legend: Legend(
        isVisible: sample.islegvis==0?false:true,
    //    overflowMode: LegendItemOverflowMode.wrap,
        height: "180.0",

        isResponsive: true,
    overflowMode: LegendItemOverflowMode.scroll,

    orientation: LegendItemOrientation.horizontal


    ),
    primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        title: new AxisTitle(text: sample.xcaption),
      labelRotation:sample.xcaprot??0,
      isVisible: sample.xaxisvsbl==0?false:true,


    ),

    primaryYAxis: NumericAxis(
        labelFormat: '{value}',

        associatedAxisName: "Hell",
        //majorGridLines: MajorGridLines(color: Colors.transparent),
        title: new AxisTitle(text: sample.ycaption),
      labelRotation:sample.ycaprot??0,
      isVisible: sample.yaxisvsbl==0?false:true,


      //labelRotation: 315

    ),
      zoomPanBehavior: zoomingBehavior,

    series: getCustomizedLineSeries(isTileView,sample),
    tooltipBehavior:
        TooltipBehavior(enable: true, header: '', canShowMarker: false),
  );
}

List<CustomLineSeries<_ChartData, String>> getCustomizedLineSeries(
    bool isTileView, ChartsBean  sampleData ) {
   List<_ChartData> chartData = new List<_ChartData>();

//
//   <_ChartData>[
//    _ChartData(DateTime(2018, 7), 2.9),
//    _ChartData(DateTime(2018, 8), 2.7),
//    _ChartData(DateTime(2018, 9), 2.3),
//    _ChartData(DateTime(2018, 10), 2.5),
//    _ChartData(DateTime(2018, 11), 2.2),
//    _ChartData(DateTime(2018, 12), 1.9),
//    _ChartData(DateTime(2019, 1), 1.6),
//    _ChartData(DateTime(2019, 2), 1.5),
//    _ChartData(DateTime(2019, 3), 1.9),
//    _ChartData(DateTime(2019, 4), 2),
//  ];

  if(sampleData.mtype=="xy"){
    if(sampleData.chartSampleData!=null){
      for(int i =0;i<sampleData.chartSampleData.length;i++){
        chartData.add(  _ChartData(sampleData.chartSampleData[i].xValue , sampleData.chartSampleData[i].yValue.toDouble(), 0 )  );

      }
    }

    return <CustomLineSeries<_ChartData, String>>[
      CustomLineSeries<_ChartData, String>(
          animationDuration: 2500,
          enableToolTip: true,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,




          width: 2,
          markerSettings: MarkerSettings(isVisible: true)),
    ];


  }

  if(sampleData.mtype=="xyy"){
    if(sampleData.chartSampleData!=null){
      for(int i =0;i<sampleData.chartSampleData.length;i++){
        chartData.add(  _ChartData(sampleData.chartSampleData[i].xValue
            , sampleData.chartSampleData[i].yValue.toDouble(), sampleData.chartSampleData[i].yValue2.toDouble() ) );

      }
    }

    return <CustomLineSeries<_ChartData, String>>[
      CustomLineSeries<_ChartData, String>(
          animationDuration: 2500,
          enableToolTip: true,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,


          width: 2,
          markerSettings: MarkerSettings(isVisible: true),

      ),
      CustomLineSeries<_ChartData, String>(
          animationDuration: 2500,
          enableToolTip: true,
          dataSource: chartData,



          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,

          width: 2,
          markerSettings: MarkerSettings(isVisible: true))

    ];


  }





}

class _ChartData {
  _ChartData(this.x, this.y , this.y2);
  //_ChartData(this.x, this.y,this.y2);
  final String  x;
  final double y;
  final double y2;

  @override
  String toString() {
    return '_ChartData{x: $x, y: $y m y2 : $y2}';
  }
}

class CustomLineSeries<T, D> extends LineSeries<T, D> {
  CustomLineSeries({
    @required List<T> dataSource,
    @required ChartValueMapper<T, D> xValueMapper,
    @required ChartValueMapper<T, num> yValueMapper,
    String xAxisName,
    String yAxisName,
    Color color,
    double width,
    MarkerSettings markerSettings,
    EmptyPointSettings emptyPointSettings,
    DataLabelSettings dataLabel,
    bool visible,
    bool enableToolTip,
    List<double> dashArray,
    double animationDuration,
  }) : super(
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            color: color,
            width: width,
            markerSettings: markerSettings,
            emptyPointSettings: emptyPointSettings,
            dataLabelSettings: dataLabel,
            isVisible: visible,
            enableTooltip: enableToolTip,
            dashArray: dashArray,
            animationDuration: animationDuration);

  static Random randomNumber = Random();

  @override
  ChartSegment createSegment() {
    return LineCustomPainter(randomNumber.nextInt(4));
  }
}

class LineCustomPainter extends LineSegment {
  LineCustomPainter(int value) {
    //ignore: prefer_initializing_formals
    index = value;
    xValues = <num>[];
    yValues = <num>[];
  }

  double maximum, minimum;
  int index;
  List<Color> colors = <Color>[
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.cyan
  ];

  @override
  Paint getStrokePaint() {
    final Paint customerStrokePaint = Paint();
    customerStrokePaint.color = const Color.fromRGBO(53, 92, 125, 1);
    customerStrokePaint.strokeWidth = 2;
    customerStrokePaint.style = PaintingStyle.stroke;
    return customerStrokePaint;
  }

  @override
  void onPaint(Canvas canvas) {
    final double x1 = this.x1, y1 = this.y1, x2 = this.x2, y2 = this.y2;
    xValues.add(x1);
    xValues.add(x2);
    yValues.add(y1);
    yValues.add(y2);

    final Path path = Path();
    path.moveTo(x1, y1);
    path.lineTo(x2, y2);
    canvas.drawPath(path, getStrokePaint());

    if (currentSegmentIndex == series.segments.length - 1) {
      const double labelPadding = 10;
      final Paint topLinePaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final Paint bottomLinePaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      maximum = yValues.reduce(max);
      minimum = yValues.reduce(min);
      final Path bottomLinePath = Path();
      final Path topLinePath = Path();
      bottomLinePath.moveTo(xValues[0], maximum + 5);
      bottomLinePath.lineTo(xValues[xValues.length - 1], maximum + 5);

      topLinePath.moveTo(xValues[0], minimum - 5);
      topLinePath.lineTo(xValues[xValues.length - 1], minimum - 5);
        canvas.drawPath(
          _dashPath(
            bottomLinePath,
            dashArray: _CircularIntervalList<double>(<double>[15, 3, 3, 3]),
          ),
          bottomLinePaint);

      canvas.drawPath(
          _dashPath(
            topLinePath,
            dashArray: _CircularIntervalList<double>(<double>[15, 3, 3, 3]),
          ),
          topLinePaint);

      final TextSpan span = TextSpan(
        style: TextStyle(
            color: Colors.red[800], fontSize: 12.0, fontFamily: 'Roboto'),
        text: 'Low point',
      );
       TextPainter tp =
          TextPainter(text: span );
      tp.layout();
      tp.paint(
          canvas, Offset(xValues.length<4?1:xValues[xValues.length - 4], maximum + labelPadding));
      final TextSpan span1 = TextSpan(
        style: TextStyle(
            color: Colors.green[800], fontSize: 12.0, fontFamily: 'Roboto'),
        text: 'High point',
      );
      final TextPainter tp1 =
          TextPainter(text: span1);
      tp1.layout();
      tp1.paint(
          canvas,
          Offset(xValues[0] + labelPadding / 2,
              minimum - labelPadding - tp1.size.height));
      yValues.clear();
    }
  }
}

Path _dashPath(
  Path source, {
  @required _CircularIntervalList<double> dashArray,
}) {
  if (source == null) {
    return null;
  }
  const double intialValue = 0.0;
  final Path path = Path();
  for (final PathMetric measurePath in source.computeMetrics()) {
    double distance = intialValue;
    bool draw = true;
    while (distance < measurePath.length) {
      final double length = dashArray.next;
      if (draw) {
        path.addPath(
            measurePath.extractPath(distance, distance + length), Offset.zero);
      }
      distance += length;
      draw = !draw;
    }
  }
  return path;
}

class _CircularIntervalList<T> {
  _CircularIntervalList(this._values);
  final List<T> _values;
  int _index = 0;
  T get next {
    if (_index >= _values.length) {
      _index = 0;
    }
    return _values[_index++];
  }
}



ZoomPanBehavior zoomingBehavior;

//ignore:must_be_immutable
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
                child:getCustomizedLineChart(true,widget.chartObject)),
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

