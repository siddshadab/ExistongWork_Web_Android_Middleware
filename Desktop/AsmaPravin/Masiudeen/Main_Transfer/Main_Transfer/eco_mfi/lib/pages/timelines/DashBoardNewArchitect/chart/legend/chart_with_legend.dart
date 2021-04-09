import 'dart:async';
import 'dart:math' as math;
import 'package:scoped_model/scoped_model.dart';
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


//ignore: must_be_immutable
class LegendDefault extends StatefulWidget {
  LegendDefault({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _LegendDefaultState createState() => _LegendDefaultState(sample);
}

class _LegendDefaultState extends State<LegendDefault> {
  _LegendDefaultState(this.sample);
  final SubItem sample;

  @override
  Widget build(BuildContext context) {
    return getScopedModel(getLegendDefaultChart(false), sample);
  }
}

SfCircularChart getLegendDefaultChart(bool isTileView) {
  return SfCircularChart(
    title: ChartTitle(text: isTileView ? '' : 'Electricity sectors'),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
    series: getLegendDefaultSeries(isTileView),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

List<DoughnutSeries<ChartSampleData, String>> getLegendDefaultSeries(
    bool isTileView) {
  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Coal', y: 56.2),
    ChartSampleData(x: 'Large Hydro', y: 12.7),
    ChartSampleData(x: 'Small Hydro', y: 1.3),
    ChartSampleData(x: 'Wind Power', y: 10),
    ChartSampleData(x: 'Solar Power', y: 8),
    ChartSampleData(x: 'Biomass', y: 2.6),
    ChartSampleData(x: 'Nuclear', y: 1.9),
    ChartSampleData(x: 'Gas', y: 7),
    ChartSampleData(x: 'Diesel', y: 0.2)
  ];
  return <DoughnutSeries<ChartSampleData, String>>[
    DoughnutSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: DataLabelSettings(
            isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
  ];
}
