



import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanAddressDetails.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDeclaration.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/List/CustomerLoanDetailsList.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/LoanLimitDetails.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/TabsDisplayBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

class CustomerLoanDetailsMasterTab extends StatefulWidget {
  CustomerLoanDetailsBean laonLimitPassedObject;
  CustomerLoanDetailsMasterTab({Key key, this.laonLimitPassedObject}) : super(key: key);


  @override
  CustomerLoanDetailsMasterTabState createState() => new CustomerLoanDetailsMasterTabState();
}

class CustomerLoanDetailsMasterTabState extends State<CustomerLoanDetailsMasterTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  int branch = 0;
  String branchName;
  String operationDate;
  int spouseTabNeeded = 0;
  int lbrcode;
  int isFullerTon=0;
   List<String> tabNames ;
  double incAmount=0.0;
  int isBiometricNeeded =0;


  static CustomerLoanDetailsBean customerLoanDetailsBeanObj = new CustomerLoanDetailsBean();

  static int mcenterId;
  static int mgrpID;
  static bool isMemeberOfGroupForLoan = true;
  static bool isMarried = false;


  List<Widget> tabWidget =[ ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabNames = ["Basic Details","Contact Details"];


    tabWidget.add(new LoanLimitDetails());
    tabWidget.add(new CustomerLoanAddressDetails());
    if(Constant.isSpouseTabNeeded==true){
      tabWidget.add(new CustomerLoanDeclaration());
      tabNames.add("Spouse Declaration");

    }




    _tabController = new TabController(
        vsync: this, initialIndex: 0, length: Constant.isSpouseTabNeeded==true?3:2);
    getSessionVariables();

    if(widget.laonLimitPassedObject!=null){
      customerLoanDetailsBeanObj = widget.laonLimitPassedObject;
    }
    else{



      if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans==null){
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans= new  List<CustomerLoanImageBean>();
        for(int i =0;i< 5;i++){
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans.add(new CustomerLoanImageBean());
        }
      }

    }

  }



  Future<Null> getSessionVariables() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {

      try {
        isFullerTon = prefs.getInt(TablesColumnFile.ISFULLERTON);
      }catch(_){}


      branch = prefs.getInt(TablesColumnFile.musrbrcode);
      username = prefs.getString(TablesColumnFile.musrcode).trim();
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      branchName =  prefs.getString(TablesColumnFile.branchname);
      isBiometricNeeded = prefs.getInt(TablesColumnFile.ISBIOMETRICNEEDED);

      try{
        geoLatitude = prefs.getDouble(TablesColumnFile.geoLatitude).toString();
        geoLongitude = prefs.getDouble(TablesColumnFile.geoLongitude).toString();


      }catch(_){
        print("Exception in getting loangitude");
      }
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mbranchName = branchName;



    });
    setState(() {

    });
  }








  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
      onWillPop: () {

        callDialog();



        //globals.grtBean = GRTBean();
        print("Clear Image");
      },
      child: new Scaffold(

        appBar: new AppBar(
          title: new Text(
            Translations.of(context).text('loan_application'),
            style: TextStyle(color: Colors.white),
          ),
          elevation: 3.0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
             onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
               callDialog();
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

          actions: <Widget>[
            //globals.isButtonDisabled
            new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: ()async  {

                if(widget.laonLimitPassedObject!=null&&widget.laonLimitPassedObject.mleadstatus!=null&&
                widget.laonLimitPassedObject.mleadstatus>1){
                  _showAlert(
                      Translations.of(context).text("modifyrightalert"),
                      Translations.of(context).text("modificationNotallowedafterSendforapproval"));
                       return;
                }


                if(  isBiometricNeeded ==1&&(globals.fingerPrintAuthForLoanApplicationDone==false&&(
                    CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckbiometric==0||
                        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckbiometric==null))){

                  _showAlert(
                      Translations.of(context).text("Finger_Print_Capture"),
                      Translations.of(context).text("It_Is_Mandatory"));
                  _tabController.animateTo(0);
                  return;
                }

                bool validate  = await validateSubmit();

                if(widget.laonLimitPassedObject==null){
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrefno = 0;
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mleadstatus = 1;
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrefno =
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrefno != null ?
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrefno : 0;

                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrouteto = '';
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mroutefrom = '';
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mlastupdateby = username;
                    CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreatedby = username;
                    CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcreateddt = DateTime.now();
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mlastupdatedt = DateTime.now();
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mgeolocation = geoLocation;
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mgeologd = geoLongitude;
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mgeolatd = geoLatitude;
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mlbrcode = branch;
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.missynctocoresys = 0;
                  if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind==1){
                      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt = null;

                  }


                }else{

                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mlastupdatedt = DateTime.now();
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mlastupdateby = username;
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrouteto = '';
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mroutefrom = '';
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.missynctocoresys = 0;
                  
                  if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind==1){
                      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt = null;

                  }

                }



                if(validate==true){

                  await AppDatabase.get()
                      .updateCustomerLoanDetailsMaster(
                          CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj)
                      .then((val) {});

                  for (int i = 0; i < 5; i++) {
                    if (CustomerLoanDetailsMasterTabState
                                .customerLoanDetailsBeanObj
                                .loanimageBeans[i]
                                .mimagestring !=
                            "" &&
                        CustomerLoanDetailsMasterTabState
                                .customerLoanDetailsBeanObj
                                .loanimageBeans[i]
                                .mimagestring !=
                            null &&
                        CustomerLoanDetailsMasterTabState
                                .customerLoanDetailsBeanObj
                                .loanimageBeans[i]
                                .mimagestring
                                .trim() !=
                            "null") {
                      if (CustomerLoanDetailsMasterTabState
                                  .customerLoanDetailsBeanObj
                                  .loanimageBeans[i]
                                  .trefno ==
                              0 ||
                          CustomerLoanDetailsMasterTabState
                                  .customerLoanDetailsBeanObj
                                  .loanimageBeans[i]
                                  .trefno ==
                              null) {
                        await AppDatabase.get()
                            .getMaxCustomerLoanImageNumber()
                            .then((val) async {
                          print("Max Returned number ${val}");

                          CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj
                              .loanimageBeans[i]
                              .trefno = val;
                          CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj
                              .loanimageBeans[i]
                              .mcreatedby = username;
                          CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj
                              .loanimageBeans[i]
                              .mcreateddt = DateTime.now();
                        });
                      }
                      CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj
                              .loanimageBeans[i]
                              .mloantrefno =
                          CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj.trefno;

                      CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj
                              .loanimageBeans[i]
                              .mloanmrefno =
                          CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj.mrefno;

                      CustomerLoanDetailsMasterTabState
                          .customerLoanDetailsBeanObj
                          .loanimageBeans[i]
                          .mlastupdateby = username;

                      CustomerLoanDetailsMasterTabState
                          .customerLoanDetailsBeanObj
                          .loanimageBeans[i]
                          .mlastupdatedt = DateTime.now();

                      if (CustomerLoanDetailsMasterTabState
                              .customerLoanDetailsBeanObj
                              .loanimageBeans[i]
                              .mrefno ==
                          null) {
                        CustomerLoanDetailsMasterTabState
                            .customerLoanDetailsBeanObj
                            .loanimageBeans[i]
                            .mrefno = 0;
                      }

                      await AppDatabaseExtended.get()
                          .updateCustomerLoanImageMaster(
                              CustomerLoanDetailsMasterTabState
                                  .customerLoanDetailsBeanObj.loanimageBeans[i],
                              i);
                    }
                  }


                  success(
                      'Loan is created sucessfully'
                          'Table refrence Number is :  '
                          '${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.trefno.toString()} for getting Core ',
                      context);

                }






              },
            ),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
            ),
          ],
        ),
        body: new TabBarView(
          controller: _tabController,
          children: tabWidget/*<Widget>[
            new LoanLimitDetails(),
            new CustomerLoanAddressDetails(),
            new CustomerLoanDeclaration()
          ],*/
        ),
      ),
    );
  }














  Future<bool> validateSubmit() async {
    String error = "";

    double canApplyMaxAmount = 0.0;
    double canApplyMinAmount = 0.0;

    double canApplyMaxInst = 0.0;
    double canApplyMinInst = 0.0;
    bool flag =true;
    int passingBranch ;

    if (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.trefno ==
            0 ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.trefno ==
            null) {
      _showAlert(Translations.of(context).text("Reference Num is Null"),
          Translations.of(context).text("Try creating a new lead"));
      _tabController.animateTo(0);
    }

    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno == null ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno == "" ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustname == null ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustname == "" ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustname == "null") {
      _showAlert(
          Translations.of(context).text("Customer Tablet Ref Number And Name"),
          Translations.of(context).text("It_Is_Mandatory"));
       _tabController.animateTo(0);

      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdname == null) {
      _showAlert("Product Name", "It is Mandatory");
       _tabController.animateTo(0);
      return false;
    }
    if (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mpurposeofLoan == "" ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mpurposeofLoan == null) {
      _showAlert(Translations.of(context).text('purpose_of_loan'), Translations.of(context).text('It_Is_M andatory'));
      _tabController.animateTo(0);
      return false;
    }

    if (isFullerTon==0 && (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan == "" ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.msubpurposeofloan == null)) {
      _showAlert(Translations.of(context).text('sub_purpose_of_loan'), Translations.of(context).text('It_Is_M andatory'));
      _tabController.animateTo(0);
      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency == null) {
      _showAlert(Translations.of(context).text('repayment_frequency_of_loan'), Translations.of(context).text('It_Is_Mandatory'));
      _tabController.animateTo(0);
      return false;
    }

    print("CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt  ${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt}");
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt==null || CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt=='null' || CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt < 0.0) {
      _showAlert(Translations.of(context).text("appliedAmount"), Translations.of(context).text("It_Is_Mandatory"));
      _tabController.animateTo(0);
      return false;
    }

    
    if ( (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind!=null&&
     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappliedasind.trim()=='0'&&
     CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minststrtdt== null)&&(isFullerTon!=1)
    ) {
      _showAlert(Translations.of(context).text("loaninstStrtDt"),
          Translations.of(context).text("It is mandatory if individual"));
      _tabController.animateTo(0);
      return false;
    }




    if(branch!=null&&branch.toString()!=null){


      try{

        passingBranch  = branch;

        await AppDatabase.get()
            .selectMaxLoanAmtCanApply(  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd.trim().toString(),
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloancycle + 1, passingBranch,   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency)
            .then((onValue) {

              print("Returned Value is ${onValue}");
          for (int secondLoanCycle = 0;
          secondLoanCycle < onValue.length;
          secondLoanCycle++) {


            if (onValue[secondLoanCycle].mruletype == 1) {
              canApplyMaxAmount = onValue[secondLoanCycle].mmaxamount;
              canApplyMinAmount = onValue[secondLoanCycle].mminamount;
            } else if (onValue[secondLoanCycle].mruletype == 2){
              canApplyMaxInst = onValue[secondLoanCycle].mmaxamount;
              canApplyMinInst = onValue[secondLoanCycle].mminamount;
            }


          }
          setState(() {});
        });


        try {
          if (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
              .mperiod < canApplyMinInst) {
            _showAlert(
                Translations.of(context).text("No Of Installment cannot be less than Min apply Installment"),
                Translations.of(context).text("Please enter correct Installment"));
            _tabController.animateTo(0);
            return false;
          }
        }catch(_){}


        try{
        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt < canApplyMinAmount) {
          _showAlert(Translations.of(context).text("Applied Amount Not In Limit Range"), Translations.of(context).text("Please enter correct Amount"));
          _tabController.animateTo(0);
          return false;
        }
        }catch(_){}


        try{
        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt > canApplyMaxAmount ||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mappldloanamt > canApplyMaxAmount) {
          _showAlert(Translations.of(context).text("Applied Amount Not In Limit Range"), Translations.of(context).text("Please enter correct Amount"));
          _tabController.animateTo(0);
          return false;
        }
        }catch(_){}

        try{
        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod > canApplyMaxInst) {
          _showAlert("No Of Installment cannot be more than Max apply Installment",
              "Please enter correct Installment");
          _tabController.animateTo(0);
          return false;
        }
        }catch(_){}



      }catch(_){

      }

    }


    if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt>0) {
      flag = await checkIfInIncrementalWay();
    }
    if(!flag){
      _showAlert("Applied amount should be incremental of ${incAmount}","Please enter correct Applied amount");
      _tabController.animateTo(0);
      return false;
    }

    
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod == 0 ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mperiod == null) {
      _showAlert(Translations.of(context).text('NumOfInst'), Translations.of(context).text('It_Is_Mandatory'));
       _tabController.animateTo(0);
      return false;
    }


    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mintrate == null) {
      _showAlert(Translations.of(context).text("R.O.I"), Translations.of(context).text("It_Is_Mandatory"));
       _tabController.animateTo(0);
      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minterestamount == "" ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minterestamount == null) {
      _showAlert(Translations.of(context).text("interest_amount"), Translations.of(context).text("It_Is_Mandatory"));
       _tabController.animateTo(0);
      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minstamt == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.minstamt == null) {
      _showAlert(Translations.of(context).text("instalment_amount"), Translations.of(context).text("It_Is_Mandatory"));
      _tabController.animateTo(0);
      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mapprvdloanamt == null) {
      _showAlert(Translations.of(context).text("approved_amount"), Translations.of(context).text("It_Is_Mandatory"));
       _tabController.animateTo(0);
      return false;
    }
    if ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd == "" ||  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mloanamtdisbd == null) {
      _showAlert(Translations.of(context).text("disbursment_amount"), Translations.of(context).text("It_Is_Mandatory"));
       _tabController.animateTo(0);
      return false;
    }
    if (isFullerTon==0 &&   (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode == "" ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode == null ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode == 0)) {
      _showAlert(Translations.of(context).text("mode_of_collection"), Translations.of(context).text("It_Is_Mandatory"));
       _tabController.animateTo(0);
      return false;
    }
    if (isFullerTon==0 && ( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mmodeofdisb == "" ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mmodeofdisb == null ||
        CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mrepaymentmode == 0)) {
      _showAlert(Translations.of(context).text("mode_of_disbursment"), Translations.of(context).text("It_Is_Mandatory"));
       _tabController.animateTo(0);
      return false;
    }



    GroupFoundationBean GrpObj =
    await AppDatabase.get().getGroupFromGrpId(mgrpID);

    if (GrpObj.mgroupprdcode != null &&
        GrpObj.mgroupprdcode.trim() != "" &&
        GrpObj.mgroupprdcode.trim() != "null" &&
        isMemeberOfGroupForLoan == true) {
      if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd != GrpObj.mgroupprdcode) {
        _showAlert("Product group mismatch ",
            "Can Only apply for ${GrpObj.mgroupprdcode}");
         _tabController.animateTo(0);
        return false;
      }





    }



    /*if(prefs.getString(TablesColumnFile.misIndividual)=="N"){
      return true;
    }*/



    CenterDetailsBean centerObj =
    await AppDatabase.get().getCenterFromCenterId(mcenterId);
    if (centerObj != null &&
        centerObj.mmeetingfreq != null &&
        centerObj.mmeetingfreq.trim() != "") {
      List<String> frequencies = new List<String>();
      bool matched = false;

      if (centerObj.mmeetingfreq.trim() == "W") {
        frequencies = Constant.INSTFREQ_W.split("-");

        for (String freq in frequencies) {
          if (freq.trim() ==   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim()) {
            matched = true;
            break;
          }
        }
      } else if (centerObj.mmeetingfreq.trim() == "F") {
        frequencies = Constant.INSTFREQ_F.split("-");

        for (String freq in frequencies) {
          if (freq.trim() ==   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim()) {
            matched = true;
            break;
          }
        }
      } else if (centerObj.mmeetingfreq.trim() == "M") {
        frequencies = Constant.INSTFREQ_M.split("-");

        for (String freq in frequencies) {
          if (freq.trim() ==   CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim()) {
            matched = true;
            break;
          }
        }
      } else {
        frequencies = Constant.INSTFREQ_B.split("-");

        for (String freq in frequencies) {
          if (freq.trim() ==  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mfrequency.trim()) {
            matched = true;
            break;
          }
        }
      }

      if(matched==false){
        _showAlert(Translations.of(context).text('Center Meeting Frequency'), Translations.of(context).text('Center meeting frequency do not match with product frequency'));
        _tabController.animateTo(0);
        return false;
      }











    }




    int isFulleton = 0;
    isFulleton = prefs.getInt(TablesColumnFile.ISFULLERTON);

    print("Is Fullerton ${isFulleton}");

    if(isFulleton==1){

      if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckresaddchng==1){

        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[0]== null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[0].mimagestring==null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[0].mimagestring== 'null'
            ||CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[0].mimagestring.trim()== ''
        ) {
          _showAlert(Translations.of(context).text('addressproofimages') ,

              Translations.of(context).text('It_Is_Mandatory'));
          _tabController.animateTo(1);
          return false;
        }

        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[1]== null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[1].mimagestring==null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[1].mimagestring== 'null'
            ||CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[1].mimagestring.trim()== ''
        ) {
          _showAlert(Translations.of(context).text('addressproofimages') ,

              Translations.of(context).text('It_Is_Mandatory'));
          _tabController.animateTo(1);
          return false;
        }


      }




      //if(Constant.isSpouseTabNeeded==true&&CustomerLoanDetailsMasterTabState.isMarried==true){
      //Changes done for in evercase instead only married validation required
      if(Constant.isSpouseTabNeeded==true){
          if(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname==null
              ||CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname.trim()==""
          ||CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mspouserelname.trim()=="null"
          ){

            _showAlert(Translations.of(context).text('spouseName/relativename') ,

                Translations.of(context).text('It_Is_Mandatory'));
            _tabController.animateTo(2);
            return false;

          }



        /*if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[2]== null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[2].mimagestring==null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[2].mimagestring== 'null'
            ||CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[2].mimagestring.trim()== ''
        ) {
          _showAlert(Translations.of(context).text('spouseimages') ,

              Translations.of(context).text('It_Is_Mandatory'));
          _tabController.animateTo(2);
          return false;
        }
        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[3]== null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[3].mimagestring==null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[3].mimagestring== 'null'
            ||CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[3].mimagestring.trim()== ''
        ) {
          _showAlert(Translations.of(context).text('spouseimages') ,

              Translations.of(context).text('It_Is_Mandatory'));
          _tabController.animateTo(2);
          return false;
        }*/

        if (  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4]== null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4].mimagestring==null||
            CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4].mimagestring== 'null'
            ||CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[4].mimagestring.trim()== ''
        ) {
          _showAlert(Translations.of(context).text('spousesignature') ,

              Translations.of(context).text('It_Is_Mandatory'));
          _tabController.animateTo(2);
          return false;
        }

        if (CustomerLoanDetailsMasterTabState
                    .customerLoanDetailsBeanObj.mcheckspouserepay ==
                null ||
            CustomerLoanDetailsMasterTabState
                    .customerLoanDetailsBeanObj.mcheckspouserepay ==
                0) {
          _showAlert(Translations.of(context).text('Spouse Support Check Box'),
              Translations.of(context).text('It_Is_Mandatory'));
	      _tabController.animateTo(2);
          return false;
        }
      }


    }









    return true;
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
                Text('$error.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('Ok')),
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

  Future<bool> callDialog() {
    globals.Dialog.onPop(
        context,
        Translations.of(context).text('Are_You_Sure'),
         Translations.of(context).text('Do you want to Go To Loan without saving data'),
        "Loan Application");
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
                  Navigator.of(context).pop();
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj = new CustomerLoanDetailsBean();

                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        // new LoanLimitDetails()), //When Authorized Navigate to the next screen
                        new CustomerLoanDetailsList("Loan Application",null)),
                  );
                },
              ),
            ],
          );
        });
  }

  Future<bool> checkIfInIncrementalWay() async{
    bool retn=true;
    try {
      await AppDatabase.get()
          .selectPrimaryTableForValidtion(
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mprdcd
              .trim().toString(),
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
              .mloancycle + 1, branch,
          CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
              .mfrequency).then((onValue) async {
        for (int secondLoanCycle = 0; secondLoanCycle < onValue.length; secondLoanCycle++) {
               if (onValue[secondLoanCycle].mincramount > 0) {
            if (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
                .mapprvdloanamt % onValue[secondLoanCycle].mincramount == 0) {
              retn = true;
            } else {
              incAmount = onValue[secondLoanCycle].mincramount;
              retn = false;
            }
            //retn = true;
          }
          else {
            retn = true;
          }
        }
      });

           }catch(_){
      retn =true;
           }
    return retn;

    }



}
