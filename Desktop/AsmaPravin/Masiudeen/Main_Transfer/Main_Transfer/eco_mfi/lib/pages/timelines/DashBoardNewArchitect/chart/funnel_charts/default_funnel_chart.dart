import 'dart:async';
import 'dart:math' as math;
import 'package:scoped_model/scoped_model.dart';
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

//ignore: must_be_immutable
class FunnelDefault extends StatefulWidget {
  FunnelDefault({this.subItemList, Key key}) : super(key: key);
  final SubItem subItemList;

  @override
  _FunnelDefaultState createState() => _FunnelDefaultState(subItemList);
}

class _FunnelDefaultState extends State<FunnelDefault> {
  _FunnelDefaultState(this.subItemList);
  final SubItem subItemList;

  @override
  Widget build(BuildContext context) {
    return getScopedModel(null, subItemList, DefaultFunnelFrontPanel(subItemList));
  }
}

SfFunnelChart getDefaultFunnelChart(bool isTileView,
    [double gapRatio, int neckWidth, int neckHeight, bool explode]) {
  return SfFunnelChart(
    smartLabelMode: SmartLabelMode.shift,
    title: ChartTitle(text: isTileView ? '' : 'Website conversion rate'),
    tooltipBehavior: TooltipBehavior(enable: true),
    series:
        _getFunnelSeries(isTileView, gapRatio, neckWidth, neckHeight, explode),
  );
}

FunnelSeries<ChartSampleData, String> _getFunnelSeries(bool isTileView,
    [double _gapRatio, int _neckWidth, int _neckHeight, bool _explode]) {
  final List<ChartSampleData> pieData = <ChartSampleData>[
    ChartSampleData(x: 'Purchased ', y: 150),
    ChartSampleData(x: 'Requested price list', y: 300),
    ChartSampleData(x: 'Downloaded trail', y: 600),
    ChartSampleData(x: 'Visit download page', y: 1500),
    ChartSampleData(x: 'Watched demo', y: 2600),
    ChartSampleData(x: 'Website visitors', y: 3000)
  ];
  return FunnelSeries<ChartSampleData, String>(
      dataSource: pieData,
      xValueMapper: (ChartSampleData data, _) => data.x,
      yValueMapper: (ChartSampleData data, _) => data.y,
      explode: isTileView ? false : _explode,
      gapRatio: isTileView ? 0 : _gapRatio,
      neckHeight: isTileView ? '20%' : _neckHeight.toString() + '%',
      neckWidth: isTileView ? '20%' : _neckWidth.toString() + '%',
      dataLabelSettings: DataLabelSettings(isVisible: true));
}

class DefaultFunnelFrontPanel extends StatefulWidget {
  //ignore: prefer_const_constructors_in_immutables
  DefaultFunnelFrontPanel(this.subItemList);
  final SubItem subItemList;

  @override
  _DefaultFunnelFrontPanelState createState() =>
      _DefaultFunnelFrontPanelState(subItemList);
}

class _DefaultFunnelFrontPanelState extends State<DefaultFunnelFrontPanel> {
  _DefaultFunnelFrontPanelState(this.subItemList);
  final SubItem subItemList;
  double gapRatio = 0;
  int neckWidth = 20;
  int neckHeight = 20;
  bool explode = false;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SampleModel>(
        rebuildOnChange: true,
        builder: (BuildContext context, _, SampleModel model) {
          return Scaffold(
              backgroundColor: model.cardThemeColor,
              body: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
                child: Container(
                    child: getDefaultFunnelChart(
                        false, gapRatio, neckWidth, neckHeight, explode)),
              ),
              floatingActionButton: Stack(children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: null,
                     onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                      _showSettingsPanel(model);
                    },
                    child: Icon(Icons.graphic_eq, color: Colors.white),
                    backgroundColor: model.backgroundColor,
                  ),
                ),
              ]));
        });
  }

  void _showSettingsPanel(SampleModel model) {
    final double height =
        (MediaQuery.of(context).size.height > MediaQuery.of(context).size.width)
            ? 0.3
            : 0.4;
    showRoundedModalBottomSheet<dynamic>(
        dismissOnTap: false,
        context: context,
        radius: 12.0,
        color: model.bottomSheetBackgroundColor,
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
                              child: Stack(children: <Widget>[
                                Container(
                                  height: 40,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            Text('Gap ratio  ',
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
                                                  maxValue: 0.5,
                                                  initialValue: gapRatio,
                                                  onChanged: (dynamic val) =>
                                                      setState(() {
                                                    gapRatio = val;
                                                  }),
                                                  step: 0.1,
                                                  horizontal: true,
                                                  loop: false,
                                                  padding: 0,
                                                  iconUp:
                                                      Icons.keyboard_arrow_up,
                                                  iconDown:
                                                      Icons.keyboard_arrow_down,
                                                  iconLeft:
                                                      Icons.keyboard_arrow_left,
                                                  iconRight: Icons
                                                      .keyboard_arrow_right,
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
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Neck height  ',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: model.textColor)),
                                            Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        25, 0, 0, 0),
                                                child: CustomButton(
                                                  minValue: 0,
                                                  maxValue: 50,
                                                  initialValue:
                                                      neckHeight.toDouble(),
                                                  onChanged: (dynamic val) =>
                                                      setState(() {
                                                    neckHeight = val.toInt();
                                                  }),
                                                  step: 10,
                                                  horizontal: true,
                                                  loop: false,
                                                  padding: 0,
                                                  iconUp:
                                                      Icons.keyboard_arrow_up,
                                                  iconDown:
                                                      Icons.keyboard_arrow_down,
                                                  iconLeft:
                                                      Icons.keyboard_arrow_left,
                                                  iconRight: Icons
                                                      .keyboard_arrow_right,
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
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text('Neck width',
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
                                                  maxValue: 50,
                                                  initialValue:
                                                      neckWidth.toDouble(),
                                                  onChanged: (dynamic val) =>
                                                      setState(() {
                                                    neckWidth = val.toInt();
                                                  }),
                                                  step: 10,
                                                  horizontal: true,
                                                  loop: false,
                                                  padding: 0,
                                                  iconUp:
                                                      Icons.keyboard_arrow_up,
                                                  iconDown:
                                                      Icons.keyboard_arrow_down,
                                                  iconLeft:
                                                      Icons.keyboard_arrow_left,
                                                  iconRight: Icons
                                                      .keyboard_arrow_right,
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
                                          children: <Widget>[
                                            Text('Explode',
                                                style: TextStyle(
                                                    color: model.textColor,
                                                    fontSize: 16,
                                                    letterSpacing: 0.34,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            const Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    40, 0, 0, 0)),
                                            BottomSheetCheckbox(
                                              activeColor:
                                                  model.backgroundColor,
                                              switchValue: explode,
                                              valueChanged: (dynamic value) {
                                                setState(() {
                                                  explode = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            )))))));
  }
}
