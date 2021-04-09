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
class StackedBarChart extends StatefulWidget {
  StackedBarChart({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

  @override
  _StackedBarChartState createState() => _StackedBarChartState();
}

class _StackedBarChartState extends State<StackedBarChart> {


  @override
  Widget build(BuildContext context) {
    return PinchZoomingFrontPanel(widget.chartObject);
    //return getScopedModel(getStackedBarChart(false), sample);
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
                child: getStackedBarChart(sample )),
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

SfCartesianChart getStackedBarChart(ChartsBean sample) {
  return SfCartesianChart(
    plotAreaBorderWidth: 1,
//    title: ChartTitle(
//      text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
    legend: Legend( isVisible: sample.islegvis==0?false:true, opacity: 0.7),
    primaryXAxis: CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
      title: AxisTitle(text: sample.xcaption),
      labelRotation:sample.xcaprot??0,
      isVisible: sample.xaxisvsbl==0?false:true,
    ),
    primaryYAxis: NumericAxis(
      axisLine: AxisLine(width: 0),
      labelFormat: '{value}',
      majorTickLines: MajorTickLines(size: 0),
      labelRotation:sample.ycaprot??0,
      isVisible: sample.yaxisvsbl==0?false:true,

    ),
    series: getStackedBarSeries(sample),
    tooltipBehavior:
        TooltipBehavior(enable: true, header: '', canShowMarker: false),
  );
}

List<StackedBarSeries<ChartSampleData, String>> getStackedBarSeries(
    ChartsBean sample) {


  if(sample.mtype=="xyn"){
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

    for(int i = 0;i<sample.chartSampleData.length;i++) {


      if(tempKey!= sample.chartSampleData[i].xValue&&tempKey!="!@#"){

        print("adding for --> ${tempKey}==  ${tempMap}");
        chartSampleData2.add(ChartSampleData(
            xValue: tempKey, valueMap: tempMap));
        print("clearing temp Map ${tempMap}" );
        print("clearing key  ${tempKey}");

        tempMap = new Map<String,num>();
        tempMap[sample.chartSampleData[i].yValue] = sample.chartSampleData[i].yValue2;
        tempKey = sample.chartSampleData[i].xValue;



      }else{
        if(tempKey=="!@#"){
          tempKey =  sample.chartSampleData[i].xValue;
        }
        tempMap[sample.chartSampleData[i].yValue] = sample.chartSampleData[i].yValue2;
        print("tempMap = ${tempMap} after adding");

        if(i==sample.chartSampleData.length-1){
          chartSampleData2.add(ChartSampleData(
              xValue: tempKey, valueMap: tempMap));
        }

      }



      if (!yvalueList.contains(sample.chartSampleData[i].yValue)) {
        yvalueList.add(sample.chartSampleData[i].yValue);
      }
    }

    for(var items in chartSampleData2){
      print("Chart item ${items}");
    }

    List<StackedBarSeries<ChartSampleData, String>> returningColumnSeries = new List<StackedBarSeries<ChartSampleData, String>>();


    for(int j = 0;j<yvalueList.length;j++){
      print("Adding one moreYYYYY");

      returningColumnSeries.add(

          StackedBarSeries<ChartSampleData, String>(
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
  else if (sample.mtype=="xy"){
    return <StackedBarSeries<ChartSampleData, String>>[
      StackedBarSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: sample.chartSampleData,
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue,
        name:sample.categoryNames[0]??'',
        dataLabelSettings: DataLabelSettings(
            isVisible: true, textStyle: ChartTextStyle(fontSize: 10)),

      )
    ];
  }
  else if(sample.mtype=="xyy"){
    return <StackedBarSeries<ChartSampleData, String>>[
      StackedBarSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: sample.chartSampleData,
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue,
        name:sample.categoryNames[0]??'',
        dataLabelSettings: DataLabelSettings(
          isVisible: true, textStyle: ChartTextStyle(fontSize: 10),  ),
      ),
      StackedBarSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: sample.chartSampleData,
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue2,

        name: sample.categoryNames[1]??'',
        dataLabelSettings: DataLabelSettings(
            isVisible: true, textStyle: ChartTextStyle(fontSize: 10)),
      )
    ];
  }




  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Jan', y: 6, yValue: 6, yValue2: -1),
    ChartSampleData(x: 'Feb', y: 8, yValue: 8, yValue2: -1.5),
    ChartSampleData(x: 'Mar', y: 12, yValue: 11, yValue2: -2),
    ChartSampleData(x: 'Apr', y: 15.5, yValue: 16, yValue2: -2.5),
    ChartSampleData(x: 'May', y: 20, yValue: 21, yValue2: -3),
    ChartSampleData(x: 'June', y: 24, yValue: 25, yValue2: -3.5),
  ];
  return <StackedBarSeries<ChartSampleData, String>>[
    StackedBarSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        name: 'Apple'),
    StackedBarSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        name: 'Orange'),
    StackedBarSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
        name: 'Wastage')
  ];
}
