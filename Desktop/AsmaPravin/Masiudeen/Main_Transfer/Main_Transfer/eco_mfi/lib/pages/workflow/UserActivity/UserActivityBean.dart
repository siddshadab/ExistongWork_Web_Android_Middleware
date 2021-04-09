import 'package:eco_mfi/db/TablesColumnFile.dart';

class UserActivityBean {

  int trefno;
  int mrefno;
  String musercode;
  int mcustno;
  int mcenterid;
  int mgroupcd;
  double mtxnamount;
  String msystemnarration;
  String musernarration;
  String mactivity;
  int mmoduletype;
  String mtxnrefno;
  String mcorerefno;
  String status;
  String screenname;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  int missynctocoresys;
  int mlbrcode;
  DateTime mentrydate;
  int srno;
  String mprdacctid;

  UserActivityBean(
      {this.trefno,
      this.mrefno,
      this.musercode,
      this.mcustno,
      this.mcenterid,
      this.mgroupcd,
      this.mtxnamount,
      this.msystemnarration,
      this.musernarration,
      this.mactivity,
      this.mmoduletype,
      this.mtxnrefno,
      this.mcorerefno,
      this.status,
      this.screenname,
      this.mcreateddt,
      this.mcreatedby,
      this.mlastupdatedt,
      this.mlastupdateby,
      this.mgeolocation,
      this.mgeolatd,
      this.mgeologd,
      this.mlastsynsdate,
      this.missynctocoresys,
      this.mlbrcode,
      this.mentrydate,
        this.mprdacctid
      });

  factory UserActivityBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return UserActivityBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      musercode: map[TablesColumnFile.musercode1] as String,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mtxnamount: map[TablesColumnFile.mtxnamount] as double,
      msystemnarration: map[TablesColumnFile.msystemnarration] as String,
      musernarration: map[TablesColumnFile.musernarration] as String,
      mactivity: map[TablesColumnFile.mactivity] as String,
      mmoduletype: map[TablesColumnFile.mmoduletype] as int,
      mtxnrefno: map[TablesColumnFile.mtxnrefno] as String,
      mcorerefno: map[TablesColumnFile.mcorerefno] as String,
      status: map[TablesColumnFile.status] as String,
      screenname: map[TablesColumnFile.screenname] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt] == "null" ||
              map[TablesColumnFile.mcreateddt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby: map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt: (map[TablesColumnFile.mlastupdatedt] == "null" ||
              map[TablesColumnFile.mlastupdatedt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation: map[TablesColumnFile.mgeolocation] as String,
      mgeolatd: map[TablesColumnFile.mgeolatd] as String,
      mgeologd: map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate: (map[TablesColumnFile.mlastsynsdate] == "null" ||
              map[TablesColumnFile.mlastsynsdate] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      mentrydate: (map[TablesColumnFile.mentrydate] == "null" ||
              map[TablesColumnFile.mentrydate] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mentrydate]) as DateTime,

        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
    );
  }

  factory UserActivityBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return UserActivityBean(
      trefno: map[TablesColumnFile.trefno] as int,
      mrefno: map[TablesColumnFile.mrefno] as int,
      musercode: map[TablesColumnFile.musercode1] as String,
      mcustno: map[TablesColumnFile.mcustno] as int,
      mcenterid: map[TablesColumnFile.mcenterid] as int,
      mgroupcd: map[TablesColumnFile.mgroupcd] as int,
      mtxnamount: map[TablesColumnFile.mtxnamount] as double,
      msystemnarration: map[TablesColumnFile.msystemnarration] as String,
      musernarration: map[TablesColumnFile.musernarration] as String,
      mactivity: map[TablesColumnFile.mactivity] as String,
      mmoduletype: map[TablesColumnFile.mmoduletype] as int,
      mtxnrefno: map[TablesColumnFile.mtxnrefno] as String,
      mcorerefno: map[TablesColumnFile.mcorerefno] as String,
      status: map[TablesColumnFile.status] as String,
      screenname: map[TablesColumnFile.screenname] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt] == "null" ||
              map[TablesColumnFile.mcreateddt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby: map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt: (map[TablesColumnFile.mlastupdatedt] == "null" ||
              map[TablesColumnFile.mlastupdatedt] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby: map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation: map[TablesColumnFile.mgeolocation] as String,
      mgeolatd: map[TablesColumnFile.mgeolatd] as String,
      mgeologd: map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate: (map[TablesColumnFile.mlastsynsdate] == "null" ||
              map[TablesColumnFile.mlastsynsdate] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      mentrydate: (map[TablesColumnFile.mentrydate] == "null" ||
              map[TablesColumnFile.mentrydate] == null)
          ? null
          : DateTime.parse(map[TablesColumnFile.mentrydate]) as DateTime,

      mprdacctid: map[TablesColumnFile.mprdacctid] as String,
    );
  }
}
