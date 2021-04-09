
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/ChartsUtils.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_line_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/widgets/bottom_sheet.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoGraphMasterTab.dart';
import 'package:eco_mfi/pages/timelines/DisplayChartsInd.dart';

import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

import 'package:shared_preferences/shared_preferences.dart';


import 'ChartsBean.dart';
import 'DashBoardNewArchitect/chart/circular_charts/pie_series/default_pie_chart.dart';
/*import 'SimpleScatterPlotCharts.dart';
import 'SimpleTimeSeriesCharts.dart';*/
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoBarDefault.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoColumnDefault.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoCustomizedLine.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoMultipleAxis.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoPieGrouping.dart';

class DemoTimeLinesDashBoard extends StatefulWidget {
  @override
  _DemoTimeLinesDashBoardState createState() => _DemoTimeLinesDashBoardState();
}

class _DemoTimeLinesDashBoardState extends State<DemoTimeLinesDashBoard> {
  @override
  Widget build(BuildContext context) {

    return new SingleChildScrollView(

      child: new Column(

        children: <Widget>[
          Container(
            color:Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly
              ,children: <Widget>[

                new GestureDetector(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new ClipRect(

                          child: new Image(
                            image: new AssetImage("assets/graph7.png"),
                            alignment: Alignment.center,
                            height: 125.0,
                            width: 200.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Text("Graphical Analysis", style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
                        )
                      ]

                  ),
                  onTap:(){



                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => DemoGraphMasterTab(chartPassedObject: new ChartsBean() )), //When Authorized Navigate to the next screen
                    );


                  } ,

                ),





              GestureDetector(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new ClipRect(

                      child: new Image(
                        image: new AssetImage("assets/report7.png"),
                        alignment: Alignment.center,
                        height: 125.0,
                        width: 200.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: new Text("Reports", style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
                    )
                  ]

                ),

                onTap: (){
                 print("Pressed");


                },
              ),




            ],

            ),
          ),

          Container(
            height: 300.0,
            child: new Card(
                child: DemoPieGrouping(
                  sample: null,
                )
            ),
          ),

          new Card(
            child: DemoBarDefault(
              sample: null,
            )
          ),
          new Card(
              child: DemoColumnDefault(
              sample: null,
              )
          ),
          new Card(
              child: DemoCustomizedLine(
                sample: null,
              )
          ),
          new Card(
              child: DemoMultipleAxis(
                sample: null,
              )
          )

        ],
      ),
    );
  }
}
