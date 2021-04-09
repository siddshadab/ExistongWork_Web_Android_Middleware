import 'dart:convert';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/GLAccountBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/LoanCycleWiseLimitBean.dart';

class syncingLoanCycleWiseLimit {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlInfo = "loanLimit/getLoanCycleWiseLimit/";
  static const JsonCodec JSON = const JsonCodec();

  Future<Null> trySave() async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    if (isNetworkAvailable) {
      await getMiddleWareData();
    }
  }

  Future<Null> getMiddleWareData() async {
    try {
      String bodyValue = await NetworkUtil.callGetService(
          Constant.apiURL.toString() + urlInfo.toString());
      print("body val " + bodyValue.toString());
      if (bodyValue == "404") {
        return null;
      } else if (bodyValue != null && bodyValue.toString() != 'null') {
        final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
        //await AppDatabase.get().deletSomeSyncingActivityFromOmni('Product');
        List<LoanCycleWiseLimitBean> obj = parsed
            .map<LoanCycleWiseLimitBean>(
                (json) => LoanCycleWiseLimitBean.fromMap(json))
            .toList();
        if (obj != null && obj.isNotEmpty) {
          await AppDatabase.get()
              .deleData(" ${AppDatabase.loanCycleWiseLimitMaster} ; ");
        }
        for (LoanCycleWiseLimitBean items in obj) {
          await AppDatabase.get().updateLoanCycleWiseLimitMaster(items);
        }
      }
    } catch (e) {}
  }
}
