import 'dart:io';

import 'package:eco_mfi/MenuAndRights/MenuMasterBean.dart';
import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/ManagmentDashBoard.dart';
import 'package:eco_mfi/pages/timelines/ReportUtils.dart';
import 'package:eco_mfi/pages/todo/home/ColourPalleteGenerater.dart';
import 'package:eco_mfi/pages/workflow/CashBookRegister/CashBookRegisterbean.dart';
import 'package:eco_mfi/pages/workflow/Collateral/CollateralREM/Bean/CollateralREMlandandhouseBean.dart';
import 'package:eco_mfi/pages/workflow/Collateral/CollatralVehicle/CollateralVehicleBean.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/GLAccountBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/UserActivity/UserActivityBean.dart';
import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';
import 'package:eco_mfi/pages/workflow/collection/list/DailyLoanCollectionList.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerFingerPrintBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/disbursment/bean/DisbursmentBean.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eco_mfi/models/Tasks.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/InternalBankTransferBean.dart';
import 'package:eco_mfi/main.dart';

class AppDatabaseExtended {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static final CosutomerLoanCashFlowMaster = "Customer_Loan_Cash_Flow_Master";
  static final AppDatabaseExtended appDatabaseExtended =
      new AppDatabaseExtended._internal();
  final glAccountMaster = 'GL_Account_Master';

  AppDatabaseExtended._internal();

  Database _database;

  static AppDatabaseExtended get() {
    return appDatabaseExtended;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async {
    if (!didInit) await init();
    return _database;
  }

  Future init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "microfinance.db");
    _database = await openDatabase(path, version: 6,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {});
    didInit = true;
  }

  Future<int> deleteDate(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete("Delete FROM ${query}");
    });
  }

  Future<UserActivityBean> selectUserActivityOnTrefANDMrefno(
      int trefno, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${AppDatabase.UserActivityMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And  ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    UserActivityBean bean;
    if (result.isEmpty) {
      selectQueryIsDataSynced =
          'SELECT * FROM ${AppDatabase.UserActivityMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno  AND ${TablesColumnFile.mrefno}  = 0 ';
      print(selectQueryIsDataSynced);
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new UserActivityBean();
        bean = bindUserAcitvity(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  UserActivityBean bindUserAcitvity(Map<String, dynamic> result) {
    UserActivityBean userActivityBean = new UserActivityBean();
    return UserActivityBean.fromMap(result);
  }

  Future<List<UserActivityBean>> getUserActivityNotSynced() async {
    List<UserActivityBean> returnedList = new List<UserActivityBean>();
    String selectQueryIsDataSynced =
        'SELECT * FROM ${AppDatabase.UserActivityMaster}  WHERE ${TablesColumnFile.mrefno}  = 0 OR ${TablesColumnFile.mrefno}  IS NULL ';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    UserActivityBean bean;

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new UserActivityBean();
        bean = bindUserAcitvity(result[i]);
        returnedList.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return returnedList;
  }

  Future<int> getMaxTrefnoForInternalTransfer() async {
    String insertQuery = "SELECT *"
        "FROM    ${AppDatabase.internalBankTransferMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${AppDatabase.internalBankTransferMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
      if (retValue == null) {
        retValue = 0;
      }
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  Future<List<InternalBankTransferBean>>
      getInternalTransactionsNotSynced() async {
    var db = await _getDb();
    InternalBankTransferBean retBean = new InternalBankTransferBean();
    List<InternalBankTransferBean> n = new List<InternalBankTransferBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced =
        'SELECT * FROM ${AppDatabase.internalBankTransferMaster}  WHERE  '
        '${TablesColumnFile.missynctocoresys} = 0  OR   ${TablesColumnFile.missynctocoresys} IS NULL ';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindInternalBankTransferDetails(result[i]);

        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  InternalBankTransferBean bindInternalBankTransferDetails(
      Map<String, dynamic> result) {
    return InternalBankTransferBean.fromMap(result);
  }

  Future<InternalBankTransferBean> selectInterTransferBean(
      int trefno, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${AppDatabase.internalBankTransferMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno  AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    InternalBankTransferBean bean;
    if (result.isEmpty) {
      selectQueryIsDataSynced =
          'SELECT * FROM ${AppDatabase.internalBankTransferMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = 0 ';
      print(selectQueryIsDataSynced);
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new InternalBankTransferBean();
        bean = bindInternalBankTransferDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateInterBankTransferTable(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${AppDatabase.internalBankTransferMaster} SET ${query}");
    });
  }

  Future<CashBookRegisterBean> getUserActivity(DateTime operationDate) async {
    CashBookRegisterBean reObj = new CashBookRegisterBean();
    reObj.inflowcahstransaction = 0.0;
    reObj.outflowcashtransaction = 0.0;
    reObj.overallloancollection = 0.0;
    reObj.overallsavingscollection = 0.0;
    reObj.oflnloancolltrnsnos = 0;
    reObj.onlnloancolltrnsnos = 0;
    reObj.oflnsvngcolltrnsnos = 0;
    reObj.onlnnsvngcolltrnsnos = 0;
    reObj.loanclsrtrnsnos = 0;
    reObj.svngclsrtrnsnos = 0;
    reObj.tdopngtrnsnos = 0;
    reObj.tdclsrtrnsnos = 0;
    reObj.inflowtrnsnos = 0;
    reObj.outflowtrnsnos = 0;
    reObj.onlnsvngwdrwltrnsno = 0;

    reObj.offlineLoanDisbursment = 0.0;
    reObj.overallLoanDisbursment = 0.0;

    reObj.oflnloandisbtrnsno = 0;
    reObj.onlnloandisbtrnsno = 0;
    reObj.onlineBulkloanclosure = 0.0;
    reObj.blkloanclsrtrnsnos = 0;
    reObj.overallloanclosure = 0.0;
    reObj.onlineloanclosure = 0.0;

    reObj.onlninflwothrtrnsnos = 0;
    reObj.oflninflwothrtrnsnos = 0;
    reObj. onlnoutflwothrtrnsnos = 0;
    reObj. oflnoutflwothrtrnsnos = 0;

    reObj. inflwothrtrnsamt = 0.0;
    reObj. outflwothrtrnsamt = 0.0;
    reObj. inflwothrtrnsnos = 0;
    reObj. outflwothrtrnsnos = 0;


    reObj.oflninflwdisbamt = 0.0;
    reObj.oflninflwdisbtrnsnos = 0;



    var db = await _getDb();
    if(operationDate==null){
      operationDate= DateTime.now();
    }
    print("Andar aaya ${operationDate}");

    String query =
        "Select SUM(${TablesColumnFile.mtxnamount}) AS totalflow , ${TablesColumnFile.mactivity}"
        " , ${TablesColumnFile.mmoduletype} , ${TablesColumnFile.mentrydate}, COUNT(*) as ${TablesColumnFile.transactioncount}  from ${AppDatabase.UserActivityMaster}  WHERE  ${TablesColumnFile.mentrydate} = '${operationDate}' GROUP BY  ${TablesColumnFile.mactivity} , "
        "${TablesColumnFile.mmoduletype}  ";

    print(query);
    var result = await db.rawQuery(query);

    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        if (result[i][TablesColumnFile.mactivity] ==
                TablesColumnFile.INSTALPAY &&
            result[i][TablesColumnFile.mmoduletype] == 30) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlineLoanCollection = 0.0;
            reObj.inflowcahstransaction += 0.0;
          } else {
            reObj.onlineLoanCollection = result[i][TablesColumnFile.totalflow];
            reObj.inflowcahstransaction +=
                result[i][TablesColumnFile.totalflow];
            reObj.overallloancollection +=
                result[i][TablesColumnFile.totalflow];
            reObj.onlnloancolltrnsnos =
                result[i][TablesColumnFile.transactioncount];
            reObj.inflowtrnsnos += result[i][TablesColumnFile.transactioncount];
          }
        } else if (result[i][TablesColumnFile.mactivity] ==
                TablesColumnFile.DEPOSIT &&
            result[i][TablesColumnFile.mmoduletype] == 11) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlinesavingsCollection = 0.0;
            reObj.inflowcahstransaction += 0.0;
          } else {
            reObj.onlinesavingsCollection =
                result[i][TablesColumnFile.totalflow];
            reObj.inflowcahstransaction +=
                result[i][TablesColumnFile.totalflow];
            reObj.overallsavingscollection +=
                result[i][TablesColumnFile.totalflow];
            reObj.onlnnsvngcolltrnsnos =
                result[i][TablesColumnFile.transactioncount];
            reObj.inflowtrnsnos += result[i][TablesColumnFile.transactioncount];
          }
        } else if (result[i][TablesColumnFile.mactivity] ==
                TablesColumnFile.WITHDRAWAL &&
            result[i][TablesColumnFile.mmoduletype] == 11) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlinesavingswithdrawal = 0.0;
            reObj.inflowcahstransaction += 0.0;
          } else {
            reObj.onlinesavingswithdrawal =
                result[i][TablesColumnFile.totalflow];
            reObj.outflowcashtransaction +=
                result[i][TablesColumnFile.totalflow];
            reObj.onlnsvngwdrwltrnsno =
                result[i][TablesColumnFile.transactioncount];
            reObj.outflowtrnsnos +=
                result[i][TablesColumnFile.transactioncount];
          }
        } else if (result[i][TablesColumnFile.mactivity] ==
                TablesColumnFile.CLOSURE &&
            result[i][TablesColumnFile.mmoduletype] == 11) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlinesavingsclosure = 0.0;
            reObj.inflowcahstransaction += 0.0;
          } else {
            reObj.onlinesavingsclosure = result[i][TablesColumnFile.totalflow];
            reObj.inflowcahstransaction +=
                result[i][TablesColumnFile.totalflow];
            reObj.svngclsrtrnsnos =
                result[i][TablesColumnFile.transactioncount];
            reObj.outflowtrnsnos +=
                result[i][TablesColumnFile.transactioncount];
          }
        } else if (result[i][TablesColumnFile.mactivity] ==
                TablesColumnFile.CLOSURE &&
            result[i][TablesColumnFile.mmoduletype] == 30) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlineloanclosure = 0.0;
            reObj.inflowcahstransaction += 0.0;
          } else {
            reObj.onlineloanclosure = result[i][TablesColumnFile.totalflow];
            reObj.inflowcahstransaction +=
                result[i][TablesColumnFile.totalflow];
            reObj.overallloanclosure += result[i][TablesColumnFile.totalflow];
            reObj.loanclsrtrnsnos =
                result[i][TablesColumnFile.transactioncount];
            reObj.inflowtrnsnos += result[i][TablesColumnFile.transactioncount];
          }
        } else if (result[i][TablesColumnFile.mactivity] ==
                TablesColumnFile.BULKLOANCLOSURE &&
            result[i][TablesColumnFile.mmoduletype] == 30) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlineBulkloanclosure = 0.0;
            reObj.inflowcahstransaction += 0.0;
          } else {
            reObj.onlineBulkloanclosure = result[i][TablesColumnFile.totalflow];
            reObj.inflowcahstransaction +=
                result[i][TablesColumnFile.totalflow];
            reObj.overallloanclosure += result[i][TablesColumnFile.totalflow];
            reObj.blkloanclsrtrnsnos =
                result[i][TablesColumnFile.transactioncount];
            reObj.inflowtrnsnos += result[i][TablesColumnFile.transactioncount];
          }
        } else if (result[i][TablesColumnFile.mactivity] ==
                TablesColumnFile.CLOSURE &&
            result[i][TablesColumnFile.mmoduletype] == 20) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.outflowtdclosure = 0.0;
            reObj.inflowcahstransaction += 0.0;
          } else {
            reObj.outflowtdclosure = result[i][TablesColumnFile.totalflow];
            reObj.outflowcashtransaction +=
                result[i][TablesColumnFile.totalflow];
            reObj.loanclsrtrnsnos =
                result[i][TablesColumnFile.transactioncount];
            reObj.outflowtrnsnos +=
                result[i][TablesColumnFile.transactioncount];
          }
        } else if (result[i][TablesColumnFile.mactivity] ==
                TablesColumnFile.DISBURSMENT &&
            result[i][TablesColumnFile.mmoduletype] == 30) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlineLoanDisbursment = 0.0;
            reObj.outflowcashtransaction += 0.0;
          } else {
            reObj.onlineLoanDisbursment = result[i][TablesColumnFile.totalflow];
            reObj.outflowcashtransaction +=
                result[i][TablesColumnFile.totalflow];
            reObj.onlnloandisbtrnsno =
                result[i][TablesColumnFile.transactioncount];
            reObj.outflowtrnsnos +=
                result[i][TablesColumnFile.transactioncount];
          }
        }
        else if (result[i][TablesColumnFile.mactivity] ==
            TablesColumnFile.INTERNALBANKTRANSFERCR ) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlninflowoothrtrnsamt = 0.0;
            reObj.inflowcahstransaction += 0.0;
          } else {
            reObj.onlninflowoothrtrnsamt = result[i][TablesColumnFile.totalflow];
            reObj.inflowcahstransaction +=
            result[i][TablesColumnFile.totalflow];
            reObj.inflwothrtrnsamt += result[i][TablesColumnFile.totalflow];
            reObj.onlninflwothrtrnsnos =
            result[i][TablesColumnFile.transactioncount];
            reObj.inflowtrnsnos += result[i][TablesColumnFile.transactioncount];
          }
        }

        else if (result[i][TablesColumnFile.mactivity] ==
            TablesColumnFile.INTERNALBANKTRANSFERDR ) {
          if (result[i][TablesColumnFile.totalflow] == null) {
            reObj.onlnoutflwowoothrtrnsamt = 0.0;
            reObj.outflowcashtransaction += 0.0;

          } else {
            reObj.onlnoutflwowoothrtrnsamt = result[i][TablesColumnFile.totalflow];

            reObj.outflowcashtransaction +=
            result[i][TablesColumnFile.totalflow];
            reObj.onlnoutflwothrtrnsnos =
            result[i][TablesColumnFile.transactioncount];
            reObj.outflowtrnsnos +=
            result[i][TablesColumnFile.transactioncount];
          }
        }
      }
    }
//Offline Loan Collection----------------------------------------------
    query =
        "Select SUM(${TablesColumnFile.mcollamt}) AS totalflow , COUNT(*) as ${TablesColumnFile.transactioncount} "
        "from ${AppDatabase.collectedLoansAmtMaster}  WHERE  ${TablesColumnFile.mlastopendate} = '${operationDate}' ";

    print(query);
    result = await db.rawQuery(query);
    if (result != null) {
      reObj.offlineLoanCollection =
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.inflowcahstransaction +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;

      reObj.overallloancollection +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;

      reObj.oflnloancolltrnsnos =
          result[0][TablesColumnFile.transactioncount] ?? 0;
      reObj.inflowtrnsnos += result[0][TablesColumnFile.transactioncount] ?? 0;
    }

    //Offline Savings Collection----------------------------------------------
    query =
        "Select SUM(${TablesColumnFile.mcollectedamount}) AS totalflow , COUNT(*) as ${TablesColumnFile.transactioncount} "
        "from ${AppDatabase.savingsCollectionMaster} WHERE  ${TablesColumnFile.moperationdate} = '${operationDate}' ";

    print(query);
    result = await db.rawQuery(query);
    if (result != null) {
      reObj.offlinesavingscollection =
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.inflowcahstransaction +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.overallsavingscollection +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;

      reObj.oflnsvngcolltrnsnos =
          result[0][TablesColumnFile.transactioncount] ?? 0;
      reObj.inflowtrnsnos += result[0][TablesColumnFile.transactioncount] ?? 0;
    }

    //Offline TErm Dposit----------------------------------------------
    query =
        "SELECT SUM(${TablesColumnFile.mmainbalfcy}) AS totalflow , COUNT(*) as ${TablesColumnFile.transactioncount} FROM ${AppDatabase.TermDepositMaster} "
        " WHERE    ${TablesColumnFile.moperationdate} = '${operationDate}' ";

    print(query);
    result = await db.rawQuery(query);
    if (result != null) {
      reObj.inflowtdopening = result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.inflowcahstransaction +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.tdopngtrnsnos = result[0][TablesColumnFile.transactioncount] ?? 0.0;

      reObj.inflowtrnsnos += result[0][TablesColumnFile.transactioncount] ?? 0;
    }

    query =
        "Select SUM(${TablesColumnFile.mdisbamount}) AS totalflow , COUNT(*) as ${TablesColumnFile.transactioncount} "
            ",SUM (${TablesColumnFile.mchargesamt0}) AS  ${TablesColumnFile.mchargesamt0} , SUM(${TablesColumnFile.mchargesamt1}) AS ${TablesColumnFile.mchargesamt1} ,   "
            " SUM (${TablesColumnFile.mchargesamt2}) AS  ${TablesColumnFile.mchargesamt2} , SUM(${TablesColumnFile.mchargesamt3}) AS ${TablesColumnFile.mchargesamt3} ,   "
            " SUM (${TablesColumnFile.mchargesamt4}) AS  ${TablesColumnFile.mchargesamt4} , SUM(${TablesColumnFile.mchargesamt5}) AS ${TablesColumnFile.mchargesamt5} ,   "
            " SUM (${TablesColumnFile.mchargesamt6}) AS  ${TablesColumnFile.mchargesamt6} , SUM(${TablesColumnFile.mchargesamt7}) AS ${TablesColumnFile.mchargesamt7} ,   "
            "  SUM (${TablesColumnFile.mchargesamt8}) AS  ${TablesColumnFile.mchargesamt8} , SUM(${TablesColumnFile.mchargesamt9}) AS ${TablesColumnFile.mchargesamt9}    "
        " from ${AppDatabase.disbursedMaster} WHERE  ${TablesColumnFile.mdisburseddate} = '${operationDate}' AND ${TablesColumnFile.mdisbstatus} = 1 ";

    print(query);
    result = await db.rawQuery(query);
    if (result != null) {
      reObj.offlineLoanDisbursment =
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.outflowcashtransaction +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.overallLoanDisbursment +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;

      reObj.oflnloandisbtrnsno =
          result[0][TablesColumnFile.transactioncount] ?? 0;
      reObj.outflowtrnsnos += result[0][TablesColumnFile.transactioncount] ?? 0;



      //Collextion of Service Charges-------------
      reObj.oflninflwdisbamt = 0.0;
      reObj.oflninflwdisbtrnsnos = 0;

      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt0] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt1] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt2] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt3] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt4] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt5] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt6] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt7] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt8] ?? 0.0;
      reObj.oflninflwdisbamt +=
          result[0][TablesColumnFile.mchargesamt9] ?? 0.0;

      reObj.inflowcahstransaction += reObj.oflninflwdisbamt;

      reObj.oflninflwdisbtrnsnos =
          result[0][TablesColumnFile.transactioncount] ?? 0.0;
      reObj.inflowtrnsnos += reObj.oflninflwdisbtrnsnos;





    }

    //------------------------Internal Transactions---------------------------------------
    query =
    "Select SUM(${TablesColumnFile.mamt}) AS totalflow , COUNT(*) as ${TablesColumnFile.transactioncount} "
        "  "
        "from ${AppDatabase.internalBankTransferMaster} WHERE  ${TablesColumnFile.mcrdr} = 'D' AND ${TablesColumnFile.mcashtr} = 1 "
        " AND  ${TablesColumnFile.moperationdate} = '${operationDate}' ";

    print(query);
    result = await db.rawQuery(query);
    if (result != null) {
      reObj.oflnoutflwowoothrtrnsamt =
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.outflowcashtransaction +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.outflwothrtrnsamt +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;

      reObj.oflnoutflwothrtrnsnos =
          result[0][TablesColumnFile.transactioncount] ?? 0;
      reObj.outflowtrnsnos += result[0][TablesColumnFile.transactioncount] ?? 0;



    }



    query =
    "Select SUM(${TablesColumnFile.mamt}) AS totalflow , COUNT(*) as ${TablesColumnFile.transactioncount} "
        "  "
        "from ${AppDatabase.internalBankTransferMaster} WHERE  ${TablesColumnFile.mcrdr} = 'C' AND ${TablesColumnFile.mcashtr} = 1 "
        " AND  ${TablesColumnFile.moperationdate} = '${operationDate}' ";

    print(query);
    result = await db.rawQuery(query);
    if (result != null) {
      reObj.oflninflowoothrtrnsamt =
          result[0][TablesColumnFile.totalflow] ?? 0.0;
      reObj.inflowcahstransaction +=
          result[0][TablesColumnFile.totalflow] ?? 0.0;
//      reObj.oflnoutflwowoothrtrnsamt +=
//          result[0][TablesColumnFile.totalflow] ?? 0.0;

      reObj.oflninflwothrtrnsnos =
          result[0][TablesColumnFile.transactioncount] ?? 0;
      reObj.inflwothrtrnsnos += result[0][TablesColumnFile.transactioncount] ?? 0;
      reObj.inflowtrnsnos += result[0][TablesColumnFile.transactioncount] ?? 0;


    }








    print("Returning object ${reObj}");

    return reObj;
  }

  Future<List<UserActivityBean>> getUserActivityList(
      int moduletype, String mactivity, DateTime mentrydate) async {
    UserActivityBean userActivityBean = new UserActivityBean();
    List<UserActivityBean> retBeanList = new List<UserActivityBean>();
    String query =
        "SELECT * FROM ${AppDatabase.UserActivityMaster} WHERE ${TablesColumnFile.mmoduletype} = ${moduletype} "
        " AND ${TablesColumnFile.mactivity} = '${mactivity}' AND ${TablesColumnFile.mentrydate} = '${mentrydate}'  ";

    print(query);
    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        //for (var items in result[i].toString().split(",")) {}
        print(result[i]);
        userActivityBean = bindUserAcitvity(result[i]);
        print("exiting from map");
        retBeanList.add(userActivityBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBeanList;
  }

  Future<List<CollectionMasterBean>> getOfflineCollectionList(
      DateTime mentrydate) async {
    CollectionMasterBean collectedBean = new CollectionMasterBean();
    List<CollectionMasterBean> retBeanList = new List<CollectionMasterBean>();
    String query =
        "SELECT * FROM ${AppDatabase.collectedLoansAmtMaster} WHERE ${TablesColumnFile.mlastopendate} = '${mentrydate}' ";
    print(query);
    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        //for (var items in result[i].toString().split(",")) {}
        print(result[i].runtimeType);
        collectedBean = CollectionMasterBean.fromMap(result[i]);
        ;
        print("exiting from map");
        retBeanList.add(collectedBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBeanList;
  }

  Future<List<SavingsListBean>> getOfflineSavingsCollection(
      DateTime mentrydate) async {
    SavingsListBean savingsBean = new SavingsListBean();
    List<SavingsListBean> retBeanList = new List<SavingsListBean>();
    String query =
        "SELECT * FROM ${AppDatabase.savingsCollectionMaster} WHERE ${TablesColumnFile.moperationdate} = '${mentrydate}' ";
    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        //for (var items in result[i].toString().split(",")) {}
        print(result[i].runtimeType);
        savingsBean = bindDataSavingsListBean(result[i]);
        print("exiting from map");
        retBeanList.add(savingsBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBeanList;
  }

  SavingsListBean bindDataSavingsListBean(Map<String, dynamic> result) {
    SavingsListBean savingsListBean = new SavingsListBean();
    return SavingsListBean.fromMap(result);
  }

  Future<List<DisbursmentBean>> getOfflineDisbursment(
      DateTime mentrydate) async {
    DisbursmentBean retBean = new DisbursmentBean();
    List<DisbursmentBean> retBeanList = new List<DisbursmentBean>();
    String query =
        "SELECT * FROM ${AppDatabase.disbursedMaster} WHERE ${TablesColumnFile.mentrydate} = '${mentrydate}' ";
    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        //for (var items in result[i].toString().split(",")) {}
        print(result[i].runtimeType);
        retBean = DisbursmentBean.fromMap(result[i]);
        print("exiting from map");
        retBeanList.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBeanList;
  }

  Future<double> getLoanCycleWiseLimit(int loancycle) async {
    double retValue = 0.0;
    try {
      var db = await _getDb();
      var result;
      print("query is" +
          "Select * from ${AppDatabase.loanCycleWiseLimitMaster} WHERE  ${TablesColumnFile.mloancycle} = ${loancycle}  ;");
      result = await db.rawQuery(
          " Select * from ${AppDatabase.loanCycleWiseLimitMaster} WHERE  ${TablesColumnFile.mloancycle} = ${loancycle}  ;");
      print(result);
      try {
        retValue = result[0][TablesColumnFile.mloanlimit];
      } catch (e) {
        retValue = 0.0;
      }

      if (retValue == 0.0 || retValue == null) {
        print("query is" +
            "Select * from ${AppDatabase.loanCycleWiseLimitMaster} WHERE  ${TablesColumnFile.mloancycle} = ${99}  ;");
        result = await db.rawQuery(
            " Select * from ${AppDatabase.loanCycleWiseLimitMaster} WHERE  ${TablesColumnFile.mloancycle} = ${99}  ;");
        print(result);
        try {
          retValue = result[0][TablesColumnFile.mloanlimit];
          if (retValue == 0.0 || retValue == null) {
            retValue = 125000;

          }


        } catch (e) {
          retValue = 125000;
        }
      }
    } catch (e) {
      retValue = 125000;
    }
    return retValue;
  }

  //Insert ImageMaster
  Future updateCustomerFingerPrintMaster(CustomerFingerPrintBean listImgBean, int tImagerefNo) async {
    var db = await _getDb();
    String insertQuery = "INSERT OR REPLACE INTO ${AppDatabase.customerFingerPrintMaster} ( "
        "${TablesColumnFile.timagerefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mimagerefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mimagetype} ,"
        "${TablesColumnFile.mimagesubtype} ,"
        "${TablesColumnFile.desc} ,"
        "${TablesColumnFile.mimagestring} ,"
        "${TablesColumnFile.mcustno} "
        ") VALUES ("
        "${tImagerefNo} ,"
        "${listImgBean.trefno} ,"
        "${listImgBean.mimagerefno} ,"
        "${listImgBean.mrefno} ,"
        "'${listImgBean.mimagetype}' ,"
        "'${listImgBean.mimagesubtype}' ,"
        "'${listImgBean.desc}' ,"
        "'${listImgBean.mimagestring}' , "
        "${listImgBean.mcustno} "
        ");";

    print("insert query is ${insertQuery}");

    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${AppDatabase.customerFingerPrintMaster}");
    });
  }




  Future<List<CustomerFingerPrintBean>> selectFingerPrintList(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${AppDatabase.customerFingerPrintMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<CustomerFingerPrintBean> listbean = new List<CustomerFingerPrintBean>();
    CustomerFingerPrintBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerFingerPrintBean();
        bean = bindDataFingerPrintListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }


  CustomerFingerPrintBean bindDataFingerPrintListBean(Map<String, dynamic> result) {
    return CustomerFingerPrintBean.fromMap(result);
  }


  Future<List<CustomerFingerPrintBean>> getFingerListByCustNo(int mcustno) async {
    var db = await _getDb();
    var result = [];

    result = await db.rawQuery(
        'SELECT * FROM ${AppDatabase.customerFingerPrintMaster} where ${TablesColumnFile.mrefno} = (Select ${TablesColumnFile.mrefno} from ${AppDatabase.customerFoundationMasterDetails} '
            ' WHERE ${TablesColumnFile.mcustno} = ${mcustno} )');
    print("result" + result.toString());
    List<CustomerFingerPrintBean> listbean = new List<CustomerFingerPrintBean>();
    CustomerFingerPrintBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerFingerPrintBean();
        bean = bindDataFingerPrintListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }



  Future<List<CustomerFingerPrintBean>> getFingerList(int trefno, int mrefno) async {
    var db = await _getDb();
    print(
        'SELECT * FROM ${AppDatabase.customerFingerPrintMaster} where ${TablesColumnFile.trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno ');
    var result = await db.rawQuery(
        'SELECT * FROM ${AppDatabase.customerFingerPrintMaster} where ${TablesColumnFile.trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno ');
    print("result" + result.toString());
    List<CustomerFingerPrintBean> listbean = new List<CustomerFingerPrintBean>();
    CustomerFingerPrintBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerFingerPrintBean();
        bean = bindDataFingerPrintListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }


  Future updateFingerPrintMaster(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Image --- UPDATE ${AppDatabase.customerFingerPrintMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${AppDatabase.customerFingerPrintMaster} SET ${query}");
    });
  }

  Future<int> updateChartsFavouriteMaster(
      ChartFavouriteBean chartsFavouriteBean) async {
    String insertQuery =
        "INSERT OR REPLACE INTO ${AppDatabase.chartFavouriteMaster} (  "
        " ${TablesColumnFile.mrefno} , "
        "${TablesColumnFile.mcharttype},"
        "${TablesColumnFile.mchartfavtype}"
        ") VALUES ( "
        "${chartsFavouriteBean.mrefno},"
        "'${chartsFavouriteBean.mcharttype}',"
        "'${chartsFavouriteBean.mchartfavtype}'"
        ");";

    print(insertQuery);

    var db = await _getDb();
    int id = 0;
    await db.transaction((Transaction txn) async {
      id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${AppDatabase.chartFavouriteMaster}");
    });

    return id;

  }

  Future<int> getCountFavouriteCharts() async{


    String insertQuery = "SELECT COUNT(*) FROM ${AppDatabase.chartFavouriteMaster} " ;
    var result;
    var db = await _getDb();
    int count = 0;
    result = await db.rawQuery(insertQuery);
    try{
      count = result["count"];
    }catch(_){
      count = 0;
    }

    return count;




  }


  Future<ChartFavouriteBean> getChartsBean(int mrefno, String mcharttype ) async{
    var result;
    var db = await _getDb();
    ChartFavouriteBean retBean;

    String selectQuery = "SELECT * FROM ${AppDatabase.chartFavouriteMaster} WHERE ${TablesColumnFile.mrefno}  = ${mrefno}"
        " AND ${TablesColumnFile.mcharttype} = '${mcharttype}' ";

    result = await db.rawQuery(selectQuery);

    try{
      if(result!= null){
        retBean = bindFavouriteMaster(result[0]);
        return retBean;
      }
      else{
        return null;
      }


    }catch(_){
      return null;
    }


  }



  Future<Null> deleteChartsFavouriteBean(int mrefno, String mcharttype, [bool all] ) async{

    var db = await _getDb();
    String deleteQuery = "DELETE  FROM ${AppDatabase.chartFavouriteMaster} WHERE ${TablesColumnFile.mrefno}  = ${mrefno} "
        " AND ${TablesColumnFile.mcharttype} = '${mcharttype}' ";

    if(all==true){
      deleteQuery = "DELETE  FROM ${AppDatabase.chartFavouriteMaster} ";

    }
    print("Delete query is ${deleteQuery}");
    await db.rawQuery(deleteQuery);
  }



  ChartFavouriteBean bindFavouriteMaster(Map<String, dynamic> result) {
    //ChartFavouriteBean savingsListBean = new ChartFavouriteBean();
    return ChartFavouriteBean.fromMap(result);
  }

  Future<List<ChartsBean>> getFavouriteChartTypes(
      String chartFavouriteType) async {
    var db = await _getDb();
    var result;
    ChartsBean retBean ;
    List<ChartsBean> chartsBeanList = new List<ChartsBean>();

    String selectQuery = "Select * from  ${AppDatabase.chartFavouriteMaster}";

    selectQuery= "SELECT "
        "a.${TablesColumnFile.trefno}  ,"
        "a.${TablesColumnFile.mrefno}  ,"
        "a.${TablesColumnFile.mchartid}  ,"
        "a.${TablesColumnFile.mtitle}  ,"
        "a.${TablesColumnFile.mxcatg}  ,"
        "a.${TablesColumnFile.mycatg}  ,"
        "a.${TablesColumnFile.mzcatg}  ,"
        "a.${TablesColumnFile.misonline}  ,"
        "a.${TablesColumnFile.mquerydesc}  ,"
        "a.${TablesColumnFile.mdefaulttype}  ,"
        "a.${TablesColumnFile.mquery}  ,"
        "a.${TablesColumnFile.mtype}  ,"
        "a.${TablesColumnFile.mdatasource}  ,"
        "a.${TablesColumnFile.subtitle}  ,"
        "a.${TablesColumnFile.subdescription}  ,"
        "a.${TablesColumnFile.image}  ,"
        "a.${TablesColumnFile.status}  ,"
        "a.${TablesColumnFile.subdisplaytype}  ,"
        "a.${TablesColumnFile.mkey}  ,"
        "a.${TablesColumnFile.codelink}  ,"
        "a.${TablesColumnFile.parenttype}  ,"
        "a.${TablesColumnFile.childtype}  ,"
        "a.${TablesColumnFile.premetivedatatype}  ,"
        "a.${TablesColumnFile.xminval}  ,"
        "a.${TablesColumnFile.yminval}  ,"
        "a.${TablesColumnFile.xinterval}  ,"
        "a.${TablesColumnFile.yinterval}  ,"
        "a.${TablesColumnFile.xcaption}  ,"
        "a.${TablesColumnFile.ycaption}  ,"
        "a.${TablesColumnFile.isfavalwed}  ,"
        "a.${TablesColumnFile.xcaprot}  ,"
        "a.${TablesColumnFile.ycaprot}  ,"
        "a.${TablesColumnFile.xaxisvsbl}  ,"
        "a.${TablesColumnFile.yaxisvsbl}  ,"
        "a.${TablesColumnFile.islegvis}  ,"
        "b.${TablesColumnFile.mcharttype} FROM ${AppDatabase.chartFavouriteMaster} b , ${AppDatabase.CHARTMASTER} a  "
        " WHERE a.${TablesColumnFile.mchartid} = b.${TablesColumnFile.mrefno} AND  b.${TablesColumnFile.mchartfavtype} = '${chartFavouriteType}' "
        "";
    result = await db.rawQuery(selectQuery);

//    if(result.isEmpty) {
//
//      selectQuery = "Select  TOP 5 * from  ${AppDatabase.CHARTMASTER}";
//      result = await db.rawQuery(selectQuery);
//
//    }

    try {
      if (result != null) {
        for (int i = 0; i < result.length; i++) {
          retBean = bindChartsDetailsBean(result[i]);
          print("exiting from map");
          chartsBeanList.add(retBean);
        }
      }
    } catch (_) {}

    return chartsBeanList;
  }

  ChartsBean bindChartsDetailsBean(Map<String, dynamic> result) {
    return ChartsBean.fromMap(result);
  }

  Future<List<MenuMasterBean>> getUserAccessCharts() async {


      List<MenuMasterBean> chartHolderRetList = new List<MenuMasterBean>();
      MenuMasterBean retBean = MenuMasterBean();
      var db = await _getDb();
      String queryForGetMenu =" SELECT * FROM ${AppDatabase.MenuMaster} WHERE ${TablesColumnFile.menutype} = 'Charts'"
          " AND (${TablesColumnFile.mparentmenuid} = 0 OR ${TablesColumnFile.mparentmenuid} IS NULL  ) "
          "";
         var result;
         var result2;

      result = await db.rawQuery(queryForGetMenu);

      if (result.length > 0 && result[0] != null) {
        try {
          for (int i = 0; i < result.length; i++) {
            retBean = MenuMasterBean();
            retBean = bindChartHolderBean(result[i]);

            chartHolderRetList.add(retBean);
          }
        } catch (e) {
          print(e.toString());
        }
      }

      return chartHolderRetList;
      }



  Future<List<MenuMasterBean>> getInnerCharts(MenuMasterBean chart) async {


    List<MenuMasterBean> chartHolderRetList = new List<MenuMasterBean>();
    MenuMasterBean retBean = MenuMasterBean();
    var db = await _getDb();
    String queryForGetMenu =" SELECT * FROM ${AppDatabase.MenuMaster} WHERE"
        "  ${TablesColumnFile.mparentmenuid} = 0 OR ${TablesColumnFile.mparentmenuid} IS NULL  "
        "";
    var result;
    var result2;

    result = await db.rawQuery(queryForGetMenu);

    if (result.length > 0 && result[0] != null) {
      try {
        for (int i = 0; i < result.length; i++) {
          retBean = MenuMasterBean();
          retBean = bindChartHolderBean(result[i]);

          chartHolderRetList.add(retBean);
        }
      } catch (e) {
        print(e.toString());
      }
    }

    return chartHolderRetList;
  }

  MenuMasterBean bindChartHolderBean(Map<String, dynamic> result) {
    return MenuMasterBean.fromMap(result);
  }

  Future<List<UserRightBean>> getUserRights(
      UserRightBean getBean , String menuType) async {
   // try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getBean.musrcode = prefs.getString(TablesColumnFile.musrcode);

    var db = await _getDb();
    UserRightBean retBean = new UserRightBean();
    List<UserRightBean> n = new List<UserRightBean>();
    String queryForGetMenu;
    if (menuType == "Charts") {
      queryForGetMenu =
          'SELECT userRights.createe,userRights.modifye,userRights.browsee,userRights.authoritye,userRights.deletee,menuMaster.menuid,menuMaster.menuDesc,menuMaster.menutype,menuMaster.mchartid, '
          'menuMaster.parenttype,menuMaster.murl FROM ${AppDatabase.UserRightsTable} as userRights  '
          'INNER JOIN  ${AppDatabase.MenuMaster} AS menuMaster  on menuMaster.menuid = userRights.menuid WHERE (userRights.musrcode = "${getBean.musrcode}"  OR userRights.musrcode = "ALLUSERS") '
          ' AND menuMaster.${TablesColumnFile.menutype} =  "${menuType}" AND '
          '(menuMaster.${TablesColumnFile.mparentmenuid} = 0 OR menuMaster.${TablesColumnFile.mparentmenuid} IS NULL  )'
          ' ';
    } else {
      queryForGetMenu =
          'SELECT userRights.createe,userRights.modifye,userRights.browsee,userRights.authoritye,userRights.deletee,menuMaster.menuid,menuMaster.menuDesc,menuMaster.menutype,menuMaster.mchartid, '
          'menuMaster.parenttype,menuMaster.murl FROM ${AppDatabase.UserRightsTable} as userRights  '
          'INNER JOIN  ${AppDatabase.MenuMaster} AS menuMaster  on menuMaster.menuid = userRights.menuid WHERE (userRights.musrcode = "${getBean.musrcode}"  OR userRights.musrcode = "ALLUSERS") '
          ' AND ( menuMaster.${TablesColumnFile.menutype} =  "Reports"  OR menuMaster.${TablesColumnFile.menutype} =  "RDLReports"  )  AND '
          ' (menuMaster.${TablesColumnFile.mparentmenuid} = 0 OR menuMaster.${TablesColumnFile.mparentmenuid} IS NULL  )'
          ' ';
    }
    print("Query from first method  ${queryForGetMenu}");
    var result;

    result = await db.rawQuery(queryForGetMenu);

    if (result.length > 0 && result[0] != null) {
      try {
        for (int i = 0; i < result.length; i++) {
          retBean = bindDataUserRightBeanListBean(result[i]);
          retBean.musrcode = getBean.musrcode;
          retBean.userSubRightBean =
              await getInnerUserAccessRights(retBean, menuType);

          n.add(retBean);
        }
      } catch (e) {
        print(e.toString());
      }
    }

    return n;
//    } catch (e) {
//      return null;
//    }
  }

  Future<List<UserRightBean>> getInnerUserAccessRights(
      UserRightBean getBean, String menuType) async {
    // try {
    print("menuID is ${getBean.menuId}");
    print("menuiD is ${getBean.menuid}");
    var db = await _getDb();
    UserRightBean retBean = new UserRightBean();
    List<UserRightBean> n = new List<UserRightBean>();
    String queryForGetMenu;
    if (menuType == "Charts") {
      queryForGetMenu =
          'SELECT userRights.createe,userRights.modifye,userRights.browsee,userRights.authoritye,userRights.deletee,menuMaster.menuid,menuMaster.menuDesc,menuMaster.menutype,menuMaster.mchartid, '
          'menuMaster.parenttype,menuMaster.murl FROM ${AppDatabase.UserRightsTable} as userRights  '
          'INNER JOIN  ${AppDatabase.MenuMaster} AS menuMaster  on menuMaster.menuid = userRights.menuid WHERE (userRights.musrcode = "${getBean.musrcode}" OR userRights.musrcode = "ALLUSERS") '
          ' AND menuMaster.${TablesColumnFile.menutype} = "${menuType}" AND '
          ' menuMaster.${TablesColumnFile.mparentmenuid} = ${getBean.menuid} '
          ' ';
    } else {
      queryForGetMenu =
          'SELECT userRights.createe,userRights.modifye,userRights.browsee,userRights.authoritye,userRights.deletee,menuMaster.menuid,menuMaster.menuDesc,menuMaster.menutype,menuMaster.mchartid, '
          'menuMaster.parenttype,menuMaster.murl FROM ${AppDatabase.UserRightsTable} as userRights  '
          'INNER JOIN  ${AppDatabase.MenuMaster} AS menuMaster  on menuMaster.menuid = userRights.menuid WHERE (userRights.musrcode = "${getBean.musrcode}" OR userRights.musrcode = "ALLUSERS") '
          ' AND ( menuMaster.${TablesColumnFile.menutype} =  "Reports"  OR menuMaster.${TablesColumnFile.menutype} =  "RDLReports"  )  AND  '
          ' menuMaster.${TablesColumnFile.mparentmenuid} = ${getBean.menuid} '
          ' ';
    }

    print("Query from Second method  ${queryForGetMenu}");
    var result;

    result = await db.rawQuery(queryForGetMenu);

    if (result.length > 0 && result[0] != null) {
      try {
        for (int i = 0; i < result.length; i++) {
          retBean = bindDataUserRightBeanListBean(result[i]);
          retBean.musrcode = getBean.musrcode;
          retBean.userSubRightBean =
              await getInnerUserAccessRights(retBean, menuType);

          n.add(retBean);
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      return null;
    }

    return n;
//    } catch (e) {
//      return null;
//    }
  }

  UserRightBean bindDataUserRightBeanListBean(Map<String, dynamic> result) {
    return UserRightBean.fromJoinMap(result);
  }

  Future<ChartsBean> getSelectedChartDetails(int chartID) async {
    var db = await _getDb();
    String seleQuery = "";
    ChartsBean retBean = new ChartsBean();
    var result;
      seleQuery = "Select * from ${AppDatabase.CHARTMASTER} WHERE ${TablesColumnFile.mchartid} = ${chartID};";

    result = await db.rawQuery(seleQuery);

    print("xxxxxxxxxhoraha hai hone do ${result}");


      retBean = bindChartsDetailsBean(result[0]);
      print("exiting from map");

    return retBean;
    }



  Future<List<ChartSampleData>> getQueryNumNumComparisionType(String query) async {
    var db = await _getDb();

    List<ChartSampleData> salesDataList = new List<ChartSampleData>();
    var result;
    var values;
    if (!query.contains("Query")) {
      try {
        print("bean.mquery" + query);
        result = await db.rawQuery(query);
        for (int i = 0; i < result.length; i++) {
          print("result[i]" + result[i].toString());

          dynamic xcat = result[i]["x"];
          dynamic ycat = result[i]["y"];
          dynamic y1cat = result[i]["y1"];

          values = result[i].toString().split(",");

          print("xcat" +
              xcat.toString() +
              "         xxxxxxxxxxxycat" +
              ycat.toString());

          int xAxis = 0;
          int yAxis = 0;
          int y1Axis = 0;

          if (xcat != null && xcat != 'null') {
            switch (xcat.runtimeType) {
              case int:
                print("Y is  Int");
                xAxis = xcat;
                break;
              case String:
                print("Y is  String");
                try {
                  xAxis = int.parse(xcat);
                } catch (_) {
                  xAxis = 0;
                }

                break;
              default:
                print("nothing");
                xAxis = int.parse(xcat);
                break;
            }
          } else {
            xAxis = 0;
          }

          if (ycat != null && ycat != 'null') {
            switch (ycat.runtimeType) {
              case int:
                print("Y is  Int");
                yAxis = ycat;
                break;
              case String:
                print("Y is  String");
                try {
                  yAxis = int.parse(ycat);
                } catch (_) {
                  yAxis = 0;
                }

                break;
              default:
                print("nothing");
                yAxis = int.parse(ycat);
                break;
            }
          } else {
            yAxis = 0;
          }

          if (y1cat != null && y1cat != 'null') {
            switch (y1cat.runtimeType) {
              case int:
                print("Y is  Int");
                y1Axis = y1cat;
                break;
              case String:
                print("Y is  String");
                try {
                  y1Axis = int.parse(y1cat);
                } catch (_) {
                  y1Axis = 0;
                }

                break;
              default:
                print("nothing");
                y1Axis = int.parse(y1cat);
                break;
            }
          } else {
            y1Axis = 0;
          }
          ChartSampleData salesData = new ChartSampleData();
          salesData.yValue = xAxis;
          salesData.yValue2 = yAxis;
          salesData.yValue3 = y1Axis;
          print("salesData salesData ${salesData}");
          salesDataList.add(salesData);
        }
      } catch (_) {
        print("exception aaya  chutye");
      }
    }
    return salesDataList;
  }

  Future<List<ChartSampleData>> getQuerySimpleChart(ChartsBean charttype) async {
    var db = await _getDb();

    List<ChartSampleData> salesDataList = new List<ChartSampleData>();
    var  result;
    var val;
    if(!charttype.mquery.contains("Query")) {
      //try {

      print("bean.mquery" + charttype.mquery);
      result = await db.rawQuery(charttype.mquery);
      var values;
      print(" xxxxxxxxxxxycat  xxxxxxxxxxxycat ${result}");
//        if(result.isEmpty){
//          return null;
//        }
      for (int i = 0; i < result.length; i++) {
        print("result[i]" + result[i].toString());
        values = result[i].toString().split(",");  //[count: 1 , year:  1975]
        if(i==0){

          charttype.categoryNames = new List<String>();
          // bean.categoryNames.add(values[0].substring(values[0].indexOf("{")+1,values[0].indexOf(":") ).trim());
          charttype.categoryNames
              .add(values[1].substring(0, values[1].indexOf(":")).trim());
          charttype.categoryNames
              .add(values[0].substring(0, values[0].indexOf(":")).trim());
        }

        String xAxis = values[0].replaceAll(RegExp(r'.*:'), "");
        String ycat = values[1].replaceAll(RegExp(r'.*:'), "");
        ycat = ycat.replaceAll("}", "");
        int yAxis = int.parse(ycat);
        print("xAxis  hai ${xAxis}");
        print("yAxis  hai ${yAxis}");
        ChartSampleData salesData = new ChartSampleData();
        salesData.xValue = xAxis == null ? 2 : xAxis;
        salesData.yValue = yAxis;
        print("salesData salesData ${salesData}");
        salesDataList.add(salesData);
      }
//      } catch (_) {
//        print("exception aaya  chutye");
//      }
    }
    print(salesDataList);
    charttype.chartSampleData = salesDataList;
    return salesDataList;
  }

  Future<List<ChartSampleData>> getQueryLineChart(ChartsBean charttype) async {
    var db = await _getDb();
    var values;

    List<ChartSampleData> salesDataList = new List<ChartSampleData>();
    var result;
    if (!charttype.mquery.contains("Query")) {
      try {
        print("bean.mquery" + charttype.mquery);
        result = await db.rawQuery(charttype.mquery);
        print(" xxxxxxxxxxxycat  xxxxxxxxxxxycat ${result}");
        for (int i = 0; i < result.length; i++) {
          print("result[i]" + result[i].toString());

          if (i == 0) {
            charttype.categoryNames = new List<String>();
            // bean.categoryNames.add(values[0].substring(values[0].indexOf("{")+1,values[0].indexOf(":") ).trim());
            charttype.categoryNames
                .add(values[1].substring(0, values[1].indexOf(":")).trim());
            charttype.categoryNames
                .add(values[2].substring(0, values[1].indexOf(":")).trim());
          }

          dynamic xcat = values[0].replaceAll(RegExp(r'.*:'), "");
          dynamic ycat = values[1].replaceAll(RegExp(r'.*:'), "");
          dynamic y2cat = values[2].replaceAll(RegExp(r'.*:'), "");

          print("xcat" +
              xcat.toString() +
              "         xxxxxxxxxxxycat" +
              ycat.toString());

          String xAxis="";
          ycat = ycat.replaceAll("}", "");
          xAxis= xcat;
          int yAxis = int.parse(ycat);
          print("xAxis  hai ${xAxis}");
          print("yAxis  hai ${yAxis}");
          ChartSampleData salesData = new ChartSampleData();
          salesData.xValue = xAxis == null ? 2 : xAxis;
          salesData.yValue = yAxis;
          salesData.yValue2 = y2cat;
          print("salesData salesData ${salesData}");
          salesDataList.add(salesData);
        }
      } catch (_) {
        print("exception aaya  chutye");
      }
    }
    return salesDataList;
  }
  
  
  
  
  Future<int> updateQuery(String insertQuery) async {
    var db = await _getDb();
    var result = await db.rawQuery(insertQuery);
    print(result) ;
  }

  Future<int> updateColorPalleteMaster(ColorPalleteBean colorPallteBean) async {
    var db = await _getDb();
    int i = 0;
    if (colorPallteBean.trefno == 0 || colorPallteBean.trefno == null) {
      i = await getMaxColorNumber();
      if (i == null || i == 0) {
        i = 1;
      } else {
        i++;
      }
    } else {
      i = colorPallteBean.trefno;
    }

    String insertQuery =
        "INSERT OR REPLACE INTO ${AppDatabase.colorPalleteMaster} ("
        " trefno, "
        " appbar  ,"
        " subappbar  ,"
        " appbaricon  ,"
        " subappbaricon  ,"
        " appbartext  ,"
        " subappbartext  ,"
        " icon  ,"
        " chrtnavbtn  ,"
        "chrttitle  ,"
        "chrttitleborder ,"
        "misselected ,"
        "mname "
        " ) VALUES ("
        " ${i} ,"
        " ${colorPallteBean.appbar != null ? colorPallteBean.appbar.value : 0}  , "
        " ${colorPallteBean.subappbar != null ? colorPallteBean.subappbar.value : 0}  ,"
        " ${colorPallteBean.appbaricon != null ? colorPallteBean.appbaricon.value : 0}  ,"
        " ${colorPallteBean.subappbaricon != null ? colorPallteBean.subappbaricon.value : 0}  ,"
        " ${colorPallteBean.appbartext != null ? colorPallteBean.appbartext.value : 0}  ,"
        " ${colorPallteBean.subappbartext != null ? colorPallteBean.subappbartext.value : 0}  ,"
        " ${colorPallteBean.icon != null ? colorPallteBean.icon.value : 0}  ,"
        " ${colorPallteBean.chrtnavbtn != null ? colorPallteBean.chrtnavbtn.value : 0}  ,"
        "${colorPallteBean.chrttitle != null ? colorPallteBean.chrttitle.value : 0}  ,"
        " ${colorPallteBean.chrttitleborder != null ? colorPallteBean.chrttitleborder.value : 0}  ,"
        " ${colorPallteBean.misselected ?? 0}  ,"
        " '${colorPallteBean.mname}'  "
        " );";
    print("insert query is ${insertQuery}");
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${AppDatabase.colorPalleteMaster}");
    });
    return i;
  }

  Future<int> getMaxColorNumber() async {
    String insertQuery = "SELECT *"
        "FROM    ${AppDatabase.colorPalleteMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${AppDatabase.colorPalleteMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }



  Future updateCollateralREMlandandhouseMaster(
      CollateralREMlandandhouseBean collateralREMlandandhouseBean) async {
    print("trying to insert or replace ${AppDatabase.CollateralREMlandandhouseMaster}");

    String insertQuery =
        "INSERT OR REPLACE INTO ${AppDatabase.CollateralREMlandandhouseMaster} ("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.loantrefno},"
        "${TablesColumnFile.loanmrefno},"
        "${TablesColumnFile.colleteraltrefno},"
        "${TablesColumnFile.colleteralmrefno},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mtitle},"
        "${TablesColumnFile.mfname},"
        "${TablesColumnFile.mmname},"
        "${TablesColumnFile.mlname},"
        "${TablesColumnFile.maddress1},"
        "${TablesColumnFile.maddress2},"
        "${TablesColumnFile.mcountry},"
        "${TablesColumnFile.mstate},"
        "${TablesColumnFile.mdist},"
        "${TablesColumnFile.msubdist},"
        "${TablesColumnFile.marea},"
        "${TablesColumnFile.mhousebuilttype},"
        "${TablesColumnFile.menvdescription},"
        "${TablesColumnFile.mlotarea},"
        "${TablesColumnFile.mfloorarea},"
        "${TablesColumnFile.mdescofproperty},"
        "${TablesColumnFile.msizeofproperty},"
        "${TablesColumnFile.msizeofpropertyl},"
        "${TablesColumnFile.msizeofpropertyh},"
        "${TablesColumnFile.mtctno},"
        "${TablesColumnFile.msrno},"
        "${TablesColumnFile.mregdate},"
        "${TablesColumnFile.mepebdate},"
        "${TablesColumnFile.mrescodeorremark},"
        "${TablesColumnFile.mepebno},"
        "${TablesColumnFile.mregofdeedslocation},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.mcollno},"
        "${TablesColumnFile.mpriorsec},"
        "${TablesColumnFile.mcolltype},"
        "${TablesColumnFile.mcollsubtype},"
        "${TablesColumnFile.mtypeofproperty},"
        "${TablesColumnFile.mltypeofownercerti},"
        "${TablesColumnFile.mhtypeofownercerti},"
        "${TablesColumnFile.mlissuednoprop},"
        "${TablesColumnFile.mhissuednoprop},"
        "${TablesColumnFile.mlissueby},"
        "${TablesColumnFile.mhissueby},"
        "${TablesColumnFile.mlsizeprop},"
        "${TablesColumnFile.mhsizeprop},"
        "${TablesColumnFile.mlnpropborder},"
        "${TablesColumnFile.mhnpropborder},"
        "${TablesColumnFile.mlspropborder},"
        "${TablesColumnFile.mhspropborder},"
        "${TablesColumnFile.mlwpropborder},"
        "${TablesColumnFile.mhwpropborder},"
        "${TablesColumnFile.mlepropborder},"
        "${TablesColumnFile.mhepropborder},"
        "${TablesColumnFile.mllocprop},"
        "${TablesColumnFile.mhlocprop},"
        "${TablesColumnFile.mltitleowener},"
        "${TablesColumnFile.mhtitleowener},"
        "${TablesColumnFile.mllocalauthvalue},"
        "${TablesColumnFile.mhlocalauthvalue},"
        "${TablesColumnFile.mlrealestatecmpnyvalue},"
        "${TablesColumnFile.mhrealestatecmpnyvalue},"
        "${TablesColumnFile.mlaskneighonvalue},"
        "${TablesColumnFile.mhaskneighonvalue},"
        "${TablesColumnFile.mlsumonvalprop},"
        "${TablesColumnFile.mhsumonvalprop},"
        "${TablesColumnFile.mlissuedt},"
        "${TablesColumnFile.mhissuedt}"
        ")VALUES("
        "${collateralREMlandandhouseBean.trefno},"
        "${collateralREMlandandhouseBean.mrefno},"
        "${collateralREMlandandhouseBean.mloantrefno},"
        "${collateralREMlandandhouseBean.mloanmrefno},"
        "${collateralREMlandandhouseBean.colleteraltrefno},"
        "${collateralREMlandandhouseBean.colleteralmrefno},"
        "'${collateralREMlandandhouseBean.mprdacctid}',"
        "'${collateralREMlandandhouseBean.mtitle}',"
        "'${collateralREMlandandhouseBean.mfname}',"
        "'${collateralREMlandandhouseBean.mmname}',"
        "'${collateralREMlandandhouseBean.mlname}',"
        "'${collateralREMlandandhouseBean.maddress1}',"
        "'${collateralREMlandandhouseBean.maddress2}',"
        "'${collateralREMlandandhouseBean.mcountry}',"
        "'${collateralREMlandandhouseBean.mstate}',"
        "'${collateralREMlandandhouseBean.mdist}',"
        "'${collateralREMlandandhouseBean.msubdist}',"
        "'${collateralREMlandandhouseBean.marea}',"
        "'${collateralREMlandandhouseBean.mhousebuilttype}',"
        "'${collateralREMlandandhouseBean.menvdescription}',"
        "${collateralREMlandandhouseBean.mlotarea},"
        "${collateralREMlandandhouseBean.mfloorarea},"
        "'${collateralREMlandandhouseBean.mdescofproperty}',"
        "'${collateralREMlandandhouseBean.msizeofproperty}',"
        "'${collateralREMlandandhouseBean.msizeofpropertyl}',"
        "'${collateralREMlandandhouseBean.msizeofpropertyh}',"
        "${collateralREMlandandhouseBean.mtctno},"
        "${collateralREMlandandhouseBean.msrno},"
        "'${collateralREMlandandhouseBean.mregdate}',"
        "'${collateralREMlandandhouseBean.mepebdate}',"
        "'${collateralREMlandandhouseBean.mrescodeorremark}',"
        "${collateralREMlandandhouseBean.mepebno},"
        "'${collateralREMlandandhouseBean.mregofdeedslocation}',"
        "'${collateralREMlandandhouseBean.mcreateddt}',"
        "'${collateralREMlandandhouseBean.mcreatedby}',"
        "'${collateralREMlandandhouseBean.mlastupdatedt}',"
        "'${collateralREMlandandhouseBean.mlastupdateby}',"
        "'${collateralREMlandandhouseBean.mgeolocation}',"
        "'${collateralREMlandandhouseBean.mgeolatd}',"
        "'${collateralREMlandandhouseBean.mgeologd}',"
        "'${collateralREMlandandhouseBean.mlastsynsdate}',"
        "'${collateralREMlandandhouseBean.merrormessage}',"
        "${collateralREMlandandhouseBean.mcollno},"
        "'${collateralREMlandandhouseBean.mpriorsec}',"
        "'${collateralREMlandandhouseBean.mcolltype}',"
        "'${collateralREMlandandhouseBean.mcollsubtype}',"
        "'${collateralREMlandandhouseBean.mtypeofproperty}',"
        "'${collateralREMlandandhouseBean.mltypeofownercerti}',"
        "'${collateralREMlandandhouseBean.mhtypeofownercerti}',"
        "'${collateralREMlandandhouseBean.mlissuednoprop}',"
        "'${collateralREMlandandhouseBean.mhissuednoprop}',"
        "'${collateralREMlandandhouseBean.mlissueby}',"
        "'${collateralREMlandandhouseBean.mhissueby}',"
        "'${collateralREMlandandhouseBean.mlsizeprop}',"
        "'${collateralREMlandandhouseBean.mhsizeprop}',"
        "'${collateralREMlandandhouseBean.mlnpropborder}',"
        "'${collateralREMlandandhouseBean.mhnpropborder}',"
        "'${collateralREMlandandhouseBean.mlspropborder}',"
        "'${collateralREMlandandhouseBean.mhspropborder}',"
        "'${collateralREMlandandhouseBean.mlwpropborder}',"
        "'${collateralREMlandandhouseBean.mhwpropborder}',"
        "'${collateralREMlandandhouseBean.mlepropborder}',"
        "'${collateralREMlandandhouseBean.mhepropborder}',"
        "'${collateralREMlandandhouseBean.mllocprop}',"
        "'${collateralREMlandandhouseBean.mhlocprop}',"
        "'${collateralREMlandandhouseBean.mltitleowener}',"
        "'${collateralREMlandandhouseBean.mhtitleowener}',"
        "${collateralREMlandandhouseBean.mllocalauthvalue},"
        "${collateralREMlandandhouseBean.mhlocalauthvalue},"
        "${collateralREMlandandhouseBean.mlrealestatecmpnyvalue},"
        "${collateralREMlandandhouseBean.mhrealestatecmpnyvalue},"
        "${collateralREMlandandhouseBean.mlaskneighonvalue},"
        "${collateralREMlandandhouseBean.mhaskneighonvalue},"
        "${collateralREMlandandhouseBean.mlsumonvalprop},"
        "${collateralREMlandandhouseBean.mhsumonvalprop},"
        "'${collateralREMlandandhouseBean.mlissuedt}',"
        "'${collateralREMlandandhouseBean.mhissuedt}'"
        " );";
    for (var items in insertQuery.split(",")) {
      print(items);
    }

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          "xxx ida fter insert in ${AppDatabase.CollateralREMlandandhouseMaster}");
    });
  }

  Future<int> getMaxCollateralVehicleTrefNo() async {
    print("trying to select last row  ${AppDatabase.collateralVehicleMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${AppDatabase.collateralVehicleMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${AppDatabase.collateralVehicleMaster});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.trefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  Future updateCollateralVehicleMaster(
      CollateralVehicleBean collateralbean) async {
    print("trying to insert or replace ${AppDatabase.collateralVehicleMaster}");

    String insertQuery = "INSERT OR REPLACE INTO ${AppDatabase.collateralVehicleMaster} ("
        "${TablesColumnFile.msrno}  ,"
        "${TablesColumnFile.mlbrcode}   ,"
        "${TablesColumnFile.mprdacctid}  ,"
        "${TablesColumnFile.msectype}  ,"
        "${TablesColumnFile.trefno}   ,"
        "${TablesColumnFile.mrefno}  ,"
        "${TablesColumnFile.loantrefno}   ,"
        "${TablesColumnFile.loanmrefno}  ,"
        "${TablesColumnFile.colleteraltrefno}  ,"
        "${TablesColumnFile.colleteralmrefno}  ,"
        "${TablesColumnFile.mbusinessname}  ,"
        "${TablesColumnFile.mownername}  ,"
        "${TablesColumnFile.mtel}  ,"
        "${TablesColumnFile.maddress1}  ,"
        "${TablesColumnFile.maddress2}  ,"
        "${TablesColumnFile.mcountry}  ,"
        "${TablesColumnFile.mstate}  ,"
        "${TablesColumnFile.mdist}   ,"
        "${TablesColumnFile.msubdist}  ,"
        "${TablesColumnFile.marea}   ,"
        "${TablesColumnFile.mvillage}   ,"
        "${TablesColumnFile.mbrand}  ,"
        "${TablesColumnFile.mnoofaxles}   ,"
        "${TablesColumnFile.mtype}  ,"
        "${TablesColumnFile.mnoofcylinder}   ,"
        "${TablesColumnFile.mcolor}  ,"
        "${TablesColumnFile.msizeofcylinder}   ,"
        "${TablesColumnFile.mbodyno}   ,"
        "${TablesColumnFile.menginepower}   ,"
        "${TablesColumnFile.mengineno}   ,"
        "${TablesColumnFile.myearmade}   ,"
        "${TablesColumnFile.mchassisno}  ,"
        "${TablesColumnFile.mmadeby}  ,"
        "${TablesColumnFile.midentitycarno}  ,"
        "${TablesColumnFile.mcarpricing}   ,"
        "${TablesColumnFile.mstdpricing}   ,"
        "${TablesColumnFile.minsurancepricing}   ,"
        "${TablesColumnFile.mpriceafterevaluation}   ,"
        "${TablesColumnFile.mltv}   ,"
        "${TablesColumnFile.mcartype},"
        "${TablesColumnFile.mltvdd},"
        "${TablesColumnFile.mloantovalueltv}  ,"
        "${TablesColumnFile.mwhobelongocarowner}  ,"
        "${TablesColumnFile.mcarlegality}  ,"
        "${TablesColumnFile.mreason}  ,"
        "${TablesColumnFile.mdescription}  ,"
        "${TablesColumnFile.mcarcanbeused}  ,"
        "${TablesColumnFile.mcredittenor}   ,"
        "${TablesColumnFile.mdmirror}  ,"
        "${TablesColumnFile.mddoor}  ,"
        "${TablesColumnFile.mdmirrorbacklock}  ,"
        "${TablesColumnFile.mdcolororspot}  ,"
        "${TablesColumnFile.mfcolorandspot}  ,"
        "${TablesColumnFile.mftireandyan}  ,"
        "${TablesColumnFile.mfcapofsplatter}  ,"
        "${TablesColumnFile.mhmirror}  ,"
        "${TablesColumnFile.mhvent}  ,"
        "${TablesColumnFile.mhlightfarl}  ,"
        "${TablesColumnFile.mhlightfarr}  ,"
        "${TablesColumnFile.mhsignal}  ,"
        "${TablesColumnFile.mhwincap}  ,"
        "${TablesColumnFile.mhheadcap}  ,"
        "${TablesColumnFile.mpmirror}  ,"
        "${TablesColumnFile.mpdoor}  ,"
        "${TablesColumnFile.mpbackmirror}  ,"
        "${TablesColumnFile.mpcolororspot}  ,"
        "${TablesColumnFile.mftcolorandspot}  ,"
        "${TablesColumnFile.mfttanandyan}  ,"
        "${TablesColumnFile.mftcap}  ,"
        "${TablesColumnFile.mftsplattercap}  ,"
        "${TablesColumnFile.mbpmirror}  ,"
        "${TablesColumnFile.mbpdoor}  ,"
        "${TablesColumnFile.mbpcolorandspot}  ,"
        "${TablesColumnFile.mbtcolorandsport}  ,"
        "${TablesColumnFile.mbttanandyan}  ,"
        "${TablesColumnFile.mbtcap}  ,"
        "${TablesColumnFile.mbcbacklightr}  ,"
        "${TablesColumnFile.mbcturnsignal}  ,"
        "${TablesColumnFile.mbcmessagesignal}  ,"
        "${TablesColumnFile.mbcsignal}  ,"
        "${TablesColumnFile.mbcbacklightl}  ,"
        "${TablesColumnFile.mbcbackdoor}  ,"
        "${TablesColumnFile.mbccranes}  ,"
        "${TablesColumnFile.mbctakelock}  ,"
        "${TablesColumnFile.mbcholdlock}  ,"
        "${TablesColumnFile.mbchandcranes}  ,"
        "${TablesColumnFile.mbcreservetire}   ,"
        "${TablesColumnFile.mbcbackmirror}   ,"
        "${TablesColumnFile.mbcantenna}  ,"
        "${TablesColumnFile.mbtlcolororspot}  ,"
        "${TablesColumnFile.mbtltanandyan}  ,"
        "${TablesColumnFile.mbtlcap}  ,"
        "${TablesColumnFile.mbtlsplattercap}  ,"
        "${TablesColumnFile.mbtrcolororspot}  ,"
        "${TablesColumnFile.mbtrtireandyan}  ,"
        "${TablesColumnFile.mbtrcap}  ,"
        "${TablesColumnFile.mbtrsplattercap}  ,"
        "${TablesColumnFile.mibarsun}  ,"
        "${TablesColumnFile.midescriptionbook}  ,"
        "${TablesColumnFile.miautosystem}  ,"
        "${TablesColumnFile.miairconditioner}  ,"
        "${TablesColumnFile.mimirrorremote}  ,"
        "${TablesColumnFile.misafebell}  ,"
        "${TablesColumnFile.mimiddlebox}  ,"
        "${TablesColumnFile.mregdate} ,"
        "${TablesColumnFile.mregexpdate} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.missynctocoresys} ,"
        "${TablesColumnFile.mlastsynsdate} "
        ")VALUES("
        " ${collateralbean.msrno}   ,"
        " ${collateralbean.mlbrcode}   ,"
        " '${collateralbean.mprdacctid}'  ,"
        " '${collateralbean.msectype}'  ,"
        " ${collateralbean.trefno}   ,"
        " ${collateralbean.mrefno}  ,"
        " ${collateralbean.mloantrefno}   ,"
        " ${collateralbean.mloanmrefno}  ,"
        " ${collateralbean.colleteraltrefno}  ,"
        " ${collateralbean.colleteralmrefno}  ,"
        " '${collateralbean.mbusinessname}'  ,"
        " '${collateralbean.mownername}'  ,"
        " '${collateralbean.mtel}'  ,"
        " '${collateralbean.maddress1}'  ,"
        " '${collateralbean.maddress2}'  ,"
        " '${collateralbean.mcountry}'  ,"
        " '${collateralbean.mstate}'  ,"
        " '${collateralbean.mdist}'   ,"
        " '${collateralbean.msubdist}'  ,"
        " '${collateralbean.marea}'  ,"
        " '${collateralbean.mvillage}'   ,"
        " '${collateralbean.mbrand}'  ,"
        " ${collateralbean.mnoofaxles}   ,"
        " '${collateralbean.mtype}'  ,"
        " ${collateralbean.mnoofcylinder}   ,"
        " '${collateralbean.mcolor}'  ,"
        " ${collateralbean.msizeofcylinder}   ,"
        " '${collateralbean.mbodyno}'   ,"
        " ${collateralbean.menginepower}   ,"
        "' ${collateralbean.mengineno} '  ,"
        " ${collateralbean.myearmade}   ,"
        " '${collateralbean.mchassisno}'  ,"
        " '${collateralbean.mmadeby}'  ,"
        " '${collateralbean.midentitycarno}'  ,"
        " ${collateralbean.mcarpricing}   ,"
        " ${collateralbean.mstdpricing}   ,"
        " ${collateralbean.minsurancepricing}   ,"
        " ${collateralbean.mpriceafterevaluation}   ,"
        " ${collateralbean.mltv}   ,"
        " '${collateralbean.mcartype}'  ,"
        " '${collateralbean.mltvdd}'  ,"
        " '${collateralbean.mloantovalueltv}'  ,"
        " '${collateralbean.mwhobelongocarowner}'  ,"
        " ${collateralbean.mcarlegality}  ,"
        " '${collateralbean.mreason}'  ,"
        " '${collateralbean.mdescription}'  ,"
        " '${collateralbean.mcarcanbeused}'  ,"
        " '${collateralbean.mcredittenor}'   ,"
        " '${collateralbean.mdmirror}'  ,"
        " '${collateralbean.mddoor}'  ,"
        " '${collateralbean.mdmirrorbacklock}'  ,"
        " '${collateralbean.mdcolororspot}'  ,"
        " '${collateralbean.mfcolorandspot}'  ,"
        " '${collateralbean.mftireandyan}'  ,"
        " '${collateralbean.mfcapofsplatter}'  ,"
        " '${collateralbean.mhmirror}'  ,"
        " '${collateralbean.mhvent}'  ,"
        " '${collateralbean.mhlightfarl}'  ,"
        " '${collateralbean.mhlightfarr}'  ,"
        " '${collateralbean.mhsignal}'  ,"
        " '${collateralbean.mhwincap}'  ,"
        " '${collateralbean.mhheadcap}'  ,"
        " '${collateralbean.mpmirror}'  ,"
        " '${collateralbean.mpdoor}'  ,"
        " '${collateralbean.mpbackmirror}'  ,"
        " '${collateralbean.mpcolororspot}'  ,"
        " '${collateralbean.mftcolorandspot}'  ,"
        " '${collateralbean.mfttanandyan}'  ,"
        " '${collateralbean.mftcap}'  ,"
        " '${collateralbean.mftsplattercap}'  ,"
        " '${collateralbean.mbpmirror}'  ,"
        " '${collateralbean.mbpdoor}'  ,"
        " '${collateralbean.mbpcolorandspot}'  ,"
        " '${collateralbean.mbtcolorandsport}'  ,"
        " '${collateralbean.mbttanandyan}'  ,"
        " '${collateralbean.mbtcap}'  ,"
        " '${collateralbean.mbcbacklightr}'  ,"
        " '${collateralbean.mbcturnsignal}'  ,"
        " '${collateralbean.mbcmessagesignal}'  ,"
        " '${collateralbean.mbcsignal}'  ,"
        " '${collateralbean.mbcbacklightl}'  ,"
        " '${collateralbean.mbcbackdoor}'  ,"
        " '${collateralbean.mbccranes}'  ,"
        " '${collateralbean.mbctakelock}'  ,"
        " '${collateralbean.mbcholdlock}'  ,"
        " '${collateralbean.mbchandcranes}'  ,"
        " '${collateralbean.mbcreservetire}'   ,"
        " '${collateralbean.mbcbackmirror}'   ,"
        " '${collateralbean.mbcantenna}'  ,"
        " '${collateralbean.mbtlcolororspot}'  ,"
        " '${collateralbean.mbtltanandyan}'  ,"
        " '${collateralbean.mbtlcap}'  ,"
        " '${collateralbean.mbtlsplattercap}'  ,"
        " '${collateralbean.mbtrcolororspot}'  ,"
        " '${collateralbean.mbtrtireandyan}'  ,"
        " '${collateralbean.mbtrcap}'  ,"
        " '${collateralbean.mbtrsplattercap}'  ,"
        " '${collateralbean.mibarsun}'  ,"
        " '${collateralbean.midescriptionbook}'  ,"
        " '${collateralbean.miautosystem}'  ,"
        " '${collateralbean.miairconditioner}'  ,"
        " '${collateralbean.mimirrorremote}'  ,"
        " '${collateralbean.misafebell}'  ,"
        " '${collateralbean.mimiddlebox}'  ,"
        "'${collateralbean.mregdate}' ,"
        "'${collateralbean.mregexpdate}' ,"
        "'${collateralbean.mcreateddt}' ,"
        "'${collateralbean.mcreatedby}' ,"
        "'${collateralbean.mlastupdatedt}' ,"
        "'${collateralbean.mlastupdateby}' ,"
        "'${collateralbean.mgeolocation}',"
        "'${collateralbean.mgeolatd}' ,"
        "'${collateralbean.mgeologd}' ,"
        "${collateralbean.missynctocoresys} ,"
        "'${collateralbean.mlastsynsdate}' "
        " );";
    for (var items in insertQuery.split(",")) {
      print(items);
    }

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + "xxx ida fter insert in ");
    });
  }

  Future<List<CreditBereauBean>> getAllCreditMasterObjectsSynced(
      String mpanNo, String imdDesc) async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      CreditBereauBean retBean = new CreditBereauBean();
      List<CreditBereauBean> n = new List<CreditBereauBean>();

      var result;
      print("query is" +
          "SELECT *  FROM ${AppDatabase.creditBereauMaster} where   "
              "( ${TablesColumnFile.mpanno} = '${mpanNo}' OR ${TablesColumnFile.mpanno} = '${imdDesc}' OR "
              "${TablesColumnFile.mid1desc} = '${mpanNo}' OR ${TablesColumnFile.mid1desc} = '${imdDesc}' )"
              " AND (${TablesColumnFile.mprospectstatus} = 2 OR  ${TablesColumnFile.mprospectstatus} = 6 )   "
              " AND ${TablesColumnFile.mrefno}!= 0 AND ${TablesColumnFile.mrefno} IS NOT NULL  ");

      result = await db.rawQuery(
          "SELECT *  FROM ${AppDatabase.creditBereauMaster} where   "
          "( ${TablesColumnFile.mpanno} = '${mpanNo}' OR ${TablesColumnFile.mpanno} = '${imdDesc}' OR "
          "${TablesColumnFile.mid1desc} = '${mpanNo}' OR ${TablesColumnFile.mid1desc} = '${imdDesc}' )"
          " AND (${TablesColumnFile.mprospectstatus} = 2 OR  ${TablesColumnFile.mprospectstatus} = 6 )   "
          " AND ${TablesColumnFile.mrefno}!= 0 AND ${TablesColumnFile.mrefno} IS NOT NULL  ");

      try {
        for (int i = 0; i < result.length; i++) {
          retBean = bindDataProspectbean(result[i]);
          n.add(retBean);
        }
      } catch (e) {
        print(e.toString());
      }

      return n;
    } catch (e) {
      return null;
    }
  }

  CreditBereauBean bindDataProspectbean(Map<String, dynamic> result) {
    return CreditBereauBean.fromMap(result);
  }

  Future<List<ColorPalleteBean>> getColorPallteList() async {
    ColorPalleteBean disBean = new ColorPalleteBean();
    List<ColorPalleteBean> retBeanList = new List<ColorPalleteBean>();
    String query;

    query = "SELECT * FROM ${AppDatabase.colorPalleteMaster}  ";
    print(query);
    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    print(result);
    //try {
    for (int i = 0; i < result.length; i++) {
      print(result[i].runtimeType);
      disBean = bingColorPalleteObject(result[i]);
      print("exiting from map");
      retBeanList.add(disBean);
    }
//    } catch (Exception ) {
//      Exception.
//    }
    print("returning  ${retBeanList}");
    return retBeanList;
  }

  ColorPalleteBean bingColorPalleteObject(Map<String, dynamic> result) {
    return ColorPalleteBean.fromMap(result);
  }

  Future updateSelectedColor(int trefno) async {
    String query;

    query =
        "UPDATE  ${AppDatabase.colorPalleteMaster}  SET misselected = 1 WHERE trefno = ${trefno}";
    print(query);
    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    print(result);

    query =
        "UPDATE  ${AppDatabase.colorPalleteMaster}  SET misselected = 0 WHERE trefno != ${trefno}";
    print(query);
    result = await db.rawQuery(query);
    print(result);
  }

  Future updatedefaultColorPalleteTable() async {
    var db = await _getDb();
    String insertQuery =
        "INSERT OR REPLACE INTO ${AppDatabase.colorPalleteMaster} ("
        " trefno, "
        " appbar  ,"
        " subappbar  ,"
        " appbaricon  ,"
        " subappbaricon  ,"
        " appbartext  ,"
        " subappbartext  ,"
        " icon  ,"
        " chrtnavbtn  ,"
        "chrttitle  ,"
        "chrttitleborder ,"
        "misselected ,"
        "mname "
        " ) VALUES ("
        " ${1} ,"
        " 4278665834  , "
        " 4278665834  ,"
        " 4294967295  ,"
        " 4294967295  ,"
        " 4294967295  ,"
        " 4294967295  ,"
        " 0  ,"
        " 4278190080  ,"
        "4293852993  ,"
        "4278234305,"
        " 1  ,"
        " 'Default'  "
        " );";
    print("update Color Pallete query query is ${insertQuery}");
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${AppDatabase.colorPalleteMaster}");
    });
  }

  Future updateChartFavType(ChartFavouriteTypes chartTypeBean) async {
    var db = await _getDb();

    if (chartTypeBean.id != 1) {
      chartTypeBean.id = await getMaxFavTypeID();
      if (chartTypeBean.id == 0 || chartTypeBean.id == null)
        chartTypeBean.id = 2;
    }

    String insertQuery =
        "INSERT OR REPLACE INTO ${AppDatabase.chartFavouritetype} ("
        " ${TablesColumnFile.id}, "
        " ${TablesColumnFile.typeName}  "
        " ) VALUES ("
        " ${chartTypeBean.id} ,"
        "'${chartTypeBean.typeName}'"
        " );";
    print("update Color Pallete query query is ${insertQuery}");
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${AppDatabase.chartFavouritetype}");
    });
  }

  Future<int> getMaxFavTypeID() async {
    print("trying to select last row  ${AppDatabase.chartFavouritetype}");
    String insertQuery = "SELECT *"
        "FROM    ${AppDatabase.chartFavouritetype}"
        " WHERE   ${TablesColumnFile.id} = (SELECT MAX(${TablesColumnFile.id})  FROM ${AppDatabase.chartFavouritetype});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.id];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }

  Future<List<ChartFavouriteTypes>> getFavouriteTypes() async {
    var db = await _getDb();
    String seleQuery = "";

    List<ChartFavouriteTypes> retList = new List<ChartFavouriteTypes>();

    ChartFavouriteTypes retBean = new ChartFavouriteTypes();
    var result;
    seleQuery = "Select * from ${AppDatabase.chartFavouritetype} ;";
    result = await db.rawQuery(seleQuery);
    print(result);

    for (int i = 0; i < result.length; i++) {
      retBean = bindChartFavouriteType(result[i]);
      print("exiting from map");
      retList.add(retBean);
    }
    return retList;
  }

  ChartFavouriteTypes bindChartFavouriteType(Map<String, dynamic> result) {
    return ChartFavouriteTypes.fromMap(result);
  }

  Future<ColorPalleteBean> getSelectedColor() async {
    ColorPalleteBean disBean = new ColorPalleteBean();
    String query;

    query =
        "SELECT * FROM ${AppDatabase.colorPalleteMaster} WHERE misselected = 1  ";
    print(query);
    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    print(result);
    print(result[0].runtimeType);
    disBean = bingColorPalleteObject(result[0]);
    return disBean;
  }

  Future updateDefaultchartFavouriteType() async {
    updateChartFavType(ChartFavouriteTypes(id: 1, typeName: "Home"));
  }

  Future<int> updateCustomerLoanImageMaster(
      CustomerLoanImageBean loanImageBean, int tImagerefNo) async {
    print("trying to insert or replace ${AppDatabase.customerLoanImageMaster}");
    String insertQuery =
        'INSERT OR REPLACE INTO ${AppDatabase.customerLoanImageMaster} '
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mloantrefno} ,"
        "${TablesColumnFile.mloanmrefno},"
        "${TablesColumnFile.mcustmrefno}  ,"
        "${TablesColumnFile.mcusttrefno}  ,"
        "${TablesColumnFile.mimagestring},"
        "${TablesColumnFile.mimagebyteorfolder}, "
        "${TablesColumnFile.mimagetype}, "
        "${TablesColumnFile.timgrefno} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.missynctocoresys} "
        ")"
        "VALUES"
        "(${loanImageBean.trefno} ,"
        "${loanImageBean.mrefno} ,"
        "${loanImageBean.mloantrefno} ,"
        "${loanImageBean.mloanmrefno},"
        "${loanImageBean.mcustmrefno},"
        "${loanImageBean.mcusttrefno},"
        "'${loanImageBean.mimagestring}',"
        "'${loanImageBean.mimagebyteorfolder}', "
        "'${loanImageBean.mimagetype}' ,"
        "${tImagerefNo} ,"
        "'${loanImageBean.mcreateddt}' ,"
        "'${loanImageBean.mcreatedby}' ,"
        "'${loanImageBean.mlastupdatedt}' ,"
        "'${loanImageBean.mlastupdateby}' ,"
        "'${loanImageBean.mlastsynsdate}' ,"
        "${loanImageBean.missynctocoresys ?? 0} "
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${AppDatabase.customerLoanImageMaster}");
    });
  }

  Future<String> getCustomerFromNumbers(int mcustno) async {
    var db = await _getDb();
    String mobNo;
    var result;
    String query =
        'SELECT * FROM ${AppDatabase.customerFoundationMasterDetails}  WHERE ${TablesColumnFile.mcustno}  = $mcustno  ;';

//    print(query);
//     result = await db.rawQuery(query);
//
//    try {
//      if (result.isNotEmpty)
//        mobNo = result[0][TablesColumnFile.mMobile] as String;
//      else {
//        print("result is ${result}");
//      }
//    } catch (error, stackTrace) {
//      mobNo = null;
//    }

    query =
        'SELECT * FROM ${AppDatabase.customerFoundationMasterDetails}  WHERE ${TablesColumnFile.mcustno}  = $mcustno ;';
    result = await db.rawQuery(query);
    print(query);

    try {
      if (result.isNotEmpty)
        mobNo = result[0][TablesColumnFile.mmobno] as String;
      else {
        print("result is ${result}");
      }
    } catch (error, stackTrace) {
      mobNo = null;
    }
    return mobNo;
  }

  Future<int> updateCenterLocation(CenterDetailsBean bean) async {
    String str =
        "UPDATE ${AppDatabase.centerDetailsMaster} SET ${TablesColumnFile.mgeolatd}  = '${bean.mgeolatd}' AND "
        " ${TablesColumnFile.mgeologd} = ${bean.mgeologd}  WHERE ${TablesColumnFile.trefno} = ${bean.trefno} AND  ${TablesColumnFile.mrefno} = ${bean.mrefno}   ";

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(str);
    });
  }

  Future<UserRightBean> getUserRightsForID(int menuId) async {
    String query =
        "SELECT * FROM ${AppDatabase.UserRightsTable} WHERE ${TablesColumnFile.menuid} = ${menuId} ";
    print(query);
    var db = await _getDb();
    var result = await db.rawQuery(query);
    UserRightBean retBean;
    try {
      retBean = bindDataUserRightBeanListBean(result[0]);
    } catch (_) {}

    return retBean;
  }

  Future<int> deleteProspectData(DateTime dt) async {
    List<CreditBereauBean> cbList = await getDataBeforeDate(dt);
    String deleteQuery = "";
    var db = await _getDb();
    var result;
    for (CreditBereauBean cb in cbList) {
      deleteQuery =
          "DELETE FROM ${AppDatabase.creditBereauResultMaster} WHERE ${TablesColumnFile.mrefno} = ${cb.mrefno}"
          " AND ${TablesColumnFile.trefno} = ${cb.trefno}  ";
      print(deleteQuery);
      result = await db.rawQuery(deleteQuery);
      deleteQuery =
          "DELETE FROM ${AppDatabase.creditBereauLoanDetailsMaster} WHERE ${TablesColumnFile.mrefno} = ${cb.mrefno}"
          " AND ${TablesColumnFile.trefno} = ${cb.trefno}  ";
      result = await db.rawQuery(deleteQuery);

      print(deleteQuery);
    }
    if (cbList != null && cbList.length != 0) {
      deleteQuery =
          "DELETE FROM ${AppDatabase.creditBereauMaster}  WHERE ${TablesColumnFile.mlastupdatedt}  < '${dt}' ";
      print(deleteQuery);
      result = await db.rawQuery(deleteQuery);
      return cbList.length;
    }
    return 0;
  }

  Future<List<CreditBereauBean>> getDataBeforeDate(DateTime dt) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${AppDatabase.creditBereauMaster}  WHERE ${TablesColumnFile.mlastupdatedt} "
        " < '${dt}' ";
    print(selectQueryIsDataSynced);


    print("select query is ${selectQueryIsDataSynced}");

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    List<CreditBereauBean> listbean = new List<CreditBereauBean>();
    CreditBereauBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CreditBereauBean();
        bean = bindDataProspectbean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future createReportFilterMaster(Database db) {
    String query = "CREATE TABLE ${AppDatabase.reportFilterMaster} ("
        "${TablesColumnFile.mchartid} INTEGER ,"
        "${TablesColumnFile.mfieldname} TEXT ,"
        "${TablesColumnFile.mdisplay} TEXT,"
        "${TablesColumnFile.mismandatory} INTEGER ,"
        "${TablesColumnFile.mfieldid} INTEGER,"
        "${TablesColumnFile.mdefaultval} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.mchartid}, ${TablesColumnFile.mfieldname} ) "
        ");";

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future<int> updateReportFilterMaster(ReportMasterEntity reportMaster) async {
    print("trying to insert or replace ${AppDatabase.reportFilterMaster}");
    String insertQuery =
        'INSERT OR REPLACE INTO ${AppDatabase.reportFilterMaster} '
        "(${TablesColumnFile.mchartid} ,"
        "${TablesColumnFile.mfieldname} ,"
        "${TablesColumnFile.mismandatory} ,"
        "${TablesColumnFile.mdisplay} ,"
        "${TablesColumnFile.mfieldid},"
        "${TablesColumnFile.mdefaultval}"
        ")"
        "VALUES"
        "(${reportMaster.reportFilterComposite.mchartid} ,"
        "'${reportMaster.reportFilterComposite.mfieldname}' ,"
        "${reportMaster.mismandatory} ,"
        "'${reportMaster.mdisplay}',"
        "${reportMaster.mfieldid},"
        "'${reportMaster.mdefaultval}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${AppDatabase.reportFilterMaster}");
    });
  }

  Future<Null> deleteFromTable(String tableName) async {
    String query = "DELETE FROM  ${tableName} ";
    print(query);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(query);
    });
  }

  Future<List<ReportMasterEntity>> getReportFilterList(
      List<String> stringList, int chartId) async {
    List<ReportMasterEntity> retList = new List<ReportMasterEntity>();
    ReportMasterEntity tempEntity;
    String query = "";
    var db = await _getDb();
    for (String ab in stringList) {
      query =
          "SELECT * FROM ${AppDatabase.reportFilterMaster} WHERE ${TablesColumnFile.mchartid} = ${chartId} AND "
          "  ${TablesColumnFile.mfieldname} = '${ab}' ";
      print(query);

      var result = await db.rawQuery(query);

      try {
        tempEntity = new ReportMasterEntity();
        tempEntity = bindreportMasterEntity(result[0]);
        retList.add(tempEntity);
      } catch (error, stackTrace) {
        print(error.toString());
        print(stackTrace);
      }
    }

    return retList;
  }

  ReportMasterEntity bindreportMasterEntity(Map<String, dynamic> result) {
    ReportMasterEntity reportMasterEntity = new ReportMasterEntity();
    return ReportMasterEntity.fromMapLocalDataBase(result);
  }

  Future<List<CustomerLoanDetailsBean>> getCustomerLoanDetailsToDelete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int days = prefs.getInt(TablesColumnFile.LEADVALIDITYDAYS);
    DateTime lastUpdateDate;

    lastUpdateDate = DateTime.now()
        .subtract(Duration(days: days == null || days == 0 ? 60 : days));

    var db = await _getDb();
    CustomerLoanDetailsBean retBean = new CustomerLoanDetailsBean();

    List<CustomerLoanDetailsBean> loanDetailsList =
        new List<CustomerLoanDetailsBean>();
    /*String query =type=="LoanApp"? "SELECT *  FROM $customerLoanDetailsMaster":"SELECT *  FROM $customerLoanDetailsMaster WHERE ${TablesColumnFile.mleadstatus} = '${type}'";*/
    String query = "SELECT *  FROM ${AppDatabase.customerLoanDetailsMaster} "
        " WHERE ${TablesColumnFile.misdisbursed} = 1  OR  "
        " ${TablesColumnFile.mlastupdatedt} < '${lastUpdateDate}' ";
    var result;

    print("query is" + query);
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = AppDatabase.get().bindCustomerLoanDetails(result[i]);
        loanDetailsList.add(retBean);
      }
    } catch (e) {}
    return loanDetailsList;
  }
}