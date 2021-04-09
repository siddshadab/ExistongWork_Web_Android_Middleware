
import 'package:eco_mfi/db/TablesColumnFile.dart';

class AccessRightModuleBean{

  int menuid ;
  String menuDesc ;
  String menutype ;
  String parenttype ;
  String murl ;

  String mapplicationtype ;
  int mparentmenuid ;
  int mchartid ;

   int mgrpcd ;
  String musrcode ;
  int  menuId ;
  int create ;
  int  modify ;
  int browse ;
  int authority ;
  int delete ;

  String usrcode;
 


  AccessRightModuleBean(
      {this.menuid,
        this.menuDesc,
        this.menutype,
        this.parenttype,
        this.murl,
        this.mapplicationtype,
        this.mparentmenuid,
        this.mchartid,

        this.mgrpcd,
        this.musrcode,
        this.menuId,
        this.create,
        this.modify,
        this.browse,
        this.authority,
        this.delete,

      });




  factory AccessRightModuleBean.fromMap(Map<String, dynamic> map) {
    return AccessRightModuleBean(
      menuid : map[TablesColumnFile.menuid] as int,
      menuDesc  : map[TablesColumnFile.menuDesc] as String,
      menutype    : map[TablesColumnFile.menutype] as String,
      parenttype    : map[TablesColumnFile.parenttype] as String,
      murl    : map[TablesColumnFile.murl] as String,
      mapplicationtype    : map[TablesColumnFile.mapplicationtype] as String,
      mparentmenuid : map[TablesColumnFile.mparentmenuid] as int,
      mchartid : map[TablesColumnFile.mchartid] as int,

       mgrpcd : map[TablesColumnFile.mgrpcd] as int,
      musrcode  : map[TablesColumnFile.musrcode] as String,
      menuId    : map[TablesColumnFile.menuId] as int,
      create    : map[TablesColumnFile.create] as int,
      modify   : map[TablesColumnFile.modify] as int,
      browse   : map[TablesColumnFile.browse] as int,
      authority   : map[TablesColumnFile.authority] as int,
      delete   : map[TablesColumnFile.delete] as int, 
    );
  }

}





