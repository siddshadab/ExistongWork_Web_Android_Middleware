import 'dart:async';
import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'CurrentLoactionBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';


class GetCurrentLocationOnSuperUsers {

  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<CurrentLoactionBean>> trySave(String mSuperUser,bool isForCenters) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
     return await getLocations(mSuperUser,isForCenters);
    }
  }

  Future<String> _toJson(String mSuperUser,bool isForCenters) async {
    var mapData = new Map();
    if(isForCenters){
      mapData[TablesColumnFile.mcreatedby] = mSuperUser.toString();
    }else{
      mapData[TablesColumnFile.mreportinguser] = mSuperUser.toString();
    }

    String json = JSON.encode(mapData);
    print(json);
    return json;
  }

  Future<List<CurrentLoactionBean>> getLocations(String mSuperUser,bool isForCenters) async {
    String json;
    json = await _toJson(mSuperUser,isForCenters);
    try {
      String callFor = isForCenters?"currentLocationMaster/getCenterByUser/":"currentLocationMaster/getBySuperUser/";
      print(Constant.apiURL.toString() + callFor);
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + callFor,
          _headers);

    if (bodyValue == "404" || bodyValue == null) {
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


  Future<List<CustomerListBean> > getCustomersFromMiddleWareData(int mcenterId) async {
    String json;

    json = await _toJsonOfCenterId(mcenterId);
    try {
      String callFor = "customerData/getCustomerbyCenterIdForLocations/";

      print("start timing "+DateTime.now().toIso8601String())
      ;      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + callFor, _headers);
      print("url " + Constant.apiURL.toString() + callFor.toString());
      if (bodyValue == "404" ) {
        return null;
      } else {
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerListBean> obj = parsed
            .map<CustomerListBean>(
                (json) => CustomerListBean.fromMiddlewareForLocations(json, true))
            .toList();

        return obj;
      }

    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }

  }

  String _toJsonOfCenterId(int  mcenterId) {
    var mapData = new Map();
    mapData[TablesColumnFile.mCenterId] = mcenterId;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }

}
