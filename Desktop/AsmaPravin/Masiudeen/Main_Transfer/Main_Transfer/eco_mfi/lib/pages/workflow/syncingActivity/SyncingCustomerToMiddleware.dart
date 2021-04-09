import 'dart:convert';
import 'dart:io';

import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ContactPointVerificationBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerFingerPrintBean.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/PPIBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/CheckExistingCustomerFromMiddleware.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyncingCustomertoMiddleware {
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};
  List<FamilyDetailsBean> customerFamilyDetailsList = List();
  List<BorrowingDetailsBean> customerBorrowingDetailsList = List();
  List<AddressDetailsBean> customerAddressDetailsList = List();
  CustomerBusinessDetailsBean customerBusinessDetailsBean =
  new CustomerBusinessDetailsBean();
  ContactPointVerificationBean contactPointVerification =
  new ContactPointVerificationBean();
  List<BusinessExpenditureDetailsBean> businessExpendDetailsList = List();
  List<HouseholdExpenditureDetailsBean> householdExpendDetailsList = List();
  List<AssetDetailsBean> assetDetailsList = List();
  List<PPIMasterBean> pPIMasterBeanList = List();
  CustomerCheckBean custCheckObj = new CustomerCheckBean();

  List<ImageBean> imageList = List();
  List listCust = List();
  bool isForSingleCustomer = false;
  int mrefnoGeneratedForSingleCustomer =0;
  List<CustomerFingerPrintBean> customerFingerPrintBeanList = List();
  DateTime lastSyncedToServerDaeTime=null;

  Future<Null> syncedDataToMiddleware(String json) async {
  try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      print("returned data is $bodyValue");
      if (bodyValue == "404" ) {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerListBean> obj = parsed
            .map<CustomerListBean>(
                (json) => CustomerListBean.fromMapMiddleware(json, true))
            .toList();

        for (int cust = 0; cust < obj.length; cust++) {

          print("xxxxxxx  returned Cust no is ${obj[cust].mcustno}");



        if(isForSingleCustomer){
          custCheckObj= new CustomerCheckBean();
          mrefnoGeneratedForSingleCustomer = obj[cust].mrefno;
          custCheckObj.mrefno = obj[cust].mrefno;
          custCheckObj.trefno = obj[cust].trefno;
          custCheckObj.mcustno =obj[cust].mcustno;
          custCheckObj.merrormessage = obj[cust].merrormessage;

          String returnedJson = obj.toString();
          List<String> customerretList = returnedJson.split(",");
          for(var item in customerretList )print("retJson from singlecust $item");

        }
        print("print que : " +
            obj[cust].mrefno.toString() +
            " : " +
            obj[cust].trefno.toString());
        await AppDatabase.get()
            .selectCustomerOnTrefANDMrefno(obj[cust].trefno, obj[cust].mcreatedby,obj[cust].mrefno)
            .then((CustomerListBean customerData) async {
          String updateCustQuery = "";
          String updateFamQuery = "";
          String updateBorroQuery = "";
          String updateAddrQuery = "";
          String updateBusinessQuery = "";
          String updateImageQuery = "";
          String updateAssetQuery = "";
            String updateContactPointVerificationQuery = "";

            bool isSyncingFirstTime = false;

            print("isSyncingFirstTime");
            print(isSyncingFirstTime);
            try{
            if (!isForSingleCustomer) {
              if (obj[cust]!=null && obj[cust].mrefno != null && customerData.mrefno==null || customerData.mrefno == 0) {
                isSyncingFirstTime = true;
                updateCustQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mmobilelastsynsdate} = '${DateTime.now()}' "
                    ",${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' ,${TablesColumnFile.missynctocoresys}  = 1 "
                    ", ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE "
                    "${TablesColumnFile.trefno} = ${obj[cust].trefno} AND  ${TablesColumnFile.mrefno} = 0 ":
                "${TablesColumnFile.mmobilelastsynsdate} = '${DateTime.now()}' ,${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now().subtract(Duration(minutes: 1))}' , ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno},${TablesColumnFile.missynctocoresys}  = 1  WHERE ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno} and ${TablesColumnFile.mrefno} = 0 "
                ;
              } else {
                updateCustQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mmobilelastsynsdate} = '${DateTime.now()}' ,"
                    "${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' ,${TablesColumnFile.missynctocoresys}  = 1"
                    "WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}":

                "${TablesColumnFile.mmobilelastsynsdate} = '${DateTime.now()}' ,${TablesColumnFile.mlastupdatedt} = '${DateTime
                    .now()}' ,${TablesColumnFile.missynctocoresys}  = 1 WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}";
              }
            }else{
              if (obj[cust]!=null && obj[cust].mrefno != null && customerData.mrefno==null || customerData.mrefno == 0) {
                isSyncingFirstTime = true;

                updateCustQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mcustno} = ${obj[cust].mcustno},${TablesColumnFile.mmobilelastsynsdate} = '${DateTime.now()}' "
                    ",${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' , ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno}, ${TablesColumnFile.merrormessage} = '${obj[cust].merrormessage}' , ${TablesColumnFile.mcuststatus} = ${obj[cust].mcuststatus},${TablesColumnFile.missynctocoresys}  = 1  "
                    " WHERE ${TablesColumnFile.trefno} = ${obj[cust].trefno}"
                    " AND ${TablesColumnFile.mrefno} = 0":
                "${TablesColumnFile.mcustno} = ${obj[cust].mcustno},${TablesColumnFile.mmobilelastsynsdate} = '${DateTime.now()}' ,${TablesColumnFile.mlastupdatedt} = '${DateTime.now().subtract(Duration(minutes: 1))}' , ${TablesColumnFile.mrefno} = ${obj[cust]
                .mrefno}, ${TablesColumnFile.merrormessage} = '${obj[cust].merrormessage}' , ${TablesColumnFile.mcuststatus} =  ${obj[cust].mcuststatus},${TablesColumnFile.missynctocoresys}  = 1   WHERE ${TablesColumnFile.trefno} = ${obj[cust].trefno}"
            " AND ${TablesColumnFile.mrefno} = 0";
              } else {
                updateCustQuery =lastSyncedToServerDaeTime!=null&&lastSyncedToServerDaeTime!='null'?
                "${TablesColumnFile.mcustno} = ${obj[cust].mcustno}, ${TablesColumnFile.mmobilelastsynsdate} = '${DateTime.now()}' "
                    ",${TablesColumnFile.mlastupdatedt} = '${lastSyncedToServerDaeTime.subtract(Duration(minutes: 1))}' "
                    " , ${TablesColumnFile.merrormessage} = '${obj[cust].merrormessage}' , ${TablesColumnFile.mcuststatus} = ${obj[cust].mcuststatus} ,${TablesColumnFile.missynctocoresys}  = 1 "
                    " WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}":
                "${TablesColumnFile.mcustno} = ${obj[cust].mcustno}, ${TablesColumnFile.mmobilelastsynsdate} = '${DateTime.now()}' "
                    ",${TablesColumnFile.mlastupdatedt} = '${DateTime.now().subtract(Duration(minutes: 1))}' , ${TablesColumnFile.mcuststatus} = ${obj[cust].mcuststatus},${TablesColumnFile.missynctocoresys}  = 1 WHERE ${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust]
                    .trefno}"
                ;
              }
            }

            //TODO check if here it is getting update
            if (updateCustQuery != null) {
              print(updateCustQuery);
              await AppDatabase.get().updateCustomerMaster(updateCustQuery);
            }

          }catch(_){}
            try{
            //updating loans details here with new generated mrefno
            if (isSyncingFirstTime) {
              String updateQueryLoan="${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' , "
                  "${TablesColumnFile.mcustno} = ${obj[cust].mcustno==null?0:obj[cust].mcustno} ,"
                  "${TablesColumnFile.mcustmrefno} = ${obj[cust].mrefno} WHERE "
                  " ${TablesColumnFile.mcusttrefno} = ${obj[cust].trefno} AND "
                  " ${TablesColumnFile.mcreatedby} = '${obj[cust].mcreatedby}' "
                  " AND  ${TablesColumnFile.mcustmrefno} = 0 "
                  ;
              await AppDatabase.get().updateCustomerLoanMaster(updateQueryLoan);
            }
          }catch(_){}
            try{
          if (isSyncingFirstTime) {
            String updateQuerySavings="${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' , ${TablesColumnFile.mcustmrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile.mcusttrefno} = ${obj[cust].trefno} "
                " AND ${TablesColumnFile.mcreatedby} = '${obj[cust].mcreatedby}' AND  ${TablesColumnFile.mcustmrefno} = 0 ";
            await AppDatabase.get().updateSavingsAccountMaster(updateQuerySavings);
          }
            for (int famList = 0;
            famList < obj[cust].familyDetailsList.length;
            famList++) {
              if (isSyncingFirstTime) {
                updateFamQuery =
                "${TablesColumnFile.mfamilyrefno} = ${obj[cust].familyDetailsList[famList].mfamilyrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cust].familyDetailsList[famList].trefno} AND ${TablesColumnFile.mrefno} = 0 ";
              } else {
                updateFamQuery =
                "${TablesColumnFile.mfamilyrefno} = ${obj[cust].familyDetailsList[famList].mfamilyrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].familyDetailsList[famList].trefno}";
              }


              if (updateCustQuery != null) {
                await AppDatabase.get().updateFamily(updateFamQuery);
              }
            }
          }catch(_){}
            try{
            for (int addrList = 0;
            addrList < obj[cust].addressDetails.length;
            addrList++) {
              if (isSyncingFirstTime) {
                updateAddrQuery =
                "${TablesColumnFile.maddressrefno} = ${obj[cust].addressDetails[addrList].maddressrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cust].addressDetails[addrList].trefno} AND ${TablesColumnFile.mrefno} = 0 ";
              } else {
                updateAddrQuery =
                "${TablesColumnFile.maddressrefno} = ${obj[cust].addressDetails[addrList].maddressrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].addressDetails[addrList].trefno}";
              }

              if (updateAddrQuery != null) {
                await AppDatabase.get().updateAddress(updateAddrQuery);
              }
            }
          }catch(_){}

            try{
            for (int borroList = 0;
            borroList < obj[cust].borrowingDetailsBean.length;
            borroList++) {
              if (isSyncingFirstTime) {
                updateBorroQuery =
                "${TablesColumnFile.mborrowingrefno} = ${obj[cust].borrowingDetailsBean[borroList].mborrowingrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cust].borrowingDetailsBean[borroList].trefno} AND ${TablesColumnFile.mrefno} = 0 ";
              } else {
                updateBorroQuery =
                "${TablesColumnFile.mborrowingrefno} = ${obj[cust].borrowingDetailsBean[borroList].mborrowingrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].borrowingDetailsBean[borroList].trefno}";
              }

              if (updateBorroQuery != null) {
                await AppDatabase.get().updateBorrowing(updateBorroQuery);
              }
            }
          }catch(_){}

            try{
            // BussExp detail
            String updateBussExp = "";
            for (int bussExp = 0;
            bussExp < obj[cust].businessExpendDetailsList.length;
            bussExp++) {
              if (isSyncingFirstTime) {
                updateBussExp =
                "${TablesColumnFile.mbusinexpenrefno} = ${obj[cust]
                    .businessExpendDetailsList[bussExp]
                    .mbusinexpenrefno},${TablesColumnFile.mrefno} = ${obj[cust]
                    .mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cust]
                    .businessExpendDetailsList[bussExp].trefno}  AND ${TablesColumnFile.mrefno} = 0 ";
              } else {
                updateBussExp =
                "${TablesColumnFile.mbusinexpenrefno} = ${obj[cust]
                    .businessExpendDetailsList[bussExp]
                    .mbusinexpenrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust].businessExpendDetailsList[bussExp]
                    .trefno}";
              }


              if (updateBussExp != null) {
                await AppDatabase.get().updateBussExpDetails(updateBussExp);
              }
            }
          }catch(_){}
             try{
            // HHExp detail
            String updatehouseExp = "";
            for (int houseHoldExp = 0;
            houseHoldExp < obj[cust].householdExpendDetailsList.length;
            houseHoldExp++) {
              if (isSyncingFirstTime) {
                updatehouseExp =
                "${TablesColumnFile.mhoushldexpenrefno} = ${obj[cust]
                    .householdExpendDetailsList[houseHoldExp]
                    .mhoushldexpenrefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE  ${TablesColumnFile
                    .trefno} = ${obj[cust]
                    .householdExpendDetailsList[houseHoldExp].trefno} AND ${TablesColumnFile.mrefno} = 0 ";
              } else {
                updatehouseExp =
                "${TablesColumnFile.mhoushldexpenrefno} = ${obj[cust]
                    .householdExpendDetailsList[houseHoldExp]
                    .mhoushldexpenrefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust]
                    .householdExpendDetailsList[houseHoldExp].trefno} ";
              }


              if (updatehouseExp != null) {
                await AppDatabase.get().updateHouseHoldExpDetails(
                    updatehouseExp);
              }
            }

          }catch(_){}
          try{
            //asset detail
            for (int assetList = 0;
            assetList < obj[cust].assetDetailsList.length;
            assetList++) {
              if (isSyncingFirstTime) {
                updateAssetQuery =
                "${TablesColumnFile.massetdetrefno} = ${obj[cust].assetDetailsList[assetList].massetdetrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE  ${TablesColumnFile.trefno} = ${obj[cust].assetDetailsList[assetList].trefno} AND ${TablesColumnFile.mrefno} = 0";
              } else {
                updateAssetQuery =
                "${TablesColumnFile.massetdetrefno} = ${obj[cust].assetDetailsList[assetList].massetdetrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].assetDetailsList[assetList].trefno}";
              }


              if (updateAssetQuery != null) {
                await AppDatabase.get().updateAssetDetails(updateAssetQuery);
              }
            }
          }catch(_){}
            //ppi details

            try{
            // ppiQuery detail
            String ppiQuery;
            for (int ppi = 0;
            ppi < obj[cust].pPIMasterBean.length;
            ppi++) {
              if (isSyncingFirstTime) {
                ppiQuery =
                "${TablesColumnFile.mPpirefno} = ${obj[cust]
                    .pPIMasterBean[ppi]
                    .mPpirefno},${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} WHERE  ${TablesColumnFile
                    .trefno} = ${obj[cust]
                    .pPIMasterBean[ppi].trefno} AND ${TablesColumnFile.mrefno} = 0";
              } else {
                ppiQuery =
                "${TablesColumnFile.mPpirefno} = ${obj[cust]
                    .pPIMasterBean[ppi]
                    .mPpirefno}  WHERE ${TablesColumnFile
                    .mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile
                    .trefno} = ${obj[cust]
                    .pPIMasterBean[ppi].trefno}";
              }
            }
            if (ppiQuery != null) {
              await AppDatabase.get().updatePpiDetails(
                  ppiQuery);
            }
          }catch(_){}


          try{
            if (isSyncingFirstTime) {
              updateBusinessQuery =
              "${TablesColumnFile.mbussdetailsrefno} = ${obj[cust].customerBusinessDetailsBean.mbussdetailsrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cust].customerBusinessDetailsBean.trefno} AND ${TablesColumnFile.mrefno} = 0 ";
            } else {
              updateBusinessQuery =
              "${TablesColumnFile.mbussdetailsrefno} = ${obj[cust].customerBusinessDetailsBean.mbussdetailsrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].customerBusinessDetailsBean.trefno}";
            }

            if (updateBusinessQuery != null) {
              await AppDatabase.get().updateBussinessDetail(updateBusinessQuery);
            }
          }catch(_){}
            try {
           // print("____________ &{contactPointVerificationBean}"+obj[cust].contactPointVerificationBean.toString());
            if (isSyncingFirstTime) {
              updateContactPointVerificationQuery =
              "${TablesColumnFile.mcpvrefno} = ${obj[cust].contactPointVerificationBean.mcpvrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[cust].contactPointVerificationBean.trefno} AND ${TablesColumnFile.mrefno} = 0 ";
            } else {
              updateContactPointVerificationQuery =
              "${TablesColumnFile.mcpvrefno} = ${obj[cust].contactPointVerificationBean.mcpvrefno}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].contactPointVerificationBean.trefno}";
            }
            if (updateContactPointVerificationQuery != null) {
              await AppDatabase.get().updateCpvDetail(updateContactPointVerificationQuery);
            }
            }catch(_){}
            //}

            try{
            //update image
            for (int imageList = 0;
            imageList < obj[cust].imageMaster.length;
            imageList++) {
              if (isSyncingFirstTime) {
                updateImageQuery =
                "${TablesColumnFile.mImgrefno} = ${obj[cust].imageMaster[imageList].mImgrefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} , ${TablesColumnFile.mcustno}  = ${obj[cust].mcustno??0}  WHERE ${TablesColumnFile.trefno} = ${obj[cust].imageMaster[imageList].trefno} AND ${TablesColumnFile.mrefno} = 0"
                    " AND  ${TablesColumnFile.tImgrefno} = ${obj[cust].imageMaster[imageList].tImgrefno} ";
              } else {
                updateImageQuery =
                "${TablesColumnFile.mImgrefno} = ${obj[cust].imageMaster[imageList].mImgrefno} , ${TablesColumnFile.mcustno}  = ${obj[cust].mcustno??0} WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].imageMaster[imageList].trefno}"
                    " AND  ${TablesColumnFile.tImgrefno} = ${obj[cust].imageMaster[imageList].tImgrefno} ";
              }


              if (updateImageQuery != null) {
                await AppDatabase.get().updateImage(updateImageQuery);
              }
            }
            }catch(_){}

          try{
            //update image
            for (int imageList = 0;
            imageList < obj[cust].customerfingerprintlist.length;
            imageList++) {
              if (isSyncingFirstTime) {
                updateImageQuery =
                "${TablesColumnFile.mimagerefno} = ${obj[cust].customerfingerprintlist[imageList].mimagerefno},${TablesColumnFile.mrefno} = ${obj[cust].mrefno} , ${TablesColumnFile.mcustno}  = ${obj[cust].mcustno??0}  WHERE ${TablesColumnFile.trefno} = ${obj[cust].customerfingerprintlist[imageList].trefno} AND (  ${TablesColumnFile.mrefno} = 0 OR ${TablesColumnFile.mrefno}  IS NULL )"
                    " AND ${TablesColumnFile.timagerefno} = ${obj[cust].customerfingerprintlist[imageList].timagerefno} ";
              } else {
                updateImageQuery =
                "${TablesColumnFile.mimagerefno} = ${obj[cust].customerfingerprintlist[imageList].mimagerefno} , ${TablesColumnFile.mcustno}  = ${obj[cust].mcustno??0}  WHERE ${TablesColumnFile.mrefno} = ${obj[cust].mrefno} AND ${TablesColumnFile.trefno} = ${obj[cust].customerfingerprintlist[imageList].trefno}"
                    " AND ${TablesColumnFile.timagerefno} = ${obj[cust].customerfingerprintlist[imageList].timagerefno} ";
              }


              if (updateImageQuery != null) {
                await AppDatabaseExtended.get().updateFingerPrintMaster(updateImageQuery);
              }
            }
          }catch(_){}


          });
        }
        //updating lastsynced date time with now
        if(!isForSingleCustomer) {
          AppDatabase.get().updateStaticTablesLastSyncedMaster(1);
        }
      }
 } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  Future<Null> customerNormalData() async {
    List customerList = new List();
    /*await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(1,false)
        .then((onValue) async {*/
      await AppDatabase.get()
          .selectCustomerListIsDataSyncedZero(0)
          .then((List<CustomerListBean> customerData) async {
        print("lengtrh cust " + customerData.length.toString());
        for (int i = 0; i < customerData.length; i++) {
          await AppDatabase.get()
              .selectCustomerFamilyDetailsListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<FamilyDetailsBean> familyDetailsBean) async {
            customerFamilyDetailsList = familyDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerBorrowingDetailsListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<BorrowingDetailsBean> borrowingDetailsBean) async {
            customerBorrowingDetailsList = borrowingDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerAddressDetailsListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<AddressDetailsBean> addressDetails) async {
            customerAddressDetailsList = addressDetails;
          });

          await AppDatabase.get()
              .selectImagesListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<ImageBean> imageBean) async {
            imageList = imageBean;
          });

          await AppDatabase.get()
              .selectCustomerBussinessDetails(
              customerData[i].trefno, customerData[i].mrefno)
              .then((CustomerBusinessDetailsBean
          customerBussBean) async {
            customerBusinessDetailsBean = customerBussBean;
          });

          await AppDatabase.get()
              .selectCustomerCpvDetails( customerData[i].trefno,  customerData[i].mrefno)
              .then(
                  (ContactPointVerificationBean contactPointVerificationBean) async {
                contactPointVerification = contactPointVerificationBean;
                /* print(
            "customerBusinessDetailsBean list is ${bean.customerBusinessDetailsBean}");*/
              });
          await AppDatabase.get()
              .selectCustomerBusinessExpenseListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<BusinessExpenditureDetailsBean> businessExpenditureDetailsBean) async {
            businessExpendDetailsList = businessExpenditureDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerHouseholdExpenseListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<HouseholdExpenditureDetailsBean> householdExpenditureDetailsBean) async {
            householdExpendDetailsList = householdExpenditureDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerAssetDetailListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<AssetDetailsBean> assetDetailsBean) async {
            assetDetailsList = assetDetailsBean;
          });

  await AppDatabase.get()
              .selectCustomerPPIListIsDataSynced(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<PPIMasterBean> pPIMasterBean) async {
            pPIMasterBeanList = pPIMasterBean;
          });


          await AppDatabaseExtended.get()
              .selectFingerPrintList(
              customerData[i].trefno, customerData[i].mrefno)
              .then((List<CustomerFingerPrintBean> FingerPrintBean) async {
            customerFingerPrintBeanList = FingerPrintBean;
          });
	  
          await _toCustomerJson(customerData[i]).then((onValue) {});
        }
      });
      _serviceUrl = "customerData/addCustomerByHolder";
      String json = JSON.encode(listCust);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncedDataToMiddleware(json);
      //after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
   // });
  }

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
      rotate: 0,
    );

    /*print(file.lengthSync());
    print(result.lengthSync());*/

    return result;
  }

  Future<Null> _toCustomerJson(CustomerListBean customerListBean) async {
    var mapData = new Map();
    mapData[TablesColumnFile.trefno] =
    customerListBean.trefno != null ? customerListBean.trefno : 0;
    mapData[TablesColumnFile.mrefno] =
    customerListBean.mrefno != null ? customerListBean.mrefno : 0;
    mapData[TablesColumnFile.mcustno] =
    customerListBean.mcustno != null ? customerListBean.mcustno : 0;
    mapData[TablesColumnFile.mlbrcode] =
    customerListBean.mlbrcode != null ? customerListBean.mlbrcode : 0;
    //mIsMbrGrp
    mapData[TablesColumnFile.mcenterid] =
    customerListBean.mcenterid != null ? customerListBean.mcenterid : 0;
    mapData[TablesColumnFile.mgroupcd] =
    customerListBean.mgroupcd != null ? customerListBean.mgroupcd : 0;
    mapData[TablesColumnFile.mnametitle] =
        ifNullCheck(customerListBean.mnametitle);
    mapData[TablesColumnFile.mlongname] =
        ifNullCheck(customerListBean.mlongname);
    mapData[TablesColumnFile.mfathertitle] =
        ifNullCheck(customerListBean.mfathertitle);
    mapData[TablesColumnFile.mfathername] =
        ifNullCheck(customerListBean.mfathername);
    mapData[TablesColumnFile.mspousetitle] =
        ifNullCheck(customerListBean.mspousetitle);
    mapData[TablesColumnFile.mhusbandname] =
        ifNullCheck(customerListBean.mhusbandname);
    mapData[TablesColumnFile.mdob] = customerListBean.mdob != null
        ? customerListBean.mdob.toIso8601String()
        : null;
    mapData[TablesColumnFile.mage] =
    customerListBean.mage != null ? customerListBean.mage : 0;
    mapData[TablesColumnFile.mbankacno] = customerListBean.mbankacno.toString();
    /*mapData[TablesColumnFile.mbankacyn] =
    customerListBean.mbankacyn != null ? customerListBean.mbankacyn : 0;*/
    mapData[TablesColumnFile.mbankacyn] =
        ifNullCheck(customerListBean.mbankacyn);
    mapData[TablesColumnFile.mbankifsc] =
        ifNullCheck(customerListBean.mbankifsc);
    mapData[TablesColumnFile.mbanknamelk] =
        ifNullCheck(customerListBean.mbanknamelk);
    mapData[TablesColumnFile.mbankbranch] =
        ifNullCheck(customerListBean.mbankbranch);
    mapData[TablesColumnFile.mcuststatus] =
    customerListBean.mcuststatus != null ? customerListBean.mcuststatus : 0;
    mapData[TablesColumnFile.mdropoutdate] =
    customerListBean.mdropoutdate != null
        ? customerListBean.mdropoutdate.toIso8601String()
        : null;
    mapData[TablesColumnFile.mmobno] = ifNullCheck(customerListBean.mmobno);
    mapData[TablesColumnFile.mpanno] =
    customerListBean.mpanno != null ? customerListBean.mpanno : 0;
    mapData[TablesColumnFile.mpannodesc] =
        ifNullCheck(customerListBean.mpannodesc);
    mapData[TablesColumnFile.mtdsyn] = ifNullCheck(customerListBean.mtdsyn);
    mapData[TablesColumnFile.mtdsreasoncd] =
    customerListBean.mtdsreasoncd != null
        ? customerListBean.mtdsreasoncd
        : 0;
    mapData[TablesColumnFile.mtdsfrm15subdt] =
    customerListBean.mtdsfrm15subdt != null
        ? customerListBean.mtdsfrm15subdt.toIso8601String()
        : null;
    mapData[TablesColumnFile.memailId] = ifNullCheck(customerListBean.memailId);
    mapData[TablesColumnFile.mcustcategory] =
    customerListBean.mcustcategory != null
        ? customerListBean.mcustcategory
        : 0;
    mapData[TablesColumnFile.mtier] =
    customerListBean.mtier != null ? customerListBean.mtier : 0;
    mapData[TablesColumnFile.mAdd1] = ifNullCheck(customerListBean.mAdd1);
    mapData[TablesColumnFile.mAdd2] = ifNullCheck(customerListBean.mAdd2);
    mapData[TablesColumnFile.mAdd3] = ifNullCheck(customerListBean.mAdd3);
    mapData[TablesColumnFile.marea] =
    customerListBean.mArea != null ? customerListBean.mArea : 0;
    mapData[TablesColumnFile.mPinCode] = ifNullCheck(customerListBean.mPinCode);
    mapData[TablesColumnFile.mCounCd] = ifNullCheck(customerListBean.mCounCd);
    mapData[TablesColumnFile.mCityCd] = ifNullCheck(customerListBean.mCityCd);
    mapData[TablesColumnFile.mfname] = ifNullCheck(customerListBean.mfname);
    mapData[TablesColumnFile.mmname] = ifNullCheck(customerListBean.mmname);
    mapData[TablesColumnFile.mlname] = ifNullCheck(customerListBean.mlname);
    print("Gender");
    print(customerListBean.mgender);
    mapData[TablesColumnFile.mgender] =  ifNullCheck(customerListBean.mgender);
    mapData[TablesColumnFile.mrelegion] =
        ifNullCheck(customerListBean.mrelegion);
    /*mapData[TablesColumnFile.mrelegion] =
    customerListBean.mrelegion != null || customerListBean.mrelegion != "null" ? customerListBean.mrelegion : "0";*/
    mapData[TablesColumnFile.mRuralUrban] =
    customerListBean.mRuralUrban != null ? customerListBean.mRuralUrban : 0;
    mapData[TablesColumnFile.mcaste] = ifNullCheck(customerListBean.mcaste);
    mapData[TablesColumnFile.mqualification] =
        ifNullCheck(customerListBean.mqualification);
    mapData[TablesColumnFile.moccupation] =
    customerListBean.moccupation != null ? customerListBean.moccupation : 0;
    mapData[TablesColumnFile.mLandType] =
        ifNullCheck(customerListBean.mLandType);
    mapData[TablesColumnFile.mLandMeasurement] =
        ifNullCheck(customerListBean.mLandMeasurement);
    mapData[TablesColumnFile.mmaritialStatus] =
    customerListBean.mmaritialStatus != null
        ? customerListBean.mmaritialStatus
        : 0;
    mapData[TablesColumnFile.mTypeOfId] =
    customerListBean.mTypeOfId != null ? customerListBean.mTypeOfId : 0;
    mapData[TablesColumnFile.mIdDesc] = ifNullCheck(customerListBean.mIdDesc);
    /* mapData[TablesColumnFile.mInsuranceCovYN] =
    customerListBean.mInsuranceCovYN != null || customerListBean.mInsuranceCovYN != "null" ? customerListBean.mInsuranceCovYN : "0";*/
    mapData[TablesColumnFile.mInsuranceCovYN] =
        ifNullCheck(customerListBean.mInsuranceCovYN);
    mapData[TablesColumnFile.mTypeofCoverage] =
    customerListBean.mTypeofCoverage != null
        ? customerListBean.mTypeofCoverage
        : 0;
    mapData[TablesColumnFile.mcreateddt] = customerListBean.mcreateddt != null
        ? customerListBean.mcreateddt.toIso8601String()
        : null;
    mapData[TablesColumnFile.mcreatedby] =
        ifNullCheck(customerListBean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =
    customerListBean.mlastupdatedt != null
        ? customerListBean.mlastupdatedt.toIso8601String()
        : null;
    mapData[TablesColumnFile.mlastupdateby] =
        ifNullCheck(customerListBean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =
        ifNullCheck(customerListBean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(customerListBean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(customerListBean.mgeologd);
    mapData[TablesColumnFile.misCbCheckDone] =
    customerListBean.misCbCheckDone != null
        ? customerListBean.misCbCheckDone
        : 0;
    mapData[TablesColumnFile.mcbcheckrprtdt ] = customerListBean.mcbcheckrprtdt  != null
        ? customerListBean.mcbcheckrprtdt .toIso8601String()
        : null;


    mapData[TablesColumnFile.merrormessage] =
        ifNullCheck(customerListBean.merrormessage);
    mapData[TablesColumnFile.missynctocoresys] =
    customerListBean.missynctocoresys != null
        ? (isForSingleCustomer==true&&(customerListBean.mcustno==0||
        customerListBean.mcustno==null)?9:customerListBean.missynctocoresys)
        : 0;
    mapData[TablesColumnFile.mlastsynsdate] =
    customerListBean.mlastsynsdate != null
        ? customerListBean.mlastsynsdate.toIso8601String()
        : null;
    mapData[TablesColumnFile.mmobilelastsynsdate] =
    customerListBean.mmobilelastsynsdate != null
        ? customerListBean.mmobilelastsynsdate.toIso8601String()
        : null;
    mapData[TablesColumnFile.mloanagreed] =
    customerListBean.mLoanAgreed != null
        ? customerListBean.mLoanAgreed
        : 0;
    print("Center Name");
    print(customerListBean.mcentername);
    print(ifNullCheck(customerListBean.mcentername.trim()));
    print(customerListBean.mgroupname);
    print(ifNullCheck(customerListBean.mgroupname.trim()));
    mapData[TablesColumnFile.mcentername] =
        ifNullCheck(customerListBean.mcentername.trim());

    mapData[TablesColumnFile.mgroupname] =
        ifNullCheck(customerListBean.mgroupname.trim());
    mapData[TablesColumnFile.mhusdob] = customerListBean.mhusdob != null
        ? customerListBean.mhusdob.toIso8601String()
        : null;
    mapData[TablesColumnFile.mprofileind] =
        ifNullCheck(customerListBean.mprofileind);
    mapData[TablesColumnFile.mlangofcust] =
        ifNullCheck(customerListBean.mlangofcust);
    mapData[TablesColumnFile.mmainoccupn] =
        ifNullCheck(customerListBean.mmainoccupn);
    mapData[TablesColumnFile.msuboccupn] =
        ifNullCheck(customerListBean.msuboccupn);
    mapData[TablesColumnFile.msecoccupatn] =
    customerListBean.msecoccupatn != null
        ? customerListBean.msecoccupatn
        : 0;

    mapData[TablesColumnFile.mcuststatus] =
    customerListBean.mcuststatus != null ? customerListBean.mcuststatus : 0;

    mapData[TablesColumnFile.mcusttype] =
        ifNullCheck(customerListBean.mcusttype);


    mapData[TablesColumnFile.mid1issuedate] =
        ifDateNullCheck(customerListBean.mid1issuedate);

    mapData[TablesColumnFile.mid1expdate] =
        ifDateNullCheck(customerListBean.mid1expdate);

    mapData[TablesColumnFile.mid2issuedate] =
        ifDateNullCheck(customerListBean.mid2issuedate);

    mapData[TablesColumnFile.mid2expdate] =
        ifDateNullCheck(customerListBean.mid2expdate);


    mapData[TablesColumnFile.mrefcenterid] =0;
    mapData[TablesColumnFile.trefcenterid] = 0 ;
    mapData[TablesColumnFile.mrefgroupid] = 0 ;
    mapData[TablesColumnFile.trefgroupid] = 0 ;


    mapData[TablesColumnFile.mdropoutreason] = ifNullCheck(customerListBean.mdropoutreason);
    mapData[TablesColumnFile.mutils] = customerListBean.mutils==null?0:customerListBean.mutils;

    mapData[TablesColumnFile.meducation] = ifNullCheck(customerListBean.meducation);
    mapData[TablesColumnFile.mmemberno] = customerListBean.mmemberno==null?0:customerListBean.mmemberno;
    mapData[TablesColumnFile.designation] = ifNullCheck(customerListBean.designation);
    mapData[TablesColumnFile.orgName] = ifNullCheck(customerListBean.orgName);
    mapData[TablesColumnFile.yearsInOrg] = ifNullCheck(customerListBean.yearsInOrg);
    mapData[TablesColumnFile.mismodify] = customerListBean.mismodify==null?0:customerListBean.mismodify;
    mapData[TablesColumnFile.missyncfromcoresys] = 1;
    var mapDataFamily;
    var famiDetList = List();
    for (int famDetList = 0;
    famDetList < customerFamilyDetailsList.length;
    famDetList++) {
      mapDataFamily = new Map();
      mapDataFamily[TablesColumnFile.tfamilyrefno] =
      customerFamilyDetailsList[famDetList].tfamilyrefno != null
          ? customerFamilyDetailsList[famDetList].tfamilyrefno
          : 0;
      mapDataFamily[TablesColumnFile.trefno] =
      customerFamilyDetailsList[famDetList].trefno != null
          ? customerFamilyDetailsList[famDetList].trefno
          : 0;
      // mapDataFamily[TablesColumnFile.mfamilyrefno] =	        customerFamilyDetailsList[famDetList].mfamilyrefno!=null?customerFamilyDetailsList[famDetList].mfamilyrefno:0;
      mapDataFamily[TablesColumnFile.mrefno] =
      customerFamilyDetailsList[famDetList].mrefno != null
          ? customerFamilyDetailsList[famDetList].mrefno
          : 0;
      mapDataFamily[TablesColumnFile.mcustno] =
      customerFamilyDetailsList[famDetList].mcustno != null
          ? customerFamilyDetailsList[famDetList].mcustno
          : 0;
      mapDataFamily[TablesColumnFile.mname] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mname);
      mapDataFamily[TablesColumnFile.mnicno] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mnicno);
      mapDataFamily[TablesColumnFile.mdob] =
      customerFamilyDetailsList[famDetList].mdob != null
          ? customerFamilyDetailsList[famDetList].mdob.toIso8601String()
          : null;
      mapDataFamily[TablesColumnFile.mage] =
      customerFamilyDetailsList[famDetList].mage != null
          ? customerFamilyDetailsList[famDetList].mage
          : 0;
      mapDataFamily[TablesColumnFile.meducation] =
          ifNullCheck(customerFamilyDetailsList[famDetList].meducation);
      mapDataFamily[TablesColumnFile.mmemberno] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mmemberno);
      mapDataFamily[TablesColumnFile.moccuptype] =
      customerFamilyDetailsList[famDetList].moccuptype != null
          ? customerFamilyDetailsList[famDetList].moccuptype
          : 0;
      mapDataFamily[TablesColumnFile.mincome] =
      customerFamilyDetailsList[famDetList].mincome != null
          ? customerFamilyDetailsList[famDetList].mincome
          : 0;
      mapDataFamily[TablesColumnFile.mhealthstatus] =
      customerFamilyDetailsList[famDetList].mhealthstatus != null
          ? customerFamilyDetailsList[famDetList].mhealthstatus
          : 0;
      mapDataFamily[TablesColumnFile.mrelationwithcust] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mrelationwithcust);
      mapDataFamily[TablesColumnFile.maritalstatus] =
      customerFamilyDetailsList[famDetList].maritalstatus != null
          ? customerFamilyDetailsList[famDetList].maritalstatus
          : 0;
      mapDataFamily[TablesColumnFile.mcontrforhouseexp] =
      customerFamilyDetailsList[famDetList].mcontrforhouseexp != null
          ? customerFamilyDetailsList[famDetList].mcontrforhouseexp
          : 0;
      mapDataFamily[TablesColumnFile.macidntlinsurance] =
          ifNullCheck(customerFamilyDetailsList[famDetList].macidntlinsurance);
      mapDataFamily[TablesColumnFile.mnomineeyn] =
          ifNullCheck(customerFamilyDetailsList[famDetList].mnomineeyn);
      famiDetList.add(mapDataFamily);
    }

    var mapDataAdd;
    var addDetailsList = new List();
    for (int addDetList = 0;
    addDetList < customerAddressDetailsList.length;
    addDetList++) {
      mapDataAdd = new Map();
      mapDataAdd[TablesColumnFile.taddrefno] =
      customerAddressDetailsList[addDetList].taddrefno != null
          ? customerAddressDetailsList[addDetList].taddrefno
          : 0;
      mapDataAdd[TablesColumnFile.trefno] =
      customerAddressDetailsList[addDetList].trefno != null && customerAddressDetailsList[addDetList].trefno != 'null'
          ? customerAddressDetailsList[addDetList].trefno
          : 0;
      // mapDataAdd[TablesColumnFile.maddrefno] =	        customerAddressDetailsList[addDetList].maddrefno!=null&& customerAddressDetailsList[addDetList].maddrefno!='null'?customerAddressDetailsList[addDetList].maddrefno:0;
      mapDataAdd[TablesColumnFile.mrefno] =
      customerAddressDetailsList[addDetList].mrefno != null
          ? customerAddressDetailsList[addDetList].mrefno
          : 0;
      mapDataAdd[TablesColumnFile.mcustno] =
      customerAddressDetailsList[addDetList].mcustno != null
          ? customerAddressDetailsList[addDetList].mcustno
          : 0;
      mapDataAdd[TablesColumnFile.maddrType] =
      customerAddressDetailsList[addDetList].maddrType != null
          ? customerAddressDetailsList[addDetList].maddrType
          : 0;
      mapDataAdd[TablesColumnFile.maddr1] =
          ifNullCheck(customerAddressDetailsList[addDetList].maddr1);
      mapDataAdd[TablesColumnFile.maddr2] =
          ifNullCheck(customerAddressDetailsList[addDetList].maddr2);
      mapDataAdd[TablesColumnFile.maddr3] =
          ifNullCheck(customerAddressDetailsList[addDetList].maddr3);
      mapDataAdd[TablesColumnFile.mpinCd] =
      customerAddressDetailsList[addDetList].mpinCd != null
          ? customerAddressDetailsList[addDetList].mpinCd
          : 0;
      mapDataAdd[TablesColumnFile.mtel1] =
          ifNullCheck(customerAddressDetailsList[addDetList].mtel1);
      mapDataAdd[TablesColumnFile.mtel2] =
          ifNullCheck(customerAddressDetailsList[addDetList].mtel2);
      mapDataAdd[TablesColumnFile.mcityCd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mplacecd);
      mapDataAdd[TablesColumnFile.mfax1] =
          ifNullCheck(customerAddressDetailsList[addDetList].mfax1);
      mapDataAdd[TablesColumnFile.mfax2] =
          ifNullCheck(customerAddressDetailsList[addDetList].mfax2);
      mapDataAdd[TablesColumnFile.mcountryCd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mcountryCd);
      mapDataAdd[TablesColumnFile.marea] =
      customerAddressDetailsList[addDetList].marea != null
          ? customerAddressDetailsList[addDetList].marea
          : 0;
      /*mapDataAdd[TablesColumnFile.mHouseType] =
      customerAddressDetailsList[addDetList].mHouseType != null
          ? customerAddressDetailsList[addDetList].mHouseType
          : 0;*/
      print(customerListBean.mHouse);
      mapDataAdd[TablesColumnFile.mHouseType] =
      customerListBean.mHouse != "null"
          ? customerListBean.mHouse
          : 0;
      mapDataAdd[TablesColumnFile.mRntLeasAmt] =
      customerAddressDetailsList[addDetList].mRntLeasAmt != null
          ? customerAddressDetailsList[addDetList].mRntLeasAmt
          : 0;
      mapDataAdd[TablesColumnFile.mRntLeasDep] =
      customerAddressDetailsList[addDetList].mRntLeasDep != null
          ? customerAddressDetailsList[addDetList].mRntLeasDep
          : 0;
      mapDataAdd[TablesColumnFile.mContLeasExp] =
      customerAddressDetailsList[addDetList].mContLeasExp != null
          ? customerAddressDetailsList[addDetList]
          .mContLeasExp
          .toIso8601String()
          : null;
      /*mapDataAdd[TablesColumnFile.mRoofCond] =
      customerAddressDetailsList[addDetList].mRoofCond != null
          ? customerAddressDetailsList[addDetList].mRoofCond
          : 0;*/
//      print("no of room/post");
//      print(customerAddressDetailsList[addDetList].mNoOfRooms);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int isWasassa= prefs.getInt(TablesColumnFile.isWASASA);

      if(isWasassa==1){
        mapDataAdd[TablesColumnFile.mNoOfRooms] =
        customerListBean.mnoofrooms != null
            ? customerListBean.mnoofrooms
            : 0;
      }else{
        mapDataAdd[TablesColumnFile.mNoOfRooms] =
        customerAddressDetailsList[addDetList].mNoOfRooms != null
            ? customerAddressDetailsList[addDetList].mNoOfRooms
            : 0;
      }


      print(customerListBean.mConstruct);
      mapDataAdd[TablesColumnFile.mRoofCond] =
      customerListBean.mConstruct != null
          ? customerListBean.mConstruct
          : 0;
      mapDataAdd[TablesColumnFile.mUtils] =
      customerAddressDetailsList[addDetList].mUtils != null
          ? customerAddressDetailsList[addDetList].mUtils
          : 0;
      mapDataAdd[TablesColumnFile.mAreaType] =
      customerAddressDetailsList[addDetList].mAreaType != null
          ? customerAddressDetailsList[addDetList].mAreaType
          : 0;
      mapDataAdd[TablesColumnFile.mLandmark] =
          ifNullCheck(customerAddressDetailsList[addDetList].mLandmark);
      mapDataAdd[TablesColumnFile.mstate] =
          ifNullCheck(customerAddressDetailsList[addDetList].mState);
      mapDataAdd[TablesColumnFile.mYearStay] =
      customerAddressDetailsList[addDetList].mYearStay != null &&
          customerAddressDetailsList[addDetList].mYearStay != 'null'
          ? customerAddressDetailsList[addDetList].mYearStay
          : 0;
      mapDataAdd[TablesColumnFile.mWardNo] =
          ifNullCheck(customerAddressDetailsList[addDetList].mWardNo);
      mapDataAdd[TablesColumnFile.mMobile] =
          ifNullCheck(customerAddressDetailsList[addDetList].mMobile);
      mapDataAdd[TablesColumnFile.mEmail] =
          ifNullCheck(customerAddressDetailsList[addDetList].mEmail);
      mapDataAdd[TablesColumnFile.mPattaName] =
          ifNullCheck(customerAddressDetailsList[addDetList].mPattaName);
      mapDataAdd[TablesColumnFile.mRelationship] =
          ifNullCheck(customerAddressDetailsList[addDetList].mRelationship);
      mapDataAdd[TablesColumnFile.mSourceOfDep] =
      customerAddressDetailsList[addDetList].mSourceOfDep != null
          ? customerAddressDetailsList[addDetList].mSourceOfDep
          : 0;
      mapDataAdd[TablesColumnFile.mInstAmount] =
      customerAddressDetailsList[addDetList].mInstAmount != null
          ? customerAddressDetailsList[addDetList].mInstAmount
          : 0;
      /* print("ToiletYN");//mToilet
      mapDataAdd[TablesColumnFile.mToietYN] =
      customerAddressDetailsList[addDetList].mToietYN != "null"
          ? customerAddressDetailsList[addDetList].mToietYN
          : 0;
      print(customerAddressDetailsList[addDetList].mToietYN);*/

      print("ToiletYN");//mToilet
      print(customerListBean.mToilet);
      mapDataAdd[TablesColumnFile.mToietYN] =
      customerListBean.mToilet != "null"
          ? customerListBean.mToilet
          : 0;
      /* mapDataAdd[TablesColumnFile.mToietYN] =
          ifNullCheck(customerAddressDetailsList[addDetList].mToietYN);*/

      if(isWasassa==1){
        mapDataAdd[TablesColumnFile.mNoOfRooms] =
        customerListBean.mnoofrooms != null
            ? customerListBean.mnoofrooms
            : 0;
      }else{
        mapDataAdd[TablesColumnFile.mNoOfRooms] =
        customerAddressDetailsList[addDetList].mNoOfRooms != null
            ? customerAddressDetailsList[addDetList].mNoOfRooms
            : 0;
      }



      mapDataAdd[TablesColumnFile.mSpouseYearsStay] =
      customerAddressDetailsList[addDetList].mSpouseYearsStay != null
          ? customerAddressDetailsList[addDetList].mSpouseYearsStay
          : 0;
      mapDataAdd[TablesColumnFile.mDistCd] =
      customerAddressDetailsList[addDetList].mDistCd != null
          ? customerAddressDetailsList[addDetList].mDistCd
          : 0;
      mapDataAdd[TablesColumnFile.mvillage] =
      customerAddressDetailsList[addDetList].mvillage != null
          ? customerAddressDetailsList[addDetList].mvillage
          : 0;
      mapDataAdd[TablesColumnFile.mCookFuel] =
      customerAddressDetailsList[addDetList].mCookFuel != null
          ? customerAddressDetailsList[addDetList].mCookFuel
          : 0;
      mapDataAdd[TablesColumnFile.mSecMobile] =
          ifNullCheck(customerAddressDetailsList[addDetList].mSecMobile);
      mapDataAdd[TablesColumnFile.mgeolatd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mgeolatd);
      mapDataAdd[TablesColumnFile.mgeologd] =
          ifNullCheck(customerAddressDetailsList[addDetList].mgeologd);
      addDetailsList.add(mapDataAdd);
    }

    var mapDataBorr;
    var borrDetailsList = new List();
    for (int borrDetList = 0;
    borrDetList < customerBorrowingDetailsList.length;
    borrDetList++) {
      mapDataBorr = new Map();
      mapDataBorr[TablesColumnFile.tborrowingrefno] =
      customerBorrowingDetailsList[borrDetList].tborrowingrefno != null
          ? customerBorrowingDetailsList[borrDetList].tborrowingrefno
          : 0;
      mapDataBorr[TablesColumnFile.trefno] =
      customerBorrowingDetailsList[borrDetList].trefno != null
          ? customerBorrowingDetailsList[borrDetList].trefno
          : 0;
      //mapDataBorr[TablesColumnFile.mborrowingrefno] =	        customerBorrowingDetailsList[borrDetList].mborrowingrefno!=null&& customerBorrowingDetailsList[borrDetList].mborrowingrefno!='null'?customerBorrowingDetailsList[borrDetList].mborrowingrefno:0;
      mapDataBorr[TablesColumnFile.mrefno] =
      customerBorrowingDetailsList[borrDetList].mrefno != null
          ? customerBorrowingDetailsList[borrDetList].mrefno
          : 0;
      mapDataBorr[TablesColumnFile.mcustno] =
      customerBorrowingDetailsList[borrDetList].mcustno != null
          ? customerBorrowingDetailsList[borrDetList].mcustno
          : 0;
      mapDataBorr[TablesColumnFile.mnameofborrower] = ifNullCheck(
          customerBorrowingDetailsList[borrDetList].mnameofborrower);
      mapDataBorr[TablesColumnFile.msource] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].msource);
      mapDataBorr[TablesColumnFile.mpurpose] =
          customerBorrowingDetailsList[borrDetList].mpurpose;
      mapDataBorr[TablesColumnFile.mamount] =
      customerBorrowingDetailsList[borrDetList].mamount != null
          ? customerBorrowingDetailsList[borrDetList].mamount
          : 0;
      mapDataBorr[TablesColumnFile.mintrate] =
      customerBorrowingDetailsList[borrDetList].mintrate != null
          ? customerBorrowingDetailsList[borrDetList].mintrate
          : 0;
      mapDataBorr[TablesColumnFile.memiamt] =
      customerBorrowingDetailsList[borrDetList].memiamt != null
          ? customerBorrowingDetailsList[borrDetList].memiamt
          : 0;
      mapDataBorr[TablesColumnFile.moutstandingamt] =
      customerBorrowingDetailsList[borrDetList].moutstandingamt != null
          ? customerBorrowingDetailsList[borrDetList].moutstandingamt
          : 0;
      mapDataBorr[TablesColumnFile.mmemberno] =
          ifNullCheck(customerBorrowingDetailsList[borrDetList].mmemberno);
      mapDataBorr[TablesColumnFile.mloancycle] =
      customerBorrowingDetailsList[borrDetList].mloancycle != null
          ? customerBorrowingDetailsList[borrDetList].mloancycle
          : 0;
      borrDetailsList.add(mapDataBorr);
    }

    //business data error
    //laterOnset this thig
    var mapDataBuss = new Map();
    if(customerBusinessDetailsBean!=null ) {
      mapDataBuss[TablesColumnFile.tbussdetailsrefno] =
      customerBusinessDetailsBean.tbussdetailsrefno != null
          ? customerBusinessDetailsBean.tbussdetailsrefno
          : 0;
      /*   mapDataBuss[TablesColumnFile.mbussdetailsrefno] =
      customerBusinessDetailsBean.mbussdetailsrefno != null
          ? customerBusinessDetailsBean.mbussdetailsrefno
          : 0;*/
      mapDataBuss[TablesColumnFile.trefno] =
      customerBusinessDetailsBean.trefno != null
          ? customerBusinessDetailsBean.trefno
          : 0;
      mapDataBuss[TablesColumnFile.mrefno] =
      customerBusinessDetailsBean.mrefno != null
          ? customerBusinessDetailsBean.mrefno
          : 0;
      mapDataBuss[TablesColumnFile.mcusactivitytype] =
      customerBusinessDetailsBean.mcusactivitytype != null
          ? customerBusinessDetailsBean.mcusactivitytype
          : 0;
      mapDataBuss[TablesColumnFile.mbusinessname] =
      customerBusinessDetailsBean.mbusinessname != null
          ? customerBusinessDetailsBean.mbusinessname
          : 0;
      mapDataBuss[TablesColumnFile.mbuslocownership] =
      customerListBean.mOccBuisness != null
          ? customerListBean.mOccBuisness
          : 0;
      mapDataBuss[TablesColumnFile.mbusaddress1] =
          ifNullCheck(customerBusinessDetailsBean.mbusaddress1);
      mapDataBuss[TablesColumnFile.mbusaddress2] =
          ifNullCheck(customerBusinessDetailsBean.mbusaddress2);
      mapDataBuss[TablesColumnFile.mbusaddress3] =
          ifNullCheck(customerBusinessDetailsBean.mbusaddress3);
      mapDataBuss[TablesColumnFile.mbusaddress4] =
          ifNullCheck(customerBusinessDetailsBean.mbusaddress4);
      mapDataBuss[TablesColumnFile.mbuscity] =
          ifNullCheck(customerBusinessDetailsBean.mbuscity);
      mapDataBuss[TablesColumnFile.mdistcd] =
      customerBusinessDetailsBean.mdistcd != null
          ? customerBusinessDetailsBean.mdistcd
          : 0;
      mapDataBuss[TablesColumnFile.mbusstate] =
          ifNullCheck(customerBusinessDetailsBean.mbusstate);
      mapDataBuss[TablesColumnFile.mbuscountry] =
          ifNullCheck(customerBusinessDetailsBean.mbuscountry);
      mapDataBuss[TablesColumnFile.mbusarea] =
      customerBusinessDetailsBean.mbusarea != null
          ? customerBusinessDetailsBean.mbusarea
          : 0;
      mapDataBuss[TablesColumnFile.mbusvillage] =
      customerBusinessDetailsBean.mbusvillage != null
          ? customerBusinessDetailsBean.mbusvillage
          : 0;
      mapDataBuss[TablesColumnFile.mbuslandmark] =
          ifNullCheck(customerBusinessDetailsBean.mbuslandmark);
      mapDataBuss[TablesColumnFile.mbuspin] =
      customerBusinessDetailsBean.mbuspin != null
          ? customerBusinessDetailsBean.mbuspin
          : 0;
      mapDataBuss[TablesColumnFile.mbusyrsmnths] =
      customerBusinessDetailsBean.mbusyrsmnths != null
          ? customerBusinessDetailsBean.mbusyrsmnths
          : 0;
      mapDataBuss[TablesColumnFile.mregisteredyn] =
          ifNullCheck(customerBusinessDetailsBean.mregisteredyn);
      mapDataBuss[TablesColumnFile.mregistrationno] =
          ifNullCheck(customerBusinessDetailsBean.mregistrationno);
      mapDataBuss[TablesColumnFile.mbusothtomanageabsyn] =
          ifNullCheck(customerBusinessDetailsBean.mbusothtomanageabsyn);
      mapDataBuss[TablesColumnFile.mbusothmanagername] =
          ifNullCheck(customerBusinessDetailsBean.mbusothmanagername);
      mapDataBuss[TablesColumnFile.mbusothmanagerrel] =
      customerBusinessDetailsBean.mbusothmanagerrel != null
          ? customerBusinessDetailsBean.mbusothmanagerrel
          : 0;
      mapDataBuss[TablesColumnFile.mbusmonthlyincome] =
      customerBusinessDetailsBean.mbusmonthlyincome != null
          ? customerBusinessDetailsBean.mbusmonthlyincome
          : 0;
      mapDataBuss[TablesColumnFile.mbusseasonalityjan] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalityjan);
      mapDataBuss[TablesColumnFile.mbusseasonalityfeb] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalityfeb);
      mapDataBuss[TablesColumnFile.mbusseasonalitymar] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalitymar);
      mapDataBuss[TablesColumnFile.mbusseasonalityapr] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalityapr);
      mapDataBuss[TablesColumnFile.mbusseasonalitymay] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalitymay);
      mapDataBuss[TablesColumnFile.mbusseasonalityjun] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalityjun);
      mapDataBuss[TablesColumnFile.mbusseasonalityjul] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalityjul);
      mapDataBuss[TablesColumnFile.mbusseasonalityaug] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalityaug);
      mapDataBuss[TablesColumnFile.mbusseasonalitysep] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalitysep);
      mapDataBuss[TablesColumnFile.mbusseasonalityoct] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalityoct);
      mapDataBuss[TablesColumnFile.mbusseasonalitynov] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalitynov);
      mapDataBuss[TablesColumnFile.mbusseasonalitydec] =
          ifNullCheck(customerBusinessDetailsBean.mbusseasonalitydec);
      mapDataBuss[TablesColumnFile.mbushighsales] =
      customerBusinessDetailsBean.mbushighsales != null
          ? customerBusinessDetailsBean.mbushighsales
          : 0;
      mapDataBuss[TablesColumnFile.mbusmediumsales] =
      customerBusinessDetailsBean.mbusmediumsales != null
          ? customerBusinessDetailsBean.mbusmediumsales
          : 0;
      mapDataBuss[TablesColumnFile.mbuslowsales] =
      customerBusinessDetailsBean.mbuslowsales != null
          ? customerBusinessDetailsBean.mbuslowsales
          : 0;
      mapDataBuss[TablesColumnFile.mbushighincome] =
      customerBusinessDetailsBean.mbushighincome != null
          ? customerBusinessDetailsBean.mbushighincome
          : 0;
      mapDataBuss[TablesColumnFile.mbusmediumincom] =
      customerBusinessDetailsBean.mbusmediumincom != null
          ? customerBusinessDetailsBean.mbusmediumincom
          : 0;
      mapDataBuss[TablesColumnFile.mbuslowincome] =
      customerBusinessDetailsBean.mbuslowincome != null
          ? customerBusinessDetailsBean.mbuslowincome
          : 0;
      mapDataBuss[TablesColumnFile.mbusmonthlytotaleval] =
      customerBusinessDetailsBean.mbusmonthlytotaleval != null
          ? customerBusinessDetailsBean.mbusmonthlytotaleval
          : 0;
      mapDataBuss[TablesColumnFile.mbusmonthlytotalverif] =
      customerBusinessDetailsBean.mbusmonthlytotalverif != null
          ? customerBusinessDetailsBean.mbusmonthlytotalverif
          : 0;
      mapDataBuss[TablesColumnFile.mbusincludesurcalcyn] =
          ifNullCheck(customerBusinessDetailsBean.mbusincludesurcalcyn);
      mapDataBuss[TablesColumnFile.mbusnhousesameplaceyn] =
          ifNullCheck(customerBusinessDetailsBean.mbusnhousesameplaceyn);
      mapDataBuss[TablesColumnFile.mbusinesstrend] =
          ifNullCheck(customerBusinessDetailsBean.mbusinesstrend);

      mapDataBuss[TablesColumnFile.mmonthlyincome] =
      customerBusinessDetailsBean.mmonthlyincome != null
          ? customerBusinessDetailsBean.mmonthlyincome
          : 0;
      mapDataBuss[TablesColumnFile.mtotalmonthlyincome] =
      customerBusinessDetailsBean.mtotalmonthlyincome != null
          ? customerBusinessDetailsBean.mtotalmonthlyincome
          : 0;
      mapDataBuss[TablesColumnFile.mbusinessexpense] =
      customerBusinessDetailsBean.mbusinessexpense != null
          ? customerBusinessDetailsBean.mbusinessexpense
          : 0;
      mapDataBuss[TablesColumnFile.mhousehldexpense] =
      customerBusinessDetailsBean.mhousehldexpense != null
          ? customerBusinessDetailsBean.mhousehldexpense
          : 0;
      mapDataBuss[TablesColumnFile.mmonthlyemi] =
      customerBusinessDetailsBean.mmonthlyemi != null
          ? customerBusinessDetailsBean.mmonthlyemi
          : 0;
      mapDataBuss[TablesColumnFile.mincomeemiratio] =
      customerBusinessDetailsBean.mincomeemiratio != null
          ? customerBusinessDetailsBean.mincomeemiratio
          : 0;
      mapDataBuss[TablesColumnFile.mnetamount] =
      customerBusinessDetailsBean.mnetamount != null
          ? customerBusinessDetailsBean.mnetamount
          : 0;
      mapDataBuss[TablesColumnFile.mpercentage] =
      customerBusinessDetailsBean.mpercentage != null
          ? customerBusinessDetailsBean.mpercentage
          : 0;

    }


    //business data error
    //laterOnset this thig
    var mapDataCpv = new Map();
    if(contactPointVerification!=null ) {
      mapDataCpv[TablesColumnFile.tcpvrefno] =
      contactPointVerification.tcpvrefno != null
          ? contactPointVerification.tcpvrefno
          : 0;
      mapDataCpv[TablesColumnFile.trefno] =
      contactPointVerification.trefno != null
          ? contactPointVerification.trefno
          : 0;
      mapDataCpv[TablesColumnFile.mrefno] =
      contactPointVerification.mrefno != null
          ? contactPointVerification.mrefno
          : 0;
      mapDataCpv[TablesColumnFile.maddmatch] =
          ifNullCheck(contactPointVerification.maddmatch);
     /* mapDataCpv[TablesColumnFile.massetvissibledesc] =
          ifNullCheck(contactPointVerification.massetvissibledesc);*/
      mapDataCpv[TablesColumnFile.massetvissiblecode] =
          ifNullCheck(contactPointVerification.massetvissiblecode);
      mapDataCpv[TablesColumnFile.mhouseprptystatus] =
          ifNullCheck(contactPointVerification.mhouseprptystatus);
      mapDataCpv[TablesColumnFile.mhousestructure] =
          ifNullCheck(contactPointVerification.mhousestructure);
      mapDataCpv[TablesColumnFile.mhousewall] =
          ifNullCheck(contactPointVerification.mhousewall);
      mapDataCpv[TablesColumnFile.mhouseroof] =
          ifNullCheck(contactPointVerification.mhouseroof);
      mapDataCpv[TablesColumnFile.myrsmovdin] =
          ifNullCheck(contactPointVerification.myrsmovdin);
    }
    var mapDataBussExp;
    var bussExpDetailsList = new List();
    for (int bussExpDetList = 0;
    bussExpDetList < businessExpendDetailsList.length;
    bussExpDetList++) {
      mapDataBussExp = new Map();
      mapDataBussExp[TablesColumnFile.tbusinexpendrefno] =
      businessExpendDetailsList[bussExpDetList].tbusinexpendrefno != null
          ? businessExpendDetailsList[bussExpDetList].tbusinexpendrefno
          : 0;
      mapDataBussExp[TablesColumnFile.trefno] =
      businessExpendDetailsList[bussExpDetList].trefno != null
          ? businessExpendDetailsList[bussExpDetList].trefno
          : 0;
      /*  mapDataBussExp[TablesColumnFile.mbusinexpenrefno] =
      businessExpendDetailsList[bussExpDetList].mbusinexpenrefno != null
          ? businessExpendDetailsList[bussExpDetList].mbusinexpenrefno
          : 0;*/
      mapDataBussExp[TablesColumnFile.mrefno] =
      businessExpendDetailsList[bussExpDetList].mrefno != null
          ? businessExpendDetailsList[bussExpDetList].mrefno
          : 0;
      mapDataBussExp[TablesColumnFile.mcustno] =
      businessExpendDetailsList[bussExpDetList].mcustno != null
          ? businessExpendDetailsList[bussExpDetList].mcustno
          : 0;
      mapDataBussExp[TablesColumnFile.mbusinexpntype] = ifNullCheck(
          businessExpendDetailsList[bussExpDetList].mbusinexpntype);

      mapDataBussExp[TablesColumnFile.mbusinevaluationamt] =
      businessExpendDetailsList[bussExpDetList].mbusinevaluationamt != null
          ? businessExpendDetailsList[bussExpDetList].mbusinevaluationamt
          : 0;

      bussExpDetailsList.add(mapDataBussExp);
    }

    var mapDataHouseExp;
    var houseExpDetailsList = new List();
    for (int bussExpDetList = 0;
    bussExpDetList < householdExpendDetailsList.length;
    bussExpDetList++) {
      mapDataHouseExp = new Map();
      mapDataHouseExp[TablesColumnFile.tbusinexpendrefno] =
      householdExpendDetailsList[bussExpDetList].thoushldexpendrefno != null
          ? householdExpendDetailsList[bussExpDetList].thoushldexpendrefno
          : 0;
      mapDataHouseExp[TablesColumnFile.trefno] =
      householdExpendDetailsList[bussExpDetList].trefno != null
          ? householdExpendDetailsList[bussExpDetList].trefno
          : 0;
      /*     mapDataHouseExp[TablesColumnFile.mbusinexpenrefno] =
      householdExpendDetailsList[bussExpDetList].mhoushldexpenrefno != null
          ? householdExpendDetailsList[bussExpDetList].mhoushldexpenrefno
          : 0;*/
      mapDataHouseExp[TablesColumnFile.mrefno] =
      householdExpendDetailsList[bussExpDetList].mrefno != null
          ? householdExpendDetailsList[bussExpDetList].mrefno
          : 0;
      mapDataHouseExp[TablesColumnFile.mcustno] =
      householdExpendDetailsList[bussExpDetList].mcustno != null
          ? householdExpendDetailsList[bussExpDetList].mcustno
          : 0;
      mapDataHouseExp[TablesColumnFile.mhoushldexpntype] = ifNullCheck(
          householdExpendDetailsList[bussExpDetList].mhoushldexpntype);

      mapDataHouseExp[TablesColumnFile.mhoushldevaluationamt] =
      householdExpendDetailsList[bussExpDetList].mhoushldevaluationamt != null
          ? householdExpendDetailsList[bussExpDetList].mhoushldevaluationamt
          : 0;

      houseExpDetailsList.add(mapDataHouseExp);
    }


    var mapDataAsset;
    var assetDetailList = List();
    for (int assetDetList = 0;
    assetDetList < assetDetailsList.length;
    assetDetList++) {
      mapDataAsset = new Map();
      mapDataAsset[TablesColumnFile.tassetdetrefno] =
      assetDetailsList[assetDetList].tassetdetrefno != null
          ? assetDetailsList[assetDetList].tassetdetrefno
          : 0;
      mapDataAsset[TablesColumnFile.trefno] =
      assetDetailsList[assetDetList].trefno != null
          ? assetDetailsList[assetDetList].trefno
          : 0;
      mapDataAsset[TablesColumnFile.massetdetrefno] =
      assetDetailsList[assetDetList].massetdetrefno != null
          ? assetDetailsList[assetDetList].massetdetrefno
          : 0;
      mapDataAsset[TablesColumnFile.mrefno] =
      assetDetailsList[assetDetList].mrefno != null
          ? assetDetailsList[assetDetList].mrefno
          : 0;
      mapDataAsset[TablesColumnFile.mcustno] =
      assetDetailsList[assetDetList].mcustno != null
          ? assetDetailsList[assetDetList].mcustno
          : 0;
      mapDataAsset[TablesColumnFile.mitem] =
      assetDetailsList[assetDetList].mitem != null
          ? assetDetailsList[assetDetList].mitem
          : 0;
      assetDetailList.add(mapDataAsset);
    }

    var mapDataPpi;
    var ppiDetailsList = new List();
    for (int ppiDetList = 0;
    ppiDetList < pPIMasterBeanList.length;
    ppiDetList++) {
      mapDataPpi = new Map();
      mapDataPpi[TablesColumnFile.tPpirefno] =
      pPIMasterBeanList[ppiDetList].tPpirefno != null
          ? pPIMasterBeanList[ppiDetList].tPpirefno
          : 0;
      mapDataPpi[TablesColumnFile.trefno] =
      pPIMasterBeanList[ppiDetList].trefno != null
          ? pPIMasterBeanList[ppiDetList].trefno
          : 0;
      /* mapDataPpi[TablesColumnFile.mPpirefno] =
      pPIMasterBeanList[ppiDetList].mPpirefno != null
          ? pPIMasterBeanList[ppiDetList].mPpirefno
          : 0;*/
      mapDataPpi[TablesColumnFile.mrefno] =
      pPIMasterBeanList[ppiDetList].mrefno != null
          ? pPIMasterBeanList[ppiDetList].mrefno
          : 0;
      mapDataPpi[TablesColumnFile.mcustno] =
      pPIMasterBeanList[ppiDetList].mcustno != null
          ? pPIMasterBeanList[ppiDetList].mcustno
          : 0;
      mapDataPpi[TablesColumnFile.mitem] = ifNullCheck(
          pPIMasterBeanList[ppiDetList].mitem);

      mapDataPpi[TablesColumnFile.mhaveyn] = ifNullCheck(
          pPIMasterBeanList[ppiDetList].mhaveyn);

      mapDataPpi[TablesColumnFile.mnoofitems] =
      pPIMasterBeanList[ppiDetList].mnoofitems != null
          ? pPIMasterBeanList[ppiDetList].mnoofitems
          : 0;
      mapDataPpi[TablesColumnFile.mweightage] =
      pPIMasterBeanList[ppiDetList].mweightage != null
          ? pPIMasterBeanList[ppiDetList].mweightage
          : 0;
      mapDataPpi[TablesColumnFile.mquestiontype] = ifNullCheck(
          pPIMasterBeanList[ppiDetList].mquestiontype);
      ppiDetailsList.add(mapDataPpi);
    }
    var mapDataImg;
    var imgDetailsList = new List();
    for (int imgDetList = 0; imgDetList < imageList.length; imgDetList++) {
      print("data data ");
      mapDataImg = new Map();
      mapDataImg[TablesColumnFile.tImgrefno] =
      imageList[imgDetList].tImgrefno != null &&
          imageList[imgDetList].tImgrefno != 'null'
          ? imageList[imgDetList].tImgrefno
          : 0;
      mapDataImg[TablesColumnFile.trefno] = imageList[imgDetList].trefno != null
          ? imageList[imgDetList].trefno
          : 0;
      // mapDataImg[TablesColumnFile.mImgrefno] =	        imageList[imgDetList].mImgrefno!=null && imageList[imgDetList].mImgrefno!='null' ?imageList[imgDetList].mImgrefno:0;
      mapDataImg[TablesColumnFile.mrefno] = imageList[imgDetList].mrefno != null
          ? imageList[imgDetList].mrefno
          : 0;
      mapDataImg["imgType"] = ifNullCheck(imageList[imgDetList].imgType);
      /*if (imageList[imgDetList].tImgrefno == 11 ||
          imageList[imgDetList].tImgrefno == 12) {*/
      if (imageList[imgDetList].tImgrefno > 10 ) {
        mapDataImg["imgString"] = ifNullCheck(imageList[imgDetList].imgString);
      } else {
        print("Data here is " + imageList[imgDetList].tImgrefno.toString());
        print(imageList[imgDetList].imgString);
        File imageFile = new File(imageList[imgDetList].imgString);
        print("xxxxxxxxxx length of image  ${imageFile.lengthSync()}");
        final Directory extDir = await getApplicationDocumentsDirectory();
        var targetPath = extDir.absolute.path + "/temp.png";
        var imgFile = null;




        if(imageFile!=null && targetPath!=null){

          imgFile = await compressAndGetFile(imageFile, targetPath);
        List<int> imageBytes = imgFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        mapDataImg["imgString"] = ifNullCheck(base64Image);
        }else{
          mapDataImg["imgString"] = null;
        }
        /*mapDataImg["imgString"] = imageBytes;*/
      }
      mapDataImg["imgSubType"] = ifNullCheck(imageList[imgDetList].imgSubType);
      mapDataImg["description"] = ifNullCheck(imageList[imgDetList].desc);
      mapDataImg[TablesColumnFile.mcustno] = customerListBean.mcustno!=null?customerListBean.mcustno : 0;
      //mapDataImg["imageByteString"] = imageList[imgDetList].imgString;
      imgDetailsList.add(mapDataImg);
    }






    var mapDataFingerPrint;
    var fingerPrintList = new List();
    for (int fingerPrintListCount = 0; fingerPrintListCount < customerFingerPrintBeanList.length; fingerPrintListCount++) {
      mapDataFingerPrint = new Map();
      mapDataFingerPrint[TablesColumnFile.timagerefno] =
      customerFingerPrintBeanList[fingerPrintListCount].timagerefno != null
          ? customerFingerPrintBeanList[fingerPrintListCount].timagerefno
          : 0;
      mapDataFingerPrint[TablesColumnFile.trefno] = customerFingerPrintBeanList[fingerPrintListCount].trefno != null
          ? customerFingerPrintBeanList[fingerPrintListCount].trefno
          : 0;
      // mapDataImg[TablesColumnFile.mImgrefno] =	        imageList[imgDetList].mImgrefno!=null && imageList[imgDetList].mImgrefno!='null' ?imageList[imgDetList].mImgrefno:0;
      mapDataFingerPrint[TablesColumnFile.mrefno] = customerFingerPrintBeanList[fingerPrintListCount].mrefno != null
          ? customerFingerPrintBeanList[fingerPrintListCount].mrefno
          : 0;
      mapDataFingerPrint[TablesColumnFile.mimagetype] = ifNullCheck(customerFingerPrintBeanList[fingerPrintListCount].mimagetype);
      /*if (imageList[imgDetList].tImgrefno == 11 ||
          imageList[imgDetList].tImgrefno == 12) {*/

      mapDataFingerPrint[TablesColumnFile.mimagestring] = ifNullCheck(customerFingerPrintBeanList[fingerPrintListCount].mimagestring);
      mapDataFingerPrint[TablesColumnFile.mimagesubtype] = ifNullCheck(customerFingerPrintBeanList[fingerPrintListCount].mimagesubtype);
      mapDataFingerPrint[TablesColumnFile.desc] = ifNullCheck(customerFingerPrintBeanList[fingerPrintListCount].desc);

      mapDataFingerPrint[TablesColumnFile.mcustno] = customerFingerPrintBeanList[fingerPrintListCount].mcustno != null
          ? customerFingerPrintBeanList[fingerPrintListCount].mcustno:0;
      //mapDataImg["imageByteString"] = imageList[imgDetList].imgString;
      fingerPrintList.add(mapDataFingerPrint);
    }








    mapData[TablesColumnFile.familyDetails] = famiDetList;
    mapData[TablesColumnFile.addressDetails] = addDetailsList;
    mapData[TablesColumnFile.borrowingDetails] = borrDetailsList;
    mapData[TablesColumnFile.businessExpendDetails] = bussExpDetailsList;
    mapData[TablesColumnFile.householdExpendDetails] = houseExpDetailsList;
    mapData[TablesColumnFile.assetDetailsList] = assetDetailList;
    mapData[TablesColumnFile.imageMaster] = imgDetailsList;
    mapData[TablesColumnFile.contactPointVerificationEntity] = mapDataCpv;
    mapData[TablesColumnFile.customerBussDetails] = mapDataBuss;
    mapData[TablesColumnFile.ppiDetails] = ppiDetailsList;
    mapData["customerFingerPrintList"] = fingerPrintList;
    //this is still not added in list
    mapData["paymentDetailsDetails"] = List();
    // mapData["customerPPIDetailsEntity"] = List();
    listCust.add(mapData);
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value;
  }

  Future<CustomerCheckBean> SyncSingleCustomerToMiddleware(CustomerListBean item,DateTime lastBulkSysTime) async {
   // try {
      lastSyncedToServerDaeTime =lastBulkSysTime;



          await AppDatabase.get()
              .selectCustomerFamilyDetailsListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<FamilyDetailsBean> familyDetailsBean) async {
            customerFamilyDetailsList = familyDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerBorrowingDetailsListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<BorrowingDetailsBean> borrowingDetailsBean) async {
            customerBorrowingDetailsList = borrowingDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerAddressDetailsListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<AddressDetailsBean> addressDetails) async {
            customerAddressDetailsList = addressDetails;
          });

          await AppDatabase.get()
              .selectImagesListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<ImageBean> imageBean) async {
            imageList = imageBean;
          });

          await AppDatabase.get()
              .selectCustomerBussinessDetails(
              item.trefno, item.mrefno)
              .then((CustomerBusinessDetailsBean
          customerBussBean) async {
            customerBusinessDetailsBean = customerBussBean;
          });

      await AppDatabase.get()
          .selectCustomerCpvDetails( item.trefno,  item.mrefno)
          .then(
              (ContactPointVerificationBean contactPointVerificationBean) async {
            contactPointVerification = contactPointVerificationBean;
            /* print(
            "customerBusinessDetailsBean list is ${bean.customerBusinessDetailsBean}");*/
          });
          await AppDatabase.get()
              .selectCustomerBusinessExpenseListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<BusinessExpenditureDetailsBean> businessExpenditureDetailsBean) async {
            businessExpendDetailsList = businessExpenditureDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerHouseholdExpenseListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<HouseholdExpenditureDetailsBean> householdExpenditureDetailsBean) async {
            householdExpendDetailsList = householdExpenditureDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerAssetDetailListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<AssetDetailsBean> assetDetailsBean) async {
            assetDetailsList = assetDetailsBean;
          });

          await AppDatabase.get()
              .selectCustomerPPIListIsDataSynced(
              item.trefno, item.mrefno)
              .then((List<PPIMasterBean> pPIMasterBean) async {
            pPIMasterBeanList = pPIMasterBean;
          });


      await AppDatabaseExtended.get()
          .selectFingerPrintList(
          item.trefno, item.mrefno)
          .then((List<CustomerFingerPrintBean> fingerPrintListElements) async {
        customerFingerPrintBeanList = fingerPrintListElements;
        print("Returned elemnts of finger print are ${fingerPrintListElements.length}");
      });

      isForSingleCustomer = true;
          await _toCustomerJson(item).then((onValue) {});



      print("length of adress is ${customerAddressDetailsList.length}");
      print(customerAddressDetailsList);
      //await _toCustomerJson(item).then((onValue) {});
      _serviceUrl = "customerData/addCustomerByHolder";
      String json = JSON.encode(listCust);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }


      await syncedDataToMiddleware(json);
      return custCheckObj;
   /* }catch(_){
      return null;
    }*/
//after call needs to update mref in tab in all tables and update lastsynced in lastsynced date time table
  }
  
  
    String ifDateNullCheck(DateTime value){
    if(value==null || value == 'null'){
      return null;
    }
    else {
      return  value.toIso8601String();
    }

  }
}
