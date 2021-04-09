import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/translations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;


class SocialAndEnvironmental extends StatefulWidget {
  final socialAndEnvPassedObject;
  final loanPassedObject;

  SocialAndEnvironmental(this.socialAndEnvPassedObject,this.loanPassedObject);

  static Container _get(Widget child,
      [EdgeInsets pad = const EdgeInsets.all(6.0)]) =>
      new Container(
        padding: pad,
        child: child,
      );
  @override
  _SocialAndEnvironmentalState createState() => new _SocialAndEnvironmentalState();
}

class _SocialAndEnvironmentalState extends State<SocialAndEnvironmental> {
  TextEditingController branchController = new TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String reportingUser;
  int branch = 0;
  String loginTime;
  int usrGrpCode = 0;
  //SocialAndEnvironmentalBean seObj = new SocialAndEnvironmentalBean();
  SocialAndEnvironmentalBean seObj;
  bool isDataSynced = false;
  bool circIndicatorIsDatSynced = false;
  GlobalKey<ScaffoldState> _scaffoldHomeState = new GlobalKey<ScaffoldState>();
  LookupBeanData brwcat;
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;
  bool checkBox4 = false;
  bool checkBox5 = false;
  bool checkBox6 = false;
  bool checkBox7 = false;
  bool checkBox8 = false;
  bool checkBox9 = false;
  bool checkBox10 = false;
  bool checkBox11 = false;
  bool checkBox12 = false;
  bool checkBox13 = false;
  bool checkBox14 = false;
  bool checkBox15 = false;
  bool checkBox16 = false;
  bool checkBox17 = false;
  bool checkBox18 = false;
  bool checkBox19 = false;
  bool checkBox20 = false;
  bool checkBox21 = false;
  bool checkBox22 = false;
  bool checkBox23 = false;
  bool checkBox24 = false;
  bool checkBox25 = false;
  bool checkBox26 = false;
  bool checkBox27 = false;
  bool checkBox28 = false;
  bool checkBox29 = false;

  Future<Null> getSessionVariables() async {
    if (widget.socialAndEnvPassedObject != null) {
      seObj = widget.socialAndEnvPassedObject;
    } else {
      AppDatabase.get().generateSocialEnvironment().then((onValue) {
        setState(() {
          seObj.trefno = onValue;
        });

      });
    }

    prefs = await SharedPreferences.getInstance();
    setState(() {
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
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.socialAndEnvPassedObject != null) {
      seObj = widget.socialAndEnvPassedObject;

      if (seObj.mbrwexclist == 1)
        checkBox1 = true;
      else
        checkBox1 = false;      
      if (seObj.mbrwnontargetlist == 1)
        checkBox2 = true;
      else
        checkBox2 = false;
      if (seObj.mbrwairemission == 1)
        checkBox3 = true;
      else
        checkBox3 = false;
      if (seObj.mbrwwastewater == 1)
        checkBox4 = true;
      else
        checkBox4 = false;
      if (seObj.mbrwsolidhazardous == 1)
        checkBox5 = true;
      else
        checkBox5 = false;
      if (seObj.mbrwchemicalfuels == 1)
        checkBox6 = true;
      else
        checkBox6 = false;
      if (seObj.mbrwnoisefumes == 1)
        checkBox7 = true;
      else
        checkBox7 = false;
      if (seObj.mbrwresconsuption == 1)
        checkBox8 = true;
      else
        checkBox8 = false;
      if (seObj.mcinodesignation == 1)
        checkBox9 = true;
      else
        checkBox9 = false;
      if (seObj.mcinci == 1)
        checkBox10 = true;
      else
        checkBox10 = false;
      if (seObj.msilar == 1)
        checkBox11 = true;
      else
        checkBox11 = false;
      if (seObj.msidrofls == 1)
        checkBox12 = true;
      else
        checkBox12 = false;
      if (seObj.msiils == 1)
        checkBox13 = true;
      else
        checkBox13 = false;
      if (seObj.msiiip == 1)
        checkBox14 = true;
      else
        checkBox14 = false;
      if (seObj.msicnc == 1)
        checkBox15 = true;
      else
        checkBox15 = false;
      if (seObj.msiasc == 1)
        checkBox16 = true;
      else
        checkBox16 = false;
      if (seObj.msinsi == 1)
        checkBox17 = true;
      else
        checkBox17 = false;
      if (seObj.mlinpp == 1)
        checkBox18 = true;
      else
        checkBox18 = false;
      if (seObj.mliieh == 1)
        checkBox19 = true;
      else
        checkBox19 = false;
      if (seObj.mliiwc == 1)
        checkBox20 = true;
      else
        checkBox20 = false;
      if (seObj.mliite == 1)
        checkBox21 = true;
      else
        checkBox21 = false;
      if (seObj.mliueo == 1)
        checkBox22 = true;
      else
        checkBox22 = false;
      if (seObj.mlipmw == 1)
        checkBox23 = true;
      else
        checkBox23 = false;
      if (seObj.mliema == 1)
        checkBox24 = true;
      else
        checkBox24 = false;
      if (seObj.mlicfl == 1)
        checkBox25 = true;
      else
        checkBox25 = false;
      if (seObj.mlipevc == 1)
        checkBox26 = true;
      else
        checkBox26 = false;
      if (seObj.mlireou == 1)
        checkBox27 = true;
      else
        checkBox27 = false;
      if (seObj.mlinli == 1)
        checkBox28 = true;
      else
        checkBox28 = false;

    } else {
      seObj = new SocialAndEnvironmentalBean();
      seObj.mloantrefno = widget.loanPassedObject.trefno;
      seObj.mloanmrefno = widget.loanPassedObject.mrefno;
      seObj.mcusttrefno = widget.loanPassedObject.mcusttrefno;
      seObj.mcustmrefno = widget.loanPassedObject.mcustmrefno;
      seObj.mleadsid = widget.loanPassedObject.mleadsid;
    }
    getSessionVariables();

    List tempDropDownValues =  new List();
    tempDropDownValues.add(seObj.mbrwcat);

    for (int k = 0;
    k < globals.dropdownCaptionsValuesSocialAndEnv.length;
    k++) {
      for (int i = 0;
      i < globals.dropdownCaptionsValuesSocialAndEnv[k].length;
      i++) {
        print("k and i is $k $i");
        print(globals.dropdownCaptionsValuesSocialAndEnv[k][i].mcode.length);
        try{
          if (globals.dropdownCaptionsValuesSocialAndEnv[k][i].mcode.toString() ==
              tempDropDownValues[k].toString().trim()) {

            print("matched $k");
            setValue(k, globals.dropdownCaptionsValuesSocialAndEnv[k][i]);
          }
        }catch(_){
          print("Exception in dropdown");
        }
      }
    }
  }

  showDropDown(LookupBeanData selectedObj, int no) {

    if(selectedObj.mcodedesc.isEmpty){
      print("inside  code Desc is null");
      switch (no) {
        case 0:
          brwcat = blankBean;
          seObj.mbrwcat = 0;
          break;
        default:
          break;
      }
      setState(() {
      });
    }
    else{
      for (int k = 0;
      k < globals.dropdownCaptionsValuesSocialAndEnv[no].length;
      k++) {
        if (globals.dropdownCaptionsValuesSocialAndEnv[no][k].mcodedesc ==
            selectedObj.mcodedesc) {
          setValue(no, globals.dropdownCaptionsValuesSocialAndEnv[no][k]);
        }
      }
    }
  }

  setValue(int no, LookupBeanData value) {
    setState(() {
      print("coming here");
      switch (no) {
        case 0:
          brwcat = value;
          seObj.mbrwcat = int.parse(value.mcode);
          break;
        default:
          break;
      }
    });
  }

  LookupBeanData blankBean = new LookupBeanData(mcodedesc: "",mcode: "",mcodetype: 0);
  List<DropdownMenuItem<LookupBeanData>> generateDropDown(int no) {

    List<DropdownMenuItem<LookupBeanData>> _dropDownMenuItems1;
    List<LookupBeanData> mapData = List<LookupBeanData>();
    LookupBeanData bean = new LookupBeanData();
    bean.mcodedesc = "";
    mapData.add(blankBean);
    for (int k = 0;
    k < globals.dropdownCaptionsValuesSocialAndEnv[no].length;
    k++) {
      mapData.add(globals.dropdownCaptionsValuesSocialAndEnv[no][k]);
    }
    _dropDownMenuItems1 = mapData.map((value) {
      return new DropdownMenuItem<LookupBeanData>(
        value: value,
        child: new Text(value.mcodedesc,overflow: TextOverflow.ellipsis,maxLines: 3,),
      );
    }).toList();
    return _dropDownMenuItems1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 3.0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
           onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xff07426A),
        brightness: Brightness.light,
        title: new Text(Translations.of(context).text('SOCIAL_AND_ENVIROMENTAL')),
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
      body: Form(
        key: _formKey,
        onChanged: () {
          final FormState form = _formKey.currentState;
          form.save();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                  child:
                  new TextField(
                  controller: new TextEditingController(
                  text:
                          "${seObj.mloantrefno == null? "0" : seObj.mloantrefno}"
                          "/${seObj.mloanmrefno == null? "0" : seObj.mloanmrefno}"
                          "/${seObj.mleadsid == null||seObj.mleadsid.trim()=="null" ? "0" : seObj.mleadsid}"),
                  enabled: false,
                  decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.teal)),
                      hintText: Translations.of(context)
                          .text('Leads_Id_Leads_Refno'),
                      labelText: Translations.of(context)
                          .text('Leads_Id_Leads_Refno'),
                      prefixText: '',
                      suffixText: '',
                      suffixStyle: const TextStyle(color: Colors.green)),
                )
              ),
              Card(
                color: Constant.mandatoryColor,
                child : new CheckboxListTile(
                    value: checkBox1  ,
                    title: new Text(Translations.of(context).text('I have checked borrower is not on exclusion list')),
                    onChanged: (val) {
                      setState(() {
                        checkBox1 = val;
                      });
                    }),
          ),
              Card(
                color: Constant.mandatoryColor,
                child : new CheckboxListTile(
                    value: checkBox2  ,
                    title: new Text(Translations.of(context).text('I have checked borrower is not on non-target customer list')),
                    onChanged: (val) {
                      setState(() {
                        checkBox2 = val;
                      });
                    }),
              ),
              Card(
                color: Constant.mandatoryColor,
                  child : new CheckboxListTile(
                      value: checkBox3  ,
                      title: new Text(Translations.of(context).text('I have checked borrower is complying with Air emission Applicable legal requirement Compliance status of Legal requirement Evidence of the compliance collected')),
                      onChanged: (val) {
                        setState(() {
                          checkBox3 = val;
                        });
                      }),
              ),
              Card(
                color: Constant.mandatoryColor,
                  child : new CheckboxListTile(
                      value: checkBox4  ,
                      title: new Text(Translations.of(context).text('I have checked borrower is complying with Wastewater Applicable legal requirement Compliance status of Legal requirement Evidence of the compliance collected')),
                      onChanged: (val) {
                        setState(() {
                          checkBox4 = val;
                        });
                      }),
              ),
              Card(
                color: Constant.mandatoryColor,
                  child :new CheckboxListTile(
                      value: checkBox5  ,
                      title: new Text(Translations.of(context).text('I have checked borrower is complying with Solid and hazardous Applicable legal requirement Compliance status of Legal requirement Evidence of the compliance collected')),
                      onChanged: (val) {
                        setState(() {
                          checkBox5 = val;
                        });
                      }),
              ),
              Card(
                color: Constant.mandatoryColor,
                  child :new CheckboxListTile(
                      value: checkBox6  ,
                      title: new Text(Translations.of(context).text('I have checked borrower is complying with Hazardous chemicals, fuels, and pesticides Applicable legal requirement Compliance status of Legal requirement Evidence of the compliance collected')),
                      onChanged: (val) {
                        setState(() {
                          checkBox6 = val;
                        });
                      }),
              ),
              Card(
                color: Constant.mandatoryColor,
                  child :new CheckboxListTile(
                      value: checkBox7  ,
                      title: new Text(Translations.of(context).text('I have checked borrower is complying with Nuisance Dust/Noise/Odors/Fumes/Vibrations/Traffic congestion and Obstructions')),
                      onChanged: (val) {
                        setState(() {
                          checkBox7 = val;
                        });
                      }),
              ),
              Card(
                color: Constant.mandatoryColor,
                  child :new CheckboxListTile(
                      value: checkBox8  ,
                      title: new Text(Translations.of(context).text('I have checked borrower is complying with Resource consumption requirements')),
                      onChanged: (val) {
                        setState(() {
                          checkBox8 = val;
                        });
                      }),
              ),
              new Card(
                child:new Column(children: <Widget>[
                Text(
                Translations.of(context)
                    .text('Community interactions'),
                style: TextStyle(
                    color: Colors.blue, fontSize: 18.0),
                 ),
                 // new Text(Translations.of(context).text('Community interactions')),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox9  ,
                        title: new Text(Translations.of(context).text('No designated person for responding to questions from the community')),
                        onChanged: (val) {
                          setState(() {
                            checkBox9 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox10  ,
                        title: new Text(Translations.of(context).text('No community issue')),
                        onChanged: (val) {
                          setState(() {
                            checkBox10 = val;
                          });
                        }),
                  ),
                ]),
              ),
              new Card(
                child:new Column(children: <Widget>[
                  Text(
                    Translations.of(context)
                        .text('Social Issues'),
                    style: TextStyle(
                        color: Colors.blue, fontSize: 18.0),
                  ),
                  //new Text(Translations.of(context).text('Social Issues')),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox11  ,
                        title: new Text(Translations.of(context).text('Land acquisition required')),
                        onChanged: (val) {
                          setState(() {
                            checkBox11 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox12 ,
                        title: new Text(Translations.of(context).text('Displacement and resettlement of local settlements')),
                        onChanged: (val) {
                          setState(() {
                            checkBox12 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox13 ,
                        title: new Text(Translations.of(context).text('Impact on local settlements and livelihood')),
                        onChanged: (val) {
                          setState(() {
                            checkBox13 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox14 ,
                        title: new Text(Translations.of(context).text('Impact on indigenous people')),
                        onChanged: (val) {
                          setState(() {
                            checkBox14 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox15 ,
                        title: new Text(Translations.of(context).text('Complaints from neighbors and communities')),
                        onChanged: (val) {
                          setState(() {
                            checkBox15 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox16 ,
                        title: new Text(Translations.of(context).text('On or adjacent to site of cultural/archaeological importance')),
                        onChanged: (val) {
                          setState(() {
                            checkBox16 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox17 ,
                        title: new Text(Translations.of(context).text('No Social Issue')),
                        onChanged: (val) {
                          setState(() {
                            checkBox17 = val;
                          });
                        }),
                  ),
                ]),
              ),
              new Card(
                child:new Column(children: <Widget>[
                  Text(
                    Translations.of(context)
                        .text('Labor Issues'),
                    style: TextStyle(
                        color: Colors.blue, fontSize: 18.0),
                  ),
                  //new Text(Translations.of(context).text('Labor Issues')),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox18  ,
                        title: new Text(Translations.of(context).text('No Personal Protective Equipment provided (e.g., safety goggle/hard hat/protective glove)')),
                        onChanged: (val) {
                          setState(() {
                            checkBox18 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox19  ,
                        title: new Text(Translations.of(context).text('Inadequate employee health and safety measures (e.g., fall prevention/ventilation)')),
                        onChanged: (val) {
                          setState(() {
                            checkBox19 = val;
                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox20  ,
                        title: new Text(Translations.of(context).text('Inadequate working conditions (e.g., air quality/lighting/confined spaces/on-site hygiene)')),
                        onChanged: (val) {
                          setState(() {
                            checkBox20 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox21  ,
                        title: new Text(Translations.of(context).text('Inadequate terms of employment (e.g., working hours/rest breaks/time off/overtime pay)')),
                        onChanged: (val) {
                          setState(() {
                            checkBox21 = val;
                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox22  ,
                        title: new Text(Translations.of(context).text('Unequal employment opportunities (e.g., discrimination against gender/ethnic group/age)')),
                        onChanged: (val) {
                          setState(() {
                            checkBox22 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox23  ,
                        title: new Text(Translations.of(context).text('Payment below minimum wage')),
                        onChanged: (val) {
                          setState(() {
                            checkBox23 = val;
                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox24  ,
                        title: new Text(Translations.of(context).text('Employees below minimum age')),
                        onChanged: (val) {
                          setState(() {
                            checkBox24 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox25  ,
                        title: new Text(Translations.of(context).text('Child or forced labour')),
                        onChanged: (val) {
                          setState(() {
                            checkBox25 = val;
                          });
                        }),
                  ),
                  new Card(
                    child :new CheckboxListTile(
                        value: checkBox26  ,
                        title: new Text(Translations.of(context).text('No process for employees to voice complaints')),
                        onChanged: (val) {
                          setState(() {
                            checkBox26 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox27  ,
                        title: new Text(Translations.of(context).text('No recognition of employee organizations/labour unions')),
                        onChanged: (val) {
                          setState(() {
                            checkBox27 = val;
                          });
                        }),
                  ),
                  new Card(
                    child: new CheckboxListTile(
                        value: checkBox28  ,
                        title: new Text(Translations.of(context).text('No Labour Issue')),
                        onChanged: (val) {
                          setState(() {
                            checkBox28 = val;
                          });
                        }),
                  ),
                ]),
              ),
              new Card(
                color: Constant.mandatoryColor,
                child:Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new DropdownButtonFormField(
                    value: brwcat,
                    items: generateDropDown(0),
                    onChanged: (LookupBeanData newValue) {
                      showDropDown(newValue, 0);
                    },
                    validator: (args) {
                      print(args);
                    },
                    decoration: InputDecoration(labelText: Translations.of(context).text('Borrower Categorization')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  proceed() async {
    if (!validateSubmit()) {
      return;
    }
    if (checkBox1 == true)
      seObj.mbrwexclist = 1;
    else
      seObj.mbrwexclist = 0;
    if (checkBox2 == true)
      seObj.mbrwnontargetlist = 1;
    else
      seObj.mbrwnontargetlist = 0;
    if (checkBox3 == true)
      seObj.mbrwairemission = 1;
    else
      seObj.mbrwairemission = 0;
    if (checkBox4 == true)
      seObj.mbrwwastewater = 1;
    else
      seObj.mbrwwastewater = 0;
    if (checkBox5 == true)
      seObj.mbrwsolidhazardous = 1;
    else
      seObj.mbrwsolidhazardous = 0;
    if (checkBox6 == true)
      seObj.mbrwchemicalfuels = 1;
    else
      seObj.mbrwchemicalfuels = 0;
    if (checkBox7 == true)
      seObj.mbrwnoisefumes = 1;
    else
      seObj.mbrwnoisefumes = 0;
    if (checkBox8 == true)
      seObj.mbrwresconsuption = 1;
    else
      seObj.mbrwresconsuption = 0;
    if (checkBox9 == true)
      seObj.mcinodesignation = 1;
    else
      seObj.mcinodesignation = 0;
    if (checkBox10 == true)
      seObj.mcinci = 1;
    else
      seObj.mcinci = 0;
    if (checkBox11 == true)
      seObj.msilar = 1;
    else
      seObj.msilar = 0;
    if (checkBox12 == true)
      seObj.msidrofls = 1;
    else
      seObj.msidrofls = 0;
    if (checkBox13 == true)
      seObj.msiils = 1;
    else
      seObj.msiils = 0;
    if (checkBox14 == true)
      seObj.msiiip = 1;
    else
      seObj.msiiip = 0;
    if (checkBox15 == true)
      seObj.msicnc = 1;
    else
      seObj.msicnc = 0;
    if (checkBox16 == true)
      seObj.msiasc = 1;
    else
      seObj.msiasc = 0;
    if (checkBox17 == true)
      seObj.msinsi = 1;
    else
      seObj.msinsi = 0;
    if (checkBox18 == true)
      seObj.mlinpp = 1;
    else
      seObj.mlinpp = 0;
    if (checkBox19 == true)
      seObj.mliieh = 1;
    else
      seObj.mliieh = 0;
    if (checkBox20 == true)
      seObj.mliiwc = 1;
    else
      seObj.mliiwc = 0;
    if (checkBox21 == true)
      seObj.mliite = 1;
    else
      seObj.mliite = 0;
    if (checkBox22 == true)
      seObj.mliueo = 1;
    else
      seObj.mliueo = 0;
    if (checkBox23 == true)
      seObj.mlipmw = 1;
    else
      seObj.mlipmw = 0;
    if (checkBox24 == true)
      seObj.mliema = 1;
    else
      seObj.mliema = 0;
    if (checkBox25 == true)
      seObj.mlicfl = 1;
    else
      seObj.mlicfl = 0;
    if (checkBox26 == true)
      seObj.mlipevc = 1;
    else
      seObj.mlipevc = 0;
    if (checkBox27 == true)
      seObj.mlireou = 1;
    else
      seObj.mlireou = 0;
    if (checkBox28 == true)
      seObj.mlinli = 1;
    else
      seObj.mlinli = 0;

    seObj.mcreatedby = username;
    seObj.mlastupdateby = null;

    if ((seObj.mcreateddt == 'null') || (seObj.mcreateddt == null))
      seObj.mcreateddt = DateTime.now();

    seObj.mlastupdatedt = DateTime.now();
    seObj.mgeolatd=geoLatitude;
    seObj.mgeologd=geoLongitude;
    seObj.missynctocoresys=0;
    if( seObj.mrefno==null){
      seObj.mrefno=0;
    }
    await AppDatabase.get()
        .updateSocialEnvironmentMaster(seObj)
        .then((val) {
      print("val here is " + val.toString());

    });
    _successfulSubmit();
  }

  bool validateSubmit(){

    if(checkBox1 == false){
      _showAlertWithError(Translations.of(context).text('I have checked borrower is not on exclusion list'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox2 == false){
      _showAlertWithError(Translations.of(context).text('I have checked borrower is not on non-target customer list'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox3 == false){
      _showAlertWithError(Translations.of(context).text('I have checked borrower is complying with Air emission Applicable legal requirement Compliance status of Legal requirement Evidence of the compliance collected'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox4 == false){
      _showAlertWithError(Translations.of(context).text('I have checked borrower is complying with Wastewater Applicable legal requirement Compliance status of Legal requirement Evidence of the compliance collected'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox5 == false){
      _showAlertWithError(Translations.of(context).text('I have checked borrower is complying with Solid and hazardous Applicable legal requirement Compliance status of Legal requirement Evidence of the compliance collected'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox6 == false){
      _showAlertWithError(Translations.of(context).text('I have checked borrower is complying with Hazardous chemicals, fuels, and pesticides Applicable legal requirement Compliance status of Legal requirement Evidence of the compliance collected'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox7 == false){
      _showAlertWithError(Translations.of(context).text('I have checked borrower is complying with Nuisance Dust/Noise/Odors/Fumes/Vibrations/Traffic congestion and Obstructions'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox8 == false){
      _showAlertWithError(Translations.of(context).text('I have checked borrower is complying with Resource consumption requirements'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox9 == false && checkBox10 == false ){
      _showAlertWithError(Translations.of(context).text('Community interactions'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox11 == false && checkBox12 == false && checkBox13 == false && checkBox14 == false && checkBox15 == false && checkBox16 == false  && checkBox17 == false){
      _showAlertWithError(Translations.of(context).text('Social Issues'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(checkBox18 == false && checkBox19 == false && checkBox20 == false && checkBox21 == false && checkBox22 == false && checkBox23 == false && checkBox24 == false &&
       checkBox25 == false && checkBox26 == false && checkBox27 == false && checkBox28 == false){
      _showAlertWithError(Translations.of(context).text('Labor Issues'), Translations.of(context).text("itIsMand"));
      return false;
    }
    if(seObj.mbrwcat == ""||seObj.mbrwcat==null){
      _showAlertWithError(Translations.of(context).text('Borrower Categorization'), Translations.of(context).text("itIsMand"));
      return false;
    }
    return true;
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

  Future<void> _showAlertWithError(arg, error) async {
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

}
