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
class StackedAreaChart extends StatefulWidget {
  StackedAreaChart({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

  @override
  _StackedAreaChartState createState() => _StackedAreaChartState();
}

class _StackedAreaChartState extends State<StackedAreaChart> {


  @override
  Widget build(BuildContext context) {

    return PinchZoomingFrontPanel(widget.chartObject);
    return getStackedAreaChart(widget.chartObject);
  }
}

SfCartesianChart getStackedAreaChart(ChartsBean sample) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
//      title: ChartTitle(
//        text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
    legend: Legend(
        isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        title: new AxisTitle(text: sample.xcaption),
        labelRotation:sample.xcaprot??0,
        isVisible: sample.xaxisvsbl==0?false:true,
      ),
      primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        //labelFormat: '{value}',
        majorTickLines: MajorTickLines(size: 0),
        title: new AxisTitle(text: sample.ycaption),
        labelRotation:sample.ycaprot??0,
        isVisible: sample.yaxisvsbl==0?false:true,
      ),
    series: getStackedAreaSeries(sample),
    tooltipBehavior:
        TooltipBehavior(enable: true, header: '', canShowMarker: false),
      zoomPanBehavior: zoomingBehavior
  );
}

List<StackedAreaSeries<ChartSampleData, String>> getStackedAreaSeries(
    ChartsBean chartData) {

  if(chartData.mtype=="xyn"){
    List<Color> col = [Colors.red,Colors.green,Colors.yellow,Colors.blue,
      Colors.orange,
      Colors.purpleAccent,Colors.lightGreenAccent, Colors.grey,Colors.black,
      Colors.brown,Colors.pink,Colors.yellowAccent,
      Colors.deepOrangeAccent,Colors.redAccent ];
    Map<String,Color> colorComb = new Map<String,Color>();
    int colorCount = 0;
    List<List<ChartSampleData>> ab  = new List<List<ChartSampleData>>();
    List<ChartSampleData> chartSampleData2 = new List<ChartSampleData>();
    // Map<String,List<ChartSampleData>> linkingClss = new Map<String,List<ChartSampleData>>();
    List<String> yvalueList = new List();
    Map<String,num> tempMap = new Map<String,num>();

    String tempKey= "!@#";

    for(int i = 0;i<chartData.chartSampleData.length;i++) {


      if(tempKey!= chartData.chartSampleData[i].xValue&&tempKey!="!@#"){

       // print("adding for --> ${tempKey}==  ${tempMap}");
        chartSampleData2.add(ChartSampleData(
            xValue: tempKey, valueMap: tempMap));
        //print("clearing temp Map ${tempMap}" );
        //print("clearing key  ${tempKey}");

        tempMap = new Map<String,num>();
        tempMap[chartData.chartSampleData[i].yValue] = chartData.chartSampleData[i].yValue2;
        tempKey = chartData.chartSampleData[i].xValue;



      }else{
        if(tempKey=="!@#"){
          tempKey =  chartData.chartSampleData[i].xValue;
        }
        tempMap[chartData.chartSampleData[i].yValue] = chartData.chartSampleData[i].yValue2;
       // print("tempMap = ${tempMap} after adding");

        if(i==chartData.chartSampleData.length-1){
          chartSampleData2.add(ChartSampleData(
              xValue: tempKey, valueMap: tempMap));
        }

      }



      if (!yvalueList.contains(chartData.chartSampleData[i].yValue)) {
        yvalueList.add(chartData.chartSampleData[i].yValue);
      }
    }

    for(var items in chartSampleData2){
      print("Chart item ${items}");
    }

    List<StackedAreaSeries<ChartSampleData, String>> returningColumnSeries = new List<StackedAreaSeries<ChartSampleData, String>>();


    for(int j = 0;j<yvalueList.length;j++){

      returningColumnSeries.add(

          StackedAreaSeries<ChartSampleData, String>(
              enableTooltip: true,
              animationDuration: 2500,
              dataSource: chartSampleData2,
              color:  colorComb[j],
              xValueMapper: (ChartSampleData sales, _) {
                return sales.xValue;
              },
              yValueMapper: (ChartSampleData sales, _) {
                return sales.valueMap[yvalueList[j]];


              } ,
              name: yvalueList[j] )

      );

    }



    return returningColumnSeries;
  }
  else if (chartData.mtype=="xy"){
    return <StackedAreaSeries<ChartSampleData, String>>[
      StackedAreaSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData.chartSampleData,
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue,
        name:chartData.categoryNames[0]??'',
        dataLabelSettings: DataLabelSettings(
            isVisible: true, textStyle: ChartTextStyle(fontSize: 10)),

      )
    ];
  }
  else if(chartData.mtype=="xyy"){
    return <StackedAreaSeries<ChartSampleData, String>>[
      StackedAreaSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData.chartSampleData,
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue,
        name:chartData.categoryNames[0]??'',
        dataLabelSettings: DataLabelSettings(
          isVisible: true, textStyle: ChartTextStyle(fontSize: 10),  ),
      ),
      StackedAreaSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData.chartSampleData,
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue2,

        name: chartData.categoryNames[1]??'',
        dataLabelSettings: DataLabelSettings(
            isVisible: true, textStyle: ChartTextStyle(fontSize: 10)),
      )
    ];
  }



  else{
      final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(
        x: DateTime(2000, 1, 1),
        y: 0.61,
        yValue: 0.03,
        yValue2: 0.48,
        yValue3: 0.23),
    ChartSampleData(
        x: DateTime(2001, 1, 1),
        y: 0.81,
        yValue: 0.05,
        yValue2: 0.53,
        yValue3: 0.17),
    ChartSampleData(
        x: DateTime(2002, 1, 1),
        y: 0.91,
        yValue: 0.06,
        yValue2: 0.57,
        yValue3: 0.17),
    ChartSampleData(
        x: DateTime(2003, 1, 1),
        y: 1.00,
        yValue: 0.09,
        yValue2: 0.61,
        yValue3: 0.20),
    ChartSampleData(
        x: DateTime(2004, 1, 1),
        y: 1.19,
        yValue: 0.14,
        yValue2: 0.63,
        yValue3: 0.23),
    ChartSampleData(
        x: DateTime(2005, 1, 1),
        y: 1.47,
        yValue: 0.20,
        yValue2: 0.64,
        yValue3: 0.36),
    ChartSampleData(
        x: DateTime(2006, 1, 1),
        y: 1.74,
        yValue: 0.29,
        yValue2: 0.66,
        yValue3: 0.43),
    ChartSampleData(
        x: DateTime(2007, 1, 1),
        y: 1.98,
        yValue: 0.46,
        yValue2: 0.76,
        yValue3: 0.52),
    ChartSampleData(
        x: DateTime(2008, 1, 1),
        y: 1.99,
        yValue: 0.64,
        yValue2: 0.77,
        yValue3: 0.72),
    ChartSampleData(
        x: DateTime(2009, 1, 1),
        y: 1.70,
        yValue: 0.75,
        yValue2: 0.55,
        yValue3: 1.29),
    ChartSampleData(
        x: DateTime(2010, 1, 1),
        y: 1.48,
        yValue: 1.06,
        yValue2: 0.54,
        yValue3: 1.38),
    ChartSampleData(
        x: DateTime(2011, 1, 1),
        y: 1.38,
        yValue: 1.25,
        yValue2: 0.57,
        yValue3: 1.82),
    ChartSampleData(
        x: DateTime(2012, 1, 1),
        y: 1.66,
        yValue: 1.55,
        yValue2: 0.61,
        yValue3: 2.16),
    ChartSampleData(
        x: DateTime(2013, 1, 1),
        y: 1.66,
        yValue: 1.55,
        yValue2: 0.67,
        yValue3: 2.51),
    ChartSampleData(
        x: DateTime(2014, 1, 1),
        y: 1.67,
        yValue: 1.65,
        yValue2: 0.67,
        yValue3: 2.61),
  ];
    return <StackedAreaSeries<ChartSampleData, String>>[
      StackedAreaSeries<ChartSampleData, String>(
          animationDuration: 2500,
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Apple'),
      StackedAreaSeries<ChartSampleData, String>(
          animationDuration: 2500,
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: 'Orange'),
      StackedAreaSeries<ChartSampleData,String>(
          animationDuration: 2500,
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          name: 'Pears'),
      StackedAreaSeries<ChartSampleData, String>(
          animationDuration: 2500,
          enableTooltip: true,
          dataSource: chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue3,
          name: 'Others')
    ];


  }


}



ZoomPanBehavior zoomingBehavior;
class PinchZoomingFrontPanel extends StatefulWidget {
  //ignore: prefer_const_constructors_in_immutables
  PinchZoomingFrontPanel(this.chartObject);
  final ChartsBean chartObject;
  @override
  _PinchZoomingFrontPanelState createState() =>
      _PinchZoomingFrontPanelState(chartObject);
}

class _PinchZoomingFrontPanelState extends State<PinchZoomingFrontPanel> {
  _PinchZoomingFrontPanelState(this.sample);
  final ChartsBean sample;

  final List<String> _zoomModeTypeList = <String>['x', 'y', 'xy'].toList();
  String _selectedModeType = 'x';
  ZoomMode _zoomModeType = ZoomMode.xy;

  @override
  Widget build(BuildContext context) {
    zoomingBehavior = ZoomPanBehavior(
        enablePinching: true, zoomMode: _zoomModeType, enablePanning: true);
    return Container(
      height: sample.isTile==true?350:500.0,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
          child: Container(
              child: getStackedAreaChart(widget.chartObject)),
        ),
          floatingActionButton: Container(
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 15, 0, 0),
                          child: Tooltip(
                            message: 'Zoom In',
                            child: IconButton(
                              icon: Icon(Icons.add,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.zoomIn();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Zoom Out',
                            child: IconButton(
                              icon: Icon(Icons.remove,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.zoomOut();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Pan Up',
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_up,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.panToDirection('top');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Pan Down',
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_down,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.panToDirection('bottom');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Pan Left',
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_left,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.panToDirection('left');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Pan Right',
                            child: IconButton(
                              icon: Icon(Icons.keyboard_arrow_right,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.panToDirection('right');
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Tooltip(
                            message: 'Reset',
                            child: IconButton(
                              icon: Icon(Icons.refresh,
                                  color: Colors.black),
                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
                              globals.sessionTimeOut.SessionTimedOut();
                              zoomingBehavior.reset();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          )
      ),
    );

  }


}
