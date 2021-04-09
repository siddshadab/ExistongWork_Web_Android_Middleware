import 'package:eco_mfi/db/TablesColumnFile.dart';

class InternalBankTransferBean {

  int mcashtr;
  String mcrdr;
  String mremark;
  String mnarration;
  double mamt;
  String maccid;
  String mdraccid;
  String mcraccid;
  int mstatus;
  String merrormessage;
  int mlbrcode;
  String mcreatedby;
  DateTime mcreateddt;
  DateTime mlastupdatedt;	
  String mlastupdateby;
	String mlongname;
  DateTime moperationdate;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate ;
  int trefno;
  int mrefno;
  String mcraccidname;
  String mdraccidname;


    String mbatchcd;
    DateTime mentrydate;
    String mtxnrefno;
    int msetno;
    int mscrollno;
    String mcurcd;

  InternalBankTransferBean({this.mcashtr, this.mcrdr, this.mremark,
      this.mnarration, this.mamt, this.maccid, this.mdraccid, this.mcraccid,
  this.merrormessage,
    this.mstatus,
    this.mlbrcode,
    this.mcreatedby,this.mcreateddt,this.mlastupdatedt,this.mlastupdateby,this.mgeolocation,this.mgeolatd,this.mgeologd,this.missynctocoresys, this.mlastsynsdate
  ,this.trefno,this.mrefno,this.mcraccidname,this.mdraccidname,
  this.mbatchcd,
    this.mentrydate,
    this.mtxnrefno,
    this.msetno,
    this.mscrollno,
    this.mcurcd,
    this.moperationdate
     
  });

  @override
  String toString() {
    return 'InternalBankTransferBean{mcashtr: $mcashtr, mcrdr: $mcrdr, mremark: $mremark, mnarration: $mnarration, mamt: $mamt, maccid: $maccid, mdraccid: $mdraccid, mcraccid: $mcraccid}';
  }

  factory InternalBankTransferBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return InternalBankTransferBean(
      mcashtr: map[TablesColumnFile.mcashtr] as int,
      mcrdr: map[TablesColumnFile.mcrdr] as String,
      mremark:map[TablesColumnFile.mremark] as String,
      mnarration: map[TablesColumnFile.mnarration] as String,
      mamt:map[TablesColumnFile.mamt] as double,
      maccid:map[TablesColumnFile.maccid] as String,
      mdraccid:map[TablesColumnFile.mdraccid] as String,
      mcraccid:map[TablesColumnFile.mcraccid] as String,
      mstatus:map[TablesColumnFile.mstatus] as int,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
     mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:	map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:	map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:	map[TablesColumnFile.mgeolatd] as String,
      mgeologd:	map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      trefno:  map[TablesColumnFile.trefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      mcraccidname: map[TablesColumnFile.mcraccidname] as String,
      mdraccidname: map[TablesColumnFile.mdraccidname] as String,
      mbatchcd: map[TablesColumnFile.mbatchcd] as String,
    mentrydate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mtxnrefno: map[TablesColumnFile.mtxnrefno] as String,
    msetno: map[TablesColumnFile.msetno] as int,
    mscrollno: map[TablesColumnFile.mscrollno] as int,
    mcurcd: map[TablesColumnFile.mcurCd] as String,
      moperationdate: (map[TablesColumnFile.moperationdate]=="null"||map[TablesColumnFile.moperationdate]==null)?null:DateTime.parse(map[TablesColumnFile.moperationdate]) as DateTime,

    );
  }

  factory InternalBankTransferBean.fromMapMiddleware(Map<String, dynamic> map){
    print("fromMapMiddleware");
    print("Receiver String is $map");
    return InternalBankTransferBean(
      mcashtr: map[TablesColumnFile.mcashtr] as int,
      mcrdr: map[TablesColumnFile.mcrdr] as String,
      mremark:map[TablesColumnFile.mremark] as String,
      mnarration: map[TablesColumnFile.mnarration] as String,
      mamt:map[TablesColumnFile.mamt] as double,
      maccid:map[TablesColumnFile.maccid] as String,
      mdraccid:map[TablesColumnFile.mdraccid] as String,
      mcraccid:map[TablesColumnFile.mcraccid] as String,
      mstatus:map[TablesColumnFile.mstatus] as int,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
       mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:	map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:	map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:	map[TablesColumnFile.mgeolatd] as String,
      mgeologd:	map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      trefno:  map[TablesColumnFile.trefno] as int,
      mrefno : map[TablesColumnFile.mrefno] as int,
      mlbrcode: map[TablesColumnFile.mlbrcode] as int,
      mcraccidname: map[TablesColumnFile.mcraccidname] as String,
      mdraccidname: map[TablesColumnFile.mdraccidname] as String,
       mbatchcd: map[TablesColumnFile.mbatchcd] as String,
    mentrydate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mtxnrefno: map[TablesColumnFile.mtxnrefno] as String,
    msetno: map[TablesColumnFile.msetno] as int,
    mscrollno: map[TablesColumnFile.mscrollno] as int,
    mcurcd: map[TablesColumnFile.mcurCd] as String,
      moperationdate: (map[TablesColumnFile.moperationdate]=="null"||map[TablesColumnFile.moperationdate]==null)?null:DateTime.parse(map[TablesColumnFile.moperationdate]) as DateTime,
    );}
}
