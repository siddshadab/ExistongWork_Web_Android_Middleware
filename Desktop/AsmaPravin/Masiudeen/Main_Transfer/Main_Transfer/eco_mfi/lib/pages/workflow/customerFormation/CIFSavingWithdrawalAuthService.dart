import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CIFSavingWithdrawalAuthBean.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class CIFSavingWithdrawalAuthService {
  static const JsonCodec JSON = const JsonCodec();
  static final _headers = {'Content-Type': 'application/json'};

  Future<List<CIFSavingWithdrawalAuthBean>> getSavingsWithdrawalList(
      String userCode,int lbrcode) async {
    
    
    var mapData = new Map();
     mapData[TablesColumnFile.mlbrcode] = lbrcode;
    mapData[TablesColumnFile.musercode1] = userCode;
  
    String json = JSON.encode(mapData);
      print(json);
    final bodyValue = await NetworkUtil.callPostService(
        json, Constant.apiURL + "/CIFSvingWdrawAuth/getPendingAuthorizationDetails/", _headers);
    print("bodyValue Srevice m hai " + bodyValue);
    if (bodyValue == 'error'||bodyValue== 404||bodyValue== "404") {
      return null;
    } else {
      final parsed = await JSON.decode(bodyValue).cast<Map<String, dynamic>>();

      List<CIFSavingWithdrawalAuthBean> obj = parsed
          .map<CIFSavingWithdrawalAuthBean>(
              (json) => CIFSavingWithdrawalAuthBean.fromMap(json))
          .toList();

      return obj;
    }
  }



    Future<CIFSavingWithdrawalAuthBean> postCifAuthSubmit(
      CIFSavingWithdrawalAuthBean cifAuthBean) async {
    
    
    var mapData = new Map();
     mapData[TablesColumnFile.mentrydate] = cifAuthBean.mentrydate.toIso8601String();
    mapData[TablesColumnFile.musercode1] = cifAuthBean.musercode;
    mapData[TablesColumnFile.mbatchcd] = cifAuthBean.mbatchcd;
    String json = JSON.encode(mapData);
    final bodyValue = await NetworkUtil.callPostService(
        json, Constant.apiURL + "/CIFSvingWdrawAuth/submitresponse/", _headers);
    print("bodyValue Srevice m hai " + bodyValue);
    if (bodyValue == 'error'||bodyValue== 404||bodyValue== "404") {
      return null;
    } else {
      final parsed = await JSON.decode(bodyValue).cast<Map<String, dynamic>>();

      CIFSavingWithdrawalAuthBean obj = parsed
          .map<CIFSavingWithdrawalAuthBean>(
              (json) => CIFSavingWithdrawalAuthBean.fromMap(json));

      return obj;
    }
  }




}
