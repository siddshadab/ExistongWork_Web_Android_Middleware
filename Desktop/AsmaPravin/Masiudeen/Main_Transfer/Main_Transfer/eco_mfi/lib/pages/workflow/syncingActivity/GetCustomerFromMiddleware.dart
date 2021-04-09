import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerFingerPrintBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:path_provider/path_provider.dart';

class GetCustomerFromMiddleware{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCustomerDetails =
      "customerData/getCustomerbyCreatedByAndLastSyncedTiming/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;
  CustomerFingerPrintBean customerFingerPrintBean;
  String ackUrl = "customerData/updateCustomerSyncFromServer/";

  var fingerPrintUrl =  "customerData/getFinprintByCustNo/";
  var guarantorCustomer =  "customerData/getCustomerForGaurantor/";
  List mrefNoList = new List();
  var urlGetCustomerImages =
      "customerImagesMaster/getCustomerImages/";

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;

    isNetworkAvailable = await Utility.checkIntCon();
  //  isNetworkAvailable = true;
    if (isNetworkAvailable) {
      await getMiddleWareData(userName, urlGetCustomerDetails);
    }
  }


  Future<Null> getData(ImageBean bean) async{
    await  getImageStringPath(bean);
  }



  Future<Null> getImageStringPath(ImageBean bean)async{
    setBean = bean;
    Uint8List bytes =  base64.decode(bean.imgString);
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/eco_mfi/getCustomerSyncedData';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    File file = new File(filePath);
    if (file.existsSync()) {
      setBean.imgString = file.path;
      bean.imgString = file.path;
      setBean.imgType=bean.imgType;
      setBean.imgSubType=bean.imgSubType;

    } else {
      print(" file bytes  here is " +bytes.toString());
      setBean.imgType=bean.imgType;
      setBean.imgSubType=bean.imgSubType;
      await file.writeAsBytes(bytes);
      print(setBean.imgType.toString()+" file path here is ");
      print(setBean.imgSubType.toString()+" file path here is ");
      print(file.path.toString()+" file path here is ");
      setBean.imgString = file.path;


    }

  }

  Future<Null> updateCustomer(CustomerListBean custBean) async {

    try {
      if (custBean.missynctocoresys == 0) {
        custBean.missynctocoresys = 1;
      }
    }catch(_){}

  try{
    await AppDatabase.get()
        .updateCustomerFoundationMasterDetailsTable(custBean,false)
        .then((onValue) {
    });
  }catch(_){}
  try{
    print("Customer Mater Update Complete");
    await AppDatabase.get()
        .updateCustomerFoundationAddressDetailsListTable(custBean,true)
        .then((onValue) {
      //id = onValue;
    });
  }catch(_){}
  try{
    print("Customer adress Update Complete");
    await AppDatabase.get()
        .updateCustomerFoundationFamilyDetailsListTable(custBean)
        .then((onValue) {
      //id = onValue;
    });
  }catch(_){}
  try{
    print("Customer family Update Complete");
    await AppDatabase.get()
        .updateCustomerFoundationBorrowingDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
  }catch(_){}
  try{
    await AppDatabase.get()
        .updateCustomerPPIDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
  }catch(_){}
  try{
    print("Customer PPI Update Complete");
    await AppDatabase.get()
        .updateCustomerBusinessExpenseDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
  }catch(_){}
  try{
    print("Customer Business Expense Update Complete");
    await AppDatabase.get()
        .updateCustomerHouseholdExpenseDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
  }catch(_){}
  try{
    print("Customer Household Expense Update Complete");
    await AppDatabase.get()
        .updateCustomerAssetDetailsListTable(custBean)
        .then((onValue) {
      //  id = onValue;
    });
  }catch(_){}
  try{
    print("Customer Asset Update Complete");

    // print("Customer borrowing Update Complete"+obj[cust].customerBusinessDetailsBean.mbussdetailsrefno.toString());
    // obj[cust].customerBusinessDetailsBean.tbussdetailsrefno=1;
    if (custBean.customerBusinessDetailsBean != null) {
      await AppDatabase.get()
          .updateCustomerFoundationBusinessDetailsTableFromMiddleware(
          custBean)
          .then((onValue) {
        // id = onValue;
      });
    }
  }catch(_){}
  try{
    print("Customer business details Update Complete");
    List<ImageBean> imgBean = custBean.imageMaster;
    if (custBean.imageMaster!=null) {
      for(int i =0;i<23;i++){
        custBean.imageMaster.add(new ImageBean());
      }
    }
    if (imgBean!=null) {
      for (int img = 0; img < imgBean.length; img++) {
        if ( imgBean[img].imgString!=null&&imgBean[img].tImgrefno !=null
            &&!(imgBean[img].tImgrefno > 10)
        ) {
          print("signature or no "+imgBean[img].imgSubType.toString());
          //  if(imgBean[img].imgString!=null) {
          await getData(imgBean[img]);
          //  }
        } else {
          setBean = imgBean[img];
        }
        /*  print("obj.getpath of img " +
                  obj[cust].imageMaster[img].imgString.toString());*/
        setBean.mrefno = custBean.mrefno;
        AppDatabase.get().updateImageMaster(
            setBean, imgBean[img].tImgrefno);
      }
    }

  }catch(_){}

    //Update CPV here
    try {
      if (custBean.contactPointVerificationBean != null) {
        await AppDatabase.get()
            .updateCustomerCpvTable(
            custBean)
            .then((onValue) {
          // id = onValue;
        });
      }
    }catch(_){}



    try{
      print("Customer Image details Update Complete");
      List<CustomerFingerPrintBean> fingerPrintBeanList = custBean.customerfingerprintlist;

      if (fingerPrintBeanList!=null) {
        for (int fingerCount = 0; fingerCount < fingerPrintBeanList.length; fingerCount++) {


            //  if(imgBean[img].imgString!=null) {
          customerFingerPrintBean = fingerPrintBeanList[fingerCount];
            //  }

          customerFingerPrintBean.mrefno = custBean.mrefno;


          AppDatabaseExtended.get().updateCustomerFingerPrintMaster(
              customerFingerPrintBean, fingerPrintBeanList[fingerCount].timagerefno);
        }
      }

    }catch(_){}





  }






  Future<Null> getMiddleWareData(
      String userName, String url) async {
    //await AppDatabase.get().deletSomeUtil();
    DateTime isGreaterToSynced=null;
    List<CustomerListBean> isGreaterToSyncedcustomerData ;

/*    //After get sync we will make date greater, customer which is updatted before getsync frm server, those cusomer havr to br synced to server
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1, false)
        .then((onValue) async {
      isGreaterToSynced=onValue;
      if(isGreaterToSynced==null){

        await AppDatabase.get()
            .selectCustomerListIsDataSynced(onValue)
            .then((List<CustomerListBean> customerData) async {
          print("lengtrh cust " + customerData.length.toString());
          isGreaterToSyncedcustomerData=customerData;
        });

      }

    });*/

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1,true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName,onValue);
    });
    try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + url.toString(), _headers);
      print("url " + Constant.apiURL.toString() + url.toString());
      if (bodyValue == "404" ) {
        return null;
      } else {
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        DateTime updateDateimeAfterUpdate = DateTime.now();
        List<CustomerListBean> obj = parsed
            .map<CustomerListBean>(
                (json) => CustomerListBean.fromMapMiddleware(json, true))
            .toList();

        for (int cust = 0; cust < obj.length; cust++) {
          obj[cust].mmobilelastsynsdate = DateTime.now();
          try {

            try {
              if (obj[cust].missynctocoresys == 0) {
                obj[cust].missynctocoresys = 1;
              }
            }catch(_){}
            await AppDatabase.get()
                .updateCustomerFoundationMasterDetailsTable(obj[cust], false)
                .then((onValue) {
              // customerNumberValue = onValue;
            });
            mrefNoList.add(obj[cust].mrefno);
          }catch(_){}
            try{
          print("Customer Mater Update Complete");
          await AppDatabase.get()
              .updateCustomerFoundationAddressDetailsListTable(obj[cust],true)
              .then((onValue) {
            //id = onValue;
          });
            }catch(_){}
          try{
          print("Customer adress Update Complete");
          await AppDatabase.get()
              .updateCustomerFoundationFamilyDetailsListTable(obj[cust])
              .then((onValue) {
            //id = onValue;
          });
          }catch(_){}
          try{
          print("Customer family Update Complete");
          await AppDatabase.get()
              .updateCustomerFoundationBorrowingDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          }catch(_){}
          try{
          await AppDatabase.get()
              .updateCustomerPPIDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          }catch(_){}
          try{

          print("Customer PPI Update Complete");
          await AppDatabase.get()
              .updateCustomerBusinessExpenseDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          }catch(_){}
          try{
          print("Customer Business Expense Update Complete");
          await AppDatabase.get()
              .updateCustomerHouseholdExpenseDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          }catch(_){}
          try{
          print("Customer Household Expense Update Complete");
          await AppDatabase.get()
              .updateCustomerAssetDetailsListTable(obj[cust])
              .then((onValue) {
            //  id = onValue;
          });
          }catch(_){}
          try{
          print("Customer Asset Update Complete");

          // print("Customer borrowing Update Complete"+obj[cust].customerBusinessDetailsBean.mbussdetailsrefno.toString());
          // obj[cust].customerBusinessDetailsBean.tbussdetailsrefno=1;
          if (obj[cust].customerBusinessDetailsBean != null) {
            await AppDatabase.get()
                .updateCustomerFoundationBusinessDetailsTableFromMiddleware(
                obj[cust])
                .then((onValue) {
              // id = onValue;
            });
          }

          }catch(_){}
          try{
          print("Customer business details Update Complete");
          List<ImageBean> imgBean = obj[cust].imageMaster;
          // if (obj[cust].imageMaster!=null) {
          //   for(int i =0;i<23;i++){
          //     obj[cust].imageMaster.add(new ImageBean());//ye kya ho rha hai
          //   }
          // }
          if (imgBean!=null) {
            for (int img = 0; img < imgBean.length; img++) {
              if (imgBean[img].imgSubType != 'Signature' && imgBean[img].imgString!=null &&!(imgBean[img].tImgrefno > 10)
              )  {
                print("signature or no "+imgBean[img].imgSubType.toString());
              //  if(imgBean[img].imgString!=null) {
                  await getData(imgBean[img]);
              //  }
              } else {
                setBean = imgBean[img];
              }
              /*  print("obj.getpath of img " +
                  obj[cust].imageMaster[img].imgString.toString());*/
              setBean.mrefno = obj[cust].mrefno;
              if(obj[cust].mcustno!=null){
                setBean.mcustno = obj[cust].mcustno;
              }
              AppDatabase.get().updateImageMaster(
                  setBean, imgBean[img].tImgrefno);
            }
          }

          }catch(_){}

          //Update CPV here
          try {
            if (obj[cust].contactPointVerificationBean != null) {
              await AppDatabase.get()
                  .updateCustomerCpvTable(
                  obj[cust])
                  .then((onValue) {
                // id = onValue;
              });
            }
          }catch(_){}



          try{
            //print("Customer Image details Update Complete");
            List<CustomerFingerPrintBean> fingerPrintBeanList = obj[cust].customerfingerprintlist;

            if (fingerPrintBeanList!=null) {
              for (int fingerCount = 0; fingerCount < fingerPrintBeanList.length; fingerCount++) {


                //  if(imgBean[img].imgString!=null) {
                customerFingerPrintBean = fingerPrintBeanList[fingerCount];
                //  }

                customerFingerPrintBean.mrefno = obj[cust].mrefno;
                if(obj[cust].mcustno!=null){
                  customerFingerPrintBean.mcustno = obj[cust].mcustno;
                }


                AppDatabaseExtended.get().updateCustomerFingerPrintMaster(
                    customerFingerPrintBean, fingerPrintBeanList[fingerCount].timagerefno);
              }
            }

          }catch(_){}








        }
        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(1,updateDateimeAfterUpdate);


        if(mrefNoList.isNotEmpty){
           var mapData = new Map();
           mapData[TablesColumnFile.mrefnolist] = mrefNoList;
            String ackJson = await JSON.encode(mapData);
            print("Secong Sending Josn is ${ackJson} ");
            await NetworkUtil.callPostService(ackJson.toString(),
          Constant.apiURL.toString() + ackUrl.toString(), _headers);
        }

        /*await AppDatabase.get()
            .selectStaticTablesLastSyncedMaster(1,false)
            .then((onValue) async {
          if(onValue==null){
            AppDatabase.get().updateStaticTablesLastSyncedMaster(1);
          }

        });*/

   /*     if(isGreaterToSynced==null){
          AppDatabase.get().updateStaticTablesLastSyncedMaster(1);
          if(isGreaterToSyncedcustomerData!=null){
            for (int cust = 0; cust < isGreaterToSyncedcustomerData.length; cust++) {
              String  updateCustQuery = "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now().add(
                  Duration(seconds: 30))}' WHERE ${TablesColumnFile
                  .mrefno} = ${isGreaterToSyncedcustomerData[cust].mrefno} AND ${TablesColumnFile
                  .trefno} = ${isGreaterToSyncedcustomerData[cust].trefno}";
              if (updateCustQuery != null) {
                await AppDatabase.get().updateCustomerMaster(updateCustQuery);
              }
            }
          }


        }*/





      }

  } catch (e) {
  print('Server Exception!!!');
  print(e);
  }

  }

  String _toJsonOfCreatedByAndLastSyncedDateTime(String createdBy, DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = createdBy.trim();
    mapData["mlastsynsdate"] = lastsyncedDateTime!=null && lastsyncedDateTime!='null' && lastsyncedDateTime!=''? lastsyncedDateTime.toIso8601String():null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }




  Future<List<ImageBean>> getImageFromMiddleware(int custno) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    //  isNetworkAvailable = true;
    if (isNetworkAvailable) {
      var mapData = new Map();
      mapData["mcustno"] = custno;
      String json = JSON.encode(mapData);
      print("Sebding JSON IS $json");
    //  try {
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
    Constant.apiURL.toString() + fingerPrintUrl.toString(), _headers);
    print("For finger print ${bodyValue}");
    if(bodyValue==null||bodyValue==404){
      return List<ImageBean>();
    }else{

      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      List<ImageBean> obj = parsed
          .map<ImageBean>(
              (json) => ImageBean.fromMapFromMiddleWare(json))
          .toList();

      print("Length is ${obj.length}");

      print("Returning bean is $obj");
      return obj;

    }
    }
    else{

      return List<ImageBean>();
    }

  }


    Future<CustomerListBean> getCustData(int mcustno,String mnationalId) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      var mapData = new Map();
      mapData["mcustno"] = mcustno==null?0:mcustno;
      mapData[TablesColumnFile.mnationalid] = mnationalId;
      String json = JSON.encode(mapData);
      print("Sebding JSON IS $json");
    //  try {
    String bodyValue = await NetworkUtil.callPostService(json.toString(),
    Constant.apiURL.toString() + guarantorCustomer.toString(), _headers);
    print("For finger print ${bodyValue}");
    if(bodyValue==null||bodyValue.trim()=="404"||bodyValue==''){
      return null;
    }else{

      Map<String, dynamic> map = JSON.decode(bodyValue);
      CustomerListBean obj = CustomerListBean.fromMapMiddleware(map, true);


    List<ImageBean> imgBean = new List<ImageBean>();
          if ( obj.imageMaster!=null) {
            for (int img = 0; img <  obj.imageMaster.length; img++) {
              if ( obj.imageMaster[img].imgSubType != 'Signature' &&  obj.imageMaster[img].imgString!=null &&!( obj.imageMaster[img].tImgrefno > 10)
              )  {
                print("signature or no "+ obj.imageMaster[img].imgSubType.toString());
              //  if(imgBean[img].imgString!=null) {
                  await getData( obj.imageMaster[img]);
              //  }
              } else {
                setBean =  obj.imageMaster[img];
              }
              imgBean.add(setBean);
              
            }
          }

          obj.imageMaster = new List<ImageBean>();
          obj.imageMaster = imgBean;



      print("Image master is  ${obj.imageMaster}");


      return obj;

    }
    }
    else{

      return null;
    }


    }



  Future<Null> getCustomerImages  (int mrefno,int trefno) async{

    var mapData = new Map();
     mapData[TablesColumnFile.mrefno] = mrefno;
    String json = await JSON.encode(mapData);
      print("image k lie json hai ${json}" );
    
    try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + urlGetCustomerImages.toString(), _headers);
      print("url " + Constant.apiURL.toString() + urlGetCustomerImages.toString());
      if (bodyValue == "404"||bodyValue==null ) {
        return null;
      } else {

        final parsed = await JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<ImageBean> obj = await parsed
            .map<ImageBean>(
                (json) => ImageBean.fromMapFromMiddleWare(json))
            .toList();

    if (obj!=null) {
      for (int img = 0; img < obj.length; img++) {
        if ( obj[img].imgString!=null&&obj[img].tImgrefno !=null
            &&!(obj[img].tImgrefno > 10)
        ) {
          print("signature or no "+obj[img].imgSubType.toString());
          //  if(imgBean[img].imgString!=null) {
          await getData(obj[img]);
          //  }
        } else {
          setBean = obj[img];
        }
        setBean.mrefno = mrefno;
        setBean.trefno = trefno;
        await AppDatabase.get().updateImageMaster(
            setBean, obj[img].tImgrefno);
      }
    }
          

      }
    }catch(_){

    }

    print("Images get krne vala method khatam hua");
  }




  Future<List<CustomerFingerPrintBean>> getFingerPrint(int custno) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    //  isNetworkAvailable = true;
    if (isNetworkAvailable) {
      var mapData = new Map();
      mapData["mcustno"] = custno;
      String json = JSON.encode(mapData);
      print("Sebding JSON IS $json");
      //  try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + fingerPrintUrl.toString(), _headers);
      print("For finger print ${bodyValue}");
      if(bodyValue==null||bodyValue==404){
        return List<CustomerFingerPrintBean>();
      }else{

        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerFingerPrintBean> obj = parsed
            .map<CustomerFingerPrintBean>(
                (json) => CustomerFingerPrintBean.fromMapFromMiddleWare(json))
            .toList();

        print("Length is ${obj.length}");

        print("Returning bean is $obj");
        return obj;

      }
    }
    else{

      return List<CustomerFingerPrintBean>();
    }

  }


}