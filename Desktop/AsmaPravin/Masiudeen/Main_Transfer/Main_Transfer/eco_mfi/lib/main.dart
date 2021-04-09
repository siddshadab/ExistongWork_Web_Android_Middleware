import 'dart:async';
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';

//import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';
import 'package:eco_mfi/Design/CustomBubbleTabIndicatorTheme.dart';
import 'package:eco_mfi/Login.dart';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/CheckListGRTBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/SettingsBean.dart';
import 'package:eco_mfi/pages/workflow/qrScanner/QrScanner.dart';
import 'package:permission/permission.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MenuAndRights/MenuMasterBean.dart';
import 'MenuAndRights/UserRightsBean.dart';
import 'translations.dart';
import 'application.dart';
import 'package:flutter/services.dart' show  rootBundle;



String get = '';
//SettingsBean settingsBean ;
SettingsBean settingsBean = new SettingsBean();

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await updateControl();
  /*ChartsBean chartsBean = new ChartsBean(trefno: 1,mrefno: 1,mchartid:2,mtitle:"Customer Query1" ,
  mquery: 'Select mnametitle as x , Count(*) as y  from customerFoundationMasterDetails where mcreatedby= "LOGINUSER" group by mnametitle', mtype: "xy",chartType: null,simpleBarChartBean: null,
  mxcatg: "xcat",mycatg: "Ycat",mzcatg: "Zcat",misonline: 2,mquerydesc:"Desc",mdefaulttype: "default_column_chart",mdatasource:"Source",subTitle: "SubqueryTitle1", description: "",
    image: "",   status: "",   displayType: "",   key: "",  codeLink: "", premetiveDataType: 1,parenttype: 'Charts Type~Axis~Series Features',childtype: 'Column~Line');
  await AppDatabase.get().updateChartsMaster(chartsBean);

  ChartsBean chartsBean2 = new ChartsBean(trefno: 1,mrefno: 2,mchartid:2,mtitle:"Customer Query2" ,
      mquery: 'Select mcuststatus as x ,  Count(*) as y  from customerFoundationMasterDetails where mcreatedby= "LOGINUSER" Group by mcuststatus' , mtype: "xy",chartType: null,simpleBarChartBean: null,
      mxcatg: "xcat",mycatg: "Ycat",mzcatg: "Zcat",misonline: 2,mquerydesc:"Desc",mdefaulttype: "back_to_back_column",mdatasource:"Source",subTitle: "SubqueryTitle2", description: "",
    image: "",   status: "",   displayType: "",   key: "",  codeLink: "", premetiveDataType: 1,parenttype: 'Charts Type~Axis~Series Features',childtype: 'Column~Line');
  await AppDatabase.get().updateChartsMaster(chartsBean2);


  ChartsBean chartsBean3 = new ChartsBean(trefno: 1,mrefno: 3,mchartid:2,mtitle:"Customer Query3" ,
      mquery: 'Select Count(*) as x , count(mtier) as y,count(mnametitle) as y1  from customerFoundationMasterDetails where mcreatedby= "LOGINUSER" group by mtier,mnametitle', mtype: "xy",chartType: null,simpleBarChartBean: null,
      mxcatg: "xcat",mycatg: "Ycat",mzcatg: "Zcat",misonline: 2,mquerydesc:"Desc",mdefaulttype: "back_to_back_column",mdatasource:"Source",subTitle: "SubqueryTitle3", description: "",
    image: "",   status: "",   displayType: "",   key: "",  codeLink: "", premetiveDataType: 1,parenttype: 'Charts Type~Axis~Series Features',childtype: 'Column~Line');
  await AppDatabase.get().updateChartsMaster(chartsBean3);

  ChartsBean chartsBean4 = new ChartsBean(trefno: 1,mrefno: 4,mchartid:2,mtitle:"Customer Query4" ,
      mquery: 'Select Count(*) as x , count(mtier) as y,count(mnametitle) as y1  from customerFoundationMasterDetails where mcreatedby= "LOGINUSER" group by mtier,mnametitle', mtype: "xy",chartType: null,simpleBarChartBean: null,
      mxcatg: "xcat",mycatg: "Ycat",mzcatg: "Zcat",misonline: 2,mquerydesc:"Desc",mdefaulttype: "back_to_back_column",mdatasource:"Source",subTitle: "SubqueryTitle4", description: "",
    image: "",   status: "",   displayType: "",   key: "back_to_back_column",  codeLink: "", premetiveDataType: 1,parenttype: 'Charts Type~Axis~Series Features',childtype: 'Column~Line');
  await AppDatabase.get().updateChartsMaster(chartsBean4);

  ChartsBean chartsBean5 = new ChartsBean(trefno: 1,mrefno: 5,mchartid:2,mtitle:"Customer Query5" ,
      mquery: 'Select Count(*) as x , count(mtier) as y,count(mtier) as y1  from customerFoundationMasterDetails where mcreatedby= "LOGINUSER" group by mtier', mtype: "xy",chartType: null,simpleBarChartBean: null,
      mxcatg: "xcat",mycatg: "Ycat",mzcatg: "Zcat",misonline: 2,mquerydesc:"Desc",mdefaulttype: "back_to_back_column",mdatasource:"Source", subTitle: "SubqueryTitle5", description: "",
    image: "",   status: "",   displayType: "",   key: "back_to_back_column",  codeLink: "", premetiveDataType: 1,parenttype: 'Charts Type~Axis~Series Features',childtype: 'Column~Line');
  await AppDatabase.get().updateChartsMaster(chartsBean5);
*/
  /* ChartsBean chartsBean2 = new ChartsBean(trefno: 2,mrefno: 2,mtitle: "Customer Query",mtype: "1",mdefaulttype: "1",mxcatg: "xcat",mycatg: "Ycat",mchartid: "2",mquery: "Select 20 As x, 10 as  y from customer_Loan_Details_Master as b,customerFoundationMasterDetails as a  where a.mcustno = b.mcustno group by b.mcustno",chartType: null);
  await AppDatabase.get().updateChartsMaster(chartsBean2);
  ChartsBean chartsBean3 = new ChartsBean(trefno: 3,mrefno: 3,mtitle: "Title4",mtype: "1",mdefaulttype: "4",mxcatg: "xcat",mycatg: "Ycat",mchartid: "4",mquery: "Query",chartType: null);
  await AppDatabase.get().updateChartsMaster(chartsBean3);
  ChartsBean chartsBean4 = new ChartsBean(trefno: 4,mrefno: 4,mtitle: "Center wise Customer mrefno ",mtype: "1",mdefaulttype: "5",mxcatg: "x",mycatg: "y",mchartid: "1",mquery: "Select mcustno As x, mrefno as  y from customerFoundationMasterDetails group by mcenterid LIMIT 10",chartType: null);
  await AppDatabase.get().updateChartsMaster(chartsBean4);
*/
  // Constant.setStaticAccess();
  await Constant.setVer();
  await Constant.generateUrl();
  await Constant.getDropDownInitialize();
  //added here
  /* await Constant.getPermissionStatus();
  await Constant.requestPermissions();*/
  await Constant.setSystemVariables("main");
  await Constant.setCustomerTabDisplay();
  await Constant.setHomeTabsToDisplay();





  //await  AppDatabase.get().createLookupInsert();



  // await requestPermission();
  //ends


  runApp(new HotRestartController(
      child: new MyApp()
  ));
}







class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecificLocalizationDelegate _localeOverrideDelegate;

  static Timer _sessionTimer;
  SharedPreferences prefs;
 static BuildContext thisContext;
  @override
  void initState() {
    super.initState();
    thisContext=context;
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);

    ///
    /// Let's save a pointer to this method, should the user wants to change its language
    /// We would then call: applic.onLocaleChanged(new Locale('en',''));
    ///
    applic.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  void navigateUser() async {
    HotRestartController.performHotRestart(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Listener(onPointerMove: (opm) async{
      sessionTimeOut=new SessionTimeOut(context: context);
      sessionTimeOut.SessionTimedOut();
          //startTimeout([int milliseconds]) { return new Timer.periodic(Duration(seconds: 10), () => logOutUser); }
    // },
        },
        child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new LoginPage(null),
          //home: new LoginPage(),
          theme: ThemeData(
            buttonColor: Color(0xff07426A),
            bottomAppBarColor: Color(0xff07426A),
            tabBarTheme: TabBarTheme(indicator: new BubbleTabIndicator(
              indicatorHeight: 25.0,
              indicatorColor: Color(0xff12D6F4),
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
                labelColor: Colors.white
            ),
            backgroundColor: Color(0xffeeeeee),
          ),
          localizationsDelegates: [
            _localeOverrideDelegate,
            const TranslationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: applic.supportedLocales(),
          /*supportedLocales: [
        const Locale('en', ''),
        const Locale('hn', ''),
      ],*/
        )

    );

  }
  void logOutUser() {
    navigateUser();
  }
/*

class LookUpDescriptionValueObj{

  String mcodedesc;
  String extraField;




  LookUpDescriptionValueObj({this.mcodedesc, this.extraField});

  factory LookUpDescriptionValueObj.fromJson(Map<String, dynamic> json) {
    return LookUpDescriptionValueObj(
      mcodedesc: json[TablesColumnFile.mcodedesc] as String,
      extraField: json[TablesColumnFile.mfield1value] as String,

    );
  }

}
*/
}
  class LastSyncedDateTime{

  int id;
  String tTabelDesc;
  DateTime tlastSyncedFromTab;
  DateTime tlastSyncedToTab;

  LastSyncedDateTime({this.id, this.tTabelDesc,this.tlastSyncedFromTab,this.tlastSyncedToTab});

  factory LastSyncedDateTime.fromJson(Map<String, dynamic> json) {
  return LastSyncedDateTime(
  id: json[TablesColumnFile.id] as int,
  tTabelDesc: json[TablesColumnFile.tTabelDesc] as String,
  tlastSyncedFromTab:  (json[TablesColumnFile.tlastSyncedFromTab]=="null"||json[TablesColumnFile.tlastSyncedFromTab]==null)?null:DateTime.parse(json[TablesColumnFile.tlastSyncedFromTab]) as DateTime,
  tlastSyncedToTab:  (json[TablesColumnFile.tlastSyncedToTab]=="null"||json[TablesColumnFile.tlastSyncedToTab]==null)?null:DateTime.parse(json[TablesColumnFile.tlastSyncedToTab]) as DateTime

  );
  }
  }


  class HotRestartController extends StatefulWidget {
  final Widget child;

  HotRestartController({this.child});

  static performHotRestart(BuildContext context) {
    //print("context"+context.toString());
    try{
  final _HotRestartControllerState state = context.ancestorStateOfType(const TypeMatcher<_HotRestartControllerState>());
  state.performHotRestart();}
  catch(_){
  }
  }

  @override
  _HotRestartControllerState createState() => new _HotRestartControllerState();
  }

  class _HotRestartControllerState extends State<HotRestartController> {
  Key key = new UniqueKey();

  void performHotRestart() {
  this.setState(() {
  key = new UniqueKey();
  });
  }

  @override
  Widget build(BuildContext context) {
  return new Container(
  key: key,
  child: widget.child,
  );
  }
  }