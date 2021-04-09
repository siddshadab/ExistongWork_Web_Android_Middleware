import 'dart:math';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/customDropDown.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';


import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
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


/// Renders the chart with multiple axes.
class DemoMultipleAxis  extends StatefulWidget {
  DemoMultipleAxis({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _MultipleAxisExampleState createState() => _MultipleAxisExampleState(sample);
}

/// State class of the chart with multiple axes.
class _MultipleAxisExampleState extends State<DemoMultipleAxis> {
  _MultipleAxisExampleState(this.sample);
  final SubItem sample;

  @override
  Widget build(BuildContext context) {
    return getMultipleAxisLineChart();
  }

  /// Returns the chart with multiple axes.
  SfCartesianChart getMultipleAxisLineChart() {
    return SfCartesianChart(
      title: ChartTitle(
          text: 'Target to Disbursment Comparison'),
      legend: Legend(isVisible: true),
      /// API for multiple axis. It can returns the various axis to the chart.
      axes: <ChartAxis>[
        NumericAxis(
            opposedPosition: true,
            name: 'yAxis1',
            majorGridLines: MajorGridLines(width: 0),
            labelFormat: '{value} cr',
            minimum: 40,
            maximum: 100,
            interval: 10)
      ],
      primaryXAxis: DateTimeAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(textStyle: ChartTextStyle( color: Colors.black))),
//      primaryYAxis: NumericAxis(
//        majorGridLines: MajorGridLines(width: 0),
//        opposedPosition: false,
//
//        labelFormat: '{value} cr',
//      ),
      series: getMultipleAxisLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to render on the multiple axes chart.
  List<ChartSeries<ChartSampleData, DateTime>> getMultipleAxisLineSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: DateTime(2019, 5, 1), y: 13, yValue2: 69.8),
      ChartSampleData(x: DateTime(2019, 5, 2), y: 26, yValue2: 87.8),
      ChartSampleData(x: DateTime(2019, 5, 3), y: 13, yValue2: 78.8),
      ChartSampleData(x: DateTime(2019, 5, 4), y: 22, yValue2: 75.2),
      ChartSampleData(x: DateTime(2019, 5, 5), y: 14, yValue2: 68),
      ChartSampleData(x: DateTime(2019, 5, 6), y: 23, yValue2: 78.8),
      ChartSampleData(x: DateTime(2019, 5, 7), y: 21, yValue2: 80.6),
      ChartSampleData(x: DateTime(2019, 5, 8), y: 22, yValue2: 73.4),
      ChartSampleData(x: DateTime(2019, 5, 9), y: 16, yValue2: 78.8),
    ];
    return <ChartSeries<ChartSampleData, DateTime>>[
      ColumnSeries<ChartSampleData, DateTime>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Disbursmnt'),
      LineSeries<ChartSampleData, DateTime>(
          dataSource: chartData,
          yAxisName: 'yAxis1',
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          name: 'Target')
    ];
  }
}