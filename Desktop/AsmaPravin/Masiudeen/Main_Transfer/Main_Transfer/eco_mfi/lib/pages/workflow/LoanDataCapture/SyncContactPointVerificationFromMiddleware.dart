import 'dart:convert';


import 'dart:io';
import 'dart:typed_data';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:path_provider/path_provider.dart';


class SyncContactPointVerificationFromMiddleware {

  String timestamp() =>
      DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCPVDetails ="cpvBusinessRecord/getCpvByCreatedByAndLastSyncedTiming";
  static const JsonCodec JSON = const JsonCodec();
  CustomerLoanCPVBusinessRecordBean CpvBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      await getCpvMiddlewareData(userName, urlGetCPVDetails);
    }
  }

  Future<Null> getCpvMiddlewareData(String userName, String url) async {

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(22, true)
        .then((onValue) async {
      json = _toJsonOfCreatedByAndLastSyncedDateTime(userName, onValue);
      print(json);
    });

    try {
      String bodyValue = await NetworkUtil.callPostService(
          json.toString(),
          Constant.apiURL.toString() + url.toString(), _headers);

      print("url " + Constant.apiURL.toString() + url.toString());

      if (bodyValue == "404") {
        return null;
      } else {
        print(bodyValue);
        final parsed = JSON.decode(bodyValue).cast<Map<String, dynamic>>();
        DateTime updateDateimeAfterUpdate = DateTime.now();
        List<CustomerLoanCPVBusinessRecordBean> obj = parsed
            .map<CustomerLoanCPVBusinessRecordBean>(
                (json) => CustomerLoanCPVBusinessRecordBean.fromMapMiddleware(json))
            .toList();

        for (int cpv = 0; cpv < obj.length; cpv++) {
          try{
            if(obj[cpv].mpremisesphoto!=null&&obj[cpv].mpremisesphoto.trim()!=''&&obj[cpv].mpremisesphoto.trim()!=null)
              obj[cpv].mpremisesphoto = await getImageStringPath(obj[cpv].mpremisesphoto);
          }catch(_){
          }

          try{
            if(obj[cpv].mpremisesphotosec!=null&&obj[cpv].mpremisesphotosec.trim()!=''&&obj[cpv].mpremisesphotosec.trim()!=null)
              obj[cpv].mpremisesphotosec = await getImageStringPath(obj[cpv].mpremisesphotosec);
          }catch(_){
          }

          try{
            if(obj[cpv].mpremisesphotothird!=null&&obj[cpv].mpremisesphotothird.trim()!=''&&obj[cpv].mpremisesphotothird.trim()!=null)
              obj[cpv].mpremisesphotothird = await getImageStringPath(obj[cpv].mpremisesphotothird);
          }catch(_){
          }

          try{
            if(obj[cpv].mbusinesslicense!=null&&obj[cpv].mbusinesslicense.trim()!=''&&obj[cpv].mbusinesslicense.trim()!=null)
              obj[cpv].mbusinesslicense = await getImageStringPath(obj[cpv].mbusinesslicense);
          }catch(_){
          }


          await AppDatabase.get()
              .updateLoanCPVBusinessRecord(obj[cpv])
              .then((onValue) {
          });
          print("CPV Update Complete");
        }

        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(22, updateDateimeAfterUpdate);

        await AppDatabase.get()
            .selectStaticTablesLastSyncedMaster(22, false)
            .then((onValue) async {
          if (onValue == null) {
            AppDatabase.get().updateStaticTablesLastSyncedMaster(22);
          }
        });
      }
    } catch (e) {
      print('Server Exception!!!');
      print(e);
    }
  }
  String _toJsonOfCreatedByAndLastSyncedDateTime(String createdBy,DateTime lastsyncedDateTime) {
    var mapData = new Map();
    mapData["mcreatedby"] = createdBy.trim();
    mapData["mlastsynsdate"] =  lastsyncedDateTime != null && lastsyncedDateTime != 'null' &&
        lastsyncedDateTime != ''
        ? lastsyncedDateTime.toIso8601String()
        : null;
    String json = JSON.encode(mapData);
    print(json);
    return json;
  }



  Future<String> getImageStringPath(String imageString)async{

    Uint8List bytes =  base64.decode(imageString);
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/eco_mfi/getCPVData';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    File file = new File(filePath);
    if (file.existsSync()) {
      return file.path;
      // bean.imgString = file.path;
      // setBean.imgType=bean.imgType;
      // setBean.imgSubType=bean.imgSubType;

    } else {
      // print(" file bytes  here is " +bytes.toString());
      // setBean.imgType=bean.imgType;
      // setBean.imgSubType=bean.imgSubType;
      await file.writeAsBytes(bytes);
      // print(setBean.imgType.toString()+" file path here is ");
      // print(setBean.imgSubType.toString()+" file path here is ");
      // print(file.path.toString()+" file path here is ");
      return(file.path);


    }

  }
}
