import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/timelines/ReportUtils.dart';

class ReportMasterServices {
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  final urlGetDisbursmentListDetails =
      "reportFilterMapping/getListOfReportFilter/";
  static const JsonCodec JSON = const JsonCodec();

  Future<Null> trySave() async {
    bool isNetworkAvailable;

    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      await getMiddleWareData();
    }
  }

  Future<Null> getMiddleWareData() async {
    //try {
    print(Constant.apiURL.toString() + urlGetDisbursmentListDetails);
    String bodyValue = await NetworkUtil.callGetService(
        Constant.apiURL.toString() + urlGetDisbursmentListDetails);
    print("url " + Constant.apiURL.toString() + urlGetDisbursmentListDetails);
    if (bodyValue == "404") {
      return null;
    } else {
      print("returned Value is $bodyValue");
      final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
      DateTime updateDateimeAfterUpdate = DateTime.now();
      List<ReportMasterEntity> obj = parsed
          .map<ReportMasterEntity>((json) => ReportMasterEntity.fromMap(json))
          .toList();

      if (obj != null && obj.isNotEmpty) {
        await AppDatabaseExtended.get()
            .deleteFromTable(AppDatabase.reportFilterMaster);
        for (int dsbrs = 0; dsbrs < obj.length; dsbrs++) {
          print("for i = ${dsbrs} val is ${obj[dsbrs].reportFilterComposite}");
          await AppDatabaseExtended.get()
              .updateReportFilterMaster(obj[dsbrs])
              .then((onValue) {
            // customerNumberValue = onValue;
          });

          print("Disbursed Master Update Complete");
        }
      }
    }

    /*} catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }
}
