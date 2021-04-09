import 'package:eco_mfi/pages/chartsLib/charts.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';


import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';



class DemoColumnDefault extends StatefulWidget {
  DemoColumnDefault({this.sample, Key key}) : super(key: key);
  SubItem sample;

  // ColumnDefault(this.seriesList, {this.animate});
  @override
  _ColumnDefaultState createState() => _ColumnDefaultState(sample);
}

class _ColumnDefaultState extends State<DemoColumnDefault>  {
  _ColumnDefaultState(this.sample);
  SubItem sample;


  @override
  Widget build(BuildContext context) {
    return getDefaultColumnChart();
  }

  SfCartesianChart getDefaultColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          text:  'Performace for past 6 months'),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        title:new AxisTitle(
          text: "Months"
        ),
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}',
          majorTickLines: MajorTickLines(size: 0),
        title:new AxisTitle(
            text: "Customers Created "
        ),

      ),
      series: getDefaultColumnSeries(),
      tooltipBehavior:
      TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }

  List<ColumnSeries<ChartSampleData, String>> getDefaultColumnSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'July19', y: 11433),
      ChartSampleData(x: 'Aug19', y: 12520),
      ChartSampleData(x: 'Sept19', y: 14455),
      ChartSampleData(x: 'Oct19', y: 13500),
      ChartSampleData(x: 'Nov19', y: 16500),
      ChartSampleData(x: 'Dec19 ', y: 16830),
    ];
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle:  ChartTextStyle(fontSize: 10)),
      )
    ];
  }
}
