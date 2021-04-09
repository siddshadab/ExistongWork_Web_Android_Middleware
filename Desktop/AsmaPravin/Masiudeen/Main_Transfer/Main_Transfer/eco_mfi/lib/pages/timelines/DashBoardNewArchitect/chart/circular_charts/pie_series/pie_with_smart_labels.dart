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
class PieSmartLabels extends StatefulWidget {
  PieSmartLabels({this.sample, Key key}) : super(key: key);
  final SubItem sample;

  @override
  _PieSmartLabelsState createState() => _PieSmartLabelsState(sample);
}

class _PieSmartLabelsState extends State<PieSmartLabels> {
  _PieSmartLabelsState(this.sample);
  final SubItem sample;

  @override
  Widget build(BuildContext context) {
    return getScopedModel(getSmartLabelPieChart(false), sample);
  }
}

SfCircularChart getSmartLabelPieChart(bool isTileView) {
  return SfCircularChart(
    title: ChartTitle(text: isTileView ? '' : 'Largest islands in the world'),
    series: gettSmartLabelPieSeries(isTileView),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

List<PieSeries<ChartSampleData, String>> gettSmartLabelPieSeries(
    bool isTileView) {
  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Greenland', y: 2130800),
    ChartSampleData(x: 'New\nGuinea', y: 785753),
    ChartSampleData(x: 'Borneo', y: 743330),
    ChartSampleData(x: 'Madagascar', y: 587713),
    ChartSampleData(x: 'Baffin\nIsland', y: 507451),
    ChartSampleData(x: 'Sumatra', y: 443066),
    ChartSampleData(x: 'Honshu', y: 225800),
    ChartSampleData(x: 'Victoria\nIsland', y: 217291),
  ];
  return <PieSeries<ChartSampleData, String>>[
    PieSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        dataLabelMapper: (ChartSampleData data, _) => data.x,
        radius: '65%',
        startAngle: 80,
        endAngle: 80,
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            connectorLineSettings:
                ConnectorLineSettings(type: ConnectorType.curve)))
  ];
}
