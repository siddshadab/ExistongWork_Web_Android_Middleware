import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/Helper.dart';
import 'package:eco_mfi/Utilities/OpenCamera.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
var docListView=new List<PhotoViewGalleryPageOptions>();

class CustomerFormationDocuments extends StatefulWidget {
  var cameras;

  CustomerFormationDocuments(this.cameras, {Key key}) : super(key: key);

  @override
  _CustomerFormationDocumentsState createState() =>
      new _CustomerFormationDocumentsState();
}

class _CustomerFormationDocumentsState
    extends State<CustomerFormationDocuments> {
  int isFullerTon=0;
  bool isModificationRequired =true;
  LookupBeanData id1;
  LookupBeanData id2;
  File _image;
  static final GlobalKey<FormState> _formKeyid1 = new GlobalKey<FormState>();
  static final GlobalKey<FormState> _formKeyid2 = new GlobalKey<FormState>();

  final dateFormat = DateFormat("yyyy/MM/dd");
  var formatter = new DateFormat('dd-MM-yyyy');
  String tempId1IssueDate = "----/--/--";
  String tempId1IssueYear ;
  String tempId1IssueDay ;
  String tempId1IssueMonth;
  String tempId1ExpDate = "----/--/--";
  String tempId1ExpYear ;
  String tempId1ExpDay ;
  String tempId1ExpMonth;

  String tempId2IssueDate = "----/--/--";
  String tempId2IssueYear ;
  String tempId2IssueDay ;
  String tempId2IssueMonth;
  String tempId2ExpDate = "----/--/--";
  String tempId2ExpYear ;
  String tempId2ExpDay ;
  String tempId2ExpMonth;



  FocusNode monthid1IssueFocus;
  FocusNode yearid1IssueFocus;
  FocusNode monthid2IssueFocus;
  FocusNode yearid2IssueFocus;

  FocusNode monthid1ExpFocus;
  FocusNode yearid1ExpFocus;
  FocusNode monthid2ExpFocus;
  FocusNode yearid2ExpFocus;
  bool id1Mand=true;
  bool id2Mand = true;



  DateTime date;
  TimeOfDay time;
  int NIDDEFAULTTYPE;
  SharedPreferences prefs;
  Future getImage(int no) async {

    if(CustomerFormationMasterTabsState.custListBean.imageMaster==null){
      CustomerFormationMasterTabsState.custListBean.imageMaster= new  List<ImageBean>();
      for(int i =0;i<23;i++){
        CustomerFormationMasterTabsState.custListBean.imageMaster.add(new ImageBean());
      }
    }
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      //ratioX: 1.5,
      //ratioY: 1.0,
      maxWidth: 640,
      maxHeight: 640,
    );
    String st = croppedFile.path;
    print("path" + st.toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[no].imgString =
        croppedFile.path;
	try{
    if(no>1 && no<3){
      CustomerFormationMasterTabsState.custListBean.imageMaster[1].desc=  id1.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[1].imgSubType = id1.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[2].desc=  id1.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[2].imgSubType = id1.mcodedesc;
    }else if(no>3 && no<7){
      CustomerFormationMasterTabsState.custListBean.imageMaster[3].desc=  id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[3].imgSubType = id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[4].desc=  id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[4].imgSubType = id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[5].desc=  id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[5].imgSubType = id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[6].desc=  id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[6].imgSubType = id2.mcodedesc;

    }else if(no>7 && no<11){

      CustomerFormationMasterTabsState.custListBean.imageMaster[7].desc=  "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[7].imgSubType = "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[8].desc=  "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[8].imgSubType = "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[9].desc=  "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[9].imgSubType = "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[10].desc=  "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[10].imgSubType = "PassBook";

    }
}catch(_){}
    setState(() {
      _image = croppedFile;
    });
  }



  Future getImageFromGallery(int no) async {

    if(CustomerFormationMasterTabsState.custListBean.imageMaster==null){
      CustomerFormationMasterTabsState.custListBean.imageMaster= new  List<ImageBean>();
      for(int i =0;i<13;i++){
        CustomerFormationMasterTabsState.custListBean.imageMaster.add(new ImageBean());
      }
    }
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      //ratioX: 1.5,
      //ratioY: 1.0,
      maxWidth: 640,
      maxHeight: 640,
    );
    String st = croppedFile.path;
    print("path" + st.toString());
    CustomerFormationMasterTabsState.custListBean.imageMaster[no].imgString =
        croppedFile.path;
	try{
    if(no>1 && no<3){
      CustomerFormationMasterTabsState.custListBean.imageMaster[1].desc=  id1.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[1].imgSubType = id1.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[2].desc=  id1.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[2].imgSubType = id1.mcodedesc;
    }else if(no>3 && no<7){
      CustomerFormationMasterTabsState.custListBean.imageMaster[3].desc=  id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[3].imgSubType = id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[4].desc=  id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[4].imgSubType = id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[5].desc=  id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[5].imgSubType = id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[6].desc=  id2.mcodedesc;
      CustomerFormationMasterTabsState.custListBean.imageMaster[6].imgSubType = id2.mcodedesc;

    }else if(no>7 && no<11){

      CustomerFormationMasterTabsState.custListBean.imageMaster[7].desc=  "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[7].imgSubType = "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[8].desc=  "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[8].imgSubType = "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[9].desc=  "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[9].imgSubType = "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[10].desc=  "PassBook";
      CustomerFormationMasterTabsState.custListBean.imageMaster[10].imgSubType = "PassBook";

    }
}catch(_){}
    setState(() {
      _image = croppedFile;
    });
  }





  @override
  void initState() {
    super.initState();

    getSessionVariables();
    print("inside init");

    monthid1IssueFocus = new FocusNode();
    yearid1IssueFocus = new FocusNode();

    monthid2IssueFocus = new FocusNode();
    yearid2IssueFocus = new FocusNode();


    monthid1ExpFocus = new FocusNode();
    yearid1ExpFocus = new FocusNode();

    monthid2ExpFocus = new FocusNode();
    yearid2ExpFocus = new FocusNode();

    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mpanno.toString());
    tempDropDownValues.add(CustomerFormationMasterTabsState.custListBean.mTypeOfId.toString());

    for (int k = 0; k < globals.dropdownCaptionsValuesKyc.length; k++) {
      for (int i = 0; i < globals.dropdownCaptionsValuesKyc[k].length; i++) {
        try{
        if (globals.dropdownCaptionsValuesKyc[k][i].mcode.toString().trim() ==
            tempDropDownValues[k].toString().trim()) {
          setValue(k, globals.dropdownCaptionsValuesKyc[k][i]);
        }
        }catch(_){
          print("Exception Occured");
        }
      }
    }
    print("issue date is ${CustomerFormationMasterTabsState.id1IssueDate}");
    if(!CustomerFormationMasterTabsState.id1IssueDate.contains("_")){
      try{
        print("inside try");

        String tempid1issuedate = CustomerFormationMasterTabsState.id1IssueDate;

        DateTime  formattedDate =  DateTime.parse(tempid1issuedate.substring(6)+"-"+tempid1issuedate.substring(3,5)+"-"+tempid1issuedate.substring(0,2));
        print(formattedDate);
        tempId1IssueDay = formattedDate.day.toString();
        print(tempId1IssueDay);
        tempId1IssueMonth = formattedDate.month.toString();
        print(tempId1IssueMonth);
        tempId1IssueYear = formattedDate.year.toString();
        print(tempId1IssueYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }


    if(!CustomerFormationMasterTabsState.id2IssueDate.contains("_")){
      try{
        print("inside try");

        String tempId2issuedate = CustomerFormationMasterTabsState.id2IssueDate;

        DateTime  formattedDate =  DateTime.parse(tempId2issuedate.substring(6)+"-"+tempId2issuedate.substring(3,5)+"-"+tempId2issuedate.substring(0,2));
        print(formattedDate);
        tempId2IssueDay = formattedDate.day.toString();
        print(tempId2IssueDay);
        tempId2IssueMonth = formattedDate.month.toString();
        print(tempId2IssueMonth);
        tempId2IssueYear = formattedDate.year.toString();
        print(tempId2IssueYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }


    if(!CustomerFormationMasterTabsState.id1ExpDate.contains("_")){
      try{
        print("inside try");

        String tempId1Expdate = CustomerFormationMasterTabsState.id1ExpDate;

        DateTime  formattedDate =  DateTime.parse(tempId1Expdate.substring(6)+"-"+tempId1Expdate.substring(3,5)+"-"+tempId1Expdate.substring(0,2));
        print(formattedDate);
        tempId1ExpDay = formattedDate.day.toString();
        print(tempId1ExpDay);
        tempId1ExpMonth = formattedDate.month.toString();
        print(tempId1ExpMonth);
        tempId1ExpYear = formattedDate.year.toString();
        print(tempId1ExpYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }


    if(!CustomerFormationMasterTabsState.id2ExpDate.contains("_")){
      try{
        print("inside try");

        String tempId2Expdate = CustomerFormationMasterTabsState.id2ExpDate;

        DateTime  formattedDate =  DateTime.parse(tempId2Expdate.substring(6)+"-"+tempId2Expdate.substring(3,5)+"-"+tempId2Expdate.substring(0,2));
        print(formattedDate);
        tempId2ExpDay = formattedDate.day.toString();
        print(tempId2ExpDay);
        tempId2ExpMonth = formattedDate.month.toString();
        print(tempId2ExpMonth);
        tempId2ExpYear = formattedDate.year.toString();
        print(tempId2ExpYear);
        setState(() {

        });

      }catch(e){

        print("Exception Occupred");
      }
    }

  }
  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    try{


    setState(() {

  try {
   // prefs.getInt(TablesColumnFile.ISDEDUPREQUIRED);
    if(prefs.getInt(TablesColumnFile.ISDEDUPREQUIRED)==1){
      isModificationRequired =false;
    }
  }catch(_){}


  try {
    isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
    if(isFullerTon==1){
      id2Mand=false;
    }

  }catch(_){}
});

    }catch(_){

    }




  }

  showDropDown(LookupBeanData selectedObj, int no) {
    for (int k = 0; k < globals.dropdownCaptionsValuesKyc[no].length; k++) {
      if (globals.dropdownCaptionsValuesKyc[no][k].mcodedesc ==
          selectedObj.mcodedesc) {
        setValue(no, globals.dropdownCaptionsValuesKyc[no][k]);
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          id1 = value;
          CustomerFormationMasterTabsState.custListBean.mpanno = int.parse(value.mcode);
          if(CustomerFormationMasterTabsState.custListBean.mpanno==99){
            id1Mand = false;
          }else{
            id1Mand = true;
          }
          break;
        case 1:
          id2 = value;
          CustomerFormationMasterTabsState.custListBean.mTypeOfId = int.parse(value.mcode);
          if(CustomerFormationMasterTabsState.custListBean.mTypeOfId==1){
            id2Mand = false;
          }
          else{
            id2Mand =true;
          }

          try {
            isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
            if(isFullerTon==1){
              id2Mand=false;
            }
          }catch(_){}

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
    for (int k = 0; k < globals.dropdownCaptionsValuesKyc[no].length; k++) {
      mapData.add(globals.dropdownCaptionsValuesKyc[no][k]);
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

  /*List<DropdownMenuItem<String>> generateDropDown(int no) {
    List<DropdownMenuItem<String>> _dropDownMenuItems1;
    int i = 0;
    List mapdata = List();
    globals.dropdownCaptionsValuesKyc[no].forEach((mapValue) {
      var keys = mapValue.keys.toList();
      for (int i = 0; i < keys.length; i++) {
        var val = mapValue[keys[i]];
        mapdata.add(val);
      }
    });
    _dropDownMenuItems1 = mapdata.map((value) {
      return new DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  void changedDropDownItem(String id, int position) {
    print("Selected Id  $id, we are going to refresh the UI");
    print(position);
    setState(() {
      // globals.dropdownCaptionsValuesKyc[position].forEach((f) {
      switch (position) {
        case 0:
          globals.idType1 = id;
          //  globals.idType1Key = iterateMap(f, id);
          break;
        case 1:
          globals.idType2 = id;
          // globals.idType2 = iterateMap(f, id);
          break;
        default:
          break;
      }
      //  });
    });
  }*/

  Widget getTextContainer(String textValue) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 20.0),
      child: new Text(
        textValue,
        //textDirection: TextDirection,
        textAlign: TextAlign.start,
        /*overflow: TextOverflow.ellipsis,*/
        style: new TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          new Card(
              elevation: 5.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  isModificationRequired?new  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButtonFormField(
                      value: id1,
                      items: generateDropDown(0),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 0);
                      },
                      validator: (args) {
                        print(args);
                      },
                      //  isExpanded: true,
                      //hint:Text("Select"),
                      decoration:
                      InputDecoration(labelText: Translations.of(context).text("National_ID")),
                      // style: TextStyle(color: Colors.grey),
                    ),
                  ):new IgnorePointer(
          ignoring: true,

        child:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: new DropdownButtonFormField(
              value: id1,
              items: generateDropDown(0),
              onChanged: (LookupBeanData newValue) {
                showDropDown(newValue, 0);
              },
              validator: (args) {
                print(args);
              },
              //  isExpanded: true,
              //hint:Text("Select"),
              decoration:
              InputDecoration(labelText: Translations.of(context).text("National_ID")),
              // style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
                  new Form(
                    key: _formKeyid1,
                    //autovalidate: CustomerFormationMasterTabsState.autoValidate,
                    onWillPop: () {
                      return Future(() => true);
                    }
                    ,onChanged: () {
                    final FormState form = _formKeyid1.currentState;
                    form.save();
                  },
                 child: new Column(
                    children: <Widget>[


                        Container(
                          color: id1Mand==true? Constant.mandatoryColor: Colors.white,
                          child: new TextFormField(
                            enabled:  isModificationRequired?true:false,
                            keyboardType: TextInputType.text,
                            decoration:  InputDecoration(

                              hintText: Translations.of(context).text('Enter_ID1_detail'),
                              labelText: Translations.of(context).text('ID1_detail'),
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
                            initialValue:
                            CustomerFormationMasterTabsState.custListBean.mpannodesc!= null&&
                                CustomerFormationMasterTabsState.custListBean.mpannodesc!="null" ?
                            CustomerFormationMasterTabsState.custListBean.mpannodesc : "",
                            onSaved: (val) => CustomerFormationMasterTabsState.custListBean.mpannodesc = val,
                          ),
                        ),

                         SizedBox(height: 20.0,),
                        isFullerTon==1?new Container(): Container(
                           //decoration: BoxDecoration(color: Constant.mandatoryColor),
                           child: new Row(

                             children: <Widget>[Text(Translations.of(context).text('id1Issue'))],
                           ),
                         ),
                        isFullerTon==1?new Container():new Container(
                           //decoration: BoxDecoration(color: Constant.mandatoryColor,),



                           child: new Row(
                             children: <Widget>[
                               new Container(
                                 width: 50.0,
                                 child: new TextField(
                                     decoration:
                                     InputDecoration(
                                        hintText: Translations.of(context).text('DD')
                                     ),
                                     inputFormatters: [
                                       new LengthLimitingTextInputFormatter(2),
                                       globals.onlyIntNumber
                                     ],
                                     controller: tempId1IssueDay == null?null:new TextEditingController(text: tempId1IssueDay),
                                     keyboardType: TextInputType.numberWithOptions(),

                                     onChanged: (val){

                                       if(val!="0"){
                                         tempId1IssueDay = val;


                                         if(int.parse(val)<=31&&int.parse(val)>0){



                                           if(val.length==2){
                                             CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(0, 2, val);
                                             FocusScope.of(context).requestFocus(monthid1IssueFocus);
                                           }
                                           else{
                                             CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(0, 2, "0"+val);
                                           }


                                         }
                                         else {
                                           setState(() {
                                             tempId1IssueDay ="";
                                           });

                                         }


                                       }
                                     }

                                 ),

                               )
                               ,


                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: new Text("/"),
                               ),
                               new Container(
                                 width: 50.0,
                                 child: new TextField(
                                  decoration: InputDecoration(
                                    hintText: Translations.of(context).text('MM'),


                                   ),

                                   keyboardType: TextInputType.numberWithOptions(),
                                   inputFormatters: [
                                     new LengthLimitingTextInputFormatter(2),
                                     globals.onlyIntNumber
                                   ],
                                   focusNode: monthid1IssueFocus,
                                   controller: tempId1IssueMonth == null?null:new TextEditingController(text: tempId1IssueMonth),
                                   onChanged: (val){
                                     if(val!="0"){
                                       tempId1IssueMonth = val;
                                       if(int.parse(val)<=12&&int.parse(val)>0){

                                         if(val.length==2){
                                           CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(3, 5, val);

                                           FocusScope.of(context).requestFocus(yearid1IssueFocus);
                                         }
                                         else{
                                           CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(3, 5, "0"+val);
                                         }
                                       }
                                       else {
                                         setState(() {
                                           tempId1IssueMonth ="";
                                         });

                                       }
                                     }



                                   },

                                 ),
                               )
                               ,
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: new Text("/"),
                               ),

                               Container(
                                 width:80,

                                 child:new TextField(


                                  decoration: InputDecoration(
                                    hintText: Translations.of(context).text('YYYY'),

                                   ),

                                   keyboardType: TextInputType.numberWithOptions(),
                                   inputFormatters: [
                                     new LengthLimitingTextInputFormatter(4),
                                     globals.onlyIntNumber
                                   ],


                                   focusNode: yearid1IssueFocus,
                                   controller: tempId1IssueYear == null?null:new TextEditingController(text: tempId1IssueYear),
                                   onChanged: (val){
                                     tempId1IssueYear = val;
                                     if(val.length==4) CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(6, 10,val);

                                   },
                                 ),)
                               ,

                               SizedBox(
                                 width: 50.0,
                               ),

                               IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                 _selectId1IssueDate(context);
                               } )
                             ],


                           ),

                         ),




                         SizedBox(height: 20.0,),
                        isFullerTon==1?new Container(): Container(
                          // decoration: BoxDecoration(color: Constant.mandatoryColor),
                           child: new Row(

                             children: <Widget>[Text(Translations.of(context).text('id1Exp'))],
                           ),
                         ),
                        isFullerTon==1?new Container():  new Container(
                           //decoration: BoxDecoration(color: Constant.mandatoryColor,),



                          child: new Row(
                            children: <Widget>[
                              new Container(
                                width: 50.0,
                                child: new TextField(
                                    decoration:
                                    InputDecoration(
                                        hintText: Translations.of(context).text('DD')
                                    ),
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(2),
                                      globals.onlyIntNumber
                                    ],
                                    controller: tempId1ExpDay == null?null:new TextEditingController(text: tempId1ExpDay),
                                    keyboardType: TextInputType.numberWithOptions(),

                                     onChanged: (val){

                                       if(val!="0"){
                                         tempId1ExpDay = val;


                                         if(int.parse(val)<=31&&int.parse(val)>0){



                                           if(val.length==2){
                                             CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(0, 2, val);
                                             FocusScope.of(context).requestFocus(monthid1ExpFocus);
                                           }
                                           else{
                                             CustomerFormationMasterTabsState.id1ExpDate= CustomerFormationMasterTabsState.id1ExpDate.replaceRange(0, 2, "0"+val);
                                           }


                                         }
                                         else {
                                           setState(() {
                                             tempId1ExpDay ="";
                                           });

                                         }


                                       }
                                     }

                                 ),

                               )
                               ,


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text("/"),
                              ),
                              new Container(
                                width: 50.0,
                                child: new TextField(
                                  decoration: InputDecoration(
                                    hintText: Translations.of(context).text('MM'),


                                   ),

                                   keyboardType: TextInputType.numberWithOptions(),
                                   inputFormatters: [
                                     new LengthLimitingTextInputFormatter(2),
                                     globals.onlyIntNumber
                                   ],
                                   focusNode: monthid1ExpFocus,
                                   controller: tempId1ExpMonth == null?null:new TextEditingController(text: tempId1ExpMonth),
                                   onChanged: (val){
                                     if(val!="0"){
                                       tempId1ExpMonth = val;
                                       if(int.parse(val)<=12&&int.parse(val)>0){

                                         if(val.length==2){
                                           CustomerFormationMasterTabsState.id1ExpDate= CustomerFormationMasterTabsState.id1ExpDate.replaceRange(3, 5, val);

                                           FocusScope.of(context).requestFocus(yearid1ExpFocus);
                                         }
                                         else{
                                           CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(3, 5, "0"+val);
                                         }
                                       }
                                       else {
                                         setState(() {
                                           tempId1ExpMonth ="";
                                         });

                                       }
                                     }



                                   },

                                 ),
                               )
                               ,
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: new Text("/"),
                               ),

                               Container(
                                 width:80,

                                 child:new TextField(


                                  decoration: InputDecoration(
                                    hintText: Translations.of(context).text('YYYY'),

                                   ),

                                   keyboardType: TextInputType.numberWithOptions(),
                                   inputFormatters: [
                                     new LengthLimitingTextInputFormatter(4),
                                     globals.onlyIntNumber
                                   ],


                                   focusNode: yearid1ExpFocus,
                                   controller: tempId1ExpYear == null?null:new TextEditingController(text: tempId1ExpYear),
                                   onChanged: (val){
                                     tempId1ExpYear = val;
                                     if(val.length==4) CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(6, 10,val);

                                   },
                                 ),)
                               ,

                               SizedBox(
                                 width: 50.0,
                               ),

                               IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                 _selectId1ExpDate(context);
                               } )
                             ],


                           ),

                         ),


                    ],
                  ),
          ),
                  new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: Text(
                      Translations.of(context).text('Click_Below_for_pic'),
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
                                  getCircleContainer(1),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(1);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
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
                                  getCircleContainer(2),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(2);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
          new Card(
              elevation: 5.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButtonFormField(
                      value: id2,
                      items: generateDropDown(1),
                      onChanged: (LookupBeanData newValue) {
                        showDropDown(newValue, 1);
                      },
                      validator: (args) {
                        print(args);
                      },
                      //  isExpanded: true,
                      //hint:Text("Select"),
                      decoration: InputDecoration(
                        labelText: globals.captionIdType[1],
                        hintText: globals.captionIdType[1],
                      ),
                      // style: TextStyle(color: Colors.grey),
                    ),
                  ),
        new Form(
          key: _formKeyid2,
          //autovalidate: CustomerFormationMasterTabsState.autoValidate,
          onWillPop: () {
            return Future(() => true);
          }
          ,onChanged: () {
          final FormState form = _formKeyid2.currentState;
          form.save();
        },
                    child: new Column(
                      children: <Widget>[
                        Container(
                          color: id2Mand == true?Constant.mandatoryColor:Colors.white,
                          child: new TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(

                              hintText: Translations.of(context).text('Enter_ID2_detail'),
                              labelText: Translations.of(context).text('ID2_detail'),
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
                            initialValue:
                            CustomerFormationMasterTabsState.custListBean.mIdDesc!= null&&
                                CustomerFormationMasterTabsState.custListBean.mIdDesc!="null" ?
                            CustomerFormationMasterTabsState.custListBean.mIdDesc : "",
                            onSaved: (val) => CustomerFormationMasterTabsState.custListBean.mIdDesc = val,
                          ),
                        ),




                        SizedBox(height: 20.0,),
                        isFullerTon==1?new Container():      Container(
                          //decoration: BoxDecoration(color: Constant.mandatoryColor),
                          child: new Row(

                            children: <Widget>[Text(Translations.of(context).text('id2Issue'))],
                          ),
                        ),
                        isFullerTon==1?new Container():     new Container(
                          //decoration: BoxDecoration(color: Constant.mandatoryColor,),



                          child: new Row(
                            children: <Widget>[
                              new Container(
                                width: 50.0,
                                child: new TextField(
                                    decoration:
                                    InputDecoration(
                                        hintText: Translations.of(context).text('DD')
                                    ),
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(2),
                                      globals.onlyIntNumber
                                    ],
                                    controller: tempId2IssueDay == null?null:new TextEditingController(text: tempId2IssueDay),
                                    keyboardType: TextInputType.numberWithOptions(),

                                    onChanged: (val){

                                      if(val!="0"){
                                        tempId2IssueDay = val;


                                        if(int.parse(val)<=31&&int.parse(val)>0){



                                          if(val.length==2){
                                            CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(0, 2, val);
                                            FocusScope.of(context).requestFocus(monthid2IssueFocus);
                                          }
                                          else{
                                            CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(0, 2, "0"+val);
                                          }


                                        }
                                        else {
                                          setState(() {
                                            tempId2IssueDay ="";
                                          });

                                        }


                                      }
                                    }

                                ),

                              )
                              ,


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text("/"),
                              ),
                              new Container(
                                width: 50.0,
                                child: new TextField(
                                  decoration: InputDecoration(
                                    hintText: Translations.of(context).text('MM'),


                                  ),

                                  keyboardType: TextInputType.numberWithOptions(),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(2),
                                    globals.onlyIntNumber
                                  ],
                                  focusNode: monthid2IssueFocus,
                                  controller: tempId2IssueMonth == null?null:new TextEditingController(text: tempId2IssueMonth),
                                  onChanged: (val){
                                    if(val!="0"){
                                      tempId2IssueMonth = val;
                                      if(int.parse(val)<=12&&int.parse(val)>0){

                                        if(val.length==2){
                                          CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(3, 5, val);

                                          FocusScope.of(context).requestFocus(yearid2IssueFocus);
                                        }
                                        else{
                                          CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(3, 5, "0"+val);
                                        }
                                      }
                                      else {
                                        setState(() {
                                          tempId2IssueMonth ="";
                                        });

                                      }
                                    }



                                  },

                                ),
                              )
                              ,
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text("/"),
                              ),

                              Container(
                                width:80,

                                child:new TextField(


                                  decoration: InputDecoration(
                                    hintText: Translations.of(context).text('YYYY'),

                                  ),

                                  keyboardType: TextInputType.numberWithOptions(),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(4),
                                    globals.onlyIntNumber
                                  ],


                                  focusNode: yearid2IssueFocus,
                                  controller: tempId2IssueYear == null?null:new TextEditingController(text: tempId2IssueYear),
                                  onChanged: (val){
                                    tempId2IssueYear = val;
                                    if(val.length==4) CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(6, 10,val);

                                  },
                                ),)
                              ,

                              SizedBox(
                                width: 50.0,
                              ),

                              IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                _selectId2IssueDate(context);
                              } )
                            ],


                          ),

                        ),




                        SizedBox(height: 20.0,),
                        isFullerTon==1?new Container():    Container(
                         // decoration: BoxDecoration(color: Constant.mandatoryColor),
                          child: new Row(

                            children: <Widget>[Text(Translations.of(context).text('id2Exp'))],
                          ),
                        ),
                        isFullerTon==1?new Container():      new Container(
                          //decoration: BoxDecoration(color: Constant.mandatoryColor,),



                          child: new Row(
                            children: <Widget>[
                              new Container(
                                width: 50.0,
                                child: new TextField(
                                    decoration:
                                    InputDecoration(
                                        hintText: Translations.of(context).text('DD')
                                    ),
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(2),
                                      globals.onlyIntNumber
                                    ],
                                    controller: tempId2ExpDay == null?null:new TextEditingController(text: tempId2ExpDay),
                                    keyboardType: TextInputType.numberWithOptions(),

                                    onChanged: (val){

                                      if(val!="0"){
                                        tempId2ExpDay = val;


                                        if(int.parse(val)<=31&&int.parse(val)>0){



                                          if(val.length==2){
                                            CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(0, 2, val);
                                            FocusScope.of(context).requestFocus(monthid2ExpFocus);
                                          }
                                          else{
                                            CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(0, 2, "0"+val);
                                          }


                                        }
                                        else {
                                          setState(() {
                                            tempId2ExpDay ="";
                                          });

                                        }


                                      }
                                    }

                                ),

                              )
                              ,


                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text("/"),
                              ),
                              new Container(
                                width: 50.0,
                                child: new TextField(
                                  decoration: InputDecoration(
                                    hintText: Translations.of(context).text('MM'),


                                  ),

                                  keyboardType: TextInputType.numberWithOptions(),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(2),
                                    globals.onlyIntNumber
                                  ],
                                  focusNode: monthid2ExpFocus,
                                  controller: tempId2ExpMonth == null?null:new TextEditingController(text: tempId2ExpMonth),
                                  onChanged: (val){
                                    if(val!="0"){
                                      tempId2ExpMonth = val;
                                      if(int.parse(val)<=12&&int.parse(val)>0){

                                        if(val.length==2){
                                          CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(3, 5, val);

                                          FocusScope.of(context).requestFocus(yearid2ExpFocus);
                                        }
                                        else{
                                          CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(3, 5, "0"+val);
                                        }
                                      }
                                      else {
                                        setState(() {
                                          tempId2ExpMonth ="";
                                        });

                                      }
                                    }



                                  },

                                ),
                              )
                              ,
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text("/"),
                              ),

                              Container(
                                width:80,

                                child:new TextField(


                                  decoration: InputDecoration(
                                    hintText: Translations.of(context).text('YYYY'),

                                  ),

                                  keyboardType: TextInputType.numberWithOptions(),
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(4),
                                    globals.onlyIntNumber
                                  ],


                                  focusNode: yearid2ExpFocus,
                                  controller: tempId2ExpYear == null?null:new TextEditingController(text: tempId2ExpYear),
                                  onChanged: (val){
                                    tempId2ExpYear = val;
                                    if(val.length==4) CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(6, 10,val);

                                  },
                                ),)
                              ,

                              SizedBox(
                                width: 50.0,
                              ),

                              IconButton(icon: Icon(Icons.calendar_today), onPressed:(){
                                _selectId2ExpDate(context);
                              } )
                            ],


                          ),

                        ),



                      ],
                    ),
                  ),

                  new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: Text(
                      Translations.of(context).text('Click_Below_for_pic'),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new Center(
                              child: new Stack(
                                children: <Widget>[
                                  getCircleContainer(3),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(3);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
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
                                  getCircleContainer(4),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(4);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new Center(
                              child: new Stack(
                                children: <Widget>[
                                  getCircleContainer(5),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(5);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
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
                                  getCircleContainer(6),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(6);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
          new Card(
              elevation: 5.0,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  new Text(
                    Translations.of(context).text('Click_passbook_photos'),
                    style: TextStyle(color: Colors.grey),
                  ),
                  new Container(
                    padding: new EdgeInsets.all(8.0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new Center(
                              child: new Stack(
                                children: <Widget>[
                                  getCircleContainer(7),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(7);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
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
                                  getCircleContainer(8),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(8);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Flexible(
                        child: new Column(
                          children: <Widget>[
                            new Center(
                              child: new Stack(
                                children: <Widget>[
                                  getCircleContainer(9),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(9);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
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
                                  getCircleContainer(10),

                                  new Positioned(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                                         onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                          print("Here");
                                          _PickImage(10);
                                        },
                                      ),
                                    ),

                                    top: 100.0,
                                    left: 120.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
/*
  _navigateAndDisplaySelection(BuildContext context, String str) async {
    globals.imageType = str;
    if (widget.cameras == null) {
      //widget.cameras = await availableCameras();
    }
    final result = Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new OpenCamera(),
          fullscreenDialog: true,
        )).then((onValue) {
      if (onValue != null) {
        setState(() {
          _changed(onValue, str);
        });
      }

      setState(() {});
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$onValue")));
    });
  }*/

  void _changed(String filePath, String str) {
    setState(() {
      if (str == "id1") {
        globals.imageVisibilityKyc1AppId1TagCustomer = true;
        globals.kyc1AppId1PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgSubType = 'Kyc1Id1';
        imgBean.imgType = str;
        CustomerFormationMasterTabsState.custListBean.imageMaster.insert(1, imgBean);
        /*globals.listImgBean.add(imgBean);*/
        // globals.listImgBean.insert(1,imgBean);
      } else if (str == "id12") {
        globals.imageVisibilityKyc1AppId12TagCustomer = true;
        globals.kyc1AppId12PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Id1';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(2,imgBean);
      } else if (str == "id2") {
        globals.imageVisibilityKyc1AppId2TagCustomer = true;
        globals.kyc1AppId2PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Id2';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(3,imgBean);
      } else if (str == "id22") {
        globals.imageVisibilityKyc1AppId22TagCustomer = true;
        globals.kyc1AppId22PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Id2';
        globals.listImgBean.add(imgBean);
        // globals.listImgBean.insert(4,imgBean);
      } else if (str == "id23") {
        globals.imageVisibilityKyc1AppId23TagCustomer = true;
        globals.kyc1AppId23PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Id2';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(5,imgBean);
      } else if (str == "id24") {
        globals.imageVisibilityKyc1AppId24TagCustomer = true;
        globals.kyc1AppId24PicTagCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgSubType = 'Kyc1Id2';
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(6,imgBean);
      } else if (str == "passbook2") {
        globals.imageVisibilityKyc1PassBook2TagCustomer = true;
        globals.kyc1PassBook2TagPicCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Passbook';
        globals.listImgBean.add(imgBean);
        // globals.listImgBean.insert(7,imgBean);
      } else if (str == "passbook1") {
        globals.imageVisibilityKyc1PassBook1TagCustomer = true;
        globals.kyc1PassBook1TagPicCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Passbook';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(8,imgBean);
      } else if (str == "passbook3") {
        globals.imageVisibilityKyc1PassBook3TagCustomer = true;
        globals.kyc1PassBook3TagPicCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Passbook';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(9,imgBean);
      } else if (str == "passbook4") {
        globals.imageVisibilityKyc1PassBook4TagCustomer = true;
        globals.kyc1PassBook4TagPicCustomer = filePath;
        ImageBean imgBean = new ImageBean();
        imgBean.imgString = filePath;
        imgBean.imgType = str;
        imgBean.imgSubType = 'Kyc1Passbook';
        globals.listImgBean.add(imgBean);
        //globals.listImgBean.insert(10,imgBean);
      }
    });
  }
  Future<Null> _selectId1IssueDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid1issuedate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid1issuedate= picked;
        tempId1IssueDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId1IssueDay = "0"+picked.day.toString();

        }
        else tempId1IssueDay = picked.day.toString();
        CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(0, 2, tempId1IssueDay);
        tempId1IssueYear = picked.year.toString();
        CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(6, 10,tempId1IssueYear);
        if(picked.month.toString().length==1){
          tempId1IssueMonth = "0"+picked.month.toString();
        }
        else
          tempId1IssueMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id1IssueDate = CustomerFormationMasterTabsState.id1IssueDate.replaceRange(3, 5, tempId1IssueMonth);

      });
  }


  Future<Null> _selectId1ExpDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid1expdate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid1expdate= picked;
        tempId1ExpDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId1ExpDay = "0"+picked.day.toString();

        }
        else tempId1ExpDay = picked.day.toString();
        CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(0, 2, tempId1ExpDay);
        tempId1ExpYear = picked.year.toString();
        CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(6, 10,tempId1ExpYear);
        if(picked.month.toString().length==1){
          tempId1ExpMonth = "0"+picked.month.toString();
        }
        else
          tempId1ExpMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id1ExpDate = CustomerFormationMasterTabsState.id1ExpDate.replaceRange(3, 5, tempId1ExpMonth);

      });
  }


  Future<Null> _selectId2ExpDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid2expdate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid2expdate= picked;
        tempId2ExpDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId2ExpDay = "0"+picked.day.toString();

        }
        else tempId2ExpDay = picked.day.toString();
        CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(0, 2, tempId2ExpDay);
        tempId2ExpYear = picked.year.toString();
        CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(6, 10,tempId2ExpYear);
        if(picked.month.toString().length==1){
          tempId2ExpMonth = "0"+picked.month.toString();
        }
        else
          tempId2ExpMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id2ExpDate = CustomerFormationMasterTabsState.id2ExpDate.replaceRange(3, 5, tempId2ExpMonth);

      });
  }

  Future<Null> _selectId2IssueDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != CustomerFormationMasterTabsState
        .custListBean.mid2issuedate)
      setState(() {
        CustomerFormationMasterTabsState.custListBean.mid2issuedate= picked;
        tempId2IssueDate = formatter.format(picked);
        if(picked.day.toString().length==1){
          tempId2IssueDay = "0"+picked.day.toString();

        }
        else tempId2IssueDay = picked.day.toString();
        CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(0, 2, tempId2IssueDay);
        tempId2IssueYear = picked.year.toString();
        CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(6, 10,tempId2IssueYear);
        if(picked.month.toString().length==1){
          tempId2IssueMonth = "0"+picked.month.toString();
        }
        else
          tempId2IssueMonth = picked.month.toString();
        CustomerFormationMasterTabsState.id2IssueDate = CustomerFormationMasterTabsState.id2IssueDate.replaceRange(3, 5, tempId2IssueMonth);

      });
  }



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

  Widget getCircleContainer(int i) {
    imageCache.clear();
    try {
      return
        new GestureDetector(
          onTap: () {
            print("Inside circle cont"+i.toString());
            print("Container clicked ${CustomerFormationMasterTabsState
                .custListBean
                .imageMaster[i]
                .imgString}");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();

            if (CustomerFormationMasterTabsState
                .custListBean
                .imageMaster[i]
                .imgString !=
                null &&
                CustomerFormationMasterTabsState
                    .custListBean.imageMaster !=
                    null &&
                CustomerFormationMasterTabsState
                    .custListBean
                    .imageMaster[i]
                    .imgString !=
                    "") {
              docListView = new List<PhotoViewGalleryPageOptions>();
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(CustomerFormationMasterTabsState
                          .custListBean.imageMaster[i].imgString)
                          .readAsBytesSync())));
              _showImage();
            } else {
              _PickImage(i);
            }
          },
          child:
          new Container(
            width: 200.0,
            height: 200.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(color: Color(0xff07426A), width: 0.3),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,
                  image:
                  CustomerFormationMasterTabsState
                      .custListBean.imageMaster !=
                      null &&
                      CustomerFormationMasterTabsState
                          .custListBean
                          .imageMaster[i]
                          .imgString !=
                          null &&
                      CustomerFormationMasterTabsState
                          .custListBean.imageMaster !=
                          null &&
                      CustomerFormationMasterTabsState
                          .custListBean
                          .imageMaster[i]
                          .imgString !=
                          ""
                      ?
                  MemoryImage(File(CustomerFormationMasterTabsState
                      .custListBean.imageMaster[i].imgString).readAsBytesSync())

                      : new ExactAssetImage('assets/Document.png'),

                )

            ),
          ),
        );
    }catch(_){
      return
        new GestureDetector(
          onTap: () {
            print("Container clicked");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();
            print(
                "CustomerFormationMasterTabsState.custListBean.imageMaster[i].imgString ${CustomerFormationMasterTabsState
                    .custListBean.imageMaster[i].imgString}");
            if (CustomerFormationMasterTabsState
                .custListBean
                .imageMaster[i]
                .imgString !=
                null &&
                CustomerFormationMasterTabsState
                    .custListBean.imageMaster !=
                    null &&
                CustomerFormationMasterTabsState
                    .custListBean
                    .imageMaster[i]
                    .imgString !=
                    "") {
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(CustomerFormationMasterTabsState
                          .custListBean.imageMaster[i].imgString)
                          .readAsBytesSync())));
              _showImage();
            } else {
              _PickImage(i);
            }
          },
          child:
          new Container(
            width: 200.0,
            height: 200.0,
            decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(color: Color(0xff07426A), width: 0.3),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,

                )

            ),
          ),
        );
    }

  }

  Future<void> _showImage() async {

    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            ViewImageScreen()));
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

