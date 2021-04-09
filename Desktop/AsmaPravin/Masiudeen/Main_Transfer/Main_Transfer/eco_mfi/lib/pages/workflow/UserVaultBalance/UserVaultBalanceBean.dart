


import 'package:eco_mfi/db/TablesColumnFile.dart';

class UserVaultBalanceBean {

  String musercode;
  int mlbrcode;
  int acctStat;
  int cashtype;
  String magenta;
  String currency;
  String usertype;
  double mbalance;
  UserVaultBalanceCompositetEntity userVaultBalanceCompositetEntity;


  UserVaultBalanceBean({this.musercode, this.mlbrcode, this.acctStat,
      this.cashtype, this.magenta, this.currency, this.usertype, this.mbalance,this.userVaultBalanceCompositetEntity});



  factory UserVaultBalanceBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return UserVaultBalanceBean(
      musercode:	map[TablesColumnFile.musercode] as String,
      mlbrcode:	map[TablesColumnFile.mlbrcode] as int,
      acctStat:	map[TablesColumnFile.acctStat] as int,
      cashtype:	map[TablesColumnFile.cashtype] as int,
      magenta:	map[TablesColumnFile.magenta] as String,
      currency:	map[TablesColumnFile.mcurcd] as String,
      usertype:	map[TablesColumnFile.usertype] as String,
      mbalance:	map[TablesColumnFile.mbalance] as double,

    );

  }


  factory UserVaultBalanceBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return UserVaultBalanceBean(
      userVaultBalanceCompositetEntity: UserVaultBalanceCompositetEntity.fromJson(map[TablesColumnFile.userVaultBalanceCompositetEntity]),
      acctStat:	map[TablesColumnFile.acctStat] as int,
      cashtype:	map[TablesColumnFile.cashtype] as int,
      magenta:	map[TablesColumnFile.magenta] as String,

      usertype:	map[TablesColumnFile.usertype] as String,
      mbalance:	map[TablesColumnFile.mbalance] as double,
    );
  }

}


class UserVaultBalanceCompositetEntity{
  String musercode;
  int mlbrcode;
  String currency;

  UserVaultBalanceCompositetEntity({this.mlbrcode, this.musercode,this.currency});

  factory UserVaultBalanceCompositetEntity.fromJson(Map<String, dynamic> json) {
    return UserVaultBalanceCompositetEntity(
      musercode:	json[TablesColumnFile.musercode1] as String,
      mlbrcode:	json[TablesColumnFile.mlbrcode] as int,
      currency:	json[TablesColumnFile.mcurcd] as String,
    );
  }
}