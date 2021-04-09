import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

import 'CollatralVehicle/CollateralVehicleBean.dart';

class SyncingCollateralVehicleToMiddleware {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List collateralVehicleList = List();

  Future<Null> syncCollateralVehicle(String jsonList) async {
    try {
      String bodyValue = await NetworkUtil.callPostService(jsonList,
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());
      if (bodyValue == '404') {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CollateralVehicleBean> obj = parsed
            .map<CollateralVehicleBean>(
                (json) => CollateralVehicleBean.fromMapMiddleware(json))
            .toList();

        for (int collateralVehicleNo = 0;
            collateralVehicleNo < obj.length;
            collateralVehicleNo++) {
          await AppDatabase.get()
              .selectCollateralVehicleOnTrefANDMrefno(
                  obj[collateralVehicleNo].trefno,
                  obj[collateralVehicleNo].mcreatedby,
                  obj[collateralVehicleNo].mrefno)
              .then((CollateralVehicleBean collateralVehicleBean) async {
            String updateCollateralVehicleQuery = null;

            try {
              if (obj[collateralVehicleNo] != null &&
                      obj[collateralVehicleNo].mrefno != null &&
                      collateralVehicleBean != null &&
                      collateralVehicleBean.mrefno == null ||
                  collateralVehicleBean.mrefno == 0) {
                print("1 st vali koshish");
                updateCollateralVehicleQuery =
                    "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' , ${TablesColumnFile.mrefno} = ${obj[collateralVehicleNo].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[collateralVehicleNo].trefno}";
              } else {
                print("2nd st vali koshish");
                updateCollateralVehicleQuery =
                    "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' WHERE ${TablesColumnFile.mrefno} = ${obj[collateralVehicleNo].mrefno} AND ${TablesColumnFile.trefno} = ${obj[collateralVehicleNo].trefno}";
              }

              if (updateCollateralVehicleQuery != null) {
                await AppDatabase.get().updateCollateralVehicleMasterAfterSync(
                    updateCollateralVehicleQuery);
              }
            } catch (_) {}
          });
        }

        AppDatabase.get().updateStaticTablesLastSyncedMaster(14);
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  Future<Null> getAndSync() async {
    try {
      await AppDatabase.get()
          .selectStaticTablesLastSyncedMaster(14, false)
          .then((returnedCollateralVehicleDateTime) async {
        await AppDatabase.get()
            .selectCollateralVehicleListNotSynced(
                returnedCollateralVehicleDateTime)
            .then((List<CollateralVehicleBean> collateralVehicleBean) async {
          for (int i = 0; i < collateralVehicleBean.length; i++) {
            _toListJson(collateralVehicleBean[i]);
          }
          String json = JSON.encode(collateralVehicleList);
          /* for (var items in json.toString().split(",")) {
          print("Json values for cgt1 " + items.toString());
        }*/
          _serviceUrl = "collateralVehicleData/add/";
          await syncCollateralVehicle(json);
        });
      });
    } catch (e) {
      print('Server Exception!!!');
    }
  }

  Future<String> _toListJson(CollateralVehicleBean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.msrno] = bean.msrno == null ? 0 : bean.msrno;
    mapData[TablesColumnFile.mlbrcode] =
        bean.mlbrcode == null ? 0 : bean.mlbrcode;
    mapData[TablesColumnFile.mprdacctid] = ifNullCheck(bean.mprdacctid);
    mapData[TablesColumnFile.msectype] = ifNullCheck(bean.msectype);
    mapData[TablesColumnFile.trefno] = bean.trefno == null ? 0 : bean.trefno;
    mapData[TablesColumnFile.mrefno] = bean.mrefno == null ? 0 : bean.mrefno;
    mapData[TablesColumnFile.loantrefno] =
        bean.mloantrefno == null ? 0 : bean.mloantrefno;
    mapData[TablesColumnFile.loanmrefno] =
        bean.mloanmrefno == null ? 0 : bean.mloanmrefno;
    mapData[TablesColumnFile.colleteraltrefno] =
        bean.colleteraltrefno == null ? 0 : bean.colleteraltrefno;
    mapData[TablesColumnFile.colleteralmrefno] =
        bean.colleteralmrefno == null ? 0 : bean.colleteralmrefno;
    mapData[TablesColumnFile.mbusinessname] = ifNullCheck(bean.mbusinessname);
    mapData[TablesColumnFile.mownername] = ifNullCheck(bean.mownername);
    mapData[TablesColumnFile.mtel] = ifNullCheck(bean.mtel);
    mapData[TablesColumnFile.maddress1] = ifNullCheck(bean.maddress1);
    mapData[TablesColumnFile.maddress2] = ifNullCheck(bean.maddress2);
    mapData[TablesColumnFile.mcountrycd] = ifNullCheck(bean.mcountry);
    mapData[TablesColumnFile.mstate] = ifNullCheck(bean.mstate);
    mapData[TablesColumnFile.mdistcd] = ifNullCheck(bean.mdist);
    mapData[TablesColumnFile.msubdist] = ifNullCheck(bean.msubdist);
    mapData[TablesColumnFile.mareatype] = ifNullCheck(bean.marea);
    mapData[TablesColumnFile.mvillage] = ifNullCheck(bean.mvillage);
    mapData[TablesColumnFile.mbrand] = ifNullCheck(bean.mbrand);
    mapData[TablesColumnFile.mnoofaxles] =
        bean.mnoofaxles == null ? 0 : bean.mnoofaxles;
    mapData[TablesColumnFile.mtype] = ifNullCheck(bean.mtype);
    mapData[TablesColumnFile.mnoofcylinder] =
        bean.mnoofcylinder == null ? 0 : bean.mnoofcylinder;
    mapData[TablesColumnFile.mcolor] = ifNullCheck(bean.mcolor);
    mapData[TablesColumnFile.msizeofcylinder] =
        bean.msizeofcylinder == null ? 0 : bean.msizeofcylinder;
    mapData[TablesColumnFile.mbodyno] = ifNullCheck(bean.mbodyno);
    mapData[TablesColumnFile.menginepower] =
        bean.menginepower == null ? 0 : bean.menginepower;
    mapData[TablesColumnFile.mengineno] = ifNullCheck(bean.mengineno);
    mapData[TablesColumnFile.myearmade] =
        bean.myearmade == null ? 0 : bean.myearmade;
    mapData[TablesColumnFile.mchassisno] = ifNullCheck(bean.mchassisno);
    mapData[TablesColumnFile.mmadeby] = ifNullCheck(bean.mmadeby);
    mapData[TablesColumnFile.midentitycarno] = ifNullCheck(bean.midentitycarno);
    mapData[TablesColumnFile.mcarpricing] =
        bean.mcarpricing == null ? 0.0 : bean.mcarpricing;
    mapData[TablesColumnFile.mstdpricing] =
        bean.mstdpricing == null ? 0 : bean.mstdpricing;
    mapData[TablesColumnFile.minsurancepricing] =
        bean.minsurancepricing == null ? 0 : bean.minsurancepricing;
    mapData[TablesColumnFile.mpriceafterevaluation] =
        bean.mpriceafterevaluation == null ? 0 : bean.mpriceafterevaluation;
    mapData[TablesColumnFile.mltv] = bean.mltv == null ? 0 : bean.mltv;
    mapData[TablesColumnFile.mltvdd] = ifNullCheck(bean.mltvdd);
    mapData[TablesColumnFile.mcartype] = ifNullCheck(bean.mcartype);
    mapData[TablesColumnFile.mloantovalueltv] =
        ifNullCheck(bean.mloantovalueltv);
    mapData[TablesColumnFile.mwhobelongocarowner] =
        ifNullCheck(bean.mwhobelongocarowner);
    mapData[TablesColumnFile.mcarlegality] =
        bean.mcarlegality == null ? 0 : bean.mcarlegality;
    mapData[TablesColumnFile.mreason] = ifNullCheck(bean.mreason);
    mapData[TablesColumnFile.mdescription] = ifNullCheck(bean.mdescription);
    mapData[TablesColumnFile.mcarcanbeused] = ifNullCheck(bean.mcarcanbeused);
    mapData[TablesColumnFile.mcredittenor] = ifNullCheck(bean.mcredittenor);
    mapData[TablesColumnFile.mdmirror] = ifNullCheck(bean.mdmirror);
    mapData[TablesColumnFile.mddoor] = ifNullCheck(bean.mddoor);
    mapData[TablesColumnFile.mdmirrorbacklock] =
        ifNullCheck(bean.mdmirrorbacklock);
    mapData[TablesColumnFile.mdcolororspot] = ifNullCheck(bean.mdcolororspot);
    mapData[TablesColumnFile.mfcolorandspot] = ifNullCheck(bean.mfcolorandspot);
    mapData[TablesColumnFile.mftireandyan] = ifNullCheck(bean.mftireandyan);
    mapData[TablesColumnFile.mfcapofsplatter] =
        ifNullCheck(bean.mfcapofsplatter);
    mapData[TablesColumnFile.mhmirror] = ifNullCheck(bean.mhmirror);
    mapData[TablesColumnFile.mhvent] = ifNullCheck(bean.mhvent);
    mapData[TablesColumnFile.mhlightfarl] = ifNullCheck(bean.mhlightfarl);
    mapData[TablesColumnFile.mhlightfarr] = ifNullCheck(bean.mhlightfarr);
    mapData[TablesColumnFile.mhsignal] = ifNullCheck(bean.mhsignal);
    mapData[TablesColumnFile.mhwincap] = ifNullCheck(bean.mhwincap);
    mapData[TablesColumnFile.mhheadcap] = ifNullCheck(bean.mhheadcap);
    mapData[TablesColumnFile.mpmirror] = ifNullCheck(bean.mpmirror);
    mapData[TablesColumnFile.mpdoor] = ifNullCheck(bean.mpdoor);
    mapData[TablesColumnFile.mpbackmirror] = ifNullCheck(bean.mpbackmirror);
    mapData[TablesColumnFile.mpcolororspot] = ifNullCheck(bean.mpcolororspot);
    mapData[TablesColumnFile.mftcolorandspot] =
        ifNullCheck(bean.mftcolorandspot);
    mapData[TablesColumnFile.mfttanandyan] = ifNullCheck(bean.mfttanandyan);
    mapData[TablesColumnFile.mftcap] = ifNullCheck(bean.mftcap);
    mapData[TablesColumnFile.mftsplattercap] = ifNullCheck(bean.mftsplattercap);
    mapData[TablesColumnFile.mbpmirror] = ifNullCheck(bean.mbpmirror);
    mapData[TablesColumnFile.mbpdoor] = ifNullCheck(bean.mbpdoor);
    mapData[TablesColumnFile.mbpcolorandspot] =
        ifNullCheck(bean.mbpcolorandspot);
    mapData[TablesColumnFile.mbtcolorandsport] =
        ifNullCheck(bean.mbtcolorandsport);
    mapData[TablesColumnFile.mbttanandyan] = ifNullCheck(bean.mbttanandyan);
    mapData[TablesColumnFile.mbtcap] = ifNullCheck(bean.mbtcap);
    mapData[TablesColumnFile.mbcbacklightr] = ifNullCheck(bean.mbcbacklightr);
    mapData[TablesColumnFile.mbcturnsignal] = ifNullCheck(bean.mbcturnsignal);
    mapData[TablesColumnFile.mbcmessagesignal] =
        ifNullCheck(bean.mbcmessagesignal);
    mapData[TablesColumnFile.mbcsignal] = ifNullCheck(bean.mbcsignal);
    mapData[TablesColumnFile.mbcbacklightl] = ifNullCheck(bean.mbcbacklightl);
    mapData[TablesColumnFile.mbcbackdoor] = ifNullCheck(bean.mbcbackdoor);
    mapData[TablesColumnFile.mbccranes] = ifNullCheck(bean.mbccranes);
    mapData[TablesColumnFile.mbctakelock] = ifNullCheck(bean.mbctakelock);
    mapData[TablesColumnFile.mbcholdlock] = ifNullCheck(bean.mbcholdlock);
    mapData[TablesColumnFile.mbchandcranes] = ifNullCheck(bean.mbchandcranes);
    mapData[TablesColumnFile.mbcreservetire] =
        bean.mbcreservetire == null ? 0 : bean.mbcreservetire;
    mapData[TablesColumnFile.mbcbackmirror] =
        bean.mbcbackmirror == null ? 0 : bean.mbcbackmirror;
    mapData[TablesColumnFile.mbcantenna] = ifNullCheck(bean.mbcantenna);
    mapData[TablesColumnFile.mbtlcolororspot] =
        ifNullCheck(bean.mbtlcolororspot);
    mapData[TablesColumnFile.mbtltanandyan] = ifNullCheck(bean.mbtltanandyan);
    mapData[TablesColumnFile.mbtlcap] = ifNullCheck(bean.mbtlcap);
    mapData[TablesColumnFile.mbtlsplattercap] =
        ifNullCheck(bean.mbtlsplattercap);
    mapData[TablesColumnFile.mbtrcolororspot] =
        ifNullCheck(bean.mbtrcolororspot);
    mapData[TablesColumnFile.mbtrtireandyan] = ifNullCheck(bean.mbtrtireandyan);
    mapData[TablesColumnFile.mbtrcap] = ifNullCheck(bean.mbtrcap);
    mapData[TablesColumnFile.mbtrsplattercap] =
        ifNullCheck(bean.mbtrsplattercap);
    mapData[TablesColumnFile.mibarsun] = ifNullCheck(bean.mibarsun);
    mapData[TablesColumnFile.midescriptionbook] =
        ifNullCheck(bean.midescriptionbook);
    mapData[TablesColumnFile.miautosystem] = ifNullCheck(bean.miautosystem);
    mapData[TablesColumnFile.miairconditioner] =
        ifNullCheck(bean.miairconditioner);
    mapData[TablesColumnFile.mimirrorremote] = ifNullCheck(bean.mimirrorremote);
    mapData[TablesColumnFile.misafebell] = ifNullCheck(bean.misafebell);
    mapData[TablesColumnFile.mimiddlebox] = ifNullCheck(bean.mimiddlebox);
    mapData[TablesColumnFile.mregdate] = ifDateNullCheck(bean.mregdate);
    mapData[TablesColumnFile.mregexpdate] = ifDateNullCheck(bean.mregexpdate);
    mapData[TablesColumnFile.mcreateddt] = ifDateNullCheck(bean.mcreateddt);
    mapData[TablesColumnFile.mcreatedby] = ifNullCheck(bean.mcreatedby);
    mapData[TablesColumnFile.mlastupdatedt] =
        ifDateNullCheck(bean.mlastupdatedt);
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.mgeolocation] = ifNullCheck(bean.mgeolocation);
    mapData[TablesColumnFile.mgeolatd] = ifNullCheck(bean.mgeolatd);
    mapData[TablesColumnFile.mgeologd] = ifNullCheck(bean.mgeologd);
    mapData[TablesColumnFile.missynctocoresys] =
        bean.missynctocoresys == null ? 0 : bean.missynctocoresys;
    mapData[TablesColumnFile.mlastsynsdate] =
        ifDateNullCheck(bean.mlastsynsdate);

    collateralVehicleList.add(mapData);
    return mapData.toString();
  }

  String ifDateNullCheck(DateTime value) {
    if (value == null || value == 'null') {
      return "";
    } else {
      return value.toIso8601String();
    }
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }
}
