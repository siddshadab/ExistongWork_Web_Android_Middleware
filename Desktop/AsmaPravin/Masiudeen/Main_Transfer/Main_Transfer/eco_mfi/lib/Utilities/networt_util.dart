import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/CreditBereauCallSubmisiion.dart';
import 'package:eco_mfi/translations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFormationMasterListViewBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterFormationMasterListViewBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:toast/toast.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;


class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

//common service
  static Future<String> callPostService(String tojson,String url,final header,[context]) async{
    String retValue;
    print("yes yahi hai url "+url.toString());
    try {
      final response = await http.post(url, headers: header, body: tojson).timeout(Duration(minutes: 5 ));
      bool fromLoginPage = false;

      if((Constant.apiURL+"userDetailsMaster/loginValidation")==url){
          fromLoginPage = true;
      }
      
    if (response.statusCode == 500 || response.body==null || response.body.toString()=='null') {
      print("status "+ response.statusCode.toString() + " bodyval "+response.body.toString());
      return "404";
    }else   if (response.statusCode == 201 || response.statusCode ==200) {
      print(response.body.toString() +"    here is data ");
      print("coming");
      return response.body;
    }

    else if(response.statusCode==401&&context!=null){
      print("iske andar aaya with status code = ${response.statusCode}" );
      if(fromLoginPage==true){
          globals.Utility.showAlertPopup(context, "Info",Translations.of(context).text("Apk Version mismatch"));
      }else{
           Toast.show(Translations.of(context).text("Apk Version mismatch"), context,duration: 10);
      }
      
     
      return response.body;

    } 
     else if(response.statusCode==402&&context!=null){
      print("iske andar aaya with status code = ${response.statusCode}" );
       if(fromLoginPage==true){
          globals.Utility.showAlertPopup(context, "Info",Translations.of(context).text("Number Of users Exceeded"));
      }else{
      Toast.show(Translations.of(context).text("Number Of users Exceeded"), context,duration: 10);
      }
      return response.body;

    } 
     else if(response.statusCode==403&&context!=null){
      print("iske andar aaya with status code = ${response.statusCode}" );
       if(fromLoginPage==true){
          globals.Utility.showAlertPopup(context, "Info",Translations.of(context).text("Number Of branches Exceeded"));
      }else{
      Toast.show(Translations.of(context).text("Number Of branches Exceeded"), context,duration: 10);
      }
      return response.body;

    } 
    else if(response.statusCode==405&&context!=null){
      print("iske andar aaya with status code = ${response.statusCode}" );
       if(fromLoginPage==true){
          globals.Utility.showAlertPopup(context, "Info",Translations.of(context).text("License Expired"));
      }else{
      Toast.show(Translations.of(context).text("License Expired"), context,duration: 10);
      }
      return response.body;

    } 

    else if(response.statusCode==406&&context!=null){
      print("iske andar aaya with status code = ${response.statusCode}" );
       if(fromLoginPage==true){
          globals.Utility.showAlertPopup(context, "Info",Translations.of(context).text("License not Valid"));
      }else{
      Toast.show(Translations.of(context).text("License not Valid"), context,duration: 10);
      }
      return response.body;

    } 

    
      }catch(_){

      return "404";
    }
    return null;
  }

  //common service
  /*static Future<Response> callPostWithWholeDataService(String tojson,String url,final header) async{
    final response = await http.post(url, headers: header, body: tojson);
    return response;
  }*/

//common service
  static Future<String> callGetService(String url) async{
    try {
      String retValue;
    final response = await http.get(url);
    if (response.statusCode == 201 || response.statusCode ==200) {
      retValue = response.body;
    } else if (response.statusCode == 500 || response.body==null || response.body=='null') {
      retValue = "404";
    }
    return response.body;
   } catch (e) {
      print('Server Exception!!!');
      return "";
    }
  }

  //common service
  static Future<String> callPostServiceHttps(String tojson,String url,final header)async{
    String responsebody =null;
    var httpclient = new HttpClient();
    try{
      httpclient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      await httpclient.postUrl(Uri.parse(url)).then((HttpClientRequest request) {
        request.headers.set('Content-Type', 'application/json');
        request.add(utf8.encode(tojson));
        return request.close();
      }).then((HttpClientResponse response) async {
        if (response == null || response.statusCode == 500 ||
            response.toString() == 'null') {
          responsebody = "404";
        } else if (response.statusCode == 201 || response.statusCode == 200) {
          responsebody = await response.transform(utf8.decoder).join();
        }

      });
    }catch(_){}
    return responsebody;
  }


  static Future<String> callGetServiceHttps(String url) async{
    String responsebody =null;
    var httpclient = new HttpClient();
    httpclient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    try {
      await httpclient.getUrl(Uri.parse(url)).then((HttpClientRequest request) {
        request.headers.set('Content-Type', 'application/json');
        return request.close();
      }).then((HttpClientResponse response) async {
        if (response == null || response.statusCode == 500 ||
            response.toString() == 'null') {
          responsebody = "404";
        } else if (response.statusCode == 201 || response.statusCode == 200) {
          responsebody = await response.transform(utf8.decoder).join();
        }
      });
    } catch(_){}
    return responsebody;

  }


/* static callMultipartRequestForImages(ImageBean bean ,Uri url) async{
    var request = new http.MultipartRequest("POST", url);
    request.fields['imgType'] = 'someone@somewhere.com';

    request.files.add(new http.MultipartFile.fromBytes('imgString', await File.fromUri(Uri.parse(bean.imgString)).readAsBytes(), contentType: new MediaType('image', 'jpeg')));
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }*/

 /* static Future<StreamedResponse> callMultipartRequestForImages(ImageBean bean,String url) async {
    StreamedResponse byteStream;
    print("data here "+ bean.imgString)  ;
    File imageFile =  File(bean.imgString);
    var stream =  new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(url);
    print(" nananananananana " +uri.toString());
    var request =  new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('imgString', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
 *//*   request.files.add( new http.MultipartFile.fromBytes("imgString",
        imageFile.readAsBytesSync(), filename: imageFile.path,
        contentType: new MediaType(" image", "png;boundary=032a1ab685934650abbe059cb45d6ff3")));*//*


    await request.send().then((response) async{
      byteStream = response;
      print(response.statusCode.toString()+" status code here ");
      if (response.statusCode == 200) print("Uploaded!");
      print(response.toString()+" nulnulnulnul");
      print(response.statusCode.toString()+"yahahahahah");
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
      return byteStream;
    });

    return byteStream;

  }*/



  Future<List<CenterFormationMasterListViewBean>> getCenterFoundationList(
      String url) async {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      print(res + " yahi hai woh ");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      final parsed = json.decode(res).cast<Map<String, dynamic>>();

      return parsed
          .map<CenterFormationMasterListViewBean>(
              (json) => CenterFormationMasterListViewBean.fromJson(json))
          .toList();
    });
  }

  Future<List<CreditBereauBean>> getProspectList(String url) async {
    print("inside getProspect List");
    print(url);
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      print(res + " yahi hai woh ");
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      final parsed = json.decode(res).cast<Map<String, dynamic>>();
      return parsed
          .map<CreditBereauBean>((json) => CreditBereauBean.fromJson(json))
          .toList();
    });
  }

  Future<List<GroupFormationMasterListViewBean>> getGroupFormationList(
      String url) async {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      print(res + " yahi hai woh ");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      final parsed = json.decode(res).cast<Map<String, dynamic>>();

      return parsed
          .map<GroupFormationMasterListViewBean>(
              (json) => GroupFormationMasterListViewBean.fromJson(json))
          .toList();
    });
  }

  Future<String> get(String url) {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      print(res + " yahi hai woh ");
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(statusCode);
      print("Data here " + res);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    print("request data " + request.toString());
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print("ReplyData  " + reply.toString());
    // reply["loginStatus"];
    return reply;
  }

  static Future<String> postSaijaMessage(String Content, String contactNo,
      [BuildContext context]) async {
    bool isNetworkAvailable;
    Utility obj = new Utility();
    isNetworkAvailable = await obj.checkIfIsconnectedToNetwork();
    var SMSVerURL = 'https://api.textlocal.in/send/?';
    const JsonCodec JSON = const JsonCodec();
    final _headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    if (isNetworkAvailable) {
      var parsed;
      try {
        String body1 =
            'apiKey=Vlsq0LknQoo-WOAGuq3V7jyucsWvr2hfPgW6mdSeh5&numbers=91${contactNo}&sender=SAIJAF&message=${Content}';
        final response = await http.post(Uri.encodeFull(SMSVerURL),
            body: body1, headers: _headers);

        print("Response Created");
        print(response);
        print(response.statusCode);

        String res = response.body;

        var res2 = res.split(",");
        for (var items in res2) {
          print(items);
        }

        if (response.statusCode == 200) {
          parsed = json.decode(res);
          OTPResponse obj = OTPResponse.fromMap(parsed);
        }
      } catch (e) {
        print('Server Exception!!!');
        print("ghgjhg");
        print(e.toString() + "  is the exception");
        try {
          OTPResponseWarning warn = OTPResponseWarning.fromMap(parsed);
          print(warn.warnings[0]);
        } catch (e) {
          print("Unable to map");
        }
      }
    } else {
      return "Network Not Available";
    }
  }
}
