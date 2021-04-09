import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/AdminModule/AccessRightModuleBean.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';


class UserAccessRightSyncing {

 static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var getUserAccessDetails =
      "userAccessMapping/getUserAccessMappingData/";
  static const JsonCodec JSON = const JsonCodec();




   Future<List<AccessRightModuleBean>> getAccessDetails(String  userCode) async {
    var mapData = new Map();
    mapData["usrcode"] = userCode;
    String json = JSON.encode(mapData);
    print(json);


   // try{
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + getUserAccessDetails.toString(), _headers);

      if (bodyValue == "404"||bodyValue==null ) {
        return null;
      } else {
        
         final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<AccessRightModuleBean> obj = parsed
            .map<AccessRightModuleBean>(
                (json) => AccessRightModuleBean.fromMap(json))
            .toList();     

        return obj;

      }

  }




}