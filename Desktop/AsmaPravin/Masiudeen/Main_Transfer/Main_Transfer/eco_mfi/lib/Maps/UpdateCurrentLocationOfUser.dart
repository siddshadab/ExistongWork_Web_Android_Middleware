
import 'package:device_info/device_info.dart';
import 'package:eco_mfi/LoginBean.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';

class UpdateCurrentLocationOfUser {

static final _headers = {'Content-Type': 'application/json'};
static const JsonCodec JSON = const JsonCodec();




Future<Null> updateCurrentLocationOfUser(double latitude, double longitude, String musrcode, String mreportinguser,String muserName,bool isPathTrackerOn) async {

  String json =  await _toJson(latitude, longitude, musrcode, mreportinguser,muserName);
  print(json);

  String callFor = isPathTrackerOn?"currentLocationMaster/addPathTracker":"currentLocationMaster/add";

  final bodyValue = await NetworkUtil.callPostService(json,Constant.apiURL+callFor,_headers);
  print(bodyValue);
  if(bodyValue == 'error'){
    return null;
  }
 }

Future<String> _toJson(double latitude, double longitude, String musrcode, String mreportinguser,String muserName) async {
  var mapData = new Map();
  mapData[TablesColumnFile.mgeolatd] = latitude.toString();
  mapData[TablesColumnFile.mgeologd] = longitude.toString();
  mapData[TablesColumnFile.musrcode] = musrcode;
  mapData[TablesColumnFile.musrname] = muserName;
  mapData[TablesColumnFile.mlastupdateby] = musrcode;
  mapData[TablesColumnFile.mcreatedby] = musrcode;
  mapData[TablesColumnFile.musrname] = muserName;
  mapData[TablesColumnFile.mcreateddt] =	DateTime.now().toIso8601String();
  mapData[TablesColumnFile.mlastupdatedt] =	DateTime.now().toIso8601String();
 mapData[TablesColumnFile.mreportinguser] = mreportinguser;
  String json = JSON.encode(mapData);
  print(json);
  return json;
}

}
