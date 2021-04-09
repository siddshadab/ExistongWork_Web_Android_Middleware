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
class ColumnRounded extends StatefulWidget {
  ColumnRounded({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

  @override
  _ColumnRoundedState createState() => _ColumnRoundedState(chartObject);
}
ZoomPanBehavior zoomingBehavior;

class _ColumnRoundedState extends State<ColumnRounded> {
  _ColumnRoundedState(this.sample);
  final ChartsBean sample;

  @override
  Widget build(BuildContext context) {
  /*  const String sourceLink =
        'https://www.worldatlas.com/articles/largest-cities-in-the-world-by-land-area.html';
    const String source = 'www.worldatlas.com';*/
    /*return getScopedModel(
        getRoundedColumnChart(false), sample, null, sourceLink, source);*/



    //return getRoundedColumnChart(false,sample) ;

    return PinchZoomingFrontPanel(sample);
  }
}

SfCartesianChart getRoundedColumnChart(bool isTileView,ChartsBean sample) {
  print("xxaption hai ${sample.xcaption}" );
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
//      title: ChartTitle(
//        text: sample.isTile==true? ' ' +sample.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
    primaryXAxis: CategoryAxis(
      labelStyle: ChartTextStyle(color: Colors.white),
      axisLine: AxisLine(width: 0),
      labelPosition: ChartDataLabelPosition.inside,
      majorTickLines: MajorTickLines(width: 0),
      majorGridLines: MajorGridLines(width: 0),
        title: new AxisTitle(text: sample.xcaption),

      labelRotation:sample.xcaprot??0,
      isVisible: sample.xaxisvsbl==0?false:true,
    ),
    primaryYAxis: NumericAxis(
        title: new AxisTitle(text: sample.ycaption),
      labelRotation:sample.ycaprot??0,
      isVisible: sample.yaxisvsbl==0?false:true,
    ),
    series: getRoundedColumnSeries(isTileView,sample!=null?sample.chartSampleData:null),
    tooltipBehavior: TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y ',
        header: ''),
      zoomPanBehavior: zoomingBehavior
  );
}

List<ColumnSeries<ChartSampleData, String>> getRoundedColumnSeries(
    bool isTileView,List<ChartSampleData> beanValue) {
/*  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'New York', y: 8683),
    ChartSampleData(x: 'Tokyo', y: 6993),
    ChartSampleData(x: 'Chicago', y: 5498),
    ChartSampleData(x: 'Atlanta', y: 5083),
    ChartSampleData(x: 'Boston', y: 4497),
  ];*/
  return <ColumnSeries<ChartSampleData, String>>[
    ColumnSeries<ChartSampleData, String>(
      enableTooltip: true,
      width: 0.9,
      dataLabelSettings: DataLabelSettings(
          isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
      dataSource: beanValue,
      borderRadius: BorderRadius.circular(10),
      xValueMapper: (ChartSampleData sales, _) => sales.xValue,
      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
    ),
  ];
}


//ignore:must_be_immutable

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
              child: getRoundedColumnChart(false ,sample )),
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





