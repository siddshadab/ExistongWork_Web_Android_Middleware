import 'package:eco_mfi/db/TablesColumnFile.dart';

class CashBookRegisterBean {
  double vaultbalance;
  String usercode;
  double totalinflow;
  double totaloutflow;
  double offlineLoanCollection;
  double offlinesavingscollection;
  double onlineLoanCollection;
  double onlinesavingsCollection;
  double onlineloanclosure;
  double onlinesavingsclosure;
  double inflowcahstransaction;

  double onlinesavingswithdrawal;
  double outflowcashtransaction;

  double overallsavingscollection;
  double overallloancollection;
  double inflowtdopening;
  double outflowtdclosure;

  int oflnloancolltrnsnos;
  int onlnloancolltrnsnos;
  int oflnsvngcolltrnsnos;
  int onlnnsvngcolltrnsnos;
  int loanclsrtrnsnos;
  int svngclsrtrnsnos;
  int tdopngtrnsnos;
  int tdclsrtrnsnos;
  int onlnsvngwdrwltrnsno;
  int inflowtrnsnos;
  int outflowtrnsnos;

  double onlineLoanDisbursment;
  double offlineLoanDisbursment;
  int onlnloandisbtrnsno;
  int oflnloandisbtrnsno;
  double overallLoanDisbursment;

  double onlineBulkloanclosure;
  int blkloanclsrtrnsnos;
  double overallloanclosure;




  double onlninflowoothrtrnsamt;
  double oflninflowoothrtrnsamt;
  double onlnoutflwowoothrtrnsamt;
  double oflnoutflwowoothrtrnsamt;

  int onlninflwothrtrnsnos;
  int oflninflwothrtrnsnos;
  int onlnoutflwothrtrnsnos;
  int oflnoutflwothrtrnsnos;

  double inflwothrtrnsamt;
  double outflwothrtrnsamt;
  int inflwothrtrnsnos;
  int outflwothrtrnsnos;

  double oflninflwdisbamt;
  int oflninflwdisbtrnsnos;



  CashBookRegisterBean(
      {this.vaultbalance,
      this.usercode,
      this.totalinflow,
      this.totaloutflow,
      this.offlineLoanCollection,
      this.offlinesavingscollection,
      this.onlineLoanCollection,
      this.onlinesavingsCollection,
      this.onlineloanclosure,
      this.inflowcahstransaction,
      this.onlinesavingswithdrawal,
      this.outflowcashtransaction,
      this.onlinesavingsclosure,
      this.overallsavingscollection,
      this.overallloancollection,
      this.inflowtdopening,
      this.outflowtdclosure,
      this.oflnloancolltrnsnos,
      this.onlnloancolltrnsnos,
      this.oflnsvngcolltrnsnos,
      this.onlnnsvngcolltrnsnos,
      this.loanclsrtrnsnos,
      this.svngclsrtrnsnos,
      this.tdopngtrnsnos,
      this.tdclsrtrnsnos,
      this.onlnsvngwdrwltrnsno,
      this.inflowtrnsnos,
      this.outflowtrnsnos,
      this.onlineLoanDisbursment,
      this.offlineLoanDisbursment,
      this.onlnloandisbtrnsno,
      this.oflnloandisbtrnsno,
      this.overallLoanDisbursment,
      this.onlineBulkloanclosure,
      this.blkloanclsrtrnsnos,
      this.overallloanclosure,
        this.oflninflwdisbamt,
        this.oflninflwdisbtrnsnos
           });

  @override
  String toString() {
    return "CashBookRegisterBean    vaultbalance:	 ${vaultbalance}, usercode: 	 ${usercode},  totalinflow:	 ${totalinflow}, totaloutflow:	 ${totaloutflow}, offlineLoanCollection:	 ${offlineLoanCollection}, offlinesavingscollection:	 ${offlinesavingscollection}, onlineLoanCollection:	 ${onlineLoanCollection}, onlinesavingsCollection:	 ${onlinesavingsCollection}, onlineloanclosure:	 ${onlineloanclosure}, inflowcahstransaction:	 ${inflowcahstransaction},	 onlinesavingswithdrawal:	 ${onlinesavingswithdrawal}, outflowcashtransaction:	 ${outflowcashtransaction}, onlinesavingsclosure:${onlinesavingsclosure}";
  }

  factory CashBookRegisterBean.fromMap(Map<String, dynamic> map) {
    return CashBookRegisterBean(
      vaultbalance: map[TablesColumnFile.vaultbalance] as double,
      usercode: map[TablesColumnFile.usercode] as String,
      totalinflow: map[TablesColumnFile.totalinflow] as double,
      totaloutflow: map[TablesColumnFile.totaloutflow] as double,
      offlineLoanCollection:
          map[TablesColumnFile.offlineLoanCollection] as double,
      offlinesavingscollection:
          map[TablesColumnFile.offlinesavingscollection] as double,
      onlineLoanCollection:
          map[TablesColumnFile.onlineLoanCollection] as double,
      onlinesavingsCollection:
          map[TablesColumnFile.onlinesavingsCollection] as double,
      onlineloanclosure: map[TablesColumnFile.onlineloanclosure] as double,
      inflowcahstransaction:
          map[TablesColumnFile.inflowcahstransaction] as double,
      onlinesavingswithdrawal:
          map[TablesColumnFile.onlinesavingswithdrawal] as double,
      outflowcashtransaction:
          map[TablesColumnFile.outflowcashtransaction] as double,
      onlinesavingsclosure:
          map[TablesColumnFile.onlinesavingsclosure] as double,
      overallsavingscollection:
          map[TablesColumnFile.overallsavingscollection] as double,
      overallloancollection:
          map[TablesColumnFile.overallloancollection] as double,
      inflowtdopening: map[TablesColumnFile.inflowtdopening] as double,
      outflowtdclosure: map[TablesColumnFile.outflowtdclosure] as double,
      oflnloancolltrnsnos: map[TablesColumnFile.oflnloancolltrnsnos] as int,
      onlnloancolltrnsnos: map[TablesColumnFile.onlnloancolltrnsnos] as int,
      oflnsvngcolltrnsnos: map[TablesColumnFile.oflnsvngcolltrnsnos] as int,
      onlnnsvngcolltrnsnos: map[TablesColumnFile.onlnnsvngcolltrnsnos] as int,
      loanclsrtrnsnos: map[TablesColumnFile.loanclsrtrnsnos] as int,
      svngclsrtrnsnos: map[TablesColumnFile.svngclsrtrnsnos] as int,
      tdopngtrnsnos: map[TablesColumnFile.tdopngtrnsnos] as int,
      tdclsrtrnsnos: map[TablesColumnFile.tdclsrtrnsnos] as int,
      onlnsvngwdrwltrnsno: map[TablesColumnFile.onlnsvngwdrwltrnsno] as int,
      inflowtrnsnos: map[TablesColumnFile.inflowtrnsnos] as int,
      outflowtrnsnos: map[TablesColumnFile.outflowtrnsnos] as int,
      onlineLoanDisbursment:
          map[TablesColumnFile.onlineLoanDisbursment] as double,
      offlineLoanDisbursment:
          map[TablesColumnFile.offlineLoanDisbursment] as double,
      onlnloandisbtrnsno: map[TablesColumnFile.onlnloandisbtrnsno] as int,
      oflnloandisbtrnsno: map[TablesColumnFile.oflnloandisbtrnsno] as int,
      overallLoanDisbursment:
          map[TablesColumnFile.overallLoanDisbursment] as double,
      onlineBulkloanclosure:
          map[TablesColumnFile.onlineBulkloanclosure] as double,
      blkloanclsrtrnsnos: map[TablesColumnFile.blkloanclsrtrnsnos] as int,
      overallloanclosure: map[TablesColumnFile.overallloanclosure] as double,
      oflninflwdisbamt: map[TablesColumnFile.oflninflwdisbamt] as double,
      oflninflwdisbtrnsnos: map[TablesColumnFile.oflninflwdisbtrnsnos] as int,
    );
  }
}
