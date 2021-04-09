

import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect//Utils/view.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/flutter_backdrop.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:url_launcher/url_launcher.dart';
//import 'model.dart';

void onTapControlItem(BuildContext context, SampleModel model, int position) async{

  model.selectedIndex = position;
  /*SharedPreferences prefs = await SharedPreferences.getInstance();
  String usercode="";
  try {
    usercode = prefs.getString(TablesColumnFile.musrcode);
  }catch(_){}

  String query = await replacekeywords(model.controlList[position].mquery,usercode);

  await AppDatabase.get().getQuerySimpleBarChart(query).then((onValue) async {
    if (onValue != null) {
      globalSample = new SubItem();
      globalSample.chartSampleData = new List<ChartSampleData>();
      globalSample.chartSampleData = onValue;
    }
*/
    Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>  LayoutPage()));

  //});
  }


String replacekeywords(String f,String usercode) {
  //replace codes here
  String formattedStr="";
  formattedStr =f.replaceAll("LOGINUSER", usercode);
  return formattedStr;
}

void onTapSampleItem(BuildContext context, SubItem sample,
    [SampleModel model]) async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
      String usercode="";
      try {
        usercode = prefs.getString(TablesColumnFile.musrcode);
      }catch(_){}
      String query = await replacekeywords(sample.codeLink,usercode);
  print("model.sampleWidget[sample.key][1].sample ${model.sampleWidget[sample.key][1].sample }");
  await AppDatabase.get().getQuerySimpleBarChart(query).then((onValue) async {
    if(sample!=null) {
      sample.chartSampleData = onValue;
    }
    model.sampleWidget[sample.key][1].sample = sample;
    Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
            builder: (BuildContext context) =>
            model.sampleWidget[sample.key][1]));
  });

}

class BackPanel extends StatefulWidget {
  //ignore:prefer_const_constructors_in_immutables
  BackPanel(this.sample);
  final SubItem sample;

  @override
  _BackPanelState createState() => _BackPanelState(sample);
}

class _BackPanelState extends State<BackPanel> {
  _BackPanelState(this.sample);
  final SubItem sample;
  final GlobalKey _globalKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  void _afterLayout(dynamic _) {
    _getSizesAndPosition();
  }

  void _getSizesAndPosition() {
    final RenderBox renderBoxRed =
    _globalKey.currentContext?.findRenderObject();
    final Size size = renderBoxRed?.size;
    final Offset position = renderBoxRed?.localToGlobal(Offset.zero);
    const double appbarHeight = 60;
    BackdropState.frontPanelHeight = position == null
        ? 0
        : (position.dy + (size.height - appbarHeight) + 20);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SampleModel>(
      rebuildOnChange: true,
      builder: (BuildContext context, _, SampleModel model) {
        return Container(
          color: model.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  sample.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      color: Colors.white,
                      letterSpacing: 0.53),
                ),
                sample.description != null
                    ? Padding(
                  key: _globalKey,
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    sample.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.white,
                        letterSpacing: 0.3,
                        height: 1.5),
                  ),
                )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FrontPanel extends StatefulWidget {
  //ignore:prefer_const_constructors_in_immutables
  FrontPanel(this.sampleList, this.sample, this.sourceLink, this.source);
  final SubItem sampleList;
  final dynamic sample;
  final String sourceLink;
  final String source;

  @override
  _FrontPanelState createState() =>
      _FrontPanelState(sampleList, sample, sourceLink, source);
}

class _FrontPanelState extends State<FrontPanel> {
  _FrontPanelState(this.sampleList, this.sample, this.sourceLink, this.source);
  final SubItem sampleList;
  final dynamic sample;
  final String sourceLink;
  final String source;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SampleModel>(
        rebuildOnChange: true,
        builder: (BuildContext context, _, SampleModel model) {
          return Scaffold(
            backgroundColor: model.cardThemeColor,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 50),
              child: Container(child: sample),
            ),
            floatingActionButton: sourceLink == null
                ? null
                : Stack(children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 0, 0),
                  child: Container(
                    height: 50,
                    child: InkWell(
                      onTap: () => launch(sourceLink),
                      child: Row(
                        children: <Widget>[
                          Text('Source: ',
                              style: TextStyle(
                                  fontSize: 16, color: model.textColor)),
                          Text(source,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ]),
          );
        });
  }
}

ScopedModelDescendant<SampleModel> getScopedModel(
    dynamic sampleWidget, SubItem sample,
    [Widget settingPanel, String sourceLink, String source]) {
  print("sample sample sample ${sample.toString()}");

  final ValueNotifier<bool> frontPanelVisible = ValueNotifier<bool>(true);
  return ScopedModelDescendant<SampleModel>(
      builder: (BuildContext context, _, SampleModel model) => SafeArea(
        child: Backdrop(
          toggleFrontLayer:
          sample.description != null && sample.description != '',
          needCloseButton: false,
          panelVisible: frontPanelVisible,
          sampleListModel: model,
          appBarAnimatedLeadingMenuIcon: AnimatedIcons.close_menu,
        //  appBarActions: new Container(),
          appBarTitle: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              child: Text(sample.title.toString())),
          backLayer: BackPanel(sample),
          frontLayer: settingPanel ??
              FrontPanel(sample, sampleWidget, sourceLink, source),
          sideDrawer: null,
          headerClosingHeight: 350,
          titleVisibleOnPanelClosed: true,
          color: model.cardThemeColor,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12), bottom: Radius.circular(0)),
        ),
      ));
}
