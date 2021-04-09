import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/chartsLib/charts.dart';


//ignore: must_be_immutable
class LineDefault extends StatefulWidget {
  LineDefault({this.sample, Key key}) : super(key: key);
   SubItem sample;

 // LineDefault(this.sample, {this.animate});
  @override
  _LineDefaultState createState() => _LineDefaultState(sample);
}

class _LineDefaultState extends State<LineDefault> {
  _LineDefaultState(this.sample);


  SubItem sample;
  final List<String> _zoomModeTypeList = <String>['x', 'y', 'xy'].toList();
  String _selectedModeType = 'x';
  ZoomMode _zoomModeType = ZoomMode.x;

  ZoomPanBehavior zoomingBehavior;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();


   // getCallQuery(null);
  }




  @override
  Widget build(BuildContext context) {
    return /*getScopedModel(*/getDefaultLineChart(false,sample)/*,sample) */;
}

}
  SfCartesianChart getDefaultLineChart(bool isTileView,SubItem sample) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(text: isTileView ? '' :sample.title),
    legend: Legend(
        isVisible: isTileView ? false : true,
        overflowMode: LegendItemOverflowMode.wrap),
    primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 2,
        majorGridLines: MajorGridLines(width: 0)),
    primaryYAxis: NumericAxis(
        labelFormat: '{value}',
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(color: Colors.transparent)),
    series: getDefaultLineSeries(isTileView,sample!=null?sample.chartSampleData:null),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}


  List<LineSeries<ChartSampleData, num>> getDefaultLineSeries(
      bool isTileView,List<ChartSampleData> beanValue) {

  return <LineSeries<ChartSampleData, num>>[
    LineSeries<ChartSampleData, num>(
        animationDuration: 2500,
        enableTooltip: true,
        dataSource: beanValue,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        xValueMapper: (ChartSampleData sales, _) => sales.yValue,
        width: 2,
        name: "",
        markerSettings: MarkerSettings(isVisible: true)),
    LineSeries<ChartSampleData, num>(
        animationDuration: 2500,
        enableTooltip: true,
        dataSource: beanValue,
        width: 2,
        name: "",
        xValueMapper: (ChartSampleData sales, _) => sales.yValue,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        markerSettings: MarkerSettings(isVisible: true))
  ];
}


class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}
