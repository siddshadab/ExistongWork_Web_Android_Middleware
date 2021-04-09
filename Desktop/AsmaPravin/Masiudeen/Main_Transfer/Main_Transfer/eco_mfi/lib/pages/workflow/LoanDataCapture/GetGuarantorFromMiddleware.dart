import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:path_provider/path_provider.dart';




class GetGuarantorFromMiddleware{

  String timestamp() =>
      DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

  static Utility obj = new Utility();
  static final _headers = {'Content-Type': 'application/json'};
  var urlGetCPVDetails ="GuarantorController/getGuarantorByCreatedByAndLastSyncedTiming";
  static const JsonCodec JSON = const JsonCodec();
  GuarantorDetailsBean guarantorDetailsBean;

  Future<Null> trySave(String userName) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      await getGuarantorFromMiddlewareData(userName, urlGetCPVDetails);
    }
  }

  Future<Null> getGuarantorFromMiddlewareData(String userName, String url) async {

    String json;
    await AppDatabase.get()
        .selectStaticTablesLastSyncedMaster(23, true)
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
        List<GuarantorDetailsBean> obj = parsed
            .map<GuarantorDetailsBean>(
                (json) => GuarantorDetailsBean.fromMapMiddleware(json))
            .toList();

        for (int guarantor = 0; guarantor < obj.length; guarantor++) {

          if(obj[guarantor].mfacecapture!=null&&obj[guarantor].mfacecapture.trim()!=''&&obj[guarantor].mfacecapture.trim()!=null)
           obj[guarantor].mfacecapture = await getImageStringPath(obj[guarantor].mfacecapture);

           
          if(obj[guarantor].mnrcphoto!=null&&obj[guarantor].mnrcphoto.trim()!=''&&obj[guarantor].mnrcphoto.trim()!=null)
           obj[guarantor].mnrcphoto = await getImageStringPath(obj[guarantor].mnrcphoto);
          
          if(obj[guarantor].mnrcsecphoto!=null&&obj[guarantor].mnrcsecphoto.trim()!=''&&obj[guarantor].mnrcsecphoto.trim()!=null)
           obj[guarantor].mnrcsecphoto = await getImageStringPath(obj[guarantor].mnrcsecphoto);
           
          if(obj[guarantor].mhouseholdphoto!=null&&obj[guarantor].mhouseholdphoto.trim()!=''&&obj[guarantor].mhouseholdphoto.trim()!=null)
           obj[guarantor].mhouseholdphoto = await getImageStringPath(obj[guarantor].mhouseholdphoto);
           
          if(obj[guarantor].mhouseholdsecphoto!=null&&obj[guarantor].mhouseholdsecphoto.trim()!=''&&obj[guarantor].mhouseholdsecphoto.trim()!=null)
           obj[guarantor].mhouseholdsecphoto = await getImageStringPath(obj[guarantor].mhouseholdsecphoto);
           
          if(obj[guarantor].maddressphoto!=null&&obj[guarantor].maddressphoto.trim()!=''&&obj[guarantor].maddressphoto.trim()!=null)
           obj[guarantor].maddressphoto = await getImageStringPath(obj[guarantor].maddressphoto);
            

         obj[guarantor].missynctocoresys=1; 

          await AppDatabase.get()
              .updateGaurantorMaster(obj[guarantor])
              .then((onValue) {
          });
          print("Guarantor Update Complete");
        }

        //updating lastsynced date time with now
        AppDatabase.get().updateStaticTablesLastSyncedMasterGetFromServer(23, updateDateimeAfterUpdate);

        await AppDatabase.get()
            .selectStaticTablesLastSyncedMaster(23, false)
            .then((onValue) async {
          if (onValue == null) {
            AppDatabase.get().updateStaticTablesLastSyncedMaster(23);
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
    final String dirPath = '${extDir.path}/Pictures/eco_mfi/getGuarantorFromMidd';
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
