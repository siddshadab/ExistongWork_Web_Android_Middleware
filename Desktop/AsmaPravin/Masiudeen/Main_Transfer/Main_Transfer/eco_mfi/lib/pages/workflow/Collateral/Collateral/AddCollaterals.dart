import 'dart:async';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Collateral/CollateralREM/CollateralREMland/CollateralsREMMaster.dart';
import 'package:eco_mfi/pages/workflow/Collateral/CollatralVehicle/CollateralVehicleMaster.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/FullScreenDialogForSubOccupationSelection.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/List/CustomerList.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../translations.dart';
import 'Bean/CollateralBasicSelectionBean.dart';

class AddCollaterals extends StatefulWidget {
  final collateralsDetailsPassedObject;
  final String mleadsId;
  final int mrefno;
  final int trefno;
  AddCollaterals(
      {Key key,
      this.collateralsDetailsPassedObject,
      this.mleadsId,
      this.mrefno,
      this.trefno})
      : super(key: key);

  static Container _get(Widget child,
          [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );

  @override
  _AddCollateralsState createState() => new _AddCollateralsState();
}

class _AddCollateralsState extends State<AddCollaterals> {
  static final GlobalKey<FormState> _formKeyNationalId =
      new GlobalKey<FormState>();
  SystemParameterBean sysBean = new SystemParameterBean();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  SubLookupForSubPurposeOfLoan subCollrlType =
      new SubLookupForSubPurposeOfLoan();
  SubLookupForSubPurposeOfLoan subCollrlTypeCat =
      new SubLookupForSubPurposeOfLoan();
  int selectedSubCollateralPosition = 0;
  int selectedSubCollateralCatPosition = 0;
  String customerName;
  String branch = "";
  SharedPreferences prefs;
  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  //LookupBeanData NationalId;
  CollateralBasicSelectionBean collateralobj =
      new CollateralBasicSelectionBean();
  LookupBeanData ApplicantType;
  LookupBeanData collatrlTyp;
  LookupBeanData collatrlCat;
  LookupBeanData RelationWithApplicant;
  LookupBeanData nameTitle;
  LookupBeanData insurance;
  LookupBeanData colltrlTitle;
  LookupBeanData misappctprimary;
  LookupBeanData mislmap;

  @override
  void initState() {
    getSessionVariables();

    super.initState();
    if (widget.collateralsDetailsPassedObject != null &&
        widget.collateralsDetailsPassedObject != "null" &&
        widget.collateralsDetailsPassedObject != "") {
      collateralobj = widget.collateralsDetailsPassedObject;
    }
    List<String> tempDropDownValues = new List<String>();
    tempDropDownValues.add(collateralobj.mapplicanttype.toString());
    tempDropDownValues.add(collateralobj.collatrlTyp.toString());
    tempDropDownValues.add(collateralobj.nametitle.toString());
    tempDropDownValues.add(collateralobj.mrelationwithcust.toString());
    tempDropDownValues.add(collateralobj.insurance.toString());
    tempDropDownValues.add(collateralobj.colltrltitle.toString());
    tempDropDownValues.add(collateralobj.misappctprimary.toString());

    tempDropDownValues.add(collateralobj.mislmap.toString());

    for (int k = 0;
        k < globals.dropdownCaptionsValuesCollateralsInfo.length;
        k++) {
      for (int i = 0;
          i < globals.dropdownCaptionsValuesCollateralsInfo[k].length;
          i++) {
        try {
          if (globals.dropdownCaptionsValuesCollateralsInfo[k][i].mcode
                  .toString()
                  .trim() ==
              tempDropDownValues[k].toString().trim()) {
            //   print("Matched");

            setValue(k, globals.dropdownCaptionsValuesCollateralsInfo[k][i]);
          }
        } catch (_) {
          print("Exception Occured in dropdown");
        }
      }
    }
  }

  showDropDown(LookupBeanData selectedObj, int no) {
    if (selectedObj.mcodedesc.isEmpty) {
      // print("inside  code Desc is null");
      switch (no) {
        case 0:
          ApplicantType = blankBean;
          collateralobj.mapplicanttype = blankBean.mcode;
          ;

          break;
        case 1:
          collatrlTyp = blankBean;
          collateralobj.collatrlTyp = blankBean.mcode;
          ;
          break;
        case 2:
          nameTitle = blankBean;
          collateralobj.nametitle = blankBean.mcode;
          break;
        case 3:
          RelationWithApplicant = blankBean;
          collateralobj.mrelationwithcust = blankBean.mcode;
          break;
        case 4:
          insurance = blankBean;
          collateralobj.insurance = blankBean.mcode;
          break;
        case 5:
          colltrlTitle = blankBean;
          collateralobj.colltrltitle = blankBean.mcode;
          break;
        case 6:
          misappctprimary = blankBean;
          collateralobj.misappctprimary = blankBean.mcode;
          break;
        case 7:
          mislmap = blankBean;
          collateralobj.mislmap = blankBean.mcode;
          break;

        default:
          break;
      }

      setState(() {});
    } else {
      bool isBreak = false;
      for (int k = 0;
          k < globals.dropdownCaptionsValuesCollateralsInfo[no].length;
          k++) {
        if (globals.dropdownCaptionsValuesCollateralsInfo[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesCollateralsInfo[no][k]);
          isBreak = true;
          break;
        }
        if (isBreak) {
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
          ApplicantType = value;
          collateralobj.mapplicanttype = value.mcode;
          break;
        case 1:
          collatrlTyp = value;
          collateralobj.collatrlTyp = value.mcode;
          break;
        case 2:
          nameTitle = value;
          collateralobj.nametitle = value.mcode;
          break;
        case 3:
          RelationWithApplicant = value;
          print("value.mcode" + value.mcode.toString());
          collateralobj.mrelationwithcust = value.mcode;
          break;
        case 4:
          insurance = value;
          collateralobj.insurance = value.mcode;
          break;
        case 5:
          colltrlTitle = value;
          collateralobj.colltrltitle = value.mcode;
          break;
        case 6:
          misappctprimary = value;
          collateralobj.misappctprimary = value.mcode;
          print("value.mcode" + value.mcode.toString());
          if (value.mcode == '2') {
            getPrimaryApplicantName();
          }
          break;
        case 7:
          mislmap = value;
          collateralobj.mislmap = value.mcode;
          break;
        default:
          break;
      }
    });
  }

  LookupBeanData blankBean =
      new LookupBeanData(mcodedesc: "", mcode: "", mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {
    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
        k < globals.dropdownCaptionsValuesCollateralsInfo[no].length;
        k++) {
      mapData.add(globals.dropdownCaptionsValuesCollateralsInfo[no][k]);
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
    prefs = await SharedPreferences.getInstance();

    if (widget.collateralsDetailsPassedObject != null) {
      collateralobj = widget.collateralsDetailsPassedObject;
    } else {
      await AppDatabase.get().generateTrefnoForCollaterals().then((val) async {
        setState(() {
          collateralobj.trefno = val;
        });

        //beanObj.segmentIdentifier;
      });
    }
    if (widget.mleadsId != "null" ||
        widget.mleadsId != "" ||
        widget.mleadsId != null) {
      collateralobj.mleadsid = widget.mleadsId;
    }
    if (widget.mrefno != "null" ||
        widget.mrefno != "" ||
        widget.mrefno != null) {
      collateralobj.loanmrefno = widget.mrefno;
    }

    if (widget.trefno != "null" ||
        widget.trefno != "" ||
        widget.trefno != null) {
      collateralobj.loantrefno = widget.trefno;
    }
    setState(() {
      branch = prefs.get(TablesColumnFile.musrbrcode).toString();
      username = prefs.getString(TablesColumnFile.musrcode);
      usrRole = prefs.getString(TablesColumnFile.usrDesignation);
      usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
      loginTime = prefs.getString(TablesColumnFile.LoginTime);
      geoLocation = prefs.getString(TablesColumnFile.geoLocation);
      geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
      geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
      reportingUser = prefs.getString(TablesColumnFile.reportingUser);
    });
  }

  Future<bool> callDialog() {
    globals.Dialog.onPop(context, Translations.of(context).text('rusre'),
        Translations.of(context).text('gur'), "gggggg");
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          callDialog();
        },
        child: new Scaffold(
          key: _scaffoldKey,
          //  resizeToAvoidBottomPadding: false,
          appBar: new AppBar(
            elevation: 1.0,
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back, color: Colors.white),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  callDialog();
                }),
            backgroundColor: Color(0xff07426A),
            brightness: Brightness.light,
            title: new Text(
              'Collaterals Details',
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              children: <Widget>[
                //TODO
                Card(
                  color: Constant.mandatoryColor,
                  child: new ListTile(
                      title: new Text(Translations.of(context).text('Ldrfno')),
                      subtitle: collateralobj.mleadsid == null
                          ? new Text("")
                          : new Text(
                              "${collateralobj.mleadsid != null && collateralobj.mleadsid.toString() != null && collateralobj.mleadsid.toString() != 'null' ? collateralobj.mleadsid.toUpperCase() : ""}/${collateralobj.loantrefno.toString()} - ${collateralobj.loanmrefno != null && collateralobj.loanmrefno.toString() != null && collateralobj.loanmrefno.toString() != 'null' ? collateralobj.loanmrefno : ""}")),
                ),
                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: mislmap,
                    items: generateDropDown(7),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 7);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(
                        labelText: Translations.of(context).text('ISLMAP')),
                  ),
                ),

                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: misappctprimary,
                    items: generateDropDown(6),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 6);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(
                        labelText:
                            Translations.of(context).text('IsApplPrmry')),
                  ),
                ),

                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: ApplicantType,
                    items: generateDropDown(0),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 0);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(
                        labelText: Translations.of(context).text('PrimSec')),
                  ),
                ),

                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: collatrlTyp,
                    items: generateDropDown(1),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 1);
                    },
                    decoration: InputDecoration(
                        labelText:
                            Translations.of(context).text('collateral_type')),
                  ),
                ),
                new Card(
                  child: new ListTile(
                      title: new Text(
                          Translations.of(context).text('collateral_sub_type')),
                      subtitle: collateralobj.msubocolltrldesc == null
                          ? new Text("")
                          : new Text(
                              "Collateral Sub Type : ${collateralobj.msubocolltrldesc}   And Code : ${collateralobj.msubcolltrl}"),
                      onTap: () => getSubCollatrl(
                          "subCollatrlType",
                          int.parse(collateralobj.collatrlTyp != null &&
                                  collateralobj.collatrlTyp.toString() != 'null'
                              ? collateralobj.collatrlTyp
                              : 0))),
                ),

                new Card(
                  child: new ListTile(
                      title: new Text(Translations.of(context).text('CollCat')),
                      subtitle: collateralobj.msubocolltrlcatdesc == null
                          ? new Text("")
                          : new Text(
                              "Collateral Category: ${collateralobj.msubocolltrlcatdesc}   And Code : ${collateralobj.msubcolltrlcat}"),
                      onTap: () => getSubCollatrlCat(
                          "subCollatrlTypeCat",
                          int.parse(collateralobj.msubcolltrl != null &&
                                  collateralobj.msubcolltrl.toString() != 'null'
                              ? collateralobj.msubcolltrl
                              : 0))),
                ),

                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: nameTitle,
                    items: generateDropDown(2),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 2);
                    },
                    decoration: InputDecoration(
                        labelText: Translations.of(context).text('NmTtl')),
                  ),
                ),
                new Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: Translations.of(context).text('EntrFrstnm'),
                        labelText: Translations.of(context).text('Frstnm'),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
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
                      controller: collateralobj != null &&
                              collateralobj.mfname != null
                          ? TextEditingController(text: collateralobj.mfname)
                          : TextEditingController(text: ""),
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                        globals.onlyCharacter
                      ],
                      onSaved: (String value) {
                        if (value.isNotEmpty &&
                            value != "" &&
                            value != null &&
                            value != 'null') {
                          collateralobj.mfname = (value);
                        }
                        // cusLoanObj.mloanamtdisbd = cusLoanObj.mappldloanamt;
                        // cusLoanObj.mapprvdloanamt = cusLoanObj.mappldloanamt;
                      }),
                ),
                SizedBox(height: 16.0),

                new TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('Entrmddlnm'),
                      labelText: Translations.of(context).text('Mddlnm'),
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.grey),
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50),
                      globals.onlyCharacter
                    ],
                    controller:
                        collateralobj != null && collateralobj.mmname != null
                            ? TextEditingController(text: collateralobj.mmname)
                            : TextEditingController(text: ""),
                    onSaved: (String value) {
                      if (value.isNotEmpty &&
                          value != "" &&
                          value != null &&
                          value != 'null') {
                        collateralobj.mmname = (value);
                      }
                      // cusLoanObj.mloanamtdisbd = cusLoanObj.mappldloanamt;
                      // cusLoanObj.mapprvdloanamt = cusLoanObj.mappldloanamt;
                    }),
                new Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        //   color: Constant.mandatoryColor,
                        hintText: Translations.of(context).text('Entrlstnm'),
                        labelText: Translations.of(context).text('Lstnm'),
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
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
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(50),
                        globals.onlyCharacter
                      ],
                      controller: collateralobj != null &&
                              collateralobj.mlname != null
                          ? TextEditingController(text: collateralobj.mlname)
                          : TextEditingController(text: ""),
                      onSaved: (String value) {
                        if (value.isNotEmpty &&
                            value != "" &&
                            value != null &&
                            value != 'null') {
                          collateralobj.mlname = (value);
                        }
                        // cusLoanObj.mloanamtdisbd = cusLoanObj.mappldloanamt;
                        // cusLoanObj.mapprvdloanamt = cusLoanObj.mappldloanamt;
                      }),
                ),

                SizedBox(height: 16.0),
                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: RelationWithApplicant,
                    items: generateDropDown(3),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 3);
                    },
                    decoration: InputDecoration(
                        labelText:
                            Translations.of(context).text('RelatonShpwthappl')),
                  ),
                ),
                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: insurance,
                    items: generateDropDown(4),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 4);
                    },
                    decoration: InputDecoration(
                        labelText: Translations.of(context).text('insurance')),
                  ),
                ),

                Card(
                  color: Constant.mandatoryColor,
                  child: new DropdownButtonFormField(
                    value: colltrlTitle,
                    items: generateDropDown(5),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 5);
                    },
                    decoration: InputDecoration(
                        labelText: Translations.of(context).text('CollTtle')),
                  ),
                ),

                new Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('EntrNmttlDoc'),
                      labelText: Translations.of(context).text('NmttleDoc'),
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50),
                      globals.onlyCharacter
                    ],
                    controller: collateralobj != null &&
                            collateralobj.mnameoftitledoc != null
                        ? TextEditingController(
                            text: collateralobj.mnameoftitledoc)
                        : TextEditingController(text: ""),
                    onSaved: (String value) {
                      try {
                        collateralobj.mnameoftitledoc = value;
                      } catch (_) {}
                    },
                  ),
                ),

                new Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('EntrCollbkno'),
                      labelText: Translations.of(context).text('Collbkno'),
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                      globals.onlyIntNumber
                    ],
                    controller: collateralobj != null &&
                            collateralobj.mcollbookno != null
                        ? TextEditingController(text: collateralobj.mcollbookno)
                        : TextEditingController(text: ""),
                    onSaved: (String value) {
                      try {
                        collateralobj.mcollbookno = value;
                      } catch (_) {}
                    },
                  ),
                ),

                new Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('EntrCollPgeno'),
                      labelText: Translations.of(context).text('Colltrlpgeno'),
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                      globals.onlyIntNumber
                    ],
                    controller: collateralobj != null &&
                            collateralobj.mcollpageno != null
                        ? TextEditingController(text: collateralobj.mcollpageno)
                        : TextEditingController(text: ""),
                    onSaved: (String value) {
                      try {
                        collateralobj.mcollpageno = value;
                      } catch (_) {}
                    },
                  ),
                ),

                new Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('EntrAttch'),
                      labelText: Translations.of(context).text('NoOfAttchmnt'),
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(10),
                      globals.onlyIntNumber
                    ],
                    controller: collateralobj != null &&
                            collateralobj.mnoofattchmnt != null
                        ? TextEditingController(
                            text: collateralobj.mnoofattchmnt)
                        : TextEditingController(text: ""),
                    onSaved: (String value) {
                      try {
                        collateralobj.mnoofattchmnt = value;
                      } catch (_) {}
                    },
                  ),
                ),

                new Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration: InputDecoration(
                      hintText: Translations.of(context).text('EntrPlceOfUse'),
                      labelText: Translations.of(context).text('PlceOfUse'),
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(50),
                      globals.onlyAphaNumeric
                    ],
                    controller: collateralobj != null &&
                            collateralobj.mplaceofuse != null
                        ? TextEditingController(text: collateralobj.mplaceofuse)
                        : TextEditingController(text: ""),
                    onSaved: (String value) {
                      try {
                        collateralobj.mplaceofuse = value;
                      } catch (_) {}
                    },
                  ),
                ),
                new Container(
                  color: Constant.mandatoryColor,
                  child: new TextFormField(
                    decoration: InputDecoration(
                      hintText: " Enter Withdrawal Condition",
                      labelText: "Withdrawal Condition",
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(65),
                      globals.onlyAphaNumeric
                    ],
                    controller: collateralobj != null &&
                            collateralobj.mwithdrawcond != null
                        ? TextEditingController(
                            text: collateralobj.mwithdrawcond)
                        : TextEditingController(text: ""),
                    onSaved: (String value) {
                      try {
                        collateralobj.mwithdrawcond = value;
                      } catch (_) {}
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  proceed() async {
    if (!validateSubmit()) {
      return;
    }
    _successfulSubmit();
  }

  submitCollateralAndRoute() async {
    collateralobj.mlastupdatedt = DateTime.now();
    collateralobj.mlastupdateby = username;

    if (collateralobj.mcreateddt == null) {
      collateralobj.mcreateddt = DateTime.now();
    }

    if (collateralobj.mcreatedby == null ||
        collateralobj.mcreatedby == '' ||
        collateralobj.mcreatedby == 'null') {
      collateralobj.mcreatedby = username;
    }

    collateralobj.mrefno =
        collateralobj.mrefno != null ? collateralobj.mrefno : 0;

    collateralobj.mgeolocation = geoLocation;
    collateralobj.mgeologd = geoLongitude;
    collateralobj.mgeolatd = geoLatitude;
    await AppDatabase.get().updateCollateralsMaster(collateralobj).then((val) {
      print("val here is " + val.toString());
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
                  Text(Translations.of(context).text('press')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(Translations.of(context).text('next')),
                onPressed: () async {
                  await submitCollateralAndRoute();

                  if (collateralobj.collatrlTyp == '33') {
                    await AppDatabase.get()
                        .selectCollateralVehicleBeanOnCollateralMTrefAndTrefno(
                            collateralobj.trefno,
                            collateralobj.mrefno,
                            collateralobj.mcreatedby)
                        .then((onValue) {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new CollateralVehicleMaster(
                                collateralobj,
                                onValue)), //When Authorized Navigate to the next screen
                      );
                    });
                  } else if (collateralobj.collatrlTyp == '34') {
                    await AppDatabase.get()
                        .selectCollateralREMBeanOnCollateralMTrefAndTrefno(
                            collateralobj.trefno,
                            collateralobj.mrefno,
                            collateralobj.mcreatedby)
                        .then((onValue) {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new CollateralsREMMaster(
                                collateralobj,
                                onValue)), //When Authorized Navigate to the next screen
                      );
                    });
                  }
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                 onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
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
          title: Text('$arg error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$error.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translations.of(context).text('ok')),
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
    if (collateralobj.collatrlTyp == "" || collateralobj.collatrlTyp == null) {
      _showAlert("Collateral Type ", "It is Mandatory");
      return false;
    }
    if (collateralobj.msubocolltrldesc == "" ||
        collateralobj.msubocolltrldesc == null) {
      _showAlert("Collateral Sub Type ", "It is Mandatory");
      return false;
    }
    if (collateralobj.msubocolltrlcatdesc == "" ||
        collateralobj.msubocolltrlcatdesc == null) {
      _showAlert("Collateral Category ", "It is Mandatory");
      return false;
    }

    if (collateralobj.mapplicanttype == "" ||
        collateralobj.mapplicanttype == null) {
      _showAlert("Applicant Type ", "It is Mandatory");
      return false;
    }

    if (collateralobj.mrelationwithcust == "" ||
        collateralobj.mrelationwithcust == null) {
      _showAlert("Relation With Customer", "It is Mandatory");
      return false;
    }
    if (collateralobj.mwithdrawcond == "" ||
        collateralobj.mwithdrawcond == null) {
      _showAlert("Withdrawal Condition", "It is Mandatory");
      return false;
    }

    return true;
  }

  Future getSubCollatrl(String purposeMode, int selectedPosition) async {
    subCollrlType = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForSubOccupationSelection(
                  /* type: "Collateral Sub Type",//TODO uncomment
                  basicCode: 6000,*/
                  position: selectedPosition),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((purposeObjVal) {
      collateralobj.msubocolltrldesc = purposeObjVal.codeDesc;
      collateralobj.msubcolltrl = (purposeObjVal.code.trim());
    });
  }

  Future getSubCollatrlCat(String purposeMode, int selectedPosition) async {
    subCollrlType = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              FullScreenDialogForSubOccupationSelection(
                  /*type: "Collateral Category",//TODO uncomment
                  basicCode: 7000,*/
                  position: selectedPosition),
          fullscreenDialog: true,
        )).then<SubLookupForSubPurposeOfLoan>((purposeObjVal) {
      collateralobj.msubocolltrlcatdesc = purposeObjVal.codeDesc;
      collateralobj.msubcolltrlcat = (purposeObjVal.code.trim());
    });
  }

  void getPrimaryApplicantName() {
    print("COming with rpimary");
    // if(collateralobj.loantrefno !=null && collateralobj.loanmrefno!=null){
    AppDatabase.get()
        .selectCustomerLoanOnTrefAndMrefno(
            collateralobj.loantrefno != null ? collateralobj.loantrefno : 0,
            collateralobj.loanmrefno != null ? collateralobj.loanmrefno : 0)
        .then((CustomerLoanDetailsBean loanDetailsList) async {
      print(loanDetailsList.toString());
      await AppDatabase.get()
          .getCustomerByTrefAndMref(
              loanDetailsList.mcusttrefno, loanDetailsList.mcustmrefno)
          .then((CustomerListBean customerListBean) async {
        print("xxxxxxxxxxxxxxxxx" +
            customerListBean.mfname.toString() +
            customerListBean.mmname.toString() +
            customerListBean.mlname.toString() +
            customerListBean.mnametitle.toString());
        collateralobj.mfname = customerListBean.mfname;
        collateralobj.mmname = customerListBean.mmname;
        collateralobj.mlname = customerListBean.mlname;
        collateralobj.nametitle = customerListBean.mnametitle;
        print("xxxxxxxxxxxxxxxxx" +
            collateralobj.mfname.toString() +
            collateralobj.mmname.toString() +
            collateralobj.mlname.toString() +
            collateralobj.nametitle.toString());
        bool isBreak = false;
        for (int k = 0;
            k < globals.dropdownCaptionsValuesCollateralsInfo[2].length;
            k++) {
          if (globals.dropdownCaptionsValuesCollateralsInfo[2][k].mcode ==
              collateralobj.nametitle) {
            setValue(2, globals.dropdownCaptionsValuesCollateralsInfo[2][k]);
            isBreak = true;
            break;
          }
          if (isBreak) {
            break;
          }
        }

        setState(() {});
      });
    });
    //}
  }
}
