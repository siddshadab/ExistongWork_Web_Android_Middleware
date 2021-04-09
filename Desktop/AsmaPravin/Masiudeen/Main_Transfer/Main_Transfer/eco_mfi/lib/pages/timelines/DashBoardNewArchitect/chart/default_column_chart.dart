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
import 'package:scoped_model/scoped_model.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';


//ignore: must_be_immutable

//bool visible = false;
class ColumnDefault extends StatefulWidget {
  ColumnDefault({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

 // ColumnDefault(this.seriesList, {this.animate});
  @override
  _ColumnDefaultState createState() => _ColumnDefaultState();



}
ZoomPanBehavior zoomingBehavior;

class _ColumnDefaultState extends State<ColumnDefault> {



  @override
  Widget build(BuildContext context) {

    //return getDefaultColumnChart(widget.chartObject);

    return PinchZoomingFrontPanel(widget.chartObject);

  }
}



SfCartesianChart getDefaultColumnChart(ChartsBean sample) {
//SfCartesianChart getDefaultColumnChart(bool isTileView,List<SimpleBarChartBean> beanValue) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
//    title: ChartTitle(
//        text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
    primaryXAxis: CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
        title: new AxisTitle(text: sample.xcaption),
      labelRotation:sample.xcaprot??0,
      isVisible: sample.xaxisvsbl==0?false:true,
    ),
    legend: Legend( isVisible: sample.islegvis==0?false:true,),
    primaryYAxis: NumericAxis(
        axisLine: AxisLine(width: 0),
        //labelFormat: '{value}',
        majorTickLines: MajorTickLines(size: 0),
        title: new AxisTitle(text: sample.ycaption),
      labelRotation:sample.ycaprot??0,
      isVisible: sample.yaxisvsbl==0?false:true,
    ),
    series: getDefaultColumnSeries(sample!=null?sample: null),
    tooltipBehavior:
    TooltipBehavior(enable: true, header: '', canShowMarker: false),
      zoomPanBehavior: zoomingBehavior
  );
}

List<ColumnSeries<ChartSampleData, String>> getDefaultColumnSeries(ChartsBean sample) {
if(sample.mtype=="xy"){
  return <ColumnSeries<ChartSampleData, String>>[
    ColumnSeries<ChartSampleData, String>(
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
  return <ColumnSeries<ChartSampleData, String>>[
    ColumnSeries<ChartSampleData, String>(
      animationDuration: 2500,
      enableTooltip: true,
      dataSource: sample.chartSampleData,
      xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
      yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue,
     name:sample.categoryNames[0]??'',
      dataLabelSettings: DataLabelSettings(
          isVisible: true, textStyle: ChartTextStyle(fontSize: 10),  ),
    ),
    ColumnSeries<ChartSampleData, String>(
      animationDuration: 1000,
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





}







//ignore:must_be_immutable
class PinchZoomingFrontPanel extends StatefulWidget {
  //ignore: prefer_const_constructors_in_immutables
  PinchZoomingFrontPanel(this.chartObject);
  final ChartsBean chartObject;
  @override
  _PinchZoomingFrontPanelState createState() => _PinchZoomingFrontPanelState(chartObject);
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
                child:getDefaultColumnChart(widget.chartObject)),
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

//
//              Align(
//                alignment: Alignment.bottomCenter,
//                child: Container(
//                  height: 50,
//                  child: InkWell(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(24, 15, 0, 0),
//                          child: Tooltip(
//                            message: 'Zoom In',
//                            child: IconButton(
//                              icon: Icon(Icons.add,
//                                  color: Colors.grey),
//                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                              globals.sessionTimeOut.SessionTimedOut();
//                              globals.sessionTimeOut=new SessionTimeOut(context: context);
//                              globals.sessionTimeOut.SessionTimedOut();
//                              zoomingBehavior.zoomIn();
//                              },
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                          child: Tooltip(
//                            message: 'Zoom Out',
//                            child: IconButton(
//                              icon: Icon(Icons.remove,
//                                  color: Colors.grey),
//                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                              globals.sessionTimeOut.SessionTimedOut();
//                              zoomingBehavior.zoomOut();
//                              },
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                          child: Tooltip(
//                            message: 'Pan Up',
//                            child: IconButton(
//                              icon: Icon(Icons.keyboard_arrow_up,
//                                  color: Colors.grey),
//                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                              globals.sessionTimeOut.SessionTimedOut();
//                              zoomingBehavior.panToDirection('top');
//                              },
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                          child: Tooltip(
//                            message: 'Pan Down',
//                            child: IconButton(
//                              icon: Icon(Icons.keyboard_arrow_down,
//                                  color: Colors.grey),
//                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                              globals.sessionTimeOut.SessionTimedOut();
//                              zoomingBehavior.panToDirection('bottom');
//                              },
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                          child: Tooltip(
//                            message: 'Pan Left',
//                            child: IconButton(
//                              icon: Icon(Icons.keyboard_arrow_left,
//                                  color: Colors.grey),
//                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                              globals.sessionTimeOut.SessionTimedOut();
//                              zoomingBehavior.panToDirection('left');
//                              },
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                          child: Tooltip(
//                            message: 'Pan Right',
//                            child: IconButton(
//                              icon: Icon(Icons.keyboard_arrow_right,
//                                  color: Colors.grey),
//                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                              globals.sessionTimeOut.SessionTimedOut();
//                              zoomingBehavior.panToDirection('right');
//                              },
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                          child: Tooltip(
//                            message: 'Reset',
//                            child: IconButton(
//                              icon: Icon(Icons.refresh,
//                                  color: Colors.grey),
//                              onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
//                              globals.sessionTimeOut.SessionTimedOut();
//                              zoomingBehavior.reset();
//                              },
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              )
//
//
            ]),
          )
      ),
    );

  }



}

