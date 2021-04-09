/// Package imports
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
/// render the default bar chart samnple.
class DemoBarDefault extends StatefulWidget {
  DemoBarDefault({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _BarDefaultState createState() => _BarDefaultState(sample);
}

/// State class of default bar chart.
class _BarDefaultState extends State<DemoBarDefault> {
  _BarDefaultState(this.sample);
  final SubItem sample;
  @override
  Widget build(BuildContext context) {
    return getDefaultBarChart();
  }

  /// Returns the default cartesian bar chart.
  SfCartesianChart getDefaultBarChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Number of Loan Creation According to states'),
      legend: Legend(isVisible:  true),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          numberFormat: NumberFormat.compact()),
      series: getDefaultBarSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to render on the barchart.
  List<BarSeries<ChartSampleData, String>> getDefaultBarSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'M.P.', y: 84452000, yValue2: 82682000, yValue3: 86861000),
      ChartSampleData(
          x: 'Maharashtra', y: 68175000, yValue2: 75315000, yValue3: 81786000),
      ChartSampleData(
          x: 'U.P', y: 77774000, yValue2: 76407000, yValue3: 76941000),
      ChartSampleData(
          x: 'Punjab', y: 50732000, yValue2: 52372000, yValue3: 58253000),
      ChartSampleData(
          x: 'Bihar', y: 32093000, yValue2: 35079000, yValue3: 39291000),
      ChartSampleData(
          x: 'UK', y: 34436000, yValue2: 35814000, yValue3: 37651000),
    ];
    return <BarSeries<ChartSampleData, String>>[
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: '2018'),
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          name: '2019'),
      BarSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue3,
          name: '2020')
    ];
  }
}