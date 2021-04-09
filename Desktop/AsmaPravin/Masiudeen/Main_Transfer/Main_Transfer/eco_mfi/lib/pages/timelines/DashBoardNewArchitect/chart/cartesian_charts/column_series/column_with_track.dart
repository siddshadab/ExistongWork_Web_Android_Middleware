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
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';

//ignore: must_be_immutable
class ColumnTracker extends StatefulWidget {
  ColumnTracker({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _ColumnTrackerState createState() => _ColumnTrackerState(sample);
}

class _ColumnTrackerState extends State<ColumnTracker> {
  _ColumnTrackerState(this.sample);
  final SubItem sample;

  @override
  Widget build(BuildContext context) {
    return getScopedModel(getTrackerColumnChart(false,sample),sample) ;
    //return getScopedModel(getTrackerColumnChart(false),sample);
  }
}


SfCartesianChart getTrackerColumnChart(bool isTileView,SubItem sample) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(text: isTileView ? '' : 'Marks of a student'),
    legend: Legend(isVisible: isTileView ? false : true),
    primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
    primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 100,
        axisLine: AxisLine(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        majorTickLines: MajorTickLines(size: 0)),
    series: getTracker(isTileView,sample!=null?sample.chartSampleData:null),
    tooltipBehavior: TooltipBehavior(
        enable: true,
        canShowMarker: false,
        header: '',
        format: 'point.y marks in point.x'),
  );
}

List<ColumnSeries<ChartSampleData, String>> getTracker(bool isTileView,List<ChartSampleData> beanValue) {
/*  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x:'Subject 1',y: 71),
    ChartSampleData(x:'Subject 2',y: 84),
    ChartSampleData(x:'Subject 3', y:48),
    ChartSampleData(x:'Subject 4', y:80),
    ChartSampleData(x:'Subject 5', y: 76),*/
  //];
  return <ColumnSeries<ChartSampleData, String>>[
    ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: beanValue,
        isTrackVisible: true,
        trackColor:const Color.fromRGBO(198, 201, 207, 1),
        borderRadius: BorderRadius.circular(15),
        xValueMapper: (ChartSampleData sales, _) => sales.xValue,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        name: 'Marks',
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: ChartTextStyle(fontSize: 10, color: Colors.white)))
  ];
}

