
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDetailsMasterTab.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/AreaDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/translations.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
var docListView=new List<PhotoViewGalleryPageOptions>();

class CustomerLoanAddressDetails extends StatefulWidget {

  /*CustomerLoanDetailsBean laonLimitPassedObject;
  CustomerLoanAddressDetails({Key key, this.laonLimitPassedObject}) : super(key: key);*/






  @override
  _CustomerLoanAddressDetailsState createState() =>
      new _CustomerLoanAddressDetailsState();
}

class _CustomerLoanAddressDetailsState
    extends State<CustomerLoanAddressDetails> {


  String countryCd = "";
  String countryName = "";
  int distCd ;
  String distName = "";
  String stateCd = "";
  String stateName = "";
  String cityCd = "";
  String cityName= "";
  String placeCd;
  String placeName = "";
  int areaCd;
  String areaName = "";
  String addr1 = "";
  String addr2 = "";
  SharedPreferences prefs;
  int residentialCode;


  File _image;


  @override
  void initState() {
    super.initState();
    // getSessionVariables();

    getAdressDetails();

  }



  void getAdressDetails() async{



    prefs = await SharedPreferences.getInstance();
    residentialCode = await prefs.getInt(TablesColumnFile.resAddCode);



  if( CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj!=null&& CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno!=null
      && CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno!=null)
  {
    await AppDatabase.get()
        .selectCustomerAddressDetailsListIsDataSynced(
         CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcusttrefno,  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcustmrefno)
        .then((List<AddressDetailsBean> addressDetails) async {

          if(addressDetails!=null&&addressDetails.isNotEmpty){


            for (int i = 0; i < addressDetails.length; i++) {

              print("adress type ${addressDetails[i].maddrType}" );
              print("residential code e ${residentialCode}" );
              if(addressDetails[i].maddrType==residentialCode){
                countryCd = addressDetails[i].mcountryCd;

                if(countryCd!=null&&countryCd.trim!=''){
                  await AppDatabase.get().getCountryNameViaCountryCode(countryCd).then((val){


                    countryName = val.countryName;

                  });



                }


                stateCd= addressDetails[i].mState;
                if(stateCd!=null&&stateCd.trim!=''){
                  await AppDatabase.get().getStateNameViaStateCode( stateCd).then(( StateDropDownList val){


                    stateName = val.stateDesc;

                  });



                }

                distCd= addressDetails[i].mDistCd;
                if(distCd!=null&&distCd!=0){
                  await AppDatabase.get().getDistrictNameViaDistrictCode( distCd.toString()).then(( DistrictDropDownList val){


                    distName = val.distDesc;

                  });



                }



                cityCd = addressDetails[i].mcityCd;
                if(cityCd!=null&&cityCd.trim()!=''&&cityCd.trim()!='null'){
                  await AppDatabase.get().getPlaceNameViaPlaceCode( cityCd.toString()).then(( SubDistrictDropDownList val){


                    cityName = val.placeCdDesc;

                  });



                }


                placeCd =  addressDetails[i].mplacecd;

                if(placeCd!=null&&placeCd.trim()!=''&&placeCd.trim()!='null'){
                  await AppDatabase.get().getPlaceNameViaPlaceCode( placeCd.toString()).then(( SubDistrictDropDownList val){


                    placeName = val.placeCdDesc;

                  });



                }

                areaCd = addressDetails[i].marea;


                if(areaCd!=null&&areaCd!=0){
                  await AppDatabase.get().getAreaNameViaAreaCode( areaCd.toString()).then(( AreaDropDownList val){
                    areaName = val.areaDesc;
                  });



                }


                addr1 = addressDetails[i].maddr1;
                addr2 = addressDetails[i].maddr2;


              }

            }

          }

    });




  }
  try{
    setState(() {

    });
  }catch(_){


  }




  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
      SizedBox(
      height: 16.0,
      ),



    Container(
    color: Constant.mandatoryColor,
        child:new ListTile(

          title: new Text( Translations.of(context).text("Country")),
          subtitle: countryCd == null ||
              countryCd  == "null"
              ? new Text("")
              : new Text("${countryCd } ${countryName==null||countryName.trim()=='null'?'':countryName}"),

        )
    ),
        SizedBox(
          height: 5.0,
        ),

    Container(
    color: Constant.mandatoryColor,
    child:
        new ListTile(
          title: new Text(Translations.of(context).text("State")),
          subtitle: stateCd == null ||
              stateCd  == "null"
              ? new Text("")
              : new Text("${stateCd } ${stateName==null||stateName.trim()=='null'?'':stateName}"),

        ),),
        SizedBox(
          height: 5.0,
        ),

    Container(
    color: Constant.mandatoryColor,
    child:new ListTile(
          title: new Text(Translations.of(context).text('zone')),
          subtitle: cityCd == null ||
              cityCd  == "null"
              ? new Text("")
              : new Text("${cityCd } ${cityName==null||cityName.trim()=='null'?'':cityName}"),

        )),
        SizedBox(
          height: 5.0,
        ),

    /*Container(
    color: Constant.mandatoryColor,
      child:new ListTile(
            title: new Text(Translations.of(context).text('zone')),
            subtitle: distCd == null ||
                distCd  == "null"
                ? new Text("")
                : new Text("${distCd}  ${distName==null||distName.trim()=='null'?'':distName}"),

          )),*/

        SizedBox(
          height: 5.0,
        ),



    Container(
    color: Constant.mandatoryColor,
    child:new ListTile(
          title: new Text(Translations.of(context).text('area')),
          subtitle: areaCd == null ||
              areaCd  == "null"||areaCd==0
              ? new Text("")
              : new Text("${areaCd} ${areaName==null||areaName.trim()=='null'?'':areaName}"),

        )),
        SizedBox(
          height: 5.0,
        ),
        Container(
            color: Constant.mandatoryColor,
            child:new ListTile(
              title: new Text(Translations.of(context).text('Address_Line_1')),
              subtitle: addr1 == null ||
                  addr1  == "null"
                  ? new Text("")
                  : new Text("${addr1} , ${addr2}"),

            )),



        new CheckboxListTile(
    subtitle: new Text(Translations.of(context).text('residentialAddressChanged'))
    ,value:  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj!=null&& CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckresaddchng==1?true:false, onChanged: (bool val){

          setState(() {

            if(val==true) CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckresaddchng = 1;
            else  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.mcheckresaddchng = 0;

          });


        }),




        new Container(
          padding: new EdgeInsets.all(8.0),
          child:Center(
    child:Text(
      Translations.of(context).text('Click_Below_for_pic'),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    )



        ),
        new Row(
          children: <Widget>[
            new Flexible(
              child: new Column(
                children: <Widget>[
                  new Center(
                    child: new Stack(
                      children: <Widget>[
                        getCircleContainer(0),

                        new Positioned(
                          child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: new Icon(Icons.camera_alt,size: 50, color: Color(0xff07426A)),
                               onPressed: () { globals.sessionTimeOut=new SessionTimeOut(context: context);
     globals.sessionTimeOut.SessionTimedOut();
                                print("Here");
                                _PickImage(0);
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

          ],
        )
    ]
    );
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
                        behavior: HitTestBehavior.opaque,
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
                        behavior: HitTestBehavior.opaque,
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



  Future getImage(int no) async {
    if (CustomerLoanDetailsMasterTabState
            .customerLoanDetailsBeanObj.loanimageBeans ==
        null) {
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
          .loanimageBeans = new List<CustomerLoanImageBean>();
      for (int i = 0; i < 5; i++) {
        CustomerLoanDetailsMasterTabState
            .customerLoanDetailsBeanObj.loanimageBeans
            .add(new CustomerLoanImageBean());
      }
    }
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      //ratioX: 1.5,
      //ratioY: 1.0,
      maxWidth: 640,
      maxHeight: 640,
    );
    File newImage = await croppedFile.copy(image.path);
    try {
      croppedFile.delete();
    } catch (_) {}
    CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
        .loanimageBeans[no].mimagestring = newImage.path;
    if (no == 0) {
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
          .loanimageBeans[no].mimagetype = "Address1";
    } else if (no == 1) {
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
          .loanimageBeans[no].mimagetype = "Address2";
    }
    CustomerLoanDetailsMasterTabState
        .customerLoanDetailsBeanObj.loanimageBeans[no].missynctocoresys = 0;
    setState(() {
      _image = newImage;
    });
  }






  Future getImageFromGallery(int no) async {
    if (CustomerLoanDetailsMasterTabState
            .customerLoanDetailsBeanObj.loanimageBeans ==
        null) {
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
          .loanimageBeans = new List<CustomerLoanImageBean>();
      for (int i = 0; i <= 5; i++) {
        CustomerLoanDetailsMasterTabState
            .customerLoanDetailsBeanObj.loanimageBeans
            .add(new CustomerLoanImageBean());
      }
    }
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      //ratioX: 1.5,
      //ratioY: 1.0,
      maxWidth: 640,
      maxHeight: 640,
    );
    File newImage = await croppedFile.copy(image.path);
    try {
      croppedFile.delete();
    } catch (_) {}
    CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
        .loanimageBeans[no].mimagestring = newImage.path;

    if (no == 0) {
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
          .loanimageBeans[no].mimagetype = "Address1";
    } else if (no == 1) {
      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj
          .loanimageBeans[no].mimagetype = "Address2";
    }
    CustomerLoanDetailsMasterTabState
        .customerLoanDetailsBeanObj.loanimageBeans[no].missynctocoresys = 0;
    setState(() {
      _image = newImage;
    });
  }





  Future<void> _PickImageDialog(int imageNo) async {
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
                        behavior: HitTestBehavior.opaque,
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
                        behavior: HitTestBehavior.opaque,
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
                      )


                    ],

                    )


                  ],
                ) ,
              )

          );
        });
  }



  Future<void> _showImage() async {

    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            ViewImageScreen()));
  }
  Widget getCircleContainer(int i) {
    imageCache.clear();
    try {
      return
        new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            print("Container clicked");
            imageCache.clear();
            docListView = new List<PhotoViewGalleryPageOptions>();

            if (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring !=
                null &&
                CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans !=
                    null &&
                CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring !=
                    "") {
              docListView = new List<PhotoViewGalleryPageOptions>();
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring )
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
                  CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans !=
                      null &&
                      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring !=
                          null &&
                      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans !=
                          null &&
                      CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring !=
                          ""
                      ?
                  MemoryImage(File(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring).readAsBytesSync())

                      : new ExactAssetImage('assets/Document.png'),

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
            print("CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring${CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring}");
            if (CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring !=
                null &&
                CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans !=
                    null &&
                CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring !=
                    "") {
              docListView.add(PhotoViewGalleryPageOptions(
                  imageProvider: MemoryImage(
                      File(CustomerLoanDetailsMasterTabState.customerLoanDetailsBeanObj.loanimageBeans[i].mimagestring)
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
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff07426A), width: 0.3),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  //repeat: ImageRepeat.noRepeat,
                  image: new ExactAssetImage('assets/Document.png'),

                )

            ),
          ),
        );
    }
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