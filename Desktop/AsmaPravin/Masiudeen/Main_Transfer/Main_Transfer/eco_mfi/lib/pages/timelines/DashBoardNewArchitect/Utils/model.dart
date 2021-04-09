import 'dart:convert';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/ChartsList.dart';

import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SampleModel extends Model {
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usercode;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  int branch;

  SampleModel() {
    getSessionVariables();

    controlList = <ChartsBean>[];
    searchControlItems = <ChartsBean>[];
    sampleList = <SubItem>[];
    searchSampleItems = <SubItem>[];
    controlList = SampleModel.controlList1;
    print("SampleModel.controlList1 ${SampleModel.controlList1.toString()} ");

    for (int index = 0; index < controlList.length; index++) {
      print(
          "SampleModel.controlList1 ${SampleModel.controlList1[index].toString()} ");
    }
    // For search results
    searchControlItems.addAll(controlList);
/*    for (int index = 0; index < controlList.length; index++) {
      if (controlList[index].sampleList != null) {
        for (int i = 0; i < controlList[index].sampleList.length; i++) {
          searchSampleItems.add(controlList[index].sampleList[i]);
        }
      } else if (controlList[index].childList != null) {
        for (int i = 0; i < controlList[index].childList.length; i++) {
          for (int j = 0;
              j < controlList[index].childList[i].subItems.length;
              j++) {
            searchSampleItems.add(controlList[index].childList[i].subItems[j]);
          }
        }
      } else {
        for (int i = 0; i < controlList[index].subItems.length; i++) {
          for (int j = 0;
              j < controlList[index].subItems[i].subItems.length;
              j++) {
            for (int k = 0;
                k < controlList[index].subItems[i].subItems[j].subItems.length;
                k++) {
              searchSampleItems
                  .add(controlList[index].subItems[i].subItems[j].subItems[k]);
            }
          }
        }
      }
    }*/
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();

    branch = prefs.get(TablesColumnFile.musrbrcode);
    reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
    username = prefs.getString(TablesColumnFile.musrcode);
    usrRole = prefs.getString(TablesColumnFile.musrdesignation);
    usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
    loginTime = prefs.getString(TablesColumnFile.LoginTime);
    usercode = prefs.getString(TablesColumnFile.musrcode);
  }

  @override
  String toString() {
    return 'SampleModel{sampleWidget: $sampleWidget, isTargetMobile: $isTargetMobile, controlList: $controlList, searchControlItems: $searchControlItems, sampleList: $sampleList, searchSampleItems: $searchSampleItems, selectedIndex: $selectedIndex, backgroundColor: $backgroundColor, slidingPanelColor: $slidingPanelColor, paletteColor: $paletteColor, themeData: $themeData, searchBoxColor: $searchBoxColor, listIconColor: $listIconColor, listDescriptionTextColor: $listDescriptionTextColor, textColor: $textColor, codeViewerIcon: $codeViewerIcon, informationIcon: $informationIcon, theme: $theme, drawerTextIconColor: $drawerTextIconColor, drawerIconColor: $drawerIconColor, drawerBackgroundColor: $drawerBackgroundColor, bottomSheetBackgroundColor: $bottomSheetBackgroundColor, isTileView: $isTileView, cardThemeColor: $cardThemeColor}';
  }

  final Map<String, List<dynamic>> sampleWidget = getSampleWidget();
  static List<ChartsBean> controlList1 = <ChartsBean>[];
  bool isTargetMobile;
  List<ChartsBean> controlList;
  List<ChartsBean> searchControlItems; // To handle search
  List<SubItem> sampleList;
  List<SubItem> searchSampleItems; // To handle search
  int selectedIndex = 0;
  Color backgroundColor = const Color.fromRGBO(0, 116, 228, 1);
  Color slidingPanelColor = const Color.fromRGBO(250, 250, 250, 1);
  Color paletteColor;
  ThemeData themeData = ThemeData.light();
  Color searchBoxColor = Colors.white;
  Color listIconColor = const Color.fromRGBO(0, 116, 228, 1);
  Color listDescriptionTextColor = Colors.grey;
  Color textColor = const Color.fromRGBO(51, 51, 51, 1);
  String codeViewerIcon = 'images/code.png';
  String informationIcon = 'images/info.png';
  Brightness theme = Brightness.light;
  Color drawerTextIconColor = Colors.black;
  Color drawerIconColor = Colors.black;
  Color drawerBackgroundColor = Colors.white;
  Color bottomSheetBackgroundColor = Colors.white;
  final bool isTileView = true;
  Color cardThemeColor = Colors.white;

  void changeTheme(ThemeData _themeData) {
    themeData = _themeData;
    switch (_themeData.brightness) {
      case Brightness.dark:
        {
          drawerTextIconColor = Colors.white;
          drawerIconColor = Colors.white;
          slidingPanelColor = const Color.fromRGBO(32, 33, 37, 1);
          drawerBackgroundColor = Colors.black;
          bottomSheetBackgroundColor = const Color.fromRGBO(34, 39, 51, 1);
          backgroundColor =
              paletteColor ?? const Color.fromRGBO(0, 116, 228, 1);
          listIconColor = paletteColor ?? Colors.white;
          searchBoxColor = Colors.white;
          listDescriptionTextColor = const Color.fromRGBO(242, 242, 242, 1);
          textColor = const Color.fromRGBO(242, 242, 242, 1);
          theme = Brightness.dark;
          cardThemeColor = const Color.fromRGBO(23, 27, 36, 1);
          break;
        }
      default:
        {
          drawerTextIconColor = Colors.black;
          drawerIconColor = Colors.black;
          slidingPanelColor = Colors.white;
          drawerIconColor = Colors.black;
          drawerBackgroundColor = Colors.white;
          bottomSheetBackgroundColor = Colors.white;
          backgroundColor =
              paletteColor ?? const Color.fromRGBO(0, 116, 228, 1);
          listIconColor = paletteColor ?? const Color.fromRGBO(0, 116, 228, 1);
          searchBoxColor = Colors.white;
          listDescriptionTextColor = Colors.grey;
          textColor = const Color.fromRGBO(51, 51, 51, 1);
          theme = Brightness.light;
          cardThemeColor = Colors.white;
          break;
        }
    }
  }
}

Future<void> updateControl() async {
  await AppDatabase.get()
      .getChartsDetailsList('0')
      .then((List<ChartsBean> chartsBean) async {
    chartsBean.forEach((f) async {
      /* f.image = 'images/cartesian_types.png';
      f.subdescription = 'Charts Ka Chutyapa';
      f.status = 'WorkInProg';*/
      f.mtitle = f.mtitle;
      SampleModel.controlList1.add(f);
    });
    for (int index = 0; index < SampleModel.controlList1.length; index++) {
      setParentQuery(index);
      for (int parent = 0;
      parent < SampleModel.controlList1[index].subItems.length;
      parent++) {
        setChildForms(index, parent);
        for (int pos = 0;
        pos <
            SampleModel
                .controlList1[index].subItems[parent].subItems.length;
        pos++) {
          setChildChartsForm(parent, pos, index);
        }
      }
    }
  });
}

void setParentQuery(int index) {
  SampleModel.controlList1[index].subItems = new List<SubItem>();
  List<String> parentType = getCommaSepratedChildType(SampleModel.controlList1[index].parenttype);

  if (parentType.contains('Charts Type')) {
    SubItem subItem = new SubItem();
    subItem.title = 'Charts Type';
    subItem.type = 'parent';
    SampleModel.controlList1[index].subItems.add(subItem);
  }

  if (parentType.contains('Axis')) {
    SubItem subItem1 = new SubItem();
    subItem1.title = 'Axis';
    subItem1.type = 'parent';
    SampleModel.controlList1[index].subItems.add(subItem1);
  }

  if (parentType.contains('Series Features')) {
    SubItem subItem2 = new SubItem();
    subItem2.title = 'Series Features';
    subItem2.type = 'parent';
    SampleModel.controlList1[index].subItems.add(subItem2);
  }

  if (parentType.contains('User Interactions')) {
    SubItem subItem3 = new SubItem();
    subItem3.title = 'User Interactions';
    subItem3.type = 'parent';
    SampleModel.controlList1[index].subItems.add(subItem3);
  }

  if (parentType.contains('Real-time Charts')) {
    SubItem subItem4 = new SubItem();
    subItem4.title = 'Real-time Charts';
    subItem4.type = 'parent';
    SampleModel.controlList1[index].subItems.add(subItem4);
  }

  if (parentType.contains('Circular Charts')) {
    SubItem subItem5 = new SubItem();
    subItem5.title = 'Circular Charts';
    subItem5.type = 'parent';
    SampleModel.controlList1[index].subItems.add(subItem5);
  }
}

void setChildForms(int index, int parent) {
  print("Oaxxxxxxxxxxxxxxxx${parent}");
  SampleModel.controlList1[index].subItems[parent].subItems =  new List<SubItem>();

  List<String> childType = getCommaSepratedChildType(SampleModel.controlList1[index].childtype);

  if (childType.contains('Column')) {
    SubItem subItem1 = new SubItem();
    subItem1.title = 'Column';
    subItem1.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItem1.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItem1);
  }
  if (childType.contains('Line')) {
    SubItem subItemT2 = new SubItem();
    subItemT2.title = 'Line';
    subItemT2.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemT2.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemT2);
  }
  if (childType.contains('Spline')) {
    SubItem subItemL3 = new SubItem();
    subItemL3.title = 'Spline';
    subItemL3.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemL3.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemL3);
  }
  if (childType.contains('Area')) {
    SubItem subItemLA4 = new SubItem();
    subItemLA4.title = 'Area';
    subItemLA4.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemLA4.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemLA4);
  }
  if (childType.contains('Bar')) {
    SubItem subItemL5 = new SubItem();
    subItemL5.title = 'Bar';
    subItemL5.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemL5.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemL5);
  }
  if (childType.contains('Bubble')) {
    SubItem subItemL6 = new SubItem();
    subItemL6.title = 'Bubble';
    subItemL6.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemL6.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemL6);
  }

  if (childType.contains('Scatter')) {
    SubItem subItemL7 = new SubItem();
    subItemL7.title = 'Scatter';
    subItemL7.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemL7.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemL7);
  }
  if (childType.contains('Step Line')) {
    SubItem subItemS8 = new SubItem();
    subItemS8.title = 'Step Line';
    subItemS8.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemS8.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemS8);
  }
  if (childType.contains('Range Column')) {
    SubItem subItemRC9 = new SubItem();
    subItemRC9.title = 'Range Column';
    subItemRC9.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemRC9.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemRC9);
  }
  if (childType.contains('Stacked Charts')) {
    SubItem subItemSC10 = new SubItem();
    subItemSC10.title = 'Stacked Charts';
    subItemSC10.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemSC10.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems.add(subItemSC10);
  }
  if (childType.contains('Stacked 100 Charts')) {
    SubItem subItemS100C11 = new SubItem();
    subItemS100C11.title = 'Stacked 100 Charts';
    subItemS100C11.displayType = SampleModel.controlList1[index].subdisplaytype;
    subItemS100C11.type = 'child';
    SampleModel.controlList1[index].subItems[parent].subItems
        .add(subItemS100C11);
  }
}

List<String> getCommaSepratedChildType(String childtype) {
  return childtype.split("~");;

}

void setChildChartsForm(int parent, int pos, int index) {
/*
  SubItem subItem2 = new SubItem();
  subItem2.title = 'Back To Back Column';
  subItem2.type = 'sample';
  subItem2.key = SampleModel.controlList1[index].mdefaulttype;
  subItem2.description = 'multi_colored_line';
  subItem2.codeLink = SampleModel.controlList1[index].mquery;
*/

  SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems =
  new List<SubItem>();
  //SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems.add(subItem2);
  if (SampleModel.controlList1[index].mtype == 'xy') {
    setXyCharts(parent, pos, index);
  } else if (SampleModel.controlList1[index].mtype == 'xyy') {
    setXyyCharts(parent, pos, index);
  } else if (SampleModel.controlList1[index].mtype == 'xyz') {
    setXyzCharts(parent, pos, index);
  }
}

Future setXyzCharts(int parent, int pos, int index) async{

  SubItem subItem1 = new SubItem();
  subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
  subItem1.title = 'Back To Back Column 1';
  subItem1.type = 'sample';
  subItem1.key = 'back_to_back_column';
  subItem1.description = 'multi_colored_line';
  subItem1.codeLink = SampleModel.controlList1[index].mquery;

  SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
      .add(subItem1);
}

void setXyyCharts(int parent, int pos, int index) async{
  SubItem subItem1 = new SubItem();
  subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
  subItem1.title = 'Back To Back Column 2';
  subItem1.type = 'sample';
  subItem1.key = 'back_to_back_column';
  subItem1.description = 'multi_colored_line';
  subItem1.codeLink = SampleModel.controlList1[index].mquery;

  SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
      .add(subItem1);
}

void setXyCharts(int parent, int pos, int index) {
//  print("SampleModel.controlList1[index].premetiveDataType ${SampleModel.controlList1[index].premetiveDataType}");
  // x-String, y-num
  if (SampleModel.controlList1[index].premetivedatatype == 1) {
    xyPremetiveDataTypeStrInt(parent, pos, index);
  } else if (SampleModel.controlList1[index].premetivedatatype == 2) {
    //x-String,y-String
    xyPremetiveDataTypeStrStr(parent, pos, index);
  } else if (SampleModel.controlList1[index].premetivedatatype == 3) {
    //x-num,y-String
    xyPremetiveDataTypeintStr(parent, pos, index);
  } else if (SampleModel.controlList1[index].premetivedatatype == 4) {
    //x-num,y-num
    xyPremetiveDataTypeintInt(parent, pos, index);
  } else if (SampleModel.controlList1[index].premetivedatatype == 5) {
    //x-Date,y-num
    xyPremetiveDataTypeDateInt(parent, pos, index);
  }
}

void xyPremetiveDataTypeDateInt(int parent, int pos, int index) async{
  if (SampleModel.controlList1[index].subItems[parent].subItems[pos].title ==
      'Line') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'multi_colored_line';
    subItem1.description = 'Date int Line Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);
  } else if (SampleModel
      .controlList1[index].subItems[parent].subItems[pos].title ==
      'Area') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'area_with_gradient';
    subItem1.description = 'Date int Area Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);
  }
}

void xyPremetiveDataTypeintInt(int parent, int pos, int index) async{
  if (SampleModel.controlList1[index].subItems[parent].subItems[pos].title ==
      'Spline') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'spline_types';
    subItem1.description = 'int int Splinen Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);

    SubItem subItem2 = new SubItem();
    subItem2.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem2.title = SampleModel.controlList1[index].subtitle;
    subItem2.type = 'sample';
    subItem2.key = 'customized_spline_chart';
    subItem2.description = 'int int Splinen Type';
    subItem2.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem2);
  } else if (SampleModel
      .controlList1[index].subItems[parent].subItems[pos].title ==
      'Area') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'area_with_emptypoints';
    subItem1.description = 'Date int Area Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);
  }
}

void xyPremetiveDataTypeintStr(int parent, int pos, int index) {}

void xyPremetiveDataTypeStrStr(int parent, int pos, int index) {}

void xyPremetiveDataTypeStrInt(int parent, int pos, int index) async{
  if (SampleModel.controlList1[index].subItems[parent].subItems[pos].title ==
      'Column') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'default_column_chart';
    subItem1.description = 'String int Column Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);

    SubItem subItem2 = new SubItem();
    subItem2.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem2.title = SampleModel.controlList1[index].subtitle;
    subItem2.type = 'sample';
    subItem2.key = 'column_with_rounded_corners';
    subItem2.description = 'String int Column with rounded Type';
    subItem2.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem2);

    SubItem subItem3 = new SubItem();
    subItem3.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem3.title = SampleModel.controlList1[index].subtitle;
    subItem3.type = 'sample';
    subItem3.key = 'column_with_track';
    subItem3.description = 'String int Column with Track Type';
    subItem3.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem3);

    SubItem subItem4 = new SubItem();
    subItem4.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem4.title = SampleModel.controlList1[index].subtitle;
    subItem4.type = 'sample';
    subItem4.key = 'customized_column_chart';
    subItem4.description = 'String int Column Customized Type';
    subItem4.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem4);
  } else if (SampleModel
      .controlList1[index].subItems[parent].subItems[pos].title ==
      'Bar') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'bar_with_rounded_corners';
    subItem1.description = 'String int Bar Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);

    SubItem subItem2 = new SubItem();
    subItem2.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem2.title = SampleModel.controlList1[index].subtitle;
    subItem2.type = 'sample';
    subItem2.key = 'bar_with_track';
    subItem2.description = 'String int Bar Type';
    subItem2.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem2);

    SubItem subItem3 = new SubItem();
    subItem3.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem3.title = SampleModel.controlList1[index].subtitle;
    subItem3.type = 'sample';
    subItem3.key = 'customized_bar_chart';
    subItem3.description = 'String int Bar Type';
    subItem3.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem3);
  } else if (SampleModel
      .controlList1[index].subItems[parent].subItems[pos].title ==
      'Bubble') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'bubble_with_various_colors';
    subItem1.description = 'String int Bubble Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);
  } else if (SampleModel
      .controlList1[index].subItems[parent].subItems[pos].title ==
      'Line') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'bubble_with_various_colors';
    subItem1.description = 'String int Bubble Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);
  } else if (SampleModel
      .controlList1[index].subItems[parent].subItems[pos].title ==
      'Area') {
    SubItem subItem1 = new SubItem();
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'bubble_with_various_colors';
    subItem1.description = 'String int Bubble Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);
  } else if (SampleModel
      .controlList1[index].subItems[parent].subItems[pos].title ==
      'Spline') {
    SubItem subItem1 = new SubItem();
    subItem1.chartSampleData = await getChartsData(SampleModel.controlList1[index].mquery);
    subItem1.title = SampleModel.controlList1[index].subtitle;
    subItem1.type = 'sample';
    subItem1.key = 'bubble_with_various_colors';
    subItem1.description = 'String int Bubble Type';
    subItem1.codeLink = SampleModel.controlList1[index].mquery;
    SampleModel.controlList1[index].subItems[parent].subItems[pos].subItems
        .add(subItem1);
  }
}




String replacekeywords(String f,String usercode, int lbrcode, int grpcd, DateTime opernDate) {
  //replace codes here
  String formattedStr="";
  formattedStr =f.replaceAll("LOGINUSER", usercode);
  formattedStr =f.replaceAll("BRANCODE", lbrcode.toString());
  formattedStr =f.replaceAll("OPRNDATE", lbrcode.toString());
  formattedStr =f.replaceAll("SYSDATE", DateTime.now().toString());
  formattedStr =f.replaceAll("LOGINUSRGRP", DateTime.now().toString());


  return formattedStr;
}

Future<List<ChartSampleData>> getChartsData(String queryVal) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String usercode = "";
  try {
    usercode = prefs.getString(TablesColumnFile.musrcode);
  } catch (_) {}


  try {
    //queryVal =  await replacekeywords(queryVal, usercode, 0,DateTime.now(),DateTime.now());
  } catch (_) {}

  // String query = await replacekeywords(queryVal, usercode);

  await AppDatabase.get().getQuerySimpleBarChart(queryVal).then((onValue) async {
    return onValue;
  });
}
class ChartSampleData {
  ChartSampleData(
      {this.x,
        this.y,
        this.xValue,
        this.yValue,
        this.yValue2,
        this.yValue3,
        this.pointColor,
        this.size,
        this.text,
        this.textx,
        this.texty,
        this.textz,
        this.title,
        this.valueMap
      });
  dynamic x;
  num y;
  dynamic xValue;
  dynamic yValue;
  num yValue2;
  num yValue3;
  Color pointColor;
  num size;
  String text;
  String textx;
  String texty;
  String textz;
  String title;
  Map<String,num> valueMap;

  @override
  String toString() {
    return 'ChartSampleData{xValue: $xValue, yValue: $yValue, yValue2: $yValue2, valueMap: $valueMap}';
  }

//  @override
//  String toString() {
//    return 'ChartSampleData{x: $x, y: $y, xValue: $xValue, yValue: $yValue, yValue2: $yValue2, yValue3: $yValue3, pointColor: $pointColor, size: $size, text: $text, textx: $textx, texty: $texty, textz: $textz, title: $title}';
//  }



}
