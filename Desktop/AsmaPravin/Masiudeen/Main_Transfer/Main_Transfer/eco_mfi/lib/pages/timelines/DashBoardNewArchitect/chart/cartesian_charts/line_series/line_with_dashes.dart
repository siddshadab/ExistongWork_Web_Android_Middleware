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
class LineDashed extends StatefulWidget {
  LineDashed({this.sample, Key key}) : super(key: key);
   final SubItem sample;

  @override
  _LineDashedState createState() => _LineDashedState(sample);
}

class _LineDashedState extends State<LineDashed> {
   _LineDashedState(this.sample);
   final SubItem sample;
  
  @override
  Widget build(BuildContext context) {
    return getDashedLineChart(false,sample);
    }
}

SfCartesianChart getDashedLineChart(bool isTileView,SubItem sample) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(
        text: isTileView ?  'Capital investment as a share of exports': '' ),
    legend: Legend(
        isVisible: isTileView ? false : true,
        overflowMode: LegendItemOverflowMode.wrap),
    primaryXAxis: CategoryAxis(
     // labelStyle: ChartTextStyle(color: Colors.white),
      axisLine: AxisLine(width: 0),
      majorTickLines: MajorTickLines(width: 0),
      majorGridLines: MajorGridLines(width: 0),
    ),
    primaryYAxis: NumericAxis(
       // minimum: sample.yminval.toDouble(),
        interval: sample.yinterval,
        labelFormat: '{value}',
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(color: Colors.transparent)),
    series: getDashedLineSeries(isTileView,sample),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

List<LineSeries<ChartSampleData, String>> getDashedLineSeries(bool isTileView,SubItem sample) {


  if(sample.mtype=="xy"){
    return <LineSeries<ChartSampleData, String>>[
      LineSeries<ChartSampleData, String>(
          animationDuration: 2500,
          enableTooltip: true,
          dashArray:<double>[15, 3, 3, 3],
          dataSource: sample.chartSampleData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          width: 2,
          name: 'Singapore',
          markerSettings: MarkerSettings(isVisible: true)),

    ];
  }

  if(sample.mtype=="xyy"){
    return <LineSeries<ChartSampleData, String>>[
      LineSeries<ChartSampleData, String>(
          animationDuration: 2500,
          enableTooltip: true,
          dashArray:<double>[15, 3, 3, 3],
          dataSource: sample.chartSampleData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          width: 2,
          name: 'Singapore',
          markerSettings: MarkerSettings(isVisible: true)),
      LineSeries<ChartSampleData, String>(
          animationDuration: 2500,
          enableTooltip: true,
          dashArray:<double>[15, 3, 3, 3],
          dataSource: sample.chartSampleData,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          width: 2,
          name: 'Target',
          markerSettings: MarkerSettings(isVisible: true)),

    ];
  }

}

class _ChartData {
  _ChartData({this.x, this.y, this.y2, this.y3, this.y4});
  final double x;
  final double y;
  final double y2;
  final double y3;
  final double y4;
}
