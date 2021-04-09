import 'package:eco_mfi/Maps/MainMap.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/models/TaskLabels.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/pages/timelines/Demo/AttendanceDashBoard.dart';
import 'package:eco_mfi/pages/timelines/ManagmentDashBoard.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/TabsDisplayBean.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/Timelines_Dashboard.dart';
import 'package:eco_mfi/pages/workflow/Workflow_Grid_Dashboard.dart';
import 'package:eco_mfi/pages/timelines/DemoTimeLinesDashBoard.dart';

import 'package:eco_mfi/pages/todo/home/HomeScreenTodo.dart';
import 'package:eco_mfi/pages/todo/home/side_drawer.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/models/Label.dart';
import 'package:eco_mfi/models/Project.dart';
import 'package:eco_mfi/models/Tasks.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Login.dart';
import '../../translations.dart';

class HomeDashboard extends StatefulWidget {


  HomeDashboard();

  @override
  HomeDashboardState createState() => new HomeDashboardState();
}

class HomeDashboardState extends State<HomeDashboard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tasks> taskList = new List();
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  String homeTitle = "Today";
  int taskStartTime, taskEndTime;
  Utility obj = new Utility();
  bool isNetworkAvailable=false;
  String companyName = "";
  bool circInd = false;
  List<TabsDisplayBean> tabDisplayWid =[ ];
  List<Widget> tabWidget =[ ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int index = 0;

    if (Constant.isGraphTabShow) {
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Graph and Report';
      tabean.tabWidget = new ManagmentDashBoard();
      tabean.tabPosition = tabDisplayWid.length + 1;
      tabean.tabIcon = new Tab(
          //text: "Stat TimeLine",
          icon: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        child: new Icon(
          Icons.timeline,
          color: globals.appbaricon ?? Colors.white,
          size: 22.0,
        ),
      ));
      tabDisplayWid.add(tabean);
      tabWidget.add(new ManagmentDashBoard());
    }

    if (Constant.isDashBoardTabShow) {
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Dash Board';
      tabean.tabWidget = new WorkFlowGrid();
      tabean.tabPosition = tabDisplayWid.length + 1;
      index = tabDisplayWid.length;
      tabean.tabIcon = new Tab(
          //text: "Stat TimeLine",
          icon: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        child: new Icon(
          Icons.work,
          color: globals.appbaricon ?? Colors.white,
          size: 22.0,
        ),
      ));
      tabDisplayWid.add(tabean);
      tabWidget.add(new WorkFlowGrid());
    }

    if (Constant.isMapTabShow) {
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'Maps';
      tabean.tabWidget = MainMap();
      tabean.tabPosition = tabDisplayWid.length + 1;
      tabean.tabIcon = new Tab(
          //text: "Stat TimeLine",

          icon: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
        child: new Icon(
          Icons.map,
          color: globals.appbaricon ?? Colors.white,
          size: 22.0,
        ),
      ));
      tabDisplayWid.add(tabean);

      tabWidget.add(MainMap());
    }

    if (Constant.isToDoTabShow) {
      TabsDisplayBean tabean = new TabsDisplayBean();
      tabean.tabName = 'TO DO';
      tabean.tabWidget = new HomeScreenTodo();
      tabean.tabPosition = tabDisplayWid.length + 1;
      tabean.tabIcon = new Tab(
          //text: "Stat TimeLine",

          icon: Padding(
        padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
        child: new Icon(
          Icons.alarm,
          color: globals.appbaricon ?? Colors.white,
          size: 22.0,
        ),
      ));
      tabDisplayWid.add(tabean);
      tabWidget.add(new HomeScreenTodo());
    }

    TabsDisplayBean tabean = new TabsDisplayBean();
    tabean.tabName = 'Maps';
    tabean.tabWidget = AttendanceDashBoard();
    tabean.tabPosition = tabDisplayWid.length + 1;
    tabean.tabIcon = new Tab(
        //text: "Stat TimeLine",

        icon: Padding(
      padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      child: new Icon(
        Icons.accessibility,
        color: globals.appbaricon ?? Colors.white,
        size: 22.0,
      ),
    ));
    tabDisplayWid.add(tabean);

    tabWidget.add(AttendanceDashBoard());

    checkIfNetwrkAval();
    _tabController = new TabController(
        vsync: this, initialIndex: index, length: tabDisplayWid.length);
    var dateTime = new DateTime.now();
    taskStartTime = new DateTime(dateTime.year, dateTime.month, dateTime.day)
        .millisecondsSinceEpoch;
    taskEndTime =
        new DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59)
            .millisecondsSinceEpoch;
    updateTasks(taskStartTime, taskEndTime);
    getsharedPreferences();
  }

  getsharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString(TablesColumnFile.mCompanyName) != null &&
          prefs.getString(TablesColumnFile.mCompanyName).trim() != "")
        companyName = prefs.getString(TablesColumnFile.mCompanyName);
    });
  }

  checkIfNetwrkAval() async {
    //isNetworkAvailable = await obj.checkIntCon();
    isNetworkAvailable = await Utility.checkIntCon();
    print("isNetworkAvailable " + isNetworkAvailable.toString());
    setState(() {});
  }

  void updateTasks(int taskStartTime, int taskEndTime) {
    AppDatabase.get()
        .getTasks(
            startDate: taskStartTime,
            endDate: taskEndTime,
            taskStatus: TaskStatus.PENDING)
        .then((tasks) {
      if (tasks == null) return;
      taskList.clear();
      taskList.addAll(tasks);
      /* setState(() {
        taskList.clear();
        taskList.addAll(tasks);
      });*/
    });
  }

  void updateTasksByProject(Project project) {
    AppDatabase.get().getTasksByProject(project.id).then((tasks) {
      if (tasks == null) return;
      setState(() {
        homeTitle = project.name;
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  void updateTasksByLabel(Label label) {
    AppDatabase.get().getTasksByLabel(label.name).then((tasks) {
      if (tasks == null) return;
      setState(() {
        homeTitle = label.name;
        taskList.clear();
        taskList.addAll(tasks);
      });
    });
  }

  Future<bool> callDialog() {
    globals.Dialog.onWillPop(
        context, 'Are you sure?', 'Do you want to exit an App', 'Login');
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: callDialog,
      child: new Scaffold(
        key: _scaffoldHomeState,
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.view_headline,
                color: globals.appbaricon ?? Colors.white),
            onPressed: () => _scaffoldHomeState.currentState.openDrawer(),
          ),
          title: new Text(
            companyName,
            //'Saija Finance',
            style: new TextStyle(
                color: globals.appbartext ?? Colors.white, fontSize: 22.0),
          ),
          backgroundColor: globals.appbar ?? Color(0xff07426A),
          brightness: Brightness.light,
          elevation: 1.0,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30.0),
              child: new Container(
                child: new TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.black,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: new List.generate(tabDisplayWid.length, (index) {
                    return tabDisplayWid[index].tabIcon;

                    new Tab(text: tabDisplayWid[index].tabName.toUpperCase());
                  }),
                ),
                //color: Colors.white,
              )),

//          bottom: PreferredSize(
//            preferredSize: const Size.fromHeight(30.0),
//            child: new Container(
//              //color: Colors.white,
//              child: new TabBar(
//                controller: _tabController,
//                indicatorColor: Colors.black,
//                tabs: <Widget>[
//                  new Tab(
//                      //text: "Stat TimeLine",
//                      icon: new Icon(
//                    Icons.timeline,
//                    color: Colors.white,
//                    size: 22.0,
//                  )),
//                  new Tab(
//                    icon: new Icon(
//                      Icons.work,
//                      color: Colors.white,
//                      size: 22.0,
//                    ),
//                    //text: "Workflow",
//                  ),
//                  new Tab(
//                    icon: new Icon(
//                      Icons.map,
//                      color: Colors.white,
//                      size: 22.0,
//                    ),
//                    //text: "To-Do",
//                  ),
//                  new Tab(
//                    icon: new Icon(
//                      Icons.access_alarm,
//                      color: Colors.white,
//                      size: 22.0,
//                    ),
//                    //text: "To-Do",
//                  ),
//                ],
//              ),
//            ),
//          ),
          actions: <Widget>[
            isNetworkAvailable
                ? new Icon(
                    Icons.network_cell,
                    color: Colors.green,
                  )
                : new Icon(
                    Icons.network_locked,
                    color: Colors.red,
                  ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
            ),
            new Icon(
              Icons.notifications_none,
              color: globals.appbaricon ?? Colors.white,
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
            ),
            // IconButton(icon: Icon(
            //   Icons.delete,
            //   color: Colors.white,),
            //   onPressed: () async{
            //     await _FlushDataBase();

            // },),
            // new Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 6.0),
            // )
          ],
        ),
        body: new TabBarView(
          controller: _tabController,
          children: tabWidget,
        ),
        backgroundColor: Color(0xffeeeeee),
        drawer: new SideDrawer(
          projectSelection: (project) {
            updateTasksByProject(project);
          },
          labelSelection: (label) {
            updateTasksByLabel(label);
          },
          dateSelection: (startTime, endTime) {
            var dayInMillis = 86340000;
            homeTitle =
                endTime - startTime > dayInMillis ? "Next 7 Days" : "Today";
            taskStartTime = startTime;
            taskEndTime = endTime;
            updateTasks(startTime, endTime);
          },
        ),
      ),
    );
  }



  _deleteAllRecordsInTables() async{
    circInd = true;
    _ShowProgressInd(context);
    List<String> deleteQuery = new List<String>();
    deleteQuery.add('DELETE FROM ${Tasks.tblTask};');
    deleteQuery.add('DELETE FROM ${Project.tblProject};');
    deleteQuery.add('DELETE FROM ${TaskLabels.tblTaskLabel};');
    deleteQuery.add('DELETE FROM ${Label.tblLabel};');
   // deleteQuery.add('DELETE FROM ${AppDatabase.userMasterTable};');
    deleteQuery.add('DELETE FROM ${AppDatabase.creditBereauMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.creditBereauResultMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.creditBereauLoanDetailsMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.groupFoundationMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.centerDetailsMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.imageMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.LookupMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.SystemParameterMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.InterestSlabMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.InterestOffsetMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.LoanCycleParameterPrimaryMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.LoanCycleParameterSecondaryMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.SubLookupMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.lastSyncedDateTimeMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.customerFoundationFamilyMasterDetails};');
    deleteQuery.add('DELETE FROM ${AppDatabase.customerFoundationBorrowingMasterDetails};');
    deleteQuery.add('DELETE FROM ${AppDatabase.customerFoundationMasterDetails};');
    deleteQuery.add('DELETE FROM ${AppDatabase.customerFoundationAddressMasterDetails};');
    deleteQuery.add('DELETE FROM ${AppDatabase.productMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.purposeMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.transactionModeMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.repaymentFrequencyMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.customerLoanDetailsMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.loanUtilizationMaster};');
    //deleteQuery.add('DELETE FROM ${AppDatabase.settingsMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.savingsMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.disbursmentMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.miniStatementMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.savingsCollectionMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.gaurantorMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.PPIMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.customerNOCImageMaster};');
    //deleteQuery.add('DELETE FROM ${AppDatabase.checkListMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.cgt1QaMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.cgt2QaMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.grtQaMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.CGT1Master};');
    deleteQuery.add('DELETE FROM ${AppDatabase.CGT2Master};');
    deleteQuery.add('DELETE FROM ${AppDatabase.GRTMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.speedoMeterMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.countryMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.stateMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.districtMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.subDistrictMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.areaMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.businessExpenseMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.houseExpenseMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.assetDetailMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.collectionMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.collectedLoansAmtMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.loanApprovalLimitMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.branchMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.CHARTMASTER}};');
    deleteQuery.add('DELETE FROM ${AppDatabase.CHARTFILTERMASTER}};');
    deleteQuery.add('DELETE FROM ${AppDatabase.glAccountMaster}};');
    deleteQuery.add('DELETE FROM ${AppDatabase.tdParameterMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.MenuMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.UserRightsTable};');
    deleteQuery.add('DELETE FROM ${AppDatabase.customerCpvMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.loanLevelMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.socialEnvironmentMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.tradeNeighbourRefCheckMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.deviationFormMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.CosutomerLoanCashFlowMaster}};');
    deleteQuery.add('DELETE FROM ${AppDatabase.kycMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.LoanCPVBusinessRecord};');
    deleteQuery.add('DELETE FROM ${AppDatabase.customerLoanImageMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.disbursedMaster};');

    await AppDatabase.get().deleteQuery(deleteQuery);
  }

  Future<void> _FlushDataBase() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete all tablet Items')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async{

                await _deleteAllRecordsInTables();
                success(
                    'All Records have been deleted',
                    context);
              },
            ),
            FlatButton(
              child: Text(
                'Cancel',
              ),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  success(String message, BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(message)],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => LoginPage(null)), //When Authorized Navigate to the next screen
                  );
                },
              ),
            ],
          );
        });
  }


  Future<void> _ShowProgressInd(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translations.of(context).text('Please_Wait')),
          content: SingleChildScrollView(
              child: SpinKitCircle(color: Colors.teal)
          ),
        );
      },
    );
  }

}
