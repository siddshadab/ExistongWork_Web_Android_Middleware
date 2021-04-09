import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';
import 'package:eco_mfi/pages/todo/home/LeadDeletion.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Login.dart';
import 'package:eco_mfi/pages/reports/ConfiguredReportsList.dart';
import 'package:eco_mfi/pages/workflow/PassChangeModule/ChangePassword.dart';
import 'package:eco_mfi/pages/workflow/tablesDisplay/DisplayTablesSearchByQuery.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/DeviceSetting.dart';
import 'package:eco_mfi/models/Label.dart';
import 'package:eco_mfi/models/Project.dart';
import 'package:eco_mfi/pages/todo/about/about_us.dart';
import 'package:eco_mfi/pages/todo/labels/add_label.dart';
import 'package:eco_mfi/pages/todo/projects/add_project.dart';
import 'package:eco_mfi/models/Tasks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';


class SideDrawer extends StatefulWidget {
  ProjectSelection projectSelection;
  LabelSelection labelSelection;
  DateSelection dateSelection;

  SideDrawer({this.projectSelection, this.labelSelection, this.dateSelection});

  @override
  _SideDrawerState createState() =>
      new _SideDrawerState(projectSelection, labelSelection, dateSelection);
}

class _SideDrawerState extends State<SideDrawer> {
  final List<Project> projectList = new List();
  final List<Label> labelList = new List();
  ProjectSelection projectSelectionListener;
  LabelSelection labelSelectionListener;
  DateSelection dateSelectionListener;
    String profileimage="";
  String userName = "";
  String role = "";
  String loginTime = "";
  String primryDisp="";
  var formatter = new DateFormat('dd/MM/yyyy');
  static const JsonCodec JSON = const JsonCodec();

  _SideDrawerState(this.projectSelectionListener, this.labelSelectionListener,
      this.dateSelectionListener);
   DateTime operationDate;

  Uint8List imageBytes;


  @override
  void initState() {
    super.initState();
    updateProjects();
    updateLabels();
    getSessionVariables();
  }



  Future<void> _PickImage() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title:new Text(Translations.of(context).text("Choose Image From"),style:TextStyle(fontWeight:FontWeight.bold)  ,),
              content:new SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child:new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly
                      ,children: <Widget>[

                      new GestureDetector(
                        child: new Image(
                          image: new AssetImage("assets/galleries.png"),
                          alignment: Alignment.center,
                          height: 100.0,
                          width: 100.5,
                        ),

                        onTap:(){
                          Navigator.of(context).pop();
                          getImageFromGallery();

                        } ,

                      ),

                      SizedBox(width: 10.0,),
                      GestureDetector(
                        child: new ClipRect(

                          child: new Image(
                            image: new AssetImage("assets/cameras.png"),
                            alignment: Alignment.center,
                            height: 100.0,
                            width: 100.5,
                          ),
                        ),

                        onTap: (){
                          Navigator.of(context).pop();
                          getImage();

                        },
                      ),
                      SizedBox(width: 10.0,),
                    ],

                    )


                  ],
                ) ,
              )

          );
        });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery);

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      //ratioX: 3.2,
      //ratioY: 3.2,
      maxWidth: 640,
      maxHeight: 640,
    );
    imageBytes  = await croppedFile.readAsBytes();
    //TODO Update offline image
    //TODO Check if offline or online
    try {
      await updateImageOnlineAndOffline(imageBytes);
    }catch(_){}
    setState(() {

    });
  }

  Future getImage() async {

    var image = await ImagePicker.pickImage(

        source: ImageSource.camera);

    print("Variable image hai  ${image}" );

    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 640,
      maxHeight: 640,
    );
    imageBytes  = await croppedFile.readAsBytes();
    //TODO Update offline image
    //TODO Check if offline or online
    try {
      await updateImageOnlineAndOffline(imageBytes);
    }catch(_){}
    setState(() {

    });


  }


  void updateProjects() {
    AppDatabase.get().getProjects(isInboxVisible: false).then((projects) {
      if (projects != null) {
        setState(() {
          projectList.clear();
          projectList.addAll(projects);
        });
      }
    });
  }

  void updateLabels() {
    AppDatabase.get().getLabels().then((projects) {
      if (projects != null) {
        setState(() {
          labelList.clear();
          labelList.addAll(projects);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            decoration: new BoxDecoration(
              color: Color(0xff07426A),
            ),
           accountName: new Text("Branch Op Dt  ${operationDate==null?"":formatter.format(operationDate)}"),
            accountEmail: new Text(
              "Login Time : ".toString() + loginTime.toString(),
              overflow: TextOverflow.fade,
            ),
            otherAccountsPictures: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 36.0,
                  ),
                   onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                    Navigator.push(
                      context,
                      new MaterialPageRoute<bool>(
                          builder: (context) => new AboutUsScreen()),
                    );
                  })
            ],
            currentAccountPicture: GestureDetector(
              onTap: () async{
               await  _PickImage();
              },
                child: new CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: MemoryImage(imageBytes),
            ),)
          ),
          new ListTile(
              leading: new Icon(Icons.inbox),
              title: new Text("Inbox"),
              onTap: () {
                if (projectSelectionListener != null) {
                  var project = Project.getInbox();
                  projectSelectionListener(project);
                  Navigator.pop(context);
                }
              }),

          new ListTile(
              onTap: () {
                var dateTime = new DateTime.now();
                var taskStartTime =
                    new DateTime(dateTime.year, dateTime.month, dateTime.day)
                        .millisecondsSinceEpoch;
                var taskEndTime = new DateTime(
                    dateTime.year, dateTime.month, dateTime.day, 23, 59)
                    .millisecondsSinceEpoch;

                if (dateSelectionListener != null) {
                  dateSelectionListener(taskStartTime, taskEndTime);
                }
                Navigator.pop(context);
              },
              leading: new Icon(Icons.calendar_today),
              title: new Text("Today")),
          new ListTile(
            onTap: () {
              var dateTime = new DateTime.now();
              var taskStartTime =
                  new DateTime(dateTime.year, dateTime.month, dateTime.day)
                      .millisecondsSinceEpoch;
              var taskEndTime = new DateTime(
                  dateTime.year, dateTime.month, dateTime.day + 7, 23, 59)
                  .millisecondsSinceEpoch;

              if (dateSelectionListener != null) {
                dateSelectionListener(taskStartTime, taskEndTime);
              }
              Navigator.pop(context);
            },
            leading: new Icon(Icons.calendar_today),
            title: new Text("Next 7 Days"),
          ),
          buildExpansionTile(Icons.book, "Projects"),
          buildExpansionTile(Icons.label, "Labels"),
          new ExpansionTile(
            leading: new Icon(
              Icons.delete,
              color: Colors.black,
            ),
            title: new Text("Clear Data"),
            children: <Widget>[
              new ListTile(
                  leading: new Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  title: new Text("Clear Offline Data"),
                  onTap: () async {
                    await _FlushDataBase();
                  }),
              new ListTile(
                  leading: new Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  title: new Text("Clear Prospect Offline Data"),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int prospectValidityDays = 0;
                    try {
                      prospectValidityDays =
                          prefs.get(TablesColumnFile.musrcode);
                    } catch (_) {}
                    if (prospectValidityDays == 0 ||
                        prospectValidityDays == null) prospectValidityDays = 90;

                    await _FlushProspectData(prospectValidityDays);
                  }),
              new ListTile(
                  leading: new Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  title: new Text("Clear Lead Data"),
                  onTap: () async {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                          new LeadDeletion()), //When Authorized Navigate to the next screen
                    );
                  }),

            ],
          ),
          new ListTile(
              leading: new Icon(Icons.settings_bluetooth),
              title: new Text("Bluetooth Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new DeviceSetting()), //When Authorized Navigate to the next screen
                );
              }),
          new ListTile(
              leading: new Icon(Icons.verified_user),
              title: new Text("Change Password & Agent Biometric"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new ChangePassword("SideDrawer")), //When Authorized Navigate to the next screen
                );
                 
              }),
              new ListTile(
              leading: new Icon(Icons.table_chart),
              title: new Text("Display Tables"),
              onTap: () {
                Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                    new DisplayTablesSearchByQuery()), //When Authorized Navigate to the next screen
                );
              }),
          new ListTile(
              leading: new Icon(Icons.note),
              title: new Text("Reports List"),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                      new ConfiguredReportsList()), //When Authorized Navigate to the next screen
                );
              }),
        ],
      ),
    );
  }

  ExpansionTile buildExpansionTile(IconData icon, String projectName) {
    return new ExpansionTile(
      leading: new Icon(icon),
      title: new Text(projectName,
          style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
      children: projectName == "Projects" ? buildProjects() : buildLabels(),
    );
  }

  List<Widget> buildProjects() {
    List<Widget> projectWidgetList = new List();
    projectList.forEach((project) =>
        projectWidgetList.add(new ProjectRow(
          project,
          projectSelection: (selectedProject) {
            projectSelectionListener(selectedProject);
            Navigator.pop(context);
          },
        )));
    projectWidgetList.add(new ListTile(
      leading: new Icon(Icons.add),
      title: new Text("Add Project"),
      onTap: () async {
        sessionTimeOut=new SessionTimeOut(context: context);
      sessionTimeOut.SessionTimedOut();;
        Navigator.pop(context);
        bool isDataChanged = await Navigator.push(
            context,
            new MaterialPageRoute<bool>(
                builder: (context) => new AddProject()));

        if (isDataChanged) {
          updateProjects();
        }
      },
    ));
    return projectWidgetList;
  }

  List<Widget> buildLabels() {
    List<Widget> projectWidgetList = new List();
    labelList.forEach((label) =>
        projectWidgetList.add(new LabelRow(label, labelSelection: (label) {
          labelSelectionListener(label);
          Navigator.pop(context);
        })));
    projectWidgetList.add(new ListTile(
        leading: new Icon(Icons.add),
        title: new Text("Add Label"),
        onTap: () async {
          sessionTimeOut=new SessionTimeOut(context: context);
      sessionTimeOut.SessionTimedOut();;
          Navigator.pop(context);
          bool isDataChanged = await Navigator.push(
              context,
              new MaterialPageRoute<bool>(
                  builder: (context) => new AddLabel()));

          if (isDataChanged) {
            updateLabels();
          }
        }));
    return projectWidgetList;
  }

  void getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.get(TablesColumnFile.musrcode);
    //role = prefs.getString(TablesColumnFile.musrdesignation);
    role = prefs.getString(TablesColumnFile.usrDesignation);
    loginTime = prefs.get(TablesColumnFile.LoginTime);
    try{

        operationDate = DateTime.parse(prefs.getString(TablesColumnFile.branchOperationalDate));

    }catch(_){

      try{
        profileimage= prefs.get(TablesColumnFile.profileimage);
        imageBytes = base64Decode(profileimage!=null?profileimage:"iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAYAAABccqhmAAAACXBIWXMAAAsTAAALEwEAmpwYAABCQWlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMwMTQgNzkuMTU2Nzk3LCAyMDE0LzA4LzIwLTA5OjUzOjAyICAgICAgICAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIKICAgICAgICAgICAgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iCiAgICAgICAgICAgIHhtbG5zOnN0RXZ0PSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VFdmVudCMiCiAgICAgICAgICAgIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIgogICAgICAgICAgICB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iCiAgICAgICAgICAgIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIgogICAgICAgICAgICB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4aWYvMS4wLyI+CiAgICAgICAgIDx4bXA6Q3JlYXRlRGF0ZT4yMDE1LTEyLTA0VDIxOjAyOjU2WjwveG1wOkNyZWF0ZURhdGU+CiAgICAgICAgIDx4bXA6TW9kaWZ5RGF0ZT4yMDE1LTEyLTA1VDAzOjIyOjU2KzA1OjMwPC94bXA6TW9kaWZ5RGF0ZT4KICAgICAgICAgPHhtcDpNZXRhZGF0YURhdGU+MjAxNS0xMi0wNVQwMzoyMjo1NiswNTozMDwveG1wOk1ldGFkYXRhRGF0ZT4KICAgICAgICAgPHhtcDpDcmVhdG9yVG9vbD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNCAoTWFjaW50b3NoKTwveG1wOkNyZWF0b3JUb29sPgogICAgICAgICA8ZGM6Zm9ybWF0PmltYWdlL3BuZzwvZGM6Zm9ybWF0PgogICAgICAgICA8eG1wTU06SGlzdG9yeT4KICAgICAgICAgICAgPHJkZjpTZXE+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNvbnZlcnRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5mcm9tIGltYWdlL3BuZyB0byBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wPC9zdEV2dDpwYXJhbWV0ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpFM0Y5M0QxRTBDMjA2ODExODIyQTg0QUVFNTNGQkEwQzwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNS0xMi0wNVQwMzowODo0NiswNTozMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNvbnZlcnRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5mcm9tIGltYWdlL3BuZyB0byBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wPC9zdEV2dDpwYXJhbWV0ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+c2F2ZWQ8L3N0RXZ0OmFjdGlvbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0Omluc3RhbmNlSUQ+eG1wLmlpZDpFNEY5M0QxRTBDMjA2ODExODIyQTg0QUVFNTNGQkEwQzwvc3RFdnQ6aW5zdGFuY2VJRD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OndoZW4+MjAxNS0xMi0wNVQwMzowODo0NiswNTozMDwvc3RFdnQ6d2hlbj4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6MWJmOGMzNDAtMDExMi00YTZlLWExYTAtNjIwYTRkOTQxNTg5PC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE1LTEyLTA1VDAzOjIyOjU2KzA1OjMwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNCAoTWFjaW50b3NoKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPmNvbnZlcnRlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5mcm9tIGFwcGxpY2F0aW9uL3ZuZC5hZG9iZS5waG90b3Nob3AgdG8gaW1hZ2UvcG5nPC9zdEV2dDpwYXJhbWV0ZXJzPgogICAgICAgICAgICAgICA8L3JkZjpsaT4KICAgICAgICAgICAgICAgPHJkZjpsaSByZGY6cGFyc2VUeXBlPSJSZXNvdXJjZSI+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDphY3Rpb24+ZGVyaXZlZDwvc3RFdnQ6YWN0aW9uPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6cGFyYW1ldGVycz5jb252ZXJ0ZWQgZnJvbSBhcHBsaWNhdGlvbi92bmQuYWRvYmUucGhvdG9zaG9wIHRvIGltYWdlL3BuZzwvc3RFdnQ6cGFyYW1ldGVycz4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgICAgIDxyZGY6bGkgcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6YWN0aW9uPnNhdmVkPC9zdEV2dDphY3Rpb24+CiAgICAgICAgICAgICAgICAgIDxzdEV2dDppbnN0YW5jZUlEPnhtcC5paWQ6Mzk2ZmIyZDItNzMyYi00YTBhLTljYTctOGE2ZmIyMDg5YmViPC9zdEV2dDppbnN0YW5jZUlEPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6d2hlbj4yMDE1LTEyLTA1VDAzOjIyOjU2KzA1OjMwPC9zdEV2dDp3aGVuPgogICAgICAgICAgICAgICAgICA8c3RFdnQ6c29mdHdhcmVBZ2VudD5BZG9iZSBQaG90b3Nob3AgQ0MgMjAxNCAoTWFjaW50b3NoKTwvc3RFdnQ6c29mdHdhcmVBZ2VudD4KICAgICAgICAgICAgICAgICAgPHN0RXZ0OmNoYW5nZWQ+Lzwvc3RFdnQ6Y2hhbmdlZD4KICAgICAgICAgICAgICAgPC9yZGY6bGk+CiAgICAgICAgICAgIDwvcmRmOlNlcT4KICAgICAgICAgPC94bXBNTTpIaXN0b3J5PgogICAgICAgICA8eG1wTU06RGVyaXZlZEZyb20gcmRmOnBhcnNlVHlwZT0iUmVzb3VyY2UiPgogICAgICAgICAgICA8c3RSZWY6aW5zdGFuY2VJRD54bXAuaWlkOjFiZjhjMzQwLTAxMTItNGE2ZS1hMWEwLTYyMGE0ZDk0MTU4OTwvc3RSZWY6aW5zdGFuY2VJRD4KICAgICAgICAgICAgPHN0UmVmOmRvY3VtZW50SUQ+eG1wLmRpZDpFM0Y5M0QxRTBDMjA2ODExODIyQTg0QUVFNTNGQkEwQzwvc3RSZWY6ZG9jdW1lbnRJRD4KICAgICAgICAgICAgPHN0UmVmOm9yaWdpbmFsRG9jdW1lbnRJRD54bXAuZGlkOkUzRjkzRDFFMEMyMDY4MTE4MjJBODRBRUU1M0ZCQTBDPC9zdFJlZjpvcmlnaW5hbERvY3VtZW50SUQ+CiAgICAgICAgIDwveG1wTU06RGVyaXZlZEZyb20+CiAgICAgICAgIDx4bXBNTTpEb2N1bWVudElEPmFkb2JlOmRvY2lkOnBob3Rvc2hvcDpmNzZlMDBiNi1kYWMwLTExNzgtOGNhNy1hYmZlM2EyY2MzZDY8L3htcE1NOkRvY3VtZW50SUQ+CiAgICAgICAgIDx4bXBNTTpJbnN0YW5jZUlEPnhtcC5paWQ6Mzk2ZmIyZDItNzMyYi00YTBhLTljYTctOGE2ZmIyMDg5YmViPC94bXBNTTpJbnN0YW5jZUlEPgogICAgICAgICA8eG1wTU06T3JpZ2luYWxEb2N1bWVudElEPnhtcC5kaWQ6RTNGOTNEMUUwQzIwNjgxMTgyMkE4NEFFRTUzRkJBMEM8L3htcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD4KICAgICAgICAgPHBob3Rvc2hvcDpDb2xvck1vZGU+MzwvcGhvdG9zaG9wOkNvbG9yTW9kZT4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPHRpZmY6WFJlc29sdXRpb24+NzIwMDAwLzEwMDAwPC90aWZmOlhSZXNvbHV0aW9uPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj43MjAwMDAvMTAwMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+NjU1MzU8L2V4aWY6Q29sb3JTcGFjZT4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjI1NjwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4yNTY8L2V4aWY6UGl4ZWxZRGltZW5zaW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAKPD94cGFja2V0IGVuZD0idyI/Pqyx0F0AAAAgY0hSTQAAeiUAAICDAAD5/wAAgOkAAHUwAADqYAAAOpgAABdvkl/FRgAAG5ZJREFUeNrsnXt4FOWhxn+bbG4EErnkxiVA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");
      }catch(_){}


    }
    print("xxxxxxxxxxxxxxloginBean.role.toString() ${role.toString()}");
    primryDisp = "User ID ";
    primryDisp = "${primryDisp }" "${userName!=null && userName!='null' && userName!=""?userName :''}";
    primryDisp = "${primryDisp }" " And role ";
    primryDisp = "${primryDisp }" "${ role!=null && role!='null' && role!=""?role :''}";

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
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _FlushProspectData(int prospectValidityDays) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure you want to delete Prospect before ${formatter.format(DateTime.now().subtract(Duration(days: prospectValidityDays)))} Items')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                _ShowProgressInd(context);
                int ap = await AppDatabaseExtended.get().deleteProspectData(
                    DateTime.now()
                        .subtract(Duration(days: prospectValidityDays)));
                if (ap != null && ap != 0) {
                  success(
                      'All Prospect ${ap} Records have been deleted', context);
                } else {
                  success('All Prospect Records have been deleted', context);
                }
              },
            ),
            FlatButton(
              child: Text(
                'Cancel',
              ),
              onPressed: () {
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
                onPressed: () {
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




  _deleteAllRecordsInTables() async{
    _ShowProgressInd(context);
    List<String> deleteQuery = new List<String>();
    deleteQuery.add('DELETE FROM ${Tasks.tblTask};');
    deleteQuery.add('DELETE FROM ${Project.tblProject};');
    //deleteQuery.add('DELETE FROM ${TaskLabels.tblTaskLabel};');
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
    deleteQuery.add('DELETE FROM ${AppDatabase.customerFingerPrintMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.internalBankTransferMaster};');
    deleteQuery.add('DELETE FROM ${AppDatabase.userVaultBalance};');



    await AppDatabase.get().deleteQuery(deleteQuery);

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

  updateImageOnlineAndOffline(Uint8List imageBytes) async{

    Utility obj = new Utility();
    final _headers = {'Content-Type': 'application/json'};
    var userDetailsMaster = "userDetailsMaster/updateProfileImage/";


    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userName = prefs.get(TablesColumnFile.musrcode);

      String json = _toJson(imageBytes,userName);
      String bodyValue = await NetworkUtil.callPostService(
          json.toString(),
          Constant.apiURL.toString() + userDetailsMaster.toString(),
          _headers);
      if (bodyValue == "404") {
        return null;
      }
    }catch(_){}

    return json;
  }



  String _toJson(Uint8List imageBytes,String userCode) {
    var mapData = new Map();


    String base64Image = base64.encode(imageBytes);
    mapData[TablesColumnFile.musrcode] = userCode;
    mapData[TablesColumnFile.profileimage] = base64Image;
    print(mapData);
    String json = JSON.encode(mapData);
    return json;
  }


}

class ProjectRow extends StatelessWidget {
  final Project project;
  final ProjectSelection projectSelection;

  ProjectRow(this.project, {this.projectSelection});

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        if (projectSelection != null) {
          projectSelection(project);
        }
      },
      leading: new Container(
        width: 24.0,
        height: 24.0,
      ),
      title: new Text(project.name),
      trailing: new Container(
        height: 10.0,
        width: 10.0,
        child: new CircleAvatar(
          backgroundColor: new Color(project.colorValue),
        ),
      ),
    );
  }
}

class LabelRow extends StatelessWidget {
  final Label label;
  final LabelSelection labelSelection;

  LabelRow(this.label, {this.labelSelection});

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        if (labelSelection != null) {
          labelSelection(label);
        }
      },
      leading: new Container(
        width: 24.0,
        height: 24.0,
      ),
      title: new Text("@ ${label.name}"),
      trailing: new Container(
        height: 10.0,
        width: 10.0,
        child: new Icon(
          Icons.label,
          size: 16.0,
          color: new Color(label.colorValue),
        ),
      ),
    );
  }

}

typedef void ProjectSelection(Project project);
typedef void LabelSelection(Label label);
typedef void DateSelection(int startDate, int endDate);
