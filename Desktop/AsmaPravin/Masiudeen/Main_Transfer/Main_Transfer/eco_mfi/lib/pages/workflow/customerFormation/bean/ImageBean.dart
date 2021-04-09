import 'package:eco_mfi/db/TablesColumnFile.dart';

class ImageBean {
  int tImgrefno;
  int trefno;
  int mImgrefno;
  int mrefno;
  String imgType;
  String imgSubType;
  String desc;
  String imgString;
  int mcustno;

  ImageBean(
      {this.tImgrefno,this.trefno,this.mImgrefno,this.mrefno, this.imgType, this.imgSubType, this.desc, this.imgString, this.mcustno});

  factory ImageBean.fromMap(Map<String, dynamic> map) {
    return ImageBean(
      trefno: 	 map[TablesColumnFile.trefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      tImgrefno: 	 map[TablesColumnFile.tImgrefno] as int,
      mImgrefno: 	 map[TablesColumnFile.mImgrefno] as int,
      imgType: map[TablesColumnFile.imageType] as String,
      imgSubType: map[TablesColumnFile.imageSubType] as String,
      imgString: map[TablesColumnFile.imageString] as String,
      desc: map[TablesColumnFile.desc] as String,
      mcustno: map[TablesColumnFile.mcustno] as int,
    );
  }

  factory ImageBean.fromMapFromMiddleWare(Map<String, dynamic> map) {
    return ImageBean(
      trefno: 	 map[TablesColumnFile.trefno] as int,
      mrefno: 	 map[TablesColumnFile.mrefno] as int,
      tImgrefno: 	 map[TablesColumnFile.tImgrefno] as int,
      mImgrefno: 	 map[TablesColumnFile.mImgrefno] as int,
      imgType: map["imgType"] as String,
        imgSubType: map["imgSubType"] as String,
      imgString: map["imgString"] as String,
      desc: map[TablesColumnFile.desc] as String,
      mcustno: map[TablesColumnFile.mcustno] as int,
    );
  }
}
