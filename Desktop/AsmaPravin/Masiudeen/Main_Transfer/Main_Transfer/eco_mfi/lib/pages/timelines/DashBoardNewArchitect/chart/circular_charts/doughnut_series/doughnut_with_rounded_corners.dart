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
class DoughnutRounded extends StatefulWidget {
  DoughnutRounded({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _DoughnutRoundedState createState() => _DoughnutRoundedState(sample);
}

class _DoughnutRoundedState extends State<DoughnutRounded> {
  _DoughnutRoundedState(this.sample);
  final SubItem sample;

  @override
  Widget build(BuildContext context) {
    return getScopedModel(getRoundedDoughnutChart(false), sample);
  }
}

SfCircularChart getRoundedDoughnutChart(bool isTileView) {
  return SfCircularChart(
    legend: Legend(
        isVisible: isTileView ? false : true,
        overflowMode: LegendItemOverflowMode.wrap),
    title: ChartTitle(text: isTileView ? '' : 'Software development cycle'),
    series: getRoundedDoughnutSeries(isTileView),
  );
}

List<DoughnutSeries<ChartSampleData, String>> getRoundedDoughnutSeries(
    bool isTileView) {
  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Planning', y: 10),
    ChartSampleData(x: 'Analysis', y: 10),
    ChartSampleData(x: 'Design', y: 10),
    ChartSampleData(x: 'Development', y: 10),
    ChartSampleData(x: 'Testing & Integration', y: 10),
    ChartSampleData(x: 'Maintainance', y: 10)
  ];
  return <DoughnutSeries<ChartSampleData, String>>[
    DoughnutSeries<ChartSampleData, String>(
      dataSource: chartData,
      animationDuration: 0,
      cornerStyle: CornerStyle.bothCurve,
      radius: '80%',
      innerRadius: '60%',
      xValueMapper: (ChartSampleData data, _) => data.x,
      yValueMapper: (ChartSampleData data, _) => data.y,
    ),
  ];
}
