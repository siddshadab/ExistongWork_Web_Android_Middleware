import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/chartsLib/charts.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/checkbox.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/customDropDown.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';

/// Render chart series with vertical gradient.
class VerticalGradient extends StatefulWidget {
  /// Creates chart series with vertical gradient.
  VerticalGradient({this.chartObject, Key key}) : super(key: key);

     final ChartsBean chartObject;


  @override
  VerticalGradientState createState() => VerticalGradientState();
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String x;
  final double y;
}

/// State class of vertical gradient.
class VerticalGradientState extends State<VerticalGradient> {
  VerticalGradientState();

  @override
  Widget build(BuildContext context) {
    //return PinchZoomingFrontPanel(widget.chartObject);
    return getVerticalGradientAreaChart(widget.chartObject);
  }
}

  /// Returns the list of spline area series with vertical gradient.
  List<ChartSeries<ChartSampleData, String>> _getGradientAreaSeries(ChartsBean chartData) {


    final List<Color> color = <Color>[];
    color.add(const Color(0xFF6A31D5));
    color.add(const Color(0xFFB650C8));

    final List<double> stops = <double>[];
    stops.add(0.1);
    stops.add(0.4);
    if (chartData.mtype=="xy"){
      return <ChartSeries<ChartSampleData, String>>[
        SplineAreaSeries<ChartSampleData, String>(

          /// To set the gradient colors for series.
            gradient: const LinearGradient(colors: <Color>[
              Color.fromRGBO(269, 210, 255, 1),
              Color.fromRGBO(143, 236, 154, 1)
            ], stops: <double>[
              0.2,
              0.6
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderWidth: 2,
            borderColor: const Color.fromRGBO(0, 156, 144, 1),
            borderDrawMode: BorderDrawMode.top,
            dataSource: chartData.chartSampleData,
            name:chartData.categoryNames[0]??'',
            xValueMapper: (ChartSampleData sales, _) => sales.xValue,
            yValueMapper: (ChartSampleData sales, _) => sales.yValue),
      ];

    }
    if (chartData.mtype=="xyy"){
      return <ChartSeries<ChartSampleData, String>>[
        SplineAreaSeries<ChartSampleData, String>(

          /// To set the gradient colors for series.
            gradient: const LinearGradient(colors: <Color>[
              Color.fromRGBO(269, 210, 255, 1),
              Color.fromRGBO(143, 236, 154, 1)
            ], stops: <double>[
              0.2,
              0.6
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderWidth: 2,
            borderColor: const Color.fromRGBO(0, 156, 144, 1),
            borderDrawMode: BorderDrawMode.top,
            dataSource: chartData.chartSampleData,
            name:chartData.categoryNames[0]??'',
            xValueMapper: (ChartSampleData sales, _) => sales.xValue,
            yValueMapper: (ChartSampleData sales, _) => sales.yValue),

        SplineAreaSeries<ChartSampleData, String>(
            gradient: const LinearGradient(colors: <Color>[
              Color.fromRGBO(140, 108, 245, 1),
              Color.fromRGBO(125, 185, 253, 1)
            ], stops: <double>[
              0.3,
              0.7
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderWidth: 2,
            name: chartData.categoryNames[1]??'',
            borderColor: const Color.fromRGBO(0, 63, 136, 1),
            borderDrawMode: BorderDrawMode.top,
            dataSource: chartData.chartSampleData,
            xValueMapper: (ChartSampleData sales, _) => sales.xValue,
            yValueMapper: (ChartSampleData sales, _) => sales.yValue2),


      ];

    }
    else{
      final List<ChartSampleData> chartData2 = <ChartSampleData>[
        ChartSampleData(x: '1997', y: 22.44),
        ChartSampleData(x: '1998', y: 25.18),
        ChartSampleData(x: '1999', y: 24.15),
        ChartSampleData(x: '2000', y: 25.83),
        ChartSampleData(x: '2001', y: 25.69),
        ChartSampleData(x: '2002', y: 24.75),
        ChartSampleData(x: '2003', y: 27.38),
        ChartSampleData(x: '2004', y: 25.31)
      ];


      return <ChartSeries<ChartSampleData, String>>[
        SplineAreaSeries<ChartSampleData, String>(

          /// To set the gradient colors for series.
            gradient: const LinearGradient(colors: <Color>[
              Color.fromRGBO(269, 210, 255, 1),
              Color.fromRGBO(143, 236, 154, 1)
            ], stops: <double>[
              0.2,
              0.6
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderWidth: 2,
            borderColor: const Color.fromRGBO(0, 156, 144, 1),
            borderDrawMode: BorderDrawMode.top,
            dataSource: chartData2,
            name: 'Country 1',
            xValueMapper: (ChartSampleData sales, _) => sales.x,
            yValueMapper: (ChartSampleData sales, _) => sales.y),
        SplineAreaSeries<ChartSampleData, String>(
            gradient: const LinearGradient(colors: <Color>[
              Color.fromRGBO(140, 108, 245, 1),
              Color.fromRGBO(125, 185, 253, 1)
            ], stops: <double>[
              0.3,
              0.7
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderWidth: 2,
            name: 'Country 2',
            borderColor: const Color.fromRGBO(0, 63, 136, 1),
            borderDrawMode: BorderDrawMode.top,
            dataSource: <ChartSampleData>[
              ChartSampleData(x: '1997', y: 17.5),
              ChartSampleData(x: '1998', y: 21.5),
              ChartSampleData(x: '1999', y: 19.5),
              ChartSampleData(x: '2000', y: 22.5),
              ChartSampleData(x: '2001', y: 21.5),
              ChartSampleData(x: '2002', y: 20.5),
              ChartSampleData(x: '2003', y: 23.5),
              ChartSampleData(x: '2004', y: 19.5)
            ],
            xValueMapper: (ChartSampleData sales, _) => sales.x,
            yValueMapper: (ChartSampleData sales, _) => sales.y),

        SplineAreaSeries<ChartSampleData, String>(
            gradient: const LinearGradient(colors: <Color>[
              Color.fromRGBO(140, 108, 245, 1),
              Color.fromRGBO(125, 185, 253, 1)
            ], stops: <double>[
              0.3,
              0.7
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            borderWidth: 2,
            name: 'Country 2',
            borderColor: const Color.fromRGBO(0, 63, 136, 1),
            borderDrawMode: BorderDrawMode.top,
            dataSource: <ChartSampleData>[
              ChartSampleData(x: '1997', y: 20),
              ChartSampleData(x: '1998', y: 21.0),
              ChartSampleData(x: '1999', y: 10.0),
              ChartSampleData(x: '2000', y: 11.0),
              ChartSampleData(x: '2001', y: 18.0),
              ChartSampleData(x: '2002', y: 19.0),
              ChartSampleData(x: '2003', y: 23.5),
              ChartSampleData(x: '2004', y: 19.5)
            ],
            xValueMapper: (ChartSampleData sales, _) => sales.x,
            yValueMapper: (ChartSampleData sales, _) => sales.y)

      ];


    }



  }

  /// Return the circular chart with vertical gradient.
  SfCartesianChart getVerticalGradientAreaChart(ChartsBean sample) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
//      title: ChartTitle(
//        text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
      primaryXAxis: CategoryAxis(
          labelPlacement: LabelPlacement.onTicks,
          title: new AxisTitle(text: sample.xcaption),
          labelRotation:sample.xcaprot??0,
          isVisible: sample.xaxisvsbl==0?false:true,
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
        title: new AxisTitle(text: sample.ycaption),
        labelRotation:sample.ycaprot??0,
        isVisible: sample.yaxisvsbl==0?false:true,
        labelFormat: '{value}',
        axisLine: AxisLine(width: 0),
      ),
      trackballBehavior: TrackballBehavior(enable: true),
      series: _getGradientAreaSeries(sample),
    );
  }




