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
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';

//ignore: must_be_immutable
class BubbleGradient extends StatefulWidget {
  BubbleGradient({this.sample, Key key}) : super(key: key);
  SubItem sample;

  @override
  _BubbleGradientState createState() => _BubbleGradientState(sample);
}

class _BubbleGradientState extends State<BubbleGradient> {
 _BubbleGradientState(this.sample); 
  final SubItem sample;

  @override
  Widget build(BuildContext context) {
   return getScopedModel(getGradientBubbleChart(false),sample);   
    }
}


SfCartesianChart getGradientBubbleChart(bool isTileView) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(
        text: isTileView ? '' : 'Circket World cup statistics - till 2015'),
    primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        title: AxisTitle(text: isTileView ? '' : 'Country'),
        labelIntersectAction: AxisLabelIntersectAction.multipleRows),
    primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0),
        title: AxisTitle(text: isTileView ? '' : 'Finals count'),
        minimum: 0,
        maximum: 4,
        interval: 1),
    series: getGradientBubbleSeries(isTileView),
    tooltipBehavior: TooltipBehavior(
      enable: true, header: '', canShowMarker: false,
      // format: 'point.x\nFinal : point.y\nWin : point.size'
    ),
  );
}

List<BubbleSeries<ChartSampleData, String>> getGradientBubbleSeries(bool isTileView) {
  final List<ChartSampleData> chartData = <ChartSampleData>[
     ChartSampleData(x:'England', y:3, yValue:0, pointColor: const Color.fromRGBO(233, 132, 30, 1)),
    ChartSampleData(x:'India', y:3, yValue:2, pointColor:const Color.fromRGBO(0, 255, 255, 1)),
    ChartSampleData(x:'Pakistan', y:2, yValue:1, pointColor:const Color.fromRGBO(255, 200, 102, 1)), 
    ChartSampleData(x:'West\nIndies', y:3, yValue:2, pointColor:const Color.fromRGBO(0, 0, 0, 1)),
    ChartSampleData(x:'Sri\nLanka', y:3, yValue:1, pointColor:const Color.fromRGBO(255, 340, 102, 1)),      
    ChartSampleData(x:'New\nZealand', y:1, yValue:0,pointColor: const Color.fromRGBO(200, 0, 102, 1)) 
  ];
  final List<Color> color = <Color>[];
  color.add(Colors.blue[50]);
  color.add(Colors.blue[200]);
  color.add(Colors.blue);

  final List<double> stops = <double>[];
  stops.add(0.0);
  stops.add(0.5);
  stops.add(1.0);

  final LinearGradient gradientColors =
      LinearGradient(colors: color, stops: stops);
  return <BubbleSeries<ChartSampleData, String>>[
    BubbleSeries<ChartSampleData, String>(
      gradient: gradientColors,
      dataSource: chartData,
      minimumRadius: 5,
      maximumRadius: 10,
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.y,
      sizeValueMapper: (ChartSampleData sales, _) => sales.yValue,
    )
  ];
}
