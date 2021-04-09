import 'package:eco_mfi/db/TablesColumnFile.dart';

class CustomerFingerPrintBean {
  int timagerefno;
  int trefno;
  int mimagerefno;
  int mrefno;
  String mimagetype;
  String mimagesubtype;
  String desc;
  String mimagestring;
  int mcustno;

  CustomerFingerPrintBean(
      {this.timagerefno,this.trefno,this.mimagerefno,this.mrefno, this.mimagetype, this.mimagesubtype, this.desc, this.mimagestring,this.mcustno});

  factory CustomerFingerPrintBean.fromMap(Map<String, dynamic> map) {
    return CustomerFingerPrintBean(
      trefno: 	 map[TablesColumnFile.trefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      timagerefno: 	 map[TablesColumnFile.timagerefno] as int,
      mimagerefno: 	 map[TablesColumnFile.mimagerefno] as int,
      mimagetype: map[TablesColumnFile.mimagetype] as String,
      mimagesubtype: map[TablesColumnFile.mimagesubtype] as String,
      mimagestring: map[TablesColumnFile.mimagestring] as String,
      desc: map[TablesColumnFile.desc] as String,
        mcustno: map[TablesColumnFile.mcustno] as int,

    );
  }

  factory CustomerFingerPrintBean.fromMapFromMiddleWare(Map<String, dynamic> map) {
    return CustomerFingerPrintBean(
      trefno: 	 map[TablesColumnFile.trefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      timagerefno: 	 map[TablesColumnFile.timagerefno] as int,
      mimagerefno: 	 map[TablesColumnFile.mimagerefno] as int,
      mimagetype: map[TablesColumnFile.mimagetype] as String,
      mimagesubtype: map[TablesColumnFile.mimagesubtype] as String,
      mimagestring: map[TablesColumnFile.mimagestring] as String,
      desc: map[TablesColumnFile.desc] as String,
      mcustno: map[TablesColumnFile.mcustno] as int,
    );
  }
}
