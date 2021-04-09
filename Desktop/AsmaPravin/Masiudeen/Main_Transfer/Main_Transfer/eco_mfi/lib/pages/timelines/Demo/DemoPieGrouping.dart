/// Package import
import 'package:flutter/material.dart';


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
class DemoPieGrouping extends StatefulWidget {
  DemoPieGrouping({this.sample, Key key}) : super(key: key);
  final SubItem sample;

  @override
  _PieGroupingState createState() => _PieGroupingState();
}

class _PieGroupingState  extends State<DemoPieGrouping> {
  _PieGroupingState();
  @override
  Widget build(BuildContext context) {
    return getGroupingPieChart();
  }

  /// Return the circular charts with pie series.
  SfCircularChart getGroupingPieChart() {
    return SfCircularChart(
      title: ChartTitle(text:''),
      series: getGroupingPieSeries(false),
      tooltipBehavior:
      TooltipBehavior(enable: true, format: 'point.x : point.y%'),
    );
  }

  /// Return the list of pie series which need to be grouping.
  List<PieSeries<ChartSampleData, String>> getGroupingPieSeries(bool isCardView) {
    final List<ChartSampleData> pieData = <ChartSampleData>[
      ChartSampleData(
          x: 'Disbursed',
          y: 56.2,
          text: 'Disbursed: 200,704.5 MW (56.2%)',
          pointColor: null),
      ChartSampleData(
          x: 'Credit\nBereau\nReject',
          y: 22.7,
          text: 'Credit Bereau Reject: 45,399.22 MW (22.7%)',
          pointColor: null),
      ChartSampleData(
          x: 'Small\nHydro',
          y: 1.3,
          text: 'Small Hydro: 4,594.15 MW (1.3%)',
          pointColor: null),
      ChartSampleData(
          x: 'In\nProcess',
          y: 10,
          text: 'In Process: 35,815.88 MW (20.0%)',
          pointColor: null),
      ChartSampleData(
          x: 'Tele Calling\nReject',
          y: 8,
          text: 'Tele Calling Reject: 28,679.21 MW (8.0%)',
          pointColor: const Color.fromRGBO(198, 201, 207, 1)),


    ];
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          radius: '70%',
          dataLabelMapper: (ChartSampleData data, _) => data.x,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.inside),
          dataSource: pieData,
          startAngle: 90,
          endAngle: 90,
          /// To enable and specify the group mode for pie chart.
          groupMode: CircularChartGroupMode.value,
          groupTo: 7,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y)
    ];
  }
}