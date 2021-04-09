import 'package:eco_mfi/db/TablesColumnFile.dart';

class CIFLoanPaymentHistoryBean {


  String mprdacctid;
  String mdtOfPayment;
  String mdtIdealrePayment;
  String mdiffInDay;
  String mtype;
  double minstAmt;
  double mamtOfTrans;
  double mprincRecvd;
  double mintRecvd;
  double mpenalIntRecvd;
  double mchrgsRecvd;
  double mwriteOffAmtRecvd;
  double mprincOutstand;
  double mwriteOffAmt;
  double mcommissRecvd;
  String mnarration;
  String minstNumber;

  CIFLoanPaymentHistoryBean({this.mprdacctid, this.mdtOfPayment,
      this.mdtIdealrePayment, this.mdiffInDay, this.mtype, this.minstAmt,
      this.mamtOfTrans, this.mprincRecvd, this.mintRecvd, this.mpenalIntRecvd,
      this.mchrgsRecvd, this.mwriteOffAmtRecvd, this.mprincOutstand,
      this.mwriteOffAmt, this.mcommissRecvd,
      this.mnarration, this.minstNumber});


  @override
  String toString() {
    return 'CIFLoanPaymentHistoryBean{mprdacctid: $mprdacctid, mdtOfPayment: $mdtOfPayment, mdtIdealrePayment: $mdtIdealrePayment, mdiffInDay: $mdiffInDay, mtype: $mtype, minstAmt: $minstAmt, mamtOfTrans: $mamtOfTrans, mprincRecvd: $mprincRecvd, mintRecvd: $mintRecvd, mpenalIntRecvd: $mpenalIntRecvd, mchrgsRecvd: $mchrgsRecvd, mwriteOffAmtRecvd: $mwriteOffAmtRecvd, mprincOutstand: $mprincOutstand, mwriteOffAmt: $mwriteOffAmt, mcommissRecvd: $mcommissRecvd, mnarration: $mnarration, minstNumber :$minstNumber}';
  }


  factory CIFLoanPaymentHistoryBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return CIFLoanPaymentHistoryBean(
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        mdtOfPayment:map[TablesColumnFile.mdtOfPayment] as String,
        mdtIdealrePayment:map[TablesColumnFile.mdtIdealrePayment] as String,
        mdiffInDay:map[TablesColumnFile.mdiffInDay] as String,
        mtype:map[TablesColumnFile.mtype] as String,
        minstAmt: map[TablesColumnFile.minstAmt] as double,
        mamtOfTrans: map[TablesColumnFile.mamtOfTrans] as double,
        mprincRecvd: map[TablesColumnFile.mprincRecvd] as double,
        mintRecvd: map[TablesColumnFile.mintRecvd] as double,
        mpenalIntRecvd: map[TablesColumnFile.mpenalIntRecvd] as double,
        mchrgsRecvd: map[TablesColumnFile.mchrgsRecvd] as double,
        mwriteOffAmtRecvd: map[TablesColumnFile.mwriteOffAmtRecvd] as double,
        mprincOutstand: map[TablesColumnFile.mprincOutstand] as double,
        mwriteOffAmt: map[TablesColumnFile.mwriteOffAmt] as double,
        mcommissRecvd: map[TablesColumnFile.mcommissRecvd] as double,
        mnarration: map[TablesColumnFile.mnarration] as String,
        minstNumber : map[TablesColumnFile.minstNumber] as String,
    );
  }

  factory CIFLoanPaymentHistoryBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    return CIFLoanPaymentHistoryBean(
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        mdtOfPayment:map[TablesColumnFile.mdtOfPayment] as String,
        mdtIdealrePayment:map[TablesColumnFile.mdtIdealrePayment] as String,
        mdiffInDay:map[TablesColumnFile.mdiffInDay] as String,
        mtype:map[TablesColumnFile.mtype] as String,
        minstAmt: map[TablesColumnFile.minstAmt] as double,
        mamtOfTrans: map[TablesColumnFile.mamtOfTrans] as double,
        mprincRecvd: map[TablesColumnFile.mprincRecvd] as double,
        mintRecvd: map[TablesColumnFile.mintRecvd] as double,
        mpenalIntRecvd: map[TablesColumnFile.mpenalIntRecvd] as double,
        mchrgsRecvd: map[TablesColumnFile.mchrgsRecvd] as double,
        mwriteOffAmtRecvd: map[TablesColumnFile.mwriteOffAmtRecvd] as double,
        mprincOutstand: map[TablesColumnFile.mprincOutstand] as double,
        mwriteOffAmt: map[TablesColumnFile.mwriteOffAmt] as double,
        mcommissRecvd: map[TablesColumnFile.mcommissRecvd] as double,
        mnarration: map[TablesColumnFile.mnarration] as String,
        minstNumber : map[TablesColumnFile.minstNumber] as String,

    );}
}
