import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

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
import 'package:scoped_model/scoped_model.dart';



//ignore: must_be_immutable
class NumericDefault extends StatefulWidget {
  final bool animate;
  final List<NumTypeBean> seriesList;

  NumericDefault(this.seriesList, {this.animate});
  @override
  _NumericDefaultState createState() => _NumericDefaultState(seriesList);
}



class _NumericDefaultState extends State<NumericDefault> {
  _NumericDefaultState(this.seriesList);

  final List<NumTypeBean> seriesList;
  final List<String> _zoomModeTypeList = <String>['x', 'y', 'xy'].toList();
  String _selectedModeType = 'x';
  ZoomMode _zoomModeType = ZoomMode.x;
  ZoomPanBehavior zoomingBehavior;


  @override
  Widget build(BuildContext context) {
    return getDefaultNumericAxisChart(false, seriesList);
  }


  SfCartesianChart getDefaultNumericAxisChart(bool isTileView,
      List<NumTypeBean> beanValue) {
    return SfCartesianChart(
      title: ChartTitle(
          text: isTileView ? '' : 'Australia vs India ODI - 2019'),
      plotAreaBorderWidth: 0,
      legend: Legend(
          isVisible: isTileView ? false : true, position: LegendPosition.top),
      primaryXAxis: NumericAxis(
          title: AxisTitle(text: isTileView ? '' : 'Match'),
          minimum: 0,
          maximum: 6,
          interval: 1,
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          edgeLabelPlacement: EdgeLabelPlacement.hide),
      primaryYAxis: NumericAxis(
          title: AxisTitle(text: isTileView ? '' : 'Score'),
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: getDefaultNumericSeries(isTileView, beanValue),
      tooltipBehavior: TooltipBehavior(
          enable: true, format: 'Score: point.y', canShowMarker: false),
    );
  }

  List<ColumnSeries<NumTypeBean, num>> getDefaultNumericSeries(bool isTileView,
      List<NumTypeBean> beanValue) {
    return <ColumnSeries<NumTypeBean, num>>[
      ColumnSeries<NumTypeBean, num>(
          enableTooltip: true,
          dataSource: beanValue,
          color: const Color.fromRGBO(237, 221, 76, 1),
          name: 'Australia',
          xValueMapper: (NumTypeBean sales, _) => sales.yAxis,
          yValueMapper: (NumTypeBean sales, _) => sales.yAxis),
      ColumnSeries<NumTypeBean, num>(
          enableTooltip: true,
          dataSource: beanValue,
          color: const Color.fromRGBO(2, 109, 213, 1),
          xValueMapper: (NumTypeBean sales, _) => sales.xAxis,
          yValueMapper: (NumTypeBean sales, _) => sales.y1Axis,
          name: 'India'),
    ];
  }

}