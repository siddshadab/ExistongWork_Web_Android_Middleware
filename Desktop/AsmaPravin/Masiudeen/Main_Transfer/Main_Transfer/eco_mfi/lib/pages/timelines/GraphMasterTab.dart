import 'dart:io';

import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/axis_features/multiple_axis_chart/multiple_axis_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/bar_series/default_bar_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/column_series/column_width_and_spacing.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/stacked_series/stacked_area_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/stacked_series/stacked_bar_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/stacked_series/stacked_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/circular_charts/pie_series/pie_with_grouping.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/funnel_charts/funnel_with_smart_labels.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/pyramid_charts/pyramid_with_smart_labels.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/series_features/annotation/chart_with_annotation.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoAnnotationWatermark.dart';
import 'package:eco_mfi/pages/timelines/ManagmentDashBoard.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ChartsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/line_series/customized_line_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/line_series/line_with_dashes.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/column_series/column_with_rounded_corners.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/area_series/default_area_chart.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:screenshot/screenshot.dart';
import 'package:open_file/open_file.dart';

import 'DashBoardNewArchitect/chart/circular_charts/Export/export.dart';
import 'DashBoardNewArchitect/chart/series_features/Gradient/Vertical_Gradient.dart';

class GraphMasterTab extends StatefulWidget {
  final ChartsBean chartPassedObject;

  GraphMasterTab({Key key, this.chartPassedObject}) : super(key: key);

  @override
  _GraphMasterTabState createState() => _GraphMasterTabState();
}

class _GraphMasterTabState extends State<GraphMasterTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabNames = new List<String>();
  List<Widget> tabWidget = [];
  List<String> parentTypes = new List<String>();
  int count = 0;

  //SubItem sampleClass = new SubItem();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//      parentTypes.addAll(widget.chartPassedObject.parenttype.split("~"));
////      for(var dummy in parentTypes ){
////        tabNames.add(dummy);
////      }

//    sampleClass.chartSampleData = widget.chartPassedObject.chartSampleData;
//    sampleClass.mtype = widget.chartPassedObject.mtype;
//    sampleClass.xcaption = widget.chartPassedObject.xcaption;
//    sampleClass.ycaption = widget.chartPassedObject.ycaption;

//    if(sampleClass.chartSampleData!=null&&sampleClass.chartSampleData.isNotEmpty){
//      if(sampleClass.mtype=='xy'){
//        int xminVal;
//        int yminval;
//        double totalXVal = 0.0;
//        double totalYVal= 0.0;
//        for(int i = 0;i<sampleClass.chartSampleData.length;i++){
//          try{
//           if(i==0)xminVal = sampleClass.chartSampleData[i].xValue;
//           else if(xminVal>sampleClass.chartSampleData[i].xValue){
//             xminVal = sampleClass.chartSampleData[i].xValue;
//           }
//           totalXVal+=sampleClass.chartSampleData[i].xValue;
//
//          }catch(_){
//            xminVal= 0;
//            totalXVal = 0.0;
//          }
//
//          try{
//            if(i==0)yminval = sampleClass.chartSampleData[i].yValue;
//            else if(yminval>sampleClass.chartSampleData[i].yValue){
//              yminval = sampleClass.chartSampleData[i].yValue;
//            }
//            totalYVal+=sampleClass.chartSampleData[i].yValue;
//
//          }catch(_){
//            yminval= 0;
//            totalYVal = 0;
//          }
//
//        }
//
//        if(widget.chartPassedObject.xinterval!=0){
//          sampleClass.xinterval = widget.chartPassedObject.xinterval;
//        }else{
//          if(sampleClass.chartSampleData.length!=0){
//            sampleClass.xinterval = totalXVal/sampleClass.chartSampleData.length;
//          }
//
//        }
//
//        if(widget.chartPassedObject.yinterval!=0){
//          sampleClass.yinterval = widget.chartPassedObject.yinterval;
//        }else{
//          if(sampleClass.chartSampleData.length!=0){
//            sampleClass.yinterval = totalYVal/sampleClass.chartSampleData.length;
//          }
//
//        }
//
//        if(widget.chartPassedObject.xminval!=0)
//          sampleClass.xminval = widget.chartPassedObject.xminval;
//        else{
//          sampleClass.xminval = xminVal;
//        }
//
//        if(widget.chartPassedObject.yminval!=0){
//          sampleClass.yminval = widget.chartPassedObject.yminval;
//        }else{
//          sampleClass.yminval  = yminval;
//          ;
//        }
//
//
//      }
//
//
//
//
//    }

    tabNames.addAll(widget.chartPassedObject.childtype.split("~"));
    for (var createdTabs in tabNames) {
      tabWidget.add(new GraphTabs(
        childTypes: createdTabs,
        chartPassedObject: widget.chartPassedObject,
      ));
    }
    _tabController = new TabController(
        vsync: this, initialIndex: 0, length: tabNames.length);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.chartPassedObject.mtitle,
            style: new TextStyle(
                color: globals.appbartext ?? Colors.white, fontSize: 22.0)),
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,
              color: globals.appbaricon ?? Colors.white),
          onPressed: () {
            globals.sessionTimeOut = new SessionTimeOut(context: context);
            globals.sessionTimeOut.SessionTimedOut();

            //callDialog();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: globals.appbar ?? Color(0xff07426A),
        brightness: Brightness.light,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          isScrollable: true,
          tabs: new List.generate(tabNames.length, (index) {
            return new Tab(
              text: tabNames[index].toUpperCase(),
            );
          }),
        ),
      ),
      body: new TabBarView(controller: _tabController, children: tabWidget
          /*<Widget>[
            new LoanLimitDetails(),
            new CustomerLoanAddressDetails(),
            new CustomerLoanDeclaration()
          ],*/
          ),
    );
  }
}

class GraphTabs extends StatefulWidget {
  final ChartsBean chartPassedObject;
  String childTypes;

  GraphTabs({Key key, this.chartPassedObject, this.childTypes})
      : super(key: key);

  @override
  _GraphTabsState createState() => _GraphTabsState();
}

class _GraphTabsState extends State<GraphTabs> {
  List<Widget> widgetList = new List<Widget>();
  Widget chartWidget = new Row();
  bool isFavourite = false;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Widget.childType  = widget.childTypes");

    getChartWidget();
    getFavouriteList();
  }

  Future<Null> getFavouriteList() async {
    try {
      await AppDatabaseExtended.get()
          .getChartsBean(widget.chartPassedObject.mchartid, widget.childTypes)
          .then((ChartFavouriteBean returnedBean) {
        setState(() {
          if (returnedBean != null &&
              returnedBean.mrefno == widget.chartPassedObject.mchartid &&
              widget.childTypes == returnedBean.mcharttype) {
            isFavourite = true;
          }
        });
      });
    } catch (_) {}
  }

  void getChartWidget() {
    widget.chartPassedObject.isTile = false;

    switch (widget.childTypes.toLowerCase()) {
      case ("customized line"):
        print("Iske andar aya");
        chartWidget = new Card(
          child: new CustomizedLine(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case ("line dashed"):
        chartWidget = new Card(
          child: new CustomizedLine(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.columndefault):
        chartWidget = new Card(
          child: new ColumnDefault(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.columnrounded):
        chartWidget = new Card(
          child: new ColumnRounded(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.areadefault):
        chartWidget = new Card(
          child: new AreaDefault(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.multipleaxis):
        chartWidget = new Card(
          child: new MultipleAxis(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;

      case (TablesColumnFile.piegrouping):
        chartWidget = Container(
          height: 400.0,
          child: new Card(
            child: new PieGrouping(
              chartObject: widget.chartPassedObject,
            ),
          ),
        );
        break;

      case (TablesColumnFile.chartwithannotation):
        chartWidget =
//      new Card(
//        child:new DemoAnnotationWatermark() ,
//      );

            new Card(
          child: new AnnotationWatermark(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.columnwidthspace):
        chartWidget = new Card(
          child: new ColumnSpacing(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;

      case (TablesColumnFile.stackedarea):
        chartWidget = new Card(
          child: new StackedAreaChart(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.stackedcolumn):
        print("switch match  ${TablesColumnFile.stackedcolumn}");
        chartWidget = new Card(
          child: new StackedColumnChart(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.defaultbar):
        print("switch match  ${TablesColumnFile.defaultbar}");
        chartWidget = new Card(
          child: new BarDefault(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.stackedbar):
        print("switch match  ${TablesColumnFile.stackedbar}");
        chartWidget = new Card(
          child: new StackedBarChart(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;
      case (TablesColumnFile.verticalgradient):
        print("switch match  ${TablesColumnFile.verticalgradient}");
        chartWidget = new Card(
          child: new VerticalGradient(
            chartObject: widget.chartPassedObject,
          ),
        );
        break;

      case (TablesColumnFile.funnelwithsmartlabel):
        print("switch match  ${TablesColumnFile.funnelwithsmartlabel}");
        chartWidget = Container(
            height: 400.0,
            child: new Card(
              child: new FunnelSmartLabels(
                chartObject: widget.chartPassedObject,
              ),
            ));
        break;

      case (TablesColumnFile.pyramidlwithsmartlabel):
        print("switch match  ${TablesColumnFile.pyramidlwithsmartlabel}");
        chartWidget = Container(
            height: 400.0,
            child: new Card(
              child: new PyramidSmartLabels(
                chartObject: widget.chartPassedObject,
              ),
            ));
        break;
      case (TablesColumnFile.pyramidlwithsmartlabel):
        print("switch match  ${TablesColumnFile.pyramidlwithsmartlabel}");
        chartWidget = Container(
            height: 400.0,
            child: new Card(
              child: new PyramidSmartLabels(
                chartObject: widget.chartPassedObject,
              ),
            ));
        break;

      case (TablesColumnFile.exporting):
        print("switch match  ${TablesColumnFile.exporting}");
        chartWidget = Container(
            height: 400.0,
            child: new Card(
              child: new ExportCircular(
                chartObject: widget.chartPassedObject,
              ),
            ));
        break;

      default:
        chartWidget = new Row();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Data Source : ${widget.chartPassedObject.mdatasource}"),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new IconButton(
                        icon: Icon(Icons.share),
                        color: Colors.blue,
                        onPressed: () async {
                          _createPDF();
                        }),
                    widget.chartPassedObject.isfavalwed == 1
                        ? new IconButton(
                        icon: Icon(Icons.star),
                        color:
                        isFavourite == true ? Colors.yellow : Colors.grey,
                        onPressed: () async {
                          if (isFavourite == false) {
                            await AppDatabaseExtended.get()
                                .getFavouriteTypes()
                                .then((List<ChartFavouriteTypes> favTypeList) {
                              print("returned fav list ${favTypeList}");
                              typesOfFavType(favTypeList);
                            });
                          } else {
                            AppDatabaseExtended.get().deleteChartsFavouriteBean(
                                widget.chartPassedObject.mchartid,
                                widget.childTypes);
                            setState(() {
                              isFavourite = !isFavourite;
                            });
                          }
                        })
                        : new SizedBox(
                    ),
                  ],
                ),


              ],
            ),
          ),
          Screenshot(
            controller: screenshotController,
            child: chartWidget,
          ),
          new Card(
            child: new ListTile(
              title: new Text(
                "Description",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              subtitle: new Text(widget.chartPassedObject.subdescription),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _createPDF() async {
    //Create a new PDF document
    PdfDocument document = PdfDocument();

    PdfPage page = document.pages.add();

    await screenshotController.capture().then((File image) async {
      print("File hai ${image.readAsBytesSync()} ");
      var imageBitMap = await image.readAsBytesSync();

      page.graphics.drawImage(
          PdfBitmap(image.readAsBytesSync()),
          Rect.fromLTWH(0, 30, page.getClientSize().width,
              page.getClientSize().height - 40));
    });

    PdfTextElement textElement = PdfTextElement(
        text: widget.chartPassedObject.mtitle,
        font: PdfStandardFont(PdfFontFamily.helvetica, 18));

    PdfLayoutResult layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            80, 150, page.getClientSize().width, page.getClientSize().height));
    PdfGrid grid = PdfGrid();

    if (widget.chartPassedObject.mtype == 'xy') {
      grid.columns.add(count: 2);
      grid.headers.add(1);
      PdfGridRow header = grid.headers[0];
      header.cells[0].value = widget.chartPassedObject.categoryNames[1] ?? '';
      header.cells[1].value = widget.chartPassedObject.categoryNames[0] ?? '';

      header.style = PdfGridRowStyle(
          backgroundBrush: PdfBrushes.cadetBlue,
          textBrush: PdfBrushes.black,
          font: PdfStandardFont(PdfFontFamily.timesRoman, 25));

//Add rows to grid
      PdfGridRow row = grid.rows.add();
      for (int i = 0;
          i < widget.chartPassedObject.chartSampleData.length;
          i++) {
        if (i != 0) {
          row = grid.rows.add();
        }
        row.cells[0].value = widget.chartPassedObject.chartSampleData[i].xValue;
        print(widget.chartPassedObject.chartSampleData[i].yValue.toString());
        row.cells[1].value =
            widget.chartPassedObject.chartSampleData[i].yValue.toString();
        //row.cells[1].value = "31";

      }
    } else if (widget.chartPassedObject.mtype == 'xyy' ||
        widget.chartPassedObject.mtype == 'xyn') {
      grid.columns.add(count: 3);
      grid.headers.add(1);
      PdfGridRow header = grid.headers[0];
      header.cells[0].value = widget.chartPassedObject.categoryNames[2] ?? '';
      header.cells[1].value = widget.chartPassedObject.categoryNames[0] ?? '';
      header.cells[2].value = widget.chartPassedObject.categoryNames[1] ?? '';

      header.style = PdfGridRowStyle(
          backgroundBrush: PdfBrushes.cadetBlue,
          textBrush: PdfBrushes.black,
          font: PdfStandardFont(PdfFontFamily.timesRoman, 25));

//Add rows to grid
      PdfGridRow row = grid.rows.add();
      for (int i = 0;
          i < widget.chartPassedObject.chartSampleData.length;
          i++) {
        if (i != 0) {
          row = grid.rows.add();
        }
        row.cells[0].value = widget.chartPassedObject.chartSampleData[i].xValue;
        print(widget.chartPassedObject.chartSampleData[i].yValue.toString());
        row.cells[1].value =
            widget.chartPassedObject.chartSampleData[i].yValue.toString();
        row.cells[2].value =
            widget.chartPassedObject.chartSampleData[i].yValue2.toString();
        //row.cells[1].value = "31";

      }
    }
//Set the grid style
    grid.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 25));

//Create a PdfGrid

//Assign data source
    //grid.dataSource = dataTable;

//Draw grid to the page of the PDF document
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    //Save the document
    List<int> bytes = document.save();

    final directory = await getExternalStorageDirectory();

//Get directory path
    final path = directory.path;
    //final path ="/storage/emulated/0/eCO";
    print(path);
//Create an empty file to write PDF data
    File file = File('$path/${widget.chartPassedObject.mtitle}.pdf');
//Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    Toast.show(
        'File Saved as ' + '$path/${widget.chartPassedObject.mtitle}.pdf',
        context);
    //Dispose the document
    document.dispose();

    OpenFile.open("$path/${widget.chartPassedObject.mtitle}.pdf");
  }

  Future<void> typesOfFavType(List<ChartFavouriteTypes> favList) async {
    List<Widget> columnChildre = new List<Widget>();
    Widget submittingColumn = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnChildre,
    );

    for (ChartFavouriteTypes item in favList) {
      columnChildre.add(new GestureDetector(
        onTap: () {
          AppDatabaseExtended.get().updateChartsFavouriteMaster(
              ChartFavouriteBean(
                  mrefno: widget.chartPassedObject.mchartid,
                  mcharttype: widget.childTypes,
                  mchartfavtype: item.typeName));
          setState(() {
            isFavourite = true;
          });
          Navigator.of(context).pop();
        },
        child: new Card(
          child: new ListTile(
            leading: new Icon(Icons.pie_chart,color: Colors.deepOrangeAccent,),
            title: new Text("${item.typeName}"),
          ),
        ),
      ));
    }
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.touch_app,
              color: Colors.blue[800],
              size: 40.0,
            ),
            content: SingleChildScrollView(
              //       child: Container(
              // height: 100.0 + count * 40.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    children: <Widget>[new Text("Select the Category" + " :")],
                  ),
                  submittingColumn
                ],
              ),
              //),
            ),

//            SingleChildScrollView(
//              padding: const EdgeInsets.all(12.0),
//              child: ListView.builder(
//                itemCount: favList.length,
//                itemBuilder: (BuildContext context, int index){
//                  return Container(
//                    width:500.0,
//                    child: Card(
//                      child: new ListTile(
//                          title: new Text("${favList[index].typeName}"),
//                          subtitle: new Text(
//                              favList[index].typeName,
//                              style: TextStyle(color: Colors.blue[800])),
//                          onTap: () async {
//                                  AppDatabaseExtended.get()
//                                      .updateChartsFavouriteMaster(
//                                          ChartFavouriteBean(
//                                              mrefno:
//                                                  widget.chartPassedObject.mchartid,
//                                              mcharttype: widget.childTypes,
//                                              mchartfavtype: favList[index].typeName
//                                          ));
//                                  setState(() {
//                                    isFavourite = true;
//                                  });
//                          }),
//                    ),
//                  );
//                },
//                padding: EdgeInsets.all(0.0),
//              ),
//            ),

            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Add New',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
                onPressed: () {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
                  globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  saveWithTextField("New List", context);
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
                  globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  saveWithTextField(String message, BuildContext context) {
    String name = "";
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                      width: 400.0,
                      child: new TextField(
                        decoration: InputDecoration(),
                        onChanged: (String val) {
                          name = val;
                        },
                      ))
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                onPressed: () async {
                  globals.sessionTimeOut = new SessionTimeOut(context: context);
                  globals.sessionTimeOut.SessionTimedOut();

                  await AppDatabaseExtended.get().updateChartFavType(ChartFavouriteTypes(typeName:name));

                  await AppDatabaseExtended.get().updateChartsFavouriteMaster(
                      ChartFavouriteBean(
                          mrefno: widget.chartPassedObject.mchartid,
                          mcharttype: widget.childTypes,
                          mchartfavtype: name));
                  setState(() {
                    isFavourite = true;
                  });

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
