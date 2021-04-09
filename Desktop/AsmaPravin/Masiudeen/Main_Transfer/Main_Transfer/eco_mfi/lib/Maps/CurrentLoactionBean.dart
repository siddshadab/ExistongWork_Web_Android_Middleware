


import 'package:eco_mfi/db/TablesColumnFile.dart';

class CurrentLoactionBean {

  String musrcode;
  String musrname;
  String mreportinguser;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  String profileimage;


  CurrentLoactionBean(
      {this.musrcode,
        this.musrname,
        this.mreportinguser,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.missynctocoresys,
        this.mlastsynsdate,
        this.profileimage
      });



  factory CurrentLoactionBean.fromMapMiddleware(Map<String, dynamic> map) {
    return CurrentLoactionBean(

      musrcode: map[TablesColumnFile.musrcode] as String,
      musrname: map[TablesColumnFile.musrname] as String,
      mreportinguser: map[TablesColumnFile.mreportinguser] as String,
      mcreateddt: (map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby],
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby],
      mgeolocation:map[TablesColumnFile.mgeolocation],
      mgeolatd:map[TablesColumnFile.mgeolatd],
      mgeologd:map[TablesColumnFile.mgeologd],
      missynctocoresys:(map[TablesColumnFile.missynctocoresys]=="null"||map[TablesColumnFile.missynctocoresys]==null)?0:map[TablesColumnFile.missynctocoresys] as int,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      profileimage: map[TablesColumnFile.profileimage] as String,
    );
  }



}