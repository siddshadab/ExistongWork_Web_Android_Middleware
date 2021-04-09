import 'dart:convert';


import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';

import 'bean/SocialAndEnvironmentalBean.dart';



class GetSocialEnvironmentFromMiddleware{

  String timestamp() =>
      DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCPVDetails ="socialAndEnvironmental/getSocialEnvironmentCreatedByAndLastSyncedTiming";
  static const JsonCodec JSON = const JsonCodec();
  SocialAndEnvironmentalBean socialEnvironmentBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      await getSocialEnvironmentMiddlewareData(userName, urlGetCPVDetails);
    }
  }

  Future<Null> getSocialEnvironmentMiddlewareData(String userName, String url) async {

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(18, true)
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
        List<SocialAndEnvironmentalBean> obj = parsed
            .map<SocialAndEnvironmentalBean>(
                (json) => SocialAndEnvironmentalBean.fromMapMiddleware(json))
            .toList();

        for (int socialEnv = 0; socialEnv < obj.length; socialEnv++) {
          await AppDatabase.get()
              .updateSocialEnvironmentMaster(obj[socialEnv])
              .then((onValue) {
          });
          print("Trc Nrc Update Complete");
        }

        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(18, updateDateimeAfterUpdate);

        await AppDatabase.get()
            .selectStaticTablesLastSyncedMaster(18, false)
            .then((onValue) async {
          if (onValue == null) {
            AppDatabase.get().updateStaticTablesLastSyncedMaster(18);
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
