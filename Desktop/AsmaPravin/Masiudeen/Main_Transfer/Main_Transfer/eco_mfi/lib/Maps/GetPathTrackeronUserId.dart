import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'CurrentLoactionBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';


class GetPathTrackeronUserId {

  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<CurrentLoactionBean>> trySave(String mUserCode) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      return await getLocations(mUserCode);
    }
  }

  Future<String> _toJson(String mUserCode) async {
    var mapData = new Map();

      mapData[TablesColumnFile.musrcode] = mUserCode.toString();


    String json = JSON.encode(mapData);
    print(json);
    return json;
  }

  Future<List<CurrentLoactionBean>> getLocations(String mUserCode) async {
    String json;
    json = await _toJson(mUserCode);
    try {
      String callFor = "currentLocationMaster/pathTrackerDraw/";
      print(Constant.apiURL.toString() + callFor);
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + callFor,
          _headers);

      if (bodyValue == "404") {
        return null;
      } else {
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        print(parsed);

        List<CurrentLoactionBean> obj = parsed
            .map<CurrentLoactionBean>(
                (json) => CurrentLoactionBean.fromMapMiddleware(json))
            .toList();
        return obj;
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }

  }



}
