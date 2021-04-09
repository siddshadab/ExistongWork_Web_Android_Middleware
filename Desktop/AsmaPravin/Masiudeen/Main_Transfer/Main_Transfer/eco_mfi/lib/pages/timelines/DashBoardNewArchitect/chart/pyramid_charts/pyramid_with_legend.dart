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
class PyramidLegend extends StatefulWidget {
  PyramidLegend({this.subItemList, Key key}) : super(key: key);
  final SubItem subItemList;
  
  @override
  _PyramidLegendState createState() => _PyramidLegendState(subItemList);
}

class _PyramidLegendState extends State<PyramidLegend> {
  _PyramidLegendState(this.subItemList);
  final SubItem subItemList;
  
  @override
  Widget build(BuildContext context) {
     return getScopedModel(getLegendPyramidChart(false), subItemList);
  }
}

SfPyramidChart getLegendPyramidChart(bool isTileView) {
  return SfPyramidChart(
    onTooltipRender: (TooltipArgs args) {
      List<String> data;
      String text;
      text = args.dataPoints[args.pointIndex].y.toString();
      if (text.contains('.')) {
        data = text.split('.');
        final String newTe =
            data[0].toString() + ' years ' + data[1].toString() + ' months';
        args.text = newTe;
      } else {
        args.text = text + ' years';
      }
    },
    smartLabelMode: SmartLabelMode.none,
    title:
        ChartTitle(text: isTileView ? '' : 'Experience of employees in a team'),
    legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
    tooltipBehavior: TooltipBehavior(enable: true),
    series: _getPyramidSeries(isTileView),
  );
}

PyramidSeries<ChartSampleData, String> _getPyramidSeries(bool isTileView) {
  final List<ChartSampleData> pieData = <ChartSampleData>[
    ChartSampleData(x:'Ray', y:7.3),
    ChartSampleData(
      x:'Michael',
      y:6.6,
    ),
    ChartSampleData(
      x:'John ',
     y: 3,
    ),
    ChartSampleData(
      x:'Mercy',
      y:0.8,
    ),
    ChartSampleData(
     x:'Tina ',
      y:1.4,
    ),
    ChartSampleData(
      x:'Stephen',
      y:5.2,
    ),
  ];
  return PyramidSeries<ChartSampleData, String>(
        dataSource: pieData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelSettings: DataLabelSettings(
            isVisible: isTileView ? false : true,
            labelPosition: ChartDataLabelPosition.inside));
}

