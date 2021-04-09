import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class ChartsBean extends Model {



  int trefno;
  int mrefno;
  int mchartid;

  @override
  String toString() {
    return 'ChartsBean{trefno: $trefno , chartSampleData : ${chartSampleData },mmrefno: $mrefno, mchartid: $mchartid, mtitle: $mtitle, mxcatg: $mxcatg, mycatg: $mycatg, mquery: $mquery, mtype: $mtype, mzcatg: $mzcatg, misonline: $misonline, mquerydesc: $mquerydesc, mdefaulttype: $mdefaulttype, mdatasource: $mdatasource, chartType: $chartType, simpleBarChartBean: $simpleBarChartBean, numTypeBean: $numTypeBean, dataTextForm: $dataTextForm, title: $subtitle, description: $subdescription, image: $image, status: $status, displayType: $subdisplaytype, sampleList: $sampleList, childList: $childList, subItems: $subItems, type: $subtype, mkey: $mkey, codeLink: $codeLink}';
  }

  String mtitle;
  String mxcatg;
  String mycatg;
  String mquery;
  String mtype;
  String mzcatg;
  int misonline;
  String mquerydesc;
  String mdefaulttype;
  String mdatasource;

  Widget chartType;
  List<SimpleBarChartBean> simpleBarChartBean;
  List<NumTypeBean> numTypeBean;
  List<Widget> dataTextForm;

  List<dynamic> sampleList;
   List<dynamic> childList;
   List<dynamic> subItems;
  String subtitle;
  String subdescription;
  String image;
  String status;
  String subdisplaytype;
  String subtype;
  String mkey;
  String codeLink;
  int premetivedatatype ;
  String parenttype;//comma seprated values here
  String childtype;//comma seprated values here
  List<ChartSampleData> chartSampleData;

  int xminval;
  int yminval;
  double xinterval;
  double yinterval;
  String xcaption  ;
  String ycaption;
  String mcharttype;

  bool isTile;//
  List categoryNames;// no need to map
  int isfavalwed;
  int xcaprot ;
  int  ycaprot ;
  int  xaxisvsbl ;
  int  yaxisvsbl ;
  int islegvis;




  ChartsBean({this.trefno, this.mrefno, this.mchartid, this.mtitle, this.mxcatg, this.mycatg, this.mquery, this.mtype, this.mzcatg, this.misonline, this.mquerydesc, this.mdefaulttype, this.mdatasource,
      this.chartType, this.simpleBarChartBean, this.numTypeBean, this.dataTextForm, this.subtitle, this.subdescription, this.image, this.status, this.subdisplaytype, this.sampleList, this.childList,
      this.subItems, this.subtype, this.mkey, this.codeLink,
      this.premetivedatatype,this.parenttype,this.childtype,this.chartSampleData,
    this.xminval,
    this.yinterval,
    this.xinterval,
    this.yminval,
    this.xcaption,
    this.ycaption,
    this.mcharttype,
    this.isTile,
    this.categoryNames,
    this.isfavalwed,
    this.xcaprot ,
    this.ycaprot ,
    this.xaxisvsbl ,
    this.yaxisvsbl ,
    this.islegvis,
  });

/*  ChartsBean({this.trefno, this.mrefno, this.mchartid, this.mtitle, this.mxcatg,
    this.mycatg,this.mquery,  this.mtype,this.chartType,this.simpleBarChartBean,this.mzcatg,this.misonline,this.mquerydesc,
  this.mdefaulttype,this.mdatasource,this.dataTextForm,this.premetiveDataType});*/

  factory ChartsBean.fromMap(
      Map<String, dynamic> map) {
    return ChartsBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno]!=null?map[TablesColumnFile.mrefno] as int:0,
      mchartid: map[TablesColumnFile.mchartid] as int,
      mtitle: map[TablesColumnFile.mtitle] as String,
      mxcatg: map[TablesColumnFile.mxcatg] as String,
      mycatg: map[TablesColumnFile.mycatg] as String,
      mquery: map[TablesColumnFile.mquery] as String,
      mtype: map[TablesColumnFile.mtype] as String,
      mzcatg: map[TablesColumnFile.mzcatg] as String,
      misonline: map[TablesColumnFile.misonline] as int,
      mquerydesc: map[TablesColumnFile.mquerydesc] as String,
      mdefaulttype: map[TablesColumnFile.mdefaulttype] as String,
      mdatasource: map[TablesColumnFile.mdatasource] as String,
      subtitle: map[TablesColumnFile.subtitle] as String,
      subdescription: map[TablesColumnFile.subdescription] as String,
      image: map[TablesColumnFile.image] as String,
      status: map[TablesColumnFile.status] as String,
      subdisplaytype: map[TablesColumnFile.subdisplaytype] as String,
      mkey: map[TablesColumnFile.mkey] as String,
      codeLink: map[TablesColumnFile.codelink] as String,
      premetivedatatype: map[TablesColumnFile.premetivedatatype] as int,
      parenttype: map[TablesColumnFile.parenttype] as String,
      childtype: map[TablesColumnFile.childtype] as String,
     xminval: map[TablesColumnFile.xminval] as int,
     yminval: map[TablesColumnFile.yminval] as int,
     xinterval: map[TablesColumnFile.xinterval] as double,
     yinterval: map[TablesColumnFile.yinterval] as double,
      xcaption: map[TablesColumnFile.xcaption] as String,
      ycaption: map[TablesColumnFile.ycaption] as String,
      mcharttype: map[TablesColumnFile.mcharttype] as String,
        isfavalwed: map[TablesColumnFile.isfavalwed] as int,
        xcaprot : map[TablesColumnFile.xcaprot] as int,
    ycaprot : map[TablesColumnFile.ycaprot] as int,
    xaxisvsbl : map[TablesColumnFile.xaxisvsbl] as int,
    yaxisvsbl : map[TablesColumnFile.yaxisvsbl] as int,
        islegvis: map[TablesColumnFile.islegvis] as int,


    );
  }


  factory ChartsBean.fromMiddleware(Map<String, dynamic> map) {

    print("inside cgt1 ");
    return ChartsBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno]!=null?map[TablesColumnFile.mrefno] as int:0,
      mchartid: map[TablesColumnFile.mchartid] as int,
      mtitle: map[TablesColumnFile.mtitle] as String,
      mxcatg: map[TablesColumnFile.mxcatg] as String,
      mycatg: map[TablesColumnFile.mycatg] as String,
      mquery: map[TablesColumnFile.mquery] as String,
      mtype: map[TablesColumnFile.mtype] as String,
      mzcatg: map[TablesColumnFile.mzcatg] as String,
      misonline: map[TablesColumnFile.misonline] as int,
      mquerydesc: map[TablesColumnFile.mquerydesc] as String,
      mdefaulttype: map[TablesColumnFile.mdefaulttype] as String,
      mdatasource: map[TablesColumnFile.mdatasource] as String,
      subtitle: map[TablesColumnFile.subtitle] as String,
      subdescription: map[TablesColumnFile.subdescription] as String,
      image: map[TablesColumnFile.image] as String,
      status: map[TablesColumnFile.status] as String,
      subdisplaytype: map[TablesColumnFile.subdisplaytype] as String,
      mkey: map[TablesColumnFile.mkey] as String,
      codeLink: map[TablesColumnFile.codelink] as String,
      premetivedatatype: map[TablesColumnFile.premetivedatatype] as int,
      parenttype: map[TablesColumnFile.parenttype] as String,
      childtype: map[TablesColumnFile.childtype] as String,
      xminval: map[TablesColumnFile.xminval] as int,
      yminval: map[TablesColumnFile.yminval] as int,
      xinterval: map[TablesColumnFile.xinterval] as double,
      yinterval: map[TablesColumnFile.yinterval] as double,
      xcaption: map[TablesColumnFile.xcaption] as String,
      ycaption: map[TablesColumnFile.ycaption] as String,
        mcharttype: map[TablesColumnFile.mcharttype] as String,
      isfavalwed: map[TablesColumnFile.isfavalwed] as int,
      xcaprot : map[TablesColumnFile.xcaprot] as int,
      ycaprot : map[TablesColumnFile.ycaprot] as int,
      xaxisvsbl : map[TablesColumnFile.xaxisvsbl] as int,
      yaxisvsbl : map[TablesColumnFile.yaxisvsbl] as int,
      islegvis: map[TablesColumnFile.islegvis] as int,

    );
  }
}


class SimpleBarChartBean{

  SimpleBarChartBean(this.xAxis, this.yAxis);

  @override
  String toString() {
    return 'AxisBean{xAxis: $xAxis, yAxis: $yAxis}';
  }

  String xAxis;

  int yAxis;
}

class SimpleTimeSeriesChartsBean{

  SimpleTimeSeriesChartsBean(this.xAxis, this.yAxis);

  @override
  String toString() {
    return 'AxisBean{xAxis: $xAxis, yAxis: $yAxis}';
  }

  DateTime xAxis;
  int yAxis;
}



class NumTypeBean{

  NumTypeBean(this.xAxis, this.yAxis,this.y1Axis);

  @override
  String toString() {
    return 'AxisBean{xAxis: $xAxis, yAxis: $yAxis,xy: $y1Axis}';
  }
  final int xAxis;
  final int yAxis;
  final int y1Axis;
}





class SubItem {


   String type;
   String displayType;
   String title;
   String key;

   @override
   String toString() {
     return 'SubItem{mtype : ${mtype}, type: $type, displayType: $displayType, title: $title, key: $key, codeLink: $codeLink, description: $description, status: $status, subItems: $subItems chartSmapleclass: ${chartSampleData}';
   }

   String codeLink;
   String description;
   String status;
  List<dynamic> subItems;
   List<ChartSampleData> chartSampleData;


   String xCatogoryType;
   String yCategoryType;
   String xCategorySubType;
   String yCategorySubType;

   int xminval;
   int yminval;
   double xinterval;
   double yinterval;
   String mtype;
   String xcaption  ;
   String ycaption;
   bool istileview;



  SubItem(
   {this.type,
        this.displayType,
        this.title,
        this.key,
        this.codeLink,
        this.description,
        this.status,
        this.subItems,
      this.chartSampleData,
     this.xCatogoryType,
     this.yCategoryType,
     this.xCategorySubType,
     this.yCategorySubType,
     this.xminval,
     this.yinterval,
     this.xinterval,
     this.yminval,
     this.mtype,
     this.xcaption,
     this.ycaption,
     this.istileview

   });
  factory SubItem.fromJson(Map<dynamic, dynamic> json) {
    return SubItem(
      type: json['type'],
      displayType:json['displayType'],
      title: json['title'],
      key: json['key'],
      codeLink:json['codeLink'],
      description: json['description'],
      status:json['status'],
      subItems: json['subItems'],
      xcaption: json[TablesColumnFile.xcaption] as String,
      ycaption: json[TablesColumnFile.ycaption] as String,
    );
  }
}

class ChartFavouriteBean{
  int mrefno;
  String mcharttype;
  String mchartfavtype;

  ChartFavouriteBean({this.mrefno, this.mcharttype,this.mchartfavtype});


  factory ChartFavouriteBean.fromMap(Map<String,dynamic> map){
    return ChartFavouriteBean(
        mrefno: map[TablesColumnFile.mrefno] as int,
       mcharttype: map[TablesColumnFile.mcharttype] as String,
        mchartfavtype: map[TablesColumnFile.mchartfavtype] as String
    );

  }
}




//
//class ChartMenuHolder{
//  int menuid ;
//  String menuDesc ;
//  String menutype ;
//  String parenttype ;
//  String murl ;
//
//  String mapplicationtype ;
//  int mparentmenuid ;
//  int mchartid ;
//  ChartsBean chartBean;
//  List<ChartMenuHolder> chartSubMenu;
//
//
//  ChartMenuHolder(
//      {this.menuid,
//        this.menuDesc,
//        this.menutype,
//        this.parenttype,
//        this.murl,
//        this.mapplicationtype,
//        this.mparentmenuid,
//        this.mchartid,
//        this.chartBean,
//        this.chartSubMenu
//
//      });
//
//
//
//
//  factory ChartMenuHolder.fromMap(Map<String, dynamic> map) {
//    return ChartMenuHolder(
//      menuid : map[TablesColumnFile.menuid] as int,
//      menuDesc  : map[TablesColumnFile.menuDesc] as String,
//      menutype    : map[TablesColumnFile.menutype] as String,
//      parenttype    : map[TablesColumnFile.parenttype] as String,
//      murl    : map[TablesColumnFile.murl] as String,
//      mapplicationtype    : map[TablesColumnFile.mapplicationtype] as String,
//      mparentmenuid : map[TablesColumnFile.mparentmenuid] as int,
//      mchartid : map[TablesColumnFile.mchartid] as int,
//      //chartBean: map[TablesColumnFile.chartbean] as ChartsBean,
//
//
//
//    );
//  }
//
//
//
//
//}

