

import 'package:eco_mfi/db/TablesColumnFile.dart';

class MenuMasterBean{

  int menuid ;
  String menuDesc ;
  String menutype ;
  String parenttype ;
  String murl ;

  String mapplicationtype ;
  int mparentmenuid ;
  int mchartid ;

  MenuMasterBean(
      {this.menuid,
        this.menuDesc,
        this.menutype,
        this.parenttype,
        this.murl,
        this.mapplicationtype,
        this.mparentmenuid,
        this.mchartid,

      });




  factory MenuMasterBean.fromMap(Map<String, dynamic> map) {
    return MenuMasterBean(
      menuid : map[TablesColumnFile.menuid] as int,
      menuDesc  : map[TablesColumnFile.menuDesc] as String,
      menutype    : map[TablesColumnFile.menutype] as String,
      parenttype    : map[TablesColumnFile.parenttype] as String,
      murl    : map[TablesColumnFile.murl] as String,
      mapplicationtype    : map[TablesColumnFile.mapplicationtype] as String,
      mparentmenuid : map[TablesColumnFile.mparentmenuid] as int,
      mchartid : map[TablesColumnFile.mchartid] as int,

    );
  }

}