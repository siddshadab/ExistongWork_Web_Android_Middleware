import 'dart:io';

import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/ReportUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:screenshot/screenshot.dart';
import 'package:open_file/open_file.dart';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ReportMasterTab extends StatefulWidget {
  final ChartsBean chartBean;
  final DataRecords dataRecords;
  ReportMasterTab({this.chartBean, this.dataRecords});

  @override
  _ReportMasterTab createState() => new _ReportMasterTab();
}

class _ReportMasterTab extends State<ReportMasterTab> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget dataTable;
  var dataColumnList;
  var dataRowList;
  var dataCellList;
  @override
  void initState() {
    dataColumnList = new List<DataColumn>();
    dataRowList = new List<DataRow>();

    for (String items in widget.dataRecords.listColumnWidget) {
      dataColumnList.add(
        new DataColumn(
          label: Text(items,style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
    }

    for (List<String> item1 in widget.dataRecords.listRowWidget) {
      dataCellList = new List<DataCell>();
      for (String item2 in item1) {
        dataCellList.add(new DataCell(
          new Text(
            item2,
            style: TextStyle(),
          ),
        ));
      }
      dataRowList.add(new DataRow(
        cells: dataCellList,
      ));
    }

    dataTable = new DataTable(columns: dataColumnList, rows: dataRowList);
  }

  String value = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
      child: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          elevation: 1.0,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                globals.sessionTimeOut = new SessionTimeOut(context: context);
                globals.sessionTimeOut.SessionTimedOut();
                Navigator.of(context).pop();
                // callDialog();
              }),
          backgroundColor: Color(0xff07426A),
          brightness: Brightness.light,
          title: new Text(
            'Devlopers',
            //textDirection: TextDirection,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.normal),
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () {
                globals.sessionTimeOut = new SessionTimeOut(context: context);
                globals.sessionTimeOut.SessionTimedOut();
                _createPDF();
                // proceed();
              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              new SingleChildScrollView(
                  // physics: new AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: dataTable),
            ]),
      ),
    );
  }

  Future<void> _createPDF() async {
    //Create a new PDF document
    PdfDocument document = PdfDocument();

    //PdfPage page = document.pages.add();

    PdfTextElement textElement = PdfTextElement(
        text: widget.chartBean.mtitle,
        font: PdfStandardFont(PdfFontFamily.helvetica, 18));

//    PdfLayoutResult layoutResult = textElement.draw(
//        page: page,
//        bounds: Rect.fromLTWH(
//            80, 150, page.getClientSize().width, page.getClientSize().height));
    PdfGrid grid = PdfGrid();

    grid.columns.add(count: widget.dataRecords.listColumnWidget.length);
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];

    for (int i = 0; i < widget.dataRecords.listColumnWidget.length; i++) {
      header.cells[i].value = widget.dataRecords.listColumnWidget[i] ?? '';
    }

    header.style = PdfGridRowStyle(
        backgroundBrush: PdfBrushes.cadetBlue,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 18));

//Add rows to grid
    PdfGridRow row = grid.rows.add();
    for (int i = 0; i < widget.dataRecords.listRowWidget.length; i++) {
      if (i != 0) {
        row = grid.rows.add();
      }
      for (int j = 0; j < widget.dataRecords.listRowWidget[i].length; j++) {
        row.cells[j].value = widget.dataRecords.listRowWidget[i][j];
        //print(widget.chartPassedObject.chartSampleData[i].yValue.toString());

      }
    }

//Set the grid style
    grid.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 10));

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
    File file = File('$path/${widget.chartBean.mtitle}.pdf');
//Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    Toast.show(
        'File Saved as ' + '$path/${widget.chartBean.mtitle}.pdf', context);
    //Dispose the document
    document.dispose();

    OpenFile.open("$path/${widget.chartBean.mtitle}.pdf");
  }
}
