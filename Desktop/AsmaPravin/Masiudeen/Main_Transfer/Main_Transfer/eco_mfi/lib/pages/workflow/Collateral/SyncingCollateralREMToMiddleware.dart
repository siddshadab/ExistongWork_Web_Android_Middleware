import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

import 'CollateralREM/Bean/CollateralREMlandandhouseBean.dart';



class SyncingCollateralREMToMiddleware {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List collateralVehicleList = List();

  Future<Null> syncCollateralRem(String jsonList) async {
 try {
      String bodyValue = await NetworkUtil.callPostService(jsonList,
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      if (bodyValue == '404') {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CollateralREMlandandhouseBean> obj = parsed
            .map<CollateralREMlandandhouseBean>((json) => CollateralREMlandandhouseBean.fromMapMiddleware(json))
            .toList();

        for (int collateralREMNo = 0; collateralREMNo< obj.length; collateralREMNo++) {
          await AppDatabase.get()
              .selectCollateralREMOnTrefANDMrefno(obj[collateralREMNo].trefno, obj[collateralREMNo].mcreatedby,obj[collateralREMNo].mrefno)
              .then((CollateralREMlandandhouseBean collateralREMlandandhouseBean) async {
            bool isSyncingFirstTime = false;
            String updateCollateralREMQuery = null;

             try {
            if (obj[collateralREMNo] != null &&
                obj[collateralREMNo].mrefno != null &&
                collateralREMlandandhouseBean != null &&
                collateralREMlandandhouseBean.mrefno == null ||
                collateralREMlandandhouseBean.mrefno == 0) {



              isSyncingFirstTime = true;
              updateCollateralREMQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' , ${TablesColumnFile.mrefno} = ${obj[collateralREMNo]
                  .mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[collateralREMNo]
                  .trefno}";
            } else {

              updateCollateralREMQuery =
              "${TablesColumnFile.mlastupdatedt} = '${DateTime
                  .now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[collateralREMNo]
                  .mrefno} AND ${TablesColumnFile.trefno} = ${obj[collateralREMNo]
                  .trefno}";
            }

            if (updateCollateralREMQuery != null) {
              await AppDatabase.get()
                  .updateCollateralREMMasterAfterSync(updateCollateralREMQuery);
            }

            } catch (_) {
               await AppDatabase.get()
                   .updateCollateralREMMasterAfterSync(updateCollateralREMQuery);
             }
          });
        }
        AppDatabase.get().updateStaticTablesLastSyncedMaster(17);
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }


  Future<Null> getAndSync() async {

    try {
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(17, false)
        .then((returnedCollateralVehicleDateTime) async {
      await AppDatabase.get()
          .selectCollateralREMListNotSynced(returnedCollateralVehicleDateTime)
          .then((List<CollateralREMlandandhouseBean> collateralREMlandandhouseBean) async {

        for (int i = 0; i < collateralREMlandandhouseBean.length; i++) {
          _toListJson(collateralREMlandandhouseBean[i]);
        }
        String json = JSON.encode(collateralVehicleList);

        _serviceUrl = "collateralRemData/add/";
        await syncCollateralRem(json);

      });
    });

    } catch (e) {
      print('Server Exception!!!');
    }
  }






  Future<String> _toListJson(CollateralREMlandandhouseBean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.msrno] = 	  bean.msrno==null?0:bean.msrno;
    mapData[TablesColumnFile.trefno] =	bean.trefno==null?0:bean.trefno;
    mapData[TablesColumnFile.mrefno] =	bean.mrefno==null?0:bean.mrefno;
    mapData[TablesColumnFile.mlbrcode] =	bean.mlbrcode==null?0:bean.mlbrcode;
    mapData[TablesColumnFile.mprdacctid] =	ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.loantrefno] = 	  bean.mloantrefno==null?0:bean.mloantrefno;
    mapData[TablesColumnFile.loanmrefno] = 	  bean.mloanmrefno==null?0:bean.mloanmrefno;
    mapData[TablesColumnFile.colleteraltrefno] = 	  bean.colleteraltrefno==null?0:bean.colleteraltrefno;
    mapData[TablesColumnFile.colleteralmrefno] = 	  bean.colleteralmrefno==null?0:bean.colleteralmrefno;
    mapData[TablesColumnFile.mtitle] =	ifNullCheck(bean.mtitle);
    mapData[TablesColumnFile.mfname] =	ifNullCheck(bean.mfname);
    mapData[TablesColumnFile.mmname] =	ifNullCheck(bean.mmname);
    mapData[TablesColumnFile.mlname] =	ifNullCheck(bean.mlname);
    mapData[TablesColumnFile.maddress1] =	ifNullCheck(bean.maddress1);
    mapData[TablesColumnFile.maddress2] =	ifNullCheck(bean.maddress2);
    mapData[TablesColumnFile.mcountry] =	ifNullCheck(bean.mcountry);
    mapData[TablesColumnFile.mstate] =	ifNullCheck(bean.mstate);
    mapData[TablesColumnFile.mdist] =	ifNullCheck(bean.mdist);
    mapData[TablesColumnFile.msubdist] =	ifNullCheck(bean.msubdist);
    mapData[TablesColumnFile.marea] =	ifNullCheck(bean.marea);
    mapData[TablesColumnFile.mpoboxno] =	bean.mpoboxno==null?0:bean.mpoboxno;
    mapData[TablesColumnFile.mhousebuilttype] =	ifNullCheck(bean.mhousebuilttype);
    mapData[TablesColumnFile.menvdescription] =	ifNullCheck(bean.menvdescription);
    mapData[TablesColumnFile.mlotarea] =	bean.mlotarea==null?0:bean.mlotarea;
    mapData[TablesColumnFile.mfloorarea] =	bean.mfloorarea==null?0:bean.mfloorarea;
    mapData[TablesColumnFile.mdescofproperty] =	ifNullCheck(bean.mdescofproperty);
    mapData[TablesColumnFile.msizeofproperty] =	ifNullCheck(bean.msizeofproperty);
    mapData[TablesColumnFile.msizeofpropertyl] =	ifNullCheck(bean.msizeofpropertyl);
    mapData[TablesColumnFile.msizeofpropertyh] =	ifNullCheck(bean.msizeofpropertyh);
    mapData[TablesColumnFile.mtctno] =	bean.mtctno==null?0:bean.mtctno;
    mapData[TablesColumnFile.msrno] =	bean.msrno==null?0:bean.msrno;
    mapData[TablesColumnFile.mregdate] =	ifDateNullCheck(bean.mregdate);
    mapData[TablesColumnFile.mepebdate] =	ifDateNullCheck(bean.mepebdate);
    mapData[TablesColumnFile.mrescodeorremark] =	ifNullCheck(bean.mrescodeorremark);
    mapData[TablesColumnFile.mepebno] =bean.mepebno==null?0:bean.mepebno;
    mapData[TablesColumnFile.mregofdeedslocation] = ifNullCheck(bean.mregofdeedslocation);
    mapData[TablesColumnFile.mcreateddt] =	ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] =	ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =	ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] =	ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] =	ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] =	ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] =	ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.mlastsynsdate] =	ifDateNullCheck(bean.mlastsynsdate);
    mapData[TablesColumnFile.merrormessage] =	ifNullCheck(bean.merrormessage);
    mapData[TablesColumnFile.missynctocoresys] =	bean.missynctocoresys==null?0:bean.missynctocoresys;
    mapData[TablesColumnFile.mcollno] =	bean.mcollno==null?0:bean.mcollno;
    mapData[TablesColumnFile.mpriorsec] =	ifNullCheck(bean.mpriorsec);
    mapData[TablesColumnFile.mcolltype] =	ifNullCheck(bean.mcolltype);
    mapData[TablesColumnFile.mcollsubtype] =	ifNullCheck(bean.mcollsubtype);
    mapData[TablesColumnFile.mtypeofproperty] =	ifNullCheck(bean.mtypeofproperty);
    mapData[TablesColumnFile.mltypeofownercerti] =	ifNullCheck(bean.mltypeofownercerti);
    mapData[TablesColumnFile.mhtypeofownercerti] =	ifNullCheck(bean.mhtypeofownercerti);
    mapData[TablesColumnFile.mlissuednoprop] =	ifNullCheck(bean.mlissuednoprop);
    mapData[TablesColumnFile.mhissuednoprop] =	ifNullCheck(bean.mhissuednoprop);
    mapData[TablesColumnFile.mlissueby] =	ifNullCheck(bean.mlissueby);
    mapData[TablesColumnFile.mhissueby] =	ifNullCheck(bean.mhissueby);
    mapData[TablesColumnFile.mlsizeprop] =	ifNullCheck(bean.mlsizeprop);
    mapData[TablesColumnFile.mhsizeprop] =	ifNullCheck(bean.mhsizeprop);
    mapData[TablesColumnFile.mlnpropborder] =	ifNullCheck(bean.mlnpropborder);
    mapData[TablesColumnFile.mhnpropborder] =	ifNullCheck(bean.mhnpropborder);
    mapData[TablesColumnFile.mlspropborder] =	ifNullCheck(bean.mlspropborder);
    mapData[TablesColumnFile.mhspropborder] =	ifNullCheck(bean.mhspropborder);
    mapData[TablesColumnFile.mlwpropborder] =	ifNullCheck(bean.mlwpropborder);
    mapData[TablesColumnFile.mhwpropborder] =	ifNullCheck(bean.mhwpropborder);
    mapData[TablesColumnFile.mlepropborder] =	ifNullCheck(bean.mlepropborder);
    mapData[TablesColumnFile.mhepropborder] =	ifNullCheck(bean.mhepropborder);
    mapData[TablesColumnFile.mllocprop] =	ifNullCheck(bean.mllocprop);
    mapData[TablesColumnFile.mhlocprop] =	ifNullCheck(bean.mhlocprop);
    mapData[TablesColumnFile.mltitleowener] =	ifNullCheck(bean.mltitleowener);
    mapData[TablesColumnFile.mhtitleowener] =	ifNullCheck(bean.mhtitleowener);
    mapData[TablesColumnFile.mllocalauthvalue] =	bean.mllocalauthvalue==null?0:bean.mllocalauthvalue;
    mapData[TablesColumnFile.mhlocalauthvalue] =	bean.mhlocalauthvalue==null?0:bean.mhlocalauthvalue;
    mapData[TablesColumnFile.mlrealestatecmpnyvalue] =	bean.mlrealestatecmpnyvalue==null?0:bean.mlrealestatecmpnyvalue;
    mapData[TablesColumnFile.mhrealestatecmpnyvalue] =bean.mhrealestatecmpnyvalue==null?0:bean.mhrealestatecmpnyvalue;
    mapData[TablesColumnFile.mlaskneighonvalue] =	bean.mlaskneighonvalue==null?0:bean.mlaskneighonvalue;
    mapData[TablesColumnFile.mhaskneighonvalue] =	bean.mhaskneighonvalue==null?0:bean.mhaskneighonvalue;
    mapData[TablesColumnFile.mlsumonvalprop] =	bean.mlsumonvalprop==null?0:bean.mlsumonvalprop;
    mapData[TablesColumnFile.mhsumonvalprop] =	bean.mhsumonvalprop==null?0:bean.mhsumonvalprop;
    mapData[TablesColumnFile.mlissuedt] =	ifDateNullCheck(bean.mlissuedt);
    mapData[TablesColumnFile.mhissuedt] =	ifDateNullCheck(bean.mhissuedt);


    collateralVehicleList.add(mapData);
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
