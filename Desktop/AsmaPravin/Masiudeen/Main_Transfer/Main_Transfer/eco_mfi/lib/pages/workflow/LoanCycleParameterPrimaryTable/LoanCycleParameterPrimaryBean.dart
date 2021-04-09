

import 'package:eco_mfi/db/TablesColumnFile.dart';

class LoanCycleParameterPrimaryBean {
   int mlbrcode;
   String mprdcd;
   int mloancycle;
   int mcusttype;
   int mgrtype;
   DateTime meffdate;
   double mminamount;
   double mmaxamount;
   int mminperiod;
   int mmaxperiod;
   int mminnoofgrpmems;
   int mmaxnoofgrpmems;
   String mgender;
   int mminage;
   int mmaxage;
   String mgrpcycyn;
   int mlogic;
   int mtenor;
   String mfrequency;
   double mincramount;
   int mnoofinstlclosure;
   int mmultiplefactor;
   DateTime mlastsynsdate;
  LoanCycleParameterPrimaryComposite loanCycleParameterPrimaryComposite;

  LoanCycleParameterPrimaryBean(
      {
        this.mlbrcode,
        this.mprdcd,
        this.mloancycle,
        this.mcusttype,
        this.mgrtype,
        this.meffdate,
        this.mminamount,
        this.mmaxamount,
        this.mminperiod,
        this.mmaxperiod,
        this.mminnoofgrpmems,
        this.mmaxnoofgrpmems,
        this.mgender,
        this.mminage,
        this.mmaxage,
        this.mgrpcycyn,
        this.mlogic,
        this.mtenor,
        this.mfrequency,
        this.mincramount,
        this.mnoofinstlclosure,
        this.mmultiplefactor,
        this.mlastsynsdate,
        this.loanCycleParameterPrimaryComposite


      });
  factory LoanCycleParameterPrimaryBean.fromMap(Map<String, dynamic> map) {
    return LoanCycleParameterPrimaryBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        //mloancycle:map[TablesColumnFile.mloancycle] as int,
        mcusttype:map[TablesColumnFile.mcusttype] as int,
        mgrtype:map[TablesColumnFile.mgrtype] as int,
        meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
        mminamount:map[TablesColumnFile.mminamount] as double,
        mmaxamount:map[TablesColumnFile.mmaxamount] as double,
        mminperiod:map[TablesColumnFile.mminperiod] as int,
        mmaxperiod:map[TablesColumnFile.mmaxperiod] as int,
        mminnoofgrpmems:map[TablesColumnFile.mminnoofgrpmems] as int,
        mmaxnoofgrpmems:map[TablesColumnFile.mmaxnoofgrpmems] as int,
        mgender:map[TablesColumnFile.mgender] as String,
        mminage:map[TablesColumnFile.mminage] as int,
        mmaxage:map[TablesColumnFile.mmaxage] as int,
        mgrpcycyn:map[TablesColumnFile.mgrpcycyn] as String,
        mlogic:map[TablesColumnFile.mlogic] as int,
        mtenor:map[TablesColumnFile.mtenor] as int,
        mfrequency:map[TablesColumnFile.mfrequency] as String,
        mincramount:map[TablesColumnFile.mincramount] as double,
        mnoofinstlclosure:map[TablesColumnFile.mnoofinstlclosure] as int,
        mmultiplefactor:map[TablesColumnFile.mmultiplefactor] as int,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
        loanCycleParameterPrimaryComposite: LoanCycleParameterPrimaryComposite.fromJson(map[TablesColumnFile.loanCycleParameterPrimaryComposite])


    );
  }

  factory LoanCycleParameterPrimaryBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware) {
    print("fromMap");
    return LoanCycleParameterPrimaryBean(
        mlbrcode:map[TablesColumnFile.mlbrcode] as int,
        mprdcd:map[TablesColumnFile.mprdcd] as String,
        mloancycle:map[TablesColumnFile.mloancycle] as int,
        mcusttype:map[TablesColumnFile.mcusttype] as int,
        mgrtype:map[TablesColumnFile.mgrtype] as int,
        meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
        mminamount:map[TablesColumnFile.mminamount] as double,
        mmaxamount:map[TablesColumnFile.mmaxamount] as double,
        mminperiod:map[TablesColumnFile.mminperiod] as int,
        mmaxperiod:map[TablesColumnFile.mmaxperiod] as int,
        mminnoofgrpmems:map[TablesColumnFile.mminnoofgrpmems] as int,
        mmaxnoofgrpmems:map[TablesColumnFile.mmaxnoofgrpmems] as int,
        mgender:map[TablesColumnFile.mgender] as String,
        mminage:map[TablesColumnFile.mminage] as int,
        mmaxage:map[TablesColumnFile.mmaxage] as int,
        mgrpcycyn:map[TablesColumnFile.mgrpcycyn] as String,
        mlogic:map[TablesColumnFile.mlogic] as int,
        mtenor:map[TablesColumnFile.mtenor] as int,
        mfrequency:map[TablesColumnFile.mfrequency] as String,
        mincramount:map[TablesColumnFile.mincramount] as double,
        mnoofinstlclosure:map[TablesColumnFile.mnoofinstlclosure] as int,
        mmultiplefactor:map[TablesColumnFile.mmultiplefactor] as int,
        mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
        loanCycleParameterPrimaryComposite: map[TablesColumnFile.loanCycleParameterPrimaryComposite]==null?null:LoanCycleParameterPrimaryComposite.fromJson(map[TablesColumnFile.loanCycleParameterPrimaryComposite]),



    );}



   factory LoanCycleParameterPrimaryBean.fromMapData(Map<String, dynamic> map) {
     print("fromMap");
     return LoanCycleParameterPrimaryBean(
       mlbrcode:map[TablesColumnFile.mlbrcode] as int,
       mprdcd:map[TablesColumnFile.mprdcd] as String,
       mloancycle:map[TablesColumnFile.mloancycle] as int,
       mcusttype:map[TablesColumnFile.mcusttype] as int,
       mgrtype:map[TablesColumnFile.mgrtype] as int,
       meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,
       mminamount:map[TablesColumnFile.mminamount] as double,
       mmaxamount:map[TablesColumnFile.mmaxamount] as double,
       mminperiod:map[TablesColumnFile.mminperiod] as int,
       mmaxperiod:map[TablesColumnFile.mmaxperiod] as int,
       mminnoofgrpmems:map[TablesColumnFile.mminnoofgrpmems] as int,
       mmaxnoofgrpmems:map[TablesColumnFile.mmaxnoofgrpmems] as int,
       mgender:map[TablesColumnFile.mgender] as String,
       mminage:map[TablesColumnFile.mminage] as int,
       mmaxage:map[TablesColumnFile.mmaxage] as int,
       mgrpcycyn:map[TablesColumnFile.mgrpcycyn] as String,
       mlogic:map[TablesColumnFile.mlogic] as int,
       mtenor:map[TablesColumnFile.mtenor] as int,
       mfrequency:map[TablesColumnFile.mfrequency] as String,
       mincramount:map[TablesColumnFile.mincramount] as double,
       mnoofinstlclosure:map[TablesColumnFile.mnoofinstlclosure] as int,
       mmultiplefactor:map[TablesColumnFile.mmultiplefactor] as int,
       mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,




     );}



}


class LoanCycleParameterPrimaryComposite{
   int mlbrcode;
   String mprdcd;
   DateTime meffdate;
   int mloancycle;
   int mgrttype;
   int mcusttype;

  LoanCycleParameterPrimaryComposite({ this.mlbrcode,
    this.mprdcd,        this.meffdate,this.mloancycle,this.mgrttype,this.mcusttype
  });

  factory LoanCycleParameterPrimaryComposite.fromJson(Map<String, dynamic> map) {

   // print("map of compo "+ map[TablesColumnFile.mloancycle].toString());
    return LoanCycleParameterPrimaryComposite(
      mlbrcode:map[TablesColumnFile.mlbrcode] as int,
      mprdcd:map[TablesColumnFile.mprdcd] as String,
      mloancycle:map[TablesColumnFile.mloancycle] as int,
      mcusttype:map[TablesColumnFile.mcusttype]  as int,
      mgrttype:map[TablesColumnFile.mgrttype] as int,
      meffdate:(map[TablesColumnFile.meffdate]=="null"||map[TablesColumnFile.meffdate]==null)?null:DateTime.parse(map[TablesColumnFile.meffdate]) as DateTime,


    );
  }
}
