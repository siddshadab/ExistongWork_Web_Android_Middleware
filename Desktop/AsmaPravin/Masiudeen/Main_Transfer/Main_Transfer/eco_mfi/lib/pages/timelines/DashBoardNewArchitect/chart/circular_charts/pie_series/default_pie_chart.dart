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
class PieDefault extends StatefulWidget {
  PieDefault({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _PieDefaultState createState() => _PieDefaultState(sample);
}

class _PieDefaultState extends State<PieDefault> {
  _PieDefaultState(this.sample);
  SubItem sample;

  @override
  Widget build(BuildContext context) {

     print("sample sample "+sample.chartSampleData.toString());

    return /*getScopedModel(*/getDefaultPieChart(false,sample);//,sample) ;
    //return getScopedModel(getDefaultPieChart(false), sample);
  }
}


SfCircularChart getDefaultPieChart(bool isTileView,SubItem sample) {
//SfCircularChart getDefaultPieChart(bool isTileView) {
  return SfCircularChart(
    title: ChartTitle(text: isTileView ? '' :"DPie" ),
    legend: Legend(isVisible: isTileView ? false : true),
   // series: getDefaultPieSeries(isTileView),
    series: getDefaultPieSeries(isTileView,sample!=null?sample.chartSampleData:null),
  );
}

//List<PieSeries<ChartSampleData, String>> getDefaultPieSeries(bool isTileView) {
List<PieSeries<ChartSampleData, String>> getDefaultPieSeries(
    bool isTileView,List<ChartSampleData> beanValue) {
/*  final List<ChartSampleData> pieData = <ChartSampleData>[
    ChartSampleData(x: 'David', y: 30, text: 'David \n 30%'),
    ChartSampleData(x: 'Steve', y: 35, text: 'Steve \n 35%'),
    ChartSampleData(x: 'Jack', y: 39, text: 'Jack \n 39%'),
    ChartSampleData(x: 'Others', y: 75, text: 'Others \n 75%'),*/
  //];
  return <PieSeries<ChartSampleData, String>>[
    PieSeries<ChartSampleData, String>(
        explode: true,
        explodeIndex: 0,
        explodeOffset: '10%',
        dataSource: beanValue,
        xValueMapper: (ChartSampleData data, _) => data.xValue,
        yValueMapper: (ChartSampleData data, _) => data.yValue,
        dataLabelMapper: (ChartSampleData data, _) => "xx",
        startAngle: 90,
        endAngle: 90,
        dataLabelSettings: DataLabelSettings(isVisible: true)),
  ];
}
