import 'dart:async';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanDetailsMasterTab.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/CustomerFormationMasterTabs.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/PPIBean.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import '../main.dart';


class SessionTimeOut {
  BuildContext context;
  SessionTimeOut({this.context});

  

   SessionTimedOut() async {

    globals.sessionTimer?.cancel();
    // duration reset's to a specific time
    print("sessionTimer ${globals.sessionTimer}");
    int autoLogoutInMinutes = 15;
    SharedPreferences prefs;
    try {
      prefs = await SharedPreferences.getInstance();
       autoLogoutInMinutes =
                prefs.getInt(TablesColumnFile.AUTOLOGOUTPERIOD);
    } catch (_) {
      print("globals.sessionTimer Exception${globals.sessionTimer}");
      globals.sessionTimer =
      new Timer(Duration(minutes: autoLogoutInMinutes), logOutUser);
    }
    print("autoLogoutInMinutes-----------------" + autoLogoutInMinutes.toString());
    print(" aagya yaha hamesha jaissa ${autoLogoutInMinutes}");
    if (autoLogoutInMinutes > 0) {
      print("globals.isSyncTapped" + globals.isSyncTapped.toString());
      if (globals.isSyncTapped == true) {
        print("globals.isSyncTapped" + globals.isSyncTapped.toString());
        globals.sessionTimer?.cancel();
      } else {
        print("autoLogoutInMinutes" + autoLogoutInMinutes.toString());

        globals.sessionTimer =
        new Timer(Duration(minutes: autoLogoutInMinutes), logOutUser);
      }
    }
  }



  void logOutUser() {
    navigateUser();
  }



   void navigateUser() async {
    // print("hdsfgsdfy"+this.context.toString());
     try{
       print("Logout krne vala hai");
        Utility.clearDataOfCustomerGlobals();
        print("iske baad bhi chala");
                    
                    CustomerFormationMasterTabsState.custListBean =
                        new CustomerListBean();
                    CustomerFormationMasterTabsState.addressBean =
                        new AddressDetailsBean();
                    CustomerFormationMasterTabsState.fdb =
                        new FamilyDetailsBean();
                    CustomerFormationMasterTabsState.ppiBean =
                        new PPIMasterBean();
                    CustomerFormationMasterTabsState.borrowingDetailsBean =
                        new BorrowingDetailsBean();
                    CustomerFormationMasterTabsState.applicantDob =
                        "__-__-____";
                    CustomerFormationMasterTabsState.loanDate = "__-__-____";
                    CustomerFormationMasterTabsState.repaymentDate =
                        "__-__-____";
                    CustomerFormationMasterTabsState.husDob = "__-__-____";
                    CustomerFormationMasterTabsState.resAddPresent = false;
                    CustomerFormationMasterTabsState.tempBnkAccNo = "";
                    CustomerLoanDetailsMasterTabState
                            .customerLoanDetailsBeanObj =
                        new CustomerLoanDetailsBean();
                    fingerPrintAuthForLoanApplicationDone = false;
                    CustomerLoanDetailsMasterTabState.isMarried = false;
                    globals.forEdit = false;
                    globals.forEditAddCode = 0;

                    print("Logout successfull");

     }catch(_){

     }
     HotRestartController.performHotRestart(this.context);
   }
}
