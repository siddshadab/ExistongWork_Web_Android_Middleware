import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/LoanSimulator.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';

class LoanSimulatorService {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String getDetailsUrl = "/LoanSimulator/getLoanSimulatorDetails/";

  Future<List<loanSimulatorEntity>> getLoanSimulatorData(
      CustomerLoanDetailsBean loanObject) async {
    var mapData = new Map();
    mapData["leadsid"] = loanObject.mleadsid;
    String json = JSON.encode(mapData);
    print(json);

    try {
      String bodyValue = await NetworkUtil.callPostService(
          json, Constant.apiURL.toString() + getDetailsUrl, _headers);
      print("url " + Constant.apiURL.toString() + getDetailsUrl.toString());
      if (bodyValue == "404") {
        return null;
      } else {
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<loanSimulatorEntity> obj = parsed
            .map<loanSimulatorEntity>(
                (json) => loanSimulatorEntity.fromMap(json))
            .toList();
        print("Returned after map ${obj}");
        return obj;
      }
    } catch (_) {}
  }
}
