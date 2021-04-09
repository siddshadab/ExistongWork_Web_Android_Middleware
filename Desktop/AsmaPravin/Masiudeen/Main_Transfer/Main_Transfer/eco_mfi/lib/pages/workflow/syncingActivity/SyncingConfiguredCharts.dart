import 'dart:convert';

import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';


import 'dart:async';
import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApprovalLimit/LoanApprovalLimitBean.dart';



class SyncingConfiguredCharts {

  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<List<ChartsBean>> getChartsData(String muserName,int mgrpcd) async {
    List<ChartsBean> chartsBeanList = new List<ChartsBean>();

    try {
    String json2 = _toJsonOfAgentUserName(muserName,mgrpcd);
    final bodyValue = await NetworkUtil.callPostService(json2,Constant.apiURL+"chartsMaster/getChartsDataByAllThreeMasterJoin",_headers);

    if(bodyValue == "error"||bodyValue == "404"||bodyValue == null){
      return null;
    }

    chartsBeanList = await _fromChartsJson(bodyValue);
    return chartsBeanList;
    } catch (e) {
      print('Server Exception!!!');

    }
  }

  Future<List<ChartsBean>> _fromChartsJson(String json) async{
    List<ChartsBean> chartsBeanList = new List<ChartsBean>();
   List list = JSON.decode(json);
    for (int i = 0; i < list.length; i++) {
      print(list.length);
      var bean = ChartsBean.fromMiddleware(list[i]);
      chartsBeanList.add(bean);
    }
    return chartsBeanList;
  }

  String _toJsonOfAgentUserName(String muserCode,int mgrpcd) {

    var mapComposite = new Map();
    var mapData = new Map();
    mapData[TablesColumnFile.musrcode] = muserCode;
    mapData[TablesColumnFile.mgrpcd] = mgrpcd;
    mapComposite[TablesColumnFile.userAccressRightsCompositeEntity]=mapData;
    String json = JSON.encode(mapComposite);
    print(json.toString());
    return json;
  }

}

