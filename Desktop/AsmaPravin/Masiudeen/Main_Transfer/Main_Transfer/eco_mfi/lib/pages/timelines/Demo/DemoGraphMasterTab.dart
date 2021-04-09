import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/line_series/customized_line_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/line_series/line_with_dashes.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/column_series/column_with_rounded_corners.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/area_series/default_area_chart.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoBarDefault.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoColumnDefault.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoCustomizedLine.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemoMultipleAxis.dart';
import 'package:eco_mfi/pages/timelines/Demo/DemopieGrouping.dart';

class DemoGraphMasterTab extends StatefulWidget {
  final ChartsBean chartPassedObject;

  DemoGraphMasterTab({Key key, this.chartPassedObject}) : super(key: key);

  @override
  _GraphMasterTabState createState() => _GraphMasterTabState();
}

class _GraphMasterTabState extends State<DemoGraphMasterTab> with SingleTickerProviderStateMixin {

  TabController _tabController;
  List<String> tabNames   = new List<String>();
  List<Widget> tabWidget =[ ];
  List<String> parentTypes = new List<String>();
  int count = 0;
  SubItem sampleClass = new SubItem();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//      parentTypes.addAll(widget.chartPassedObject.parenttype.split("~"));
////      for(var dummy in parentTypes ){
////        tabNames.add(dummy);
////      }


    widget.chartPassedObject.childtype = "Bar Default~Column Default~Customized Line~Multiple Axis~Default pie";
    tabNames.addAll(widget.chartPassedObject.childtype.split("~"));
    for(var createdTabs in tabNames){
      tabWidget.add(new GraphTabs(childTypes: createdTabs,chartPassedObject : widget.chartPassedObject,
          sample:sampleClass
      ));
    }
    _tabController = new TabController(
        vsync: this, initialIndex: 0, length:tabNames.length );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Graphical Analysis"),
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () { globals.sessionTimeOut= new SessionTimeOut(context: context);
          globals.sessionTimeOut.SessionTimedOut();
            //callDialog();
            // Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.black,
          isScrollable: true,
          tabs: new List.generate(tabNames.length, (index) {
            return new Tab(text: tabNames[index].toUpperCase());
          }),
        ),


      ),
      body: new TabBarView(
          controller: _tabController,
          children: tabWidget
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
  SubItem sample;

  GraphTabs({Key key, this.chartPassedObject,this.childTypes,this.sample}) : super(key: key);

  @override
  _GraphTabsState createState() => _GraphTabsState();
}

class _GraphTabsState extends State<GraphTabs> {
  List<Widget> widgetList = new List<Widget>();
  bool isFavourite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Sample initialization p hai ${widget.sample}");

    generateWidgetList();

  }

  void generateWidgetList(){
    if(widget.childTypes.toLowerCase()=='bar default'){
      widgetList.add(
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(icon: Icon(Icons.star_border), color: isFavourite==true?Colors.yellow
                    :Colors.black
                    , onPressed: (){
                  setState(() {
                    isFavourite = !isFavourite;
                  });


                    }),
                new IconButton(icon: Icon(Icons.info), onPressed: null)

              ],
        
      ),
          ));
      
      widgetList.add( new Card(
        child:new DemoBarDefault(
          sample: null,
        )
      ),);

      widgetList.add(
        new Card(
          child:new ListTile(
            title: new Text("Description",style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
            subtitle: new Text("This Graph shows the comparison of Different States Loan Collection with respect to the year it is collected "

            ),
          ) ,
        )
      );


    }
    else if(widget.childTypes.toLowerCase()=='column default'){
      widgetList.add(
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(icon: Icon(Icons.star_border), color: isFavourite==true?Colors.yellow
                    :Colors.black
                    , onPressed: (){
                      setState(() {
                        isFavourite = !isFavourite;
                      });


                    }),
                new IconButton(icon: Icon(Icons.info), onPressed: null)

              ],

            ),
          ));


      widgetList.add( new Card(
          child: DemoColumnDefault(
            sample: null,
          )
      ),);

      widgetList.add(
          new Card(
            child:new ListTile(
              title: new Text("Description",style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
              subtitle: new Text("This Graph shows the comparison of Different States Loan Collection with respect to the year it is collected "

              ),
            ) ,
          )
      );


    }
    else if(widget.childTypes.toLowerCase()=='customized line'){
      widgetList.add(
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(icon: Icon(Icons.star_border), color: isFavourite==true?Colors.yellow
                    :Colors.black
                    , onPressed: (){
                      setState(() {
                        isFavourite = !isFavourite;
                      });


                    }),
                new IconButton(icon: Icon(Icons.info), onPressed: null)

              ],

            ),
          ));

      widgetList.add(
       new Card(
          child: DemoCustomizedLine(
            sample: null,
          )
      ),);

      widgetList.add(
          new Card(
            child:new ListTile(
              title: new Text("Description",style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
              subtitle: new Text("This Graph shows the comparison of Different States Loan Collection with respect to the year it is collected "

              ),
            ) ,
          )
      );

    }

    else if(widget.childTypes.toLowerCase()=='multiple axis'){
      widgetList.add(
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(icon: Icon(Icons.star_border), color: isFavourite==true?Colors.yellow
                    :Colors.black
                    , onPressed: (){
                      setState(() {
                        isFavourite = !isFavourite;
                      });


                    }),
                new IconButton(icon: Icon(Icons.info), onPressed: null)

              ],

            ),
          ));

      widgetList.add( new Card(
          child: DemoMultipleAxis(
            sample: null,
          )
      ),);

      widgetList.add(
          new Card(
            child:new ListTile(
              title: new Text("Description",style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
              subtitle: new Text("This Graph shows the comparison of Different States Loan Collection with respect to the year it is collected "

              ),
            ) ,
          )
      );





    }
    else if(widget.childTypes.toLowerCase()=='default pie'){
      widgetList.add(
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(icon: Icon(Icons.star_border), color: isFavourite==true?Colors.yellow
                    :Colors.black
                    , onPressed: (){
                      setState(() {
                        isFavourite = !isFavourite;
                      });


                    }),
                new IconButton(icon: Icon(Icons.info), onPressed: null)

              ],

            ),
          ));

      widgetList.add( Container(
        height: 400.0,
        child: new Card(
          child:new DemoPieGrouping(
              sample: widget.sample
          ) ,
        ),
      ),);

      widgetList.add(
          new Card(
            child:new ListTile(
              title: new Text("Description",style: TextStyle(fontSize: 20.0 , fontWeight: FontWeight.bold),),
              subtitle: new Text("This Graph shows the comparison of Different States Loan Collection with respect to the year it is collected "

              ),
            ) ,
          )
      );





    }



  }
  @override
  Widget build(BuildContext context) {
    return new Column(
        children: widgetList
    );





    new Container(
        height: 500,
        child: new CustomizedLine(

        ));
  }
}

