import 'dart:async';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/FullScreenDialogForGroupSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForProductSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';

import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/FullScreenDialogForCenterSelection.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanCycleParameterPrimaryTable/LoanCycleParameterPrimaryBean.dart';
import 'package:toast/toast.dart';

class GroupFormationMaster extends StatefulWidget {
  final groupDetailsPassedObject ;
  GroupFormationMaster(this.groupDetailsPassedObject);
  @override
  _GroupFormationMasterState createState() => new _GroupFormationMasterState();
}

class _GroupFormationMasterState extends State<GroupFormationMaster> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TabController _tabController;
  ProductBean prodObj = new ProductBean();
  LookupBeanData status;
  LookupBeanData freezType;
  DateTime selectedDate = DateTime.now();
  DateTime date;
  TimeOfDay time;
  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  String tempYear ;
  String tempDay ;
  String tempMonth;
  bool boolValidate = false;
  int accountNumber;
  int loanNumber;
  int branch ;
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  FocusNode monthFocus;
  FocusNode yearFocus;
  GroupFoundationBean groupFoundationBean=new GroupFoundationBean();
   bool isNew=false;
  static String firstMeetingDate = "__-__-____";
  String mCenterRepayFromTo="";
  int mCenterRepayFrom=0;
  int mCenterRepayTo=0;
  SystemParameterBean sysBean = new SystemParameterBean();
  String error;
  CenterDetailsBean centerBean = new CenterDetailsBean();

  FullScreenDialogForCenterSelection _myCenterDialog =
  new FullScreenDialogForCenterSelection("Group Creation");
  String centerName="";
  int isWasasa= 1;

  LookupBeanData groupType;
  LookupBeanData groupGender;
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  String operationDate;

  String productName = "";

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          groupType = blankBean;
          groupFoundationBean.mgrouptype = blankBean.mcode;

          break;
        case 1:
          groupGender = blankBean;
          groupFoundationBean.mgroupgender = blankBean.mcode;
          break;
        default:
          break;
      }
      setState(() {

      });
    }
    else{
      bool isBreak = false;
      for (int k = 0;
      k < globals.dropdownCaptionsValuesGroupFormation[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesGroupFormation[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesGroupFormation[no][k]);
          isBreak=true;
          break;
        }
        if(isBreak){
          break;
        }
      }

    }


  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          groupType = value;
          groupFoundationBean.mgrouptype = value.mcode;

          break;
        case 1:
          groupGender = value;
          groupFoundationBean.mgroupgender = value.mcode;
          break;

        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsPersonalInfo[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesGroupFormation[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesGroupFormation[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      print("data here is of  dropdownwale biayajai " + value.mcodedesc);
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

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        'Are you sure?',
        'Do you want to Go To Group List without saving data',
        "gggggg");
  }


  @override
  void initState() {
     super.initState();

    if(widget.groupDetailsPassedObject!=null && widget.groupDetailsPassedObject.trefno!=null && widget.groupDetailsPassedObject.trefno!="null" && widget.groupDetailsPassedObject.trefno!="" && widget.groupDetailsPassedObject.trefno!=null){
      groupFoundationBean.trefno=widget.groupDetailsPassedObject.trefno;
      print("groupFoundationBean.trefno"+groupFoundationBean.trefno.toString());
      print("widget.groupDetailsPassedObject.trefno"+widget.groupDetailsPassedObject.trefno.toString());
      groupFoundationBean=widget.groupDetailsPassedObject;
      //firstMeetingDate = groupFoundationBean.mfirstmeetngdt.toString();
    }else{
      groupFoundationBean=new GroupFoundationBean();

    }



      getSessionVariables();





   
    
  }




  bool ifNullCheck(String value) {
    bool isNull = false;
    try {
      if (value == null || value == 'null' || value.trim()=='') {
        isNull = true;
      }
    }catch(_){
      isNull =true;
    }
    return isNull;
  }

  Future getProduct() async {
    prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(30,1),
          fullscreenDialog: true,
        ));
    if (prodObj != null) {

      groupFoundationBean.mgroupprdcode = prodObj.mprdCd;
      productName = prodObj.mname;
      if(isWasasa==1){
        int lbrcode = 0;

        print(branch);
        if(branch!=null)

        await AppDatabase.get().getMinMaxGroupSize(branch, groupFoundationBean.mgroupprdcode).then((LoanCycleParameterPrimaryBean loanCyclePrimaryBean ){


            if(loanCyclePrimaryBean!=null){
             groupFoundationBean.mMaxGroupMembers=  loanCyclePrimaryBean.mmaxnoofgrpmems;
             groupFoundationBean.mMinGroupMembers = loanCyclePrimaryBean.mminnoofgrpmems;
            }
            else{
                  
                print("Returned null");
            }


setState(() {
  
});



        });
        
        

      }


    }



  }


  Future<Null> getSessionVariables() async {
    if (widget.groupDetailsPassedObject != null) {
      groupFoundationBean = widget.groupDetailsPassedObject;
    } else {
      AppDatabase.get().generateTrefnoForGroupCreation().then((onValue) {
        setState(() {
          groupFoundationBean.trefno = onValue;
        });

      });
    }
    prefs = await SharedPreferences.getInstance();
    setState(() {
      groupFoundationBean.mlbrcode = prefs.get(TablesColumnFile.musrbrcode);
      branch = prefs.get(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode);
      print("username"+username.toString());
      usrRole = prefs.getString(TablesColumnFile.musrdesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.mgrpcd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.mgeolocation);
      geoLatitude = prefs.get(TablesColumnFile.mgeolatd).toString();
      geoLongitude = prefs.get(TablesColumnFile.mgeologd).toString();
      reportingUser = prefs.getString(TablesColumnFile.mreportinguser);
      operationDate = prefs.getString(TablesColumnFile.branchOperationalDate);
      if (groupFoundationBean.mGrprecogTestDate==null||groupFoundationBean.mGrprecogTestDate==""){

        try{
          groupFoundationBean.mGrprecogTestDate = DateTime.parse(operationDate);

        }catch(_){
          groupFoundationBean.mGrprecogTestDate = DateTime.now();
        }


      }
      isWasasa = prefs.getInt(TablesColumnFile.isWASASA);
      if(isWasasa==1){

          groupFoundationBean.mgrouptype = "17";
      }else{

           groupFoundationBean.mgrouptype = "17";
      }



      print("Mehul username"+username.toString());
      if (groupFoundationBean.mgrtapprovedby==null||groupFoundationBean.mgrtapprovedby=="")
        groupFoundationBean.mgrtapprovedby = username;

      print("geoLatitude:" + geoLatitude +  " geoLongitude:" + geoLongitude);
    });


    if(groupFoundationBean.mgroupprdcode!=null){
      try{

        await AppDatabase.get().getProductOnPrdCd(30, branch, groupFoundationBean.mgroupprdcode).then((ProductBean val){
        if(val!=null)
        productName = val.mname;

      });
      }catch(_){

        productName="";
      }
      
    }


    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues
        .add(groupFoundationBean.mgrouptype.toString());
    tempDropDownValues
        .add(groupFoundationBean.mgroupgender.toString());


    for (int k = 0;
    k < globals.dropdownCaptionsValuesGroupFormation.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesGroupFormation[k].length;
      i++) {


        try{
          if (globals.dropdownCaptionsValuesGroupFormation[k][i].mcode.toString().trim() ==
              tempDropDownValues[k].toString().trim()) {

            print("Matched");
            setValue(k, globals.dropdownCaptionsValuesGroupFormation[k][i]);
          }
        }catch(_){
          print("Exception Occured");

        }
      }
    }





  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          callDialog();
        },
    child: new Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 1.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
           onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();callDialog();},
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text("New Group Creation",
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
             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
              proceed();
            },
          ),

          new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),
      body: new Form(
        key: _formKey,
        autovalidate: false,
        onWillPop: () {
          return Future(() => true);
        },
        onChanged: () async {
          final FormState form = _formKey.currentState;
          form.save();
          //await calculate();

        },

        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          children: <Widget>[

            SizedBox(height: 16.0),
            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text("Center Name/No"),
                subtitle: groupFoundationBean.mcenterid ==null||
                    groupFoundationBean.mcenterid=="null"?new Text(""):
                new Text("${groupFoundationBean.mcenterid} / ${centerName}"),
                onTap: ()async  {

                  centerBean = await Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) =>_myCenterDialog,
                        fullscreenDialog: true,
                      ));
                  if(centerBean!=null){
                    if (centerBean.mCenterId != null){
                      groupFoundationBean.mcenterid= centerBean.mCenterId;
                      centerName = centerBean.mcentername;
                    }

                    else{
                      groupFoundationBean.mcenterid = 0;
                      centerName = "";
                    }

                    if (centerBean.mrefno != null)
                      groupFoundationBean.mrefcenterid=centerBean.mrefno;
                    else
                      groupFoundationBean.mrefcenterid=0;
                    groupFoundationBean.trefcenterid=centerBean.trefno;
                  }

                  setState(() {

                  });
                },
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              color: Constant.mandatoryColor,
              child:new DropdownButtonFormField(
                value:groupType==null?null: groupType,
                items: generateDropDown(0),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 0);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: "Group Type"),
                // style: TextStyle(color: Colors.grey),
              ),),

            SizedBox(height: 20.0,),

            Card(
              child: new ListTile(
                title: new Text("GRT Date"),
                subtitle:new Text("${formatter.format(groupFoundationBean.mGrprecogTestDate)}"),
              ),

            ),

            SizedBox(height: 20.0,),

            Card(
              child: new ListTile(
                title: new Text("GRT Approved By"),
                subtitle:new Text("${groupFoundationBean.mgrtapprovedby}"),
              ),

            ),

            SizedBox(height: 20.0,),

            new Container(
              color: Constant.mandatoryColor,
              child: new TextFormField(
                  decoration:  InputDecoration(
                    hintText: 'Enter Group Name',
                    labelText: "Group Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    /*labelStyle: TextStyle(color: Colors.grey),*/
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  /*inputFormatters: [
                    new LengthLimitingTextInputFormatter(50),
                    globals.onlyCharacter
                  ],*/
                  controller:groupFoundationBean.mgroupname == null
                      ? TextEditingController(text: "")
                      : TextEditingController(
                      text: groupFoundationBean.mgroupname)
                  ,
                  /*initialValue:
                  centerDetailsBean.mcentername != null ? centerDetailsBean.mcentername : "",*/

                onSaved: (val) {
                  if(val!=null&&val!=""){
                    try{
                      groupFoundationBean.mgroupname = (val);
                    }catch(e){

                    }
                  }

                },),
            ),

            SizedBox(height: 16.0),

            Card(
              color: Constant.mandatoryColor,
              child: new ListTile(
                title: new Text("Product Name"),
                subtitle: groupFoundationBean.mgroupprdcode ==null||
                    groupFoundationBean.mgroupprdcode=="null"?new Text(""):
                new Text("${productName} / ${groupFoundationBean.mgroupprdcode}"),
                onTap: getProduct,
              ),
            ),

            SizedBox(height: 16.0),

            new Container(
              color: Constant.mandatoryColor,
              child: new TextFormField(
                decoration:  InputDecoration(
                  hintText: 'Enter Min Group Member',
                  labelText: "Min. Group Member",
                  hintStyle: TextStyle(color: Colors.grey),
                  /*labelStyle: TextStyle(color: Colors.grey),*/
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff07426A),
                      )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff07426A),
                      )),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(50),
                  globals.onlyIntNumber
                ],
                enabled: isWasasa==1?false:true,
                controller: new TextEditingController(text:'${groupFoundationBean.mMinGroupMembers!=null?groupFoundationBean.mMinGroupMembers:0}'),
                /*validator: (String value) {
                  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                      .hasMatch(value)) {
                    return "no special character allowed";
                  } else
                    return null;
                },*/
                onSaved: (String value) {
                  if (value.isNotEmpty &&
                      value != "" &&
                      value != null &&
                      value != 'null') {
                    groupFoundationBean.mMinGroupMembers = int.parse(value);
                  }
                },),
            ),

            SizedBox(height: 20.0,),

            new Container(
              color: Constant.mandatoryColor,
              child: new TextFormField(
                decoration:  InputDecoration(
                  hintText: 'Enter Group Size',
                  labelText: "Group Size",
                  hintStyle: TextStyle(color: Colors.grey),
                  /*labelStyle: TextStyle(color: Colors.grey),*/
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff07426A),
                      )),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff07426A),
                      )),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(50),
                  globals.onlyIntNumber
                ],
                enabled: isWasasa==1?false:true,
                controller: new TextEditingController(text:'${groupFoundationBean.mMaxGroupMembers!=null?groupFoundationBean.mMaxGroupMembers:0}'),
                // initialValue:
                // groupFoundationBean.mMaxGroupMembers == null ? "" : "${groupFoundationBean.mMaxGroupMembers}",
                /*validator: (String value) {
                  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                      .hasMatch(value)) {
                    return "no special character allowed";
                  } else
                    return null;
                },*/
                onSaved: (String value) {
                  if (value.isNotEmpty &&
                      value != "" &&
                      value != null &&
                      value != 'null') {
                    groupFoundationBean.mMaxGroupMembers = int.parse(value);
                  }
                },),
            ),

            



            SizedBox(height: 16.0),

            Container(
              color: Constant.mandatoryColor,
              child:new DropdownButtonFormField(
                value:groupGender==null?null: groupGender,
                items: generateDropDown(1),
                onChanged: (LookupBeanData newValue) {
                  showDropDown(newValue, 1);
                },
                validator: (args) {
                  print(args);
                },
                //  isExpanded: true,
                //hint:Text("Select"),
                decoration: InputDecoration(labelText: "Gender"),
                // style: TextStyle(color: Colors.grey),
              ),),



          ],
        ),
      ),

    ));

  }


  /*Future getProduct() async {
    prodObj = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForProductSelection(11),
          fullscreenDialog: true,
        ));
//    savingsListObj.mprdcd = prodObj.mprdCd.toString();
  }*/
  Future getCustomerNumber() async {
    var customerdata;
    customerdata = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                CustomerList(null,"Loan Application")));
    if (customerdata != null) {

      /*savingsListObj.mcustno =
      customerdata.mcustno != null ? customerdata.mcustno : 0;
      savingsListObj.mcusttrefno =
      customerdata.trefno != null ? customerdata.trefno : 0;
      savingsListObj.mcustmrefno =
      customerdata.mrefno != null ? customerdata.mrefno : 0;
      savingsListObj.mlongname = customerdata.mlongname;
      savingsListObj.mcenterid =
      customerdata.mcenterid != null ? customerdata.mcenterid : 0;
      savingsListObj.mgroupcd = customerdata.mgroupcd != null ? customerdata.mgroupcd : 0;*/
    }
  }


  Future<void> _successfulSubmit() async {

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Icon(
              Icons.offline_pin,
              color: Colors.green,
              size: 60.0,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Done'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok '),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  setState(() {

                  });
                },
              ),
            ],
          );
        });
  }
  proceed() async {
    if (!validateSubmit()) {
      return;
    }
    if(groupFoundationBean.mgroupid!=null&&groupFoundationBean.mgroupid!=0){
      Toast.show(Translations.of(context).text('Modification Not Allowed'),context);
      return ;
    }

//    savingsListObj.mmoduletype=11;
    groupFoundationBean.mcreatedby = username;
    groupFoundationBean.mgrtapprovedby = username;
    print("centerDetailsBean.mcreatedby"+groupFoundationBean.mcreatedby.toString());
    print("username"+username.toString());
    groupFoundationBean.mlastupdateby = null;

    if ((groupFoundationBean.mcreateddt == 'null') || (groupFoundationBean.mcreateddt == null))
      groupFoundationBean.mcreateddt = DateTime.now();

    groupFoundationBean.mlastupdatedt = DateTime.now();
    groupFoundationBean.mgeolatd=geoLatitude;
    groupFoundationBean.mgeologd=geoLongitude;
    groupFoundationBean.magentcd= username;
    groupFoundationBean.mloanlimit=0;
    groupFoundationBean.meetingday=0;
    groupFoundationBean.missynctocoresys = 0;

    if (groupFoundationBean.mgroupprdcode == 'null' || groupFoundationBean.mgroupprdcode == null)
      groupFoundationBean.mgroupprdcode='';

    groupFoundationBean.missynctocoresys=0;
    if ((groupFoundationBean.mgroupid == 'null') || (groupFoundationBean.mgroupid == null))
      groupFoundationBean.mgroupid = 0;


    if( groupFoundationBean.mrefno==null){
      groupFoundationBean.mrefno=0;
    }
    await AppDatabase.get()
        .updateGroupFoundation(groupFoundationBean)
        .then((val) {
      print("val here is " + val.toString());

    });
    _successfulSubmit();
  }


  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$arg'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
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


  bool validateSubmit() {
    String error = "";
    print("inside mgroupname" + groupFoundationBean.mgroupname.toString());

    if (groupFoundationBean.mrefcenterid==null && groupFoundationBean.trefcenterid==null
     ) {
     _showAlert("Center Selection", "Center Selection is mandatory");
     return false;
   }

    if (groupFoundationBean.mgroupname==null || groupFoundationBean.mgroupname.trim()==""||
     groupFoundationBean.mgroupname.trim()=="null"
     ) {
     _showAlert("Group name", "Group Name is Mandatory");
     return false;
   }

   if (groupFoundationBean.mgroupprdcode==null||groupFoundationBean.mgroupprdcode.trim()=="null"||
      groupFoundationBean.mgroupprdcode.trim()==""
     ) {
     _showAlert("Group Product", "Group Product cennot be blank");
     return false;
   }


   if (groupFoundationBean.mMinGroupMembers==null || groupFoundationBean.mMinGroupMembers == 0
     ) {
     _showAlert("Min Group Members", "Min Group Members is mandatory");
     return false;
   }
  if (groupFoundationBean.mMaxGroupMembers==null || groupFoundationBean.mMaxGroupMembers == 0
     ) {
     _showAlert("Max Group Members", "Max Group Members is mandatory");
     return false;
   }

  if (groupFoundationBean.mMaxGroupMembers<groupFoundationBean.mMinGroupMembers
     ) {
     _showAlert("Max Group Members", "Max Group Members cannot be less then min group member");
     return false;
   }

   
   
   if (groupFoundationBean.mgroupgender==null||groupFoundationBean.mgroupgender.trim()=="null"||
      groupFoundationBean.mgroupgender.trim()==""
     ) {
     _showAlert("Group Gender", "Group Gender cannot be blank");
     return false;
   }

  //  if (centerDetailsBean.mfirstmeetngdt == "" || centerDetailsBean.mfirstmeetngdt== null) {
  //    _showAlert("First Meeting Date", "First Meeting Date is Mandatory");
  //    return false;
  //  }
  //  if (centerDetailsBean.mmeetingfreq == "" || centerDetailsBean.mmeetingfreq== null) {
  //    _showAlert("Meeting Frequency", "Meeting Frequency is Mandatory");
  //    return false;
  //  }
    return true;

  }




}
