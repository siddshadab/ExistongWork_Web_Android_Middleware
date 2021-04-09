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

class GetCustomerFromCenter{
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCustomerDetails =
      "customerData//getCustomerbyCenterId/";
  static const JsonCodec JSON = const JsonCodec();
  ImageBean setBean;
  CustomerFingerPrintBean customerFingerPrintBean;

  Future<Null> trySave(int mcenterId) async {
    bool isNetworkAvailable;
    //isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData(mcenterId, urlGetCustomerDetails);
    }
  }


  Future<Null> getMiddleWareData(
      int mcenterId, String url) async {
    //await AppDatabase.get().deletSomeUtil();

    String json;
    DateTime isGreaterToSynced=null;
    List<CustomerListBean> isGreaterToSyncedcustomerData ;

    //After get sync we will make date greater, customer which is updatted before getsync frm server, those cusomer havr to br synced to server
   /* await AppDatabase.get()
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

      json = await _toJsonOfCenterId(mcenterId);
    try {
    print("start timing "+DateTime.now().toIso8601String())
    ;      String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + url.toString(), _headers);
    print("url " + Constant.apiURL.toString() + url.toString());
    if (bodyValue == "404" ) {
      return null;
    } else {
      print(bodyValue);
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      List<CustomerListBean> obj = parsed
          .map<CustomerListBean>(
              (json) => CustomerListBean.fromMapMiddleware(json, true))
          .toList();

      for (int cust = 0; cust < obj.length; cust++) {
        obj[cust].mmobilelastsynsdate = DateTime.now();
        try {
          if (obj[cust].missynctocoresys == 0) {
            obj[cust].missynctocoresys = 1;
          }
        }catch(_){}

        await AppDatabase.get()
            .updateCustomerFoundationMasterDetailsTable(obj[cust],false)
            .then((onValue) {
          // customerNumberValue = onValue;

        });

        print("Customer Mater Update Complete");
        await AppDatabase.get()
            .updateCustomerFoundationAddressDetailsListTable(obj[cust],true)
            .then((onValue) {
          //id = onValue;
        });
        print("Customer adress Update Complete");
        await AppDatabase.get()
            .updateCustomerFoundationFamilyDetailsListTable(obj[cust])
            .then((onValue) {
          //id = onValue;
        });
        print("Customer family Update Complete");
        await AppDatabase.get()
            .updateCustomerFoundationBorrowingDetailsListTable(obj[cust])
            .then((onValue) {
          //  id = onValue;
        });
        await AppDatabase.get()
            .updateCustomerPPIDetailsListTable(obj[cust])
            .then((onValue) {
          //  id = onValue;
        });

        print("Customer PPI Update Complete");
        await AppDatabase.get()
            .updateCustomerBusinessExpenseDetailsListTable(obj[cust])
            .then((onValue) {
          //  id = onValue;
        });
        print("Customer Business Expense Update Complete");
        await AppDatabase.get()
            .updateCustomerHouseholdExpenseDetailsListTable(obj[cust])
            .then((onValue) {
          //  id = onValue;
        });
        print("Customer Household Expense Update Complete");
        await AppDatabase.get()
            .updateCustomerAssetDetailsListTable(obj[cust])
            .then((onValue) {
          //  id = onValue;
        });
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

        //Update CPV here
        if (obj[cust].contactPointVerificationBean != null) {
          await AppDatabase.get()
              .updateCustomerCpvTable(
              obj[cust])
              .then((onValue) {
            // id = onValue;
          });
        }
        print("Customer business details Update Complete");
        List<ImageBean> imgBean = obj[cust].imageMaster;
        
        if (imgBean!=null) {
          for (int img = 0; img < imgBean.length; img++) {
            if ( imgBean[img].tImgrefno != null && imgBean[img].imgString!=null&&!(imgBean[img].tImgrefno > 10)) {
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




    }

    } catch (e) {
  print('Server Exception!!!');
  print(e);
  }

  }

  String _toJsonOfCenterId(int  mcenterId) {
    var mapData = new Map();
    mapData[TablesColumnFile.mCenterId] = mcenterId;
    String json = JSON.encode(mapData);
    print(json);
    return json;
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

}
