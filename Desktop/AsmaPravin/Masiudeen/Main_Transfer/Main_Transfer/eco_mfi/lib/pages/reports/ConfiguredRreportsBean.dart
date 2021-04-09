import 'package:eco_mfi/db/TablesColumnFile.dart';

class ConfiguredRreportsBean {

  String values;

  ConfiguredRreportsBean({this.values});



  factory ConfiguredRreportsBean.fromMap(Map<String, dynamic> map) {
    print("inside for map");
    return ConfiguredRreportsBean(
      values:	map[TablesColumnFile.value] as String,

    );

  }


  @override
  String toString() {
    return 'ConfiguredRreportsBean{values: $values}';
  }

  factory ConfiguredRreportsBean.fromMapMiddleware(Map<String, dynamic> map) {
    print("fromMap");
    return ConfiguredRreportsBean(
      values:	map[TablesColumnFile.value] as String,
    );
  }

}
