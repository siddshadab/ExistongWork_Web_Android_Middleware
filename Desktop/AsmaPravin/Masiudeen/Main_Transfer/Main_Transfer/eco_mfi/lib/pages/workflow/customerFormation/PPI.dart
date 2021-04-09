import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/Utilities/ReadXmlCost.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/FullScreenDialogForPurposeSelection.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/FullScreenDialogPPIAnswerPickList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewCustomerFormationFamilyDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ViewCustomerFormationPPIDetails.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/PPIBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

import '../../../translations.dart';

class PPI extends StatefulWidget {
  @override
  _PPI createState() => new _PPI();
}

class _PPI extends State<PPI> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  LookupBeanData mitems;
  LookupBeanData questionType;
  List<int> selectedIndex = new List<int>();
  List<DataRow> _sampleDataRows = new List<DataRow>();
  List<DataColumn> _dataColumns = new List<DataColumn>();
  var rows2;
  var cols2;
  int count = 0;
  final TextEditingController _controller = new TextEditingController();
  static bool isSubmitClicked = false;
  PPIMasterBean ppiBean = new PPIMasterBean();
  final List<PPIMasterBean> ppiMasterBean =  new List<PPIMasterBean>();
  String answerdesc="";
  bool isBool = false;
  int i = 0;

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


  void getRow() async{
    List<TempPPIDisplayBean> tempDisplayBeanList = new List();

    rows2 = new List.generate(0,
            (int a) =>
        new DataRow(
            cells: [
              new DataCell(
                  new Text("")),
              new DataCell(
                  new Text(""
                  )),
              new DataCell(new Text("")),
              new DataCell(new Text(""))
              ,
            ]));


    for(int display =0;display< CustomerFormationMasterTabsState.custListBean.pPIMasterBean.length;display++){
      //print("CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mitem "+CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mitem.toString());
      TempPPIDisplayBean bean = new TempPPIDisplayBean();
      int ansCode =0;
      // try{
      ansCode = int.parse(CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mitem.trim());
      /* }catch(_){

      }*/
      print("get row se question desc k lie call mara");
      await AppDatabase.get().getQuesDesc(70771,CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mitem,CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mquestiontype).then((onValue) async{
        bean.quetionDesc =onValue;
        print("Added bean .quest desc is ${bean.quetionDesc}");
       /* print("[display].mitem.trim() "+CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mitem.trim());
        print("70771 +ansCode"+70771.toString() +ansCode.toString());*/
        print("get row se answer description k lie call mara" );
        await AppDatabase.get().getAnswerDesc(70771 +ansCode,CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mhaveyn.trim()).then((onValue) {
          bean.answerDesc=onValue;
        });

        try{


        await AppDatabase.get().getQuesDesc(46002 ,CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mquestiontype.trim()).then((onValue) {
          bean.questionType=onValue;
        });
        }catch(_){

        }
        // bean.answerDesc = CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mhaveyn;
        bean.weitage = CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mweightage;
        tempDisplayBeanList.add(bean);
      });
      // bean.quetionDesc = CustomerFormationMasterTabsState.custListBean.pPIMasterBean[display].mitem;

    }



    rows2 = new List.generate(
        tempDisplayBeanList.length,
            (int a) =>
        new DataRow(
            selected: selectedIndex.contains(a) ? true : false,
            onSelectChanged: (val) {
              getRow();
              if (selectedIndex.contains(a)) {
               // print("a is there");
                selectedIndex.remove(a);
              }
              else {
                //print("adding a");
                selectedIndex.add(a);
              }


              //print("${a}  bool is ${val}");
              setState(() {
                getRow();
              });
            },


            cells: [
              new DataCell(
                  new Text(tempDisplayBeanList[a].questionType==null || tempDisplayBeanList[a].questionType=='null' ?"" : tempDisplayBeanList[a].questionType)),
              new DataCell(
                  new Text(tempDisplayBeanList[a].quetionDesc==null || tempDisplayBeanList[a].quetionDesc=='null' ?"" : tempDisplayBeanList[a].quetionDesc)),
              new DataCell(
                  new Text(tempDisplayBeanList[a].answerDesc==null || tempDisplayBeanList[a].answerDesc=='null' ? "" :
                  tempDisplayBeanList[a].answerDesc.toString()
                  )),
              new DataCell(new Text(
                  tempDisplayBeanList[a].weitage.toString()),),
            ]));
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
//set answerdesc when comin back
    //adding
    List columnName = [
      "Question Type",
      "PPI Question",
      "PPI Answer",
      "PPI weightage",
    ];

    List<DataCell> _dataCells = ['A', 'B', 'C','D']
        .map((c) => DataCell(Text(c)))
        .toList();
    _sampleDataRows =
        [0, 1, 2,3].map((i) => DataRow(cells: _dataCells)).toList();
    _dataColumns = [0, 1, 2,3]
        .map((i) => DataColumn(label: Text(columnName[i])))
        .toList();
    getRow();
    cols2 = [
      new DataColumn(
        label: const Text("Question Type"),
      ),
      new DataColumn(
        label: const Text("PPI Question"),
      ),
      new DataColumn(
        label: const Text("PPI Answer"),
      ),
      new DataColumn(
        label: const Text("PPI weightage"),
      ),

    ];
    setState(() {

    });
    //ends
    super.initState();



    if (!isBool) {
      isBool = true;
    }

    if(CustomerFormationMasterTabsState.ppiBean!=null){


      // for (int k = 0; k < globals.dropdownCaptionsValuePPIDetails.length; k++) {
      //   for (int i = 0; i < globals.dropdownCaptionsValuePPIDetails[k].length; i++) {


      //     if (k == 0) {
      //       print("for k = 0 codes are ${globals.dropdownCaptionsValuePPIDetails[k][i].mcode}");
      //       if (globals.dropdownCaptionsValuePPIDetails[k][i].mcode ==
      //           CustomerFormationMasterTabsState.ppiBean.mitem) {
      //         setValue(k, globals.dropdownCaptionsValuePPIDetails[k][i]);


      //       }
      //     }
      //     else if (k==1){
      //       if (globals.dropdownCaptionsValuePPIDetails[k][i].mcode ==
      //           CustomerFormationMasterTabsState.ppiBean.mquestiontype) {
      //         setValue(k, globals.dropdownCaptionsValuePPIDetails[k][i]);


      //       }


      //     }

      //   }


      // }
    }else{
      CustomerFormationMasterTabsState.ppiBean= new PPIMasterBean();
    }

  }


  showDropDown(LookupBeanData selectedObj, int no) {
    //  print(" mitems type "+mitems.mcode.toString());
    print("selected Obj is ${selectedObj}");
    if(selectedObj.mcodedesc.isEmpty){
     // print("inside  code Desc is null");
      switch (no) {
        case 0:
          mitems = blankBean;
          CustomerFormationMasterTabsState.ppiBean.mitem = selectedObj.mcode;
          break;

        case 1:
          questionType = blankBean;
          CustomerFormationMasterTabsState.ppiBean.mquestiontype = selectedObj.mcode;
          print("phirse genrate drop down");
          //generateDropDown(1);
          break;  
        default:
          break;
      }
      setState(() {

      });
    }
    else {
      bool isBreak = false;
      for (int k = 0;
      k < globals.dropdownCaptionsValuePPIDetails[no].length;
      k++) {
        if (globals.dropdownCaptionsValuePPIDetails[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuePPIDetails[no][k]);
          isBreak=true;
          break;
        }
        if(isBreak){
          break;
        }
      }
    }


  }
  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);


  setValue(int no, LookupBeanData value) {
    print("value is ${value}");
    setState(() {
      print("coming here  value.mcode"+ value.mcode.toString());
      switch (no) {
        case 0:
          mitems = value;
          CustomerFormationMasterTabsState.ppiBean.mitem = value.mcode;
          //print("CustomerFormationMasterTabsState.ppiBean.mitem "+CustomerFormationMasterTabsState.ppiBean.mitem.toString());
          break;

        case 1:
        print("setting Value with ${value.mcode} "  );
          questionType= value;
          CustomerFormationMasterTabsState.ppiBean.mquestiontype = value.mcode;
          //print("CustomerFormationMasterTabsState.ppiBean.mitem "+CustomerFormationMasterTabsState.ppiBean.mitem.toString());
        
          break;  
        default:
          break;
      }
    });
  }

  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    //print("caption value : " + globals.dropdownCaptionsFamilyDetails[no]);

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    bean.mcode = "";
    bean.mcodetype = 0;
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuePPIDetails[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuePPIDetails[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
     // print("data here is of  dropdownwale biayajai " + value.mcodedesc);
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




  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        top: false,
        bottom: false,


        child: ListView(padding: EdgeInsets.all(20.0), children: <Widget>[
          new DropdownButtonFormField(
            value: questionType==null?null: questionType,
            items: generateDropDown(1),
            onChanged: (LookupBeanData newValue) async  {
              print("new Value is ${newValue}");
              print(globals.dropdownCaptionsValuePPIDetails);
              showDropDown(newValue, 1);
              print("on changesd k andar se call mara");

             await AppDatabase.get().getLookupDataFromLocalDb(70771,CustomerFormationMasterTabsState.ppiBean.mquestiontype).then((onValue) {
            globals.dropdownCaptionsValuePPIDetails[0].clear();
            print("Returned from ${70771} ${CustomerFormationMasterTabsState.ppiBean.mquestiontype} vals--");
            print(onValue);
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuePPIDetails[0].add(bean);
      }

      //generateDropDown(0);
    }); 
    globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
    setState(() {
      
    });
            },
            validator: (args) {
              //print(args);
            },
            decoration: InputDecoration(labelText: Translations.of(context).text('questionType')),
                 ),




                 SizedBox(height: 16.0),


                 new DropdownButtonFormField(
            value: mitems==null?null: mitems,
            items: generateDropDown(0),
            onChanged: (LookupBeanData newValue) {
              if(questionType==null||questionType==blankBean){
                _showAlert(Translations.of(context).text("questionType"), Translations.of(context).text("Choose Question Type first"));
                return;
              }
              print("new Value is ${newValue}");
              showDropDown(newValue, 0);
              globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
            },
            validator: (args) {
             // print(args);
            },
            decoration: InputDecoration(labelText: globals.dropdownCaptionsPPIDetails[0]),
                 ),
                 SizedBox(height: 16.0),
                 new Card(
                   child: new ListTile(
                       title: new Text(Translations.of(context).text('Select_PPI_Ans')),
                       subtitle: answerdesc == null || answerdesc=='null'
                           ? new Text("")
                           : new Text( (Translations.of(context).text('PPI') +"${answerdesc}")),
                       onTap: () => getPPIAns("PPI",
                           int.parse(mitems!=null && mitems.mcode != null && mitems.mcode!='null' ? mitems.mcode.trim() : 0),CustomerFormationMasterTabsState.ppiBean.mquestiontype)),
                 ),

          new Container(
            width: 300.0,
            height: 10.0,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: new IconButton(
                  icon: new Icon(
                    Icons.delete,
                    color: Color(0xff07426A),
                    size: 50.0,
                  ),
                  onPressed: deleteSelected
                ),
              ),
              Flexible(
                  child: new IconButton(
                      padding: EdgeInsets.only(right: 30.0),
                      icon: new Icon(
                        Icons.add,
                        color: Color(0xff07426A),
                        size: 50.0,
                      ),
                      splashColor: Colors.red,
                       onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                        addToList();
                      })),
            ],
          ),
          SingleChildScrollView(

            scrollDirection: Axis.horizontal,
            child: DataTable(
              rows: rows2,
              columns: cols2,
            ),
          ),
        ])

    );
  }

  void deleteSelected(){
      print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXDELETE HO Rahi hain chizenXXXXXXXXXXXXXXXXXXXXX");
    for( var items in selectedIndex){
      CustomerFormationMasterTabsState.custListBean.pPIMasterBean.removeAt(items);
    }
    selectedIndex.clear();
    setState(() {
      getRow();
    });
  }

  void addToList() {

    if(CustomerFormationMasterTabsState.custListBean.pPIMasterBean==null){
      print("XXXXXXXXXXXXXXxxxxxxxxAdding new LIStXXXXXXXXXXxxx"); 
      CustomerFormationMasterTabsState.custListBean.pPIMasterBean= new  List<PPIMasterBean>();
    }

    if(CustomerFormationMasterTabsState.ppiBean.mquestiontype==null||CustomerFormationMasterTabsState.ppiBean.mquestiontype==''){

      globals.Dialog.alertPopup(context,Translations.of(context).text('error'),Translations.of(context).text('questionType'),"PPI");
    }
    if(CustomerFormationMasterTabsState.ppiBean.mhaveyn==null||CustomerFormationMasterTabsState.ppiBean.mhaveyn==""){
      globals.Dialog.alertPopup(context,Translations.of(context).text('error'),Translations.of(context).text('answer should not be blank'),"PPI");
    }
    if(CustomerFormationMasterTabsState.ppiBean.mitem!=null&&CustomerFormationMasterTabsState.ppiBean.mitem!="null"){

      print("adding ${CustomerFormationMasterTabsState.ppiBean}");
      CustomerFormationMasterTabsState.ppiBean.trefno = CustomerFormationMasterTabsState.custListBean.trefno;
      if(CustomerFormationMasterTabsState.ppiBean.mrefno==null) CustomerFormationMasterTabsState.ppiBean.mrefno = 0;
      else  CustomerFormationMasterTabsState.ppiBean.mrefno = CustomerFormationMasterTabsState.custListBean.mrefno;

      CustomerFormationMasterTabsState.ppiBean.mPpirefno = 0;



      CustomerFormationMasterTabsState.ppiBean.tPpirefno = CustomerFormationMasterTabsState.custListBean.pPIMasterBean.length + 1;

      CustomerFormationMasterTabsState.custListBean.pPIMasterBean.add(CustomerFormationMasterTabsState.ppiBean);

      mitems = blankBean;

      answerdesc="";
      questionType = blankBean;
      globals.dropdownCaptionsValuePPIDetails[0].clear();
      
      getRow();
      //globals.familyDetailsList.insert(listLength, fdb);
      setState(() {
        CustomerFormationMasterTabsState.ppiBean = new PPIMasterBean();
      });

      print("PPI Bean add krne k baad return aaya  ${CustomerFormationMasterTabsState.custListBean.pPIMasterBean}");
    } else {
      globals.Dialog.alertPopup(context,Translations.of(context).text('error'),Translations.of(context).text('Add_PPI_Ques'),"PPI");
    }
  }

  getPPIAns(String s, int selectedPosition,String questionType) async{

    await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogPPIAnswerPickList(position: selectedPosition ,  questionType : questionType),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((purposeObjVal) {

          if(purposeObjVal!=null){
            print("PPI " + purposeObjVal.codeDesc.toString());
            print("PPI code " + purposeObjVal.code.toString());
            //subPurposeName=purposeObjVal.codeDesc;
            //subPurposeId = purposeObjVal.code;
            //print("purposeObjVal.fieldValue1 "+purposeObjVal.codeType.toString());
            CustomerFormationMasterTabsState.ppiBean.mhaveyn = purposeObjVal.code;
            answerdesc=purposeObjVal.codeDesc;

            if(purposeObjVal.fieldValue1!=null){
              try{
                List<String > ar= purposeObjVal.fieldValue1.split('~');
                CustomerFormationMasterTabsState.ppiBean.mweightage = double.parse(ar[1]);


              }catch(_){
                CustomerFormationMasterTabsState.ppiBean.mweightage = purposeObjVal.fieldValue1!=null && purposeObjVal.fieldValue1!='null' && purposeObjVal.fieldValue1!=''?double.parse(purposeObjVal.fieldValue1):0;

              }



            }
          }


    });
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


}