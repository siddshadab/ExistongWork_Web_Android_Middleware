import 'dart:typed_data';

import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CustomerLoanImageService {
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();
  String _serviceUrl;
  List customerLoanImageList = List();
  CustomerLoanImageBean setBean;

  Future<Null> syncImage(String jsonList) async {
   // try {
    print(jsonList);
      String bodyValue = await NetworkUtil.callPostService(jsonList,
          Constant.apiURL.toString() + _serviceUrl.toString(), _headers);
      print("url " + Constant.apiURL.toString() + _serviceUrl.toString());

      if (bodyValue == '404'||bodyValue==null) {
        return null;
      } else {

        print("bodyValue is ${bodyValue} ");
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerLoanImageBean> obj = parsed
            .map<CustomerLoanImageBean>((json) => CustomerLoanImageBean.fromMapFromMiddleWare(json))
            .toList();

        for (int loanImage = 0; loanImage< obj.length; loanImage++) {
          await AppDatabase.get()
              .selectCustomerLoanImageOnmreftref(obj[loanImage].mloantrefno, obj[loanImage].mloanmrefno)
              .then((CustomerLoanImageBean loanImageBean) async {

                print("returning query is ${loanImageBean} ");

            String updateCustomerLoanImageQuery = null;

          if (obj[loanImage] != null &&
                  obj[loanImage].mrefno != null &&
                  loanImageBean != null &&
                  loanImageBean.mrefno == null ||
              loanImageBean.mrefno == 0) {
            updateCustomerLoanImageQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' , ${TablesColumnFile.mrefno} = ${obj[loanImage].mrefno} "
                " , ${TablesColumnFile.missynctocoresys} = 1  WHERE ${TablesColumnFile.trefno} = ${obj[loanImage].trefno}";
          } else {
            updateCustomerLoanImageQuery =
                "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}', ${TablesColumnFile.missynctocoresys} = 1 "
                " WHERE ${TablesColumnFile.mrefno} = ${obj[loanImage].mrefno} AND ${TablesColumnFile.trefno} = ${obj[loanImage].trefno}";
          }

            if (updateCustomerLoanImageQuery != null) {
              await AppDatabase.get()
                  .updateCustomerLoanImageQuery(updateCustomerLoanImageQuery);
            }

          });
        }
      }

    /*} catch (e) {
      print('Server Exception!!!');
      print(e);
    }*/
  }


  Future<Null> getAndSync() async {

    try {
      await AppDatabase.get()
          .selectCustomerLoanImageNotSynced()
          .then((List<CustomerLoanImageBean> loanImageList) async {
        for (int i = 0; i < loanImageList.length; i++) {
          try {
            await _toListJson(loanImageList[i]);
          } catch (_) {}
        }

        String json = JSON.encode(customerLoanImageList);
        for (var items in json.toString().split(",")) {
          print("Json values" + items.toString());
        }
        _serviceUrl = "CustomerLoanImage/addCustomerLoanImage/";
        await syncImage(json);

        if (loanImageList != null && loanImageList.isNotEmpty)
          AppDatabase.get().updateStaticTablesLastSyncedMaster(24);
      });
    } catch (e) {
      print('Server Exception!!!');
    }
  }
  Future<Null> getLoanImageForSingleSync(List<CustomerLoanImageBean> loanImageBean) async {

    for (int i = 0; i < loanImageBean.length; i++) {

      await _toListJson(loanImageBean[i]);
    }


    String json = JSON.encode(customerLoanImageList);
    _serviceUrl = "CustomerLoanImage/addCustomerLoanImage/";
    await syncImage(json);

  }

  Future<String> _toListJson(CustomerLoanImageBean bean) async {
    var mapData = new Map();

    mapData[TablesColumnFile.trefno] = bean.trefno != null ? bean.trefno : 0;
    mapData[TablesColumnFile.mrefno] = bean.mrefno != null ? bean.mrefno : 0;
    mapData[TablesColumnFile.mloantrefno] = bean.mloantrefno != null ? bean.mloantrefno: 0;
    mapData[TablesColumnFile.mloanmrefno] = bean.mloanmrefno!= null ? bean.mloanmrefno: 0;
    mapData[TablesColumnFile.timgrefno] = bean.timgrefno!= null ? bean.timgrefno: 0;

    try{


      if (bean.timgrefno > 3 ) {
        mapData[TablesColumnFile.mimagestring] = ifNullCheck(bean.mimagestring);
      } else {
        File imageFile = new File(bean.mimagestring);
        final Directory extDir = await getApplicationDocumentsDirectory();
        var targetPath = extDir.absolute.path + "/temp.png";
        var imgFile = null;

        if(imageFile!=null && targetPath!=null){
          imgFile = await compressAndGetFile(imageFile, targetPath);
          List<int> imageBytes = imgFile.readAsBytesSync();
          String base64Image = base64.encode(imageBytes);
          mapData[TablesColumnFile.mimagestring] = ifNullCheck(base64Image);
        }else{
          mapData[TablesColumnFile.mimagestring] = null;
        }

      }
    }catch(_){
      mapData[TablesColumnFile.mimagestring] = null;
    }

    mapData[TablesColumnFile.mimagetype] = ifNullCheck(bean.mimagetype);
    mapData[TablesColumnFile.mimagebyteorfolder] = 0;



    mapData["mimgsize"] = 0;
    mapData[""] = ifNullCheck(bean.mimagetype);
    mapData[TablesColumnFile.mcreateddt] = bean.mcreateddt.toIso8601String();
    mapData[TablesColumnFile.mcreatedby] = bean.mcreatedby.trim();
    mapData[TablesColumnFile.mlastupdatedt] =
        bean.mlastupdatedt.toIso8601String();
    mapData[TablesColumnFile.mlastupdateby] = ifNullCheck(bean.mlastupdateby);
    mapData[TablesColumnFile.missynctocoresys] = 1;
    mapData[TablesColumnFile.mlastsynsdate] = DateTime.now().toIso8601String();
    if (mapData[TablesColumnFile.mimagestring] != null)
      customerLoanImageList.add(mapData);

    return mapData.toString();
  }

  String ifNullCheck(String value) {
    if (value == null || value == 'null') {
      value = "";
    }
    return value;
  }


  Future<File> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,
      rotate: 0,
    );

    /*print(file.lengthSync());
    print(result.lengthSync());*/

    return result;
  }

  var urlGetLoanImages = "CustomerLoanImage/getLoanImage/";
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  Future<List<CustomerLoanImageBean>> getImageAccordingToLoan(
      CustomerLoanDetailsBean loanDetailsBean) async {
    List<CustomerLoanImageBean> loanImageList =
        new List<CustomerLoanImageBean>();

    var mapData = new Map();
    mapData[TablesColumnFile.mloanmrefno] = loanDetailsBean.mrefno;
    mapData[TablesColumnFile.mloantrefno] = loanDetailsBean.trefno;
    String json = await JSON.encode(mapData);
    print("image k lie json hai ${json}");

    try {
      String bodyValue = await NetworkUtil.callPostService(json.toString(),
          Constant.apiURL.toString() + urlGetLoanImages.toString(), _headers);
      print("url " + Constant.apiURL.toString() + urlGetLoanImages.toString());
      print("returned Value ${bodyValue}");
      if (bodyValue == "404" || bodyValue == null) {
        return null;
      } else {
        final parsed =
            await JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        List<CustomerLoanImageBean> obj = await parsed
            .map<CustomerLoanImageBean>(
                (json) => CustomerLoanImageBean.fromMapFromMiddleWare(json))
            .toList();

        if (obj != null) {
          for (int img = 0; img < obj.length; img++) {
            if (obj[img].mimagestring != null &&
                obj[img].mimagestring != null &&
                obj[img].timgrefno < 4) {
              print("signature or no " + obj[img].mimagetype.toString());
              //  if(imgBean[img].imgString!=null) {
              await getData(obj[img]);
              //  }
            } else {
              setBean = obj[img];
            }
            loanImageList.add(setBean);
            setBean.missynctocoresys = 1;
            await AppDatabaseExtended.get()
                .updateCustomerLoanImageMaster(setBean, obj[img].timgrefno);
          }
        }
      }
    } catch (_) {
      return null;
    }

    print("Images get krne vala method khatam hua");

    return loanImageList;
  }

  Future<Null> getData(CustomerLoanImageBean bean) async {
    await getImageStringPath(bean);
  }

  Future<Null> getImageStringPath(CustomerLoanImageBean bean) async {
    setBean = bean;
    Uint8List bytes = base64.decode(bean.mimagestring);
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath =
        '${extDir.path}/Pictures/eco_mfi/getCustomerLoanImage';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    File file = new File(filePath);
    if (file.existsSync()) {
      setBean.mimagestring = file.path;
      bean.mimagestring = file.path;
      setBean.mimagetype = bean.mimagetype;
      setBean.timgrefno = bean.timgrefno;
      setBean.mloanmrefno = bean.mloanmrefno;
      setBean.mloantrefno = bean.mloantrefno;
      //setBean. = bean.imgSubType;
    } else {
      print(" file bytes  here is " + bytes.toString());
      setBean.mimagetype = bean.mimagetype;

      await file.writeAsBytes(bytes);
      print(setBean.mimagetype.toString() + " file path here is ");
      print(file.path.toString() + " file path here is ");
      setBean.mimagestring = file.path;
      setBean.timgrefno = bean.timgrefno;
      setBean.mloanmrefno = bean.mloanmrefno;
      setBean.mloantrefno = bean.mloantrefno;
    }
  }
}
