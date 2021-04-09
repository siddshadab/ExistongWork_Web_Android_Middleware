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


import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
//ignore: must_be_immutable
class DemoCustomizedLine extends StatefulWidget {
DemoCustomizedLine({this.sample, Key key}) : super(key: key);
SubItem sample;

@override
_LineDefaultState createState() => _LineDefaultState(sample);
}

List<num> xValues;
List<num> yValues;
List<num> xPointValues = <num>[];
List<num> yPointValues = <num>[];

class _LineDefaultState extends State<DemoCustomizedLine> {
  _LineDefaultState(this.sample);
  final SubItem sample;

  @override
  Widget build(BuildContext context) {
    return getCustomizedLineChart();
  }

  SfCartesianChart getCustomizedLineChart() {
    return SfCartesianChart(

      primaryXAxis: DateTimeAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        dateFormat: DateFormat.yMMM(),
        intervalType: DateTimeIntervalType.months,

      ),
      primaryYAxis: NumericAxis(

          majorGridLines: MajorGridLines(color: Colors.transparent),
          title:new AxisTitle(
      ),
      ),
      series: <ChartSeries<_ChartData, DateTime>>[
        LineSeries<_ChartData, DateTime>(

            animationDuration: 2500,
            enableTooltip: true,
            dataSource: <_ChartData>[
              _ChartData(DateTime(2019, 7), 11433),
              _ChartData(DateTime(2019, 8), 12520),
              _ChartData(DateTime(2019, 9), 14455),
              _ChartData(DateTime(2019, 10), 13500),
              _ChartData(DateTime(2019, 11), 16500),
              _ChartData(DateTime(2019, 12), 16830),
            ],
            xValueMapper: (_ChartData sales, _) => sales.x,
            yValueMapper: (_ChartData sales, _) => sales.y,
            width: 2,
            markerSettings: MarkerSettings(isVisible: true)),
      ],
      tooltipBehavior:
      TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final double y;
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

  void storeValues() {
    xPointValues.add(x1);
    xPointValues.add(x2);
    yPointValues.add(y1);
    yPointValues.add(y2);
    xValues.add(x1);
    xValues.add(x2);
    yValues.add(y1);
    yValues.add(y2);
  }

  @override
  void onPaint(Canvas canvas) {
    final double x1 = this.x1, y1 = this.y1, x2 = this.x2, y2 = this.y2;
    storeValues();
    final Path path = Path();
    path.moveTo(x1, y1);
    path.lineTo(x2, y2);
    canvas.drawPath(path, getStrokePaint());

    if (currentSegmentIndex == series.dataSource.length - 2) {
      const double labelPadding = 10;
      final Paint topLinePaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final Paint bottomLinePaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      maximum = yPointValues.reduce(max);
      minimum = yPointValues.reduce(min);
      final Path bottomLinePath = Path();
      final Path topLinePath = Path();
      bottomLinePath.moveTo(xPointValues[0], maximum);
      bottomLinePath.lineTo(xPointValues[xPointValues.length - 1], maximum);

      topLinePath.moveTo(xPointValues[0], minimum);
      topLinePath.lineTo(xPointValues[xPointValues.length - 1], minimum);
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
      final TextPainter tp =
      TextPainter(text: span, );
      tp.layout();
      tp.paint(
          canvas,
          Offset(
              xPointValues[xPointValues.length - 4], maximum + labelPadding));
      final TextSpan span1 = TextSpan(
        style: TextStyle(
            color: Colors.green[800], fontSize: 12.0, fontFamily: 'Roboto'),
        text: 'High point',
      );
      final TextPainter tp1 =
      TextPainter(text: span1, );
      tp1.layout();
      tp1.paint(
          canvas,
          Offset(xPointValues[0] + labelPadding / 2,
              minimum - labelPadding - tp1.size.height));
      yValues.clear();
      yPointValues.clear();
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
