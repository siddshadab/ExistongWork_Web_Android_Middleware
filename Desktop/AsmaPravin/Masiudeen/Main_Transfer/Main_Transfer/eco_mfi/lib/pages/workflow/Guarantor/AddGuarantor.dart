import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/Utilities/SignaturePainter.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForAreaSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForDistrictSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForStateSelection.dart';
import 'package:eco_mfi/pages/workflow/address/FullScreenDialogForSubDistrictSelection.dart';
import 'package:eco_mfi/pages/workflow/address/beans/AreaDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/GetCustomerFromMiddleware.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
var docListView=new List<PhotoViewGalleryPageOptions>();


class AddGuarantor extends StatefulWidget {
  final gaurantorDetailsPassedObject;
  final String mleadsId;
  final int mrefno;
  final int trefno;
 final laonLimitPassedObject;
  AddGuarantor({Key key, this.gaurantorDetailsPassedObject,this.mleadsId,this.mrefno,this.trefno,this.laonLimitPassedObject}) : super(key: key);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _AddGuarantorState createState() => new _AddGuarantorState();
}

class _AddGuarantorState extends State<AddGuarantor> {
  static final GlobalKey<FormState> _formKeyNationalId = new GlobalKey<FormState>();
  SystemParameterBean sysBean = new SystemParameterBean();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  FullScreenDialogForStateSelection _myStateDialog =
  new FullScreenDialogForStateSelection();
  FullScreenDialogForDistrictSelection _myDistrictDialog =
  new FullScreenDialogForDistrictSelection();
  FullScreenDialogForSubDistrictSelection _mySubDistrictDialog =
  new FullScreenDialogForSubDistrictSelection(false);
  FullScreenDialogForSubDistrictSelection _mySubDistrictDialogDesend =
  new FullScreenDialogForSubDistrictSelection(true);
  FullScreenDialogForAreaSelection _myAreaDialog =
  new FullScreenDialogForAreaSelection();
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempDate = "----/--/--";
  String applicantDob = "__-__-____";

  String tempYear ;
  String tempDay ;
  String tempMonth;

  DateTime date;
  TimeOfDay time;
  int selectedPosition = 0;
  String customerName;
  String branch = "";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  LookupBeanData NationalId;
  GuarantorDetailsBean guarantorobj = new GuarantorDetailsBean();
  LookupBeanData ApplicantType;
  LookupBeanData RelationWithApplicant;
  LookupBeanData HouseType;
  LookupBeanData OccupationType;
  LookupBeanData MainOccupation;
  LookupBeanData Gender;
  LookupBeanData maritalstatus;
  LookupBeanData buspropownership;
  LookupBeanData busownership;
  LookupBeanData samevillageorward;
  FocusNode monthFocus;
  FocusNode yearFocus;
  FocusNode monthFocusH;
  FocusNode yearFocusH;
  bool isExistingCustomerY = true;
  bool AgeNotPresent=true;
  bool GrntrNameNotPresent=true;
  bool Add1NotPresent=true;
  bool Add2NotPresent=true;
  bool NationalIDNotPresent=true;
  bool MobileNotPresent=true;
  bool stateCdPresent=false;
  bool villageCdPresent=false;
   bool townShipPresent=false;  
  bool applicantDobNotPresent = false;
  bool wardNoPresent = false;
  File f;
  File _image;
  int isFullerTon=0;
  String dialCode = "";
  StateDropDownList tempStateBean = new StateDropDownList();
  SubDistrictDropDownList tempSubDistrictBean = new SubDistrictDropDownList();
  DistrictDropDownList tempDistrictBean = new DistrictDropDownList();
  AreaDropDownList tempAreaDistrict = new AreaDropDownList();
  bool id1Mand=true;
  bool spouseNameMand=false;
  int resAddCode;
  String mvillage;
  bool circIndicator= false;
  bool circNationIdIndicator  = false;
  int minAge;
  int maxAge;
  static const JsonCodec JSON = const JsonCodec();
  bool isDedupDone = false;


  @override
  void initState() {

   

    if(widget.mleadsId!="null"||widget.mleadsId!=""||widget.mleadsId!=null){
  guarantorobj.mleadsid=widget.mleadsId;
  print("guarantorobj.mleadsid"+guarantorobj.mleadsid.toString());
  print("widget.mleadsId"+widget.mleadsId.toString());
}
if(widget.mrefno!="null"||widget.mrefno!=""||widget.mrefno!=null){
  guarantorobj.mloanmrefno=widget.mrefno;
  print("guarantorobj.mleadsid"+guarantorobj.mloanmrefno.toString());
  print("widget.mrefno"+widget.mrefno.toString());
}
if(widget.trefno!="null"||widget.trefno!=""||widget.trefno!=null){
  guarantorobj.mloantrefno=widget.trefno;
  print("guarantorobj.mleadsid"+guarantorobj.mloantrefno.toString());
  print("widget.trefno"+widget.trefno.toString());
}
print("widget.gaurantorDetailsPassedObject"+widget.gaurantorDetailsPassedObject.toString());

if(widget.gaurantorDetailsPassedObject!=null && widget.gaurantorDetailsPassedObject.trefno!=null && widget.gaurantorDetailsPassedObject.trefno!="null" && widget.gaurantorDetailsPassedObject.trefno!="" && widget.gaurantorDetailsPassedObject.trefno!=null){
  guarantorobj.trefno=widget.gaurantorDetailsPassedObject.trefno;
  print("guarantorobj.mleadsid"+guarantorobj.mloantrefno.toString());
  print("widget.gaurantorDetailsPassedObject.trefno"+widget.gaurantorDetailsPassedObject.trefno.toString());
}
    isExistingCustomerY = true;
    globals.existingCustomer = 'Yes';
    globals.isExistingCustomerYN = [0];
    guarantorobj.mexistingcustyn="0";

      getSessionVariables();


    if(widget.gaurantorDetailsPassedObject!=null){

      if(widget.gaurantorDetailsPassedObject.mcustno!=null&&widget.gaurantorDetailsPassedObject.mcustno!=0){
        AgeNotPresent=false;
        GrntrNameNotPresent=false;
        Add1NotPresent=false;
         Add2NotPresent=false;
        NationalIDNotPresent=false;
        MobileNotPresent=false;

      }

      if (widget.gaurantorDetailsPassedObject.mdob != null && widget.gaurantorDetailsPassedObject.mdob != 'null' && widget.gaurantorDetailsPassedObject.mdob != '') {

          String tempDay;
          String tempMonth;
          if (widget.gaurantorDetailsPassedObject.mdob.day
              .toString()
              .length == 1)
            tempDay = "0" + widget.gaurantorDetailsPassedObject.mdob.day.toString();
          else
            tempDay = widget.gaurantorDetailsPassedObject.mdob.day.toString();

          if (widget.gaurantorDetailsPassedObject.mdob.month
              .toString()
              .length == 1)
            tempMonth = "0" + widget.gaurantorDetailsPassedObject.mdob.month.toString();
          else
            tempMonth = widget.gaurantorDetailsPassedObject.mdob.month.toString();

          applicantDob =
              applicantDob
                  .replaceRange(0, 2, tempDay);
          print(
              "applicant DOB = ${applicantDob}");
          applicantDob =
              applicantDob
                  .replaceRange(3, 5, tempMonth);
          print(
              "applicant DOB = ${applicantDob}");
          applicantDob =
              applicantDob
                  .replaceRange(
                  6, 10, widget.gaurantorDetailsPassedObject.mdob.year.toString());
      }

      if (!applicantDob.contains("_")) {
        try {
          String tempApplicantdob = applicantDob;
          //applicantDob = tempp.toString();
          DateTime  formattedDate =  DateTime.parse(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
          //print(formattedDate);
          tempDay = formattedDate.day.toString();
          //print(tempDay);
          tempMonth = formattedDate.month.toString();
          //print(tempMonth);
          tempYear = formattedDate.year.toString();
        }catch(_){}

        print("Exception Occupred");
      }

      guarantorobj.mloanmrefno=widget.gaurantorDetailsPassedObject.mloanmrefno;
      guarantorobj.mloantrefno=widget.gaurantorDetailsPassedObject.mloantrefno;


      guarantorobj=widget.gaurantorDetailsPassedObject;
      print("guarantorobj"+widget.gaurantorDetailsPassedObject.toString());
      print("obj is ${guarantorobj}");
      if(widget.gaurantorDetailsPassedObject.mexistingcustyn!=null||widget.gaurantorDetailsPassedObject.mexistingcustyn!="null"||widget.gaurantorDetailsPassedObject.mexistingcustyn!=""){
        guarantorobj.mexistingcustyn=widget.gaurantorDetailsPassedObject.mexistingcustyn;
        print("widget.gaurantorDetailsPassedObject.mexistingcustyn"+widget.gaurantorDetailsPassedObject.mexistingcustyn.toString());
        if(widget.gaurantorDetailsPassedObject.mexistingcustyn==null||widget.gaurantorDetailsPassedObject.mexistingcustyn=="null"||widget.gaurantorDetailsPassedObject.mexistingcustyn==""||widget.gaurantorDetailsPassedObject.mexistingcustyn=="0"||guarantorobj.mexistingcustyn==0) {
          isExistingCustomerY = true;
          globals.existingCustomer = 'Yes';
          globals.isExistingCustomerYN = [0];
          guarantorobj.mexistingcustyn="0";

        }
        else{
          isExistingCustomerY = false;
          globals.existingCustomer = 'No';
          globals.isExistingCustomerYN = [1];
          guarantorobj.mcustno=null;
          //guarantorobj = new GuarantorDetailsBean();
          guarantorobj.mexistingcustyn="1";

        }
      }
    }

    if (guarantorobj.mcreateddt =="null" ||guarantorobj.mcreateddt ==null) {
      guarantorobj.mcreateddt = DateTime.now();
    }

    print("guarantorobj.mrelationwithcust ${guarantorobj.mrelationwithcust}");
    monthFocus = new FocusNode();
    yearFocus = new FocusNode();
    //print("Appllicant DOB is ${applicantDob}");
    monthFocusH = new FocusNode();
    yearFocusH = new FocusNode();
    //print("In Add Guarantor");
    super.initState();
    setDropdownOnPageLoad();
  }

  setDropdownOnPageLoad(){

    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues
        .add(guarantorobj.mnationalidtype.toString());
    tempDropDownValues
        .add(guarantorobj.mapplicanttype.toString());
    tempDropDownValues
        .add(guarantorobj.mgender.toString());
    tempDropDownValues
        .add(guarantorobj.mrelationwithcust.toString());
    tempDropDownValues
        .add(guarantorobj.mhousetype.toString());
    tempDropDownValues
        .add(guarantorobj.moccupationtype.toString());
    tempDropDownValues
        .add(guarantorobj.mmainoccupation.toString());
    tempDropDownValues
        .add(guarantorobj.mmaritalstatus.toString());
    tempDropDownValues
        .add(guarantorobj.mbuspropownership.toString());
    tempDropDownValues
        .add(guarantorobj.mbusownership.toString());
    tempDropDownValues
        .add(guarantorobj.msamevillageorward.toString());


    for (int k = 0;
    k < globals.dropdownCaptionsValuesGuarantorInfo.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesGuarantorInfo[k].length;
      i++) {


        try{
          if (globals.dropdownCaptionsValuesGuarantorInfo[k][i].mcode.toString().trim() ==
              tempDropDownValues[k].toString().trim()) {

            //   print("Matched");

            setValue(k, globals.dropdownCaptionsValuesGuarantorInfo[k][i]);
          }
        }catch(_){
            print("Exception Occured in dropdown");

        }
      }
    }
  }

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      // print("inside  code Desc is null");
      switch (no) {
        case 0:
          NationalId = blankBean;
          guarantorobj.mnationalidtype=0;

          break;
        case 1:
          ApplicantType = blankBean;
          guarantorobj.mapplicanttype=0;
          break;
        case 2:
          Gender = blankBean;
          guarantorobj.mgender=blankBean.mcode;
          break;

        case 3:
          RelationWithApplicant = blankBean;
          guarantorobj.mrelationwithcust=blankBean.mcode;
          break;

        case 4:
          HouseType = blankBean;
          guarantorobj.mhousetype=0;
          break;

        case 5:
          OccupationType = blankBean;
          guarantorobj.moccupationtype=0;
          break;

        case 6:
          MainOccupation = blankBean;
          guarantorobj.mmainoccupation=0;
          break;

        case 7:
          maritalstatus = blankBean;
          guarantorobj.mmaritalstatus=0;
          break;

        case 8:
          buspropownership = blankBean;
          guarantorobj.mbuspropownership=0;
          break;

        case 9:
          busownership = blankBean;
          guarantorobj.mbusownership=0;
          break;

        case 10:
          samevillageorward = blankBean;
          guarantorobj.msamevillageorward=blankBean.mcode;
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
      k < globals.dropdownCaptionsValuesGuarantorInfo[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesGuarantorInfo[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesGuarantorInfo[no][k]);
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
      //   print("coming here");
      switch (no) {
        case 0:
          NationalId=value;
          guarantorobj.mnationalidtype = int.parse(value.mcode);
          if(guarantorobj.mnationalidtype==99){
            id1Mand = false;
          }else{
            id1Mand = true;
          }
          break;
        case 1:
          ApplicantType=value;
          guarantorobj.mapplicanttype = int.parse(value.mcode);
          break;
        case 2:
          Gender=value;
          guarantorobj.mgender = value.mcode;
          break;

        case 3:
          RelationWithApplicant=value;
          guarantorobj.mrelationwithcust = value.mcode;
          break;

        case 4:
          HouseType=value;
          guarantorobj.mhousetype = int.parse(value.mcode);
          break;

        case 5:
          OccupationType=value;
          guarantorobj.moccupationtype = int.parse(value.mcode);
          break;

        case 6:
          MainOccupation=value;
          guarantorobj.mmainoccupation = int.parse(value.mcode);
          break;

        case 7:
          maritalstatus=value;
          guarantorobj.mmaritalstatus = int.parse(value.mcode);
          if(guarantorobj.mmaritalstatus==2){
            spouseNameMand = true;
          }else{
            spouseNameMand = false;
          }
          break;

        case 8:
          buspropownership=value;
          guarantorobj.mbuspropownership = int.parse(value.mcode);
          break;

        case 9:
          busownership=value;
          guarantorobj.mbusownership = int.parse(value.mcode);
          break;

        case 10:
          samevillageorward=value;
          guarantorobj.msamevillageorward = value.mcode;
          break;

        default:
          break;
      }
    });
  }
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    // print("caption value : " + globals.dropdownCaptionsValuesGuarantorInfo[no].toString());

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesGuarantorInfo[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesGuarantorInfo[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      //   print("data here is of  dropdownwale biayajai " + value.mcodedesc);
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc),
      );
    }).toList();

    return _dropDownMenuItems1;
  }
  Future<Null> getSessionVariables() async {
    String ageValidation = "";

    if(guarantorobj.trefno==""||guarantorobj.trefno==null||guarantorobj.trefno=="null"){
    await AppDatabase.get().generateTrefnoForGuarantor().then((onValue) {
      guarantorobj.trefno = onValue;
    });
    }
    setState(() {

    });
    prefs = await SharedPreferences.getInstance();

    try {
      isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
//      if(isFullerTon==1) {
//        CustomerFormationMasterTabsState.addressBean.mcountryCd = "95";
//        CustomerFormationMasterTabsState.addressBean.mcountryname = "Myanmar";
//        setState(() {
//        });
//      }
    }catch(_){}


    dialCode = prefs.getString(TablesColumnFile.dialCode);

    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation=  prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude  = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      reportingUser= prefs.getString(TablesColumnFile.reportingUser);
      ageValidation = prefs.getString(TablesColumnFile.GUARANTORAGEVALIDATION);
    });

     try {
      guarantorobj.mapplicanttype =
          prefs.getInt("${TablesColumnFile.GUARANTORAPPLICANTTYPE}");
          print(" guarantorobj.mapplicanttype  ${ guarantorobj.mapplicanttype}");
    }catch(_){
      print("Yhan fat");
    }

  try{
      List ageValidList =  ageValidation.split("~");
      minAge = int.parse(ageValidList[0]);
      maxAge = int.parse(ageValidList[1]);
  }catch(_){

  }


  }
  Widget isExistingCustomer() => AddGuarantor._get(new Row(
    children: _makeRadios(2, globals.radioCaptionValuesIsExistingCustomer, 0),
    mainAxisAlignment: MainAxisAlignment.spaceAround,
  ));

  List<Widget> _makeRadios(int numberOfRadios, List textName, int position) {
    List<Widget> radios = new List<Widget>();
    for (int i = 0; i < numberOfRadios; i++) {
      radios.add(new Row(
        children: <Widget>[
          new Text(
            textName[i],
            textAlign: TextAlign.right,
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontStyle: FontStyle.normal,
              fontSize: 10.0,
            ),
          ),
          new Radio(
            value: i,
            groupValue: globals.isExistingCustomerYN[position],
            onChanged: (selection) => _onRadioSelected(selection, position),

            activeColor: Color(0xff07426A),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
      ));
    }
    return radios;
  }
  _onRadioSelected(int selection, int position) {
    isDedupDone =false;
    setState(() => globals.isExistingCustomerYN[position] = selection);
    if (position == 0) {
      globals.existingCustomer=
      globals.radioCaptionValuesIsExistingCustomer[selection];
      if(globals.existingCustomer=='Yes'){
        isExistingCustomerY=true;
      }else{
        isExistingCustomerY=false;
        guarantorobj.mcustno=null;
       // guarantorobj = new GuarantorDetailsBean();
      }
      guarantorobj.mexistingcustyn=selection.toString();
      /*   if (globals.existingCustomer == 'Yes') {
        globals.isExistingCustomerY = true;
      } else {
        globals.isExistingCustomerY= false;
      }*/
    }

    if(isExistingCustomerY==false){

      AgeNotPresent=true;
        GrntrNameNotPresent=true;
        Add1NotPresent=true;
         Add2NotPresent=true;
        NationalIDNotPresent=true;
        MobileNotPresent=true;
        applicantDobNotPresent = true;
        stateCdPresent=false;
        villageCdPresent=false;
        townShipPresent=false;  
        wardNoPresent = false;
    }
  }


  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        Translations.of(context).text('Are_You_Sure'),
        Translations.of(context).text('Do_You_Want_To_Go_To_Guarantor_List_Without_Saving_Data'),
        "");
  }

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        //textDirection: TextDirection,
        textAlign: TextAlign.start,
        /*overflow: TextOverflow.ellipsis,*/
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
      ),
    );
  }


  Future getImage(imageNo) async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        //ratioX: 1.0,
        //ratioY: 1.5,
        maxWidth: 640,
        maxHeight: 640,
      );
      File newImage = await croppedFile.copy(image.path);
      try {
        croppedFile.delete();
      } catch (_) {}

      if (imageNo == 0) guarantorobj.mfacecapture = newImage.path;
      if (imageNo == 1) guarantorobj.mnrcphoto = newImage.path;
      if (imageNo == 2) guarantorobj.mnrcsecphoto = newImage.path;
      if (imageNo == 3) guarantorobj.mhouseholdphoto = newImage.path;
      if (imageNo == 4) guarantorobj.mhouseholdsecphoto = newImage.path;
      if (imageNo == 5 && newImage.path != null && newImage.path != "")
        guarantorobj.maddressphoto = newImage.path;

      //f = File(croppedFile.path);

      setState(() {
        _image = croppedFile;
      });
    } catch (_) {}
  }

  Future getImageFromGallery(int imageNo) async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        //ratioX: 1.0,
        //ratioY: 1.5,
        maxWidth: 640,
        maxHeight: 640,
      );

      File newImage = await croppedFile.copy(image.path);
      try {
        croppedFile.delete();
      } catch (_) {}
      if (imageNo == 0) guarantorobj.mfacecapture = newImage.path;
      if (imageNo == 1) guarantorobj.mnrcphoto = newImage.path;
      if (imageNo == 2) guarantorobj.mnrcsecphoto = newImage.path;
      if (imageNo == 3) guarantorobj.mhouseholdphoto = newImage.path;
      if (imageNo == 4) guarantorobj.mhouseholdsecphoto = newImage.path;
      if (imageNo == 5) guarantorobj.maddressphoto = newImage.path;

      setState(() {
        _image = newImage;
      });
    } catch (_) {}
  }

  // Future<void> _PickImage(int imageNo) async {
  //   return showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: new Icon(
  //             Icons.touch_app,
  //             color: Colors.blue[800],
  //             size: 40.0,
  //           ),
  //           content: SingleChildScrollView(
  //             padding: const EdgeInsets.all(12.0),
  //             child: Column(
  //               children: <Widget>[

  //                 Card(
  //                   child: new ListTile(
  //                       title: new Text(('Take Picture From Camera')),
  //                       onTap: () {

  //                         Navigator.of(context).pop();
  //                         getImage(imageNo);

  //                       }),),

  //                 Card(
  //                   child: new ListTile(
  //                       title: new Text(('Choose From Gallery')),
  //                       onTap: () {

  //                         Navigator.of(context).pop();
  //                         getImageFromGallery(imageNo);

  //                       }),),


  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }


  Future<void> _PickImage(int imageNo) async {
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
                          getImageFromGallery(imageNo);

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
                          getImage(imageNo);

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
                    globals.sessionTimeOut.SessionTimedOut();
                  callDialog();

                }
            ),
            backgroundColor: Color(0xff07426A),
            brightness: Brightness.light,
            title: new Text(
              Translations.of(context).text('Guarantor_Details'),
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
                  color:widget.laonLimitPassedObject!=null&&widget.laonLimitPassedObject.mleadstatus==1? Colors.white:Colors.grey,
                  size: 40.0,
                ),
                onPressed: () async{
		globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();

                  if(widget.laonLimitPassedObject!=null&&widget.laonLimitPassedObject.mleadstatus==1){

                    // bool IsValidated = await dedupGuarantor();
                    // if(IsValidated == true){
                        proceed();
                    //}
                    
                  }else{
                    print(widget.laonLimitPassedObject.mleadstatus);
                      _showAlert(Translations.of(context).text('modifyrightalert'), Translations.of(context).text('modificationNotallowedafterSendforapproval'));

                  }
                  
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
                new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    Translations.of(context)
                        .text('Personal Information'),
                    style: TextStyle(
                        color: Colors.blue, fontSize: 20.0),
                  ),
                ),
                Card(
                  color: Constant.mandatoryColor,
                  child: new ListTile(
                      title: new Text(Translations.of(context).text('Leads_Id_Leads_Refno')),
                      subtitle: guarantorobj.mleadsid == null
                          ? new Text("")
                          : new Text(
                      "${guarantorobj.mloantrefno == null? "0" : guarantorobj.mloantrefno}"
                  "/${guarantorobj.mloanmrefno == null? "0" : guarantorobj.mloanmrefno}"
                  "/${guarantorobj.mleadsid == null||guarantorobj.mleadsid.trim()=="null" ? "0" : guarantorobj.mleadsid}"),

                  ),
                ),
                new Table(children: [
                  new TableRow(
                      decoration: new BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.1),
                      ),
                      children: [
                        getTextContainer(globals.radioCaptionIsExistingCustomer[0]),
                        isExistingCustomer(),
                      ]),
                ]),
                isExistingCustomerY?
                //     ? Card(
                //   color: Constant.mandatoryColor,
                //   child: new ListTile(
                //       title: new Text(Translations.of(context).text('CUSTOMERNUMBER')),
                //       subtitle: guarantorobj.mcustno == null
                //           ? new Text("")
                //           : new Text(
                //           "${guarantorobj.mcustno != null && guarantorobj.mcustno.toString() != null && guarantorobj.mcustno.toString() != 'null' ? guarantorobj.mcustno : ""}"),
                //       onTap: () => getCustomerId()),
                // )
                  new Container(child:new Stack(
                                alignment: const Alignment(0.8, 0.0),
                                children: <Widget>[
                                  new TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration:  InputDecoration(
                                      hintText: Translations.of(context).text('CustNo'),
                                      labelText: Translations.of(context).text('CustNo'),
                                      hintStyle:
                                      TextStyle(color: Colors.grey),
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          )),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue,
                                          )),
                                      contentPadding: EdgeInsets.all(20.0),
                                    ),
                                    controller:guarantorobj.mcustno == null
                                        ? TextEditingController(text: "")
                                        : TextEditingController(
                                        text: guarantorobj.mcustno.toString()),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                      //globals.onlyIntNumber
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    validator: (String arg) {
                                     
                                     if (RegExp(
                                          r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]')
                                          .hasMatch(arg)) {
                                        return "no special character allowed";
                                      } else if (RegExp(r'[a-zA-Z-]')
                                          .hasMatch(arg)) {
                                        return "Characters not allowed";
                                      } else
                                        return null;
                                    },
                                    onSaved: (val) {
                                      if (val == null || val == "") {
                                      } else
                                        try {
                                          guarantorobj.mcustno = int.parse(val);
                                          isDedupDone=false;
                                        } catch (e) {
                                          print("val");
                                        }
                                    },
                                  ),
                                  new Container(
                                      child: circIndicator == true
                                          ? CircularProgressIndicator()
                                          : new RaisedButton(
                                        color: Color(0xff01579b),
                                        elevation: 20.0,
                                        child: new Text(
                                         Translations.of(context).text('check'),
                                          style: TextStyle(
                                              color:
                                              Colors.white),
                                        ),
                                        padding: EdgeInsets.only(
                                            bottom: 0.0),
                                        onPressed: () async {
                                          circIndicator= true;
                                          await getCustomerId();

                                        },
                                      )),
                                ],
                              )): Container(),

                //TODO

                //Face Photo Capture
                new Text(
                  Translations.of(context).text("Face Photo Capture"),
                  textAlign: TextAlign.center,
                ),
                new Container(
                    color: Constant.mandatoryColor,
                    height: 330.0,
                    child: new Column(
                      children: <Widget>[


                        new Center(
                          child: new Stack(
                            children: <Widget>[
                              getCircleContainer(guarantorobj.mfacecapture != null && 
                              guarantorobj.mfacecapture != ""
                                  ?guarantorobj.mfacecapture:"",0),
                              new Positioned(
                                child: new GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _PickImage(0);
                            },
                                  child:IconButton(icon: new Icon(Icons.camera_alt, color: Color(0xff07426A),size:  50.0,),
                                  ),
                                ),
                                top: 150.0,
                        left: 200.0,
                              ),
                            ],
                          ),
                        ),
                        Container(
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  height: 80.0, width: 60.00),
                            )),
                      ],
                    )),
                     Container(
                  decoration: BoxDecoration(color: Constant.mandatoryColor),
                  child: new Row(

                    children: <Widget>[Text(Constant.dateOfBirth)],
                  ),
                ),

                new Container(
                  decoration: BoxDecoration(color: Constant.mandatoryColor,),



                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: 50.0,
                        child: new TextField(
                            decoration:
                            InputDecoration(
                              enabled: applicantDobNotPresent==true?true:false,
                                hintText: Translations.of(context).text('DD')
                            ),
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(2),
                              globals.onlyIntNumber
                            ],
                            controller: tempDay == null?null:new TextEditingController(text: tempDay),
                            keyboardType: TextInputType.numberWithOptions(),

                            onChanged: (val){

                              if(val!="0"){
                                tempDay = val;


                                if(int.parse(val)<=31&&int.parse(val)>0){



                                  if(val.length==2){
                                    applicantDob = applicantDob.replaceRange(0, 2, val);
                                    FocusScope.of(context).requestFocus(monthFocus);
                                  }
                                  else{
                                    applicantDob = applicantDob.replaceRange(0, 2, "0"+val);
                                  }
                                }
                                else {
                                  setState(() {
                                    tempDay ="";
                                  });
                                }
                              }
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text("/"),
                      ),
                      new Container(
                        width: 50.0,
                        child: new TextField(
                          decoration: InputDecoration(
                            enabled: applicantDobNotPresent==true?true:false,
                            hintText: Translations.of(context).text('MM'),
                          ),
                          keyboardType: TextInputType.numberWithOptions(),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(2),
                            globals.onlyIntNumber
                          ],
                          focusNode: monthFocus,
                          controller: tempMonth == null?null:new TextEditingController(text: tempMonth),
                          onChanged: (val){
                            if(val!="0"){
                              tempMonth = val;
                              if(int.parse(val)<=12&&int.parse(val)>0){

                                if(val.length==2){
                                  applicantDob = applicantDob.replaceRange(3, 5, val);
                                  FocusScope.of(context).requestFocus(yearFocus);
                                }
                                else{
                                  applicantDob = applicantDob.replaceRange(3, 5, "0"+val);
                                }
                              }
                              else {
                                setState(() {
                                  tempMonth ="";
                                });
                              }
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text("/"),
                      ),
                      Container(
                        width:80,
                        child:new TextField(
                          decoration: InputDecoration(
                            enabled: applicantDobNotPresent==true?true:false,
                            hintText: Translations.of(context).text('YYYY'),
                          ),
                          keyboardType: TextInputType.numberWithOptions(),
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(4),
                            globals.onlyIntNumber
                          ],
                          focusNode: yearFocus,
                          controller: tempYear == null?null:new TextEditingController(text: tempYear),
                          onChanged: (val){
                            tempYear = val;
                            if(val.length==4) applicantDob = applicantDob.replaceRange(6, 10,val);
                          },
                        ),),
                      SizedBox(
                        width: 50.0,
                      ),
                      IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                        if(applicantDobNotPresent){
                          _selectDate(context);
                        }
                        
                      })
                    ],
                  ),
                ),
                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child:  new IgnorePointer(
                      ignoring: isExistingCustomerY==true?true:false,
                                          child: new DropdownButtonFormField(
                        value: NationalId,
                        items: generateDropDown(0),
                        onChanged: (LookupBeanData newValue) {
                          showDropDown(newValue, 0);
                        },
                        decoration: InputDecoration(labelText: Translations.of(context).text('National_ID_Type')),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: id1Mand==true? Constant.mandatoryColor: Colors.white,
                  child: new Stack(
                    
                                alignment: const Alignment(0.8, 0.0),
                                children: <Widget>[
                                       new TextFormField(
                      keyboardType: TextInputType.text,
                      
                    
                      decoration:  InputDecoration(
                        //enabled: isExistingCustomerY==true?false:true,
                        hintText: Translations.of(context).text('Enter_National_ID_Here'),
                        labelText: Translations.of(context).text('National_ID'),
                        hintStyle: TextStyle(color: Colors.grey),
                        /*labelStyle: TextStyle(color: Colors.grey),*/
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            )),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      enabled:
                      NationalIDNotPresent
                          ? true
                          : false,
                      //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],
                      controller:guarantorobj.mnationaliddesc == null
                          ? TextEditingController(text: "")
                          : TextEditingController(
                          text: guarantorobj.mnationaliddesc)
                 ,
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(30),
                      ],
                      onSaved: (val) {
                        if(val!=null&&val!=""){
                          try{
                            guarantorobj.mnationaliddesc = (val);
                          }catch(e){

                          }
                        }

                      },
                    ),


                    new Container(
                                      child:isExistingCustomerY==true? new SizedBox():circNationIdIndicator == true
                                          ? CircularProgressIndicator()
                                          : new RaisedButton(
                                        color: Color(0xff01579b),
                                        elevation: 20.0,
                                        child: new Text(
                                         Translations.of(context).text('check'),
                                          style: TextStyle(
                                              color:
                                              Colors.white),
                                        ),
                                        padding: EdgeInsets.only(
                                            bottom: 0.0),
                                        onPressed: () async {
                                          setState(() {
                                          circNationIdIndicator= true;  
                                          });
                                          
                                          await _DedupOnNationalID();

                                        },
                                      )),
                    
                    ]
                  ),
                ),
                //NRC Photo Capture
                new Text(
                  Translations.of(context).text("NRC Photo Capture"),
                  textAlign: TextAlign.center,
                ),
                new Container(
                  padding: new EdgeInsets.all(8.0),
                  child: Text(
                    Translations.of(context).text('Click_Below_for_pic'),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Flexible(
                      child: new Column(
                        children: <Widget>[

                          new Center(
                            child: new Stack(
                              children: <Widget>[
                                getCircleContainer(guarantorobj.mnrcphoto != null && guarantorobj.mnrcphoto != ""
                                    ?guarantorobj.mnrcphoto:"",1),
                                new Positioned(
                                  child: new GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _PickImage(1);
                              },
                                    child:IconButton(icon: new Icon(Icons.camera_alt, color: Color(0xff07426A),size: 50.0,),
                                    ),
                                  ),
                                  top: 140,
                                left: 150,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Flexible(
                      child: new Column(
                        children: <Widget>[

                          new Center(
                            child: new Stack(
                              children: <Widget>[
                                getCircleContainer(guarantorobj.mnrcsecphoto != null && guarantorobj.mnrcsecphoto != ""
                                    ?guarantorobj.mnrcsecphoto:"",2),
                                new Positioned(
                                  child: new GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _PickImage(2);
                              },
                                    child:IconButton(icon: new Icon(Icons.camera_alt, color: Color(0xff07426A),size: 50,),
                                    ),
                                  ),
                                 top: 140,
                                left: 150,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          new IgnorePointer(
            ignoring: true,

            child:new Card(
                  child:Container(
                    //color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: new DropdownButtonFormField(
                      value: ApplicantType,
                      items: generateDropDown(1),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 1);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('Applicant_Type')),
                    ),
                  ),
                ),
          ),


                Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Full_Name'),
                      labelText: Translations.of(context).text('Full_Name'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    enabled:
                    GrntrNameNotPresent
                        ? true
                        : false,
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],
                    controller:guarantorobj.mnameofguar == null
                ? TextEditingController(text: "")
                 : TextEditingController(
                text: guarantorobj.mnameofguar)
                    ,onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.mnameofguar = (val);
                        }catch(e){

                        }
                      }

                    },
                  ),
                ),

                Container(
                  child: new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Mother_Maiden_Name'),
                      labelText: Translations.of(context).text('Mother_Maiden_Name'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],
                    controller:guarantorobj.mmothermaidenname == "null"
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mmothermaidenname)
                    ,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50),
                    ],

                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.mmothermaidenname = (val);
                        }catch(e){

                        }
                      }

                    },
                  ),
                ),
                isFullerTon==0?
                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: new DropdownButtonFormField(
                      value: Gender,
                      items: generateDropDown(2),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 2);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('Gender')),
                    ),
                  ),
                ):new  Container(),
                SizedBox(height: 20.0,),
                // Container(
                //   decoration: BoxDecoration(color: Constant.mandatoryColor),
                //   child: new Row(

                //     children: <Widget>[Text(Constant.dateOfBirth)],
                //   ),
                // ),

                // new Container(
                //   decoration: BoxDecoration(color: Constant.mandatoryColor,),



                //   child: new Row(
                //     children: <Widget>[
                //       new Container(
                //         width: 50.0,
                //         child: new TextField(
                //             decoration:
                //             InputDecoration(
                //               enabled: applicantDobNotPresent==true?true:false,
                //                 hintText: Translations.of(context).text('DD')
                //             ),
                //             inputFormatters: [
                //               new LengthLimitingTextInputFormatter(2),
                //               globals.onlyIntNumber
                //             ],
                //             controller: tempDay == null?null:new TextEditingController(text: tempDay),
                //             keyboardType: TextInputType.numberWithOptions(),

                //             onChanged: (val){

                //               if(val!="0"){
                //                 tempDay = val;


                //                 if(int.parse(val)<=31&&int.parse(val)>0){



                //                   if(val.length==2){
                //                     applicantDob = applicantDob.replaceRange(0, 2, val);
                //                     FocusScope.of(context).requestFocus(monthFocus);
                //                   }
                //                   else{
                //                     applicantDob = applicantDob.replaceRange(0, 2, "0"+val);
                //                   }
                //                 }
                //                 else {
                //                   setState(() {
                //                     tempDay ="";
                //                   });
                //                 }
                //               }
                //             }
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: new Text("/"),
                //       ),
                //       new Container(
                //         width: 50.0,
                //         child: new TextField(
                //           decoration: InputDecoration(
                //             enabled: applicantDobNotPresent==true?true:false,
                //             hintText: Translations.of(context).text('MM'),
                //           ),
                //           keyboardType: TextInputType.numberWithOptions(),
                //           inputFormatters: [
                //             new LengthLimitingTextInputFormatter(2),
                //             globals.onlyIntNumber
                //           ],
                //           focusNode: monthFocus,
                //           controller: tempMonth == null?null:new TextEditingController(text: tempMonth),
                //           onChanged: (val){
                //             if(val!="0"){
                //               tempMonth = val;
                //               if(int.parse(val)<=12&&int.parse(val)>0){

                //                 if(val.length==2){
                //                   applicantDob = applicantDob.replaceRange(3, 5, val);
                //                   FocusScope.of(context).requestFocus(yearFocus);
                //                 }
                //                 else{
                //                   applicantDob = applicantDob.replaceRange(3, 5, "0"+val);
                //                 }
                //               }
                //               else {
                //                 setState(() {
                //                   tempMonth ="";
                //                 });
                //               }
                //             }
                //           },
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: new Text("/"),
                //       ),
                //       Container(
                //         width:80,
                //         child:new TextField(
                //           decoration: InputDecoration(
                //             enabled: applicantDobNotPresent==true?true:false,
                //             hintText: Translations.of(context).text('YYYY'),
                //           ),
                //           keyboardType: TextInputType.numberWithOptions(),
                //           inputFormatters: [
                //             new LengthLimitingTextInputFormatter(4),
                //             globals.onlyIntNumber
                //           ],
                //           focusNode: yearFocus,
                //           controller: tempYear == null?null:new TextEditingController(text: tempYear),
                //           onChanged: (val){
                //             tempYear = val;
                //             if(val.length==4) applicantDob = applicantDob.replaceRange(6, 10,val);
                //           },
                //         ),),
                //       SizedBox(
                //         width: 50.0,
                //       ),
                //       IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                //         if(applicantDobNotPresent){
                //           _selectDate(context);
                //         }
                        
                //       })
                //     ],
                //   ),
                // ),
                isFullerTon==0?
                new TextFormField(
                  decoration:  InputDecoration(
                    hintText: Translations.of(context).text('Enter_Age_Here'),
                    labelText: Translations.of(context).text('Age'),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  enabled:
                  AgeNotPresent
                      ? true
                      : false,
                  controller: guarantorobj.mage != null&&guarantorobj.mage != 0
                      ? TextEditingController(text:guarantorobj.mage.toString())
                      : TextEditingController(text:""),
                  keyboardType: TextInputType.number,
                  inputFormatters: [new LengthLimitingTextInputFormatter(2),globals.onlyIntNumber],
                  onSaved: (val) {
                    if(val!=null&&val!="") {
                      // globals.age = int.parse(val);
                      /*CustomerFormationMasterTabsState.custListBean
                           .familyDetailsList.last.age =  int.parse(val);*/
                      try{
                       guarantorobj.mage = int.parse(val);
                      }catch(e){

                      }

                    }
                    else{
                      // globals.age = 0;
                      /*CustomerFormationMasterTabsState.custListBean
                           .familyDetailsList.last.age =0;*/
                     guarantorobj.mage = 0;
                    }

                    //}
                  },
                ) : new  Container(),

                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: new IgnorePointer(
                      ignoring: isExistingCustomerY==true?true:false,
                                          child: new DropdownButtonFormField(
                        value: maritalstatus,
                        items: generateDropDown(7),
                        onChanged: (LookupBeanData newValue) {
                          showDropDown(newValue, 7);
                        },
                        validator: (args) {
                          print(args);
                        },
                        decoration: InputDecoration(labelText: Translations.of(context).text('maritalStatus')),
                      ),
                    ),
                  ),
                ),
                Container(
                    color: spouseNameMand==true? Constant.mandatoryColor: Colors.white,
                    child:
                    new TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: Translations.of(context).text('enterSpouseNameHere'),
                          labelText: Translations.of(context).text('spouseName'),
                          hintStyle: TextStyle(color: Colors.grey),
                          /*labelStyle: TextStyle(color: Colors.black),*/
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                          contentPadding: EdgeInsets.all(20.0),
                        ),
            /*            inputFormatters: [
                          new LengthLimitingTextInputFormatter(50),
                        ],
                        initialValue: guarantorobj.mspousename == null || guarantorobj.mspousename == "null"
                            ? ""
                            : "${guarantorobj.mspousename}",
                        onSaved: (String value) {
                          if(value.isNotEmpty && value!="" && value!=null && value!='null'){
                            guarantorobj.mspousename = value;
                          }
                        }



            */            controller:guarantorobj.mspousename == null
                    ? TextEditingController(text: "")
                        : TextEditingController(
                    text: guarantorobj.mspousename),
          inputFormatters: [new LengthLimitingTextInputFormatter(50),],
          onSaved: (val) {
            if(val!=null&&val!=""){
              try{
                guarantorobj.mspousename= (val);
              }catch(e){

              }
            }

          },
                    )
                ),
                //Household list photo capture
                new Text(
                  Translations.of(context).text("Household list photo capture"),
                  textAlign: TextAlign.center,
                ),
                new Container(
                  padding: new EdgeInsets.all(8.0),
                  child: Text(
                    Translations.of(context).text('Click_Below_for_pic'),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Flexible(
                      child: new Column(
                        children: <Widget>[

                          new Center(
                            child: new Stack(
                              children: <Widget>[
                                getCircleContainer(guarantorobj.mhouseholdphoto != null && guarantorobj.mhouseholdphoto != ""
                                    ?guarantorobj.mhouseholdphoto:"",3),
                                new Positioned(
                                  child: new GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _PickImage(3);
                              },
                                    child:IconButton(icon: new Icon(Icons.camera_alt, color: Color(0xff07426A),size: 50.0,),
                                    ),
                                  ),
                                   top: 140,
                                left: 150,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Flexible(
                      child: new Column(
                        children: <Widget>[

                          new Center(
                            child: new Stack(
                              children: <Widget>[
                                getCircleContainer(guarantorobj.mhouseholdsecphoto != null && guarantorobj.mhouseholdsecphoto != ""
                                    ?guarantorobj.mhouseholdsecphoto:"",4),
                                new Positioned(
                                  child: new GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _PickImage(4);
                              },
                                    child:IconButton(icon: new Icon(Icons.camera_alt, color: Color(0xff07426A),size: 50.0,),
                                    ),
                                  ),
                                  top: 140,
                                left: 150,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Address_Line_1'),
                      labelText: Translations.of(context).text('Address_Line_1'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    enabled:
                    Add1NotPresent
                        ? true
                        : false,
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],

    controller:guarantorobj.maddress == null
    ? TextEditingController(text: "")
        : TextEditingController(
    text: guarantorobj.maddress),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(120),
                    ],
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.maddress= (val);
                        }catch(e){

                        }
                      }

                    },
                  ),
                ),

                Container(
                  child: new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Address_Line_2'),
                      labelText: Translations.of(context).text('Address_Line_2'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    enabled:
                    Add2NotPresent
                        ? true
                        : false,
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],

                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50),
                    ],
                    controller:guarantorobj.maddress2 == "null"
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.maddress2),
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.maddress2= (val);
                        }catch(e){

                        }
                      }

                    },
                  ),
                ),
                Container(
                    child: new TextFormField(
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('entrAddLine3'),
                        labelText: Translations.of(context).text('addLin3'),
                        hintStyle: TextStyle(color: Colors.grey),
                        /*labelStyle: TextStyle(color: Colors.grey),*/
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff5c6bc0),
                            )),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      controller: guarantorobj.maddress3 != null
                          ? TextEditingController(text: guarantorobj.maddress3)
                          : TextEditingController(text: ""),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50)/*,
                    globals.onlyCharacter*/
                      ],
                      onSaved: (val) {
                        //  if(val!=null) {
                        guarantorobj.maddress3 = val;
                        // }
                      },
                    )
                  ),
                //Current Address (Region/ State & Township & Town/Village Tract & Ward/Village)
                Container(
                  color: Constant.semiMandatoryColor,
                  child: new ListTile(
                    title: new Text(Translations.of(context).text("RegionState")),
                    subtitle:
                    guarantorobj.mstatecd == null || guarantorobj.mstatecd == "null"
                        ? new Text("")
                        : new Text("${guarantorobj.mstatecd} ${guarantorobj.mstatecddesc==null||guarantorobj.mstatecddesc=="null"?"":guarantorobj.mstatecddesc}"),
                    onTap: () async {
                      if(stateCdPresent==true)return;

                      tempStateBean = await
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) => _myStateDialog,
                            fullscreenDialog: true,
                          ));

                      if(tempStateBean!=null){
                        guarantorobj.mstatecd = tempStateBean.stateCd;
                        guarantorobj.mstatecddesc  = tempStateBean.stateDesc;
                      }
                      setState(() {

                      });
                    },
                  ),
                ),
                new Divider(),
                Container(
                  color: Constant.semiMandatoryColor,
                  child: new ListTile(
                    title: new Text(Translations.of(context).text('Township')),
                    subtitle:
                    guarantorobj.mtownship == null || guarantorobj.mtownship == "null"
                        ? new Text("")
                        : new Text("${guarantorobj.mtownship} ${guarantorobj.mtownshipdesc==null||guarantorobj.mtownshipdesc=="null"?"":guarantorobj.mtownshipdesc}"),
                    onTap: () async  {

                        if(townShipPresent==true)return;
                      tempDistrictBean =  await
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) => _myDistrictDialog,
                            fullscreenDialog: true,
                          ));


                      if(tempDistrictBean!=null){
                        try{
                          guarantorobj.mtownship = tempDistrictBean.distCd.toString();
                          guarantorobj.mtownshipdesc = tempDistrictBean.distDesc;
                        }catch(e){
                          print("District code exception");
                        }
                      }
                    },
                  ),
                ),
                new Divider(),
                Container(
                  color: Constant.semiMandatoryColor,
                  child: new ListTile(
                    title: new Text(Translations.of(context).text('TownVillage Tract')),
                    subtitle: guarantorobj.mvillage == null ||
                        guarantorobj.mvillage == "null"
                        ? new Text("")
                        : new Text("${guarantorobj.mvillage} ${guarantorobj.mvillagedesc==null||guarantorobj.mvillagedesc=="null"?"":guarantorobj.mvillagedesc}"),
                    onTap: () async{

                        if(villageCdPresent==true)return;

                      tempSubDistrictBean = await
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            _mySubDistrictDialog,
                            fullscreenDialog: true,
                          ));

                      if(tempSubDistrictBean!=null){
                        guarantorobj.mvillage= int.parse(tempSubDistrictBean.placeCd);
                        guarantorobj.mvillagedesc = tempSubDistrictBean.placeCdDesc;
                      }
                    },
                  ),
                ),
                new Divider(),
                Container(
                  color: Constant.semiMandatoryColor,
                  child: new ListTile(
                    title: new Text(Translations.of(context).text('WardVillage')),
                    subtitle:
                     guarantorobj.mwardno == "null" || guarantorobj.mwardno == null
                        ? new Text("")
                        : new Text("${guarantorobj.mwardno} ${guarantorobj.mwardnodesc==null||guarantorobj.mwardnodesc=="null"?"":guarantorobj.mwardnodesc}"),
                    onTap: () async {
                        if(wardNoPresent==true)return;

                      tempAreaDistrict = await

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) => _myAreaDialog,
                            fullscreenDialog: true,
                          ));

                      if(tempAreaDistrict!=null){
                        try{
                          guarantorobj.mwardno= tempAreaDistrict.areaCd.toString() ;
                          guarantorobj.mwardnodesc = tempAreaDistrict.areaDesc;
                        }catch(e){
                          print("area code exception");
                        }
                      }
                    },
                  ),
                ),
                new Divider(),

                isFullerTon==0?
                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: new DropdownButtonFormField(
                      value: HouseType,
                      items: generateDropDown(4),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 4);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('House_Type')),
                    ),
                  ),
                ) : new  Container(),
                Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Mobile_Number_Here'),
                      labelText: Translations.of(context).text('Mobile_Number'),
                      prefixText: "+"+dialCode,
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    enabled:
                    MobileNotPresent
                        ? true
                        : false,
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],

                    controller:guarantorobj.mmobile == "null"
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mmobile),
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.mmobile= (val);
                        }catch(e){

                        }
                      }

                    },
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(isFullerTon==0?10:11),
                      globals.onlyIntNumber
                    ],

                  ),
                ),


                Container(
                  child: new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Phone_Number_Here'),
                      labelText: Translations.of(context).text('Phone_Number'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],

                    controller:guarantorobj.mphone == "null"
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mphone),
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.mphone= (val);
                        }catch(e){

                        }
                      }

                    },
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(15),
                      globals.onlyIntNumber
                    ],
                  ),
                ),
                //Address Proof Photo Capture & Address Proof Photo Capture
                new Text(
                  Translations.of(context).text("Address Proof Photo Capture"),
                  textAlign: TextAlign.center,
                ),
                new Container(
                  padding: new EdgeInsets.all(8.0),
                  child: Text(
                    Translations.of(context).text('Click_Below_for_pic'),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Flexible(
                      child: new Column(
                        children: <Widget>[

                          new Center(
                            child: new Stack(
                              children: <Widget>[
                                getCircleContainer(guarantorobj.maddressphoto != null && guarantorobj.maddressphoto != ""
                                    ?guarantorobj.maddressphoto:"",5),
                                new Positioned(
                                  child: new GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                              onTap: () {
                                _PickImage(5);
                              },
                                    child:IconButton(icon: new Icon(Icons.camera_alt, color: Color(0xff07426A),size: 50.0,),
                                    ),
                                  ),
                                  top: 140,
                                left: 150,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                new Card(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Text(
                        Translations.of(context).text('Guarantor_Sign'),
                        textAlign: TextAlign.center,
                      ),

                      new Container(
                          height: 250.0,
                          child: new Column(
                            children: <Widget>[
                              new ListTile(
                                title:
                                guarantorobj.msignature != null && guarantorobj.msignature != ""&&guarantorobj.msignature.trim()
                                    != "null"
                                    ? new ListTile(
                                  title: new Image.memory(
                                    Base64Decoder().convert(guarantorobj.msignature),
                                    height: 200.0,
                                    width: 200.0,
                                  ),
                                  subtitle: new Text(
                                    Translations.of(context).text('Click_for_Digi_sign'),
                                    textAlign: TextAlign.center,
                                  ),
                                  onTap: () {
                                    _navigateAndDisplaySignatureSelection(
                                        context, 'guarantor');
                                  },
                                )
                                    : new ListTile(
                                  title: new Image(
                                      image: new AssetImage(
                                          "assets/signature.png"),
                                      height: 200.0),
                                  subtitle: new Text(
                                    Translations.of(context).text('Click_for_Digi_sign'),
                                    textAlign: TextAlign.center,
                                  ),
                                  onTap: () {
                                    _navigateAndDisplaySignatureSelection(
                                        context, 'guarantor');
                                  },
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  elevation: 5.0,
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    Translations.of(context)
                        .text('Guarantors Business Information'),
                    style: TextStyle(
                        color: Colors.blue, fontSize: 20.0),
                  ),
                ),
                Container(
                    child: new TextFormField(
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('Business Name'),
                        labelText: Translations.of(context).text('Business Name'),
                        hintStyle: TextStyle(color: Colors.grey),
                        /*labelStyle: TextStyle(color: Colors.grey),*/
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff5c6bc0),
                            )),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      controller: guarantorobj.mbusinessname != null
                          ? TextEditingController(text: guarantorobj.mbusinessname)
                          : TextEditingController(text: ""),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50)/*,
                    globals.onlyCharacter*/
                      ],
                      onSaved: (val) {
                        //  if(val!=null) {
                        guarantorobj.mbusinessname = val;
                        // }
                      },
                    )
                ),
                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: new DropdownButtonFormField(
                      value: buspropownership,
                      items: generateDropDown(8),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 8);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('Ownership of the Business Property')),
                    ),
                  ),
                ),
                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: new DropdownButtonFormField(
                      value: busownership,
                      items: generateDropDown(9),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 9);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('Ownership of the Business')),
                    ),
                  ),
                ),
                Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration:  InputDecoration(
                      hintText: Translations.of(context).text('Value of total business asset'),
                      labelText: Translations.of(context).text('Value of total business asset'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff07426A),
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    controller:guarantorobj.mbustoaassetval == null
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mbustoaassetval.toString()),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                      globals.onlyDoubleNumber
                    ],
                    onSaved: (val) {
                      if (val != null && val != "") {
                        try {
                          guarantorobj.mbustoaassetval =
                              double.parse(val);
                        }catch(_){}
                      }
                    },
                  ),
                ),
                Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration:  InputDecoration(
                      hintText: Translations.of(context).text('Length of Business Year'),
                      labelText: Translations.of(context).text('Length of Business Year'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.black),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff07426A),
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    controller:guarantorobj.mbusleninyears == null
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mbusleninyears.toString()),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(100),
                      globals.onlyAphaNumeric
                    ],
                    onSaved: (val) {
                      if (val != null && val != "") {
                        try{
                          guarantorobj.mbusleninyears= (val);
                        }catch(e){

                        }
                      }

                    },
                  ),
                ),
                Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration:  InputDecoration(
                      hintText: Translations.of(context).text('Monthly Expense of Business'),
                      labelText: Translations.of(context).text('Monthly Expense of Business'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.black),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff07426A),
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    controller:guarantorobj.mbusmonexpense == null
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mbusmonexpense.toString()),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                      globals.onlyDoubleNumber
                    ],
                    onSaved: (val) {
                      if (val != null && val != "") {
                        guarantorobj.mbusmonexpense =
                            double.parse(val);
                      }
                    },
                  ),
                ),
                Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration:  InputDecoration(
                      hintText: Translations.of(context).text('Monthly Net Profit of the Business'),
                      labelText: Translations.of(context).text('Monthly Net Profit of the Business'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.black),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff07426A),
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    controller:guarantorobj.mbusmonhlynetprof == null
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mbusmonhlynetprof.toString()),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                      globals.onlyDoubleNumber
                    ],
                    onSaved: (val) {
                      if (val != null && val != "") {
                        guarantorobj.mbusmonhlynetprof =
                            double.parse(val);
                      }
                    },
                  ),
                ),
                isFullerTon==0?
                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: new DropdownButtonFormField(
                      value: OccupationType,
                      items: generateDropDown(5),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 5);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('Occupation_Type')),
                    ),
                  ),
                ):new  Container(),

                isFullerTon==0?
                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 12.0),
                    child: new DropdownButtonFormField(
                      value: MainOccupation,
                      items: generateDropDown(6),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 6);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('Main_Occupation')),
                    ),
                  ),
                ):new  Container(),

                isFullerTon==0?
                Container(
                  child: new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Promissory_Note_No'),
                      labelText: Translations.of(context).text('Promissory_Note_No'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],

                    controller:guarantorobj.mpromissorynote == "null"
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mpromissorynote),

                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50),
                    ],

                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.mpromissorynote= (val);
                        }catch(e){

                        }
                      }

                    },
                  ),
                ):new  Container(),

                isFullerTon==0?
                Container(
                  child: new TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Work_Address'),
                      labelText: Translations.of(context).text('Work_Address'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],

                    controller:guarantorobj.mworkingaddress == "null"
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mworkingaddress),
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50),
                    ],
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.mworkingaddress= (val);
                        }catch(e){

                        }
                      }

                    },
                  ),
                ):new  Container(),

                isFullerTon==0?
                new TextFormField(
                  decoration:  InputDecoration(
                    hintText: Translations.of(context).text('Enter_Work_Experience_In_Years_Here'),
                    labelText: Translations.of(context).text('Work_Experience_In_Years'),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),

                  controller: guarantorobj.mworkexpinyrs != null&&guarantorobj.mworkexpinyrs != 0
                      ? TextEditingController(text:guarantorobj.mworkexpinyrs.toString())
                      : TextEditingController(text:""),
                  keyboardType: TextInputType.number,
                  inputFormatters: [new LengthLimitingTextInputFormatter(2),globals.onlyIntNumber],
                  onSaved: (val) {
                    if(val!=null&&val!="") {
                      // globals.age = int.parse(val);
                      /*CustomerFormationMasterTabsState.custListBean
                           .familyDetailsList.last.age =  int.parse(val);*/
                      try{
                        guarantorobj.mworkexpinyrs = int.parse(val);
                      }catch(e){

                      }

                    }
                    else{
                      // globals.age = 0;
                      /*CustomerFormationMasterTabsState.custListBean
                           .familyDetailsList.last.age =0;*/
                      guarantorobj.mworkexpinyrs = 0;
                    }

                    //}
                  },
                ):new  Container(),

                isFullerTon==0?
                Container(
                  child: new TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:  InputDecoration(

                      hintText: Translations.of(context).text('Enter_Work_Phone_No_Here'),
                      labelText: Translations.of(context).text('Work_Phone_No'),
                      hintStyle: TextStyle(color: Colors.grey),
                      /*labelStyle: TextStyle(color: Colors.grey),*/
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          )),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30),globals.onlyAphaNumeric],


                    controller:guarantorobj.mworkphoneno == "null"
                        ? TextEditingController(text: "")
                        : TextEditingController(
                        text: guarantorobj.mworkphoneno),
                    onSaved: (val) {
                      if(val!=null&&val!=""){
                        try{
                          guarantorobj.mworkphoneno= (val);
                        }catch(e){

                        }
                      }

                    },
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(15),
                      globals.onlyIntNumber
                    ],
                  ),
                ):new  Container(),

                      Container(
    color: Constant.mandatoryColor,
    child: new TextFormField(

                  decoration:  InputDecoration(
                    /*   icon: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),*/
                    hintText: Translations.of(context).text('Enter_Monthly_Income_Here'),
                    labelText: Translations.of(context).text('Monthly_Income'),
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller:guarantorobj.mmonthlyincome == null
                      ? TextEditingController(text: "")
                      : TextEditingController(
                      text: guarantorobj.mmonthlyincome.toString()),
                  /*  controller:
                      guarantorobj.mmonthlyincome != null
                          ? TextEditingController(
                              text: guarantorobj.mmonthlyincome
                                  .toString())
                          : TextEditingController(text: ""),*/
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(10),
                    globals.onlyDoubleNumber
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {


                    try {

                      guarantorobj.mmonthlyincome =    double.parse(val);

                    } catch (_) {}
                    /*
                    if (val != null && val != "") {
                      globals.income = double.parse(val);

                    } else {
                      //globals.income = 0.0;
                      guarantorobj.mmonthlyincome = null;
                    }
                    if (guarantorobj.mmonthlyincome !=null||guarantorobj.mmonthlyincome !=" "||guarantorobj.mmonthlyincome !="null" ) {



                      guarantorobj.mtotalincome = guarantorobj.mmonthlyincome;



                    }
                    // }*/
                  },
                ),
                      ),

                isFullerTon==0?
                Container(
                color: Constant.mandatoryColor,
                child: new TextFormField(
                    decoration:  InputDecoration(
                    /*   icon: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),*/
                    hintText: Translations.of(context).text('Enter_Income_From_Another_Source_Here'),
                    labelText: Translations.of(context).text('Income_From_Another_Source'),
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  controller:guarantorobj.mincomeothsources == null
                      ? TextEditingController(text: "")
                      : TextEditingController(
                      text: guarantorobj.mincomeothsources.toString()),
                  /*  controller:
                      guarantorobj.mincomeothsources != null
                          ? TextEditingController(
                              text: guarantorobj.mincomeothsources
                                  .toString())
                          : TextEditingController(text: ""),*/
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(10),
                    globals.onlyDoubleNumber
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    if (val != null && val != "") {
                      globals.income = double.parse(val);
                      guarantorobj.mincomeothsources =
                          double.parse(val);
                    } else {
                      //globals.income = 0.0;
                      guarantorobj.mincomeothsources = null;
                    }
                    if (guarantorobj.mincomeothsources !=null &&guarantorobj.mmonthlyincome !=null) {



                      guarantorobj.mtotalincome = guarantorobj.mmonthlyincome+guarantorobj.mincomeothsources;



                    }
                    else if(guarantorobj.mincomeothsources !=null ){
                      guarantorobj.mtotalincome =guarantorobj.mincomeothsources;

                    }
                    // }
                  },
                ),
                ) : new  Container(),

                isFullerTon==0?
                new Card(
                  child: new ListTile(
                    title: new Text(Translations.of(context).text('Total_Income')),
                    subtitle: guarantorobj.mtotalincome == null
                        ? new Text("")
                        : new Text("${guarantorobj.mtotalincome}"),
                  ),
                ): new  Container(),

              /*  new TextFormField(
                  decoration: const InputDecoration(
                    *//*   icon: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),*//*
                    hintText: 'Enter Total Income here',
                    labelText: 'Total Income',
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff07426A),
                        )),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  initialValue: guarantorobj.mtotalincome != null &&  guarantorobj.mtotalincome != 'null'? guarantorobj.mtotalincome.toString():"" ,
                  *//*  controller:
                      guarantorobj.mtotalincome != null
                          ? TextEditingController(
                              text: guarantorobj.mtotalincome
                                  .toString())
                          : TextEditingController(text: ""),*//*
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(10),
                    globals.onlyDoubleNumber
                  ],
                  onSaved: (val) {
                    //  if(val!=null) {
                    if (val != null && val != "") {
                      globals.income = double.parse(val);
                      guarantorobj.mtotalincome =
                          double.parse(val);
                    } else {
                      //globals.income = 0.0;
                      guarantorobj.mtotalincome = null;
                    }

                    // }
                  },
                ),*/
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    Translations.of(context)
                        .text('Relationship with Customer'),
                    style: TextStyle(
                        color: Colors.blue, fontSize: 20.0),
                  ),
                ),
                new Card(
                  child:Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new DropdownButtonFormField(
                      value: samevillageorward,
                      items: generateDropDown(10),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 10);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('Same Village/Ward')),
                    ),
                  ),
                ),
                new Card(
                  child:Container(
                    color: Constant.mandatoryColor,
                    padding: const EdgeInsets.only(left: 10.0),
                    child: new DropdownButtonFormField(
                      value: RelationWithApplicant,
                      items: generateDropDown(3),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 3);
                      },
                      decoration: InputDecoration(labelText: Translations.of(context).text('Relationship_With_Applicant')),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ))
    ;
  }
  proceed()  async{
      if (!validateSubmit()) {
      return;
    }

    await AppDatabase.get().generateSrNoForGuarantor(guarantorobj.mloantrefno).then((onValue) {
      guarantorobj.msrno = onValue;
    });

    guarantorobj.missynctocoresys=0;
    guarantorobj.mlastupdatedt = DateTime.now();
    guarantorobj.mgeolatd=geoLatitude;
    guarantorobj.mgeologd=geoLongitude;
    guarantorobj.mcreatedby = username;
    print("guarantorobj.musrname"+guarantorobj.mcreatedby.toString());
    print("username"+username.toString());
    print("guarantorobj"+guarantorobj.toString());
    if( guarantorobj.mrefno==null){
      guarantorobj.mrefno=0;
    }
    await AppDatabase.get()
        .updateGaurantorMaster(guarantorobj)
        .then((val) {
      print("val here is " + val.toString());
    });
    _successfulSubmit();
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
  Future getCustomerId() async {


    setState(() {
      circIndicator= true;
    });
    CustomerListBean customerdata;


    customerdata = await AppDatabase.get().selectCustomerOnCustNo(guarantorobj.mcustno);

    if(customerdata!=null){
      customerdata.addressDetails = new List<AddressDetailsBean>();
        await AppDatabase.get()
          .selectCustomerAddressDetailsListIsDataSynced(
          customerdata.trefno, customerdata.mrefno)
          .then((List<AddressDetailsBean> addressDetails) async {
        for (int i = 0; i < addressDetails.length; i++) {
          customerdata.addressDetails.add(addressDetails[i]);
        }
      });


    customerdata.imageMaster= new List<ImageBean>();
      await AppDatabase.get()
          .selectImagesListIsDataSynced(customerdata.trefno, customerdata.mrefno)
          .then((List<ImageBean> imageBean) async {
        for (int i = 0; i < imageBean.length; i++) {
          customerdata.imageMaster.add(imageBean[i]) ;

          /*     print(
              "for bean ${imageBean[i].tImgrefno} is ${bean.imageMaster[imageBean[i].tImgrefno]}");*/
        }
      });
    }
    else{

        GetCustomerFromMiddleware getCustomerData = new GetCustomerFromMiddleware();
        try{
             customerdata = await getCustomerData.getCustData(guarantorobj.mcustno,null);
        }catch(_){

        }
     

    }

    if(customerdata==null){
      setState(() {
      circIndicator= false;  
      });
      
      _showAlert(Translations.of(context).text('CustNo'), Translations.of(context).text('CustomerNotPresent'));
      return;
    }


    if (customerdata != null) {
     

      if(customerdata.mrefno == widget.laonLimitPassedObject.mcustmrefno && customerdata.trefno == widget.laonLimitPassedObject.mcusttrefno ){
        _showAlert(Translations.of(context).text('CUSTOMERNUMBER'), Translations.of(context).text('cannot_be_same_as_Loan_Customer'));
        setState(() {
        circIndicator = false;
        });
        return;
      }//else if(){
        //3) same customer cannot be repeat as guarter on same loan
      //}
       isDedupDone =true;

     await AppDatabase.get().getGaurantorDetailsList(widget.trefno,widget.mrefno).then(
              (List<GuarantorDetailsBean> gaurantorData){
                if(gaurantorData.length>0){
                  for(int count =0;count<gaurantorData.length;count++){
                    if(gaurantorData[count].mcustno == widget.laonLimitPassedObject.mcustno &&gaurantorData[count].mcustno!=null&&gaurantorData[count].mcustno!=0  ){
                      _showAlert(Translations.of(context).text('CUSTOMERNUMBER'), Translations.of(context).text('cannot_add_same_guarantor_twice'));
                      return;
                    }
                  }
                }
              });

      applicantDob== "__-__-____";

      print("customerdata"+customerdata.toString());
     // guarantorobj = new GuarantorDetailsBean();
      guarantorobj.mcustno = customerdata.mcustno;
      guarantorobj.mnameofguar= customerdata.mlongname;//customerdata.mfname.toString()+" "+customerdata.mlname.toString();
//      guarantorobj.maddress = customerdata.mAdd1;
//      guarantorobj.maddress2 = customerdata.mAdd2;
//      guarantorobj.maddress3 = customerdata.mAdd3;
      print("customerdata.mdob ${customerdata.mdob }");
      guarantorobj.mdob = customerdata.mdob;

      if (guarantorobj.mdob != null && guarantorobj.mdob != 'null' && guarantorobj.mdob != '') {

        String tempDay;
        String tempMonth;
        if (guarantorobj.mdob.day
            .toString()
            .length == 1)
          tempDay = "0" + guarantorobj.mdob.day.toString();
        else
          tempDay = guarantorobj.mdob.day.toString();

        if (guarantorobj.mdob.month
            .toString()
            .length == 1)
          tempMonth = "0" + guarantorobj.mdob.month.toString();
        else
          tempMonth = guarantorobj.mdob.month.toString();

        applicantDob =
            applicantDob
                .replaceRange(0, 2, tempDay);
        print(
            "applicant DOB = ${applicantDob}");
        applicantDob =
            applicantDob
                .replaceRange(3, 5, tempMonth);
        print(
            "applicant DOB = ${applicantDob}");
        applicantDob =
            applicantDob
                .replaceRange(
                6, 10, guarantorobj.mdob.year.toString());
      }

      if (!applicantDob.contains("_")) {
        try {
          String tempApplicantdob = applicantDob;
          //applicantDob = tempp.toString();
          DateTime  formattedDate =  DateTime.parse(tempApplicantdob.substring(6)+"-"+tempApplicantdob.substring(3,5)+"-"+tempApplicantdob.substring(0,2));
          //print(formattedDate);
          tempDay = formattedDate.day.toString();
          //print(tempDay);
          tempMonth = formattedDate.month.toString();
          //print(tempMonth);
          tempYear = formattedDate.year.toString();

          applicantDobNotPresent = false;
        }catch(_){}

        print("Exception Occupred");
      }



      guarantorobj.mgender=customerdata.mgender;
      guarantorobj.mage=customerdata.mage;
      guarantorobj.mmaritalstatus=customerdata.mmaritialStatus;
      guarantorobj.mnationalidtype=customerdata.mpanno;

      print("customerdata.mmaritialStatus ${customerdata.mmaritialStatus}");
      if(customerdata.mmaritialStatus==2){
        guarantorobj.mspousename=customerdata.mhusbandname;
      }


      setDropdownOnPageLoad();
      print("guarantorobj.mrelationwithcust ${guarantorobj.mrelationwithcust}");
      //guarantorobj.maddress3 = customerdata.mAdd3;
      if(guarantorobj.mage!=null&&guarantorobj.mage!=""&&guarantorobj.mage!="null"){
        AgeNotPresent=false;
      }
      if(guarantorobj.mnameofguar!=null&&guarantorobj.mnameofguar.trim()!=""&&guarantorobj.mnameofguar.trim()!="null"){
        GrntrNameNotPresent=false;
      }
      if(guarantorobj.maddress!=null&&guarantorobj.maddress.trim()!=""&&guarantorobj.maddress.trim()!="null"){
        Add1NotPresent=false;
      }
      if(guarantorobj.maddress2!=null&&guarantorobj.maddress2.trim()!=""&&guarantorobj.maddress2.trim()!="null"){
         Add2NotPresent=false;
      }
      if( (guarantorobj.mnationaliddesc!=null &&guarantorobj.mnationaliddesc.trim()!="null" &&guarantorobj.mnationaliddesc.trim()!="")){
        NationalIDNotPresent=false;
      }
      



/*
      applicantDob=customerdata.mdob.toString();
      tempYear=customerdata.mdob.toString().substring(0, 4).trim();
      tempMonth=customerdata.mdob.toString().substring(5, 7).trim();
      tempDay=customerdata.mdob.toString().substring(8, 10).trim();*/

      guarantorobj.mmobile = customerdata.mmobno;
      guarantorobj.mnationaliddesc=customerdata.mpannodesc;

      prefs = await SharedPreferences.getInstance();
      try {
        resAddCode = await prefs.getInt(TablesColumnFile.resAddCode);
      }catch(_){}

      if( customerdata!=null&& customerdata.trefno!=null
          && customerdata.mrefno!=null)
      {
        // await AppDatabase.get()
        //     .selectCustomerAddressDetailsListIsDataSynced(
        //     customerdata.trefno,  customerdata.mrefno)
        //     .then((List<AddressDetailsBean> addressDetails) async {

          if(customerdata.addressDetails!=null&&customerdata.addressDetails.isNotEmpty){


            for (int i = 0; i < customerdata.addressDetails.length; i++) {

              print("adress type ${customerdata.addressDetails[i].maddrType}" );
              print("residential code e ${resAddCode}" );
              if(customerdata.addressDetails[i].maddrType==resAddCode){
                guarantorobj.maddress = customerdata.addressDetails[i].maddr1;
                guarantorobj.maddress2 = customerdata.addressDetails[i].maddr2;
                guarantorobj.maddress3 = customerdata.addressDetails[i].maddr3;
                try{
                guarantorobj.mstatecd = customerdata.addressDetails[i].mState;
                if(guarantorobj.mstatecd!=null&&guarantorobj.mstatecd.trim!=''){
                  await AppDatabase.get().getStateNameViaStateCode( guarantorobj.mstatecd).then(( StateDropDownList val){
                    guarantorobj.mstatecddesc = val.stateDesc;
                    stateCdPresent = true;
                  });
                }
              }catch(_){}
                try{
                guarantorobj.mtownship = customerdata.addressDetails[i].mDistCd.toString();
                if(guarantorobj.mtownship!=null&&guarantorobj.mtownship!=0){
                  await AppDatabase.get().getDistrictNameViaDistrictCode( guarantorobj.mtownship.toString()).then(( DistrictDropDownList val){
                    guarantorobj.mtownshipdesc = val.distDesc;

                    townShipPresent= true;
                  });
                }
              }catch(_){}
                try{

                  if(isExistingCustomerY==true){
                     mvillage = customerdata.addressDetails[i].mcityCd;
                  }

                  else{

                    mvillage = customerdata.addressDetails[i].mplacecd;
                  }

               
                if(mvillage!=null&&mvillage.trim()!=''&&mvillage.trim()!='null'){
                  await AppDatabase.get().getPlaceNameViaPlaceCode( mvillage.toString()).then(( SubDistrictDropDownList val){
                    guarantorobj.mvillagedesc = val.placeCdDesc;
                  });
                  guarantorobj.mvillage = int.parse(mvillage);

                }
                }catch(_){}
                try{
                guarantorobj.mwardno = customerdata.addressDetails[i].marea.toString();
                print( "Ward Number is ${guarantorobj.mwardno}");
                if(guarantorobj.mwardno!=null&&guarantorobj.mwardno!=0){
                  await AppDatabase.get().getAreaNameViaAreaCode( guarantorobj.mwardno.toString()).then(( AreaDropDownList val){
                    guarantorobj.mwardnodesc = val.areaDesc;
                    wardNoPresent= true;
                  });
                }
                }catch(_){}


                guarantorobj.mmobile = customerdata.addressDetails[i].mMobile;
              }
            }
          }
        //});
      }
      try{
        setState(() {

        });
      }catch(_){

      }

      if( customerdata!=null&& customerdata.trefno!=null
          && customerdata.mrefno!=null)
      {
        // await AppDatabase.get()
        //     .selectImagesListIsDataSynced(customerdata.trefno, customerdata.mrefno)
        //     .then((List<ImageBean> imageBean) async {
          
          if(customerdata.imageMaster!=null){
              for (int i = 0; i < customerdata.imageMaster.length; i++) {

            if (customerdata.imageMaster[i].tImgrefno == 0 ) {
              guarantorobj.mfacecapture = customerdata.imageMaster[i].imgString;
            }
            if (customerdata.imageMaster[i].tImgrefno == 1 ) {
              guarantorobj.mnrcphoto = customerdata.imageMaster[i].imgString;
            }
            if (customerdata.imageMaster[i].tImgrefno == 2 ) {
              guarantorobj.mnrcsecphoto = customerdata.imageMaster[i].imgString;
            }

            if (customerdata.imageMaster[i].tImgrefno == 3 &&
                customerdata.mTypeOfId == 2 &&
                customerdata.imageMaster[i].imgString != null &&
                customerdata.imageMaster[i].imgString.trim() != '') {
              guarantorobj.mhouseholdphoto =
                  customerdata.imageMaster[i].imgString;
            }

            if (customerdata.imageMaster[i].tImgrefno == 4 &&
                customerdata.mTypeOfId == 2 &&
                customerdata.imageMaster[i].imgString != null &&
                customerdata.imageMaster[i].imgString.trim() != '') {
              guarantorobj.mhouseholdsecphoto =
                  customerdata.imageMaster[i].imgString;
            }
          }
       // })

          }
          ;
      }
      try{

      }catch(_){

      }

      if((guarantorobj.mmobile!=null&&guarantorobj.mmobile.trim()!=''&&guarantorobj.mmobile.trim()!="null")){
        MobileNotPresent=false;
      }



      print("inside cus");
      print(customerdata.mdob);
      print(customerdata.mTypeOfId);
      print(customerdata.mmobno);
      print(customerdata.mgender);
      print(customerdata.mcustno);
      print(customerdata.mIdDesc);
      print(customerdata.mage);

      print(guarantorobj.mnationaliddesc);}

      
      setState(() {
          circIndicator= false;
      });



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
                  Text(Translations.of(context).text('Done')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('Ok')),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _showAlert(arg, error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$arg " +Translations.of(context).text('error')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Ok')),
               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                setState(() {
                  circNationIdIndicator = false;
                });

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
    print("inside validate");
  if(isDedupDone==false){
       _showAlert(Translations.of(context).text('Customer Check'), Translations.of(context).text('It_Is_Mandatory'));
      return false;

  }

    if(isExistingCustomerY){
    if (guarantorobj.mcustno == "" || guarantorobj.mcustno== null) {
      _showAlert(Translations.of(context).text('CUSTOMERNUMBER'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    }
    if (guarantorobj.mfacecapture == "" || guarantorobj.mfacecapture== null) {
      _showAlert(Translations.of(context).text('Face Photo Capture'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mnationalidtype == 0 || guarantorobj.mnationalidtype== null) {
      _showAlert(Translations.of(context).text('National_ID_Type'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if(guarantorobj.mnationalidtype != 99) {
      if (guarantorobj.mnationaliddesc == "" || guarantorobj.mnationaliddesc == null) {
        _showAlert(Translations.of(context).text('National_ID'),
            Translations.of(context).text('It_Is_Mandatory'));
        return false;
      }
    }
    if (guarantorobj.mnrcphoto == "" || guarantorobj.mnrcphoto== null) {
      _showAlert(Translations.of(context).text('NRC Photo Capture'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mnrcsecphoto == "" || guarantorobj.mnrcsecphoto== null) {
      _showAlert(Translations.of(context).text('NRC Photo Capture'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    /*if (guarantorobj.mapplicanttype == "" || guarantorobj.mapplicanttype== null) {
      _showAlert(Translations.of(context).text('Applicant_Type'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }*/
    if (guarantorobj.mnameofguar == "" || guarantorobj.mnameofguar== null) {
      _showAlert(Translations.of(context).text('Guarantor_Name'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (isFullerTon==0) {
      if (guarantorobj.mgender == "" || guarantorobj.mgender == null) {
        _showAlert(Translations.of(context).text('Gender'),
            Translations.of(context).text('It_Is_Mandatory'));
        return false;
      }
    }


    try {
      guarantorobj.mdob = DateTime.parse(applicantDob.substring(6) +
          "-" +
          applicantDob.substring(3, 5) +
          "-" +
          applicantDob.substring(0, 2));
    } catch (e) {
      _showAlert(Translations.of(context).text('dateOfBirth'), Translations.of(context).text('It_Is_Mandatory'));
      print("applicantDob applicantDob applicantDob111 ${applicantDob}");
      return false;
    }

    if(Utility.validateOmniMinAge(guarantorobj.mdob)==false){
      _showAlert(Translations.of(context).text('dateOfBirth'), Translations.of(context).text('below min age'));
      return false;
    }

    int age=0;
        age = DateTime
            .now()
            .year -  guarantorobj.mdob.year;

     if(minAge!=0&&minAge!=null&&minAge>age){
       _showAlert(Translations.of(context).text("minDob"),
            Translations.of(context).text("mandtory"));
        return false;

     }  

     if(maxAge!=0&&maxAge!=null&&maxAge<age){
       _showAlert(Translations.of(context).text("maxDob"),
            Translations.of(context).text("mandtory"));
        return false;

     } 

   if (guarantorobj.mdob == "" || guarantorobj.mdob== null) {
     _showAlert(Translations.of(context).text('dateOfBirth'),
         Translations.of(context).text('It_Is_Mandatory'));
     return false;
   }
    if(guarantorobj.mmaritalstatus == "" || guarantorobj.mmaritalstatus== null) {
      _showAlert(Translations.of(context).text('maritalStatus'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    print("marital status");
    print(guarantorobj.mmaritalstatus);
    if(guarantorobj.mmaritalstatus == 2) {
      if (guarantorobj.mspousename == "" || guarantorobj.mspousename == null) {
        _showAlert(Translations.of(context).text('spouseName'),
            Translations.of(context).text('It_Is_Mandatory'));
        return false;
      }
    }
    if (guarantorobj.mhouseholdphoto == "" || guarantorobj.mhouseholdphoto== null) {
      _showAlert(Translations.of(context).text('Household list photo capture'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mhouseholdsecphoto == "" || guarantorobj.mhouseholdsecphoto== null) {
      _showAlert(Translations.of(context).text('Household list photo capture'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mstatecd == "" || guarantorobj.mstatecd == null) {
      _showAlert(Translations.of(context).text('RegionState'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mtownship == "" || guarantorobj.mtownship == null) {
      _showAlert(Translations.of(context).text('Township'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (isFullerTon==1 && ( guarantorobj.mvillage == null)) {
      _showAlert(Translations.of(context).text('TownVillage Tract'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (isFullerTon==1 && ( guarantorobj.mwardno == null) ){
      _showAlert(Translations.of(context).text('WardVillage'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.maddress == "" || guarantorobj.maddress== null) {
      _showAlert(Translations.of(context).text('Address'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (isFullerTon==0) {
      if (guarantorobj.mhousetype == "" || guarantorobj.mhousetype == null) {
        _showAlert(Translations.of(context).text('House_Type'),
            Translations.of(context).text('It_Is_Mandatory'));
        return false;
      }
    }
    if (guarantorobj.mmobile == "" || guarantorobj.mmobile== null) {
      _showAlert(Translations.of(context).text('Mobile_Number'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.maddressphoto == "" || guarantorobj.maddressphoto== null) {
      _showAlert(Translations.of(context).text('Address Proof Photo Capture'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.msignature == "" || guarantorobj.msignature== null) {
      _showAlert(Translations.of(context).text('Guarantor_Sign'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mbuspropownership == 0 || guarantorobj.mbuspropownership== null) {
      _showAlert(Translations.of(context).text('Ownership of the Business Property'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mbusownership == 0 || guarantorobj.mbusownership== null) {
      _showAlert(Translations.of(context).text('Ownership of the Business'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mbustoaassetval == 0 || guarantorobj.mbustoaassetval== null) {
      _showAlert(Translations.of(context).text('Value of total business asset'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mbusleninyears == null || guarantorobj.mbusleninyears== 'null') {
      _showAlert(Translations.of(context).text('Length of Business Year'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mbusmonexpense == "" || guarantorobj.mbusmonexpense== null) {
      _showAlert(Translations.of(context).text('Monthly Expense of Business'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (guarantorobj.mbusmonhlynetprof == "" || guarantorobj.mbusmonhlynetprof== null) {
      _showAlert(Translations.of(context).text('Monthly Net Profit of the Business'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (isFullerTon==0) {
      if (guarantorobj.moccupationtype == "" || guarantorobj.moccupationtype == null) {
        _showAlert(Translations.of(context).text('Occupation_Type'),
            Translations.of(context).text('It_Is_Mandatory'));
        return false;
      }
      if (guarantorobj.mmainoccupation == "" || guarantorobj.mmainoccupation == null) {
        _showAlert(Translations.of(context).text('Main_Occupation'),
            Translations.of(context).text('It_Is_Mandatory'));
        return false;
      }
    }
    if (guarantorobj.mmonthlyincome == "" || guarantorobj.mmonthlyincome== null) {
      _showAlert(Translations.of(context).text('Monthly_Income'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    if (isFullerTon==0) {
      if (guarantorobj.mincomeothsources == "" || guarantorobj.mincomeothsources == null) {
        _showAlert(Translations.of(context).text('Income_From_Another_Source'),
            Translations.of(context).text('It_Is_Mandatory'));
        return false;
      }
    }
    if (guarantorobj.mrelationwithcust == "" || guarantorobj.mrelationwithcust== null) {
      _showAlert(Translations.of(context).text('Relationship_With_Applicant'), Translations.of(context).text('It_Is_Mandatory'));
      return false;
    }
    return true;

  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != guarantorobj.mdob)
      setState(() {
        guarantorobj.mdob= picked;
        tempDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempDay = "0"+picked.day.toString();

        }
        else tempDay = picked.day.toString();
        applicantDob = applicantDob.replaceRange(0, 2, tempDay);
        tempYear = picked.year.toString();
        applicantDob = applicantDob.replaceRange(6, 10,tempYear);
        if(picked.month.toString().length==1){
          tempMonth = "0"+picked.month.toString();
        }
        else
          tempMonth = picked.month.toString();
        applicantDob = applicantDob.replaceRange(3, 5, tempMonth);

      });
  }

  void _changed(ByteData filePath, String forWhat) {
    setState(() {
       if (forWhat == "guarantor") {
        globals.imageVisibilityDeclarationFormTagCustomer = true;
        if(filePath!=null&&filePath!=""){
          guarantorobj.msignature = base64.encode(filePath.buffer.asUint8List());
          debugPrint(
              "a read " + base64.encode(filePath.buffer.asUint8List()));
        }
      }
    });
  }

  _navigateAndDisplaySignatureSelection(
      BuildContext context, String str) async {

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new SignApp(),
        fullscreenDialog: true,
      ),
    ).then((onValue) {
      setState(() {
        _changed(onValue, str);
      });
      setState(() {

      });
    });
  }
  Future<void> _showImage() async {

    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            ViewImageScreen()));
  }
  Widget getCircleContainer(String s,int i) {
    imageCache.clear();
    try {
      return
        new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            print("Container clicked");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();
            if (s !=
                null &&
                s !=
                    "null" &&
                s !=
                    "") {
              docListView = new List<PhotoViewGalleryPageOptions>();
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(s )
                          .readAsBytesSync())));
              _showImage();
            } else {
              _PickImage(i);
            }
          },
          child:
          new Container(
            width:i==0?250.0: 200.0,
            height:i==0?250.0: 200.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: i==0?BoxShape.circle:BoxShape.rectangle,
                border:i==0?Border.all(color: Color(0xff07426A), width: 0.5):Border.all(color: Color(0xff07426A), width: 0.3),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,
                  image:
                  s !=
                      null &&
                      s !=
                          "null" &&
                      s !=
                          ""
                      ?
                  MemoryImage(File(s).readAsBytesSync())
                      :i==0?new ExactAssetImage('assets/AddImage.png'): new ExactAssetImage('assets/Document.png'),
                )
            ),
          ),
        );
    }catch(_){
      return
        new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            print("Container clicked");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();
            print("s${s}");
            if (s !=
                null &&
                s !=
                    "null" &&
                s !=
                    "") {
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(s)
                          .readAsBytesSync())));
              _showImage();
            } else {
              _PickImage(i);
            }
          },
          child:
          new Container(
            width:i==0?250.0: 200.0,
            height:i==0?250.0: 200.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape:  i==0?BoxShape.circle:BoxShape.rectangle,
                border:i==0?Border.all(color: Color(0xff07426A), width: 0.5):Border.all(color: Color(0xff07426A), width: 0.3),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,
                  image: i==0?new ExactAssetImage('assets/AddImage.png'):new ExactAssetImage('assets/Document.png'),
                )
            ),
          ),
        );
    }
  }


Future<bool> dedupGuarantor() async {
CustomerListBean returnedGuarantorEntity;

returnedGuarantorEntity = await AppDatabase.get().getDedupCustomerIfPresent(guarantorobj.mnationaliddesc, guarantorobj.mdob,isFullerTon==1?true:false); 


  if(returnedGuarantorEntity!=null){

    _showAlert(Translations.of(context).text('Guarantor Dedup'),
        Translations.of(context).text('already_exist_with_national_id'),);
        return false;

  }
  else{
    return true;
  }





}


  _DedupOnNationalID() async {

      isDedupDone = false;

    if(isFullerTon==1) {
     

      try {
        guarantorobj.mdob = DateTime.parse(applicantDob.substring(6) +
            "-" +
          applicantDob.substring(3, 5) +
            "-" +applicantDob.substring(0, 2));
        int age=0;
        try {
          age = DateTime
              .now()
              .year - guarantorobj.mdob.year;

          if(minAge!=0&&minAge!=null&&minAge>age){
            _showAlert(Translations.of(context).text("minDob"),
            Translations.of(context).text("mandtory"));
            return ;
          }
          
          else if(maxAge!=0&&maxAge!=null&&maxAge<age){
       _showAlert(Translations.of(context).text("maxDob"),
            Translations.of(context).text("mandtory"));
        return ;

     } 
        }catch(_){}
      } catch (e) {

        _showAlert(Translations.of(context).text("applicantDOB"),
            Translations.of(context).text("itIsMand"));
        return ;
      }

      if ( guarantorobj.mdob == null||
          guarantorobj.mdob.isAfter(DateTime.now().subtract(Duration(days: 1)))
      ) {
        _showAlert(
            Translations.of(context).text("dateOfBirth"),
            Translations.of(context).text("Date Of Birth not Correct"));

        return ;
      }

    }
    if (guarantorobj.mnationaliddesc ==
        null ||
        guarantorobj.mnationaliddesc == '' || guarantorobj.mnationaliddesc.length<6) {
      _showAlert(
          "Please fill National ID And atlest 6 Digit of NRC", "This field is Mandatory for Dedup");
    } else{
      bool isNetworkAvailable;
      bool isNetworkAvailablegoogle;
      isNetworkAvailable = await Utility.checkIntCon();

      //TODO check data in offline case for dedup if present them break here otherwise go online

      await AppDatabase.get().getDedupCustomerIfPresent(guarantorobj.mnationaliddesc, guarantorobj.mdob,isFullerTon==1?true:false).then((onValue) async{
        if(onValue!=null ){
          isDedupDone = true;
          String message = "${onValue.mlongname.toString()} is already present with Customer No ${onValue.mcustno.toString()} , Customer Belongs to User : ${onValue.mcreatedby!=null && onValue.mcreatedby!='null'?onValue.mcreatedby:""}";
          _showAlert( Translations.of(context).text("Customer already exist"), message);
          return;
        }else{
          if (isNetworkAvailable) {

            getMiddleWareData();

          } else {
            isDedupDone = true;
            _showAlert(Translations.of(context).text("Please check your Network"), Translations.of(context).text("This Should only be done Online"));
          }
        }
      });


    }
  }






  getMiddleWareData() async {
    Utility obj = new Utility();
    final _headers = {'Content-Type': 'application/json'};
    var urlGetCustomerDetails = "customerData/getCustomerDedup/";

    try {
      String json = _toJson();
      String bodyValue = await NetworkUtil.callPostService(
          json.toString(),
          Constant.apiURL.toString() + urlGetCustomerDetails.toString(),
          _headers);
      if (bodyValue == "404") {

        _showAlert(Translations.of(context).text("Network_Not_Available"),"No Response");
        return null;
      } else {
        print(bodyValue);
        //final parsed = JSON.decode(bodyValue).cast<String, dynamic>();
        Map<String, dynamic> map = JSON.decode(bodyValue);
        if(map==null){
          //TODO Put this in resource file
           isDedupDone = true;
          _showAlert(Translations.of(context).text("Customer Not Present With ID"), Translations.of(context).text("You can proceed"));
        }
        var obj =null;
        try{
          obj = CustomerListBean.fromMapMiddlewareDedup(map, true);
          isDedupDone = false;
         
        } catch (_) {
         
          //TODO Put this in resource file
          isDedupDone = true;
          _showAlert(Translations.of(context).text("Customer Not Present With ID"), Translations.of(context).text("You can proceed"));
         
        }
          String message = "${obj.mlongname
              .toString()} is already present with Customer No ${obj.mcustno
              .toString()} , Customer Belongs to User : ${obj.mcreatedby != null &&
              obj.mcreatedby != 'null' ? obj.mcreatedby : ""}";
        _showAlert(Translations.of(context).text("Cannot create guarantor with this id"), message);

      }
    } catch (_) {
      isDedupDone = true;
      _showAlert("Customer Not Present With ID", "You can proceed");
    }
  }

  String _toJson() {
    var mapData = new Map();
    mapData["mnationalid"] =
        guarantorobj.mnationaliddesc.trim();
    mapData[TablesColumnFile.mdob] = guarantorobj.mdob != null
        ? guarantorobj.mdob.toIso8601String()
        : null;

    print(mapData);
    String json = JSON.encode(mapData);
    return json;
  }











}
class ViewImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: PhotoViewGallery( pageOptions:docListView),
    );
  }
}