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
class PieGrouping extends StatefulWidget {
  PieGrouping({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

  @override
  _PieGroupingState createState() => _PieGroupingState();
}

class _PieGroupingState extends State<PieGrouping> {

   @override
  Widget build(BuildContext context) {
    //return getScopedModel(getGroupingPieChart(false), sample);
     return /*getScopedModel(*/getGroupingPieChart(widget.chartObject);//,sample) ;
  }
}

//SfCircularChart getGroupingPieChart(bool isTileView) {
SfCircularChart getGroupingPieChart(ChartsBean sample) {
  return SfCircularChart(
//    title: ChartTitle(
//      text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
    //series: getGroupingPieSeries(isTileView),
    series: getGroupingPieSeries(sample!=null?sample.chartSampleData:null),
    tooltipBehavior:
        TooltipBehavior(enable: true, format: 'point.x : point.y'),
  );
}

List<PieSeries<ChartSampleData, String>> getGroupingPieSeries(
    List<ChartSampleData> beanValue) {
  return <PieSeries<ChartSampleData, String>>[
    PieSeries<ChartSampleData, String>(
        radius: '70%',
        dataLabelMapper: (ChartSampleData data, _) => data.xValue,
        dataLabelSettings: DataLabelSettings(
            isVisible: true, labelPosition: ChartDataLabelPosition.inside),
        dataSource: beanValue,
        startAngle: 90,
        endAngle: 90,
        groupMode: CircularChartGroupMode.value,
      //  groupTo: 7,
        pointColorMapper: (ChartSampleData data, _) => data.pointColor,
        xValueMapper: (ChartSampleData data, _) => data.xValue,
        yValueMapper: (ChartSampleData data, _) => data.yValue)
  ];
}
