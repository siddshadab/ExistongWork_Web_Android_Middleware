import 'package:eco_mfi/Maps/UpdateCurrentLocationOfUser.dart';
import 'package:eco_mfi/pages/workflow/FPSPages/AgentBiometricCheck.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/PassChangeModule/ResetPasswordByAdmin.dart';
import 'package:eco_mfi/pages/workflow/Workflow_Grid_Dashboard.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationCenterAndGroupDetails.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/DeviceSetting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';

//import 'package:geo_location_finder/geo_location_finder.dart';
import 'package:eco_mfi/LoginBean.dart';
import 'package:eco_mfi/LoginServices.dart';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/initializer.dart';
import 'package:eco_mfi/application.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/CommonAppDataBase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/pages/home/Home_Dashboard.dart';
import 'dart:io';
import 'package:meta/meta.dart';
import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:eco_mfi/pages/workflow/PassChangeModule/ChangePassword.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Settings.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingActivityMenuList.dart';
import 'package:eco_mfi/translations.dart';
import 'package:toast/toast.dart';
import 'pincode/pincode_verify.dart';
import 'pincode/pincode_create.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/components.dart';
import 'Utilities/networt_util.dart';
import 'package:eco_mfi/Utilities/ThemeDesign.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  var settingsBean;

  LoginPage(this.settingsBean);

  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username;
  String _password;
  bool _usePinCode = false;
  bool isNetworkAvalable = false;
  LoginBean loginBeanGlobal = new LoginBean();
  static Utility obj = new Utility();

  bool autovalidate = false;

  static const platform = const MethodChannel('com.infrasofttech.eco_mfi');

  String LhThumbValue = "";
  String LhIndexFingerValue = "";
  String LhMiddleFingerValue = "";
  String LhRingFingerValue = "";
  String LhPinkyFingerValue = "";
  String RhThumbValue = "";
  String RhIndexFingerValue = "";
  String RhMiddleFingerValue = "";
  String RhRingFingerValue = "";
  String RhPinkyFingerValue = "";

  SharedPreferences prefs;
  String projectCd = "";
  LookupBeanData language;

  void _handleSubmitted() {

    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autovalidate = true; // Start validating on every change.
      showInSnackBar("Username/Password Required");
    } else {
      form.save();
      _performLogin();
    }
  }

  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();

    try {
      projectCd = prefs.getString(TablesColumnFile.PROJECTCODE);
    } catch (_) {}

    if (projectCd != null && projectCd != 'null') {
      applic.onLocaleChanged(new Locale('en${projectCd}', ''));
    } else {
      applic.onLocaleChanged(new Locale('en', ''));
    }
  }

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    getSessionVariables();

    if (settingsBean != null) {
      _username =
      settingsBean.musrcode != null && settingsBean.musrcode != "null"
          ? settingsBean.musrcode
          : "";
      _password =
      settingsBean.musrpass != null && settingsBean.musrpass != "null"
          ? settingsBean.musrpass
          : "";
    }

    _controller = new TextEditingController(text: 'Initial value');
  }

  showDropDown(LookupBeanData selectedObj, int no) {
    for (int k = 0; k < globals.dropDownLanguage[no].length; k++) {
      if (globals.dropDownLanguage[no][k].mcodedesc == selectedObj.mcodedesc) {
        setValue(no, globals.dropDownLanguage[no][k]);
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          language = value;
          print('${value.mcode}${projectCd}');

          try {
            applic
                .onLocaleChanged(new Locale('${value.mcode}${projectCd}', ''));
          } catch (_) {
            applic.onLocaleChanged(new Locale('en${projectCd}', ''));
          }
          //new Locale('${value.mcode}${projectCd}', '');
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.captionIdType[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(bean);
    for (int k = 0; k < globals.dropDownLanguage[no].length; k++) {
      mapData.add(globals.dropDownLanguage[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      //print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();
    /*   if(no==0){
      print(mapData);
      testString = mapData;
    }*/
    return _dropDownMenuItems1;
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<bool> _loginRequest(String username, String password) async {
    LoginBean loginBean = new LoginBean();
    bool isloginRetValue = false;
    // isNetworkAvalable = await checkIfIsconnectedToNetwork();
    isNetworkAvalable = await Utility.checkIntCon();
    loginBean.musrcode = username;
    loginBean.musrpass = password;
    if (!isNetworkAvalable) {
      try {
        print("network not available");

        await AppDatabase.get()
            .getLoginData(loginBean)
            .then((afterLogin) async {
          print("after login    ${afterLogin}");
          try {
            UserRightBean beanGet = new UserRightBean(
                mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
            await Constant.getAccessRights(beanGet);
          } catch (_) {
            print("Catch insiude");
          }
          if (afterLogin == null) {
            isloginRetValue = false;
            print("after login came null");
          } else if (afterLogin.musrcode.trim().toUpperCase() ==
              loginBean.musrcode.trim().toUpperCase() &&
              afterLogin.musrpass.trim().toUpperCase() ==
                  loginBean.musrpass.trim().toUpperCase() &&
              afterLogin.mnextpwdchgdt != null &&
              afterLogin.mnextpwdchgdt.isAfter(DateTime.now())) {
            try {
              UserRightBean beanGet = new UserRightBean(
                  mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
              await Constant.getAccessRights(beanGet);
            } catch (_) {
              print("Catch insiude");
            }
            _afterLogin(afterLogin);
            isloginRetValue = true;
            print("Valid Login!");

            setState(() {
              //callSystemLevelSyncingForFirstTime();
            });
            try {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            } catch (_) {
              print("Dusri bar ka scaffold fata");
            }
            await Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      new HomeDashboard()), //When Authorized Navigate to the next screen
            );
          } else if (afterLogin.musrcode.trim().toUpperCase() ==
              loginBean.musrcode.trim().toUpperCase() &&
              afterLogin.musrpass.trim().toUpperCase() ==
                  loginBean.musrpass.trim().toUpperCase() &&
              afterLogin.mnextpwdchgdt != null &&
              afterLogin.mnextpwdchgdt.isBefore(DateTime.now())) {
            try {
              UserRightBean beanGet = new UserRightBean(
                  mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
              await Constant.getAccessRights(beanGet);
            } catch (_) {
              print("Catch insiude");
            }

            print(" after Date");
            isloginRetValue = false;
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(
                TablesColumnFile.musrcode, loginBean.musrcode.toString());
            loginBeanGlobal.merrormessage = 'Password Expired';
            try {
              _scaffoldKey.currentState.hideCurrentSnackBar();
            } catch (_) {}
            Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new ChangePassword(
                      "login")), //When Authorized Navigate to the next screen
            );
          } else {
            print("inside else");
          }
        });
      } catch (error) {
        print("Ye catch fata");
        isloginRetValue = false;
      }
    } else if (isNetworkAvalable) {
      var loginServices = new LoginServices();
      //try {
      print("network is available");
      await loginServices.login(loginBean,context).then((value) async {
        loginBeanGlobal = value;
        //print("error is  ${value.merror}");
        if(value==null){
          try{
              _scaffoldKey.currentState.hideCurrentSnackBar();

          }catch(_){


          }
        }
        try {
          UserRightBean beanGet = new UserRightBean(
              mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
          await Constant.getAccessRights(beanGet);
        } catch (_) {
          print("Catch insiude");
        }

        if (value != null && value.merror == 50) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              TablesColumnFile.musrcode, loginBean.musrcode.toString());

          try {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          } catch (_) {
            print("3rd ctach fata");
          }
          print("error message ${value.merrormessage} ");
          await AppDatabase.get()
              .updateLoginColumn(value, username)
              .then((loginColumn) {
            print(loginColumn);
          });
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new ChangePassword(
                    "login")), //When Authorized Navigate to the next screen
          );
        } else if (value != null && value.merror == 0) {
          try {
            UserRightBean beanGet = new UserRightBean(
                mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
            await Constant.getAccessRights(beanGet);
          } catch (_) {
            print("Catch insiude");
          }

          _afterLogin(value);
          SyncingActivityState obj = SyncingActivityState();
          print("updating  login column");
          await AppDatabase.get()
              .updateLoginColumn(value, username)
              .then((loginColumn) {
            print(loginColumn);
          });
          print("afterLopgin5");
          isloginRetValue = true;
          try {
            obj.syncFactoryLimited("login");
          } catch (_) {
            print("Syncing Fat gya hai");
          }

          print("Valid Login!");

          setState(() {
            //callSystemLevelSyncingForFirstTime();
          });
          try {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          } catch (_) {
            print("Dusri bar ka scaffold fata");
          }
          await Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new HomeDashboard()), //When Authorized Navigate to the next screen
          );
        } else if (value != null && value.merror == 10) {
          print("Validity Vale m ghusa");
          try {
            UserRightBean beanGet = new UserRightBean(
                mgrpcd: loginBean.mgrpcd, musrcode: loginBean.musrcode);
            await Constant.getAccessRights(beanGet);
          } catch (_) {
            print("Catch insiude");
          }

          _afterLogin(value);
          SyncingActivityState obj = SyncingActivityState();
          print("updating  login column");
          await AppDatabase.get()
              .updateLoginColumn(value, username)
              .then((loginColumn) {
            print(loginColumn);
          });
          print("afterLopgin5");
          isloginRetValue = true;
          try {
             obj.syncFactoryLimited("login");
          } catch (_) {
            print("Syncing Fat gya hai");
          }

          print("Valid Login!");

          setState(() {
            //callSystemLevelSyncingForFirstTime();
          });
          try {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          } catch (_) {
            print("Dusri bar ka scaffold fata");
          }
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new HomeDashboard()), //When Authorized Navigate to the next screen
          );

          setState(() {
            globals.Utility.showAlertPopup(
                context, "Info", value.merrormessage);
          });
        }
      });
      /*}catch(_){
        try {


          print("Inside 2nd catch");
          await AppDatabase.get().getLoginData(loginBean).then((afterLogin) {
            if (afterLogin == null) {
              isloginRetValue = false;
            } else if (afterLogin.musrcode.trim().toUpperCase() == loginBean.musrcode.trim().toUpperCase() &&
                afterLogin.musrpass.trim().toUpperCase() == loginBean.musrpass.trim().toUpperCase()) {
              _afterLogin(afterLogin);
              isloginRetValue = true;
            } else {

            }
          });
        } catch(error){
          isloginRetValue = false;
        }
      }*/
    }
    return isloginRetValue;
  }

  _afterLogin(LoginBean loginBean) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      print("login branch code of user " + loginBean.musrbrcode.toString());
      prefs.setString(
          TablesColumnFile.mreportinguser, loginBean.mreportinguser.toString());
      globals.agentUserName = loginBean.musrcode.toString().trim();
      globals.branchId = loginBean.musrbrcode;
      globals.reportingUser = loginBean.mreportinguser.trim();
      prefs.setString(TablesColumnFile.musrcode, loginBean.musrcode.toString());
      prefs.setString(TablesColumnFile.usrDesignation,
          loginBean.musrdesignation.toString());
      prefs.setInt(TablesColumnFile.grpCd, loginBean.mgrpcd);
      prefs.setString(
          TablesColumnFile.LoginTime, new DateTime.now().toString());
      prefs.setString(TablesColumnFile.musrname, loginBean.musrname.toString());
      prefs.setInt(TablesColumnFile.musrbrcode, loginBean.musrbrcode);
      prefs.setString(
          TablesColumnFile.mreportinguser, loginBean.mreportinguser.toString());
      prefs.setString(
          TablesColumnFile.profileimage, loginBean.profileimage.toString());

      try{
        prefs.setInt(TablesColumnFile.mlocationtrackeronoff, loginBean.mlocationtrackeronoff);
        prefs.setInt(TablesColumnFile.mpathtrackeronoff, loginBean.mpathtrackeronoff);
      }catch(__){}

      await Constant.setSystemVariables("login");
      try {
        await performGeoTaggingOfAgent(prefs);
      } catch (_) {}

      if (!isNetworkAvalable) {
        prefs.setInt("error", 99);
        prefs.setString("errorMessage", "UserName or Password is not valid");
      }
    } catch (_) {}
  }

  Future<Null> performGeoTaggingOfAgent(SharedPreferences prefs) async {
    var geolocator = Geolocator();
    var locationOptions =
    LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    print("xxxxxxxxxxxxxxtrying to perform Geotagging");
    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) async{
      print("setting position");
      print(position == null
          ? 'Unknown'
          : 'positions' +
          position.latitude.toString() +
          ', ' +
          position.longitude.toString());
      prefs.setDouble(TablesColumnFile.geoLatitude, position.latitude);
      prefs.setDouble(TablesColumnFile.geoLongitude, position.longitude);
      globals.geoLatitude= position.latitude;
      globals.geoLongitude =  position.longitude;





      int PATHTRACEAFTERMINUTES = prefs.getInt(TablesColumnFile.PATHTRACEAFTERMINUTES);
    DateTime dateStoredInSharedPref = null;
      try{
        String dateTimeString = prefs.getString(TablesColumnFile.startTime);
        dateStoredInSharedPref = DateTime.parse(dateTimeString);
      }catch(_){}

      if(dateStoredInSharedPref==null){
        prefs.setString(TablesColumnFile.startTime, DateTime.now().toString());
        dateStoredInSharedPref = DateTime.now();
      }

      String musrcode = prefs.getString(TablesColumnFile.musrcode);
      String mreportinguser = prefs.getString(TablesColumnFile.mreportinguser);
      String musrname = prefs.getString(TablesColumnFile.musrname);
      int mlocationtrackeronoff = prefs.getInt(TablesColumnFile.mlocationtrackeronoff);
      int mpathtrackeronoff = prefs.getInt(TablesColumnFile.mpathtrackeronoff);


      print("mpathtrackeronoff ${mpathtrackeronoff}");
      print("updatePositionOnServer ${mlocationtrackeronoff}");
      print("dateStoredInSharedPref ${dateStoredInSharedPref.toString()}");
      print("PATHTRACEAFTERMINUTES ${PATHTRACEAFTERMINUTES.toString()}");
      double checkPreviousLat = 0.0;
      double checkPreviousLong = 0.0;
      try {

        try{
        checkPreviousLat = prefs.getDouble(
            TablesColumnFile.CheckPreviousLat);
        checkPreviousLong = prefs.getDouble(
            TablesColumnFile.CheckPreviousLong);
           }catch(_){}

        if (checkPreviousLat != position.latitude &&
            checkPreviousLong != position.longitude) {
          if (mlocationtrackeronoff == 1) {
            await updatePositionOnServer(
                position.latitude, position.longitude, musrcode, mreportinguser,
                musrname, false);
          }
          int min=0;

          try {
             min = DateTime.now().difference(dateStoredInSharedPref).inMinutes;

          }catch(_){}
          print("dateStoredInSharedPref.difference(DateTime.now()).inMinutes  ${min.toString()}");
          if (dateStoredInSharedPref!=null && DateTime.now().difference(dateStoredInSharedPref).inMinutes > PATHTRACEAFTERMINUTES &&  mpathtrackeronoff == 1) {
            await updatePositionOnServer(
                position.latitude, position.longitude, musrcode, mreportinguser,
                musrname, true);
            prefs.setString(TablesColumnFile.startTime, DateTime.now().toString());
          }
        }
      }catch(_){}

      prefs.setDouble(TablesColumnFile.CheckPreviousLat, position.latitude);
      prefs.setDouble(
          TablesColumnFile.CheckPreviousLong, position.longitude);
    });

    print("Here comes the goelatitude");
    print(prefs.getDouble(TablesColumnFile.geoLatitude));
    Map<dynamic, dynamic> locationMap;

    /*locationMap = await GeoLocation.getLocation;
      var status = locationMap["status"];
      if ((status is String && status == "true") ||
          (status is bool) && status) {
        var lat = locationMap["latitude"];
        var lng = locationMap["longitude"];
        prefs.setDouble(TablesColumnFile.geoLatitude, lat);
        prefs.setDouble(TablesColumnFile.geoLongitude, lng);
      }*/
  }

  Future<bool> checkIfIsconnectedToNetwork() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  void _performLogin() async {
    await tryLogin(_username, _password);
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (_) {
      print("Hide snckbar fata");
    }

    /* navigateToScreen('Home');*/
    /*if(isLoggedIn==true){

    }*/
  }

  tryLogin(String username, String password) async {
    if(username.length<1){
      FocusScope.of(context).unfocus();
      Toast.show("Please enter UserName", context);
      //showValidationMessage("Please enter UserName",Colors.grey);
      return;
    }

    if(password.length<1){
      FocusScope.of(context).unfocus();
      Toast.show("Please enter password", context);
      return;
    }

    showMessage("Trying To login Please Wait", Colors.grey);

    bool isLoggedIn = await _loginRequest(username, password);
    if (!mounted) return;
    if (isLoggedIn) {
      print("Valid Login!");

      setState(() {
        //callSystemLevelSyncingForFirstTime();
      });
      try {
        _scaffoldKey.currentState.hideCurrentSnackBar();
      } catch (_) {
        print("Dusri bar ka scaffold fata");
      }
      // await Navigator.push(
      //   context,
      //   new MaterialPageRoute(
      //       builder: (context) =>
      //           new HomeDashboard()), //When Authorized Navigate to the next screen
      // );
    } else {
      try{
         String errorMessage = "No Response From Server";
      if (loginBeanGlobal.merrormessage != null &&
          loginBeanGlobal.merrormessage.trim() != 'null' &&
          loginBeanGlobal.merrormessage.trim() != 'null') {
        errorMessage = loginBeanGlobal.merrormessage;
      }
      print("Login not matched");
      setState(() {
        globals.Utility.showAlertPopup(context, "Info", errorMessage);
      });
      }catch(_){
      }
     
    }
  }

  Future<Null> navigateToScreen(String name) async {
    if (name.contains('Home')) {
      await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
            new HomeDashboard()), //When Authorized Navigate to the next screen
      );
    } else if (name.contains('ChangePassword')) {
      await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ChangePassword(
                "login")), //When Authorized Navigate to the next screen
      );
    } else {
      print('Error: $name');
    }
  }

  String _authorized = 'Not Authorized';

  /* Future<Null> _goToBiometrics() async {
    final LocalAuthentication auth = new LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: "scanFingure",
          useErrorDialogs: true,
          stickyAuth: false);
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() async{
      _authorized = authenticated ? "Authorized" : "Not Authorized";
      print(_authorized);

      if (authenticated) {
        //do this lateron while gl;oggiong from biometric
        */ /*  await AppDatabase.get().getLoginData(loginBean).then((afterLogin) {
          if (afterLogin == null) {
          } else if (afterLogin.musrcode == loginBean.musrcode &&
              afterLogin.usrPass == loginBean.usrPass) {
            _afterLogin(afterLogin);
            isloginRetValue = true;
          } else {

          }
        });*/ /*
        //TODO if logging from biometric then take every
        // Todo logging requried data as default like login agent and all
        navigateToScreen('Home');
      } else {
        globals.Utility.showAlertPopup(
            context, "Info", "login Biometric error");
      }
    });
  }*/

  void newAccount() {
    /* Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          Initializer.addCGT2Questions();
          return HomeDashboard(widget.cameras);
        },
        fullscreenDialog: true));*/
    // navigateToScreen('Home');
    globals.Dialog.alertPopup(context, "This module is locked",
        "Please ask support team To open this", "LoginPage");
  }

  /*Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          globals.Utility.showAlertPopup(context, "Info", "In progress");
        },
        fullscreenDialog: true));*/

  void openSettings() {
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new Settings(
            SettingsBeanPassedObject: null,
          )),
    );
  }

  void needHelp() {
    /*  Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          globals.Utility.showAlertPopup(context, "Info", "In progress");
        },
        fullscreenDialog: true));*/
    globals.Dialog.alertPopup(context, "This module is locked",
        "Please ask support team To open this", "LoginPage");
  }

  Future<bool> callDialog() {
    globals.Dialog.onWillPop(
        context, 'Are you sure?', 'Do you want to Exit', 'Exit');
  }
  FocusNode userNameFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: callDialog,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          /* child: Card(
          margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          color: Colors.white,*/
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /*IconButton(icon: Icon(Icons.menu),  onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();},),
                  IconButton(icon: Icon(Icons.search),  onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();},),*/
              new Text("  V U : " + globals.version.toString()),
              new Image(
                image: new AssetImage("assets/only_eco.png"),
              ),
              SizedBox(),
              new Image(
                image: new AssetImage("assets/Infrasoft_Footer.png"),
              )
            ],
          ),
          // ),
        ),
        key: _scaffoldKey,
        body: Card(
          margin: EdgeInsets.only(bottom: 5.0, left: 5.0, right: 5.0, top: 30.0),
          child: new Container(
            decoration: BoxDecoration(
              /* gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 1.0],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Color(0xFFdff0fe),
              Color(0xff07426A)
            ],
          )*/
            ),

            // color: Color(0xff07426A),
            child: new Form(
              key: formKey,child:new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    //Add padding around textfield
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Icon(
                        Icons.account_balance,
                        // color: Color(0xff07426A),
                        color: Colors.black45,
                        size: 90,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    //Add padding around textfield
                    padding: EdgeInsets.only(left: 25.0,right: 25.0,top: 10.0),
                    child: TextFormField(
                      // controller: _textFieldController,
                      textInputAction: TextInputAction.next,
                      focusNode: userNameFocusNode,
                      /* onSubmitted: (term) {
                        _fieldFocusChange(
                            context, userNameFocusNode, passwordFocusNode);
                      },*/

                      decoration: InputDecoration(
                         focusedErrorBorder:OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.grey))
                        ,
                        errorBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(color: Colors.grey)) ,
                        //Add th Hint text here.
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        labelText:Translations.of(context)
                            .text('username'),
                        labelStyle: TextStyle(
                            color: userNameFocusNode.hasFocus
                                ? Colors.grey
                                : Colors.grey),
                        /*icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),*/
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      initialValue:
                      _username != null && _username != 'null'
                          ? _username
                          : "",
                    /*  validator: (val) =>
                      val.length < 1 ? null : null,*/

                      onSaved: (val) => _username = val,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      autocorrect: false,

                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    //Add padding around textfield
                    padding: EdgeInsets.only(left: 25.0,right: 25.0,top: 10.0),
                    child: TextFormField(
                      // controller: _textFieldController,
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                          focusedErrorBorder:OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))
                          ,
                          errorBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        //Add th Hint text here.
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: userNameFocusNode.hasFocus
                                ? Colors.grey
                                : Colors.grey),
                        /*icon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),*/
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      initialValue:
                      _password != null && _password != 'null'
                          ? _password
                          : "",
                      /*validator: (val) =>
                      val.length < 1 ? null : null,*/
                      onSaved: (val) => _password = val,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.0,right: 25.0,top: 10.0),

                    child: Row(
                      children: <Widget>[

                        Expanded(
                          flex: 1,
                          child: new DropdownButtonFormField(
                            value: language,
                            items: generateDropDown(0),
                            onChanged: (LookupBeanData newValue) {
                              showDropDown(newValue, 0);
                            },
                            validator: (args) {
                              print(args);
                            },
                            /*onChanged: (value) {
                            setState(() => val = value);
                          },*/
                            decoration: InputDecoration(
                                labelText: "Select Language",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      style: BorderStyle.solid,
                                      color: Colors.grey),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ), //Select Language
                Expanded(
                  flex: 1,
                  child: Padding(
                    //Add padding around textfield
                    padding: EdgeInsets.only(left: 25.0,right: 25.0,top: 10.0),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                          side: BorderSide(color: Color(0xff07426A))),
                      onPressed:

                      _handleSubmitted,
                      child: Text(
                        Translations.of(context).text('login'),
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                      color: MyColors.loginButtonColor,
                      textColor: MyColors.logginTextColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    //Add padding around textfield
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child:
                    FlatButton(
                        onPressed: () async {
                          await AppDatabase.get()
                              .getAgentFingerPrint()
                              .then((onValue) {
                            print("ola>>" + onValue.toString());
                            if (onValue.agentrightfinger.toString() !=
                                null &&
                                onValue.agentrightfinger.toString().length >
                                    7) {
                              RhThumbValue =
                                  onValue.agentrightfinger.toString();
                            }
                            if (onValue.agentleftfinger.toString() !=
                                null &&
                                onValue.agentleftfinger.toString().length >
                                    7) {
                              LhThumbValue =
                                  onValue.agentleftfinger.toString();
                            }
                          })
                          ;
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          String bluetootthAdd = prefs
                              .getString(TablesColumnFile.bluetoothAddress);
                          print("bT>>> $bluetootthAdd");
                          print("RV>>" + RhThumbValue.toString());
                          print("LV>>" + LhThumbValue.toString());
                          if (bluetootthAdd.toString() != null &&
                              bluetootthAdd.toString().length > 7) {
                            if ((RhThumbValue.toString() != null &&
                                RhThumbValue.toString() != '') ||
                                (LhThumbValue.toString() != null &&
                                    LhThumbValue.toString() != '')) {
                              _callChannelAgentFPSMatch();
                            } else {
                              Toast.show(
                                  "No finger value found in Database!",
                                  context);
                            }
                          } else {
                            Toast.show("Please select a bluetooth device!",
                                context);
                          }

                        },
                        child: Image.asset("assets/fpsImages/agent_biometric_img.png")),
                  ),
                ),
                /* Expanded(
                  flex: 1,
                  child: Divider(
                    color: Colors.grey,
                  )),*/
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),

                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            await changePasswordRoute();
                          },
                          child: Text(
                            Translations.of(context).text('Change_Password'),
                            style: TextStyle(color: MyColors.bottomTextColor),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "|",
                          style: TextStyle(color: MyColors.bottomTextColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            needHelp;
                          },
                          child: Text(
                            Translations.of(context).text('need_help'),
                            style: TextStyle(color: MyColors.bottomTextColor),
                          ),
                        ),
                      ],
                    )),
                //Change passowrd row
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // GestureDetector(
                        //   behavior: HitTestBehavior.opaque,
                        //   onTap: ()async{
                        //     await resetPasswordRoute();
                        //   },
                        //   child: Text(
                        //     Translations.of(context).text('reset_password'),
                        //     style: TextStyle(color: MyColors.bottomTextColor),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10.0,
                        // ),
                        // Text(
                        //   "|",
                        //   style: TextStyle(color: MyColors.bottomTextColor),
                        // ),
                        // SizedBox(
                        //   width: 10.0,
                        // ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            Navigator.push(
                                context, SlideRightRoute(page: new DeviceSetting()));
                          },
                          child: Text(
                            Translations.of(context).text('bluetooth_setting'),
                            style: TextStyle(color: MyColors.bottomTextColor),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "|",
                          style: TextStyle(color: MyColors.bottomTextColor),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            openSettings();
                          },

                          child: Text(
                            Translations.of(context).text('Settings'),//TODO
                            style: TextStyle(color: MyColors.bottomTextColor),
                          ),
                        ),
                      ],
                    )),
                /* Expanded(
                child: SizedBox(
                  height: 0.0,
                ),
                flex: 2,
              ),*/
                /* Expanded(),
              Expanded(),
              Expanded(),*/
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void callSystemLevelSyncingForFirstTime() async {}

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    try {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Row(
        children: <Widget>[
          const CircularProgressIndicator(),
          new Text(message)
        ],
      ),
      duration: Duration(seconds: 35),
    ));
  }

  _callChannelAgentFPSMatch() async {
    //  prefs = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TablesColumnFile.userType, "AGENT");
    String bluetootthAdd = prefs.getString(TablesColumnFile.bluetoothAddress);
    print("Sending Value is $RhMiddleFingerValue");
    print("Sending Value is $RhIndexFingerValue");
    print("Sending Value is  for LH Index $LhIndexFingerValue");
    print("Sending Value is  LH MIDDle $LhMiddleFingerValue");
    print("Sending Value is  LH Thumb $LhThumbValue");
    try {
      final String result = await platform.invokeMethod("callingForFPSMatch", {
        "callValue": 0,
        "BluetoothADD": bluetootthAdd,
        "LhThumbValue": LhThumbValue,
        "LhIndexFingerValue": LhIndexFingerValue,
        "LhMiddleFingerValue": LhMiddleFingerValue,
        "LhRingFingerValue": LhRingFingerValue,
        "LhPinkyFingerValue": LhPinkyFingerValue,

        "RhThumbValue": RhThumbValue,
        "RhIndexFingerValue": RhIndexFingerValue,
        "RhMiddleFingerValue": RhMiddleFingerValue,
        "RhRingFingerValue": RhRingFingerValue,
        "RhPinkyFingerValue": RhPinkyFingerValue,
        // TODO pass dynamic blutooth address
      });
      String geTest = '$result';

      if (result == '-5') {

        await AppDatabase.get()
            .getLoginDataOnFingerPrint()
            .then((afterLogin) async {

          try {
            UserRightBean beanGet = new UserRightBean(
                mgrpcd: afterLogin.mgrpcd, musrcode: afterLogin.musrcode);
            await Constant.getAccessRights(beanGet);
          } catch (_) {
            print("Catch insiude");
          }

          _afterLogin(afterLogin);
          SyncingActivityState obj = SyncingActivityState();

          try {
            obj.syncFactoryLimited("login");
          } catch (_) {
            print("Syncing Fat gya hai");
          }

        });

        setState(() {
          print("User Verified");
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new HomeDashboard()),
          );
        });
      } else if (result == '-1') {
        setState(() {});
      } else if (result == '0') {
        setState(() {});
      }
      print("FLutter : " + geTest.toString());
    } on PlatformException catch (e) {
      print("FLutter : " + e.message.toString());
    }
  }
  void changePasswordRoute() async{
    await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new ChangePassword(
              "login")), //When Authorized Navigate to the next screen
    );
  }
  void resetPasswordRoute() async{
    await Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new ResetPasswordByAdmin(
              "login")),  //When Authorized Navigate to the next screen
    );
  }

  void updatePositionOnServer(double latitude, double longitude, String musrcode, String mreportinguser,String muserName,bool isPathTrackerOn) async{
    var updateCurrentLocationOfUser = new UpdateCurrentLocationOfUser();
    await updateCurrentLocationOfUser.updateCurrentLocationOfUser(latitude, longitude, musrcode, mreportinguser,muserName,isPathTrackerOn);
  }
}

class MyColors {
  static Color bottomTextColor = Colors.black45;
  static Color loginButtonColor = Color(0xff07426A);
  static Color logginTextColor = Colors.white;
}
