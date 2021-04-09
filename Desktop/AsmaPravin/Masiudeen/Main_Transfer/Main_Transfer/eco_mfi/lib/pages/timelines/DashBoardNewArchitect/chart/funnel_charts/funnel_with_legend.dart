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

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';

//ignore: must_be_immutable
class FunnelLegend extends StatefulWidget {
  FunnelLegend({this.subItemList, Key key}) : super(key: key);
  final SubItem subItemList;
  
  @override
  _FunnelLegendState createState() => _FunnelLegendState(subItemList);
}

class _FunnelLegendState extends State<FunnelLegend> {
  _FunnelLegendState(this.subItemList);
  final SubItem subItemList;
  
  @override
  Widget build(BuildContext context) {
     return getScopedModel(getLegendFunnelChart(false), subItemList);
  }
}
SfFunnelChart getLegendFunnelChart(bool isTileView) {
  return SfFunnelChart(
    smartLabelMode: SmartLabelMode.none,
    title: ChartTitle(
        text: isTileView ? '' : 'Monthly expenditure of an individual'),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
    tooltipBehavior:
        TooltipBehavior(enable: true, format: 'point.x : point.y%'),
    series: _getFunnelSeries(isTileView),
  );
}

FunnelSeries<ChartSampleData, String> _getFunnelSeries(bool isTileView) {
  final List<ChartSampleData> pieData = <ChartSampleData>[
    ChartSampleData(x:'Others', y:10, text:'10%'),
    ChartSampleData(x:'Medical ', y:11, text:'11%'),
    ChartSampleData(x:'Saving ', y:14, text:'14%'),
    ChartSampleData(x:'Shopping',y: 17, text:'17%'),
    ChartSampleData(x:'Travel', y:21, text:'21%'),
    ChartSampleData(x:'Food', y:27, text:'27%'),
  ];
  return FunnelSeries<ChartSampleData, String>(
        dataSource: pieData,
        textFieldMapper: (ChartSampleData data, _) => data.text,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelSettings: DataLabelSettings(
            isVisible: isTileView ? false : true,
            labelPosition: ChartDataLabelPosition.inside));
}
