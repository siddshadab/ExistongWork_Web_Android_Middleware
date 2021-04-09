import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

import 'Collateral/Bean/CollateralBasicSelectionBean.dart';



class SyncingCollatralBasicDetailsToMiddleware {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List collateralBasicDetailsList = List();

  Future<Null> syncCollateralBasicDetails(String jsonList) async {
    try {
      String bodyValue = await NetworkUtil.callPostService(jsonList,
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      if (bodyValue == '404') {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CollateralBasicSelectionBean> obj = parsed
            .map<CollateralBasicSelectionBean>((json) => CollateralBasicSelectionBean.fromMapMiddleware(json))
            .toList();

        for (int collateralBasicDetailsNo = 0; collateralBasicDetailsNo< obj.length; collateralBasicDetailsNo++) {
          await AppDatabase.get()
              .selectCollateralBasicOnTrefANDMrefno(obj[collateralBasicDetailsNo].trefno, obj[collateralBasicDetailsNo].mcreatedby,obj[collateralBasicDetailsNo].mrefno)
              .then((CollateralBasicSelectionBean collateralBasicDetailsBean) async {

            String updateCollateralBasicDetailsQuery = null;
            String updateSubCol =null;
             try {
            if (obj[collateralBasicDetailsNo] != null &&
                obj[collateralBasicDetailsNo].mrefno != null &&
                collateralBasicDetailsBean != null &&
                collateralBasicDetailsBean.mrefno == null ||
                collateralBasicDetailsBean.mrefno == 0) {

              updateCollateralBasicDetailsQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mrefno} = ${obj[collateralBasicDetailsNo]
                  .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[collateralBasicDetailsNo]
                  .trefno}";


              updateSubCol=  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.colleteralmrefno} = ${obj[collateralBasicDetailsNo]
                 .mrefno} ,${TablesColumnFile.mlastsynsdate} =  '${DateTime.now()}' "
                  " WHERE ${TablesColumnFile.colleteraltrefno} = ${obj[collateralBasicDetailsNo]
                 .trefno}";

            } else {
              updateCollateralBasicDetailsQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[collateralBasicDetailsNo]
                  .mrefno} AND ${TablesColumnFile.trefno} = ${obj[collateralBasicDetailsNo]
                  .trefno}";
/*
               updateSubCol =
                  "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.colleteralmrefno} = ${obj[collateralBasicDetailsNo]
                  .mrefno},${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}' "
                  " WHERE ${TablesColumnFile.colleteraltrefno} = ${obj[collateralBasicDetailsNo]
                  .trefno} AND  ${TablesColumnFile.mcreatedby} = '${obj[collateralBasicDetailsNo]
                  .mcreatedby.trim()}'";*/
            }

            if (updateCollateralBasicDetailsQuery != null) {
              await AppDatabase.get()
                  .updateCollateralBasicMasterAfterSync(updateCollateralBasicDetailsQuery);
            }


            if (updateSubCol != null) {
              await AppDatabase.get()
                  .updateCollateralVehicleWhileBasicCollSyncMaster(
                  updateSubCol);
              await AppDatabase.get().updateCollateralREMMasterAfterSync(
                  updateSubCol);
            }


             } catch (_) {}
          });
        }
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }


  Future<Null> getAndSync() async {
    try {
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(16, false)
        .then((returnedCollateralBasicDetailsDateTime) async {
          print("returnedCollateralBasicDetailsDateTime "+ returnedCollateralBasicDetailsDateTime.toString());
      await AppDatabase.get()
          .selectCollateralMasterListNotSynced(returnedCollateralBasicDetailsDateTime)
          .then((List<CollateralBasicSelectionBean> collateralBasicDetailsBean) async {

        for (int i = 0; i < collateralBasicDetailsBean.length; i++) {


          _toListJson(collateralBasicDetailsBean[i]);

        }
        String json = JSON.encode(collateralBasicDetailsList);
      /*  for (var items in json.toString().split(",")) {
          print("Json values for cgt1 " + items.toString());
        }*/
        _serviceUrl = "collateralBasicSelectionData/add/";
        await syncCollateralBasicDetails(json);
      });
    });
   AppDatabase.get().updateStaticTablesLastSyncedMaster(16);
    } catch (e) {
      print('Server Exception!!!');
    }
  }






  Future<String> _toListJson(CollateralBasicSelectionBean bean) async {
    var mapData = new Map();


    mapData[TablesColumnFile.trefno] = 	  bean.trefno==null?0:bean.trefno;
    mapData[TablesColumnFile.mrefno] = 	  bean.mrefno==null?0:bean.mrefno;
    mapData[TablesColumnFile.loantrefno] = 	  bean.loantrefno==null?0:bean.loantrefno;
    mapData[TablesColumnFile.loanmrefno] = 	  bean.loanmrefno==null?0:bean.loanmrefno;
    mapData[TablesColumnFile.mleadsid] = 	  ifNullCheck(bean.mleadsid);
    mapData[TablesColumnFile.mprdacctid] = 	  ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.mcollateralsid] = 	  ifNullCheck(bean.mcollateralsid);
    mapData[TablesColumnFile.msrno] = 	  bean.msrno==null?0:bean.msrno;
    mapData[TablesColumnFile.mfname] = 	  ifNullCheck(bean.mfname);
    mapData[TablesColumnFile.mmname] = 	  ifNullCheck(bean.mmname);
    mapData[TablesColumnFile.mlname] = 	 ifNullCheck(bean.mlname);
    mapData[TablesColumnFile.mapplicanttype] = 	  bean.mapplicanttype==null?0:bean.mapplicanttype;
      mapData[TablesColumnFile.mcollatrlTyp] = 	  ifNullCheck(bean.collatrlTyp);

    mapData[TablesColumnFile.mcustno] = 	  bean.mcustno==null?0:bean.mcustno;
    mapData[TablesColumnFile.mrelationwithcust] = 	  ifNullCheck(bean.mrelationwithcust);
    mapData[TablesColumnFile.mrelationsince] = 	  bean.mrelationsince==null?0:bean.mrelationsince;
    mapData[TablesColumnFile.msubcolltrl] = 	  ifNullCheck(bean.msubcolltrl);
    mapData[TablesColumnFile.msubocolltrldesc] = 	  ifNullCheck(bean.msubocolltrldesc);
    mapData[TablesColumnFile.msubcolltrlcat] = 	  ifNullCheck(bean.msubcolltrlcat);
    mapData[TablesColumnFile.msubocolltrlcatdesc] = 	  ifNullCheck(bean.msubocolltrlcatdesc);
    mapData[TablesColumnFile.mcollatrlcat] = 	  ifNullCheck(bean.collatrlcat);
    mapData[TablesColumnFile.mnametitle] = 	  ifNullCheck(bean.nametitle);
    mapData[TablesColumnFile.minsurance] = 	  ifNullCheck(bean.insurance);
    mapData[TablesColumnFile.mcolltrltitle] = 	  ifNullCheck(bean.colltrltitle);
    mapData[TablesColumnFile.mnameoftitledoc] = 	  ifNullCheck(bean.mnameoftitledoc);
    mapData[TablesColumnFile.mcollbookno] = 	  ifNullCheck(bean.mcollbookno);
    mapData[TablesColumnFile.mcollpageno] = 	  ifNullCheck(bean.mcollpageno);
    mapData[TablesColumnFile.mplaceofuse] = 	  ifNullCheck(bean.mplaceofuse);
    mapData[TablesColumnFile.mwithdrawcond] = 	  ifNullCheck(bean.mwithdrawcond);


    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
   mapData[TablesColumnFile.missynctocoresys] = 	  bean.missynctocoresys==null?0:bean.missynctocoresys;
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.misappctprimary] =	ifNullCheck(bean.misappctprimary);
    mapData[TablesColumnFile.mislmap] =	ifNullCheck(bean.mislmap);
    mapData[TablesColumnFile.mnoofattchmnt] =	ifNullCheck(bean.mnoofattchmnt);

    collateralBasicDetailsList.add(mapData);
    return mapData.toString();
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
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }
}
