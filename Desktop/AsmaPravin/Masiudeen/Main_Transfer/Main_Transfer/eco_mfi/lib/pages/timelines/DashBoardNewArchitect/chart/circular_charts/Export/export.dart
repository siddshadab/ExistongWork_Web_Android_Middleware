import 'dart:async';
import 'dart:io';
import 'dart:ui' as dart_ui;

///Package imports
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// Chart import
///
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';import 'package:eco_mfi/pages/chartsLib/charts.dart';

/// Local imports



///Renders default circular chart sample
class ExportCircular extends StatefulWidget {
  ExportCircular({this.chartObject, Key key}) : super(key: key);
  final ChartsBean chartObject;

  @override
  _ExportState createState() => _ExportState();
}

class _ExportState extends State<ExportCircular> {
  //final GlobalKey<SfCircularChartState> _circularChartKey = GlobalKey();
  _ExportState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: model.cardThemeColor,
        body: Column(children: [
          Expanded(child: _getCircularChart(widget.chartObject)),
//          Container(
//              padding: EdgeInsets.only(bottom: 10),
//              child: Row(
//                children: [
//                  Spacer(),
//                  Container(
//                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
//                        BoxShadow(
//                          color: Colors.grey,
//                          offset: const Offset(0, 4.0),
//                          blurRadius: 4.0,
//                        ),
//                      ], shape: BoxShape.circle, color:Colors.white),
//                      alignment: Alignment.center,
//                      child: IconButton(
//                        onPressed: () {
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            behavior: SnackBarBehavior.floating,
//                            duration: Duration(milliseconds: 100),
//                            shape: RoundedRectangleBorder(
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(5))),
//                            content:
//                            Text("Chart has been exported as PNG image"),
//                          ));
//                          //_renderCircularImage();
//                        },
//                        icon: Icon(Icons.image, color: Colors.white),
//                      )),
//                  Container(
//                      padding: EdgeInsets.only(left: 10, right: 10),
//                      decoration: BoxDecoration(boxShadow: <BoxShadow>[
//                        BoxShadow(
//                          color: Colors.grey,
//                          offset: const Offset(0, 4.0),
//                          blurRadius: 4.0,
//                        ),
//                      ], shape: BoxShape.circle, color:Colors.grey),
//                      alignment: Alignment.center,
//                      child: IconButton(
//                        onPressed: () {
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            behavior: SnackBarBehavior.floating,
//                            duration: Duration(milliseconds: 2000),
//                            shape: RoundedRectangleBorder(
//                                borderRadius:
//                                BorderRadius.all(Radius.circular(5))),
//                            content:
//                            Text("Chart is being exported as PDF document"),
//                          ));
//                          //_renderPdf();
//                        },
//                        icon: Icon(Icons.picture_as_pdf, color: Colors.white),
//                      )),
//                ],
//              ))
        ]));
  }

  /// Get default circular chart
  SfCircularChart _getCircularChart(  ChartsBean chartObject ) {
    return SfCircularChart(
      //backgroundColor: model.cardThemeColor,
      //key: _circularChartKey,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
        iconBorderWidth: 1,
        iconBorderColor: Colors.black,
      ),
//      title: ChartTitle(
//        text: chartObject.isTile==true? ' ' +chartObject.mtitle+ ' ':'', borderColor: Color(0xff283593), borderWidth: 2.0, ),
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            height: '55%',
            width: '55%',
            widget: Container(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(Icons.exposure, color: Colors.black),
                )))
      ],
      series: _getDefaultCircularSeries(chartObject),
    );
  }

  /// Get default circular series
  List<CircularSeries<ChartSampleData, String>> _getDefaultCircularSeries(ChartsBean chartObject) {

    if(chartObject.mtype=='xy'){
  return <CircularSeries<ChartSampleData, String>>[
  DoughnutSeries<ChartSampleData, String>(
  dataSource: chartObject.chartSampleData,
  xValueMapper: (ChartSampleData sales, _) => sales.xValue,
  yValueMapper: (ChartSampleData sales, _) => sales.yValue,
  strokeColor:Colors.white,
  explode: true,
  strokeWidth: 1,
  legendIconType: LegendIconType.rectangle,
  dataLabelMapper: (ChartSampleData sales, _) => sales.yValue.toString(),
  dataLabelSettings: DataLabelSettings(isVisible: true))
  ];
  }else{
  final List<ChartSampleData> chartData = <ChartSampleData>[
  ChartSampleData(x: 'Once a month', y: 25, text: '25%'),
  ChartSampleData(x: 'Everyday', y: 4, text: '4%'),
  ChartSampleData(x: 'At least once a week', y: 14, text: '14%'),
  ChartSampleData(x: 'Once every 2-3 months', y: 10, text: '10%'),
  ChartSampleData(x: 'A few times a year', y: 15, text: '15%'),
  ChartSampleData(x: 'Less often than that', y: 7, text: '7%'),
  ChartSampleData(x: 'Never', y: 25, text: '25%'),
  ];
  return <CircularSeries<ChartSampleData, String>>[
  DoughnutSeries<ChartSampleData, String>(
  dataSource: chartData,
  xValueMapper: (ChartSampleData sales, _) => sales.x,
  yValueMapper: (ChartSampleData sales, _) => sales.y,
  strokeColor:Colors.white,
  explode: true,
  strokeWidth: 1,
  legendIconType: LegendIconType.rectangle,
  dataLabelMapper: (ChartSampleData sales, _) => sales.text,
  dataLabelSettings: DataLabelSettings(isVisible: true))
  ];
  }



  }

  Future<void> _renderCircularImage() async {
    final bytes = null;
    if (bytes != null) {
      final Directory documentDirectory =
      await getApplicationDocumentsDirectory();
      final String path = documentDirectory.path;
      final String imageName = 'circularchart.png';
      imageCache.clear();
      File file = new File('$path/$imageName');
      file.writeAsBytesSync(bytes);

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Container(
                  color: Colors.white,
                  child: Image.file(file),
                ),
              ),
            );
          },
        ),
      );
    }
  }

//  Future<void> _renderPdf() async {
//    final PdfDocument document = PdfDocument();
//    final PdfBitmap bitmap = PdfBitmap(await _readImageData());
//    document.pageSettings.orientation =
//    MediaQuery.of(context).orientation == Orientation.landscape
//        ? PdfPageOrientation.landscape
//        : PdfPageOrientation.portrait;
//    document.pageSettings.margins.all = 0;
//    document.pageSettings.size =
//        Size(bitmap.width.toDouble(), bitmap.height.toDouble());
//    final PdfPage page = document.pages.add();
//    final Size pageSize = page.getClientSize();
//    page.graphics.drawImage(
//        bitmap, Rect.fromLTWH(0, 0, pageSize.width, pageSize.height));
//    Scaffold.of(context).hideCurrentSnackBar();
//    Scaffold.of(context).showSnackBar(SnackBar(
//      behavior: SnackBarBehavior.floating,
//      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.all(Radius.circular(5))),
//      duration: Duration(milliseconds: 200),
//      content: Text("Chart has been exported as PDF document."),
//    ));
//
//    final List<int> bytes = document.save();
//    document.dispose();
//   // await FileSaveHelper.saveAndLaunchFile(bytes, 'circular_chart.pdf');
//  }

//  Future<List<int>> _readImageData() async {
//    dart_ui.Image data =
//    await _circularChartKey.currentState.toImage(pixelRatio: 3.0);
//    final bytes = await data.toByteData(format: dart_ui.ImageByteFormat.png);
//    return bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
//  }
}