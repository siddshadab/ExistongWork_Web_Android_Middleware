import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';

class LoanCycleWiseLimitBean {
  int mloancycle;
  double mloanlimit;

  LoanCycleWiseLimitBean({this.mloancycle, this.mloanlimit});

  factory LoanCycleWiseLimitBean.fromMap(Map<String, dynamic> map) {
    return LoanCycleWiseLimitBean(
      mloancycle: map[TablesColumnFile.mloancycle] as int,
      mloanlimit: map[TablesColumnFile.mloanlimit] as double,
    );
  }
}
