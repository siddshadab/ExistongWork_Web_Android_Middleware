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
class ColumnBack extends StatefulWidget {
  ColumnBack({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _ColumnBackState createState() => _ColumnBackState(sample);
}

class _ColumnBackState extends State<ColumnBack> {
  _ColumnBackState(this.sample);
  final SubItem sample;
  @override
  Widget build(BuildContext context) {
   // return getScopedModel(getBackColumnChart(false), sample);

    print("sample sample sample1 ${sample.toString()}");
    return getBackColumnChart(false,sample);
  }
}
SfCartesianChart getBackColumnChart(bool isTileView,SubItem sample) {
  print("sample sample samplexxxxxxxxxxxx ${sample.toString()}");
//SfCartesianChart getBackColumnChart(bool isTileView) {
  return SfCartesianChart(
      plotAreaBorderWidth: 0,
      enableSideBySideSeriesPlacement: false,
      title:
          ChartTitle(text: isTileView ? '' : sample.title),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          majorTickLines: MajorTickLines(size: 0),
          numberFormat: NumberFormat.compact(),
          majorGridLines: MajorGridLines(width: 0),
          rangePadding: ChartRangePadding.additional),
      series: getBackToBackColumn(isTileView),
      tooltipBehavior: TooltipBehavior(enable: true));
}

List<ColumnSeries<ChartSampleData, String>> getBackToBackColumn(
    bool isTileView) {
  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(
        x: 'France', y: 63621381, yValue: 65027507, yValue2: 66316092),
    ChartSampleData(
        x: 'United Kingdom',
        y: 60846820,
        yValue: 62766365,
        yValue2: 64613160),
    ChartSampleData(
        x: 'Italy', y: 58143979, yValue: 59277417, yValue2: 60789140),
  ];
  return <ColumnSeries<ChartSampleData, String>>[
    ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        width: 0.7,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
        name: '2014'),
    ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        width: 0.5,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        name: '2010'),
    ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        width: 0.3,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        name: '2006')
  ];
}
