import 'package:eco_mfi/db/TablesColumnFile.dart';

class CIFBean {

  int mcustno;
  String mnid;
  int mlbrcode;
  String mprdacctid;
  int mmoduletype;
  int macctstat;
  int mtier;
  double mshadowclearbal;
  double mshadowtotalbal;
  double mactualclearbal;
  double mactualtotalbal;
  double mlienamt;
  double mmainbal;
  //double minterestamt;
  double mtdsamt;
  String mnametitle;
  String mlongname;
  String mdob;
  String mpannodesc;
  String middesc;
  String mreloff;
  String msexcode;
  int mreligioncd;
  int mmaritalstatus;
  String mlangofcust;
  String mmailingaddr1;
  String mmailingaddr2;
  String mmailingaddr3;
  String mhomeaddr1;
  String mhomeaddr2;
  String mhomeaddr3;
  String mofficeaddr1;
  String mofficeaddr2;
  String mofficeaddr3;
  String macctstatdesc;
  String mprdcd;
  String mremark;
  String mcrdr;
  double mamt;
  double minterestprov ;
  double minterestpaid ;
  double mmaturityvalue ;
  double mpenalprov ;
  double mpenalpaid ;
  double mdisbursedamt ;
  double mexcessamt ;
  String mnarration;
  String mcreatedby;
  String momnitxnrefno;
  String merror;
  int mfreezetype;
  String mleadsid;
  String mbranchname;
  int mcuststatus;
  String misbiometricdeclareflagyn;
  double mprinccurrdue;
  double mprincoverdue;
  double mintdue;
  String mopendate;
  double mlcybal;
  double mtotallien;
  double mintapplied;
  String mbatchcd;
  int msetno;
  double mlcytrnamt;
  DateTime mdisbursmentdate;
  DateTime moperationdate;
  double mloanrepayprin;
	double mloanrepayint;
	double mothrchrgpen;
	double mloanoutbal;
  double moverdueintcoll;
  String mentrydate;
  int mscrollno;
  String mcurcd;
  String mrouteto;


  CIFBean({
    this.mcustno, this.mnid, this.mlbrcode, this.mprdacctid,
    this.mmoduletype, this.macctstat, this.mtier, this.mshadowclearbal,
    this.mshadowtotalbal, this.mactualclearbal, this.mactualtotalbal,
    this.mlienamt, this.mmainbal, this.mtdsamt,
    this.mnametitle, this.mlongname, this.mdob, this.mpannodesc, this.middesc,
    this.mreloff, this.msexcode, this.mreligioncd, this.mmaritalstatus,
    this.mlangofcust, this.mmailingaddr1, this.mmailingaddr2,
    this.mmailingaddr3, this.mhomeaddr1, this.mhomeaddr2, this.mhomeaddr3,
    this.mofficeaddr1, this.mofficeaddr2, this.mofficeaddr3, this.macctstatdesc,
    this.mprdcd, this.mremark, this.mcrdr, this.mamt, this.minterestprov, this.minterestpaid,
    this.mmaturityvalue, this.mpenalprov, this.mpenalpaid, this.mdisbursedamt, this.mexcessamt,
    this.mnarration, this.mcreatedby, this.merror, this.momnitxnrefno, this.mfreezetype,
    this.mleadsid, this.mbranchname, this.mcuststatus, this.misbiometricdeclareflagyn,
    this.mprinccurrdue, this.mprincoverdue, this.mintdue,this.mopendate,	this.mlcybal,	this.mtotallien,	this.mintapplied,
    this.mbatchcd,this.msetno,this.mlcytrnamt,this.mdisbursmentdate,this.moperationdate,
    this.mloanrepayprin,	this.mloanrepayint,	this.mothrchrgpen,	this.mloanoutbal,  this.moverdueintcoll,
    this.mentrydate, this.mscrollno, this.mcurcd,this.mrouteto

  }  );


  @override
  String toString() {
    return 'CIFBean{mcustno: $mcustno, mnid: $mnid, mlbrcode: $mlbrcode, mprdacctid: $mprdacctid, mmoduletype: $mmoduletype, macctstat: $macctstat, mtier: $mtier, mshadowclearbal: $mshadowclearbal, mshadowtotalbal: $mshadowtotalbal, mactualclearbal: $mactualclearbal, mactualtotalbal: $mactualtotalbal, mlienamt: $mlienamt, mmainbal: $mmainbal, mtdsamt: $mtdsamt, mnametitle: $mnametitle, mlongname: $mlongname, mdob: $mdob, mpannodesc: $mpannodesc, middesc: $middesc, mreloff: $mreloff, msexcode: $msexcode, mreligioncd: $mreligioncd, mmaritalstatus: $mmaritalstatus, mlangofcust: $mlangofcust, mmailingaddr1: $mmailingaddr1, mmailingaddr2: $mmailingaddr2, mmailingaddr3: $mmailingaddr3, mhomeaddr1: $mhomeaddr1, mhomeaddr2: $mhomeaddr2, mhomeaddr3: $mhomeaddr3, mofficeaddr1: $mofficeaddr1, mofficeaddr2: $mofficeaddr2, mofficeaddr3: $mofficeaddr3, macctstatdesc: $macctstatdesc, mprdcd: $mprdcd, mremark: $mremark, mcrdr: $mcrdr, mamt: $mamt, minterestprov: $minterestprov, minterestpaid: $minterestpaid, mmaturityvalue: $mmaturityvalue, mpenalprov: $mpenalprov, mpenalpaid: $mpenalpaid, mdisbursedamt: $mdisbursedamt, mexcessamt: $mexcessamt, mnarration: $mnarration, mcreatedby: $mcreatedby, momnitxnrefno: $momnitxnrefno, merror: $merror, mfreezetype: $mfreezetype, mleadsid: $mleadsid, mbranchname: $mbranchname, mcuststatus: $mcuststatus, misbiometricdeclareflagyn: $misbiometricdeclareflagyn, mprinccurrdue: $mprinccurrdue, mprincoverdue: $mprincoverdue, mintdue: $mintdue, mopendate: $mopendate, mlcybal: $mlcybal, mtotallien: $mtotallien, mintapplied: $mintapplied, mbatchcd: $mbatchcd, msetno: $msetno, mlcytrnamt: $mlcytrnamt}';
  }

  factory CIFBean.fromMap(Map<String, dynamic> map) {
    print(map);
    return CIFBean(
        mcustno: map[TablesColumnFile.mcustno] as int,
        mnid: map[TablesColumnFile.mnid] as String,
        mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        mmoduletype: map[TablesColumnFile.mmoduletype] as int,
        macctstat: map[TablesColumnFile.macctstat] as int,
        mtier: map[TablesColumnFile.mtier] as int,
        mshadowclearbal: map[TablesColumnFile.mshadowclearbal] as double,
        mshadowtotalbal: map[TablesColumnFile.mshadowtotalbal] as double,
        mactualclearbal: map[TablesColumnFile.mactualclearbal] as double,
        mactualtotalbal: map[TablesColumnFile.mactualtotalbal] as double,
        mlienamt: map[TablesColumnFile.mlienamt] as double,
        mmainbal: map[TablesColumnFile.mmainbal] as double,
        mtdsamt: map[TablesColumnFile.mtdsamt] as double,
        mnametitle:map[TablesColumnFile.mnametitle] as String,
        mlongname:map[TablesColumnFile.mlongname] as String,
        mdob:map[TablesColumnFile.mdob] as String,
        mpannodesc:map[TablesColumnFile.mpannodesc] as String,
        middesc:map[TablesColumnFile.middesc] as String,
        mreloff:map[TablesColumnFile.mreloff] as String,
        msexcode:map[TablesColumnFile.msexcode] as String,
        mreligioncd:map[TablesColumnFile.mreligioncd] as int,
        mmaritalstatus:map[TablesColumnFile.mmaritalstatus] as int,
        mlangofcust:map[TablesColumnFile.mlangofcust] as String,
        mmailingaddr1:map[TablesColumnFile.mmailingaddr1] as String,
        mmailingaddr2:map[TablesColumnFile.mmailingaddr2] as String,
        mmailingaddr3:map[TablesColumnFile.mmailingaddr3] as String,
        mhomeaddr1:map[TablesColumnFile.mhomeaddr1] as String,
        mhomeaddr2:map[TablesColumnFile.mhomeaddr2] as String,
        mhomeaddr3:map[TablesColumnFile.mhomeaddr3] as String,
        mofficeaddr1:map[TablesColumnFile.mofficeaddr1] as String,
        mofficeaddr2:map[TablesColumnFile.mofficeaddr2] as String,
        mofficeaddr3:map[TablesColumnFile.mofficeaddr2] as String,
        macctstatdesc:map[TablesColumnFile.macctstatdesc] as String,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        mremark:map[TablesColumnFile.mremark] as String,
        mcrdr:map[TablesColumnFile.mcrdr] as String,
        mamt: map[TablesColumnFile.mamt] as double,
        minterestprov: map[TablesColumnFile.minterestprov] as double,
        minterestpaid: map[TablesColumnFile.minterestpaid] as double,
        mmaturityvalue: map[TablesColumnFile.mmaturityvalue] as double,
        mpenalprov: map[TablesColumnFile.mpenalprov] as double,
        mpenalpaid: map[TablesColumnFile.mpenalpaid] as double,
        mdisbursedamt: map[TablesColumnFile.mdisbursedamt] as double,
        mexcessamt: map[TablesColumnFile.mexcessamt] as double,
        mnarration: map[TablesColumnFile.mnarration] as String,
        mcreatedby:map[TablesColumnFile.mcreatedby],
        merror: map[TablesColumnFile.merror] as String,
        momnitxnrefno: map[TablesColumnFile.momnitxnrefno] as String,
        mfreezetype:map[TablesColumnFile.mfreezetype] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mbranchname: map[TablesColumnFile.mbranchname] as String,
        mcuststatus: map[TablesColumnFile.mcuststatus] as int,
        misbiometricdeclareflagyn: map[TablesColumnFile.misbiometricdeclareflagyn] as String,
        mprinccurrdue: map[TablesColumnFile.mprinccurrdue] as double,
        mprincoverdue: map[TablesColumnFile.mprincoverdue] as double,
        mintdue: map[TablesColumnFile.mintdue] as double,
        mopendate: map[TablesColumnFile.mopendate] as String,
        mlcybal: map[TablesColumnFile.mlcybal] as double,
        mtotallien: map[TablesColumnFile.mtotallien] as double,
        mintapplied: map[TablesColumnFile.mintapplied] as double,
        mbatchcd: map[TablesColumnFile.mbatchcd] as String,
        msetno: map[TablesColumnFile.msetno] as int,
        mlcytrnamt: map[TablesColumnFile.mlcytrnamt] as double,
        mdisbursmentdate:(map[TablesColumnFile.mdisbursmentdate]=="null"||map[TablesColumnFile.mdisbursmentdate]==null)?
        null:DateTime.parse(map[TablesColumnFile.mdisbursmentdate]) as DateTime,
        moperationdate:(map[TablesColumnFile.moperationdate]=="null"||map[TablesColumnFile.moperationdate]==null)?
        null:DateTime.parse(map[TablesColumnFile.moperationdate]) as DateTime,
        mloanrepayprin: map[TablesColumnFile.mloanrepayprin] as double,
	    mloanrepayint: map[TablesColumnFile.mloanrepayint] as double,
	    mothrchrgpen: map[TablesColumnFile.mothrchrgpen] as double,
	    mloanoutbal: map[TablesColumnFile.mloanoutbal] as double,
        moverdueintcoll: map[TablesColumnFile.moverdueintcoll] as double,
        mentrydate: map[TablesColumnFile.mentrydate] as String,
        mscrollno: map[TablesColumnFile.mscrollno] as int,
        mcurcd: map[TablesColumnFile.mcurcd] as String,
        mrouteto: map[TablesColumnFile.mrouteto] as String,
    );
  }

  factory CIFBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    print("fromMapMiddleware");
    return CIFBean(
        mcustno: map[TablesColumnFile.mcustno] as int,
        mnid: map[TablesColumnFile.mnid] as String,
        mlbrcode: map[TablesColumnFile.mlbrcode] as int,
        mprdacctid: map[TablesColumnFile.mprdacctid] as String,
        mmoduletype: map[TablesColumnFile.mmoduletype] as int,
        macctstat: map[TablesColumnFile.macctstat] as int,
        mtier: map[TablesColumnFile.mtier] as int,
        mshadowclearbal: map[TablesColumnFile.mshadowclearbal] as double,
        mshadowtotalbal: map[TablesColumnFile.mshadowtotalbal] as double,
        mactualclearbal: map[TablesColumnFile.mactualclearbal] as double,
        mactualtotalbal: map[TablesColumnFile.mactualtotalbal] as double,
        mlienamt: map[TablesColumnFile.mlienamt] as double,
        mmainbal: map[TablesColumnFile.mmainbal] as double,
        //minterestamt: map[TablesColumnFile.minterestamt] as double,
        mtdsamt: map[TablesColumnFile.mtdsamt] as double,
        mnametitle:map[TablesColumnFile.mnametitle] as String,
        mlongname:map[TablesColumnFile.mlongname] as String,
        mdob:map[TablesColumnFile.mdob] as String,
        mpannodesc:map[TablesColumnFile.mpannodesc] as String,
        middesc:map[TablesColumnFile.middesc] as String,
        mreloff:map[TablesColumnFile.mreloff] as String,
        msexcode:map[TablesColumnFile.msexcode] as String,
        mreligioncd:map[TablesColumnFile.mreligioncd] as int,
        mmaritalstatus:map[TablesColumnFile.mmaritalstatus] as int,
        mlangofcust:map[TablesColumnFile.mlangofcust] as String,
        mmailingaddr1:map[TablesColumnFile.mmailingaddr1] as String,
        mmailingaddr2:map[TablesColumnFile.mmailingaddr2] as String,
        mmailingaddr3:map[TablesColumnFile.mmailingaddr3] as String,
        mhomeaddr1:map[TablesColumnFile.mhomeaddr1] as String,
        mhomeaddr2:map[TablesColumnFile.mhomeaddr2] as String,
        mhomeaddr3:map[TablesColumnFile.mhomeaddr3] as String,
        mofficeaddr1:map[TablesColumnFile.mofficeaddr1] as String,
        mofficeaddr2:map[TablesColumnFile.mofficeaddr2] as String,
        mofficeaddr3:map[TablesColumnFile.mofficeaddr2] as String,
        macctstatdesc:map[TablesColumnFile.macctstatdesc] as String,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        mremark:map[TablesColumnFile.mremark] as String,
        mcrdr:map[TablesColumnFile.mcrdr] as String,
        mamt: map[TablesColumnFile.mamt] as double,
        minterestprov: map[TablesColumnFile.minterestprov] as double,
        minterestpaid: map[TablesColumnFile.minterestpaid] as double,
        mmaturityvalue: map[TablesColumnFile.mmaturityvalue] as double,
        mpenalprov: map[TablesColumnFile.mpenalprov] as double,
        mpenalpaid: map[TablesColumnFile.mpenalpaid] as double,
        mdisbursedamt: map[TablesColumnFile.mdisbursedamt] as double,
        mexcessamt: map[TablesColumnFile.mexcessamt] as double,
        mnarration: map[TablesColumnFile.mnarration] as String,
        mcreatedby:map[TablesColumnFile.mcreatedby],
        merror: map[TablesColumnFile.merror] as String,
        momnitxnrefno: map[TablesColumnFile.momnitxnrefno] as String,
        mfreezetype:map[TablesColumnFile.mfreezetype] as int,
        mleadsid: map[TablesColumnFile.mleadsid] as String,
        mbranchname: map[TablesColumnFile.mbranchname] as String,
        mcuststatus: map[TablesColumnFile.mcuststatus] as int,
        misbiometricdeclareflagyn: map[TablesColumnFile.misbiometricdeclareflagyn] as String,
        mprinccurrdue: map[TablesColumnFile.mprinccurrdue] as double,
        mprincoverdue: map[TablesColumnFile.mprincoverdue] as double,
        mintdue: map[TablesColumnFile.mintdue] as double,
        mopendate: map[TablesColumnFile.mopendate] as String,
        mlcybal: map[TablesColumnFile.mlcybal] as double,
        mtotallien: map[TablesColumnFile.mtotallien] as double,
        mintapplied: map[TablesColumnFile.mintapplied] as double,
        mbatchcd: map[TablesColumnFile.mbatchcd] as String,
        msetno: map[TablesColumnFile.msetno] as int,
        mlcytrnamt: map[TablesColumnFile.mlcytrnamt] as double,
        mdisbursmentdate:(map[TablesColumnFile.mdisbursmentdate]=="null"||map[TablesColumnFile.mdisbursmentdate]==null)?
        null:DateTime.parse(map[TablesColumnFile.mdisbursmentdate]) as DateTime,
        moperationdate:(map[TablesColumnFile.moperationdate]=="null"||map[TablesColumnFile.moperationdate]==null)?
        null:DateTime.parse(map[TablesColumnFile.moperationdate]) as DateTime,
        mloanrepayprin: map[TablesColumnFile.mloanrepayprin] as double,
	    mloanrepayint: map[TablesColumnFile.mloanrepayint] as double,
	    mothrchrgpen: map[TablesColumnFile.mothrchrgpen] as double,
	    mloanoutbal: map[TablesColumnFile.mloanoutbal] as double,
        moverdueintcoll: map[TablesColumnFile.moverdueintcoll] as double,
        mentrydate: map[TablesColumnFile.mentrydate] as String,
        mscrollno: map[TablesColumnFile.mscrollno] as int,
        mcurcd: map[TablesColumnFile.mcurcd] as String,
        mrouteto: map[TablesColumnFile.mrouteto] as String,
    );}
}
