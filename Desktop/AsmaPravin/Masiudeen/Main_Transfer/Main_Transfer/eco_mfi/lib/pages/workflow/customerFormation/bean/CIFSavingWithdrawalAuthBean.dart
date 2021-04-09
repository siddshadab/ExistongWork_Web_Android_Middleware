import 'package:eco_mfi/db/TablesColumnFile.dart';

class CIFSavingWithdrawalAuthBean {
  String musercode;
  int missynctocoresys;
  String mcustname;
  double msubmitamt;
  String merrormessage;
  String mcreatedby;
  DateTime mcreateddt;
  

   int mlbrcode;
	   DateTime mtxndate;
	   String msavingacctno;
	   double macttotbalfcy ;
	   double mtotallienfcy ; 
	   double mwithdrawalamt;
	   String  mremarks ; 
	   DateTime mentrydate;
	   String  mbatchcd  ;
	   int msetno;



  CIFSavingWithdrawalAuthBean({this.musercode,this.missynctocoresys,this.mcustname,this.merrormessage,this.msubmitamt,
  this.mcreatedby,this.mcreateddt,this.mlbrcode,
	     this.mtxndate,
	     this.msavingacctno,
	     this.macttotbalfcy ,
	     this.mtotallienfcy , 
	     this.mwithdrawalamt,
	      this.mremarks , 
	     this.mentrydate,
	      this.mbatchcd  ,
	   this.msetno,
  });

  factory CIFSavingWithdrawalAuthBean.fromMap(Map<String, dynamic> map) {
    return CIFSavingWithdrawalAuthBean(
      musercode: map[TablesColumnFile.musercode1] as String,
       missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
        mcustname: map[TablesColumnFile.mcustname] as String,
      msubmitamt: map[TablesColumnFile.msubmitamt] as double,
      merrormessage: map[TablesColumnFile.merrormessage] as String,
      mcreatedby: map[TablesColumnFile.mcreatedby] as String,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,

       mlbrcode: map[TablesColumnFile.mlbrcode] as int,
	     mtxndate:(map[TablesColumnFile.mtxndate]=="null"||map[TablesColumnFile.mtxndate]==null)?null:DateTime.parse(map[TablesColumnFile.mtxndate]) as DateTime,
	     msavingacctno: map[TablesColumnFile.msavingacctno] as String,
	     macttotbalfcy :  map[TablesColumnFile.macttotbalfcy] as double,
	     mtotallienfcy : map[TablesColumnFile.mtotallienfcy] as double,
	     mwithdrawalamt:map[TablesColumnFile.mwithdrawalamt] as double,
	      mremarks : map[TablesColumnFile.mremarks] as String,
	     mentrydate:(map[TablesColumnFile.mentrydate]=="null"||map[TablesColumnFile.mentrydate]==null)?null:DateTime.parse(map[TablesColumnFile.mentrydate]) as DateTime,
	    
	      mbatchcd  : map[TablesColumnFile.mbatchcd] as String,
	   msetno:map[TablesColumnFile.msetno] as int,
      
    );
  }
}
