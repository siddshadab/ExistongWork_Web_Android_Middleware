

import 'dart:convert';

import 'package:eco_mfi/Utilities/app_constant.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/UserVaultBalance/UserVaultBalanceBean.dart';

class UserVaultBalanceSevice{

  static String url = "UserValutBalance/getUserValutBalanceByUSerCode/";
  static final _headers = {'Content-Type': 'application/json'};
  static const JsonCodec JSON = const JsonCodec();

  Future<Null> getMiddleWareData(String musercode) async {

    print("Data after UserValutBalance UserValutBalance UserValutBalance  1");
    try {
      String json2 = _toJsonOfMusercode(musercode);
      final bodyValue = await NetworkUtil.callPostService(json2,Constant.apiURL.toString()+url.toString(),_headers);
      print(" bodyValue ${bodyValue}");
      if(bodyValue==null ||bodyValue=='null'|| bodyValue == '' || bodyValue == "error"){
        return null;
      }
      print("Data after System parameter service  " + bodyValue);
     // final parsed = json.decode(bodyValue).cast<Map<String, dynamic>>();
    Map<String, dynamic> map = JSON.decode(bodyValue);
      await AppDatabase.get().deletSomeSyncingActivityFromOmni('User_Vault_Balance');
      UserVaultBalanceBean obj =  UserVaultBalanceBean.fromMapMiddleware(map);

    //  for (UserVaultBalanceBean items in obj) {
        await AppDatabase.get().updateUserVaultBalanceMaster(obj);
      //}


    } catch (e) {
      print('Server Exception!!!');

    }
  }

 /* Future<UserVaultBalanceBean> _fromUserVaultBalanceBeanJson(String json) async{
   // List<UserVaultBalanceBean> userVaultBalanceBean = new List<UserVaultBalanceBean>();
    List list = JSON.decode(json);
    UserVaultBalanceBean userVaultBalanceBean = UserVaultBalanceBean.fromMapMiddleware(json);


    return userVaultBalanceBean;
  }*/


  Future<Null> trySave(String musercode) async {
    bool isNetworkAvailable;
    isNetworkAvailable = await Utility.checkIntCon();
    Utility utility = new Utility();
   // isNetworkAvailable = await utility.checkIfIsconnectedToNetwork();
    if (isNetworkAvailable) {
      print("Network hai be chutya");
      await getMiddleWareData(musercode);
    }
  }

  String _toJsonOfMusercode(String musercode) {
    var mapData = new Map();
    var mapComposite = new Map();
    mapComposite[TablesColumnFile.musercode1] = musercode;
    mapData[TablesColumnFile.userVaultBalanceCompositetEntity] = mapComposite;
    String json = JSON.encode(mapData);
    print(json.toString());
    return json;
  }

}