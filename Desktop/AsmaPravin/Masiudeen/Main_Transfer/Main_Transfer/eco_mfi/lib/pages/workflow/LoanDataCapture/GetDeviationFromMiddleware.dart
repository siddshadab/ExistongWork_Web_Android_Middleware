import 'dart:convert';


import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';





class GetDeviationFromMiddleware{

  String timestamp() =>
      DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCPVDetails ="deviationForm/getDeviationByCreatedByAndLastSyncedTiming";
  static const JsonCodec JSON = const JsonCodec();
  DeviationFormBean deviationFormBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      await getDeivationFromMiddlewareData(userName, urlGetCPVDetails);
    }
  }

  Future<Null> getDeivationFromMiddlewareData(String userName, String url) async {

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(19, true)
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
        List<DeviationFormBean> obj = parsed
            .map<DeviationFormBean>(
                (json) => DeviationFormBean.fromMapMiddleware(json))
            .toList();

        for (int deviation = 0; deviation < obj.length; deviation++) {
          await AppDatabase.get()
              .updateDeviationFormMaster(obj[deviation])
              .then((onValue) {
          });
          print("Deviation Update Complete");
        }

        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(19, updateDateimeAfterUpdate);

        await AppDatabase.get()
            .selectStaticTablesLastSyncedMaster(19, false)
            .then((onValue) async {
          if (onValue == null) {
            AppDatabase.get().updateStaticTablesLastSyncedMaster(19);
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
