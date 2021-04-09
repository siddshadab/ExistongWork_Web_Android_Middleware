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
import 'package:scoped_model/scoped_model.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/helper.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'dart:collection';


//ignore: must_be_immutable
class ColumnSpacing extends StatefulWidget {
  ColumnSpacing({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

  @override
  _ColumnSpacingState createState() => _ColumnSpacingState();
}

class _ColumnSpacingState extends State<ColumnSpacing> {


  @override
  Widget build(BuildContext context) {

    return PinchZoomingFrontPanel(widget.chartObject);


    if(widget.chartObject.isTile==false){
      return  ColumnSettingsFrontPanel(widget.chartObject);
    }else{
      return  getSpacingColumnChart(widget.chartObject);
    }


  }
}

SfCartesianChart getSpacingColumnChart(ChartsBean chartObject,
   ) {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
//    title: ChartTitle(
//      text: chartObject.isTile==true? ' ' +chartObject.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
    primaryXAxis: CategoryAxis(
      majorGridLines: MajorGridLines(width: 0),
        title: new AxisTitle(text: chartObject.xcaption),
    labelRotation:chartObject.xcaprot??0,
    isVisible: chartObject.xaxisvsbl==0?false:true,
    ),
    primaryYAxis: NumericAxis(

        axisLine: AxisLine(width: 0),

      majorTickLines: MajorTickLines(size: 0),
      title: new AxisTitle(text: chartObject.ycaption),
      labelRotation:chartObject.ycaprot??0,
      isVisible: chartObject.yaxisvsbl==0?false:true,

    ),
      zoomPanBehavior: zoomingBehavior,
    series: getDefaultColumn(chartObject.isTile, chartObject),
    legend: Legend( isVisible: chartObject.islegvis==0?false:true,),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}
class TrialClass{
  String xa;
  Map<String,double> valueMap;

  TrialClass({
    this.xa,
    this.valueMap
    });
}

class SecondTrialClass{
  String xa;
  Map<String,double> valueMap;

  SecondTrialClass({
    this.xa,
    this.valueMap
  });
}

List<ColumnSeries<ChartSampleData, String>> getDefaultColumn(bool isTileView,
    ChartsBean chartObject ) {





  if(chartObject.mtype=="xy"){
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        dataSource: chartObject.chartSampleData,
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue,
        name:chartObject.categoryNames[0]??'',
        color: const Color.fromRGBO(205, 127, 50, 1),
        dataLabelSettings: DataLabelSettings(
            isVisible: true, textStyle: ChartTextStyle(fontSize: 10)),

      )
    ];
  }
  else if(chartObject.mtype=="xyy"){
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        animationDuration: 2500,
        enableTooltip: true,
        dataSource: chartObject.chartSampleData,
        color: const Color.fromRGBO(252, 216, 20, 1),
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue,
        name:chartObject.categoryNames[0]??'',

        dataLabelSettings: DataLabelSettings(
          isVisible: true, textStyle: ChartTextStyle(fontSize: 10),  ),
      ),
      ColumnSeries<ChartSampleData, String>(
        animationDuration: 1000,
        enableTooltip: true,
        dataSource: chartObject.chartSampleData,
        color: const Color.fromRGBO(205, 127, 50, 1),
        xValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.xValue,
        yValueMapper: (ChartSampleData simpleBarChartBean, _) => simpleBarChartBean.yValue2,

        name: chartObject.categoryNames[1]??'',
        dataLabelSettings: DataLabelSettings(
            isVisible: true, textStyle: ChartTextStyle(fontSize: 10)),
      )
    ];
  }

  else if(chartObject.mtype=="xyn"){
    List<Color> col = [Colors.red,Colors.green,Colors.yellow,Colors.blue,
      Colors.orange,
      Colors.purpleAccent,Colors.lightGreenAccent, Colors.grey,Colors.black,
      Colors.brown,Colors.pink,Colors.yellowAccent,
      Colors.deepOrangeAccent,Colors.redAccent ];
    Map<String,Color> colorComb = new Map<String,Color>();
    int colorCount = 0;
//    Map<String,List<int>> map = new Map<String,List<int>>();
//    //Map<String,List<String>> secondmap = new Map<String,List<String>>();
//    List<SecondTrialClass> secondTrialList = new List();
//









    List<List<ChartSampleData>> ab  = new List<List<ChartSampleData>>();
    List<ChartSampleData> chartSampleData2 = new List<ChartSampleData>();
   // Map<String,List<ChartSampleData>> linkingClss = new Map<String,List<ChartSampleData>>();
    List<String> yvalueList = new List();
    Map<String,num> tempMap = new Map<String,num>();

    String tempKey= "!@#";

    for(int i = 0;i<chartObject.chartSampleData.length;i++) {


      if(tempKey!= chartObject.chartSampleData[i].xValue&&tempKey!="!@#"){

        print("adding for --> ${tempKey}==  ${tempMap}");
        chartSampleData2.add(ChartSampleData(
            xValue: tempKey, valueMap: tempMap));
        print("clearing temp Map ${tempMap}" );
        print("clearing key  ${tempKey}");

        tempMap = new Map<String,num>();
        tempMap[chartObject.chartSampleData[i].yValue] = chartObject.chartSampleData[i].yValue2;
        tempKey = chartObject.chartSampleData[i].xValue;



      }else{
        if(tempKey=="!@#"){
          tempKey =  chartObject.chartSampleData[i].xValue;
        }
        tempMap[chartObject.chartSampleData[i].yValue] = chartObject.chartSampleData[i].yValue2;
        print("tempMap = ${tempMap} after adding");

        if(i==chartObject.chartSampleData.length-1){
          chartSampleData2.add(ChartSampleData(
              xValue: tempKey, valueMap: tempMap));
        }

      }



      if (!yvalueList.contains(chartObject.chartSampleData[i].yValue)) {
        yvalueList.add(chartObject.chartSampleData[i].yValue);
      }
    }

    for(var items in chartSampleData2){
      print("Chart item ${items}");
    }

    List<ColumnSeries<ChartSampleData, String>> returningColumnSeries = new List<ColumnSeries<ChartSampleData, String>>();


    for(int j = 0;j<yvalueList.length;j++){
      print("Adding one moreYYYYY");

      returningColumnSeries.add(

          ColumnSeries<ChartSampleData, String>(
              enableTooltip: true,
//              width: isTileView ? 0.2 : columnWidth,
//              spacing: isTileView ? 0.0 : columnSpacing,
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

//
//
//
//
//
//
//
//
//
//
//
//
//
//    List<Map<String,List<int>>> mapList = new List<Map<String,List<int>>>();
//
//    for(int i = 0;i<chartObject.chartSampleData.length;i++){
//
//      if(!map.containsKey(chartObject.chartSampleData[i].yValue)){
//        map[chartObject.chartSampleData[i].yValue] = [i];
//       // secondmap[chartObject.chartSampleData[i].yValue] = chartObject.chartSampleData[i].xValue;
//        colorComb[chartObject.chartSampleData[i].yValue] = col[colorCount];
//        if(colorCount==12)colorCount = 0;
//        colorCount++;
//      }else{
//
//        List<int> indexes = new List();
//       // List<String> indexesString = new List<String>();
//        indexes = map[chartObject.chartSampleData[i].yValue];
//        //indexesString = secondmap[chartObject.chartSampleData[i].yValue];
//        indexes.add(i);
//        //indexesString.add(chartObject.chartSampleData[i].xValue);
//        map[chartObject.chartSampleData[i].yValue] =indexes;
//       // secondmap[chartObject.chartSampleData[i].yValue] = indexesString;
//      }
//
//
//
//    }

//    print("Map ki keys hain ${map.keys}");
//    print("map hai ${map}");
//
//
//
//    List<ColumnSeries<ChartSampleData, String>> returningColumnSeries = new List<ColumnSeries<ChartSampleData, String>>();
//    for(String keyItem in map.keys){
//      print("Adding one moreYYYYY");
//
//      returningColumnSeries.add(
//
//          ColumnSeries<ChartSampleData, String>(
//              enableTooltip: true,
//              width: isTileView ? 0.2 : columnWidth,
//              spacing: isTileView ? 0.0 : columnSpacing,
//              dataSource: chartObject.chartSampleData,
//              color:  colorComb[keyItem],
//              xValueMapper: (ChartSampleData sales, _) {
////                print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
////                print("${keyItem}");
////                print("X value in final ${sales.xValue}");
//                return sales.xValue;
//              },
//              yValueMapper: (ChartSampleData sales, _) {
////                print("Y value in final ${sales.yValue2}");
////                print("      ");
//               // return sales.yValue2;
//
//                for (int i in map[keyItem] ){
//
//                  if(chartObject.chartSampleData[i].xValue == sales.xValue
//                  &&chartObject.chartSampleData[i].yValue==keyItem
//                  ){
//                    for(SecondTrialClass secondTrialObject in secondTrialList){
////  if(secondTrialObject.xa==chartObject.chartSampleData[i].xValue&&
////  secondTrialObject.ya==chartObject.chartSampleData[i].yValue )  {
////  return null;
////  }
//                    }
//                    secondTrialList.add(SecondTrialClass(xa:chartObject.chartSampleData[i].xValue, ya: chartObject.chartSampleData[i].yValue));
//                    print("Returning Values ${sales.yValue2}   -> ${sales.xValue}  for ${keyItem} ");
//                    return sales.yValue2;
//                  }
//                }
//
//
//              } ,
//              name: keyItem )
//
//      );
//
//    }

    return returningColumnSeries;
  }

  else{
      final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: 'Germany', y: 128, yValue2: 129, yValue3: 101),
    ChartSampleData(x: 'Russia', yValue2: 92, yValue3: 93),
    ChartSampleData(x: 'Norway', y: 107, yValue3: 90),
    ChartSampleData(x: 'USA', y: 87,  yValue3: 71),
  ];

    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          enableTooltip: true,
          /// To apply the column width here.
          width:  0.2 ,
          /// To apply the spacing betweeen to two columns here.
          spacing: 0.0 ,
          dataSource: chartData,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Gold'),
      ColumnSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          width:  0.2 ,
          spacing:  0.0 ,
          color: const Color.fromRGBO(169, 169, 169, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
          name: 'Silver'),
      ColumnSeries<ChartSampleData, String>(
          enableTooltip: true,
          dataSource: chartData,
          width:  0.2 ,
          spacing:  0.0 ,
          color: const Color.fromRGBO(205, 127, 50, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue3,
          name: 'Bronze')
    ];

  }












}

//ignore: must_be_immutable
class ColumnSettingsFrontPanel extends StatefulWidget {
  //ignore:prefer_const_constructors_in_immutables
  ColumnSettingsFrontPanel(this.chartObject);
  ChartsBean chartObject;

  @override
  _ColumnSettingsFrontPanelState createState() =>
      _ColumnSettingsFrontPanelState();
}

class _ColumnSettingsFrontPanelState extends State<ColumnSettingsFrontPanel> {

  double columnWidth = 0.8;
  double columnSpacing = 0.2;
  TextEditingController editingController = TextEditingController();
  TextEditingController spacingEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

          return Container(
            height: 500.0,
            width:MediaQuery.of(context).size.width,
            child: Scaffold(


                body: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
                  child: Container(
                      child: getSpacingColumnChart(widget.chartObject)),
                ),
                floatingActionButton: FloatingActionButton(
                   onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                    //_showSettingsPanel(model);

                   if (widget.chartObject.chartSampleData != null && widget.chartObject.chartSampleData.isNotEmpty){
                     widget.chartObject.chartSampleData.removeLast();
                     setState(() {

                     });
                   }
                   },
                  child: Icon(Icons.graphic_eq, color: Colors.white),
                  //backgroundColor: model.backgroundColor,
                )),
          );
  }

  void _showSettingsPanel() {
    final double height =
        (MediaQuery.of(context).size.height > MediaQuery.of(context).size.width)
            ? 0.3
            : 0.4;
    showRoundedModalBottomSheet<dynamic>(
        dismissOnTap: false,
        context: context,
        radius: 12.0,
        //color: model.bottomSheetBackgroundColor,
        builder: (BuildContext context) => ScopedModelDescendant<SampleModel>(
            rebuildOnChange: false,
            builder: (BuildContext context, _, SampleModel model) => Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Container(
                  height: 170,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * height,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Settings',
                                        style: TextStyle(
                                            color: model.textColor,
                                            fontSize: 18,
                                            letterSpacing: 0.34,
                                            fontWeight: FontWeight.w500)),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: model.textColor,
                                      ),
                                       onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 50, 0, 0),
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Width  ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: model.textColor)),
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      40, 0, 0, 0),
                                              child: CustomButton(
                                                minValue: 0,
                                                maxValue: 0.9,
                                                initialValue: columnWidth,
                                                onChanged: (dynamic val) =>
                                                    setState(() {
                                                  columnWidth = val;
                                                }),
                                                step: 0.1,
                                                horizontal: true,
                                                loop: true,
                                                padding: 0,
                                                iconUp: Icons.keyboard_arrow_up,
                                                iconDown:
                                                    Icons.keyboard_arrow_down,
                                                iconLeft:
                                                    Icons.keyboard_arrow_left,
                                                iconRight:
                                                    Icons.keyboard_arrow_right,
                                                iconUpRightColor:
                                                    model.textColor,
                                                iconDownLeftColor:
                                                    model.textColor,
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: model.textColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 15, 0, 0),
                                            child: Text('Spacing  ',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: model.textColor)),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      25, 0, 0, 0),
                                              child: CustomButton(
                                                minValue: 0,
                                                maxValue: 1,
                                                initialValue: columnSpacing,
                                                onChanged: (dynamic val) =>
                                                    setState(() {
                                                  columnSpacing = val;
                                                }),
                                                step: 0.1,
                                                horizontal: true,
                                                loop: true,
                                                padding: 5.0,
                                                iconUp: Icons.keyboard_arrow_up,
                                                iconDown:
                                                    Icons.keyboard_arrow_down,
                                                iconLeft:
                                                    Icons.keyboard_arrow_left,
                                                iconRight:
                                                    Icons.keyboard_arrow_right,
                                                iconUpRightColor:
                                                    model.textColor,
                                                iconDownLeftColor:
                                                    model.textColor,
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: model.textColor),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ))
        )
    );
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
      height: sample.isTile==true?380:530.0,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
          child: Container(
              child: getSpacingColumnChart(widget.chartObject)),
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