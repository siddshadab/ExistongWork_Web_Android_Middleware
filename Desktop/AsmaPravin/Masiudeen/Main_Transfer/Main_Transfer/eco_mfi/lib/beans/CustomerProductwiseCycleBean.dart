import 'package:eco_mfi/db/TablesColumnFile.dart';

class CustomerProductwiseCycleBean{


  int mcycle;
  DateTime mcreateddt;
  String mcreatedby;
  DateTime mlastupdatedt;
  String mlastupdateby;
  String mgeolocation;
  String mgeolatd;
  String mgeologd;
  int missynctocoresys;
  DateTime mlastsynsdate;
  ProductWiseCycleCompositeEntity customerProductwiseCycleCompositeEntity;

  CustomerProductwiseCycleBean(
  {
    this.mcycle,
    this.mcreateddt,
    this.mcreatedby,
    this.mlastupdatedt,
    this.mlastupdateby,
    this.mgeolocation,
    this.mgeolatd,
    this.mgeologd,
    this.missynctocoresys,
    this.mlastsynsdate,
    this.customerProductwiseCycleCompositeEntity
   }
      );
  factory CustomerProductwiseCycleBean.fromMapMiddleware(Map<String, dynamic> map,bool isFromMiddleware){
    return CustomerProductwiseCycleBean(
      mcycle:map[TablesColumnFile.mcycle] as int,
      mcreateddt:(map[TablesColumnFile.mcreateddt]=="null"||map[TablesColumnFile.mcreateddt]==null)?null:DateTime.parse(map[TablesColumnFile.mcreateddt]) as DateTime,
      mcreatedby:map[TablesColumnFile.mcreatedby] as String,
      mlastupdatedt:(map[TablesColumnFile.mlastupdatedt]=="null"||map[TablesColumnFile.mlastupdatedt]==null)?null:DateTime.parse(map[TablesColumnFile.mlastupdatedt]) as DateTime,
      mlastupdateby:map[TablesColumnFile.mlastupdateby] as String,
      mgeolocation:map[TablesColumnFile.mgeolocation] as String,
      mgeolatd:map[TablesColumnFile.mgeolatd] as String,
      mgeologd:map[TablesColumnFile.mgeologd] as String,
      mlastsynsdate:(map[TablesColumnFile.mlastsynsdate]=="null"||map[TablesColumnFile.mlastsynsdate]==null)?null:DateTime.parse(map[TablesColumnFile.mlastsynsdate]) as DateTime,
      missynctocoresys: map[TablesColumnFile.missynctocoresys] as int,
      customerProductwiseCycleCompositeEntity:
       ProductWiseCycleCompositeEntity.fromJson(map[TablesColumnFile.customerProductwiseCycleCompositeEntity]) 

    );
  }





}


class ProductWiseCycleCompositeEntity{
  String mprdcd;
  int mcustno;

  ProductWiseCycleCompositeEntity({this.mprdcd, this.mcustno});

  factory ProductWiseCycleCompositeEntity.fromJson(Map<String, dynamic> json) {
    return ProductWiseCycleCompositeEntity(
      mprdcd:	json[TablesColumnFile.mprdcd] as String,
      mcustno:	json[TablesColumnFile.mcustno] as int,
    );
  }
}



