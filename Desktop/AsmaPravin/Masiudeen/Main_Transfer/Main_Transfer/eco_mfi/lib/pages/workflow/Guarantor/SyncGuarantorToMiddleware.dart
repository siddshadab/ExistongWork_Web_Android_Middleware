import 'dart:convert';
import 'dart:io';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:path_provider/path_provider.dart';

class SyncGuarantorToMiddleware {
  List listGuar = List();
  static const JsonCodec JSON = const JsonCodec();
  static String _serviceUrl = "";
  static final _headers = {'Content-Type': 'application/json'};

  Future<Null> syncGuarantor(String listValue,String userCode) async {
    try {

      String bodyValue  = await NetworkUtil.callPostService(listValue,Constant.apiURL.toString()+_serviceUrl.toString(),_headers);
      print("url "+Constant.apiURL.toString()+_serviceUrl.toString());
      if(bodyValue == "404" ){
        return null;
      } else {
        for (var items in bodyValue.toString().split(",")) {
          print("lolololololoXXXXXXXXXXX" + items.toString());
        }
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        print(" parsed ${parsed}");


        List<GuarantorDetailsBean> obj = parsed
            .map<GuarantorDetailsBean>(
                (json) => GuarantorDetailsBean.fromMiddlwareTemp(json)).toList();
        print("obj.length ${obj.length }");

        for (int grntr = 0; grntr < obj.length; grntr++) {
          await AppDatabase.get()
              .selectGuarantorOnTrefMrerfoForMiddlewareResponseUpdate(obj[grntr].trefno, obj[grntr].mcreatedby,obj[grntr].mrefno)
              .then((GuarantorDetailsBean guarantorDetailsBean) async {

                print(" guarantorDetailsBean guarantorDetailsBean ${guarantorDetailsBean }");
            //if (obj[grntr]!=null && obj[grntr].mrefno != null && guarantorDetailsBean.mrefno==null || guarantorDetailsBean.mrefno == 0) {
            if (obj[grntr]!=null && obj[grntr].mrefno != null && guarantorDetailsBean.mrefno==null || guarantorDetailsBean.mrefno == 0) {
              String updateGrntrQuery ="";
              updateGrntrQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}',${TablesColumnFile.missynctocoresys} = 1  , ${TablesColumnFile.mrefno} = ${obj[grntr].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[grntr].trefno} "
                  "AND ${TablesColumnFile.mcreatedby} = '${obj[grntr].mcreatedby.trim()}'";
              print("updateGrntrQuery query" + updateGrntrQuery.toString());
              if(updateGrntrQuery !=null) {
                await AppDatabase.get().updateGuarantorMaster(updateGrntrQuery);
              }
            }else{
              String updateGrntrQuery ="";
              updateGrntrQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.missynctocoresys} = 1  WHERE ${TablesColumnFile.mrefno} = ${obj[grntr].mrefno} AND ${TablesColumnFile.trefno} = ${obj[grntr].trefno}";
              print("updateGrntrQuery query" + updateGrntrQuery.toString());
              if (updateGrntrQuery != null) {
                await AppDatabase.get().updateGuarantorMaster(updateGrntrQuery);
              }
            }



          });
        }
        AppDatabase.get().updateStaticTablesLastSyncedMaster(23);
        print("Updatedxxxxxxxxx");
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  Future<Null> getAndSync(String userCode) async {
    print("guarantor getAndSync");
    List _guarantorList = new List();
    try {
        await AppDatabase.get().getGuarantorsNotSynced().then((guarantorList) async{


          if(guarantorList.length==0){
            return;
          }
          print("Returned Gaiurantor Entity ${guarantorList}");

          for (int i = 0; i < guarantorList.length; i++) {

            try{
              await _toJson(guarantorList[i]).then((returnedJson) async { });
            }catch(_){

            }

          }



          String json = JSON.encode(listGuar);
          for (var items in json.toString().split(",")) {
            print("Json values" + items.toString());
          }
          _serviceUrl = "/GuarantorController/add/";
          await syncGuarantor(json,userCode);




        });
     
     }

    catch (e) {
      print('Server Exception!!!');

    }
  }



  Future<Null> getGaurantor(List<GuarantorDetailsBean> gaurantorList) async {


      print("Returned Gaiurantor Entity ${gaurantorList}");
      for (int i = 0; i < gaurantorList.length; i++) {
        //if((gaurantorList!=null)&&(gaurantorList[i].missynctocoresys==0||gaurantorList[i].missynctocoresys==null)){
        await _toJson(gaurantorList[i]).then((returnedJson) async { });
      //}
      }
      print("after get guarantor not synced");
      _serviceUrl = "/GuarantorController/add/";
      String json = JSON.encode(listGuar);
      for (var items in json.toString().split(",")) {
        print("Json values" + items.toString());
      }

      await syncGuarantor(json,userCode);
  }


  String ifDateNullCheck(DateTime value){
    if(value==null || value == 'null'){
      return "";
    }
    else {
      return  value.toIso8601String();
    }

  }
  String ifNullCheck(String value) {
    if (value == null || value == 'null' ) {
      value = "";
    }
    return value;
  }

  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
      rotate: 0,
    );
    return result;
  }

  Future<Null> _toJson(GuarantorDetailsBean bean) async{
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] =	bean.trefno!=null ? bean.trefno:0;
    mapData[TablesColumnFile.mrefno] =	bean.mrefno!=null ? bean.mrefno:0;
    mapData[TablesColumnFile.mloantrefno] =	bean.mloantrefno!=null ? bean.mloantrefno:0;
    mapData[TablesColumnFile.mloanmrefno] =	bean.mloanmrefno!=null ? bean.mloanmrefno:0;
    mapData[TablesColumnFile.mleadsid] =	ifNullCheck(bean.mleadsid);
    mapData[TablesColumnFile.mprdacctid] =	ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.msrno] =	bean.msrno !=null ? bean.msrno :0;
    mapData[TablesColumnFile.mapplicanttype] =	bean.mapplicanttype !=null ? bean.mapplicanttype:0;
    mapData[TablesColumnFile.mexistingcustyn] =	ifNullCheck(bean.mexistingcustyn);
    mapData[TablesColumnFile.mcustno] =	bean.mcustno !=null ? bean.mcustno:0;
    mapData[TablesColumnFile.mnameofguar] =	ifNullCheck(bean.mnameofguar);
    mapData[TablesColumnFile.mgender] =	ifNullCheck(bean.mgender);
    mapData[TablesColumnFile.mrelationwithcust] =	ifNullCheck(bean.mrelationwithcust);
    mapData[TablesColumnFile.mrelationsince] =	bean.mrelationsince !=null ? bean.mrelationsince:0;
    mapData[TablesColumnFile.mage] =	bean.mage !=null ? bean.mage:0;
    mapData[TablesColumnFile.mphone] =	ifNullCheck(bean.mphone);
    mapData[TablesColumnFile.mmobile] =	ifNullCheck(bean.mmobile);
    mapData[TablesColumnFile.maddress] =	ifNullCheck(bean.maddress);
    mapData[TablesColumnFile.mmonthlyincome] =	bean.mmonthlyincome!=null?bean.mmonthlyincome:0;
    mapData[TablesColumnFile.mdob] =	ifDateNullCheck(bean.mdob) ;
    mapData[TablesColumnFile.moccupationtype] =	bean.moccupationtype!=null ? bean.moccupationtype:0;
    mapData[TablesColumnFile.mmainoccupation] =	bean.mmainoccupation !=null ? bean.mmainoccupation:0;
    mapData[TablesColumnFile.mworkexpinyrs] =	bean.mworkexpinyrs !=null ? bean.mworkexpinyrs:0;
    mapData[TablesColumnFile.mincomeothsources] =	bean.mincomeothsources!=null? bean.mincomeothsources:0;
    mapData[TablesColumnFile.mtotalincome] =	bean.mtotalincome!=null? bean.mtotalincome:0;
    mapData[TablesColumnFile.mhousetype] =	bean.mhousetype!=null ? bean.mhousetype:0;
    mapData[TablesColumnFile.mworkingaddress] =	ifNullCheck(bean.mworkingaddress);
    mapData[TablesColumnFile.mworkphoneno] =	ifNullCheck(bean.mworkphoneno);
    mapData[TablesColumnFile.mmothermaidenname] =	ifNullCheck(bean.mmothermaidenname);
    mapData[TablesColumnFile.mpromissorynote] =	ifNullCheck(bean.mpromissorynote);
    mapData[TablesColumnFile.mnationalidtype] =	bean.mnationalidtype!=null ? bean.mnationalidtype:0;
    mapData[TablesColumnFile.mnationalid] =	bean.mnationalid !=null ? bean.mnationalid:0;
    mapData[TablesColumnFile.mnationaliddesc] =	ifNullCheck(bean.mnationaliddesc);
    mapData[TablesColumnFile.maddress2] =	ifNullCheck(bean.maddress2);
    mapData[TablesColumnFile.maddress3] =	ifNullCheck(bean.maddress3);
    mapData[TablesColumnFile.maddress4] =	ifNullCheck(bean.maddress4);
    mapData[TablesColumnFile.mmaritalstatus] =	bean.mmaritalstatus!=null ? bean.mmaritalstatus:0;
    mapData[TablesColumnFile.mreligioncd] =	bean.mreligioncd!=null ? bean.mreligioncd:0;
    mapData[TablesColumnFile.meducationalqual] =	ifNullCheck(bean.meducationalqual);
    mapData[TablesColumnFile.memailaddr] =	ifNullCheck(bean.memailaddr);
    mapData[TablesColumnFile.memployername] =	ifNullCheck(bean.memployername);
    mapData[TablesColumnFile.mbusinessname] =	ifNullCheck(bean.mbusinessname);
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.merrormessage] =	ifNullCheck(bean.merrormessage);
    mapData[TablesColumnFile.isDataSynced] = 1;
    mapData[TablesColumnFile.mspousename] =	ifNullCheck(bean.mspousename);
    mapData[TablesColumnFile.mstatecd] =	ifNullCheck(bean.mstatecd);
    mapData[TablesColumnFile.mtownship] =	ifNullCheck(bean.mtownship);
    mapData[TablesColumnFile.mvillage] =	bean.mvillage!=null ? bean.mvillage:0;
    mapData[TablesColumnFile.mwardno] =	ifNullCheck(bean.mwardno);
    mapData[TablesColumnFile.mbuspropownership] =	bean.mbuspropownership!=null ? bean.mbuspropownership:0;
    mapData[TablesColumnFile.mbusownership] =	bean.mbusownership!=null ? bean.mbusownership:0;
    mapData[TablesColumnFile.mbustoaassetval] =	bean.mbustoaassetval!=null? bean.mbustoaassetval:0;
    mapData[TablesColumnFile.mbusleninyears] =	ifNullCheck(bean.mbusleninyears);
    mapData[TablesColumnFile.mbusmonexpense] =	bean.mbusmonexpense!=null? bean.mbusmonexpense:0;
    mapData[TablesColumnFile.mbusmonhlynetprof] =	bean.mbusmonhlynetprof!=null? bean.mbusmonhlynetprof:0;
    mapData[TablesColumnFile.msamevillageorward] =	ifNullCheck(bean.msamevillageorward);
    mapData[TablesColumnFile.missynctocoresys] =	0;
    //Image capture
    try{
      if (bean.mfacecapture != null && bean.mfacecapture != "null") {
        File imageFile = new File(bean.mfacecapture);
        final Directory extDir = await getApplicationDocumentsDirectory();
        var targetPath = extDir.absolute.path + "/temp.png";
        var imgFile = await compressAndGetFile(imageFile, targetPath);
        List<int> imageBytes = imgFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        mapData["mfacecapture"] = ifNullCheck(base64Image);
      } else
        mapData["mfacecapture"] = null;
    }catch(_){
      mapData["mfacecapture"] = null;
    }


    try{
      if (bean.mnrcphoto != null && bean.mnrcphoto != "null") {
        File imageFile = new File(bean.mnrcphoto);
        final Directory extDir = await getApplicationDocumentsDirectory();
        var targetPath = extDir.absolute.path + "/temp.png";
        var imgFile = await compressAndGetFile(imageFile, targetPath);
        List<int> imageBytes = imgFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        mapData["mnrcphoto"] = ifNullCheck(base64Image);
      } else
        mapData["mnrcphoto"] = null;
    }catch(_){
      mapData["mnrcphoto"] = null;
    }


    try{
      if (bean.mnrcsecphoto != null && bean.mnrcsecphoto != "null") {
        File imageFile = new File(bean.mnrcsecphoto);
        final Directory extDir = await getApplicationDocumentsDirectory();
        var targetPath = extDir.absolute.path + "/temp.png";
        var imgFile = await compressAndGetFile(imageFile, targetPath);
        List<int> imageBytes = imgFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        mapData["mnrcsecphoto"] = ifNullCheck(base64Image);
      } else
        mapData["mnrcsecphoto"] = null;
    }catch(_){
      mapData["mnrcsecphoto"] = null;
    }


    try{
      if (bean.mhouseholdphoto != null && bean.mhouseholdphoto != "null") {
        File imageFile = new File(bean.mhouseholdphoto);
        final Directory extDir = await getApplicationDocumentsDirectory();
        var targetPath = extDir.absolute.path + "/temp.png";
        var imgFile = await compressAndGetFile(imageFile, targetPath);
        List<int> imageBytes = imgFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        mapData["mhouseholdphoto"] = ifNullCheck(base64Image);
      } else
        mapData["mhouseholdphoto"] = null;
    }catch(_){
      mapData["mhouseholdphoto"] = null;
    }



    try{
      if (bean.mhouseholdsecphoto != null && bean.mhouseholdsecphoto != "null") {
        File imageFile = new File(bean.mhouseholdsecphoto);
        final Directory extDir = await getApplicationDocumentsDirectory();
        var targetPath = extDir.absolute.path + "/temp.png";
        var imgFile = await compressAndGetFile(imageFile, targetPath);
        List<int> imageBytes = imgFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        mapData["mhouseholdsecphoto"] = ifNullCheck(base64Image);
      } else
        mapData["mhouseholdsecphoto"] = null;
    }catch(_){
      mapData["mhouseholdsecphoto"] = null;
    }



    try{
      if (bean.maddressphoto != null && bean.maddressphoto != "null") {
        File imageFile = new File(bean.maddressphoto);
        final Directory extDir = await getApplicationDocumentsDirectory();
        var targetPath = extDir.absolute.path + "/temp.png";
        var imgFile = await compressAndGetFile(imageFile, targetPath);
        List<int> imageBytes = imgFile.readAsBytesSync();
        String base64Image = base64.encode(imageBytes);
        mapData["maddressphoto"] = ifNullCheck(base64Image);
      } else
        mapData["maddressphoto"] = null;
    }catch(_){
      mapData["maddressphoto"] = null;
    }


      mapData["msignature"] = ifNullCheck(bean.msignature);


  /* // String json = JSON.encode(mapData);
    return mapData;*/
    listGuar.add(mapData);
    }
  }
