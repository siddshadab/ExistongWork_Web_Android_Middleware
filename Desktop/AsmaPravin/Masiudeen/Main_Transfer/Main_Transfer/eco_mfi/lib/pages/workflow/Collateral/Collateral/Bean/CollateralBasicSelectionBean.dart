import 'package:eco_mfi/db/TablesColumnFile.dart';

class CollateralBasicSelectionBean {
  int trefno;
  int mrefno;
  int loantrefno;
  int loanmrefno;
  String mleadsid;
  String mprdacctid;
  String mcollateralsid;
  int	msrno ;
  String mfname;
  String mmname;
  String mlname;
  String	mapplicanttype ;
  String collatrlTyp;
  int	mcustno ;
  String	mrelationwithcust ;
  int	mrelationsince ;

  String msubcolltrl;
  String msubocolltrldesc;
  String msubcolltrlcat;
  String msubocolltrlcatdesc;
  String collatrlcat;
  String nametitle;
  String insurance;
  String colltrltitle;
  String mnameoftitledoc;
  String mcollbookno;
  String mcollpageno;
  String mplaceofuse;
  String mwithdrawcond;
  String misappctprimary;
  String mislmap;
  String mnoofattchmnt;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  DateTime mlastsynsdate;
  String merrormessage;
  int missynctocoresys;
  CollateralBasicSelectionBean(
      {
        this.trefno,
        this.mrefno,
        this.loantrefno,
        this.loanmrefno,
        this.mleadsid,
        this.mprdacctid,
        this.msrno,
        this.mapplicanttype,

        this.mcustno,

        this.misappctprimary,
        this.mislmap,
        this.mnoofattchmnt,
        this.mrelationwithcust,
        this.mrelationsince,
        this.mcreateddt,
        this.mcreatedby,
        this.mlastupdatedt,
        this.mlastupdateby,
        this.mgeolocation,
        this.mgeolatd,
        this.mgeologd,
        this.mlastsynsdate,
        this.merrormessage,
        this.mfname,
        this.mmname,
        this.mlname,
        this.collatrlTyp,
        this.msubcolltrl,
        this.msubocolltrldesc,
        this.msubcolltrlcat,
        this.msubocolltrlcatdesc,
        this.collatrlcat,
        //this.relationwithapplicant,
        this.nametitle,
        this.insurance,
        this.colltrltitle,
        this.mnameoftitledoc,
        this.mcollbookno,
        this.mcollpageno,
        this.mplaceofuse,
        this.mwithdrawcond,
        this.mcollateralsid,
        this.missynctocoresys
      });


  factory CollateralBasicSelectionBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return CollateralBasicSelectionBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      loanmrefno:	map[TablesColumnFile.loanmrefno] as int,
      loantrefno:	map[TablesColumnFile.loantrefno] as int,
      mleadsid:	map[TablesColumnFile.mleadsid] as String,
      mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
      msrno:	map[TablesColumnFile.msrno] as int,
      mapplicanttype:	map[TablesColumnFile.mapplicanttype] as String,
      collatrlTyp:map[TablesColumnFile.mcollatrlTyp] as String,

      mcustno:	map[TablesColumnFile.mcustno] as int,
      mrelationwithcust:	map[TablesColumnFile.mrelationwithcust] as String,
      mrelationsince:	map[TablesColumnFile.mrelationsince] as int,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      msubcolltrl: map[TablesColumnFile.msubcolltrl] as String,
      msubocolltrldesc: map[TablesColumnFile.msubocolltrldesc] as String,
      msubcolltrlcat: map[TablesColumnFile.msubcolltrlcat] as String,
      msubocolltrlcatdesc: map[TablesColumnFile.msubocolltrlcatdesc] as String,
      collatrlcat: map[TablesColumnFile.mcollatrlcat] as String,
      //relationwithapplicant: map[TablesColumnFile.mrelationwithapplicant] as String,
      nametitle: map[TablesColumnFile.mnametitle] as String,
      insurance: map[TablesColumnFile.minsurance] as String,
      colltrltitle: map[TablesColumnFile.mcolltrltitle] as String,
      mnameoftitledoc: map[TablesColumnFile.mnameoftitledoc] as String,
      mcollbookno: map[TablesColumnFile.mcollbookno] as String,
      mcollpageno: map[TablesColumnFile.mcollpageno] as String,
      mplaceofuse: map[TablesColumnFile.mplaceofuse] as String,
      mwithdrawcond: map[TablesColumnFile.mwithdrawcond] as String,
      mcollateralsid: map[TablesColumnFile.mcollateralsid] as String,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      misappctprimary: map[TablesColumnFile.misappctprimary] as String,
      mislmap: map[TablesColumnFile.mislmap] as String,
      mnoofattchmnt: map[TablesColumnFile.mnoofattchmnt] as String,


    );

  }
  factory CollateralBasicSelectionBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return CollateralBasicSelectionBean(
      trefno:	map[TablesColumnFile.trefno] as int,
      mrefno:	map[TablesColumnFile.mrefno] as int,
      loanmrefno:	map[TablesColumnFile.loanmrefno] as int,
      loantrefno:	map[TablesColumnFile.loantrefno] as int,
      mleadsid:	map[TablesColumnFile.mleadsid] as String,
      mprdacctid:	map[TablesColumnFile.mprdacctid] as String,
      msrno:	map[TablesColumnFile.msrno] as int,
      mapplicanttype:	map[TablesColumnFile.mapplicanttype] as String,
      collatrlTyp:map[TablesColumnFile.mcollatrlTyp] as String,

      mcustno:	map[TablesColumnFile.mcustno] as int,
      mrelationwithcust:	map[TablesColumnFile.mrelationwithcust] as String,
      mrelationsince:	map[TablesColumnFile.mrelationsince] as int,
      mcreateddt:	(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      merrormessage:map[TablesColumnFile.merrormessage] as String,
      mfname: map[TablesColumnFile.mfname] as String,
      mmname: map[TablesColumnFile.mmname] as String,
      mlname: map[TablesColumnFile.mlname] as String,
      msubcolltrl: map[TablesColumnFile.msubcolltrl] as String,
      msubocolltrldesc: map[TablesColumnFile.msubocolltrldesc] as String,
      msubcolltrlcat: map[TablesColumnFile.msubcolltrlcat] as String,
      msubocolltrlcatdesc: map[TablesColumnFile.msubocolltrlcatdesc] as String,
      collatrlcat: map[TablesColumnFile.mcollatrlcat] as String,
      //relationwithapplicant: map[TablesColumnFile.mrelationwithapplicant] as String,
      nametitle: map[TablesColumnFile.mnametitle] as String,
      insurance: map[TablesColumnFile.minsurance] as String,
      colltrltitle: map[TablesColumnFile.mcolltrltitle] as String,
      mnameoftitledoc: map[TablesColumnFile.mnameoftitledoc] as String,
      mcollbookno: map[TablesColumnFile.mcollbookno] as String,
      mcollpageno: map[TablesColumnFile.mcollpageno] as String,
      mplaceofuse: map[TablesColumnFile.mplaceofuse] as String,
      mwithdrawcond: map[TablesColumnFile.mwithdrawcond] as String,
      mcollateralsid: map[TablesColumnFile.mcollateralsid] as String,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      misappctprimary: map[TablesColumnFile.misappctprimary] as String,
      mislmap: map[TablesColumnFile.mislmap] as String,
      mnoofattchmnt: map[TablesColumnFile.mnoofattchmnt] as String,
    );
  }

}

