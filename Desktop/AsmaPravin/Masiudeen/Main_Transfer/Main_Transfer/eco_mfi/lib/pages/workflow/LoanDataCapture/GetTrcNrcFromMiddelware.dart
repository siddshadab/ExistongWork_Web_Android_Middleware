import 'dart:convert';


import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';



class GetTrcNrcFromMiddelware{

  String timestamp() =>
      DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCPVDetails ="tradeAndNeighbourRefCheck/getTrcNrcByCreatedByAndLastSyncedTiming";
  static const JsonCodec JSON = const JsonCodec();
  TradeAndNeighbourRefCheckBean TrcNrcBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      await getTrcNrcMiddlewareData(userName, urlGetCPVDetails);
    }
  }

  Future<Null> getTrcNrcMiddlewareData(String userName, String url) async {

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(17, true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName, onValue);
      print(json);
    });

    try {
      String bodyValue = await NetworkUtil.callPostService(
          json.toString(),
          Constant.apiURL.toString() + url.toString(), _headers);

      print("url " + Constant.apiURL.toString() + url.toString());

      if (bodyValue == "404") {
        return null;
      } else {
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        DateTime updateDateimeAfterUpdate = DateTime.now();
        List<TradeAndNeighbourRefCheckBean> obj = parsed
            .map<TradeAndNeighbourRefCheckBean>(
                (json) => TradeAndNeighbourRefCheckBean.fromMapMiddleware(json))
            .toList();

        for (int TrcNrc = 0; TrcNrc < obj.length; TrcNrc++) {
          await AppDatabase.get()
              .updateTradeNeighbourRefCheckMaster(obj[TrcNrc])
              .then((onValue) {
          });
          print("Trc Nrc Update Complete");
        }

        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(17, updateDateimeAfterUpdate);

        await AppDatabase.get()
            .selectStaticTablesLastSyncedMaster(17, false)
            .then((onValue) async {
          if (onValue == null) {
            AppDatabase.get().updateStaticTablesLastSyncedMaster(17);
          }
        });
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }
  String _toJsonOfCreatedByAndLastSyncedDateTime(String createdBy,DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = createdBy.trim();
    mapData["mlastsynsdate"] =  lastsyncedDateTime != null && lastsyncedDateTime != 'null' &&
        lastsyncedDateTime != ''
        ? lastsyncedDateTime.toIso8601String()
        : null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }
}
