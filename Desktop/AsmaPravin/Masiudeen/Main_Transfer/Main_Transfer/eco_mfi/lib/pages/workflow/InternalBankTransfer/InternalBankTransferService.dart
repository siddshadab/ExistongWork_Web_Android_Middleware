import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/InternalBankTransferBean.dart';
import 'package:eco_mfi/db/AppDatabaseExtended.dart';
import 'package:eco_mfi/db/AppDatabase.dart';

class InternalBankTransferService {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlPostTransaction = "internalBankTransfer/doTransaction";

  var urlSubmitInternalBankTransfer = "/internalBankTransfer/add";
  String ackUrl = "internalBankTransfer/updateSyncFromServer/";
  static const JsonCodec JSON = const JsonCodec();
  List listInternalBankTransfer = List();
  List mrefNoList = new List();

  Future<String> getJson(
      InternalBankTransferBean internalBanktransferBean) async {
    Map map = new Map();

    map[TablesColumnFile.mcashtr] = internalBanktransferBean.mcashtr;
    map[TablesColumnFile.mcrdr] = ifNullCheck(internalBanktransferBean.mcrdr);
    map[TablesColumnFile.mremark] =
        ifNullCheck(internalBanktransferBean.mremark);
    map[TablesColumnFile.mnarration] =
        ifNullCheck(internalBanktransferBean.mnarration);
    map[TablesColumnFile.mamt] = internalBanktransferBean.mamt;
    map[TablesColumnFile.maccid] = ifNullCheck(internalBanktransferBean.maccid);
    map[TablesColumnFile.mdraccid] =
        ifNullCheck(internalBanktransferBean.mdraccid);
    map[TablesColumnFile.mcraccid] =
        ifNullCheck(internalBanktransferBean.mcraccid);
    map[TablesColumnFile.mlbrcode] = internalBanktransferBean.mlbrcode;
    map[TablesColumnFile.mcreatedby] =
        ifNullCheck(internalBanktransferBean.mcreatedby);
    String returnigJson = await JSON.encode(map);
    return returnigJson;
  }

  String ifNullCheck(String param) {
    if (param == null || param.trim() == 'null')
      return "";
    else
      return param;
  }

  Future<InternalBankTransferBean> postInternalBanktransfer(
      InternalBankTransferBean internalBanktransferBean) async {
    String json;

    json = await getJson(internalBanktransferBean);

    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + urlPostTransaction, _headers);
    print("url " + Constant.apiURL.toString() + urlPostTransaction);
    if (bodyValue == "404" || bodyValue == null) {
      return null;
    } else {
      Map<String, dynamic> map = JSON.decode(bodyValue);

      InternalBankTransferBean obj =
          InternalBankTransferBean.fromMapMiddleware(map);

      return obj;
    }
  }

  Future<InternalBankTransferBean> postOfflineInternalBanktransfer() async {
    String json;

    await AppDatabaseExtended.get()
        .getInternalTransactionsNotSynced()
        .then((List<InternalBankTransferBean> internalBankTransferList) {
      for (InternalBankTransferBean items in internalBankTransferList) {
        getListJson(items);
      }
    });
    json = JSON.encode(listInternalBankTransfer);
    print("Sending json is ${json}");

    String bodyValue = await NetworkUtil.callPostService(json.toString(),
        Constant.apiURL.toString() + urlSubmitInternalBankTransfer, _headers);

    if (bodyValue == "404" || bodyValue == null) {
      return null;
    } else {
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();

      List<InternalBankTransferBean> obj = parsed
          .map<InternalBankTransferBean>(
              (json) => InternalBankTransferBean.fromMap(json))
          .toList();

      for (int grntr = 0; grntr < obj.length; grntr++) {
        await AppDatabaseExtended.get()
            .selectInterTransferBean(obj[grntr].trefno, obj[grntr].mrefno)
            .then((InternalBankTransferBean interBankTransferBean) async {
          if (obj[grntr] != null &&
                  obj[grntr].mrefno != null &&
                  interBankTransferBean.mrefno == null ||
              interBankTransferBean.mrefno == 0) {
            String updateInternalTransactionquery = "";
            updateInternalTransactionquery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}',${TablesColumnFile.missynctocoresys} = 1  , ${TablesColumnFile.mrefno} = ${obj[grntr].mrefno} WHERE ${TablesColumnFile.trefno} = ${obj[grntr].trefno} ";

            if (updateInternalTransactionquery != null) {
              await AppDatabaseExtended.get()
                  .updateInterBankTransferTable(updateInternalTransactionquery);
            }
          } else {
            String updateInternalTransactionquery = "";
            updateInternalTransactionquery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' ,${TablesColumnFile.missynctocoresys} = 1  WHERE ${TablesColumnFile.mrefno} = ${obj[grntr].mrefno} AND ${TablesColumnFile.trefno} = ${obj[grntr].trefno}";

            if (updateInternalTransactionquery != null) {
              await AppDatabaseExtended.get()
                  .updateInterBankTransferTable(updateInternalTransactionquery);
            }
          }
        });
      }
      AppDatabase.get().updateStaticTablesLastSyncedMaster(23);
    }
  }

  Future<String> getListJson(
      InternalBankTransferBean internalBanktransferBean) async {
    Map map = new Map();
    map[TablesColumnFile.trefno] = internalBanktransferBean.trefno != null
        ? internalBanktransferBean.trefno
        : 0;
    map[TablesColumnFile.mrefno] = internalBanktransferBean.mrefno != null
        ? internalBanktransferBean.mrefno
        : 0;

    map[TablesColumnFile.mcashtr] = internalBanktransferBean.mcashtr;
    map[TablesColumnFile.mcrdr] = ifNullCheck(internalBanktransferBean.mcrdr);
    map[TablesColumnFile.mremark] =
        ifNullCheck(internalBanktransferBean.mremark);
    map[TablesColumnFile.mnarration] =
        ifNullCheck(internalBanktransferBean.mnarration);
    map[TablesColumnFile.mamt] = internalBanktransferBean.mamt;
    map[TablesColumnFile.maccid] = ifNullCheck(internalBanktransferBean.maccid);
    map[TablesColumnFile.mdraccid] =
        ifNullCheck(internalBanktransferBean.mdraccid);
    map[TablesColumnFile.mcraccid] =
        ifNullCheck(internalBanktransferBean.mcraccid);
    map[TablesColumnFile.mlbrcode] = internalBanktransferBean.mlbrcode;
    map[TablesColumnFile.mcreatedby] =
        ifNullCheck(internalBanktransferBean.mcreatedby);
    map[TablesColumnFile.mlastupdateby] =
        ifNullCheck(internalBanktransferBean.mlastupdateby);
    map[TablesColumnFile.mgeolatd] =
        ifNullCheck(internalBanktransferBean.mgeolatd);
    map[TablesColumnFile.mgeologd] =
        ifNullCheck(internalBanktransferBean.mgeologd);
    map[TablesColumnFile.mgeolocation] =
        ifNullCheck(internalBanktransferBean.mgeolocation);
    map[TablesColumnFile.mgeologd] =
        ifNullCheck(internalBanktransferBean.mgeologd);  
     map[TablesColumnFile.mcreateddt] =
        internalBanktransferBean.mcreateddt != null
        ? internalBanktransferBean.mcreateddt.toIso8601String()
        : null;       
    map[TablesColumnFile.mlastupdatedt] =
        internalBanktransferBean.mlastupdatedt != null
        ? internalBanktransferBean.mlastupdatedt.toIso8601String()
        : null;  

    map[TablesColumnFile.missyncfromcoresys] = 1;


    listInternalBankTransfer.add(map);
  }

  Future<Null> tryGettingMiddlewareData(String userName) async {
    bool isNetworkAvailable;
    String urlGetInternalBankTransfer = "/internalBankTransfer//getInternalBankTransferResponse/";

    isNetworkAvailable = await Utility.checkIntCon();

    if (isNetworkAvailable) {
      await getMiddleWareData(userName, urlGetInternalBankTransfer);
    }
  }

  Future<Null> getMiddleWareData(String userName, String url) async {
    List<InternalBankTransferBean> getInternalBankTransferBean;

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(28, true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName, onValue);
    });
    try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + url.toString(), _headers);
      print("url " + Constant.apiURL.toString() + url.toString());
      if (bodyValue == "404") {
        return null;
      } else {
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        DateTime updateDateimeAfterUpdate = DateTime.now();
        List<InternalBankTransferBean> obj = parsed
            .map<InternalBankTransferBean>(
                (json) => InternalBankTransferBean.fromMapMiddleware(json))
            .toList();

        for (int cust = 0; cust < obj.length; cust++) {
          try {
            try {
              if (obj[cust].missynctocoresys == 0) {
                obj[cust].missynctocoresys = 1;
              }
            } catch (_) {}
            await AppDatabase.get()
                .updateInternalTransactionMaster(obj[cust])
                .then((onValue) {
              // customerNumberValue = onValue;
            });
            mrefNoList.add(obj[cust].mrefno);
          } catch (_) {}
        }

        await AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(
            28, updateDateimeAfterUpdate);

        if (mrefNoList.isNotEmpty) {
          var mapData = new Map();
          mapData[TablesColumnFile.mrefnolist] = mrefNoList;

          String ackJson = await JSON.encode(mapData);
          print("again sending json is ${ackJson}");
          await NetworkUtil.callPostService(ackJson.toString(),
              Constant.apiURL.toString() + ackUrl.toString(), _headers);
        }
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }

  String _toJsonOfCreatedByAndLastSyncedDateTime(
      String createdBy, DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = createdBy.trim();
    mapData["mlastsynsdate"] = lastsyncedDateTime != null &&
            lastsyncedDateTime != 'null' &&
            lastsyncedDateTime != ''
        ? lastsyncedDateTime.toIso8601String()
        : null;
    String json = JSON.encode(mapData);
    return json;
  }
}
