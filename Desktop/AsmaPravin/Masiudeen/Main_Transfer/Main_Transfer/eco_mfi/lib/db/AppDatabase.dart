import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:eco_mfi/beans/CustomerProductwiseCycleBean.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/workflow/Collateral/Collateral/Bean/CollateralBasicSelectionBean.dart';
import 'package:eco_mfi/pages/workflow/Collateral/CollateralREM/Bean/CollateralREMlandandhouseBean.dart';
import 'package:eco_mfi/pages/workflow/Collateral/CollatralVehicle/CollateralVehicleBean.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/InternalBankTransferBean.dart';
import 'package:eco_mfi/pages/workflow/Kyc/beans/KycMasterBean.dart';
import 'package:eco_mfi/MenuAndRights/MenuMasterBean.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/workflow/InternalBankTransfer/bean/GLAccountBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanCPVBusinessRecord.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanImageBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/SavingsCollectionSearch.dart';
import 'package:eco_mfi/pages/workflow/UserActivity/UserActivityBean.dart';
import 'package:eco_mfi/pages/workflow/collection/DailyCollectionSearchScreen.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/LoanCycleWiseLimitBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDescBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ContactPointVerificationBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/LoanLevelService.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingActivityMenuList.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingTDParameterService.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:eco_mfi/LoginBean.dart';
import 'package:eco_mfi/Utilities/globals.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/models/Label.dart';
import 'package:eco_mfi/models/Project.dart';
import 'package:eco_mfi/models/TaskLabels.dart';
import 'package:eco_mfi/pages/workflow/BranchMaster/BranchMasterBean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/CheckListGRTBean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/GRTBean.dart';
import 'package:eco_mfi/pages/workflow/GroupFormation/bean/GroupFoundation.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/InterestOffsetMaster/InterestOffsetBean.dart';
import 'package:eco_mfi/pages/workflow/InterestOffsetMaster/InterestOffsetServices.dart';
import 'package:eco_mfi/pages/workflow/InterestSlabMaster/InterestSlabBean.dart';
import 'package:eco_mfi/pages/workflow/InterestSlabMaster/InterestSlabServices.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/Product.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/PurposeOfLoan.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/RepaymentFrequency.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/TransactionMode.dart';
import 'package:eco_mfi/pages/workflow/LoanApprovalLimit/LoanApprovalLimitBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApprovalLimit/LoanApprovalLimitServices.dart';
import 'package:eco_mfi/pages/workflow/LoanCycleParameterPrimaryTable/LoanCycleParameterPrimaryBean.dart';
import 'package:eco_mfi/pages/workflow/LoanCycleParameterPrimaryTable/LoanCycleParameterPrimaryServices.dart';
import 'package:eco_mfi/pages/workflow/LoanCycleParameterSecondaryTable/LoanCycleParameterSecondaryBean.dart';
import 'package:eco_mfi/pages/workflow/LoanCycleParameterSecondaryTable/LoanCycleParameterSecondaryServices.dart';

import 'package:eco_mfi/pages/workflow/LoanUtilization/LoanUtilizationBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/MiniStatementBean.dart';
import 'package:eco_mfi/pages/workflow/Savings/bean/SavingsListBean.dart';
import 'package:eco_mfi/pages/workflow/SpeedoMeter/bean/SpeedoMeterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterServices.dart';
import 'package:eco_mfi/pages/workflow/address/beans/AreaDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/CountryDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/DistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/StateDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/address/beans/SubDistrictDropDownBean.dart';
import 'package:eco_mfi/pages/workflow/collection/bean/CollectionMasterBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/NOCImageBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/SettingsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AddressDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/AssetDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BorrowingDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/BusinessExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerBusinessDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/HouseholdExpenditureDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/PPIBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingLookupDataServices.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingLookupDataServices.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';

import 'package:eco_mfi/pages/workflow/centerfoundation/bean/CenterDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CbResultBean.dart';

import 'package:eco_mfi/pages/workflow/creditBereau/Bean/CreditBereauBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/CustomerListBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/FamilyDetailsBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/bean/ImageBean.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingSubLookupDataServices.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingTDOffsetInteresetMasterServices.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingTDRoiDataServices.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/NewTermDepositBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/ProductwiseInterestTableBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDOffsetInterestMasterBean.dart';
import 'package:eco_mfi/pages/workflow/termDeposit/TDParameterBean.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:eco_mfi/models/Tasks.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingLookupDataServices.dart';
import 'package:eco_mfi/pages/workflow/disbursment/bean/DisbursmentBean.dart';
//import 'package:eco_mfi/pages/workflow/LoanApplication/bean/LoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/pages/workflow/UserVaultBalance/UserVaultBalanceBean.dart';
import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';

//import 'package:eco_mfi/Kyc/beans/KycMasterBean.dart';
/// This is the singleton database class which handlers all database transactions
/// All the task raw queries is handle here and return a Future<T> with result
class AppDatabase {
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  static final AppDatabase _appDatabase = new AppDatabase._internal();
  static final userMasterTable = "User_Master";
  static final LookupMaster = "Lookup_Master";
  static final SystemParameterMaster = "System_Parameter_Master";
  static final TermDepositMaster = "Term_Deposit_Master";
  static final TDProductwiseInterestTable = "TD_Productwise_interest_table";
  static final TDOffsetInterestMaster = "TD_Offset_Interest_Master";

  static final InterestSlabMaster = "Interest_Slab_Master";
  static final InterestOffsetMaster = "Interest_Offset_Master";
  static final LoanCycleParameterPrimaryMaster =
      "Loan_Cycle_Parameter_Primary_Master";
  static final LoanCycleParameterSecondaryMaster =
      "Loan_Cycle_Parameter_Secondary_Master";

  static final SubLookupMaster = "Sub_Lookup_Master";
  static final creditBereauMaster = "Credit_Bereau_Master";
  static final creditBereauBatchMaster = "Credit_Bereau_Batch_Master";
  static final creditBereauResultMaster = "Credit_Bereau_Result_Master";

  //static final creditBereauResultDetailsMaster="Credit_Bereau_Result_Details_Master";
  static final creditBereauLoanDetailsMaster =
      "Credit_Bereau_Loan_Details_Master";
  static final groupFoundationMaster = "Group_Foundation";
  static final centerDetailsMaster = "Center_Details_Master";

  //static final centerFoundationMaster = "Center_Foundation_Master";
  //changes of restructure
  static final lastSyncedDateTimeMaster = "lastSyncedDateTimeMaster";
  static final customerFoundationMasterDetails =
      "customerFoundationMasterDetails";
  static final customerFoundationFamilyMasterDetails =
      "customerFoundationFamilyMasterDetails";
  static final customerFoundationAddressMasterDetails =
      "customerFoundationAddressMasterDetails";
  static final customerFoundationBorrowingMasterDetails =
      "customerFoundationBorrowingMasterDetails";
  static final customerBusinessDetailMaster = "CustomerBusinessDetailMaster";

  //changes of restructure ends
  static final imageMaster = "Image_Master";
  static final PPIMaster = "PPI_Master";
  static final productMaster = "Product_Master";
  static final purposeMaster = "Purpose_Master";
  static final transactionModeMaster = "Transaction_Mode_Master";
  static final repaymentFrequencyMaster = "repayment_Frequency_Master";
  static final customerLoanDetailsMaster = "customer_Loan_Details_Master";
  static final loanUtilizationMaster = "loan_Utilization_Master";
  static final savingsCollectionMaster = "savings_Collection_Master";
  static final gaurantorMaster = "gaurantor_Master";
  static final savingsMaster = "savings_Master";
  static final miniStatementMaster = "mini_Statement_Master";
  static final settingsMaster = "settings_Master";
  static final customerNOCImageMaster = "customer_NOC_Image_Master";

  //static final checkListMaster = "check_list_Master";
  static final cgt1QaMaster = "CGT1_QA_Master";
  static final cgt2QaMaster = "CGT2_QA_Master";
  static final grtQaMaster = "GRT_QA_Master";
  static final CGT1Master = "CGT1_Master";
  static final CGT2Master = "CGT2_Master";
  static final GRTMaster = "GRT_Master";
  static final speedoMeterMaster = "SpeedoMeter_Master";
  static final countryMaster = "Country_Master";
  static final stateMaster = "State_Master";
  static final districtMaster = "District_Master";
  static final subDistrictMaster = "SubDistrict_Master";
  static final areaMaster = "Area_Master";
  static final businessExpenseMaster = "Business_Expense_Master";
  static final houseExpenseMaster = "Household_Expense_Master";
  static final assetDetailMaster = "Asset_Detail_Master";
  static final collectionMaster = "collection_Master";
  static final collectedLoansAmtMaster = "collected_LoansAmt_Master";
  static final loanApprovalLimitMaster = "Loan_Approval_limit_Master";
  static final branchMaster = "Branch_Master";
  static final CHARTMASTER = "Charts_Master";
  static final CHARTFILTERMASTER = "Charts_Filter_Master";
  static final tdParameterMaster = 'TD_Parameter_Master';
  static final glAccountMaster = 'GL_Account_Master';
  static final disbursmentMaster = "disbursment_Master";
  //Menumaster and user rights
  static final MenuMaster = "Menu_Master";
  static final UserRightsTable = "User_Rights_table";

  static final customerCpvMaster = "CustomerCpvMaster";
  static final loanLevelMaster = "Loan_Level_Master";
  static final socialEnvironmentMaster = "Social_Environment_Master";
  static final tradeNeighbourRefCheckMaster =
      "Trade_Neighbour_Ref_Check_Master";
  static final deviationFormMaster = "Deviation_Form_Master";
  static final CosutomerLoanCashFlowMaster = "Customer_Loan_Cash_Flow_Master";
  static final kycMaster = "Kyc_Master";
  static final LoanCPVBusinessRecord = "Loan_CPVBusiness_Record";
  static final customerLoanImageMaster = "customer_loan_image_master";
  static final disbursedMaster = "disbursed_master";
  static final userVaultBalance = "User_Vault_Balance";
  static final UserActivityMaster = "User_Activity_Master";
  static final collateralsMaster = "Collaterals_Master";
  static final CollateralREMlandandhouseMaster =
      "Collateral_REM_land_and_house_Master";
  static final collateralVehicleMaster = "Collateral_Vehicle_Master";
  static final CustomerProductwiseCycleMaster =
      "Customer_Productwise_Cycle_Master";
  static final internalBankTransferMaster = "internal_Bank_Transfer_Master";

  static final loanCycleWiseLimitMaster = "loan_Cycle_Wise_Limit_Master";
  static final customerFingerPrintMaster = "customer_finger_print_master";
  static final chartFavouriteMaster = "chart_Favourite_Master";
  static final colorPalleteMaster = "color_Pallete_Master";
  static final chartFavouritetype = "chart_favourite_type";
  static final reportFilterMaster = "report_Filter_Master";
  bool chk = false;

  //private internal constructor to make it singleton
  AppDatabase._internal();

  CreditBereauBean creditbean = new CreditBereauBean();

  Database _database;

  static AppDatabase get() {
    return _appDatabase;
  }

  bool didInit = false;

  /// Use this method to access the database which will provide you future of [Database],
  /// because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async {
    if (!didInit) await _init();
    return _database;
  }

  Future _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "microfinance.db");
    _database = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await _createProjectTable(db);
          await _createTaskTable(db);
          await _createLabelTable(db);
          await _createUserMasterTable(db);
          await _createTermDepositMasterTable(db);
          await _createTDProductwiseInterestTable(db);
          await _createTDOffsetInterestMaster(db);
          await _createCustomerFoundationMasterDetailsTable(db);
          await _createCreditbereauMaster(db);
          await _createCreditBereauResult(db);
          await _createCreditBereauLoanDetails(db);
          await _createGroupFoundation(db);
          await _createCenterFoundation(db);
          await _createImageMaster(db);
          await _createCustomerFoundationFamilyDetailsTable(db);
          await _createLastSyncedDateTimeMaster(db);
          await _createCustomerFoundationBorrowingDetailsTable(db);
          await _createCustomerFoundationAddressDetailsBeanTable(db);
          await _createProductMaster(db);
          await _createPurposeMaster(db);
          await _createTransactionModeMaster(db);
          await _createRepaymentFrequencyMaster(db);
          await _createCustomerLoanDetailsMaster(db);
          await _createLoanUtilizationMaster(db);
          await _createLookupMasterTable(db);
          await _createInterestSlabMasterTable(db);
          await _createSystemParameterMasterTable(db);
          await _createLoanCycleParameterPrimaryMasterTable(db);
          await _createLoanCycleParameterSecondaryMasterTable(db);
          await _createInterestOffsetMasterTable(db);
          await _createSubLookupMasterTable(db);
          await _createPPIMaster(db);
          await _createNOCImageMaster(db);
          //await _createCheckListMaster(db);
          await _createCgt1QaMaster(db);
          await _createCgt2QaMaster(db);
          await _createGrtQaMaster(db);
          await _createSavingsCollectionMaster(db);
          await _createGaurantorMaster(db);

          await _createSettingsMaster(db);

          await _createminiStatementMaster(db);

          await _createSavingsMaster(db);
          await _createCustomerProductwiseCycleMaster(db);
          await _createDisbursmentMaster(db);
          await _createCGT1Master(db);
          await _createCGT2Master(db);
          await _createGRTMaster(db);
          await _createSpeedoMeterMaster(db);
          await _createCountryMaster(db);
          await _createStateMaster(db);
          await _createDistrictMaster(db);
          await _createSubDistrictMaster(db);
          await _createAreaMaster(db);
          await _createCustomerBusinessDetailMaster(db);
          await _createCustomerCpvMaster(db);
          await _createBusinessExpenseMaster(db);
          await _createHouseExpenseMaster(db);
          await _createAssetDetailMaster(db);
          await _createCollectionMasterTable(db);
          await _createCollectedLoanAmtMasterTable(db);
          await _createLoanApprovalLimitMasterTable(db);
          await _createBranchMasterTable(db);
          await _createChartsMaster(db);
          await _createChartsFilterMaster(db);
          await _createGLAccountMasterTable(db);
          await _createTDParameterMasterMasterTable(db);
          await _createMenuMasterTable(db);
          await _createUserRightsTable(db);
          await _createLoanLevelMaster(db);
          await _createSocialEnvironmentMaster(db);
          await _createTradeNeighbourRefCheckMaster(db);
          await _createDeviationFormMaster(db);
          await _createCustomerLoanCashFlow(db);
          await _createKycMaster(db);
          await _createLoanCPVBusinessRecord(db);
          await _createCustomerLoanImageMaster(db);
          await _createDisbursedMaster(db);
          await _createUserVaultBalanceMaster(db);
          await _createUserActivityMaster(db);
          await _createCollateralsMaster(db);
          await createCollateralREMlandandhouseMasterTable(db);
          await createCollateralVehicleMasterTable(db);
          await createInternalBankTransfer(db);
          await createLoanCycleWiseLimitMaster(db);
          await _createCustomerFingerPrintMaster(db);
          await _createChartFavouriteMaster(db);
      await _createColorPalleteMaster(db);
      await _createChartFavouriteTypeMaster(db);
      await AppDatabaseExtended.get().createReportFilterMaster(db);
        }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
          /* await db.execute("DROP TABLE ${Tasks.tblTask}");
          await db.execute("DROP TABLE ${Project.tblProject}");
          await db.execute("DROP TABLE ${TaskLabels.tblTaskLabel}");
          await db.execute("DROP TABLE ${Label.tblLabel}");
          await db.execute("DROP TABLE $userMasterTable");
          await db.execute("DROP TABLE $creditBereauMaster");
          await db.execute("DROP TABLE $creditBereauResultMaster");
          await db.execute("DROP TABLE $creditBereauLoanDetailsMaster");
          await db.execute("DROP TABLE $groupFoundationMaster");
          await db.execute("DROP TABLE $centerDetailsMaster");
          await db.execute("DROP TABLE $imageMaster");
          await db.execute("DROP TABLE $LookupMaster");
          await db.execute("DROP TABLE $SystemParameterMaster");
          await db.execute("DROP TABLE $InterestSlabMaster");
          await db.execute("DROP TABLE $InterestOffsetMaster");
          await db.execute("DROP TABLE $LoanCycleParameterPrimaryMaster");
          await db.execute("DROP TABLE $LoanCycleParameterSecondaryMaster");

          await db.execute("DROP TABLE $SubLookupMaster");
          await db.execute("DROP TABLE $lastSyncedDateTimeMaster");
          await db.execute("DROP TABLE $customerFoundationFamilyMasterDetails");

          await db.execute(
              "DROP TABLE $customerFoundationBorrowingMasterDetails");
          await db.execute("DROP TABLE $customerFoundationMasterDetails");
          await db.execute(
              "DROP TABLE $customerFoundationAddressMasterDetails");
          await db.execute("DROP TABLE $productMaster");
          await db.execute("DROP TABLE $purposeMaster");
          await db.execute("DROP TABLE $transactionModeMaster");
          await db.execute("DROP TABLE $repaymentFrequencyMaster");
          await db.execute("DROP TABLE $customerLoanDetailsMaster");
          await db.execute("DROP TABLE $loanUtilizationMaster");
          await db.execute("DROP TABLE $settingsMaster");
          await db.execute("DROP TABLE $savingsMaster");
          await db.execute("DROP TABLE $disbursmentMaster");
          await db.execute("DROP TABLE $miniStatementMaster");
          await db.execute("DROP TABLE $savingsCollectionMaster");
          await db.execute("DROP TABLE $gaurantorMaster");
          await db.execute("DROP TABLE $PPIMaster");
          await db.execute("DROP TABLE $customerNOCImageMaster");
          //await db.execute("DROP TABLE $checkListMaster");
          await db.execute("DROP TABLE $cgt1QaMaster");
          await db.execute("DROP TABLE $cgt2QaMaster");
          await db.execute("DROP TABLE $grtQaMaster");
          await db.execute("DROP TABLE $CGT1Master");
          await db.execute("DROP TABLE $CGT2Master");
          await db.execute("DROP TABLE $GRTMaster");
          await db.execute("DROP TABLE $speedoMeterMaster");
          await db.execute("DROP TABLE $countryMaster");
          await db.execute("DROP TABLE $stateMaster");
          await db.execute("DROP TABLE $districtMaster");
          await db.execute("DROP TABLE $subDistrictMaster");
          await db.execute("DROP TABLE $areaMaster");
          await db.execute("DROP TABLE $businessExpenseMaster");
          await db.execute("DROP TABLE $houseExpenseMaster");
          await db.execute("DROP TABLE $assetDetailMaster");
          await db.execute("DROP TABLE $collectionMaster");
          await db.execute("Drop TABLE $collectedLoansAmtMaster");
          await db.execute("Drop TABLE $loanApprovalLimitMaster");
          await db.execute("DROP TABLE $branchMaster");
          await db.execute("DROP TABLE ${CHARTMASTER}");
          await db.execute("DROP TABLE ${CHARTFILTERMASTER}");
          await db.execute("DROP TABLE ${glAccountMaster}");
          await db.execute("DROP TABLE $tdParameterMaster");
          await db.execute("DROP TABLE $MenuMaster");
          await db.execute("DROP TABLE $UserRightsTable");
          await db.execute("DROP TABLE $customerCpvMaster");
          await db.execute("DROP TABLE $loanLevelMaster");
          await db.execute("DROP TABLE $socialEnvironmentMaster");
          await db.execute("DROP TABLE $tradeNeighbourRefCheckMaster");
          await db.execute("DROP TABLE $deviationFormMaster");
          await db.execute("DROP TABLE ${CosutomerLoanCashFlowMaster}");
	        await db.execute("DROP TABLE $kycMaster");
          await db.execute("DROP TABLE $LoanCPVBusinessRecord");
          await db.execute("DROP TABLE $customerLoanImageMaster");
          await db.execute("DROP TABLE $disbursedMaster");
          await _createTermDepositMasterTable(db);
          await _createTDProductwiseInterestTable(db);
          await _createTDOffsetInterestMaster(db);
          await _createUserMasterTable(db);
          await _createCustomerFoundationMasterDetailsTable(db);
          await _createProjectTable(db);
          await _createTaskTable(db);
          await _createLabelTable(db);
          await _createCreditbereauMaster(db);
          await _createCreditBereauResult(db);
          await _createCreditBereauLoanDetails(db);
          await _createGroupFoundation(db);
          await _createCenterFoundation(db);
          await _createImageMaster(db);
          await _createLastSyncedDateTimeMaster(db);
          await _createCustomerFoundationFamilyDetailsTable(db);
          await _createCustomerFoundationBorrowingDetailsTable(db);
          await _createCustomerFoundationAddressDetailsBeanTable(db);
          await _createProductMaster(db);
          await _createPurposeMaster(db);
          await _createTransactionModeMaster(db);
          await _createRepaymentFrequencyMaster(db);
          await _createCustomerLoanDetailsMaster(db);
          await _createLoanUtilizationMaster(db);
          await _createLookupMasterTable(db);
          await _createInterestSlabMasterTable(db);
          await _createInterestSlabMasterTable(db);
          await _createInterestOffsetMasterTable(db);
          await _createLoanCycleParameterPrimaryMasterTable(db);
          await _createLoanCycleParameterSecondaryMasterTable(db);
          await _createSubLookupMasterTable(db);
          await _createPPIMaster(db);
          await _createNOCImageMaster(db);
          //await _createCheckListMaster(db);
          await _createCgt1QaMaster(db);
          await _createCgt2QaMaster(db);
          await _createGrtQaMaster(db);
          await _createSavingsCollectionMaster(db);
          await _createGaurantorMaster(db);
          await _createSettingsMaster(db);
          await _createminiStatementMaster(db);
          await _createSavingsMaster(db);
          await _createDisbursmentMaster(db);
          await _createCGT1Master(db);
          await _createCGT2Master(db);
          await _createGRTMaster(db);
          await _createSpeedoMeterMaster(db);
          await _createCountryMaster(db);
          await _createStateMaster(db);
          await _createDistrictMaster(db);
          await _createSubDistrictMaster(db);
          await _createAreaMaster(db);
          await _createCustomerBusinessDetailMaster(db);
          await _createCustomerCpvMaster(db);
          await _createBusinessExpenseMaster(db);
          await _createHouseExpenseMaster(db);
          await _createAssetDetailMaster(db);
          await _createCollectionMasterTable(db);
          await _createCollectedLoanAmtMasterTable(db);
          await _createLoanApprovalLimitMasterTable(db);
          await _createBranchMasterTable(db);
          await _createChartsMaster(db);
          await _createChartsFilterMaster(db);
	  await _createTDParameterMasterMasterTable(db);
          await _createGLAccountMasterTable(db);
          await _createMenuMasterTable(db);
          await _createUserRightsTable(db);
          await _createLoanLevelMaster(db);
	            await _createSocialEnvironmentMaster(db);
          await _createTradeNeighbourRefCheckMaster(db);
          await _createDeviationFormMaster(db);

          await _createCustomerLoanCashFlow(db);
	  //await kycMaster
          await _createKycMaster(db);
	  await _createLoanCPVBusinessRecord(db);
          await _createCustomerLoanImageMaster(db);
          await _createDisbursedMaster(db);
           _createCollateralsMaster(db);
            await createCollateralREMlandandhouseMasterTable(db);
            await _createColorPalleteMaster(db);
             await createCollateralVehicleMasterTable(db);*/
          await db.execute("DROP TABLE ${PPIMaster}");
          await _createPPIMaster(db);
          await createInternalBankTransfer(db);
          await db.execute("DROP TABLE $customerFingerPrintMaster");
          await _createCustomerFingerPrintMaster(db);
          await db.execute("DROP TABLE ${chartFavouriteMaster}");
          await _createChartFavouriteMaster(db);
        });
    didInit = true;
  }

  Future _createProjectTable(Database db) {
    return db.transaction((Transaction txn) async {
      txn.execute("CREATE TABLE ${Project.tblProject} ("
          "${Project.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Project.dbName} TEXT,"
          "${Project.dbColorName} TEXT,"
          "${Project.dbColorCode} INTEGER);");
      txn.rawInsert('INSERT INTO '
          '${Project.tblProject}(${Project.dbId},${Project.dbName},${Project.dbColorName},${Project.dbColorCode})'
          ' VALUES(1, "Inbox", "Grey", ${Colors.grey.value});');
    });
  }

  Future _createLabelTable(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${Label.tblLabel} ("
          "${Label.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${Label.dbName} TEXT,"
          "${Label.dbColorName} TEXT,"
          "${Label.dbColorCode} INTEGER);");
      txn.execute("CREATE TABLE ${TaskLabels.tblTaskLabel} ("
          "${TaskLabels.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
          "${TaskLabels.dbTaskId} INTEGER,"
          "${TaskLabels.dbLabelId} INTEGER,"
          "FOREIGN KEY(${TaskLabels.dbTaskId}) REFERENCES ${Tasks.tblTask}(${Tasks.dbId}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TaskLabels.dbLabelId}) REFERENCES ${Label.tblLabel}(${Label.dbId}) ON DELETE CASCADE);");
    });
  }

  Future _createTaskTable(Database db) {
    return db.execute("CREATE TABLE ${Tasks.tblTask} ("
        "${Tasks.dbId} INTEGER PRIMARY KEY AUTOINCREMENT,"
        "${Tasks.dbTitle} TEXT,"
        "${Tasks.dbComment} TEXT,"
        "${Tasks.dbDueDate} LONG,"
        "${Tasks.dbPriority} LONG,"
        "${Tasks.dbProjectID} LONG,"
        "${Tasks.dbStatus} LONG,"
        "FOREIGN KEY(${Tasks.dbProjectID}) REFERENCES ${Project.tblProject}(${Project.dbId}) ON DELETE CASCADE);");
  }

  Future<List<Tasks>> getTasks(
      {int startDate = 0, int endDate = 0, TaskStatus taskStatus}) async {
    var db = await _getDb();
    var whereClause = startDate > 0 && endDate > 0
        ? "WHERE ${Tasks.tblTask}.${Tasks.dbDueDate} BETWEEN $startDate AND $endDate"
        : "";

    if (taskStatus != null) {
      var taskWhereClause =
          "${Tasks.tblTask}.${Tasks.dbStatus} = ${taskStatus.index}";
      whereClause = whereClause.isEmpty
          ? "WHERE $taskWhereClause"
          : "$whereClause AND $taskWhereClause";
    }

    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
            'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
            'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
            'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} $whereClause GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

    return bindData(result);
  }

  Future<List<Tasks>> getTasksByProject(int projectId) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames '
            'FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
            'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
            'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=$projectId GROUP BY ${Tasks.tblTask}.${Tasks.dbId} ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

    return bindData(result);
  }

  Future<List<Tasks>> getTasksByLabel(String labelName) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT ${Tasks.tblTask}.*,${Project.tblProject}.${Project.dbName},${Project.tblProject}.${Project.dbColorCode},group_concat(${Label.tblLabel}.${Label.dbName}) as labelNames FROM ${Tasks.tblTask} LEFT JOIN ${TaskLabels.tblTaskLabel} ON ${TaskLabels.tblTaskLabel}.${TaskLabels.dbTaskId}=${Tasks.tblTask}.${Tasks.dbId} '
            'LEFT JOIN ${Label.tblLabel} ON ${Label.tblLabel}.${Label.dbId}=${TaskLabels.tblTaskLabel}.${TaskLabels.dbLabelId} '
            'INNER JOIN ${Project.tblProject} ON ${Tasks.tblTask}.${Tasks.dbProjectID} = ${Project.tblProject}.${Project.dbId} WHERE ${Tasks.tblTask}.${Tasks.dbProjectID}=${Project.tblProject}.${Project.dbId} GROUP BY ${Tasks.tblTask}.${Tasks.dbId} having labelNames LIKE "%$labelName%" ORDER BY ${Tasks.tblTask}.${Tasks.dbDueDate} ASC;');

    return bindData(result);
  }

  List<Tasks> bindData(List<Map<String, dynamic>> result) {
    List<Tasks> tasks = new List();
    for (Map<String, dynamic> item in result) {
      var myTask = new Tasks.fromMap(item);
      myTask.projectName = item[Project.dbName];
      myTask.projectColor = item[Project.dbColorCode];
      var labelComma = item["labelNames"];
      if (labelComma != null) {
        myTask.labelList = labelComma.toString().split(",");
      }
      tasks.add(myTask);
    }
    return tasks;
  }

  Future<List<Project>> getProjects({bool isInboxVisible = true}) async {
    var db = await _getDb();
    var whereClause = isInboxVisible ? ";" : " WHERE ${Project.dbId}!=1;";
    var result =
    await db.rawQuery('SELECT * FROM ${Project.tblProject} $whereClause');
    List<Project> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = new Project.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  Future<List<Label>> getLabels() async {
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM ${Label.tblLabel}');
    List<Label> projects = new List();
    for (Map<String, dynamic> item in result) {
      var myProject = new Label.fromMap(item);
      projects.add(myProject);
    }
    return projects;
  }

  /// Inserts or replaces the task.
  Future updateTask(Tasks task, {List<int> labelIDs}) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Tasks.tblTask}(${Tasks.dbId},${Tasks.dbTitle},${Tasks.dbProjectID},${Tasks.dbComment},${Tasks.dbDueDate},${Tasks.dbPriority},${Tasks.dbStatus})'
          ' VALUES(${task.id}, "${task.title}", ${task.projectId},"${task.comment}", ${task.dueDate},${task.priority.index},${task.tasksStatus.index})');
      if (id > 0 && labelIDs != null && labelIDs.length > 0) {
        labelIDs.forEach((labelId) {
          txn.rawInsert('INSERT OR REPLACE INTO '
              '${TaskLabels.tblTaskLabel}(${TaskLabels.dbId},${TaskLabels.dbTaskId},${TaskLabels.dbLabelId})'
              ' VALUES(null, $id, $labelId)');
        });
      }
    });
  }

  Future updateProject(Project project) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Project.tblProject}(${Project.dbId},${Project.dbName},${Project.dbColorCode},${Project.dbColorName})'
          ' VALUES(${project.id},"${project.name}", ${project.colorValue}, "${project.colorName}")');
    });
  }

  Future updateLabels(Label label) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawInsert('INSERT OR REPLACE INTO '
          '${Label.tblLabel}(${Label.dbName},${Label.dbColorCode},${Label.dbColorName})'
          ' VALUES("${label.name}", ${label.colorValue}, "${label.colorName}")');
    });
  }

  Future deleteProject(int projectID) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Project.tblProject} WHERE ${Project.dbId}==$projectID;');
    });
  }

  Future deleteTask(int taskID) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          'DELETE FROM ${Tasks.tblTask} WHERE ${Tasks.dbId}=$taskID;');
    });
  }

  Future updateTaskStatus(int taskID, TaskStatus status) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${Tasks.tblTask} SET ${Tasks.dbStatus} = '${status.index}' WHERE ${Tasks.dbId} = '$taskID'");
    });
  }

  Future<bool> isLabelExits(Label label) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${Label.tblLabel} WHERE ${Label.dbName} LIKE '${label.name}'");
    if (result.length == 0) {
      return await updateLabels(label).then((value) {
        return false;
      });
    } else {
      return true;
    }
  }

  Future _createChartFavouriteTypeMaster(Database db) {
    String query = "CREATE TABLE ${chartFavouritetype} ("
        "${TablesColumnFile.id} INETEGER PRIMARY KEY,"
        "${TablesColumnFile.typeName} TEXT ) ";
    return db.transaction((Transaction txn)  {
      txn.execute(query);
     // AppDatabaseExtended.get().updateDefaultchartFavouriteType();
    });
  }

  Future _createCollectionMasterTable(Database db) {
    String query = "CREATE TABLE ${collectionMaster} ("
        "${TablesColumnFile.masondate} DATETIME,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.macctstat} INTEGER,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupid} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mfocode} TEXT,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.midealbaldate} DATETIME,"
        "${TablesColumnFile.modamt} REAL,"
        "${TablesColumnFile.memiamt} REAL,"
        "${TablesColumnFile.mcurrentdue} REAL,"
        "${TablesColumnFile.midealbal} REAL,"
        "${TablesColumnFile.memino} INTEGER,"
        "${TablesColumnFile.mexpdate} DATETIME,"
        "${TablesColumnFile.mexpprnpaid} REAL,"
        "${TablesColumnFile.mexpintpaid} REAL,"
        "${TablesColumnFile.mpaidprn} REAL,"
        "${TablesColumnFile.mpaidint} REAL,"
        "${TablesColumnFile.mprnos} REAL,"
        "${TablesColumnFile.mintos} REAL,"
        "${TablesColumnFile.mclosint} REAL,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mappliedasind} TEXT,"
        "${TablesColumnFile.malmeffdate} DATETIME,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastopendate} DATETIME,"
        "${TablesColumnFile.mexcesspaid} REAL,"
        "${TablesColumnFile.msdbal} REAL,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.moverdueint} REAL,"
        "${TablesColumnFile.mpenalos} REAL,"
        "${TablesColumnFile.moverdueprn} REAL,"
        "${TablesColumnFile.mschemiint} REAL,"
        "${TablesColumnFile.mschemiprn} REAL,"
        "PRIMARY KEY (${TablesColumnFile.masondate}, ${TablesColumnFile.mlbrcode}, ${TablesColumnFile.mprdacctid}))";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  //TODO add ideal bal date here
  Future _createCollectedLoanAmtMasterTable(Database db) {
    String query = "CREATE TABLE ${collectedLoansAmtMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER ,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT ,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupid} INTEGER,"
        "${TablesColumnFile.mfocode} TEXT,"
        "${TablesColumnFile.memino} INTEGER,"
        "${TablesColumnFile.malmeffdate} DATETIME,"
        "${TablesColumnFile.madjfrmsd} INTEGER,"
        "${TablesColumnFile.madjfrmexcss} INTEGER,"
        "${TablesColumnFile.mpaidbygrp} INTEGER,"
        "${TablesColumnFile.mattndnc} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mremarks} TEXT,"
        "${TablesColumnFile.mcollamt} REAL, "
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.midealbaldate} DATETIME,"
        "${TablesColumnFile.mbatchcd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.mlongname} TEXT ,"
        "${TablesColumnFile.moverdueint} REAL,"
        "${TablesColumnFile.mpenalos} REAL,"
        "${TablesColumnFile.moverdueprn} REAL,"
        "${TablesColumnFile.mschemiint} REAL,"
        "${TablesColumnFile.mschemiprn} REAL, "
        "${TablesColumnFile.macctstat}  INTEGER,"
        "${TablesColumnFile.loanoutbal}  REAL ,"
        "${TablesColumnFile.mintos}  REAL,"
        "${TablesColumnFile.mlastopendate} DATETIME ,"
        "${TablesColumnFile.missynctocoresys}  INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno} ) "
        ");";

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createUserMasterTable(Database db) {
    print("shadab's  table xxxxxxxxxxxxx");
    String query = "CREATE TABLE ${userMasterTable} ("
        "${TablesColumnFile.musrcode} TEXT PRIMARY KEY,"
        "${TablesColumnFile.mcustaccesslvl} INTEGER,"
        "${TablesColumnFile.mextnno} INTEGER,"
        "${TablesColumnFile.mactiveinstn} TEXT,"
        "${TablesColumnFile.mautologoutperiod} INTEGER,"
        "${TablesColumnFile.mautologoutyn} TEXT,"
        "${TablesColumnFile.mbadloginsdt} DATETIME,"
        "${TablesColumnFile.memailid} TEXT,"
        "${TablesColumnFile.merror} INTEGER,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mgrpcd} INTEGER,"
        "${TablesColumnFile.misloggedinyn} INTEGER,"
        "${TablesColumnFile.mlastpwdchgdt} DATETIME,"
        "${TablesColumnFile.mlastsyslidt} DATETIME,"
        "${TablesColumnFile.mmaxbadlginperday} INTEGER,"
        "${TablesColumnFile.mmaxbadlginperinst} INTEGER,"
        "${TablesColumnFile.mmobile} TEXT,"
        "${TablesColumnFile.mnextpwdchgdt} DATETIME,"
        "${TablesColumnFile.mnextsyslgindt} DATETIME,"
        "${TablesColumnFile.mnoofbadlogins} INTEGER,"
        "${TablesColumnFile.mpwdchgforcedyn} TEXT,"
        "${TablesColumnFile.mpwdchgperioddays} INTEGER,"
        "${TablesColumnFile.mregdevicemacid} TEXT,"
        "${TablesColumnFile.mreportinguser} TEXT,"
        "${TablesColumnFile.mstatus} INTEGER,"
        "${TablesColumnFile.musrbrcode} INTEGER,"
        "${TablesColumnFile.musrdesignation} TEXT,"
        "${TablesColumnFile.musrname} TEXT,"
        "${TablesColumnFile.musrpass} TEXT,"
        "${TablesColumnFile.musrshortname} TEXT,"
        "${TablesColumnFile.mReason} TEXT,"
        "${TablesColumnFile.mSusDate} DATETIME,"
        "${TablesColumnFile.mJoinDate} DATETIME,"
        "${TablesColumnFile.mgender} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.agentleftfinger} TEXT,"
        "${TablesColumnFile.agentrightfinger} TEXT,"
        "${TablesColumnFile.profileimage} TEXT,"
        "${TablesColumnFile.mlocationtrackeronoff} INTEGER,"
        "${TablesColumnFile.mpathtrackeronoff} INTEGER"
        ");";
    print("table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createBranchMasterTable(Database db) {
    print("shadab's  table xxxxxxxxxxxxx");
    String query = "CREATE TABLE ${branchMaster} ("
        "${TablesColumnFile.mpbrcode} INTEGER PRIMARY KEY,"
        "${TablesColumnFile.mname} TEXT,"
        "${TablesColumnFile.mshortname} TEXT,"
        "${TablesColumnFile.madd1} TEXT,"
        "${TablesColumnFile.madd2} TEXT,"
        "${TablesColumnFile.madd3} TEXT,"
        "${TablesColumnFile.mcitycd} TEXT,"
        "${TablesColumnFile.mpincode} INTEGER,"
        "${TablesColumnFile.mcountrycd} TEXT,"
        "${TablesColumnFile.mbranchtype} INTEGER,"
        "${TablesColumnFile.mtele1} TEXT,"
        "${TablesColumnFile.mtele2} TEXT,"
        "${TablesColumnFile.mfaxno1} TEXT,"
        "${TablesColumnFile.mswiftaddr} TEXT,"
        "${TablesColumnFile.mpostcode} TEXT,"
        "${TablesColumnFile.mweekoff1} INTEGER,"
        "${TablesColumnFile.mweekoff2} INTEGER,"
        "${TablesColumnFile.mparentbrcode} INTEGER,"
        "${TablesColumnFile.mbranchtype1} INTEGER,"
        "${TablesColumnFile.mbranchcat} INTEGER,"
        "${TablesColumnFile.mformatndt} DATETIME,"
        "${TablesColumnFile.mdistrict} TEXT,"
        "${TablesColumnFile.mbrnmanager} TEXT,"
        "${TablesColumnFile.mstate} TEXT,"
        "${TablesColumnFile.mmingroupmembers} INTEGER,"
        "${TablesColumnFile.mmaxgroupmembers} INTEGER,"
        "${TablesColumnFile.msector} INTEGER,"
        "${TablesColumnFile.mbranchemailid} TEXT,"
        "${TablesColumnFile.mbiccode} TEXT,"
        "${TablesColumnFile.mlegacybrncd} TEXT,"
        "${TablesColumnFile.mlatitude} REAL,"
        "${TablesColumnFile.mlongitude} REAL,"
        "${TablesColumnFile.mlastopendate} DATETIME"
        ");";
    print("table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCreditbereauMaster(Database db) {
    print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxinside credit Master Create");
    String query = "CREATE TABLE ${creditBereauMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mqueueno} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mprospectdt} DATETIME,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mprospectname} TEXT,"
        "${TablesColumnFile.mmobno} INTEGER,"
        "${TablesColumnFile.mdob} DATETIME,"
        "${TablesColumnFile.motpverified} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mcbcheckstatus} TEXT,"
        "${TablesColumnFile.mprospectstatus} INTEGER,"
        "${TablesColumnFile.madd1} TEXT,"
        "${TablesColumnFile.madd2} TEXT,"
        "${TablesColumnFile.madd3} TEXT,"
        "${TablesColumnFile.mhomeloc} TEXT,"
        "${TablesColumnFile.mareacd} INTEGER,"
        "${TablesColumnFile.mvillage} TEXT,"
        "${TablesColumnFile.mdistcd} INTEGER,"
        "${TablesColumnFile.mstatecd} TEXT,"
        "${TablesColumnFile.mcountrycd} TEXT,"
        "${TablesColumnFile.mpincode} INTEGER,"
        "${TablesColumnFile.mcountryoforigin} TEXT,"
        "${TablesColumnFile.mnationality} TEXT,"
        "${TablesColumnFile.mpanno} TEXT,"
        "${TablesColumnFile.mpannodesc} TEXT,"
        "${TablesColumnFile.misuploaded} INTEGER,"
        "${TablesColumnFile.mspousename} TEXT,"
        "${TablesColumnFile.mspouserelation} TEXT,"
        "${TablesColumnFile.mnomineename} TEXT,"
        "${TablesColumnFile.mnomineerelation} TEXT,"
        "${TablesColumnFile.mcreditenqpurposetype} TEXT,"
        "${TablesColumnFile.mcreditequstage} TEXT,"
        "${TablesColumnFile.mcreditreporttransdatetype} TEXT,"
        "${TablesColumnFile.mcreditreporttransid} TEXT,"
        "${TablesColumnFile.mcreditrequesttype} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.mstreet} TEXT,"
        "${TablesColumnFile.mhouse} TEXT,"
        "${TablesColumnFile.mcity} TEXT,"
        "${TablesColumnFile.mstate} TEXT,"
        "${TablesColumnFile.mid1} TEXT,"
        "${TablesColumnFile.mid1desc} TEXT,"
        "${TablesColumnFile.motp} INTEGER,"
        "${TablesColumnFile.mroutedto} TEXT ,"
        "${TablesColumnFile.miscustcreated} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mtier} INTEGER DEFAULT 1,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mhighmarkchkdt} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    print("xxxxxxxxxxxxxxxxxxxtable Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCreditBereauResult(Database db) {
    String query = "CREATE TABLE ${creditBereauResultMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mrefresultsrno} INTEGER ,"
        "${TablesColumnFile.trefresultsrno} INTEGER ,"
        "${TablesColumnFile.mcbcheckstatus} TEXT,"
        "${TablesColumnFile.mdateofissue} TEXT,"
        "${TablesColumnFile.mdateofrequest} TEXT,"
        "${TablesColumnFile.miscustomercreated} TEXT,"
        "${TablesColumnFile.mpreparedfor} TEXT,"
        "${TablesColumnFile.mreportid} TEXT,"
        "${TablesColumnFile.mothrmficnt} INTEGER ,"
        "${TablesColumnFile.mloancycle} INTEGER ,"
        "${TablesColumnFile.mothrmficurbal} REAL ,"
        "${TablesColumnFile.mothrmfiovrdueamt} REAL ,"
        "${TablesColumnFile.mothrmfidisbamt} REAL ,"
        "${TablesColumnFile.mtotovrdueaccno} INTEGER ,"
        "${TablesColumnFile.mmfitotdisbamt} REAL ,"
        "${TablesColumnFile.mmfitotcurrentbal} REAL ,"
        "${TablesColumnFile.mmfitotovrdueamt} REAL ,"
        "${TablesColumnFile.mtotovrdueamt} REAL ,"
        "${TablesColumnFile.mtotcurrentbal} REAL ,"
        "${TablesColumnFile.mtotdisbamt} REAL ,"
        "${TablesColumnFile.mexpsramt} REAL ,"
        "${TablesColumnFile.mcbresultblob} TEXT ,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.trefno} , ${TablesColumnFile.mrefno})"
        ");";
    print(
        "xxxxxxxxxxxxxxxxxxx  ${creditBereauResultMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCreditBereauLoanDetails(Database db) {
    String query = "CREATE TABLE ${creditBereauLoanDetailsMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.trefsrno} INTEGER,"
        "${TablesColumnFile.mrefsrno} INTEGER,"
        "${TablesColumnFile.maccounttype} TEXT,"
        "${TablesColumnFile.mcurrentbalance} REAL,"
        "${TablesColumnFile.mcustbankacnum} TEXT,"
        "${TablesColumnFile.mdatereported} TEXT,"
        "${TablesColumnFile.mdisbursedamount} REAL,"
        "${TablesColumnFile.mnameofmfi} TEXT,"
        "${TablesColumnFile.mnocimagestring} TEXT,"
        "${TablesColumnFile.moverdueamount} REAL,"
        "${TablesColumnFile.mwriteoffamount} REAL,"
        "${TablesColumnFile.mmfiid} TEXT,"
        "PRIMARY KEY(${TablesColumnFile.trefno},${TablesColumnFile.mrefno},${TablesColumnFile.trefsrno})"
        ");";
    print(
        "xxxxxxxxxxxxxxxxxxx ${creditBereauLoanDetailsMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createGroupFoundation(Database db) {
    String query = "CREATE TABLE ${groupFoundationMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mgroupid} INTEGER,"
        "${TablesColumnFile.mgroupname} TEXT,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.magentcd} TEXT,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mGrprecogTestDate} DATETIME,"
        "${TablesColumnFile.mMaxGroupMembers} INTEGER,"
        "${TablesColumnFile.mMinGroupMembers} INTEGER,"
        "${TablesColumnFile.mgrouptype} TEXT,"
        "${TablesColumnFile.mgrtapprovedby} TEXT,"
        "${TablesColumnFile.mloanlimit} DOUBLE,"
        "${TablesColumnFile.meetingday} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.mgroupprdcode} TEXT,"
        "${TablesColumnFile.mgroupgender} TEXT,"
        "${TablesColumnFile.mrefcenterid} INTEGER,"
        "${TablesColumnFile.trefcenterid} INTEGER,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${groupFoundationMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCenterFoundation(Database db) {
    String query = "CREATE TABLE ${centerDetailsMaster} ("
        "${TablesColumnFile.trefno} INTEGER  ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mCenterId} INTEGER,"
        "${TablesColumnFile.mEffectiveDt} DATETIME,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcentername} TEXT,"
        "${TablesColumnFile.mcrs} TEXT,"
        "${TablesColumnFile.marea} INTEGER,"
        "${TablesColumnFile.mareatype} INTEGER,"
        "${TablesColumnFile.mformatndt} DATETIME,"
        "${TablesColumnFile.mmeetingfreq} TEXT,"
        "${TablesColumnFile.mmeetinglocn} TEXT,"
        "${TablesColumnFile.mmeetingday} INTEGER,"
        "${TablesColumnFile.mcentermthhmm} TEXT,"
        "${TablesColumnFile.mcentermtampm} INTEGER,"
        "${TablesColumnFile.mfirstmeetngdt} DATETIME,"
        "${TablesColumnFile.mnextmeetngdt} DATETIME,"
        "${TablesColumnFile.mlastmeetngdt} DATETIME,"
        "${TablesColumnFile.mrepayfrom} INTEGER,"
        "${TablesColumnFile.mrepayto} INTEGER,"
        "${TablesColumnFile.mcurrnoOfmembers} INTEGER,"
        "${TablesColumnFile.mcenterstatus} INTEGER,"
        "${TablesColumnFile.mdropoutdate} DATETIME,"
        "${TablesColumnFile.mlastmonitoringdate} DATETIME,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    for (var items in query.split(",")) {
      print(items);
    }

    print("xxxxxxxxxxxxxxxxxxx ${centerDetailsMaster} table Query Here is : " +
        query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createProductMaster(Database db) {
    String query = "CREATE TABLE ${productMaster} ("
        "${TablesColumnFile.trefno} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.mrefno} INTEGER  ,"
        "${TablesColumnFile.mlbrcode} INTEGER  ,"
        "${TablesColumnFile.mprdCd} TEXT,"
        "${TablesColumnFile.mname} TEXT,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mmoduletype} INTEGER,"
        "${TablesColumnFile.mcurCd} TEXT,"
        "${TablesColumnFile.mdivisiontype} TEXT,"
        "${TablesColumnFile.mnoofguaranter} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.mgraceperyn} TEXT,"
        "${TablesColumnFile.mgraceperinmnths} INTEGER,"
        "${TablesColumnFile.mgraceperindays} INTEGER"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${productMaster} table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createPurposeMaster(Database db) {
    String query = "CREATE TABLE ${purposeMaster} ("
        "${TablesColumnFile.purposeId} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.purposeName} TEXT,"
        "${TablesColumnFile.purposeDescription} TEXT);";
    print(
        "xxxxxxxxxxxxxxxxxxx ${purposeMaster} table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createTransactionModeMaster(Database db) {
    String query = "CREATE TABLE ${transactionModeMaster} ("
        "${TablesColumnFile.transactionModeId} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.transactionMode} TEXT,"
        "${TablesColumnFile.transactionModeDescription} TEXT);";
    print(
        "xxxxxxxxxxxxxxxxxxx ${transactionModeMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createRepaymentFrequencyMaster(Database db) {
    String query = "CREATE TABLE ${repaymentFrequencyMaster} ("
        "${TablesColumnFile.repaymentFrequencyId} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.repaymentFrequency} TEXT,"
        "${TablesColumnFile.repaymentFrequencyDescription} TEXT);";
    print(
        "xxxxxxxxxxxxxxxxxxx ${repaymentFrequencyMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCustomerLoanDetailsMaster(Database db) {
    String query = "CREATE TABLE ${customerLoanDetailsMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mappldloanamt} REAL,"
        "${TablesColumnFile.mapprvdloanamt} REAL,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mcustcategory} INTEGER,"
        "${TablesColumnFile.mloanamtdisbd} REAL,"
        "${TablesColumnFile.mloandisbdt} DATETIME,"
        "${TablesColumnFile.mleadstatus} INTEGER,"
        "${TablesColumnFile.mexpdt} DATETIME,"
        "${TablesColumnFile.minstamt} REAL,"
        "${TablesColumnFile.minststrtdt} DATETIME,"
        "${TablesColumnFile.minterestamount} REAL,"
        "${TablesColumnFile.mrepaymentmode} INTEGER,"
        "${TablesColumnFile.mmodeofdisb} INTEGER,"
        "${TablesColumnFile.mperiod} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mpurposeofLoan} INTEGER,"
        "${TablesColumnFile.msubpurposeofloan} INTEGER,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mroutefrom} TEXT,"
        "${TablesColumnFile.mrouteto} TEXT,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER ,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.mprdname} TEXT,"
        "${TablesColumnFile.mcustname} TEXT ,"
        "${TablesColumnFile.mApprovalDesc} TEXT ,"
        "${TablesColumnFile.merrormessage} TEXT ,"
        "${TablesColumnFile.mappliedasind} TEXT ,"
        "${TablesColumnFile.mcheckresaddchng} INTEGER,"
        "${TablesColumnFile.mspouserelname} TEXT,"
        "${TablesColumnFile.mcheckspouserepay} INTEGER,"
        "${TablesColumnFile.mcheckbiometric} INTEGER , "
        "${TablesColumnFile.mlbrcode} INTEGER , "
        "${TablesColumnFile.misdisbursed} INTEGER , "
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno}"
        ") );";
    print(
        "Customer Loan Details Master ${customerLoanDetailsMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }


  Future _createCgt1QaMaster(Database db) {
    return db.transaction((Transaction txn) {
      String table = "CREATE TABLE ${cgt1QaMaster} ("
          "${TablesColumnFile.tclcgt1refno} INTEGER,"
          "${TablesColumnFile.mclcgt1refno} INTEGER,"
          "${TablesColumnFile.trefno} INTEGER,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mquestionid} TEXT,"
          "${TablesColumnFile.manschecked} INTEGER,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tclcgt1refno})"
          "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${CGT1Master}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${CGT1Master}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";

      txn.execute(table);
    });
  }

  Future _createCgt2QaMaster(Database db) {
    String table = "CREATE TABLE ${cgt2QaMaster} ("
        "${TablesColumnFile.tclcgt2refno} INTEGER,"
        "${TablesColumnFile.mclcgt2refno} INTEGER,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mquestionid} TEXT,"
        "${TablesColumnFile.manschecked} INTEGER,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tclcgt2refno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${CGT2Master}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${CGT2Master}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(table);
    });
  }

  Future _createGrtQaMaster(Database db) {
    String table = "CREATE TABLE ${grtQaMaster} ("
        "${TablesColumnFile.tclgrtrefno} INTEGER,"
        "${TablesColumnFile.mclgrtrefno} INTEGER,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mquestionid} TEXT,"
        "${TablesColumnFile.manschecked} INTEGER,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tclgrtrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${GRTMaster}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${GRTMaster}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(table);
    });
  }

  Future _createGaurantorMaster(Database db) {
    String query = "CREATE TABLE ${gaurantorMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mloanmrefno} INTEGER,"
        "${TablesColumnFile.mloantrefno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mapplicanttype} INTEGER,"
        "${TablesColumnFile.mexistingcustyn} TEXT,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mnameofguar} TEXT,"
        "${TablesColumnFile.mgender} TEXT,"
        "${TablesColumnFile.mrelationwithcust} TEXT,"
        "${TablesColumnFile.mrelationsince} INTEGER,"
        "${TablesColumnFile.mage} INTEGER,"
        "${TablesColumnFile.mphone} TEXT,"
        "${TablesColumnFile.mmobile} TEXT,"
        "${TablesColumnFile.maddress} TEXT,"
        "${TablesColumnFile.mmonthlyincome} REAL,"
        "${TablesColumnFile.mdob} DATETIME,"
        "${TablesColumnFile.moccupationtype} INTEGER,"
        "${TablesColumnFile.mmainoccupation} INTEGER,"
        "${TablesColumnFile.mworkexpinyrs} INTEGER,"
        "${TablesColumnFile.mincomeothsources} REAL,"
        "${TablesColumnFile.mtotalincome} REAL,"
        "${TablesColumnFile.mhousetype} INTEGER,"
        "${TablesColumnFile.mworkingaddress} TEXT,"
        "${TablesColumnFile.mworkphoneno} TEXT,"
        "${TablesColumnFile.mmothermaidenname} TEXT,"
        "${TablesColumnFile.mpromissorynote} TEXT,"
        "${TablesColumnFile.mnationalidtype} INTEGER,"
        "${TablesColumnFile.mnationalid} INTEGER,"
        "${TablesColumnFile.mnationaliddesc} TEXT,"
        "${TablesColumnFile.maddress2} TEXT,"
        "${TablesColumnFile.maddress3} TEXT,"
        "${TablesColumnFile.maddress4} TEXT,"
        "${TablesColumnFile.mmaritalstatus} INTEGER,"
        "${TablesColumnFile.mreligioncd} INTEGER,"
        "${TablesColumnFile.meducationalqual} TEXT,"
        "${TablesColumnFile.memailaddr} TEXT,"
        "${TablesColumnFile.memployername} TEXT,"
        "${TablesColumnFile.mbusinessname} TEXT,"
        "${TablesColumnFile.mspousename} TEXT,"
        "${TablesColumnFile.mstatecd} TEXT,"
        "${TablesColumnFile.mtownship} TEXT,"
        "${TablesColumnFile.mvillage} INTEGER,"
        "${TablesColumnFile.mwardno} TEXT,"
        "${TablesColumnFile.mstatecddesc} TEXT,"
        "${TablesColumnFile.mtownshipdesc} TEXT,"
        "${TablesColumnFile.mvillagedesc} INTEGER,"
        "${TablesColumnFile.mwardnodesc} TEXT,"
        "${TablesColumnFile.mbuspropownership} INTEGER,"
        "${TablesColumnFile.mbusownership} INTEGER,"
        "${TablesColumnFile.mbustoaassetval} REAL,"
        "${TablesColumnFile.mbusleninyears} TEXT,"
        "${TablesColumnFile.mbusmonexpense} REAL,"
        "${TablesColumnFile.mbusmonhlynetprof} REAL,"
        "${TablesColumnFile.msamevillageorward} TEXT,"
        "${TablesColumnFile.mfacecapture} TEXT,"
        "${TablesColumnFile.mnrcphoto} TEXT,"
        "${TablesColumnFile.mnrcsecphoto} TEXT,"
        "${TablesColumnFile.mhouseholdphoto} TEXT,"
        "${TablesColumnFile.mhouseholdsecphoto} TEXT,"
        "${TablesColumnFile.maddressphoto} TEXT,"
        "${TablesColumnFile.msignature} TEXT,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
    //"${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mrefno}, ${TablesColumnFile.trefno}))";
    print("primary of gaurantor table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createSavingsCollectionMaster(Database db) {
    String query = "CREATE TABLE ${savingsCollectionMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.msvngacctrefno} INTEGER,"
        "${TablesColumnFile.msvngaccmrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mcollectiondate} DATETIME,"
        "${TablesColumnFile.mcollectedamount} REAL,"
        "${TablesColumnFile.mmoduletype} INTEGER,"
        "${TablesColumnFile.mremark} TEXT,"
        "${TablesColumnFile.mcashflow} TEXT,"
        "${TablesColumnFile.mentrydate} DATETIME,"
        "${TablesColumnFile.mbatchcd} TEXT,"
        "${TablesColumnFile.msetno} INTEGER,"
        "${TablesColumnFile.mscrollno} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} DATETIME,"
        "${TablesColumnFile.mlastsynsdate} TEXT,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.moperationdate} INTEGER,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mrefno}, ${TablesColumnFile.trefno}))";
    print("primary of Savings table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createminiStatementMaster(Database db) {
    String query = "CREATE TABLE ${miniStatementMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mbramchname} TEXT,"
        "${TablesColumnFile.mparticulars} TEXT,"
        "${TablesColumnFile.mlcytrnamt} REAL,"
        "${TablesColumnFile.macttotballcy} REAL,"
        "${TablesColumnFile.mtotallienfcy} REAL,"
        "${TablesColumnFile.mentrydate} TEXT,"
        "${TablesColumnFile.mdrcr} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0)";
    print(query.toString());
    print(" Mini Statement table created");

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createSavingsMaster(Database db) {
    String query = "CREATE TABLE ${savingsMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mmobno} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mdateopen} DATETIME,"
        "${TablesColumnFile.mdateclosed} DATETIME,"
        "${TablesColumnFile.mfreezetype} INTEGER,"
        "${TablesColumnFile.macctstat} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mactTotbalfcy} REAL,"
        "${TablesColumnFile.mtotallienfcy} REAL,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mmoduletype} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.mcrs} TEXT,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        "${TablesColumnFile.missynctocoresys} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mrefno} , ${TablesColumnFile.trefno}))";
    print("primary of Savings table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }
  Future _createCustomerProductwiseCycleMaster(Database db) {
    String query = "CREATE TABLE ${CustomerProductwiseCycleMaster} ("
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mcycle} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.missynctocoresys} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mprdcd} , ${TablesColumnFile.mcustno}))";
    print("primary of CustomerProductwiseCycle table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }
  Future _createDisbursmentMaster(Database db) {
    String query = "CREATE TABLE ${disbursmentMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mefffromdate} DATETIME,"
        "${TablesColumnFile.mdisburseddate} DATETIME,"
        "${TablesColumnFile.minstlstartdate} DATETIME,"
        "${TablesColumnFile.minstlamt} REAL,"
        "${TablesColumnFile.minstlintcomp} REAL,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mappliedasindvyn} TEXT,"
        "${TablesColumnFile.mnewtopupflag} INTEGER,"
        "${TablesColumnFile.msancdate} DATETIME,"
        "${TablesColumnFile.mdisbursedamt} REAL,"
        "${TablesColumnFile.msdamt} REAL,"
        "${TablesColumnFile.mrebateamt} REAL,"
        "${TablesColumnFile.mchargesamt} REAL,"
        "${TablesColumnFile.mdisbursedamtcoltd} REAL,"
        "${TablesColumnFile.msdamtcoltd} REAL,"
        "${TablesColumnFile.mrebateamtcoltd} REAL,"
        "${TablesColumnFile.mchargesamtcoltd} REAL,"
        "${TablesColumnFile.mdisbursedamtflag} INTEGER,"
        "${TablesColumnFile.msdamtflag} INTEGER,"
        "${TablesColumnFile.mrebateamtflag} INTEGER,"
        "${TablesColumnFile.mchargesamtflag} INTEGER,"
        "${TablesColumnFile.mreason} TEXT,"
        "${TablesColumnFile.msetno} INTEGER,"
        "${TablesColumnFile.mscrollno} INTEGER,"
        "${TablesColumnFile.mentrydate} DATETIME,"
        "${TablesColumnFile.mbatchcd} TEXT,"
        "${TablesColumnFile.mmainscrollno} INTEGER,"
        "${TablesColumnFile.mbatchnumber} TEXT,"
        "${TablesColumnFile.mnarration} TEXT,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mcrs} TEXT,"
        "${TablesColumnFile.msuspbatchcd} TEXT,"
        "${TablesColumnFile.msuspsetno} INTEGER,"
        "${TablesColumnFile.msuspscrollno} INTEGER,"
        "${TablesColumnFile.msspmainscrollno} INTEGER,"
        "${TablesColumnFile.mpartcashamount} REAL,"
        "${TablesColumnFile.mpartcashbatchcd} TEXT,"
        "${TablesColumnFile.mpartcashsetno} INTEGER,"
        "${TablesColumnFile.mpartcashscrollno} INTEGER,"
        "${TablesColumnFile.mpartcashmainscrollno} INTEGER,"
        "${TablesColumnFile.mneftclsrBatchCd} TEXT,"
        "${TablesColumnFile.mneftclsrsetno} INTEGER,"
        "${TablesColumnFile.mneftclsrscrollno} INTEGER,"
        "${TablesColumnFile.mneftclsrmainscrollno} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mdisbamount} REAL,"
        "${TablesColumnFile.mchargesamt1} REAL,"
        "${TablesColumnFile.mchargesamt2} REAL,"
        "${TablesColumnFile.mchargesamt0} REAL,"
        "${TablesColumnFile.mchargesamt3} REAL,"
        "${TablesColumnFile.mchargesamt4} REAL,"
        "${TablesColumnFile.mchargesamt5} REAL,"
        "${TablesColumnFile.mchargesamt6} REAL,"
        "${TablesColumnFile.mchargesamt7} REAL,"
        "${TablesColumnFile.mchargesamt8} REAL,"
        "${TablesColumnFile.mchargesamt9} REAL,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0 ,"
        "${TablesColumnFile.mchargescollectiontype} INTEGER DEFAULT 0 ,"
        "${TablesColumnFile.msdcollectiontype} INTEGER DEFAULT 0 ,"
        "${TablesColumnFile.mthirdpartyamount} REAL "
        ")";
    print("primary of Disbursment table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createDisbursedMaster(Database db) {
    String query = "CREATE TABLE ${disbursedMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mefffromdate} DATETIME,"
        "${TablesColumnFile.mdisburseddate} DATETIME,"
        "${TablesColumnFile.minstlstartdate} DATETIME,"
        "${TablesColumnFile.minstlamt} REAL,"
        "${TablesColumnFile.minstlintcomp} REAL,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mappliedasindvyn} TEXT,"
        "${TablesColumnFile.mnewtopupflag} INTEGER,"
        "${TablesColumnFile.msancdate} DATETIME,"
        "${TablesColumnFile.mdisbursedamt} REAL,"
        "${TablesColumnFile.msdamt} REAL,"
        "${TablesColumnFile.mrebateamt} REAL,"
        "${TablesColumnFile.mchargesamt} REAL,"
        "${TablesColumnFile.mdisbursedamtcoltd} REAL,"
        "${TablesColumnFile.msdamtcoltd} REAL,"
        "${TablesColumnFile.mrebateamtcoltd} REAL,"
        "${TablesColumnFile.mchargesamtcoltd} REAL,"
        "${TablesColumnFile.mdisbursedamtflag} INTEGER,"
        "${TablesColumnFile.msdamtflag} INTEGER,"
        "${TablesColumnFile.mrebateamtflag} INTEGER,"
        "${TablesColumnFile.mchargesamtflag} INTEGER,"
        "${TablesColumnFile.mreason} TEXT,"
        "${TablesColumnFile.msetno} INTEGER,"
        "${TablesColumnFile.mscrollno} INTEGER,"
        "${TablesColumnFile.mentrydate} DATETIME,"
        "${TablesColumnFile.mbatchcd} TEXT,"
        "${TablesColumnFile.mmainscrollno} INTEGER,"
        "${TablesColumnFile.mbatchnumber} TEXT,"
        "${TablesColumnFile.mnarration} TEXT,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mcrs} TEXT,"
        "${TablesColumnFile.msuspbatchcd} TEXT,"
        "${TablesColumnFile.msuspsetno} INTEGER,"
        "${TablesColumnFile.msuspscrollno} INTEGER,"
        "${TablesColumnFile.msspmainscrollno} INTEGER,"
        "${TablesColumnFile.mpartcashamount} REAL,"
        "${TablesColumnFile.mpartcashbatchcd} TEXT,"
        "${TablesColumnFile.mpartcashsetno} INTEGER,"
        "${TablesColumnFile.mpartcashscrollno} INTEGER,"
        "${TablesColumnFile.mpartcashmainscrollno} INTEGER,"
        "${TablesColumnFile.mneftclsrBatchCd} TEXT,"
        "${TablesColumnFile.mneftclsrsetno} INTEGER,"
        "${TablesColumnFile.mneftclsrscrollno} INTEGER,"
        "${TablesColumnFile.mneftclsrmainscrollno} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mdisbamount} REAL,"
        "${TablesColumnFile.mchargesamt1} REAL,"
        "${TablesColumnFile.mchargesamt2} REAL,"
        "${TablesColumnFile.mchargesamt0} REAL,"
        "${TablesColumnFile.mchargesamt3} REAL,"
        "${TablesColumnFile.mchargesamt4} REAL,"
        "${TablesColumnFile.mchargesamt5} REAL,"
        "${TablesColumnFile.mchargesamt6} REAL,"
        "${TablesColumnFile.mchargesamt7} REAL,"
        "${TablesColumnFile.mchargesamt8} REAL,"
        "${TablesColumnFile.mchargesamt9} REAL,"
        "${TablesColumnFile.mcheckbiometric} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mdisbstatus} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mrouteto} TEXT,"
        "${TablesColumnFile.mremarks} TEXT,"
        "${TablesColumnFile.misauthorized} INTEGER DEFAULT 0,"
        "${TablesColumnFile.mamttodisb} REAL,"
        "${TablesColumnFile.missynctocoresys} INTEGER DEFAULT 0, "
        " PRIMARY KEY (${TablesColumnFile.mrefno} , ${TablesColumnFile.trefno}))";
    print("secondary of Disbursment table");
    print(query.toString());
    print("SuccessFull Creation Of Disbused Master");
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createSettingsMaster(Database db) {
    String query = "CREATE TABLE ${settingsMaster} ("
        "${TablesColumnFile.trefno} INTEGER PRIMARY KEY,"
        "${TablesColumnFile.musrcode} TEXT,"
        "${TablesColumnFile.musrpass} TEXT,"
        "${TablesColumnFile.mipaddress} TEXT,"
        "${TablesColumnFile.mportno} TEXT,"
        "${TablesColumnFile.isHttps} INTEGER DEFAULT 0,"
        "${TablesColumnFile.isPortRequired} INTEGER DEFAULT 0,"
        "${TablesColumnFile.yesno} INTEGER)";
    print("primary of settings table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createLoanUtilizationMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${loanUtilizationMaster} ("
          "${TablesColumnFile.mcustno} INTEGER ,"
          "${TablesColumnFile.mcustname} TEXT,"
          "${TablesColumnFile.mgroupcd} INTEGER,"
          "${TablesColumnFile.mcenterid} INTEGER,"
          "${TablesColumnFile.mpurposeofLoan} TEXT,"
          "${TablesColumnFile.mprdacctid} TEXT,"
          "${TablesColumnFile.mactualutilization} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.musrname} TEXT,"
          "${TablesColumnFile.mremarks} TEXT,"
          "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0 "
          ");");
    });
  }

  Future _createCGT1Master(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${CGT1Master} ("
          "${TablesColumnFile.trefno} INTEGER,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.loantrefno} INTEGER,"
          "${TablesColumnFile.loanmrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mcgt1doneby} TEXT,"
          "${TablesColumnFile.mstarttime} TEXT,"
          "${TablesColumnFile.mendtime} TEXT,"
          "${TablesColumnFile.mroutefrom} TEXT,"
          "${TablesColumnFile.mrouteto} TEXT,"
          "${TablesColumnFile.mremark} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mcreatedby} TEXT,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.mlastupdateby} TEXT,"
          "${TablesColumnFile.mgeolocation} TEXT,"
          "${TablesColumnFile.mgeolatd} TEXT,"
          "${TablesColumnFile.mgeologd} TEXT,"
          "${TablesColumnFile.missynctocoresys} INTEGER,"
          "${TablesColumnFile.mlastsynsdate} DATETIME,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno})"
          ");");
    });
  }

  Future _createCGT2Master(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${CGT2Master} ("
          "${TablesColumnFile.trefno} INTEGER ,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.loantrefno} INTEGER,"
          "${TablesColumnFile.loanmrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mcgt2doneby} TEXT,"
          "${TablesColumnFile.mstarttime} TEXT,"
          "${TablesColumnFile.mendtime} TEXT,"
          "${TablesColumnFile.mroutefrom} TEXT,"
          "${TablesColumnFile.mrouteto} TEXT,"
          "${TablesColumnFile.mremark} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mcreatedby} TEXT,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.mlastupdateby} TEXT,"
          "${TablesColumnFile.mgeolocation} TEXT,"
          "${TablesColumnFile.mgeolatd} TEXT,"
          "${TablesColumnFile.mgeologd} TEXT,"
          "${TablesColumnFile.missynctocoresys} INTEGER,"
          "${TablesColumnFile.mlastsynsdate} DATETIME,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno})"
          ");");
    });
  }

  Future _createGRTMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${GRTMaster} ("
          "${TablesColumnFile.trefno} INTEGER ,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.loantrefno} INTEGER,"
          "${TablesColumnFile.loanmrefno} INTEGER,"
          "${TablesColumnFile.mleadsid} TEXT,"
          "${TablesColumnFile.mgrtdoneby} TEXT,"
          "${TablesColumnFile.mstarttime} TEXT,"
          "${TablesColumnFile.mendtime} TEXT,"
          "${TablesColumnFile.mroutefrom} TEXT,"
          "${TablesColumnFile.mrouteto} TEXT,"
          "${TablesColumnFile.mremark} TEXT,"
          "${TablesColumnFile.midtype1status} TEXT,"
          "${TablesColumnFile.midtype2status} TEXT,"
          "${TablesColumnFile.midtype3status} TEXT,"
          "${TablesColumnFile.mcreateddt} DATETIME,"
          "${TablesColumnFile.mcreatedby} TEXT,"
          "${TablesColumnFile.mlastupdatedt} DATETIME,"
          "${TablesColumnFile.mlastupdateby} TEXT,"
          "${TablesColumnFile.mgeolocation} TEXT,"
          "${TablesColumnFile.mgeolatd} TEXT,"
          "${TablesColumnFile.mgeologd} TEXT,"
          "${TablesColumnFile.missynctocoresys} INTEGER,"
          "${TablesColumnFile.mlastsynsdate} DATETIME,"
          "${TablesColumnFile.mhouseVerifiImg} TEXT,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno})"
          ");");
    });
  }

  Future _createSpeedoMeterMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${speedoMeterMaster} ("
          "${TablesColumnFile.usrName} TEXT,"
          "${TablesColumnFile.effDate} DATETIME ,"
          "${TablesColumnFile.geoLocation} TEXT,"
          "${TablesColumnFile.geoLongitude} TEXT,"
          "${TablesColumnFile.geoLatitude} TEXT,"
          "${TablesColumnFile.startingFromImg} TEXT,"
          "${TablesColumnFile.endingFromImg} TEXT,"
          "${TablesColumnFile.startingPoint} INTEGER,"
          "${TablesColumnFile.endingPoint} INTEGER,"
          "${TablesColumnFile.totMeterReading} INTEGER ,"
          "${TablesColumnFile.updatedBy} TEXT,"
          "${TablesColumnFile.createdBy} TEXT,"
          "${TablesColumnFile.createdAt} DATETIME,"
          "${TablesColumnFile.updatedAt} DATETIME,"
          "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
          "PRIMARY KEY(${TablesColumnFile.effDate},${TablesColumnFile.usrName}));");
    });
  }

  Future _createCountryMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${countryMaster} ("
          "${TablesColumnFile.cntryCd} TEXT PRIMARY KEY ,"
          "${TablesColumnFile.countryName} TEXT,"
      //"${TablesColumnFile.updatedBy} TEXT,"
      //"${TablesColumnFile.createdBy} TEXT,"
      //"${TablesColumnFile.updatedAt} DATETIME,"
          "${TablesColumnFile.createdAt} DATETIME);");
    });
  }

  Future _createStateMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${stateMaster} ("
          "${TablesColumnFile.stateCd} TEXT PRIMARY KEY ,"
          "${TablesColumnFile.stateDesc} TEXT,"
          "${TablesColumnFile.cntryCd} TEXT,"
          "${TablesColumnFile.createdAt} DATETIME);");
    });
  }

  Future _createDistrictMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${districtMaster} ("
          "${TablesColumnFile.distCd} INTEGER PRIMARY KEY ,"
          "${TablesColumnFile.distDesc} TEXT,"
          "${TablesColumnFile.stateCd} TEXT,"
          "${TablesColumnFile.createdAt} DATETIME);");
    });
  }

  Future _createSubDistrictMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${subDistrictMaster} ("
          "${TablesColumnFile.placeCd} TEXT PRIMARY KEY ,"
          "${TablesColumnFile.placeCdDesc} TEXT,"
          "${TablesColumnFile.distCd} INTEGER,"
          "${TablesColumnFile.createdAt} DATETIME);");
    });
  }

  Future _createAreaMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${areaMaster} ("
          "${TablesColumnFile.areaCd} INTEGER,"
          "${TablesColumnFile.placeCd} TEXT,"
          "${TablesColumnFile.areaDesc} TEXT,"
          "${TablesColumnFile.createdAt} DATETIME,"
          "PRIMARY KEY(${TablesColumnFile.areaCd},${TablesColumnFile.placeCd}));");
    });
  }

  //Create Table PPIMaster

  Future _createNOCImageMaster(Database db) {
    String query = "CREATE TABLE ${customerNOCImageMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.serialNo} INTEGER,"
        "${TablesColumnFile.imageString} TEXT,"
        "${TablesColumnFile.createdAt} DATETIME,"
        "${TablesColumnFile.updatedAt} DATETIME,"
        "${TablesColumnFile.mnameofmfi} STRING,"
        "${TablesColumnFile.isDataSynced} INTEGER, "
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.serialNo})"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${customerNOCImageMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

//Charts Master
  _createChartsMaster(Database db) {
    String query = "CREATE TABLE ${CHARTMASTER} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mchartid} INTEGER,"
        "${TablesColumnFile.mtitle} TEXT,"
        "${TablesColumnFile.mxcatg} TEXT,"
        "${TablesColumnFile.mycatg} TEXT,"
        "${TablesColumnFile.mzcatg} TEXT,"
        "${TablesColumnFile.misonline} INTEGER,"
        "${TablesColumnFile.mquerydesc} TEXT,"
        "${TablesColumnFile.mdefaulttype} TEXT,"
        "${TablesColumnFile.mquery} TEXT,"
        "${TablesColumnFile.mtype} TEXT,"
        "${TablesColumnFile.mdatasource} TEXT,"
        "${TablesColumnFile.subtitle} TEXT,"
        "${TablesColumnFile.subdescription} TEXT,"
        "${TablesColumnFile.image} TEXT,"
        "${TablesColumnFile.status} TEXT,"
        "${TablesColumnFile.subdisplaytype} TEXT,"
        "${TablesColumnFile.mkey} TEXT,"
        "${TablesColumnFile.codelink} TEXT,"
        "${TablesColumnFile.parenttype} TEXT,"
        "${TablesColumnFile.childtype} TEXT,"
        "${TablesColumnFile.premetivedatatype} INTEGER,"
        "${TablesColumnFile.xminval} INTEGER,"
        "${TablesColumnFile.yminval} INTEGER,"
        "${TablesColumnFile.xinterval} REAL,"
        "${TablesColumnFile.yinterval} REAL,"
        "${TablesColumnFile.xcaption} TEXT,"
        "${TablesColumnFile.ycaption} TEXT,"
        "${TablesColumnFile.isfavalwed} INTEGER,"
        "${TablesColumnFile.xcaprot} INTEGER,"
        "${TablesColumnFile.ycaprot} INTEGER,"
        "${TablesColumnFile.xaxisvsbl} INTEGER,"
        "${TablesColumnFile.yaxisvsbl} INTEGER,"
        "${TablesColumnFile.islegvis} INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    print("primary of lookup table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  //charts filter
  _createChartsFilterMaster(Database db) {
    String query = "CREATE TABLE ${CHARTFILTERMASTER} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mchartid} INTEGER,"
        "${TablesColumnFile.mfilterid} TEXT,"
        "${TablesColumnFile.mdesc} TEXT,"
        "${TablesColumnFile.mdatatype} TEXT,"
        "${TablesColumnFile.mdatalen} INTEGER,"
        "${TablesColumnFile.mfield1value} TEXT,"
        "${TablesColumnFile.mdefaultvalue} TEXT,"
        "${TablesColumnFile.mdatatypedynamicquery} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    print("primary of lookup table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  _createGLAccountMasterTable(Database db) {
    String query = "CREATE TABLE ${glAccountMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";
    print("GL Master Table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createSocialEnvironmentMaster(Database db) {
    String query = "CREATE TABLE ${socialEnvironmentMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mloantrefno} INTEGER ,"
        "${TablesColumnFile.mloanmrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mbrwexclist} INTEGER,"
        "${TablesColumnFile.mbrwnontargetlist} INTEGER,"
        "${TablesColumnFile.mbrwairemission} INTEGER,"
        "${TablesColumnFile.mbrwwastewater} INTEGER,"
        "${TablesColumnFile.mbrwsolidhazardous} INTEGER,"
        "${TablesColumnFile.mbrwchemicalfuels} INTEGER,"
        "${TablesColumnFile.mbrwnoisefumes} INTEGER,"
        "${TablesColumnFile.mbrwresconsuption} INTEGER,"
        "${TablesColumnFile.mcinodesignation} INTEGER,"
        "${TablesColumnFile.mcinci} INTEGER,"
        "${TablesColumnFile.msilar} INTEGER,"
        "${TablesColumnFile.msidrofls} INTEGER,"
        "${TablesColumnFile.msiils} INTEGER,"
        "${TablesColumnFile.msiiip} INTEGER,"
        "${TablesColumnFile.msicnc} INTEGER,"
        "${TablesColumnFile.msiasc} INTEGER,"
        "${TablesColumnFile.msinsi} INTEGER,"
        "${TablesColumnFile.mlinpp} INTEGER,"
        "${TablesColumnFile.mliieh} INTEGER,"
        "${TablesColumnFile.mliiwc} INTEGER,"
        "${TablesColumnFile.mliite} INTEGER,"
        "${TablesColumnFile.mliueo} INTEGER,"
        "${TablesColumnFile.mlipmw} INTEGER,"
        "${TablesColumnFile.mliema} INTEGER,"
        "${TablesColumnFile.mlicfl} INTEGER,"
        "${TablesColumnFile.mlipevc} INTEGER,"
        "${TablesColumnFile.mlireou} INTEGER,"
        "${TablesColumnFile.mlinli} INTEGER,"
        "${TablesColumnFile.mbrwcat} INTEGER,"
        "${TablesColumnFile.mleadstatus} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${socialEnvironmentMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createTradeNeighbourRefCheckMaster(Database db) {
    String query = "CREATE TABLE ${tradeNeighbourRefCheckMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mloantrefno} INTEGER ,"
        "${TablesColumnFile.mloanmrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.msupname} TEXT,"
        "${TablesColumnFile.msupaddress} TEXT,"
        "${TablesColumnFile.msupcontact} TEXT,"
        "${TablesColumnFile.msupcredit} TEXT,"
        "${TablesColumnFile.msuponcredit} TEXT,"
        "${TablesColumnFile.mclientdelay} INTEGER,"
        "${TablesColumnFile.mdefpayment} TEXT,"
        "${TablesColumnFile.mproductsup} TEXT,"
        "${TablesColumnFile.msalcycles} INTEGER,"
        "${TablesColumnFile.mvalsalcycles} TEXT,"
        "${TablesColumnFile.mloanlender} TEXT,"
        "${TablesColumnFile.mfacility} TEXT,"
        "${TablesColumnFile.mturnover} INTEGER,"
        "${TablesColumnFile.mremarks} TEXT,"
        "${TablesColumnFile.mbuyersname} TEXT,"
        "${TablesColumnFile.mbuyersaddress} TEXT,"
        "${TablesColumnFile.mcontactno} TEXT,"
        "${TablesColumnFile.mbuyingperiod} INTEGER,"
        "${TablesColumnFile.mcreditbuying} TEXT,"
        "${TablesColumnFile.mdays} TEXT,"
        "${TablesColumnFile.mproducts} TEXT,"
        "${TablesColumnFile.mmonthlypur} TEXT,"
        "${TablesColumnFile.mquality} INTEGER,"
        "${TablesColumnFile.mreliableper} TEXT,"
        "${TablesColumnFile.mcusremarks} TEXT,"
        "${TablesColumnFile.mneigname} TEXT,"
        "${TablesColumnFile.mneigadd} TEXT,"
        "${TablesColumnFile.mknownclient} INTEGER,"
        "${TablesColumnFile.mimprovement} INTEGER,"
        "${TablesColumnFile.mrelperson} TEXT,"
        "${TablesColumnFile.mleadstatus} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${tradeNeighbourRefCheckMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createDeviationFormMaster(Database db) {
    String query = "CREATE TABLE ${deviationFormMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mloantrefno} INTEGER ,"
        "${TablesColumnFile.mloanmrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mdevloanapp} TEXT,"
        "${TablesColumnFile.mdrnrc} INTEGER,"
        "${TablesColumnFile.mdrmni} INTEGER,"
        "${TablesColumnFile.mdrdbr} INTEGER,"
        "${TablesColumnFile.mdrmfi} INTEGER,"
        "${TablesColumnFile.mdrbl} INTEGER,"
        "${TablesColumnFile.mdevapproval} TEXT,"
        "${TablesColumnFile.mleadstatus} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";

    print("xxxxxxxxxxxxxxxxxxx ${deviationFormMaster} table Query Here is : " +
        query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createUserVaultBalanceMaster(Database db) {
    String query = "CREATE TABLE ${userVaultBalance} ("
        "${TablesColumnFile.musercode} TEXT  ,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.acctStat} INTEGER,"
        "${TablesColumnFile.cashtype} INTEGER,"
        "${TablesColumnFile.magenta} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.usertype} TEXT,"
        "${TablesColumnFile.mbalance} REAL,"
        "PRIMARY KEY (${TablesColumnFile.musercode},${TablesColumnFile.mlbrcode},${TablesColumnFile.mcurcd})"
        ");";

    print("xxxxxxxxxxxxxxxxxxx ${userVaultBalance} table Query Here is : " +
        query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }


  Future _createChartFavouriteMaster(Database db) {
    String query = "CREATE TABLE ${chartFavouriteMaster} ("
        "${TablesColumnFile.mrefno} INTEGER  ,"
        "${TablesColumnFile.mcharttype} TEXT , "
        "${TablesColumnFile.mchartfavtype} TEXT , "
        "PRIMARY KEY (${TablesColumnFile.mrefno},${TablesColumnFile.mcharttype})"
        ");";

    print("xxxxxxxxxxxxxxxxxxx ${chartFavouriteMaster} table Query Here is : " +
        query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }
  Future createLoanCycleWiseLimitMaster(Database db) {
    String query = "CREATE TABLE ${loanCycleWiseLimitMaster} ("
        "${TablesColumnFile.mloancycle} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.mloanlimit} REAL "
        ");";

    print("xxxxxxxxxxxxxxxxxxx ${userVaultBalance} table Query Here is : " +
        query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createUserActivityMaster(Database db) {
    String query = "CREATE TABLE ${UserActivityMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.musercode1} TEXT,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mtxnamount} REAL,"
        "${TablesColumnFile.msystemnarration} TEXT,"
        "${TablesColumnFile.musernarration} TEXT,"
        "${TablesColumnFile.mactivity} TEXT,"
        "${TablesColumnFile.mmoduletype} INTEGER,"
        "${TablesColumnFile.mtxnrefno} TEXT,"
        "${TablesColumnFile.mcorerefno} TEXT,"
        "${TablesColumnFile.status} TEXT,"
        "${TablesColumnFile.screenname} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mentrydate} DATETIME ,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";

    print("xxxxxxxxxxxxxxxxxxx ${UserActivityMaster} table Query Here is : " +
        query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createColorPalleteMaster(Database db) {
    String query = "CREATE TABLE ${colorPalleteMaster} ("
        " trefno INTEGER  ,"
        " appbar INTEGER ,"
        " subappbar INTEGER ,"
        " appbaricon INTEGER ,"
        " subappbaricon INTEGER ,"
        " appbartext INTEGER ,"
        " subappbartext INTEGER ,"
        " icon INTEGER ,"
        " chrtnavbtn INTEGER ,"
        "chrttitle INTEGER ,"
        "chrttitleborder INTEGER ,  "
        "misselected INTEGER ,"
        "mname TEXT ,"
        "PRIMARY KEY(trefno)"
        ");";
    print("xxxxxxxxxxxxxxxxxxx ${colorPalleteMaster} table Query Here is : " +
        query);
    return db.transaction((Transaction txn)  {
       txn.execute(query);
      //AppDatabaseExtended.get().updatedefaultColorPalleteTable();
    });
  }

  Future updateUserVaultBalanceMaster(UserVaultBalanceBean bean) async {
    print("trying to insert or replace ${userVaultBalance}");
    String insertQuery = "INSERT OR REPLACE INTO ${userVaultBalance}  "
        "(${TablesColumnFile.musercode} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.acctStat} ,"
        "${TablesColumnFile.cashtype} ,"
        "${TablesColumnFile.magenta} ,"
        "${TablesColumnFile.mcurcd} ,"
        "${TablesColumnFile.usertype} ,"
        "${TablesColumnFile.mbalance} "
        ") "
        "VALUES "
        "('${bean.userVaultBalanceCompositetEntity.musercode}' ,"
        "${bean.userVaultBalanceCompositetEntity.mlbrcode} ,"
        "${bean.acctStat} ,"
        "${bean.cashtype},"
        "'${bean.userVaultBalanceCompositetEntity.currency}',"
        "'${bean.magenta}',"
        "'${bean.usertype}',"
        "'${bean.mbalance}'"
        "); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(insertQuery.toString() +
          " insertQuery after insert in ${userVaultBalance}");
    });
  }

  Future updateDeviationFormMaster(DeviationFormBean bean) async {
    print("trying to insert or replace ${deviationFormMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${deviationFormMaster}  "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mloantrefno} ,"
        "${TablesColumnFile.mloanmrefno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mcustmrefno}  ,"
        "${TablesColumnFile.mcusttrefno}  ,"
        "${TablesColumnFile.mdevloanapp},"
        "${TablesColumnFile.mdrnrc},"
        "${TablesColumnFile.mdrmni},"
        "${TablesColumnFile.mdrdbr},"
        "${TablesColumnFile.mdrmfi},"
        "${TablesColumnFile.mdrbl},"
        "${TablesColumnFile.mdevapproval},"
        "${TablesColumnFile.mleadstatus},"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.missynctocoresys} "
        ") "
        "VALUES "
        "(${bean.trefno} ,"
        "${bean.mrefno} ,"
        "${bean.mloantrefno} ,"
        "${bean.mloanmrefno},"
        "'${bean.mleadsid}',"
        "${bean.mcusttrefno},"
        "${bean.mcustmrefno},"
        "'${bean.mdevloanapp}',"
        "${bean.mdrnrc},"
        "${bean.mdrmni},"
        "${bean.mdrdbr},"
        "${bean.mdrmfi},"
        "${bean.mdrbl},"
        "'${bean.mdevapproval}',"
        "${bean.mleadstatus},"
        "'${bean.mcreateddt}' ,"
        "'${bean.mcreatedby}' ,"
        "'${bean.mlastupdatedt}' ,"
        "'${bean.mlastupdateby}' ,"
        "'${bean.mgeolocation}' ,"
        "'${bean.mgeolatd}' ,"
        "'${bean.mgeologd}' ,"
        "'${bean.mlastsynsdate}'  , "
        "${bean.missynctocoresys} "
        "); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${deviationFormMaster}");
    });
  }

  Future updateTradeNeighbourRefCheckMaster(
      TradeAndNeighbourRefCheckBean bean) async {
    print("trying to insert or replace ${tradeNeighbourRefCheckMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${tradeNeighbourRefCheckMaster}  "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mloantrefno} ,"
        "${TablesColumnFile.mloanmrefno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mcustmrefno}  ,"
        "${TablesColumnFile.mcusttrefno}  ,"
        "${TablesColumnFile.msupname},"
        "${TablesColumnFile.msupaddress},"
        "${TablesColumnFile.msupcontact},"
        "${TablesColumnFile.msupcredit},"
        "${TablesColumnFile.msuponcredit},"
        "${TablesColumnFile.mclientdelay},"
        "${TablesColumnFile.mdefpayment},"
        "${TablesColumnFile.mproductsup},"
        "${TablesColumnFile.msalcycles},"
        "${TablesColumnFile.mvalsalcycles},"
        "${TablesColumnFile.mloanlender},"
        "${TablesColumnFile.mfacility},"
        "${TablesColumnFile.mturnover},"
        "${TablesColumnFile.mremarks},"
        "${TablesColumnFile.mbuyersname},"
        "${TablesColumnFile.mbuyersaddress},"
        "${TablesColumnFile.mcontactno},"
        "${TablesColumnFile.mbuyingperiod},"
        "${TablesColumnFile.mcreditbuying},"
        "${TablesColumnFile.mdays},"
        "${TablesColumnFile.mproducts},"
        "${TablesColumnFile.mmonthlypur},"
        "${TablesColumnFile.mquality},"
        "${TablesColumnFile.mreliableper},"
        "${TablesColumnFile.mcusremarks},"
        "${TablesColumnFile.mneigname},"
        "${TablesColumnFile.mneigadd},"
        "${TablesColumnFile.mknownclient},"
        "${TablesColumnFile.mimprovement},"
        "${TablesColumnFile.mrelperson},"
        "${TablesColumnFile.mleadstatus},"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.missynctocoresys} "
        ") "
        "VALUES "
        "(${bean.trefno} ,"
        "${bean.mrefno} ,"
        "${bean.mloantrefno} ,"
        "${bean.mloanmrefno},"
        "'${bean.mleadsid}',"
        "${bean.mcusttrefno},"
        "${bean.mcustmrefno},"
        "'${bean.msupname}',"
        "'${bean.msupaddress}',"
        "${bean.msupcontact},"
        "'${bean.msupcredit}',"
        "'${bean.msuponcredit}',"
        "${bean.mclientdelay},"
        "'${bean.mdefpayment}',"
        "'${bean.mproductsup}',"
        "${bean.msalcycles},"
        "'${bean.mvalsalcycles}',"
        "'${bean.mloanlender}',"
        "'${bean.mfacility}',"
        "${bean.mturnover},"
        "'${bean.mremarks}',"
        "'${bean.mbuyersname}',"
        "'${bean.mbuyersaddress}',"
        "'${bean.mcontactno}',"
        "${bean.mbuyingperiod},"
        "'${bean.mcreditbuying}',"
        "'${bean.mdays}',"
        "'${bean.mproducts}',"
        "'${bean.mmonthlypur}',"
        "${bean.mquality},"
        "'${bean.mreliableper}',"
        "'${bean.mcusremarks}',"
        "'${bean.mneigname}',"
        "'${bean.mneigadd}',"
        "${bean.mknownclient},"
        "${bean.mimprovement},"
        "'${bean.mrelperson}',"
        "${bean.mleadstatus},"
        "'${bean.mcreateddt}' ,"
        "'${bean.mcreatedby}' ,"
        "'${bean.mlastupdatedt}' ,"
        "'${bean.mlastupdateby}' ,"
        "'${bean.mgeolocation}' ,"
        "'${bean.mgeolatd}' ,"
        "'${bean.mgeologd}' ,"
        "'${bean.mlastsynsdate}'  , "
        "${bean.missynctocoresys} "
        "); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${tradeNeighbourRefCheckMaster}");
    });
  }

  Future updateSocialEnvironmentMaster(SocialAndEnvironmentalBean bean) async {
    print("trying to insert or replace ${socialEnvironmentMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${socialEnvironmentMaster}  "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mloantrefno} ,"
        "${TablesColumnFile.mloanmrefno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mcustmrefno}  ,"
        "${TablesColumnFile.mcusttrefno}  ,"
        "${TablesColumnFile.mbrwexclist},"
        "${TablesColumnFile.mbrwnontargetlist},"
        "${TablesColumnFile.mbrwairemission},"
        "${TablesColumnFile.mbrwwastewater},"
        "${TablesColumnFile.mbrwsolidhazardous},"
        "${TablesColumnFile.mbrwchemicalfuels},"
        "${TablesColumnFile.mbrwnoisefumes},"
        "${TablesColumnFile.mbrwresconsuption},"
        "${TablesColumnFile.mcinodesignation},"
        "${TablesColumnFile.mcinci},"
        "${TablesColumnFile.msilar},"
        "${TablesColumnFile.msidrofls},"
        "${TablesColumnFile.msiils},"
        "${TablesColumnFile.msiiip},"
        "${TablesColumnFile.msicnc},"
        "${TablesColumnFile.msiasc},"
        "${TablesColumnFile.msinsi},"
        "${TablesColumnFile.mlinpp},"
        "${TablesColumnFile.mliieh},"
        "${TablesColumnFile.mliiwc},"
        "${TablesColumnFile.mliite},"
        "${TablesColumnFile.mliueo},"
        "${TablesColumnFile.mlipmw},"
        "${TablesColumnFile.mliema},"
        "${TablesColumnFile.mlicfl},"
        "${TablesColumnFile.mlipevc},"
        "${TablesColumnFile.mlireou},"
        "${TablesColumnFile.mlinli},"
        "${TablesColumnFile.mbrwcat},"
        "${TablesColumnFile.mleadstatus},"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.missynctocoresys} "
        ") "
        "VALUES "
        "(${bean.trefno} ,"
        "${bean.mrefno} ,"
        "${bean.mloantrefno} ,"
        "${bean.mloanmrefno},"
        "'${bean.mleadsid}',"
        "${bean.mcusttrefno},"
        "${bean.mcustmrefno},"
        "${bean.mbrwexclist},"
        "${bean.mbrwnontargetlist},"
        "${bean.mbrwairemission},"
        "${bean.mbrwwastewater},"
        "${bean.mbrwsolidhazardous},"
        "${bean.mbrwchemicalfuels},"
        "${bean.mbrwnoisefumes},"
        "${bean.mbrwresconsuption},"
        "${bean.mcinodesignation},"
        "${bean.mcinci},"
        "${bean.msilar},"
        "${bean.msidrofls},"
        "${bean.msiils},"
        "${bean.msiiip},"
        "${bean.msicnc},"
        "${bean.msiasc},"
        "${bean.msinsi},"
        "${bean.mlinpp},"
        "${bean.mliieh},"
        "${bean.mliiwc},"
        "${bean.mliite},"
        "${bean.mliueo},"
        "${bean.mlipmw},"
        "${bean.mliema},"
        "${bean.mlicfl},"
        "${bean.mlipevc},"
        "${bean.mlireou},"
        "${bean.mlinli},"
        "${bean.mbrwcat},"
        "${bean.mleadstatus},"
        "'${bean.mcreateddt}' ,"
        "'${bean.mcreatedby}' ,"
        "'${bean.mlastupdatedt}' ,"
        "'${bean.mlastupdateby}' ,"
        "'${bean.mgeolocation}' ,"
        "'${bean.mgeolatd}' ,"
        "'${bean.mgeologd}' ,"
        "'${bean.mlastsynsdate}'  , "
        "${bean.missynctocoresys} "
        "); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${socialEnvironmentMaster}");
    });
  }

  Future updateGroupFoundation(GroupFoundationBean gfb) async {
    print("trying to insert or replace ${groupFoundationMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${groupFoundationMaster}  "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mgroupid} ,"
        "${TablesColumnFile.mgroupname} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.magentcd} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mGrprecogTestDate} ,"
        "${TablesColumnFile.mMaxGroupMembers} ,"
        "${TablesColumnFile.mMinGroupMembers} ,"
        "${TablesColumnFile.mgrouptype} ,"
        "${TablesColumnFile.mgrtapprovedby} ,"
        "${TablesColumnFile.mloanlimit} ,"
        "${TablesColumnFile.meetingday} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.mgroupprdcode},"
        "${TablesColumnFile.mgroupgender},"
        "${TablesColumnFile.mrefcenterid} ,"
        "${TablesColumnFile.trefcenterid} ,"
        "${TablesColumnFile.missynctocoresys}, "
        "${TablesColumnFile.merrormessage} "
        ") "
        "VALUES "
        "(${gfb.trefno} ,"
        "${gfb.mrefno} ,"
        "${gfb.mgroupid} ,"
        "'${gfb.mgroupname} ',"
        "${gfb.mlbrcode} ,"
        "'${gfb.magentcd}' ,"
        "${gfb.mcenterid} ,"
        "'${gfb.mGrprecogTestDate}' ,"
        "${gfb.mMaxGroupMembers} ,"
        "${gfb.mMinGroupMembers} ,"
        "'${gfb.mgrouptype}' ,"
        "'${gfb.mgrtapprovedby}' ,"
        "${gfb.mloanlimit} ,"
        "${gfb.meetingday} ,"
        "'${gfb.mcreateddt}' ,"
        "'${gfb.mcreatedby}' ,"
        "'${gfb.mlastupdatedt}' ,"
        "'${gfb.mlastupdateby}' ,"
        "'${gfb.mgeolocation}' ,"
        "'${gfb.mgeolatd}' ,"
        "'${gfb.mgeologd}' ,"
        "'${gfb.mlastsynsdate}'  , "
        "'${gfb.mgroupprdcode}'  ,"
        "'${gfb.mgroupgender}'  ,"
        "${gfb.mrefcenterid} ,"
        "${gfb.trefcenterid} ,"
        "${gfb.missynctocoresys}, "
        "'${gfb.merrormessage}' "
        "); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${groupFoundationMaster}");
    });
  }

  Future updateCenterFoundation(CenterDetailsBean centrObj) async {
    print("trying to insert or replace ${centerDetailsMaster}");
    String insertQuery = 'INSERT OR REPLACE INTO ${centerDetailsMaster} ('
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mCenterId} ,"
        "${TablesColumnFile.mEffectiveDt},"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mcentername} ,"
        "${TablesColumnFile.mcrs} ,"
        "${TablesColumnFile.marea} ,"
        "${TablesColumnFile.mareatype} ,"
        "${TablesColumnFile.mformatndt},"
        "${TablesColumnFile.mmeetingfreq} ,"
        "${TablesColumnFile.mmeetinglocn} ,"
        "${TablesColumnFile.mmeetingday} ,"
        "${TablesColumnFile.mcentermthhmm} ,"
        "${TablesColumnFile.mcentermtampm} ,"
        "${TablesColumnFile.mfirstmeetngdt},"
        "${TablesColumnFile.mnextmeetngdt},"
        "${TablesColumnFile.mlastmeetngdt},"
        "${TablesColumnFile.mrepayfrom} ,"
        "${TablesColumnFile.mrepayto} ,"
        "${TablesColumnFile.mcurrnoOfmembers} ,"
        "${TablesColumnFile.mcenterstatus} ,"
        "${TablesColumnFile.mdropoutdate},"
        "${TablesColumnFile.mlastmonitoringdate},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.missynctocoresys} ,"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.merrormessage} "
        ")"
        "VALUES"
        "("
        "${centrObj.trefno},"
        "${centrObj.mrefno},"
        "${centrObj.mCenterId},"
        "'${centrObj.mEffectiveDt}',"
        "${centrObj.mlbrcode},"
        "'${centrObj.mcentername}',"
        "'${centrObj.mcrs}',"
        "${centrObj.marea},"
        "${centrObj.mareatype},"
        "'${centrObj.mformatndt}',"
        "'${centrObj.mmeetingfreq}',"
        "'${centrObj.mmeetinglocn}',"
        "${centrObj.mmeetingday},"
        "'${centrObj.mcentermthhmm}',"
        "${centrObj.mcentermtampm},"
        "'${centrObj.mfirstmeetngdt}',"
        "'${centrObj.mnextmeetngdt}',"
        "'${centrObj.mlastmeetngdt}',"
        "${centrObj.mrepayfrom},"
        "${centrObj.mrepayto},"
        "${centrObj.mcurrnoOfmembers},"
        "${centrObj.mcenterstatus},"
        "'${centrObj.mdropoutdate}',"
        "'${centrObj.mlastmonitoringdate}',"
        "'${centrObj.mcreateddt}',"
        "'${centrObj.mcreatedby}',"
        "'${centrObj.mlastupdatedt}',"
        "'${centrObj.mlastupdateby}',"
        "'${centrObj.mgeolocation}',"
        "'${centrObj.mgeolatd}',"
        "'${centrObj.mgeologd}',"
        "${centrObj.missynctocoresys},"
        "'${centrObj.mlastsynsdate}',"
        "'${centrObj.merrormessage}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${centerDetailsMaster}");
    });
  }

  Future updatecountryMaster(CountryDropDownBean bean) async {
    print("trying to insert or replace ${countryMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${countryMaster}( "
        "${TablesColumnFile.cntryCd},"
        "${TablesColumnFile.countryName},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "'${bean.cntryCd}',"
        "'${bean.countryName}',"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${countryMaster}");
    });
  }

  Future updateStateMaster(StateDropDownList bean) async {
    print("trying to insert or replace ${stateMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${stateMaster}( "
        "${TablesColumnFile.stateCd},"
        "${TablesColumnFile.stateDesc},"
        "${TablesColumnFile.cntryCd},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "'${bean.stateCd}',"
        "'${bean.stateDesc}',"
        "'${bean.cntryCd}',"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${stateMaster}");
    });
  }

  Future updateDistrictMaster(DistrictDropDownList bean) async {
    print("trying to insert or replace ${districtMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${districtMaster}( "
        "${TablesColumnFile.distCd},"
        "${TablesColumnFile.distDesc},"
        "${TablesColumnFile.stateCd},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "${bean.distCd},"
        "'${bean.distDesc}',"
        "'${bean.stateCd}',"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${districtMaster}");
    });
  }

  Future updateSubDistrictMaster(SubDistrictDropDownList bean) async {
    print("trying to insert or replace ${subDistrictMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${subDistrictMaster}( "
        "${TablesColumnFile.placeCd},"
        "${TablesColumnFile.placeCdDesc},"
        "${TablesColumnFile.distCd},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "'${bean.placeCd}',"
        "'${bean.placeCdDesc}',"
        "${bean.distCd},"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${subDistrictMaster}");
    });
  }

  Future updateAreaMaster(AreaDropDownList bean, areaCode, placeCode) async {
    //print("trying to insert or replace ${areaMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${areaMaster}( "
        "${TablesColumnFile.areaCd},"
        "${TablesColumnFile.placeCd},"
        "${TablesColumnFile.areaDesc},"
        "${TablesColumnFile.createdAt}"
        ")"
        "VALUES("
        "${areaCode},"
        "'${placeCode}',"
        "'${bean.areaDesc}',"
        "'${bean.createdAt}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      //print(id.toString() + " id after insert in ${areaMaster}");
    });
  }

  Future updateCreditBereauMaster(CreditBereauBean creditBereauBean) async {
    String insertQuery = "INSERT OR REPLACE INTO "
        "${creditBereauMaster}( "
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mqueueno} ,"
        "${TablesColumnFile.mprospectdt} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mprospectname} ,"
        "${TablesColumnFile.mmobno} ,"
        "${TablesColumnFile.mdob} ,"
        "${TablesColumnFile.motpverified} ,"
        "${TablesColumnFile.mcbcheckstatus} ,"
        "${TablesColumnFile.mprospectstatus} ,"
        "${TablesColumnFile.madd1} ,"
        "${TablesColumnFile.madd2} ,"
        "${TablesColumnFile.madd3} ,"
        "${TablesColumnFile.mhomeloc} ,"
        "${TablesColumnFile.mareacd} ,"
        "${TablesColumnFile.mvillage} ,"
        "${TablesColumnFile.mdistcd} ,"
        "${TablesColumnFile.mstatecd},"
        "${TablesColumnFile.mcountrycd},"
        "${TablesColumnFile.mpincode} ,"
        "${TablesColumnFile.mcountryoforigin} ,"
        "${TablesColumnFile.mnationality} ,"
        "${TablesColumnFile.mpanno} ,"
        "${TablesColumnFile.mpannodesc} ,"
        "${TablesColumnFile.misuploaded},"
        "${TablesColumnFile.mspousename} ,"
        "${TablesColumnFile.mspouserelation} ,"
        "${TablesColumnFile.mnomineename} ,"
        "${TablesColumnFile.mnomineerelation} ,"
        "${TablesColumnFile.mcreditenqpurposetype} ,"
        "${TablesColumnFile.mcreditequstage} ,"
        "${TablesColumnFile.mcreditreporttransdatetype} ,"
        "${TablesColumnFile.mcreditreporttransid} ,"
        "${TablesColumnFile.mcreditrequesttype} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.missynctocoresys} ,"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.mstreet} ,"
        "${TablesColumnFile.mhouse} ,"
        "${TablesColumnFile.mcity} ,"
        "${TablesColumnFile.mstate} ,"
        "${TablesColumnFile.mid1} ,"
        "${TablesColumnFile.mid1desc} ,"
        "${TablesColumnFile.motp},"
        "${TablesColumnFile.mroutedto},"
        "${TablesColumnFile.miscustcreated},"
        "${TablesColumnFile.mtier},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mhighmarkchkdt}"
        " )VALUES("
        "${creditBereauBean.trefno} ,"
        "${creditBereauBean.mrefno} ,"
        "${creditBereauBean.mlbrcode} ,"
        "${creditBereauBean.mqueueno} ,"
        "'${creditBereauBean.mprospectdt}' ,"
        "'${creditBereauBean.mnametitle}' ,"
        "'${creditBereauBean.mprospectname}' ,"
        "${creditBereauBean.mmobno},"
        "'${creditBereauBean.mdob}' ,"
        "${creditBereauBean.motpverified} ,"
        "'${creditBereauBean.mcbcheckstatus}' ,"
        "${creditBereauBean.mprospectstatus} ,"
        "'${creditBereauBean.madd1}' ,"
        "'${creditBereauBean.madd2}' ,"
        "'${creditBereauBean.madd3}' ,"
        "'${creditBereauBean.mhomeloc}' ,"
        "${creditBereauBean.mareacd} ,"
        "'${creditBereauBean.mvillage}' ,"
        "${creditBereauBean.mdistcd} ,"
        "'${creditBereauBean.mstatecd}' ,"
        "'${creditBereauBean.mcountrycd}' ,"
        "${creditBereauBean.mpincode} ,"
        "'${creditBereauBean.mcountryoforigin}' ,"
        "'${creditBereauBean.mnationality}' ,"
        "'${creditBereauBean.mpanno}' ,"
        "'${creditBereauBean.mpannodesc}' ,"
        "${creditBereauBean.misuploaded},"
        "'${creditBereauBean.mspousename}' ,"
        "'${creditBereauBean.mspouserelation}' ,"
        "'${creditBereauBean.mnomineename}' ,"
        "'${creditBereauBean.mnomineerelation}' ,"
        "'${creditBereauBean.mcreditenqpurposetype}' ,"
        "'${creditBereauBean.mcreditequstage}' ,"
        "'${creditBereauBean.mcreditreporttransdatetype}' ,"
        "'${creditBereauBean.mcreditreporttransid}' ,"
        "'${creditBereauBean.mcreditrequesttype}' ,"
        "'${creditBereauBean.mcreateddt}' ,"
        "'${creditBereauBean.mcreatedby}' ,"
        "'${creditBereauBean.mlastupdatedt}' ,"
        "'${creditBereauBean.mlastupdateby}' ,"
        "'${creditBereauBean.mgeolocation}',"
        "'${creditBereauBean.mgeolatd}' ,"
        "'${creditBereauBean.mgeologd}' ,"
        "${creditBereauBean.missynctocoresys} ,"
        "'${creditBereauBean.mlastsynsdate}' ,"
        "'${creditBereauBean.mstreet}' ,"
        "'${creditBereauBean.mhouse}' ,"
        "'${creditBereauBean.mcity}',"
        "'${creditBereauBean.mstate}' ,"
        "'${creditBereauBean.mid1}' ,"
        "'${creditBereauBean.mid1desc}' ,"
        "${creditBereauBean.motp},"
        "'${creditBereauBean.mroutedto}',"
        "${creditBereauBean.miscustcreated},"
        "${creditBereauBean.mtier},"
        "${creditBereauBean.mcustno},"
        "'${creditBereauBean.mhighmarkchkdt}'"
        ")";

    for (var items in insertQuery.split(",")) {
      print(items);
    }
    print("inser query is ${insertQuery}");

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + "idafterinsert");
    });
  }

  Future updateCreditBereauResult(CbResultBean creditBereauResultBean) async {
    print("trying to insert or replace ${creditBereauResultMaster}");

    String insertQuery = "INSERT OR REPLACE INTO ${creditBereauResultMaster} ("
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.trefresultsrno} ,"
        "${TablesColumnFile.mrefresultsrno} ,"
        "${TablesColumnFile.mcbcheckstatus} ,"
        "${TablesColumnFile.mdateofissue} ,"
        "${TablesColumnFile.mdateofrequest} ,"
        "${TablesColumnFile.miscustomercreated} ,"
        "${TablesColumnFile.mpreparedfor} ,"
        "${TablesColumnFile.mreportid} ,"
        "${TablesColumnFile.mothrmficnt},"
        "${TablesColumnFile.mloancycle},"
        "${TablesColumnFile.mothrmficurbal} ,"
        "${TablesColumnFile.mothrmfiovrdueamt} ,"
        "${TablesColumnFile.mothrmfidisbamt},"
        "${TablesColumnFile.mtotovrdueaccno} ,"
        "${TablesColumnFile.mmfitotdisbamt} ,"
        "${TablesColumnFile.mmfitotcurrentbal},"
        "${TablesColumnFile.mmfitotovrdueamt} ,"
        "${TablesColumnFile.mtotovrdueamt} ,"
        "${TablesColumnFile.mtotcurrentbal},"
        "${TablesColumnFile.mtotdisbamt}  ,"
        "${TablesColumnFile.mexpsramt}  ,"
        "${TablesColumnFile.mcbresultblob} ,"
        "${TablesColumnFile.mcreateddt} "
        ")VALUES("
        "${creditBereauResultBean.trefno} ,"
        "${creditBereauResultBean.mrefno} ,"
        "${creditBereauResultBean.trefresultsrno} ,"
        "${creditBereauResultBean.mrefresultsrno} ,"
        "'${creditBereauResultBean.mcbcheckstatus}' ,"
        "'${creditBereauResultBean.mdateofissue}' ,"
        "'${creditBereauResultBean.mdateofrequest}' ,"
        "'${creditBereauResultBean.miscustomercreated}' ,"
        "'${creditBereauResultBean.mpreparedfor}' ,"
        "'${creditBereauResultBean.mreportid}' ,"
        "${creditBereauResultBean.mothrmficnt},"
        "${creditBereauResultBean.mloancycle},"
        "${creditBereauResultBean.mothrmficurbal} ,"
        "${creditBereauResultBean.mothrmfiovrdueamt},"
        "${creditBereauResultBean.mothrmfidisbamt},"
        "${creditBereauResultBean.mtotovrdueaccno},"
        "${creditBereauResultBean.mmfitotdisbamt},"
        "${creditBereauResultBean.mmfitotcurrentbal},"
        "${creditBereauResultBean.mmfitotovrdueamt},"
        "${creditBereauResultBean.mtotovrdueamt},"
        "${creditBereauResultBean.mtotcurrentbal},"
        "${creditBereauResultBean.mtotdisbamt},"
        "${creditBereauResultBean.mexpsramt},"
        "'${creditBereauResultBean.mcbresultblob}',"
        "'${creditBereauResultBean.mcreateddt}'"
        " );";
    for (var items in insertQuery.split(",")) {
      print(items);
    }

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(
          id.toString() + "xxx ida fter insert in ${creditBereauResultMaster}");
    });
  }

  Future updateCreditBereauLoanDetailsWithLoanSeq(
      CbResultBean creditBereauResultBean, int trefsrno) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${creditBereauLoanDetailsMaster}( "
        "${TablesColumnFile.trefno}  ,"
        "${TablesColumnFile.mrefno}  ,"
        "${TablesColumnFile.mrefsrno}  ,"
        "${TablesColumnFile.trefsrno}  ,"
        "${TablesColumnFile.maccounttype}  ,"
        "${TablesColumnFile.mcurrentbalance}  ,"
        "${TablesColumnFile.mcustbankacnum}  ,"
        "${TablesColumnFile.mdatereported}  ,"
        "${TablesColumnFile.mdisbursedamount}  ,"
        "${TablesColumnFile.mnameofmfi}  ,"
        "${TablesColumnFile.mnocimagestring}  ,"
        "${TablesColumnFile.moverdueamount}  ,"
        "${TablesColumnFile.mwriteoffamount},"
        "${TablesColumnFile.mmfiid}"
        ")VALUES("
        "${creditBereauResultBean.trefno} ,"
        "${creditBereauResultBean.mrefno} ,"
        "${creditBereauResultBean.mrefsrno}, "
        "${trefsrno} ,"
        "'${creditBereauResultBean.maccounttype}' ,"
        "${creditBereauResultBean.mcurrentbalance},"
        "'${creditBereauResultBean.mcustbankacnum}' ,"
        "'${creditBereauResultBean.mdatereported}' ,"
        "${creditBereauResultBean.mdisbursedamount} ,"
        "'${creditBereauResultBean.mnameofmfi}' ,"
        "'${creditBereauResultBean.mnocimagestring}' ,"
        "${creditBereauResultBean.moverdueamount} ,"
        "${creditBereauResultBean.mwriteoffamount},"
        "'${creditBereauResultBean.mmfiid}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${creditBereauLoanDetailsMaster}");
    });
  }

  Future updateCreditBereauMasterFromtTrefNo(
      int trefNo,
      mrefNo,
      String cbCheckStatus,
      int mprospectStatus,
      DateTime lastUpdateDate,
      DateTime highmrkchkdate) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile.mrefno} = ${mrefNo} ";

    print("xxxxxxxxxxxxxxquery is here : " +
        "Update $creditBereauMaster SET ${TablesColumnFile.misuploaded} = 1 "
            ",${TablesColumnFile.mlastupdatedt} = '${lastUpdateDate}'"
            ",${TablesColumnFile.mcbcheckstatus} = '${cbCheckStatus}'"
            ", ${TablesColumnFile.mprospectstatus} = ${mprospectStatus} "
            " ${TablesColumnFile.mhighmarkchkdt} ='${highmrkchkdate}' "
            "WHERE $str ");
    var result = await db.rawQuery(
        "Update $creditBereauMaster SET ${TablesColumnFile.misuploaded} = 1 "
            ",${TablesColumnFile.mlastupdatedt} = '${lastUpdateDate}'"
            ",${TablesColumnFile.mcbcheckstatus} = '${cbCheckStatus}'"
            ", ${TablesColumnFile.mprospectstatus} = ${mprospectStatus} "
            " ,${TablesColumnFile.mhighmarkchkdt} = '${highmrkchkdate}' "
            "WHERE $str ");
  }

  Future updateCreditBereauMasterProspectStatusFromTrefNo(
      int trefNo,
      int mrefNo,
      String routedTo,
      int prospectStatus,
      DateTime mlastUpdatedt,
      lastUpdatedBy) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile.mrefno} = ${mrefNo}";
    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mprospectstatus} "
        "= ${prospectStatus} , ${TablesColumnFile.mroutedto} "
        "= '${routedTo}'"
        ",  ${TablesColumnFile.mlastupdateby} = '${lastUpdatedBy}'"
        ",${TablesColumnFile.mlastupdatedt} = '$mlastUpdatedt' WHERE $str";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("CreditBereauMaster Updated");
  }

  Future updateGaurantorMaster(
      GuarantorDetailsBean guarantorDetailsBean) async {
    print("trying to insert or replace ${gaurantorMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${gaurantorMaster}( "
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mloanmrefno} ,"
        "${TablesColumnFile.mloantrefno} ,"
        "${TablesColumnFile.mleadsid} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.msrno} ,"
        "${TablesColumnFile.mapplicanttype} ,"
        "${TablesColumnFile.mexistingcustyn} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mnameofguar} ,"
        "${TablesColumnFile.mgender} ,"
        "${TablesColumnFile.mrelationwithcust} ,"
        "${TablesColumnFile.mrelationsince} ,"
        "${TablesColumnFile.mage} ,"
        "${TablesColumnFile.mphone} ,"
        "${TablesColumnFile.mmobile} ,"
        "${TablesColumnFile.maddress} ,"
        "${TablesColumnFile.mmonthlyincome} ,"
        "${TablesColumnFile.mdob} ,"
        "${TablesColumnFile.moccupationtype} ,"
        "${TablesColumnFile.mmainoccupation} ,"
        "${TablesColumnFile.mworkexpinyrs} ,"
        "${TablesColumnFile.mincomeothsources} ,"
        "${TablesColumnFile.mtotalincome} ,"
        "${TablesColumnFile.mhousetype} ,"
        "${TablesColumnFile.mworkingaddress} ,"
        "${TablesColumnFile.mworkphoneno} ,"
        "${TablesColumnFile.mmothermaidenname} ,"
        "${TablesColumnFile.mpromissorynote} ,"
        "${TablesColumnFile.mnationalidtype} ,"
        "${TablesColumnFile.mnationalid} ,"
        "${TablesColumnFile.mnationaliddesc} ,"
        "${TablesColumnFile.maddress2} ,"
        "${TablesColumnFile.maddress3} ,"
        "${TablesColumnFile.maddress4} ,"
        "${TablesColumnFile.mmaritalstatus} ,"
        "${TablesColumnFile.mreligioncd} ,"
        "${TablesColumnFile.meducationalqual} ,"
        "${TablesColumnFile.memailaddr} ,"
        "${TablesColumnFile.memployername} ,"
        "${TablesColumnFile.mbusinessname} ,"
        "${TablesColumnFile.mspousename} ,"
        "${TablesColumnFile.mstatecd} ,"
        "${TablesColumnFile.mtownship} ,"
        "${TablesColumnFile.mvillage} ,"
        "${TablesColumnFile.mwardno} ,"
        "${TablesColumnFile.mstatecddesc} ,"
        "${TablesColumnFile.mtownshipdesc} ,"
        "${TablesColumnFile.mvillagedesc} ,"
        "${TablesColumnFile.mwardnodesc} ,"
        "${TablesColumnFile.mbuspropownership} ,"
        "${TablesColumnFile.mbusownership} ,"
        "${TablesColumnFile.mbustoaassetval} ,"
        "${TablesColumnFile.mbusleninyears} ,"
        "${TablesColumnFile.mbusmonexpense} ,"
        "${TablesColumnFile.mbusmonhlynetprof} ,"
        "${TablesColumnFile.msamevillageorward} ,"
        "${TablesColumnFile.mfacecapture} ,"
        "${TablesColumnFile.mnrcphoto} ,"
        "${TablesColumnFile.mnrcsecphoto} ,"
        "${TablesColumnFile.mhouseholdphoto} ,"
        "${TablesColumnFile.mhouseholdsecphoto} ,"
        "${TablesColumnFile.maddressphoto} ,"
        "${TablesColumnFile.msignature} ,"
        "${TablesColumnFile.merrormessage} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.missynctocoresys} "
    //"${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${guarantorDetailsBean.trefno},"
        "${guarantorDetailsBean.mrefno},"
        "${guarantorDetailsBean.mloanmrefno},"
        "${guarantorDetailsBean.mloantrefno},"
        "'${guarantorDetailsBean.mleadsid}',"
        "'${guarantorDetailsBean.mprdacctid}',"
        "${guarantorDetailsBean.msrno},"
        "${guarantorDetailsBean.mapplicanttype},"
        "'${guarantorDetailsBean.mexistingcustyn}',"
        "${guarantorDetailsBean.mcustno},"
        "'${guarantorDetailsBean.mnameofguar}',"
        "'${guarantorDetailsBean.mgender}',"
        "'${guarantorDetailsBean.mrelationwithcust}',"
        "${guarantorDetailsBean.mrelationsince},"
        "${guarantorDetailsBean.mage},"
        "'${guarantorDetailsBean.mphone}',"
        "'${guarantorDetailsBean.mmobile}',"
        "'${guarantorDetailsBean.maddress}',"
        "${guarantorDetailsBean.mmonthlyincome},"
        "'${guarantorDetailsBean.mdob}',"
        "${guarantorDetailsBean.moccupationtype},"
        "${guarantorDetailsBean.mmainoccupation},"
        "${guarantorDetailsBean.mworkexpinyrs},"
        "${guarantorDetailsBean.mincomeothsources},"
        "${guarantorDetailsBean.mtotalincome},"
        "${guarantorDetailsBean.mhousetype},"
        "'${guarantorDetailsBean.mworkingaddress}',"
        "'${guarantorDetailsBean.mworkphoneno}',"
        "'${guarantorDetailsBean.mmothermaidenname}',"
        "'${guarantorDetailsBean.mpromissorynote}',"
        "${guarantorDetailsBean.mnationalidtype},"
        "${guarantorDetailsBean.mnationalid},"
        "'${guarantorDetailsBean.mnationaliddesc}',"
        "'${guarantorDetailsBean.maddress2}',"
        "'${guarantorDetailsBean.maddress3}',"
        "'${guarantorDetailsBean.maddress4}',"
        "${guarantorDetailsBean.mmaritalstatus},"
        "${guarantorDetailsBean.mreligioncd},"
        "'${guarantorDetailsBean.meducationalqual}',"
        "'${guarantorDetailsBean.memailaddr}',"
        "'${guarantorDetailsBean.memployername}',"
        "'${guarantorDetailsBean.mbusinessname}',"
        "'${guarantorDetailsBean.mspousename}',"
        "'${guarantorDetailsBean.mstatecd}',"
        "'${guarantorDetailsBean.mtownship}',"
        "${guarantorDetailsBean.mvillage},"
        "'${guarantorDetailsBean.mwardno}',"
        "'${guarantorDetailsBean.mstatecddesc}',"
        "'${guarantorDetailsBean.mtownshipdesc}',"
        "'${guarantorDetailsBean.mvillagedesc}',"
        "'${guarantorDetailsBean.mwardnodesc}',"
        "${guarantorDetailsBean.mbuspropownership},"
        "${guarantorDetailsBean.mbusownership},"
        "${guarantorDetailsBean.mbustoaassetval},"
        "'${guarantorDetailsBean.mbusleninyears}',"
        "${guarantorDetailsBean.mbusmonexpense},"
        "${guarantorDetailsBean.mbusmonhlynetprof},"
        "'${guarantorDetailsBean.msamevillageorward}',"
        "'${guarantorDetailsBean.mfacecapture}',"
        "'${guarantorDetailsBean.mnrcphoto}',"
        "'${guarantorDetailsBean.mnrcsecphoto}',"
        "'${guarantorDetailsBean.mhouseholdphoto}',"
        "'${guarantorDetailsBean.mhouseholdsecphoto}',"
        "'${guarantorDetailsBean.maddressphoto}',"
        "'${guarantorDetailsBean.msignature}',"
        "'${guarantorDetailsBean.merrormessage}',"
        "'${guarantorDetailsBean.mcreateddt}',"
        "'${guarantorDetailsBean.mcreatedby}',"
        "'${guarantorDetailsBean.mlastupdatedt}',"
        "'${guarantorDetailsBean.mlastupdateby}',"
        "'${guarantorDetailsBean.mgeolocation}',"
        "'${guarantorDetailsBean.mgeolatd}',"
        "'${guarantorDetailsBean.mgeologd}',"
        "'${guarantorDetailsBean.mlastsynsdate}',"
    //"${0}"
        "${guarantorDetailsBean.missynctocoresys} "
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${gaurantorMaster}");
    });
  }

  Future updateSavingsCollectionListMaster(
      SavingsListBean savingsCollectionListBean) async {
    print("trying to insert or replace ${savingsCollectionMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${savingsCollectionMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.msvngacctrefno},"
        "${TablesColumnFile.msvngaccmrefno},"
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mcollectiondate},"
        "${TablesColumnFile.mcollectedamount},"
        "${TablesColumnFile.mmoduletype},"
        "${TablesColumnFile.mremark},"
        "${TablesColumnFile.mcashflow} ,"
        "${TablesColumnFile.mentrydate},"
        "${TablesColumnFile.mbatchcd} ,"
        "${TablesColumnFile.msetno} ,"
        "${TablesColumnFile.mscrollno} ,"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupcd} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.moperationdate} ,"
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${savingsCollectionListBean.trefno},"
        "${savingsCollectionListBean.mrefno},"
        "${savingsCollectionListBean.msvngacctrefno},"
        "${savingsCollectionListBean.msvngaccmrefno},"
        "${savingsCollectionListBean.mlbrcode},"
        "'${savingsCollectionListBean.mprdacctid}',"
        "'${savingsCollectionListBean.mcollectiondate}',"
        "${savingsCollectionListBean.mcollectedamount},"
        "${savingsCollectionListBean.mmoduletype},"
        "'${savingsCollectionListBean.mremark}',"
        "'${savingsCollectionListBean.mcashflow} ',"
        "'${savingsCollectionListBean.mentrydate}',"
        "'${savingsCollectionListBean.mbatchcd} ',"
        "${savingsCollectionListBean.msetno} ,"
        "${savingsCollectionListBean.mscrollno} ,"
        "'${savingsCollectionListBean.mcreateddt}',"
        "'${savingsCollectionListBean.mcreatedby}',"
        "'${savingsCollectionListBean.mlastupdatedt}',"
        "'${savingsCollectionListBean.mlastupdateby}',"
        "'${savingsCollectionListBean.mgeolocation}',"
        "'${savingsCollectionListBean.mgeolatd}',"
        "'${savingsCollectionListBean.mgeologd}',"
        "'${savingsCollectionListBean.mlastsynsdate}',"
        "${savingsCollectionListBean.mcenterid},"
        "${savingsCollectionListBean.mgroupcd},"
        "${savingsCollectionListBean.mcustno},"
        "'${savingsCollectionListBean.moperationdate}',"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${savingsCollectionMaster}");
    });
  }

  Future updateMiniStatementMaster(MiniStatementBean miniStatementBean) async {
    print("trying to insert or replace ${miniStatementMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${miniStatementMaster}( "
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mlongname},"
        "${TablesColumnFile.mbramchname},"
        "${TablesColumnFile.mparticulars},"
        "${TablesColumnFile.mlcytrnamt},"
        "${TablesColumnFile.macttotballcy},"
        "${TablesColumnFile.mtotallienfcy},"
        "${TablesColumnFile.mentrydate},"
        "${TablesColumnFile.mdrcr},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${miniStatementBean.mlbrcode},"
        "'${miniStatementBean.mprdacctid}',"
        "'${miniStatementBean.mlongname}',"
        "'${miniStatementBean.mbramchname}',"
        "'${miniStatementBean.mparticulars}',"
        "${miniStatementBean.mlcytrnamt},"
        "${miniStatementBean.macttotballcy},"
        "${miniStatementBean.mtotallienfcy},"
        "'${miniStatementBean.mentrydate}',"
        "'${miniStatementBean.mdrcr}',"
        "'${miniStatementBean.mgeolocation}',"
        "'${miniStatementBean.mgeolatd}',"
        "'${miniStatementBean.mgeologd}',"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${miniStatementMaster}");
    });
  }

  Future updateSavingsListMaster(SavingsListBean savingsListBean) async {
    print("trying to insert or replace ${savingsMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${savingsMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mcusttrefno},"
        "${TablesColumnFile.mcustmrefno},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mlongname},"
        "${TablesColumnFile.mmobno},"
        "${TablesColumnFile.mprdcd},"
        "${TablesColumnFile.mcurcd},"
        "${TablesColumnFile.mdateopen},"
        "${TablesColumnFile.mdateclosed},"
        "${TablesColumnFile.mfreezetype},"
        "${TablesColumnFile.macctstat},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mactTotbalfcy},"
        "${TablesColumnFile.mtotallienfcy},"
        "${TablesColumnFile.mmoduletype},"
        "${TablesColumnFile.mcenterid},"
        "${TablesColumnFile.mgroupcd},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mcrs},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.isDataSynced}, "
        "${TablesColumnFile.missynctocoresys} "
        ")"
        "VALUES("
        "${savingsListBean.trefno},"
        "${savingsListBean.mrefno},"
        "${savingsListBean.mlbrcode},"
        "${savingsListBean.mcusttrefno},"
        "${savingsListBean.mcustmrefno},"
        "'${savingsListBean.mprdacctid}',"
        "'${savingsListBean.mlongname}',"
        "'${savingsListBean.mmobno}',"
        "'${savingsListBean.mprdcd}',"
        "'${savingsListBean.mcurcd}',"
        "'${savingsListBean.mdateopen}',"
        "'${savingsListBean.mdateclosed}',"
        "${savingsListBean.mfreezetype},"
        "${savingsListBean.macctstat},"
        "${savingsListBean.mcustno},"
        "${savingsListBean.macttotbalfcy},"
        "${savingsListBean.mtotallienfcy},"
        "${savingsListBean.mmoduletype},"
        "${savingsListBean.mcenterid},"
        "${savingsListBean.mgroupcd},"
        "'${savingsListBean.mcreateddt}',"
        "'${savingsListBean.mcreatedby}',"
        "'${savingsListBean.mlastupdatedt}',"
        "'${savingsListBean.mlastupdateby}',"
        "'${savingsListBean.mgeolocation}',"
        "'${savingsListBean.mgeolatd}',"
        "'${savingsListBean.mgeologd}',"
        "'${savingsListBean.mlastsynsdate}',"
        "'${savingsListBean.mcrs}',"
        "'${savingsListBean.merrormessage}',"
        "${0},"
        "${savingsListBean.missynctocoresys}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${customerLoanDetailsMaster}");
    });
  }
  Future updateCustomerProductwiseCycleMaster(CustomerProductwiseCycleBean customerProductwiseCycleBean) async {
    print("trying to insert or replace ${CustomerProductwiseCycleMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${CustomerProductwiseCycleMaster}( "
        "${TablesColumnFile.mprdcd},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mcycle},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.missynctocoresys} "
        ")"
        "VALUES("
        "'${customerProductwiseCycleBean.customerProductwiseCycleCompositeEntity.mprdcd}',"
        "${customerProductwiseCycleBean.customerProductwiseCycleCompositeEntity.mcustno},"
        "${customerProductwiseCycleBean.mcycle},"
        "'${customerProductwiseCycleBean.mcreateddt}',"
        "'${customerProductwiseCycleBean.mcreatedby}',"
        "'${customerProductwiseCycleBean.mlastupdatedt}',"
        "'${customerProductwiseCycleBean.mlastupdateby}',"
        "'${customerProductwiseCycleBean.mgeolocation}',"
        "'${customerProductwiseCycleBean.mgeolatd}',"
        "'${customerProductwiseCycleBean.mgeologd}',"
        "'${customerProductwiseCycleBean.mlastsynsdate}',"
        "${customerProductwiseCycleBean.missynctocoresys}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${CustomerProductwiseCycleMaster}");
    });
  }
  Future updateDisbursmentMaster(DisbursmentBean disbursmentBean) async {
    print("trying to insert or replace ${disbursmentMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${disbursmentMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mlongname},"
        "${TablesColumnFile.mgroupcd},"
        "${TablesColumnFile.mefffromdate},"
        "${TablesColumnFile.mdisburseddate},"
        "${TablesColumnFile.minstlstartdate},"
        "${TablesColumnFile.minstlamt},"
        "${TablesColumnFile.minstlintcomp},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mappliedasindvyn},"
        "${TablesColumnFile.mnewtopupflag},"
        "${TablesColumnFile.msancdate},"
        "${TablesColumnFile.mdisbursedamt},"
        "${TablesColumnFile.msdamt},"
        "${TablesColumnFile.mrebateamt},"
        "${TablesColumnFile.mchargesamt},"
        "${TablesColumnFile.mdisbursedamtcoltd},"
        "${TablesColumnFile.msdamtcoltd},"
        "${TablesColumnFile.mrebateamtcoltd},"
        "${TablesColumnFile.mchargesamtcoltd},"
        "${TablesColumnFile.mdisbursedamtflag},"
        "${TablesColumnFile.msdamtflag},"
        "${TablesColumnFile.mrebateamtflag},"
        "${TablesColumnFile.mchargesamtflag},"
        "${TablesColumnFile.mreason},"
        "${TablesColumnFile.msetno},"
        "${TablesColumnFile.mscrollno},"
        "${TablesColumnFile.mentrydate},"
        "${TablesColumnFile.mbatchcd},"
        "${TablesColumnFile.mmainscrollno},"
        "${TablesColumnFile.mbatchnumber},"
        "${TablesColumnFile.mnarration},"
        "${TablesColumnFile.mcenterid},"
        "${TablesColumnFile.mcrs},"
        "${TablesColumnFile.msuspbatchcd},"
        "${TablesColumnFile.msuspsetno},"
        "${TablesColumnFile.msuspscrollno},"
        "${TablesColumnFile.msspmainscrollno},"
        "${TablesColumnFile.mpartcashamount},"
        "${TablesColumnFile.mpartcashbatchcd},"
        "${TablesColumnFile.mpartcashsetno},"
        "${TablesColumnFile.mpartcashscrollno},"
        "${TablesColumnFile.mpartcashmainscrollno},"
        "${TablesColumnFile.mneftclsrBatchCd},"
        "${TablesColumnFile.mneftclsrsetno},"
        "${TablesColumnFile.mneftclsrscrollno},"
        "${TablesColumnFile.mneftclsrmainscrollno},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.mdisbamount},"
        "${TablesColumnFile.mchargesamt1},"
        "${TablesColumnFile.mchargesamt2},"
        "${TablesColumnFile.mchargesamt0},"
        "${TablesColumnFile.mchargesamt3},"
        "${TablesColumnFile.mchargesamt4},"
        "${TablesColumnFile.mchargesamt5},"
        "${TablesColumnFile.mchargesamt6},"
        "${TablesColumnFile.mchargesamt7},"
        "${TablesColumnFile.mchargesamt8},"
        "${TablesColumnFile.mchargesamt9},"
        "${TablesColumnFile.isDataSynced}, "
        "${TablesColumnFile.mchargescollectiontype}, "
        "${TablesColumnFile.msdcollectiontype}, "
        "${TablesColumnFile.mthirdpartyamount} "
        ")"
        "VALUES("
        "${disbursmentBean.trefno},"
        "${disbursmentBean.mrefno},"
        "${disbursmentBean.mlbrcode},"
        "${disbursmentBean.mcustno},"
        "'${disbursmentBean.mprdacctid}',"
        "'${disbursmentBean.mlongname}',"
        "${disbursmentBean.mgroupcd},"
        "'${disbursmentBean.mefffromdate}',"
        "'${disbursmentBean.mdisburseddate}',"
        "'${disbursmentBean.minstlstartdate}',"
        "${disbursmentBean.minstlamt},"
        "${disbursmentBean.minstlintcomp},"
        "'${disbursmentBean.mleadsid}',"
        "'${disbursmentBean.mappliedasindvyn}',"
        "${disbursmentBean.mnewtopupflag},"
        "'${disbursmentBean.msancdate}',"
        "${disbursmentBean.mdisbursedamt},"
        "${disbursmentBean.msdamt},"
        "${disbursmentBean.mrebateamt},"
        "${disbursmentBean.mchargesamt},"
        "${disbursmentBean.mdisbursedamtcoltd},"
        "${disbursmentBean.msdamtcoltd},"
        "${disbursmentBean.mrebateamtcoltd},"
        "${disbursmentBean.mchargesamtcoltd},"
        "${disbursmentBean.mdisbursedamtflag},"
        "${disbursmentBean.msdamtflag},"
        "${disbursmentBean.mrebateamtflag},"
        "${disbursmentBean.mchargesamtflag},"
        "'${disbursmentBean.mreason}',"
        "${disbursmentBean.msetno},"
        "${disbursmentBean.mscrollno},"
        "'${disbursmentBean.mentrydate}',"
        "'${disbursmentBean.mbatchcd}',"
        "${disbursmentBean.mmainscrollno},"
        "'${disbursmentBean.mbatchnumber}',"
        "'${disbursmentBean.mnarration}',"
        "${disbursmentBean.mcenterid},"
        "'${disbursmentBean.mcrs}',"
        "'${disbursmentBean.msuspbatchcd}',"
        "${disbursmentBean.msuspsetno},"
        "${disbursmentBean.msuspscrollno},"
        "${disbursmentBean.msspmainscrollno},"
        "${disbursmentBean.mpartcashamount},"
        "'${disbursmentBean.mpartcashbatchcd}',"
        "${disbursmentBean.mpartcashsetno},"
        "${disbursmentBean.mpartcashscrollno},"
        "${disbursmentBean.mpartcashmainscrollno},"
        "'${disbursmentBean.mneftclsrBatchCd}',"
        "${disbursmentBean.mneftclsrsetno},"
        "${disbursmentBean.mneftclsrscrollno},"
        "${disbursmentBean.mneftclsrmainscrollno},"
        "'${disbursmentBean.mcreateddt}',"
        "'${disbursmentBean.mcreatedby}',"
        "'${disbursmentBean.mlastupdatedt}',"
        "'${disbursmentBean.mlastupdateby}',"
        "'${disbursmentBean.mgeolocation}',"
        "'${disbursmentBean.mgeolatd}',"
        "'${disbursmentBean.mgeologd}',"
        "'${disbursmentBean.mlastsynsdate}',"
        "'${disbursmentBean.merrormessage}',"
        "${disbursmentBean.mdisbamount},"
        "${disbursmentBean.mchargesamt1},"
        "${disbursmentBean.mchargesamt2},"
        "${disbursmentBean.mchargesamt0},"
        "${disbursmentBean.mchargesamt3},"
        "${disbursmentBean.mchargesamt4},"
        "${disbursmentBean.mchargesamt5},"
        "${disbursmentBean.mchargesamt6},"
        "${disbursmentBean.mchargesamt7},"
        "${disbursmentBean.mchargesamt8},"
        "${disbursmentBean.mchargesamt9},"
        "${0},"
        "${disbursmentBean.mchargescollectiontype}, "
        "${disbursmentBean.msdcollectiontype}, "
        "${disbursmentBean.mthirdpartyamount} "
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${disbursmentMaster}");
    });
  }

  Future updateCustomerLoanDetailsMaster(
      CustomerLoanDetailsBean custLoanBean) async {
    print("trying to insert or replace ${customerLoanDetailsMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${customerLoanDetailsMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mappldloanamt},"
        "${TablesColumnFile.mapprvdloanamt},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mcusttrefno},"
        "${TablesColumnFile.mcustmrefno},"
        "${TablesColumnFile.mcustcategory},"
        "${TablesColumnFile.mloanamtdisbd},"
        "${TablesColumnFile.mloandisbdt},"
        "${TablesColumnFile.mleadstatus},"
        "${TablesColumnFile.mexpdt},"
        "${TablesColumnFile.minstamt},"
        "${TablesColumnFile.minststrtdt},"
        "${TablesColumnFile.minterestamount},"
        "${TablesColumnFile.mrepaymentmode},"
        "${TablesColumnFile.mmodeofdisb},"
        "${TablesColumnFile.mperiod},"
        "${TablesColumnFile.mprdcd},"
        "${TablesColumnFile.mpurposeofLoan},"
        "${TablesColumnFile.msubpurposeofloan},"
        "${TablesColumnFile.mintrate},"
        "${TablesColumnFile.mroutefrom},"
        "${TablesColumnFile.mrouteto},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mloancycle},"
        "${TablesColumnFile.mfrequency},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mprdname},"
        "${TablesColumnFile.mcustname},"
        "${TablesColumnFile.mApprovalDesc},"
        "${TablesColumnFile.mappliedasind},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.mcheckresaddchng},"
        "${TablesColumnFile.mspouserelname},"
        "${TablesColumnFile.mcheckspouserepay},"
        "${TablesColumnFile.mcheckbiometric},"
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.misdisbursed}  "
        ")"
        "VALUES("
        "${custLoanBean.trefno},"
        "${custLoanBean.mrefno},"
        "'${custLoanBean.mleadsid}',"
        "${custLoanBean.mappldloanamt},"
        "${custLoanBean.mapprvdloanamt},"
        "${custLoanBean.mcustno},"
        "${custLoanBean.mcusttrefno},"
        "${custLoanBean.mcustmrefno},"
        "${custLoanBean.mcustcategory},"
        "${custLoanBean.mloanamtdisbd},"
        "'${custLoanBean.mloandisbdt}',"
        "${custLoanBean.mleadstatus},"
        "'${custLoanBean.mexpdt}',"
        "${custLoanBean.minstamt},"
        "'${custLoanBean.minststrtdt}',"
        "${custLoanBean.minterestamount},"
        "${custLoanBean.mrepaymentmode},"
        "${custLoanBean.mmodeofdisb},"
        "${custLoanBean.mperiod},"
        "'${custLoanBean.mprdcd}',"
        "${custLoanBean.mpurposeofLoan},"
        "${custLoanBean.msubpurposeofloan},"
        "${custLoanBean.mintrate},"
        "'${custLoanBean.mroutefrom}',"
        "'${custLoanBean.mrouteto}',"
        "'${custLoanBean.mprdacctid}',"
        "${custLoanBean.mloancycle},"
        "'${custLoanBean.mfrequency}',"
        "'${custLoanBean.mcreateddt}',"
        "'${custLoanBean.mcreatedby}',"
        "'${custLoanBean.mlastupdatedt}',"
        "'${custLoanBean.mlastupdateby}',"
        "'${custLoanBean.mgeolocation}',"
        "'${custLoanBean.mgeolatd}',"
        "'${custLoanBean.mgeologd}',"
        "${custLoanBean.missynctocoresys},"
        "'${custLoanBean.mlastsynsdate}',"
        "'${custLoanBean.mprdname}',"
        "'${custLoanBean.mcustname}',"
        "'${custLoanBean.mapprovaldesc}',"
        "'${custLoanBean.mappliedasind}',"
        "'${custLoanBean.merrormessage}',"
        "${custLoanBean.mcheckresaddchng},"
        "'${custLoanBean.mspouserelname}',"
        "${custLoanBean.mcheckspouserepay},"
        "${custLoanBean.mcheckbiometric},"
        "${custLoanBean.mlbrcode},"
        "${custLoanBean.misdisbursed}  "
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${customerLoanDetailsMaster}");
    });
  }

  Future updateSettingsMaster(SettingsBean settingbean) async {
    print("trying to insert or replace ${settingsMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${settingsMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.musrcode},"
        "${TablesColumnFile.musrpass} ,"
        "${TablesColumnFile.mipaddress} ,"
        "${TablesColumnFile.mportno} ,"
        "${TablesColumnFile.isHttps} ,"
        "${TablesColumnFile.isPortRequired} ,"
        "${TablesColumnFile.yesno})"
        "VALUES("
        "${settingbean.trefno},"
        "'${settingbean.musrcode}',"
        "'${settingbean.musrpass}' ,"
        "'${settingbean.mipaddress}' ,"
        "'${settingbean.mportno}' ,"
        "${settingbean.isHttps},"
        "${settingbean.isPortRequired},"
        "${0});";
    print("insert query is sasasasasasas" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${settingsMaster}");
    });
  }

  Future updateCustomerLoanUtilizationMaster(
      LoanUtilizationBean loanUtil) async {
    print("trying to insert or replace ${loanUtilizationMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${loanUtilizationMaster}( "
        "${TablesColumnFile.mcustno}  ,"
        "${TablesColumnFile.mcustname} ,"
        "${TablesColumnFile.mgroupcd} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mpurposeofLoan} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.mactualutilization} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.musrname} ,"
        "${TablesColumnFile.mremarks} ,"
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "${loanUtil.mcustno},"
        "'${loanUtil.mcustname}' ,"
        "${loanUtil.mgroupcd} ,"
        "${loanUtil.mcenterid} ,"
        "'${loanUtil.mpurposeofloan}' ,"
        "'${loanUtil.mprdacctid}' ,"
        "'${loanUtil.mactualutilization}' ,"
        "'${loanUtil.mcreateddt}' ,"
        "'${loanUtil.mlastupdatedt}' ,"
        "'${loanUtil.musrname}' ,"
        "'${loanUtil.mremarks}' ,"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${loanUtilizationMaster}");
    });
  }

  // For updating Term Deposit Master
  Future updateTermDepositMaster(NewTermDepositBean newTermDepositBean) async {
    print("trying to insert or replace ${TermDepositMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${TermDepositMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mlongname} ,"
        "${TablesColumnFile.mcurcd} ,"
        "${TablesColumnFile.mcertdate} ,"
        "${TablesColumnFile.mnoinst} ,"
        "${TablesColumnFile.mnoofmonths} ,"
        "${TablesColumnFile.mnoofdays} ,"
        "${TablesColumnFile.mintrate} ,"
        "${TablesColumnFile.mmatval} ,"
        "${TablesColumnFile.mmatdate} ,"
        "${TablesColumnFile.mreceiptstatus} ,"
        "${TablesColumnFile.mlastrepaydate} ,"
        "${TablesColumnFile.mmainbalfcy} ,"
        "${TablesColumnFile.mintprvdamtfcy} ,"
        "${TablesColumnFile.mintpaidamtfcy} ,"
        "${TablesColumnFile.mtdsamtfcy} ,"
        "${TablesColumnFile.mtdsyn} ,"
        "${TablesColumnFile.mmodeofdeposit} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupcd} ,"
        "${TablesColumnFile.mprdcd} ,"
        "${TablesColumnFile.mcrs} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mmobilelastsynsdate},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.msourceoffunds},"
        "${TablesColumnFile.mnoticetype},"
        "${TablesColumnFile.mbatchcd},"
        "${TablesColumnFile.msetno},"
        "${TablesColumnFile.mscrollno}, "
        "${TablesColumnFile.moperationdate} "
        ")"
        "VALUES("
        "${newTermDepositBean.trefno},"
        "${newTermDepositBean.mrefno} ,"
        "${newTermDepositBean.mlbrcode} ,"
        "'${newTermDepositBean.mprdacctid}' ,"
        "'${newTermDepositBean.mnametitle}' ,"
        "'${newTermDepositBean.mlongname}' ,"
        "'${newTermDepositBean.mcurcd}' ,"
        "'${newTermDepositBean.mcertdate}' ,"
        "'${newTermDepositBean.mnoinst}' ,"
        "'${newTermDepositBean.mnoofmonths}' ,"
        "'${newTermDepositBean.mnoofdays}' ,"
        "'${newTermDepositBean.mintrate}' ,"
        " ${newTermDepositBean.mmatval} ,"
        "'${newTermDepositBean.mmatdate}' ,"
        "'${newTermDepositBean.mreceiptstatus}' ,"
        "'${newTermDepositBean.mlastrepaydate}' ,"
        "'${newTermDepositBean.mmainbalfcy}' ,"
        "'${newTermDepositBean.mintprvdamtfcy}' ,"
        "'${newTermDepositBean.mintpaidamtfcy}' ,"
        "'${newTermDepositBean.mtdsamtfcy}' ,"
        "'${newTermDepositBean.mtdsyn}' ,"
        "'${newTermDepositBean.mmodeofdeposit}' ,"
        "'${newTermDepositBean.mcustno}' ,"
        "'${newTermDepositBean.mcenterid}' ,"
        "'${newTermDepositBean.mgroupcd}' ,"
        "'${newTermDepositBean.mprdcd}' ,"
        "'${newTermDepositBean.mcrs}' ,"
        "'${newTermDepositBean.mcreateddt}' ,"
        "'${newTermDepositBean.mcreatedby}' ,"
        "'${newTermDepositBean.mlastupdatedt}' ,"
        "'${newTermDepositBean.mlastupdateby}' ,"
        "'${newTermDepositBean.mgeolocation}' ,"
        "'${newTermDepositBean.mgeolatd}' ,"
        "'${newTermDepositBean.mgeologd}' ,"
        "'${newTermDepositBean.mlastsynsdate}' ,"
        "'${newTermDepositBean.mmobilelastsynsdate}' ,"
        "'${newTermDepositBean.merrormessage}', "
        "${newTermDepositBean.msourceoffunds}, "
        "${newTermDepositBean.mnoticetype} ,"
        "'${newTermDepositBean.mbatchcd}',"
        "${newTermDepositBean.msetno},"
        "${newTermDepositBean.mscrollno},"
        "'${newTermDepositBean.moperationdate}' "
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${TermDepositMaster}");
    });
  }

  //bSpeedoMeter
  Future updateSpeedoMeterDetailsMaster(SpeedoMeterBean bean) async {
    print(bean);
    print("trying to insert or replace ${speedoMeterMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${speedoMeterMaster}( "
        "${TablesColumnFile.usrName},"
        "${TablesColumnFile.effDate},"
        "${TablesColumnFile.geoLatitude},"
        "${TablesColumnFile.geoLongitude},"
        "${TablesColumnFile.geoLocation},"
        "${TablesColumnFile.startingFromImg},"
        "${TablesColumnFile.endingFromImg},"
        "${TablesColumnFile.startingPoint},"
        "${TablesColumnFile.endingPoint},"
        "${TablesColumnFile.totMeterReading},"
        "${TablesColumnFile.createdAt},"
        "${TablesColumnFile.updatedAt},"
        "${TablesColumnFile.createdBy},"
        "${TablesColumnFile.updatedBy}, "
        "${TablesColumnFile.isDataSynced} "
        ")"
        "VALUES("
        "'${bean.usrName}',"
        "'${bean.effDate}',"
        "'${bean.geoLatitude}',"
        "'${bean.geoLongitude}',"
        "'${bean.geoLocation}',"
        "'${bean.startingFromImg}',"
        "'${bean.endingFromImg}',"
        "${bean.startingPoint},"
        "${bean.endingPoint},"
        "${bean.totMeterReading},"
        "'${bean.createdAt}',"
        "'${bean.updatedAt}',"
        "'${bean.createdBy}',"
        "'${bean.updatedBy}',"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${speedoMeterMaster}");
    });
  }

  Future _createCustomerLoanCashFlow(Database db) {
    String query = "CREATE TABLE ${CosutomerLoanCashFlowMaster} ("
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mfimainbsinc} REAL,"
        "${TablesColumnFile.mfisubbusinc} REAL,"
        "${TablesColumnFile.mfirentalinc} REAL,"
        "${TablesColumnFile.mfiotherinc} REAL,"
        "${TablesColumnFile.mfitotalInc} REAL,"
        "${TablesColumnFile.mbepurequipments} REAL,"
        "${TablesColumnFile.mbepetrolcost} REAL,"
        "${TablesColumnFile.mbewages} REAL,"
        "${TablesColumnFile.mberent} REAL,"
        "${TablesColumnFile.mbeeemi} REAL,"
        "${TablesColumnFile.mbetotalbusexp} REAL,"
        "${TablesColumnFile.mfefoodexp} REAL,"
        "${TablesColumnFile.mfemobileexp} REAL,"
        "${TablesColumnFile.mfemedicalexp} REAL,"
        "${TablesColumnFile.mfeschoolfees} REAL,"
        "${TablesColumnFile.mfecollegefees} REAL,"
        "${TablesColumnFile.mfemiscellaneous} REAL,"
        "${TablesColumnFile.mfeelectricity} REAL,"
        "${TablesColumnFile.mfesocialcharity} REAL,"
        "${TablesColumnFile.mfetotalfaminc} REAL,"
        "${TablesColumnFile.mfetotalexp} REAL,"
        "${TablesColumnFile.msurpluscash} REAL,"
        "${TablesColumnFile.mdbr} REAL,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.mloanmrefno} INTEGER,"
        "${TablesColumnFile.mloantrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.mrefno}, ${TablesColumnFile.trefno} ))";
    print("primary of lookup table");
    print("CustomerCashflow " + query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future updateSavingsAccountMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${savingsMaster} SET ${query}");
    });
  }

  Future updateCustomerLoanMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${customerLoanDetailsMaster} SET ${query}");
    });
  }

  Future updateLoanDetailsStatus(
      int loanLeTrefNo,
      int loanMrefno,
      CustomerLoanDetailsBean custLoanBean,
      DateTime updateDate,
      String routeTo,
      String routeFrom,
      String lastUpdatedBy) async {
    var db = await _getDb();
    /*String query;
    if (custLoanBean.mrefno != null && custLoanBean.mrefno > 0) {
        query =
            "Select * from  ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno} = $loanLeTrefNo AND ${TablesColumnFile.mrefno} = ${custLoanBean.mrefno}";

    } else {
        query =
            "Select * from  ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno} = $loanNumber AND ${TablesColumnFile.mcreatedby} = '${custLoanBean.mcreatedby}'";
    }

    print("select query of laon satus upd " + query.toString());
    var db = await _getDb();

    var result = await db.rawQuery(queselectPrimaryTableForValidtionry);*/
    // print("result after " + result.toString());
    String updateQuery;
    if (loanMrefno != null && loanMrefno > 0) {
      updateQuery =
      "UPDATE ${customerLoanDetailsMaster} SET ${TablesColumnFile.mleadstatus} = ${custLoanBean.mleadstatus} ,${TablesColumnFile.mlastupdatedt} = '${updateDate}', "
          " ${TablesColumnFile.mApprovalDesc} ='${custLoanBean.mapprovaldesc}' ,"
          " ${TablesColumnFile.mrouteto} ='${routeTo}' ,   ${TablesColumnFile.mroutefrom} ='${routeFrom}' , "
          " ${TablesColumnFile.mlastupdateby} ='${lastUpdatedBy}' , ${TablesColumnFile.missynctocoresys} = 0 "
          " WHERE "
          " ${TablesColumnFile.trefno} = $loanLeTrefNo AND ${TablesColumnFile.mrefno} = $loanMrefno";
    } else {
      updateQuery =
      "UPDATE ${customerLoanDetailsMaster} SET ${TablesColumnFile.mleadstatus} = ${custLoanBean.mleadstatus}, "
          "${TablesColumnFile.mApprovalDesc} = '${custLoanBean.mapprovaldesc}' ,"
          " ${TablesColumnFile.mlastupdatedt} = '${updateDate}' "
          ", ${TablesColumnFile.mrouteto} ='${routeTo}' ,   ${TablesColumnFile.mroutefrom} ='${routeFrom}' , "
          " ${TablesColumnFile.mlastupdateby} ='${lastUpdatedBy}' , ${TablesColumnFile.missynctocoresys} = 0 "
          " WHERE ${TablesColumnFile.trefno} = $loanLeTrefNo AND ${TablesColumnFile.mrefno} = 0";
    }

    print(updateQuery);
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(updateQuery);
    });
  }

  Future<bool> checkIfCGT1And2onSameDate(int loanNumber) async {
    bool isCgt2OnSameDate = false;
    var db = await _getDb();
    var result;
    result = await db.rawQuery(
        'SELECT ${TablesColumnFile.mleadstatus} FROM ${customerLoanDetailsMaster} WHERE ${TablesColumnFile.mleadsid} = ${loanNumber};) ');
    if (result["mleadstatus"] == 5) {
      result = null;
      result = await db.rawQuery(
          'SELECT ${TablesColumnFile.createdAt} FROM ${CGT1Master} WHERE ${TablesColumnFile.mleadsid} = ${loanNumber};) ');
    }
    DateTime cgt1CreatedDate = DateTime.parse(result[TablesColumnFile.endTime]);
    if (cgt1CreatedDate.isBefore(DateTime.now())) {
      isCgt2OnSameDate = true;
    }
    return isCgt2OnSameDate;
  }

  Future updateCustomerNOCImageMaster(NOCImageBean imageBean) async {
    print("trying to insert or replace ${customerNOCImageMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${customerNOCImageMaster}  "
        "(${TablesColumnFile.trefno} , "
        "${TablesColumnFile.serialNo}  , "
        "${TablesColumnFile.NOCImageString}  , "
        "${TablesColumnFile.createdAt}  , "
        "${TablesColumnFile.mnameofmfi}  , "
        "${TablesColumnFile.updatedAt}   ) "
        "VALUES "
        "(${imageBean.adhaarNo} , "
        "'${imageBean.serialNo}' , "
        "'${imageBean.NOCImageString}'  , "
        "'${imageBean.createdAt}' , "
        "'${imageBean.updatedAt}'  , "
        "'${imageBean.nameOfMFI}'  , "
        "${imageBean.isDataSynced} ); ";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${customerNOCImageMaster}");
    });
  }

  //KYC Master Update
  Future updateKycMaster(KycMasterBean kycObj) async {
    print("trying to insert or replace ${kycMaster}");
    String insertQuery = 'INSERT OR REPLACE INTO ${kycMaster} ('
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "'${TablesColumnFile.mleadsid}',"
        "${TablesColumnFile.mloantrefno},"
        "${TablesColumnFile.mloanmrefno},"
        "${TablesColumnFile.mcusttrefno},"
        "${TablesColumnFile.mcustmrefno},"
        "${TablesColumnFile.mbackground},"
        "${TablesColumnFile.mjob},"
        "${TablesColumnFile.mlifestyle},"
        "${TablesColumnFile.mloanrepay},"
        "${TablesColumnFile.mnetworth},"
        "'${TablesColumnFile.mcomments}',"
        "${TablesColumnFile.mverifiedinfo},"
        "${TablesColumnFile.mcreateddt},"
        "'${TablesColumnFile.mcreatedby}',"
        "${TablesColumnFile.mlastupdatedt},"
        "'${TablesColumnFile.mlastupdateby}',"
        "'${TablesColumnFile.mgeolocation}',"
        "'${TablesColumnFile.mgeologd}',"
        "'${TablesColumnFile.mgeolatd}',"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate})"
        "VALUES"
        "("
        "${kycObj.trefno},"
        "${kycObj.mrefno},"
        "'${kycObj.mleadsid}',"
        "${kycObj.mloantrefno},"
        "${kycObj.mloanmrefno},"
        "${kycObj.mcusttrefno},"
        "${kycObj.mcustmrefno},"
        "${kycObj.mbackground},"
        "${kycObj.mjob},"
        "${kycObj.mlifestyle},"
        "${kycObj.mloanrepay},"
        "${kycObj.mnetworth},"
        "'${kycObj.mcomments}',"
        "${kycObj.mverifiedinfo},"
        "'${kycObj.mcreateddt}',"
        "'${kycObj.mcreatedby}',"
        "'${kycObj.mlastupdatedt}',"
        "'${kycObj.mlastupdateby}',"
        "'${kycObj.mgeolocation}',"
        "'${kycObj.mgeologd}',"
        "'${kycObj.mgeolatd}',"
        "${kycObj.missynctocoresys},"
        "'${kycObj.mlastsynsdate}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${kycMaster}");
    });
  }

  Future<List<CreditBereauBean>> getAllCreditMasterObjectsSynced() async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      CreditBereauBean retBean = new CreditBereauBean();
      List<CreditBereauBean> n = new List<CreditBereauBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $creditBereauMaster where  ${TablesColumnFile.misuploaded} = 1");

      result = await db.rawQuery(
          'SELECT *  FROM $creditBereauMaster where  ${TablesColumnFile.misuploaded} = 1');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = bindDataProspectbean(result[i]);
          print("exiting from map");
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

  Future<List<SavingsListBean>> getSavingsAccountDetails() async {
    var db = await _getDb();
    SavingsListBean retBean = new SavingsListBean();
    List<SavingsListBean> SavingsAccountList = new List<SavingsListBean>();
    var result;
    print("query is" + "SELECT *  FROM $savingsMaster ;");
    //result = await db.rawQuery('SELECT *  FROM $savingsMaster WHERE ${TablesColumnFile.mprdacctId} <> null AND  ${TablesColumnFile.mprdacctId} <> "null" ;');
    result = await db.rawQuery(
        'SELECT *  FROM $savingsMaster Order by ${TablesColumnFile.mdateopen} DESC ;');
    var result1 = await db.rawQuery('SELECT COUNT(*) FROM ${savingsMaster}');
    print("savingsMaster count");
    print(result1);
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindDataSavingsListBean(result[i]);
      print("exiting from map");
      SavingsAccountList.add(retBean);
    }
    return SavingsAccountList;
  }

  Future<List<NewTermDepositBean>> getTermDepositList() async {
    var db = await _getDb();
    NewTermDepositBean retBean = new NewTermDepositBean();
    List<NewTermDepositBean> TermDepositList = new List<NewTermDepositBean>();
    var result;
    print("query is" + "SELECT *  FROM $TermDepositMaster ;");
    result = await db.rawQuery('SELECT *  FROM $TermDepositMaster  ;');
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindTermDepositListBean(result[i]);
      print("exiting from map");
      TermDepositList.add(retBean);
    }
    return TermDepositList;
  }

  GuarantorDetailsBean bindLoanGuarantorDetailsBean(
      Map<String, dynamic> result) {
    return GuarantorDetailsBean.fromMap(result);
  }

  LoanUtilizationBean bindLoanUtilizationBean(Map<String, dynamic> result) {
    return LoanUtilizationBean.fromMap(result);
  }

  Future<List<GuarantorDetailsBean>> getGaurantorDetailsList(
      int trefno, int mrefno) async {
    var db = await _getDb();
    String seleQuery = "";
    GuarantorDetailsBean retBean = new GuarantorDetailsBean();
    List<GuarantorDetailsBean> GaurantorDetailsList =
    new List<GuarantorDetailsBean>();
    var result;
    seleQuery = "Select * from ${gaurantorMaster} WHERE "
        "${TablesColumnFile.mloantrefno + " = " + trefno.toString()}"
        "${mrefno == 0 || mrefno == null ? "" : " AND " + TablesColumnFile.mloanmrefno + " = " + mrefno.toString()}; ";

    result = await db.rawQuery(seleQuery);

    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindLoanGuarantorDetailsBean(result[i]);
      print("exiting from map");
      GaurantorDetailsList.add(retBean);
    }
    return GaurantorDetailsList;
  }

  Future<List<LoanUtilizationBean>> getLoanUtilizationDetails() async {
    var db = await _getDb();
    LoanUtilizationBean retBean = new LoanUtilizationBean();
    List<LoanUtilizationBean> UtilizationList = new List<LoanUtilizationBean>();
    var result;
    print("query is" + "SELECT *  FROM $loanUtilizationMaster ;");
    result = await db.rawQuery('SELECT *  FROM $loanUtilizationMaster  ;');
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindLoanUtilizationBean(result[i]);
      print("exiting from map");
      UtilizationList.add(retBean);
    }
    return UtilizationList;
  }

  Future<List<LoanUtilizationBean>> getLoanUtilizationNotSynced() async {
    var db = await _getDb();
    LoanUtilizationBean retBean = new LoanUtilizationBean();
    List<LoanUtilizationBean> UtilizationList = new List<LoanUtilizationBean>();
    var result;
    print("query is" +
        "SELECT *  FROM $loanUtilizationMaster where ${TablesColumnFile.isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} is NULL; ;");
    result = await db.rawQuery(
        'SELECT *  FROM $loanUtilizationMaster where ${TablesColumnFile.isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} is NULL; ;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindLoanUtilizationBean(result[i]);
        print("exiting ffrom map");
        UtilizationList.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return UtilizationList;
  }

  Future<List<CreditBereauBean>> getAllCbCheckEligibleProspect() async {
    //try {
    var db = await _getDb();

    print("inside get ALl Objects");
    CreditBereauBean retBean = new CreditBereauBean();
    List<CreditBereauBean> n = new List<CreditBereauBean>();

    var result;
    print("query is" +
        "SELECT *  FROM $creditBereauMaster where  ${TablesColumnFile.misuploaded}= 0 AND ${TablesColumnFile.motpverified} = 1 ");

    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauMaster where  ${TablesColumnFile.misuploaded} = 0 AND ${TablesColumnFile.motpverified} = 1');

    //try {
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindDataProspectbean(result[i]);
      print("exiting from map");
      n.add(retBean);
    }
    /*} catch ( e) {
        print(e.toString());
      }*/

    return n;
    /*} catch (e) {
      return null;
    }*/
  }

  Future<List<CreditBereauBean>> getCreditBereauMasterFromProspectStatus(
      int prospectStatus) async {
    var db = await _getDb();
    CreditBereauBean retBean = new CreditBereauBean();
    List<CreditBereauBean> prospectList = new List<CreditBereauBean>();
    var result;

    print("query is" +
        "SELECT *  FROM $creditBereauMaster where ${TablesColumnFile.mprospectstatus} >= ${prospectStatus} ;");
    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauMaster  where ${TablesColumnFile.mprospectstatus} >= ${prospectStatus} ');
    try {
      for (int i = 0; i < result.length; i++) {
        for (var items in result[i].toString().split(",")) {}
        print(result[i].runtimeType);
        retBean = bindProspectBean(result[i]);
        print("exiting from map");
        prospectList.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return prospectList;
  }

  Future<List<CreditBereauBean>> getCreditBereauMasterFromIsDataSynced(
      int isDataSynced) async {
    var db = await _getDb();
    CreditBereauBean retBean = new CreditBereauBean();
    List<CreditBereauBean> prospectList = new List<CreditBereauBean>();

    var result;

    print("query is" +
        "SELECT *  FROM $creditBereauMaster where ${TablesColumnFile.isDataSynced} = ${isDataSynced} ;");
    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauMaster  where ${TablesColumnFile.isDataSynced} = ${isDataSynced} ');
    // try {

    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        //print(result[i]);
        for (var items in result[i].toString().split(",")) {
          //print(items);
        }
        print(result[i].runtimeType);
        retBean = bindProspectBean(result[i]);
        print("exiting from map");
        prospectList.add(retBean);
      }
    }

    /* } catch (e) {
      print(e.toString());
    }*/
    return prospectList;
  }

  CreditBereauBean bindProspectBean(Map<String, dynamic> result) {
    return CreditBereauBean.fromMap(result);
  }

  Future<List<CbResultBean>> getCreditBereauResultNotSynced() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CbResultBean retBean = new CbResultBean();
    List<CbResultBean> prospectList = new List<CbResultBean>();

    /*CreditBereauBean future =await  getMaxSegmentIdentifier(retBean);*/
    //int count = future.segmentIdentifier;
    // print("MaxsegmentIdentifier is"+count.toString());
    var result;

    //if(future!=null) {

    print("query is" +
        "SELECT *  FROM $creditBereauResultMaster where ${TablesColumnFile.isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} is NULL;");
    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauResultMaster  where ${TablesColumnFile.isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} is NULL; ;');
    // try {
    for (int i = 0; i < result.length; i++) {
      //print(result[i]);
      for (var items in result[i].toString().split(",")) {
        //print(items);
      }
      print(result[i].runtimeType);
      retBean = bindCreditBereauResultBean(result[i]);
      print("exiting from map");
      prospectList.add(retBean);
    }
    /* } catch (e) {
      print(e.toString());
    }*/
    return prospectList;
  }

  CbResultBean bindCreditBereauResultBean(Map<String, dynamic> result) {
    return CbResultBean.fromMap(result);
  }

  GRTBean bindCustomerGRTDetails(Map<String, dynamic> result) {
    return GRTBean.fromMap(result);
  }

  Future<List<GRTBean>> getCustomerGRTDetails(int mrefno, int trefno) async {
    var db = await _getDb();
    GRTBean retBean = new GRTBean();
    List<GRTBean> grtDetailsList = new List<GRTBean>();
    String query =
        "SELECT *  FROM $GRTMaster WHERE ${TablesColumnFile.loanmrefno} = ${mrefno} AND ${TablesColumnFile.loantrefno} = ${trefno}";
    var result;
    print("query is" + "SELECT *  FROM $GRTMaster ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        print("yes yaha grt " + result[i].toString());
        print(result[i].runtimeType);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCustomerGRTDetails(result[i]);
        print("exiting ffrom map");
        grtDetailsList.add(retBean);
      }
    } catch (e) {
      print(StackTrace.current);
      debugPrintStack();
      print(e.toString());
    }
    return grtDetailsList;
  }

  CGT2Bean bindCustomerCGT2Details(Map<String, dynamic> result) {
    return CGT2Bean.fromMap(result);
  }

  Future<List<CGT2Bean>> getCustomerCGT2Details(int mrefno, int trefno) async {
    var db = await _getDb();
    CGT2Bean retBean = new CGT2Bean();
    List<CGT2Bean> CGT2DetailsList = new List<CGT2Bean>();
    String query =
        'SELECT *  FROM $CGT2Master  WHERE ${TablesColumnFile.loanmrefno} = ${mrefno} AND ${TablesColumnFile.loantrefno} = ${trefno}';
    var result;
    print("query is" + "SELECT *  FROM $CGT2Master ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        print("yes yaha cgt2 " + result[i].toString());
        print(result[i].runtimeType);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCustomerCGT2Details(result[i]);
        print("exiting ffrom map");
        CGT2DetailsList.add(retBean);
      }
    } catch (e) {
      print(StackTrace.current);
      debugPrintStack();
      print(e.toString());
    }
    return CGT2DetailsList;
  }

  CGT1Bean bindCustomerCGT1Details(Map<String, dynamic> result) {
    return CGT1Bean.fromMap(result);
  }

  Future<List<CGT1Bean>> getCustomerCGT1Details(int mrefno, int trefno) async {
    var db = await _getDb();
    CGT1Bean retBean = new CGT1Bean();
    List<CGT1Bean> CGT1DetailsList = new List<CGT1Bean>();
    String query =
        "SELECT *  FROM $CGT1Master  WHERE  ${TablesColumnFile.loanmrefno} = ${mrefno} AND ${TablesColumnFile.loantrefno} = ${trefno}";
    var result;
    print("query is" + "SELECT *  FROM $CGT1Master ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        print("yes yaha cgt1 " + result[i].toString());
        print(result[i].runtimeType);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }

        retBean = bindCustomerCGT1Details(result[i]);

        CGT1DetailsList.add(retBean);
      }
    } catch (e) {
      print(StackTrace.current);
      debugPrintStack();
      print(e.toString());
    }
    return CGT1DetailsList;
  }

  Future<CreditBereauBean> showAllCreditMaster() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CreditBereauBean retBean = new CreditBereauBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'SELECT *  FROM $creditBereauMaster ');
    var result = await db.rawQuery('SELECT *  FROM $creditBereauMaster ');
    if (result[0] != null) {
      print(result);
      retBean = bindDataCreditBean(result);
    }
    return retBean;
  }

  Future<List<GroupFoundationBean>> getGroupFoundationList() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    GroupFoundationBean retBean = new GroupFoundationBean();
    List<GroupFoundationBean> n = new List<GroupFoundationBean>();
    var result;
    String centerNo = globals.centerNo;
    print("query is" + "SELECT *  FROM $groupFoundationMaster ");
    if (centerNo == "GroupCreation") {
      result = await db.rawQuery("SELECT *  FROM $groupFoundationMaster ");
    } else {
      result = await db.rawQuery(
          "SELECT *  FROM $groupFoundationMaster where ${TablesColumnFile.mcenterid} = $centerNo;");
    }

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindGroupFoundationBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }

    return n;
  }

  GroupFoundationBean bindGroupFoundationBean(Map<String, dynamic> result) {
    return GroupFoundationBean.fromMap(result);
  }

  Future<List<CenterDetailsBean>> getCenterFoundationList( String type) async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CenterDetailsBean retBean = new CenterDetailsBean();
    List<CenterDetailsBean> n = new List<CenterDetailsBean>();

    /*CreditBereauBean future =await  getMaxSegmentIdentifier(retBean);*/
    //int count = future.segmentIdentifier;
    // print("MaxsegmentIdentifier is"+count.toString());
    var result;

    //if(future!=null) {

    print("query is" + "SELECT *  FROM $centerDetailsMaster ");
    if(type=="Center Creation"||type=="Group Creation" ){
      result = await db.rawQuery(
          'SELECT *  FROM $centerDetailsMaster order by ${TablesColumnFile.mnextmeetngdt};');

    }
    else{

      result = await db.rawQuery(
          "SELECT *  FROM $centerDetailsMaster  WHERE ${TablesColumnFile.mcenterid} !=0 AND ${TablesColumnFile.mcenterid} IS NOT NULL "
              " order by ${TablesColumnFile.mnextmeetngdt};");
    }

    try {
      for (int i = 0; i < result.length; i++) {
        //print(result[i]);
        for (var items in result[i].toString().split(",")) {
          //print(items);
        }
        //print(result[i].runtimeType);
        retBean = bindCenterDetailsBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }

    return n;
  }

  CenterDetailsBean bindCenterDetailsBean(Map<String, dynamic> result) {
    return CenterDetailsBean.fromMap(result);
  }

  Future<List<CountryDropDownBean>> getCountryList() async {
    var db = await _getDb();
    CountryDropDownBean retBean = new CountryDropDownBean();
    List<CountryDropDownBean> n = new List<CountryDropDownBean>();
    var result;
    print("query is" + "SELECT *  FROM $countryMaster ");
    result = await db.rawQuery('SELECT *  FROM $countryMaster ;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCountryDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  CountryDropDownBean bindCountryDropDownBean(Map<String, dynamic> result) {
    return CountryDropDownBean.fromMap(result);
  }

  Future<List<StateDropDownList>> getStateList(String countryCd) async {
    var db = await _getDb();
    StateDropDownList retBean = new StateDropDownList();
    List<StateDropDownList> n = new List<StateDropDownList>();
    var result;
    print("query is" +
        "SELECT *  FROM $stateMaster where countryId like '%$countryCd%';");
    result = await db.rawQuery(
        "SELECT *  FROM $stateMaster where countryId like '%$countryCd%';");
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindStateDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  StateDropDownList bindStateDropDownBean(Map<String, dynamic> result) {
    return StateDropDownList.fromMap(result);
  }

  Future<List<DistrictDropDownList>> getDistrictList() async {
    var db = await _getDb();
    DistrictDropDownList retBean = new DistrictDropDownList();
    List<DistrictDropDownList> n = new List<DistrictDropDownList>();
    var result;
    print("query is" + "SELECT *  FROM $districtMaster ");
    result = await db
        .rawQuery("SELECT *  FROM $districtMaster where stateCd = '$stateCd';");
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindDistrictDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  DistrictDropDownList bindDistrictDropDownBean(Map<String, dynamic> result) {
    return DistrictDropDownList.fromMap(result);
  }

  Future<List<SubDistrictDropDownList>> getSubDistrictList(
      bool desendAddress) async {
    var db = await _getDb();
    SubDistrictDropDownList retBean = new SubDistrictDropDownList();
    List<SubDistrictDropDownList> n = new List<SubDistrictDropDownList>();
    var result;
    print("query is" + "SELECT *  FROM $subDistrictMaster ");
    if (desendAddress) {
      result = await db.rawQuery("SELECT *  FROM $subDistrictMaster;");
    } else {
      result = await db.rawQuery(
          "SELECT *  FROM $subDistrictMaster where distCd = $distCd;");
    }
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindSubDistrictDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  SubDistrictDropDownList bindSubDistrictDropDownBean(
      Map<String, dynamic> result) {
    return SubDistrictDropDownList.fromMap(result);
  }

  Future<List<AreaDropDownList>> getAreaList() async {
    var db = await _getDb();
    AreaDropDownList retBean = new AreaDropDownList();
    List<AreaDropDownList> n = new List<AreaDropDownList>();
    var result;

    print(
        "query is" + "SELECT *  FROM $areaMaster where placeCd = '$placeCd' ");
    result = await db
        .rawQuery("SELECT *  FROM $areaMaster where placeCd = '$placeCd';");

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindAreaDropDownBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  AreaDropDownList bindAreaDropDownBean(Map<String, dynamic> result) {
    return AreaDropDownList.fromMap(result);
  }

  Future<CbResultBean> getCbResult(int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile.mrefno} = ${mrefNo}";

    var result;
    CbResultBean retBean = new CbResultBean();

    print(
        "query is" + "SELECT *  FROM $creditBereauResultMaster  where ${str}");

    try {
      result = await db
          .rawQuery('SELECT *  FROM $creditBereauResultMaster where ${str};');

      if (result[0] != null) {
        print(result[0]);
        retBean = bindCreditResultBean(result);
      }
      return retBean;
    } catch (e) {
      print(e);
      return null;
    }
  }

  CbResultBean bindCreditResultBean(List<Map<String, dynamic>> result) {
    return CbResultBean.fromMap(result[0]);
  }

  Future<List<CbResultBean>> getLoanDetails(int trefNo, int mrefNo) async {
    var db = await _getDb();

    CbResultBean retBean = new CbResultBean();
    List<CbResultBean> n = new List<CbResultBean>();
    var str =
        "${TablesColumnFile.trefno} = $trefNo AND ${TablesColumnFile.mrefno} = $mrefNo  ";

    var result;

    print("query is" +
        "SELECT *  FROM $creditBereauLoanDetailsMaster where ${str} ");
    result = await db.rawQuery(
        'SELECT *  FROM $creditBereauLoanDetailsMaster  where ${str};');

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindLoanDetailBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print("error in fetching");
    }

    return n;
  }

  CbResultBean bindLoanDetailBean(Map<String, dynamic> result) {
    return CbResultBean.fromMap(result);
  }

  CreditBereauBean bindDataProspectbean(Map<String, dynamic> result) {
    return CreditBereauBean.fromMap(result);
  }

  CreditBereauBean bindDataCreditBean(List<Map<String, dynamic>> result) {
    return CreditBereauBean.fromMap(result[0]);
  }

  Future updateLoginColumn(LoginBean loginBean, String usrCode) async {
    String selectQuery =
        'SELECT * FROM ${userMasterTable}  WHERE ${TablesColumnFile.musrcode}  =  "$usrCode"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQuery);
    print(selectQuery.toString() + "Result==> " + result.toString());

    if (result.isEmpty) {
      String insertQuery = 'INSERT OR REPLACE INTO '
          '${userMasterTable}'
          '( ${TablesColumnFile.musrcode}  ,'
          '${TablesColumnFile.mcustaccesslvl} ,'
          '${TablesColumnFile.mextnno} ,'
          '${TablesColumnFile.mactiveinstn} ,'
          '${TablesColumnFile.mautologoutperiod} ,'
          '${TablesColumnFile.mautologoutyn} ,'
          '${TablesColumnFile.mbadloginsdt} ,'
          '${TablesColumnFile.memailid} ,'
          '${TablesColumnFile.merror} ,'
          '${TablesColumnFile.merrormessage} ,'
          '${TablesColumnFile.mgrpcd} ,'
          '${TablesColumnFile.misloggedinyn} ,'
          '${TablesColumnFile.mlastpwdchgdt} ,'
          '${TablesColumnFile.mlastsyslidt} ,'
          '${TablesColumnFile.mmaxbadlginperday} ,'
          '${TablesColumnFile.mmaxbadlginperinst} ,'
          '${TablesColumnFile.mmobile} ,'
          '${TablesColumnFile.mnextpwdchgdt} ,'
          '${TablesColumnFile.mnextsyslgindt} ,'
          '${TablesColumnFile.mnoofbadlogins} ,'
          '${TablesColumnFile.mpwdchgforcedyn} ,'
          '${TablesColumnFile.mpwdchgperioddays} ,'
          '${TablesColumnFile.mregdevicemacid} ,'
          '${TablesColumnFile.mreportinguser} ,'
          '${TablesColumnFile.mstatus} ,'
          '${TablesColumnFile.musrbrcode} ,'
          '${TablesColumnFile.musrdesignation} ,'
          '${TablesColumnFile.musrname} ,'
          '${TablesColumnFile.musrpass} ,'
          '${TablesColumnFile.musrshortname} ,'
          '${TablesColumnFile.mReason} ,'
          '${TablesColumnFile.mSusDate} ,'
          '${TablesColumnFile.mJoinDate} ,'
          '${TablesColumnFile.mgender} ,'
          '${TablesColumnFile.mcreateddt} ,'
          '${TablesColumnFile.mcreatedby} ,'
          '${TablesColumnFile.mlastupdatedt} ,'
          '${TablesColumnFile.mlastupdateby} ,'
          '${TablesColumnFile.mgeolocation} ,'
          '${TablesColumnFile.mgeolatd} ,'
          '${TablesColumnFile.mgeologd} ,'
          '${TablesColumnFile.mlocationtrackeronoff} ,'
          '${TablesColumnFile.mpathtrackeronoff} ,'
          '${TablesColumnFile.profileimage} ,'
          '${TablesColumnFile.mlastsynsdate})'
          ' VALUES('
          '"${loginBean.musrcode.trim()}",'
          '${loginBean.mcustaccesslvl} ,'
          '${loginBean.mextnno} ,'
          '"${loginBean.mactiveinstn}",'
          '${loginBean.mautologoutperiod} ,'
          '"${loginBean.mautologoutyn}",'
          '"${loginBean.mbadloginsdt}" ,'
          '"${loginBean.memailid}",'
          '${loginBean.merror} ,'
          '"${loginBean.merrormessage}",'
          '${loginBean.mgrpcd} ,'
          '${loginBean.misloggedinyn} ,'
          '"${loginBean.mlastpwdchgdt}" ,'
          '"${loginBean.mlastsyslidt}" ,'
          '${loginBean.mmaxbadlginperday} ,'
          '${loginBean.mmaxbadlginperinst} ,'
          '"${loginBean.mmobile}",'
          '"${loginBean.mnextpwdchgdt}" ,'
          '"${loginBean.mnextsyslgindt}" ,'
          '${loginBean.mnoofbadlogins} ,'
          '"${loginBean.mpwdchgforcedyn}",'
          '${loginBean.mpwdchgperioddays} ,'
          '"${loginBean.mregdevicemacid}",'
          '"${loginBean.mreportinguser}",'
          '${loginBean.mstatus} ,'
          '${loginBean.musrbrcode} ,'
          '"${loginBean.musrdesignation}",'
          '"${loginBean.musrname}",'
          '"${loginBean.musrpass.trim()}",'
          '"${loginBean.musrshortname}",'
          '"${loginBean.mReason}",'
          '"${loginBean.mSusDate}" ,'
          '"${loginBean.mJoinDate}" ,'
          '"${loginBean.mgender}",'
          '"${loginBean.mcreateddt}" ,'
          '"${loginBean.mcreatedby}",'
          '"${loginBean.mlastupdatedt}" ,'
          '"${loginBean.mlastupdateby}",'
          '"${loginBean.mgeolocation}",'
          '"${loginBean.mgeolatd}",'
          '"${loginBean.mgeologd}",'
          '${loginBean.mlocationtrackeronoff} ,'
          '${loginBean.mpathtrackeronoff} ,'
          '"${loginBean.profileimage}",'
          '"${loginBean.mlastsynsdate}")';
      print("insert query of login here it is " + insertQuery);
      var db1 = await _getDb();
      await db1.transaction((Transaction txn) async {
        int id = await txn.rawInsert(insertQuery);
        print(id.toString() + "idafterinsert");
      });
    } else {
      var db1 = await _getDb();
      int count = await db1.rawUpdate(
          'UPDATE ${userMasterTable} SET '
              '${TablesColumnFile.mcustaccesslvl} = ?,'
              ' ${TablesColumnFile.mextnno} = ?, '
              ' ${TablesColumnFile.mactiveinstn} = ?, '
              ' ${TablesColumnFile.mautologoutperiod} = ?, '
              ' ${TablesColumnFile.mautologoutyn} = ?, '
              ' ${TablesColumnFile.mbadloginsdt} = ?, '
              ' ${TablesColumnFile.memailid} = ?, '
              ' ${TablesColumnFile.merror} = ?, '
              ' ${TablesColumnFile.merrormessage} = ?, '
              ' ${TablesColumnFile.mgrpcd} = ?, '
              ' ${TablesColumnFile.misloggedinyn} = ?, '
              ' ${TablesColumnFile.mlastpwdchgdt} = ?, '
              ' ${TablesColumnFile.mlastsyslidt} = ?, '
              ' ${TablesColumnFile.mmaxbadlginperday} = ?, '
              ' ${TablesColumnFile.mmaxbadlginperinst} = ?, '
              ' ${TablesColumnFile.mmobile} = ?, '
              ' ${TablesColumnFile.mnextpwdchgdt} = ?, '
              ' ${TablesColumnFile.mnextsyslgindt} = ?, '
              ' ${TablesColumnFile.mnoofbadlogins} = ?, '
              ' ${TablesColumnFile.mpwdchgforcedyn} = ?, '
              ' ${TablesColumnFile.mpwdchgperioddays} = ?, '
              ' ${TablesColumnFile.mregdevicemacid} = ?, '
              ' ${TablesColumnFile.mreportinguser} = ?, '
              ' ${TablesColumnFile.mstatus} = ?, '
              ' ${TablesColumnFile.musrbrcode} = ?, '
              ' ${TablesColumnFile.musrdesignation} = ?, '
              ' ${TablesColumnFile.musrname} = ?, '
              ' ${TablesColumnFile.musrpass} = ?, '
              ' ${TablesColumnFile.musrshortname} = ?, '
              ' ${TablesColumnFile.mReason} = ?, '
              ' ${TablesColumnFile.mSusDate} = ?, '
              ' ${TablesColumnFile.mJoinDate} = ?, '
              ' ${TablesColumnFile.mgender} = ?, '
              ' ${TablesColumnFile.mcreateddt} = ?, '
              ' ${TablesColumnFile.mcreatedby} = ?, '
              ' ${TablesColumnFile.mlastupdatedt} = ?, '
              ' ${TablesColumnFile.mlastupdateby} = ?, '
              ' ${TablesColumnFile.mgeolocation} = ?, '
              ' ${TablesColumnFile.mgeolatd} = ?, '
              ' ${TablesColumnFile.mgeologd} = ?, '
              ' ${TablesColumnFile.mlastsynsdate} = ?, '
              '${TablesColumnFile.mlocationtrackeronoff} = ?,'
              '${TablesColumnFile.profileimage} = ?,'
              '${TablesColumnFile.mpathtrackeronoff} = ? '
              'WHERE ${TablesColumnFile.musrcode} = ?',
          [
            '${loginBean.mcustaccesslvl}',
            '${loginBean.mextnno}',
            '${loginBean.mactiveinstn}',
            '${loginBean.mautologoutperiod}',
            '${loginBean.mautologoutyn}',
            '${loginBean.mbadloginsdt}',
            '${loginBean.memailid}',
            '${loginBean.merror}',
            '${loginBean.merrormessage}',
            '${loginBean.mgrpcd}',
            '${loginBean.misloggedinyn}',
            '${loginBean.mlastpwdchgdt}',
            '${loginBean.mlastsyslidt}',
            '${loginBean.mmaxbadlginperday}',
            '${loginBean.mmaxbadlginperinst}',
            '${loginBean.mmobile}',
            '${loginBean.mnextpwdchgdt}',
            '${loginBean.mnextsyslgindt}',
            '${loginBean.mnoofbadlogins}',
            '${loginBean.mpwdchgforcedyn}',
            '${loginBean.mpwdchgperioddays}',
            '${loginBean.mregdevicemacid}',
            '${loginBean.mreportinguser}',
            '${loginBean.mstatus}',
            '${loginBean.musrbrcode}',
            '${loginBean.musrdesignation}',
            '${loginBean.musrname}',
            '${loginBean.musrpass.trim()}',
            '${loginBean.musrshortname}',
            '${loginBean.mReason}',
            '${loginBean.mSusDate}',
            '${loginBean.mJoinDate}',
            '${loginBean.mgender}',
            '${loginBean.mcreateddt}',
            '${loginBean.mcreatedby}',
            '${loginBean.mlastupdatedt}',
            '${loginBean.mlastupdateby}',
            '${loginBean.mgeolocation}',
            '${loginBean.mgeolatd}',
            '${loginBean.mgeologd}',
            '${loginBean.mlastsynsdate}',
            '${loginBean.mlocationtrackeronoff}' ,
            '${loginBean.profileimage}' ,
            '${loginBean.mpathtrackeronoff}' ,
            '$usrCode'
          ]);
      print('updated>>>: $count');
    }
  }

  Future<LoginBean> getLoginData(LoginBean loginBean) async {
    var db = await _getDb();
    var userPass =
        "${TablesColumnFile.musrpass} = '${loginBean.musrpass.trim()}'";
    var userCode =
        "UPPER(${TablesColumnFile.musrcode}) = '${loginBean.musrcode.trim().toUpperCase()}'";
    LoginBean retBean = new LoginBean();

    print('query is here : ' +
        'SELECT *FROM   $userMasterTable  WHERE $userCode AND $userPass');
    var result = await db.rawQuery(
        'SELECT *  FROM $userMasterTable  WHERE $userCode AND $userPass');
    if (result[0] != null) {
      print(" yes login ofline " + result[0].toString());
      retBean = bindDataLoginBEan(result);
      //  retBean = bindDataLoginBEan(result);
    }
    return retBean;
  }

  LoginBean bindDataLoginBEan(List<Map<String, dynamic>> result) {
    return LoginBean.fromMap(result[0]);
  }

  String creditBereauStructure = "${TablesColumnFile.trefno} ,"
      "${TablesColumnFile.mrefno} ,"
      "${TablesColumnFile.mlbrcode} ,"
      "${TablesColumnFile.mqueueno} ,"
      "${TablesColumnFile.mprospectdt} ,"
      "${TablesColumnFile.mnametitle} ,"
      "${TablesColumnFile.mprospectname} ,"
      "${TablesColumnFile.mmobno} ,"
      "${TablesColumnFile.mdob} ,"
      "${TablesColumnFile.motpverified} ,"
      "${TablesColumnFile.mcbcheckstatus} ,"
      "${TablesColumnFile.mprospectstatus} ,"
      "${TablesColumnFile.madd1} ,"
      "${TablesColumnFile.madd2} ,"
      "${TablesColumnFile.madd3} ,"
      "${TablesColumnFile.mhomeloc} ,"
      "${TablesColumnFile.mareacd} ,"
      "${TablesColumnFile.mvillage} ,"
      "${TablesColumnFile.mdistcd} ,"
      "${TablesColumnFile.mstatecd} ,"
      "${TablesColumnFile.mcountrycd} ,"
      "${TablesColumnFile.mpincode} ,"
      "${TablesColumnFile.mcountryoforigin} ,"
      "${TablesColumnFile.mnationality} ,"
      "${TablesColumnFile.mpanno} ,"
      "${TablesColumnFile.mpannodesc} ,"
      "${TablesColumnFile.misuploaded} ,"
      "${TablesColumnFile.mspousename} ,"
      "${TablesColumnFile.mspouserelation} ,"
      "${TablesColumnFile.mnomineename} ,"
      "${TablesColumnFile.mnomineerelation} ,"
      "${TablesColumnFile.mcreditenqpurposetype} ,"
      "${TablesColumnFile.mcreditequstage} ,"
      "${TablesColumnFile.mcreditreporttransdatetype} ,"
      "${TablesColumnFile.mcreditreporttransid} ,"
      "${TablesColumnFile.mcreditrequesttype} ,"
      "${TablesColumnFile.mcreateddt} ,"
      "${TablesColumnFile.mcreatedby} ,"
      "${TablesColumnFile.mlastupdatedt} ,"
      "${TablesColumnFile.mlastupdateby} ,"
      "${TablesColumnFile.mgeolocation} ,"
      "${TablesColumnFile.mgeolatd} ,"
      "${TablesColumnFile.mgeologd} ,"
      "${TablesColumnFile.missynctocoresys} ,"
      "${TablesColumnFile.mlastsynsdate} ,"
      "${TablesColumnFile.mstreet} ,"
      "${TablesColumnFile.mhouse} ,"
      "${TablesColumnFile.mcity} ,"
      "${TablesColumnFile.mstate} ,"
      "${TablesColumnFile.mid1} ,"
      "${TablesColumnFile.mid1desc},"
      "${TablesColumnFile.motp} ,"
      "${TablesColumnFile.mroutedto} ";

  Future<GLAccountBean> getGlAccountDetails(String prdAcctId)async{

    var db = await _getDb();
    GLAccountBean retBean = new GLAccountBean();
    var result;
    String query = "SELECT * FROM ${glAccountMaster} WHERE ${TablesColumnFile.mprdacctid} = '${prdAcctId}' ";
    result = await db.rawQuery(query);
    try{
      if(result!=null){
        retBean = bindGLAccountBean(result[0]);
      }
    }catch(_){

    }

    return retBean;




  }

  Future<int> getMaxTrefNo() async {
    print("trying to select last row  ${creditBereauMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${creditBereauMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${creditBereauMaster});";
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

  CreditBereauBean bindDataCreditBereauBean(List<Map<String, dynamic>> result) {
    return CreditBereauBean.fromMap(result[0]);
  }

  Future<CreditBereauBean> deleteDatabase() async {
    var db = await _getDb();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'delete  *  FROM $creditBereauMaster  ');
    var result = await db.rawQuery('Delete FROM $creditBereauMaster ');
    print(
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdelete from $creditBereauLoanDetailsMaster ");
    result = await db.rawQuery('Delete FROM $creditBereauLoanDetailsMaster');

    print(
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdelete from $creditBereauResultMaster ");
    result = await db.rawQuery('Delete FROM $creditBereauResultMaster');
  }

  Future<CreditBereauBean> deleteSelected(CreditBereauBean cbb) async {
    var db = await _getDb();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'Delete FROM $creditBereauMaster where  ${TablesColumnFile.trefno} = ${cbb.trefno} AND  ${TablesColumnFile.mrefno} = ${cbb.mrefno}');
    ;
    var result = await db.rawQuery(
        'Delete FROM $creditBereauMaster where  ${TablesColumnFile.trefno} = ${cbb.trefno} AND  ${TablesColumnFile.mrefno} = ${cbb.mrefno}');
  }

  Future deleteCbResultData() async {
    var db = await _getDb();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'delete  *  FROM $creditBereauMaster  ');
    var result = await db.rawQuery('Delete FROM $creditBereauResultMaster ');

    print(
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdelete from $creditBereauResultMaster ");

    result = await db.rawQuery('Delete FROM $creditBereauLoanDetailsMaster');
    print(
        "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXdelete from $creditBereauLoanDetailsMaster ");
  }

  //create LookupMasterTable

  Future _createLoanCycleParameterSecondaryMasterTable(Database db) {
    String query = "CREATE TABLE ${LoanCycleParameterSecondaryMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.mcusttype} INTEGER,"
        "${TablesColumnFile.mgrtype} INTEGER,"
        "${TablesColumnFile.meffdate} DATETIME,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mruletype} INTEGER,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.muptoamount} REAL,"
        "${TablesColumnFile.mminamount} REAL,"
        "${TablesColumnFile.mmaxamount} REAL,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode},${TablesColumnFile.mprdcd},${TablesColumnFile.mloancycle},${TablesColumnFile.mcusttype},${TablesColumnFile.mgrtype},${TablesColumnFile.meffdate},${TablesColumnFile.mfrequency},${TablesColumnFile.mruletype},${TablesColumnFile.msrno}))";

    // "PRIMARY KEY (${TablesColumnFile.mlbrcode},${TablesColumnFile.mprdcd},${TablesColumnFile.mloancycle},${TablesColumnFile.mcusttype},${TablesColumnFile.mgrtype},${TablesColumnFile.meffdate},${TablesColumnFile.mfrequency},${TablesColumnFile.mruletype},${TablesColumnFile.msrno})";
    print("primary of Insert Loan Cycle Parameter Secondary Master table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createLoanCycleParameterPrimaryMasterTable(Database db) {
    String query = "CREATE TABLE ${LoanCycleParameterPrimaryMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.mcusttype} INTEGER,"
        "${TablesColumnFile.mgrtype} INTEGER,"
        "${TablesColumnFile.meffdate} DATETIME,"
        "${TablesColumnFile.mminamount} REAL,"
        "${TablesColumnFile.mmaxamount} REAL,"
        "${TablesColumnFile.mminperiod} INTEGER,"
        "${TablesColumnFile.mmaxperiod} INTEGER,"
        "${TablesColumnFile.mminnoofgrpmems} INTEGER,"
        "${TablesColumnFile.mmaxnoofgrpmems} INTEGER,"
        "${TablesColumnFile.mgender} TEXT,"
        "${TablesColumnFile.mminage} INTEGER,"
        "${TablesColumnFile.mmaxage} INTEGER,"
        "${TablesColumnFile.mgrpcycyn} INTEGER,"
        "${TablesColumnFile.mlogic} INTEGER,"
        "${TablesColumnFile.mtenor} INTEGER,"
        "${TablesColumnFile.mfrequency} TEXT,"
        "${TablesColumnFile.mincramount} REAL,"
        "${TablesColumnFile.mnoofinstlclosure} INTEGER,"
        "${TablesColumnFile.mmultiplefactor} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile.mprdcd}, ${TablesColumnFile.meffdate}))";
    print("primary of Insert Loan Cycle Parameter Primary Master table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createInterestOffsetMasterTable(Database db) {
    String query = "CREATE TABLE ${InterestOffsetMaster} ("
        "${TablesColumnFile.mlbrcode} TEXT,"
        "${TablesColumnFile.mprdcd} INTEGER,"
        "${TablesColumnFile.mloantype} INTEGER,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.meffdate} DATETIME,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mmonths} INTEGER,"
        "${TablesColumnFile.mamount} REAL,"
        "${TablesColumnFile.mintrestrate} REAL,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile.mprdcd}, ${TablesColumnFile.mloantype}, ${TablesColumnFile.mloancycle}, ${TablesColumnFile.meffdate}, ${TablesColumnFile.msrno}))";
    print("primary of Insert Slab table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  /*Future _createSystemParameterMasterTable(Database db) {
    String query = "CREATE TABLE ${SystemParameterMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcode} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER PRIMARY KEY,"
        "${TablesColumnFile.name} INTEGER,"
        "${TablesColumnFile.mfield1value} TEXT "
        ");";
    print("primary of Insert Slab table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }*/

  Future _createSystemParameterMasterTable(Database db) {
    String query = "CREATE TABLE ${SystemParameterMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER ,"
        "${TablesColumnFile.mcode} TEXT,"
        "${TablesColumnFile.mcodedesc} TEXT ,"
        "${TablesColumnFile.mcodevalue} TEXT ,"
        "${TablesColumnFile.mcreateddt} DATETIME ,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile.mcode}))";
    print("system parameter table--" + query.toString());
    //print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createInterestSlabMasterTable(Database db) {
    String query = "CREATE TABLE ${InterestSlabMaster} ("
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.minteffdt} DATETIME,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mtoamt} REAL,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mmlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mprdcd}, ${TablesColumnFile.mcurcd}, ${TablesColumnFile.minteffdt}, ${TablesColumnFile.msrno}))";
    print("primary of Insert Slab table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createLookupMasterTable(Database db) {
    String query = "CREATE TABLE ${LookupMaster} ("
        "${TablesColumnFile.mcode} TEXT,"
        "${TablesColumnFile.mcodetype} INTEGER,"
        "${TablesColumnFile.mcodedesc} TEXT,"
        "${TablesColumnFile.mfield1value} TEXT,"
        "${TablesColumnFile.mcodedatatype} INTEGER,"
        "${TablesColumnFile.mcodedatalen} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mcode}, ${TablesColumnFile.mcodetype} , ${TablesColumnFile.mfield1value}))";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  //Create Sub LookupMaster table

  Future _createSubLookupMasterTable(Database db) {
    String query = "CREATE TABLE ${SubLookupMaster} ("
        "${TablesColumnFile.mcode} TEXT,"
        "${TablesColumnFile.mcodetype} INTEGER,"
        "${TablesColumnFile.mcodedesc} TEXT,"
        "${TablesColumnFile.mfield1value} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.mcode}, ${TablesColumnFile.mcodetype},${TablesColumnFile.mfield1value} ))";
    print("primary of lookup table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future createLoanCycleParameterSecondaryInsert(int lbrCode) async {
    //deletSomeUtil();
    var loanCycleParameterSecondaryServices =
    new LoanCycleParameterSecondaryServices();
    var db = await _getDb();
    List<LoanCycleParameterSecondaryBean> LoanCycleParameterSecondaryList =
    new List<LoanCycleParameterSecondaryBean>();
    await loanCycleParameterSecondaryServices
        .getLoanCycleParameterSecondaryData(lbrCode)
        .then((onValue) {
      print(onValue.length);
      LoanCycleParameterSecondaryList = onValue;
    });
    await AppDatabase.get().deletSomeSyncingActivityFromOmni(
        'Loan_Cycle_Parameter_Secondary_Master');
    for (int i = 0; i < LoanCycleParameterSecondaryList.length; i++) {
      print(LoanCycleParameterSecondaryList.length.toString() +
          " LoanCycleParameterSecondaryMaster");
      String insertQuery =
          "INSERT OR REPLACE INTO ${LoanCycleParameterSecondaryMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mloancycle} ,"
          "${TablesColumnFile.mcusttype} ,"
          "${TablesColumnFile.mgrtype} ,"
          "${TablesColumnFile.meffdate} ,"
          "${TablesColumnFile.mfrequency} ,"
          "${TablesColumnFile.mruletype} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.muptoamount} ,"
          "${TablesColumnFile.mminamount} ,"
          "${TablesColumnFile.mmaxamount} ,"
          "${TablesColumnFile.mlastsynsdate}  )"
          "VALUES"
          "(${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.mlbrcode},"
          "'${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.mprdcd.trim()}',"
          "${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.mloancycle},"
          "${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.mcusttype},"
          "${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.mgrtype},"
          "'${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.meffdate}',"
          "'${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.mfrequency}',"
          "${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.mruletype},"
          "${LoanCycleParameterSecondaryList[i].loanCycleParameterSecondaryComposite.msrno},"
          "${LoanCycleParameterSecondaryList[i].muptoamount},"
          "${LoanCycleParameterSecondaryList[i].mminamount},"
          "${LoanCycleParameterSecondaryList[i].mmaxamount},"
          "'${LoanCycleParameterSecondaryList[i].mlastsynsdate}');";
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() +
            " id after insert in ${LoanCycleParameterSecondaryMaster}");
      });
    }
  }

  Future createLoanCycleParameterPrimaryInsert(int lbrCode) async {
    //deletSomeUtil();
    var loanCycleParameterPrimaryServices =
    new LoanCycleParameterPrimaryServices();
    var db = await _getDb();
    List<LoanCycleParameterPrimaryBean> LoanCycleParameterPrimaryList =
    new List<LoanCycleParameterPrimaryBean>();
    await loanCycleParameterPrimaryServices
        .getLoanCycleParameterPrimaryData(lbrCode)
        .then((onValue) {
      print(onValue.length);
      LoanCycleParameterPrimaryList = onValue;
    });
    await AppDatabase.get().deletSomeSyncingActivityFromOmni(
        'Loan_Cycle_Parameter_Primary_Master');
    for (int i = 0; i < LoanCycleParameterPrimaryList.length; i++) {
      print(LoanCycleParameterPrimaryList.length.toString() +
          " LoanCycleParameterPrimaryMaster");
      String insertQuery =
          "INSERT OR REPLACE INTO ${LoanCycleParameterPrimaryMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mloancycle} ,"
          "${TablesColumnFile.mcusttype} ,"
          "${TablesColumnFile.mgrtype} ,"
          "${TablesColumnFile.meffdate} ,"
          "${TablesColumnFile.mminamount} ,"
          "${TablesColumnFile.mmaxamount} ,"
          "${TablesColumnFile.mminperiod} ,"
          "${TablesColumnFile.mmaxperiod} ,"
          "${TablesColumnFile.mminnoofgrpmems} ,"
          "${TablesColumnFile.mmaxnoofgrpmems} ,"
          "${TablesColumnFile.mgender} ,"
          "${TablesColumnFile.mminage} ,"
          "${TablesColumnFile.mmaxage} ,"
          "${TablesColumnFile.mgrpcycyn} ,"
          "${TablesColumnFile.mlogic} ,"
          "${TablesColumnFile.mtenor} ,"
          "${TablesColumnFile.mfrequency} ,"
          "${TablesColumnFile.mincramount} ,"
          "${TablesColumnFile.mnoofinstlclosure} ,"
          "${TablesColumnFile.mmultiplefactor} ,"
          "${TablesColumnFile.mlastsynsdate}   )"
          "VALUES"
          "(${LoanCycleParameterPrimaryList[i].loanCycleParameterPrimaryComposite.mlbrcode},"
          "'${LoanCycleParameterPrimaryList[i].loanCycleParameterPrimaryComposite.mprdcd}',"
          "${LoanCycleParameterPrimaryList[i].loanCycleParameterPrimaryComposite.mloancycle},"
          "${LoanCycleParameterPrimaryList[i].loanCycleParameterPrimaryComposite.mcusttype},"
          "${LoanCycleParameterPrimaryList[i].loanCycleParameterPrimaryComposite.mgrttype},"
          "'${LoanCycleParameterPrimaryList[i].loanCycleParameterPrimaryComposite.meffdate}',"
          "${LoanCycleParameterPrimaryList[i].mminamount},"
          "${LoanCycleParameterPrimaryList[i].mmaxamount},"
          "${LoanCycleParameterPrimaryList[i].mminperiod},"
          "${LoanCycleParameterPrimaryList[i].mmaxperiod},"
          "${LoanCycleParameterPrimaryList[i].mminnoofgrpmems},"
          "${LoanCycleParameterPrimaryList[i].mmaxnoofgrpmems},"
          "'${LoanCycleParameterPrimaryList[i].mgender}',"
          "${LoanCycleParameterPrimaryList[i].mminage},"
          "${LoanCycleParameterPrimaryList[i].mmaxage},"
          "'${LoanCycleParameterPrimaryList[i].mgrpcycyn}',"
          "${LoanCycleParameterPrimaryList[i].mlogic},"
          "${LoanCycleParameterPrimaryList[i].mtenor},"
          "'${LoanCycleParameterPrimaryList[i].mfrequency}',"
          "${LoanCycleParameterPrimaryList[i].mincramount},"
          "${LoanCycleParameterPrimaryList[i].mnoofinstlclosure},"
          "${LoanCycleParameterPrimaryList[i].mmultiplefactor},"
          "'${LoanCycleParameterPrimaryList[i].mlastsynsdate}');";
      try {
        await db.transaction((Transaction txn) async {
          var id = await txn.rawInsert(insertQuery);
          print(id.toString() +
              " id after insert in ${LoanCycleParameterPrimaryMaster}");
        });
      } catch (_) {
        print("exception here ");
      }
    }
  }

  Future createInterestOffsetInsert() async {
    //deletSomeUtil();
    var interestOffsetServices = new InterestOffsetServices();
    var db = await _getDb();
    List<InterestOffsetBean> InterestOffsetList =
    new List<InterestOffsetBean>();
    await interestOffsetServices.getInterestOffset().then((onValue) {
      print(onValue.length);
      InterestOffsetList = onValue;
    });
    await AppDatabase.get()
        .deletSomeSyncingActivityFromOmni('Interest_Offset_Master');
    for (int i = 0; i < InterestOffsetList.length; i++) {
      print(InterestOffsetList.length.toString() + " InterestOffsetMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${InterestOffsetMaster} "
          "(${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mloantype} ,"
          "${TablesColumnFile.mloancycle} ,"
          "${TablesColumnFile.meffdate} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mmonths} ,"
          "${TablesColumnFile.mamount} ,"
          "${TablesColumnFile.mintrestrate} ,"
          "${TablesColumnFile.mlastsynsdate}  )"
          "VALUES"
          "('${InterestOffsetList[i].interestOffsetComposite.mprdcd}' ,"
          "${InterestOffsetList[i].interestOffsetComposite.mlbrcode},"
          "${InterestOffsetList[i].interestOffsetComposite.mloantype},"
          "${InterestOffsetList[i].interestOffsetComposite.mloancycle} ,"
          "'${InterestOffsetList[i].interestOffsetComposite.meffdate}',"
          "${InterestOffsetList[i].interestOffsetComposite.msrno},"
          "${InterestOffsetList[i].mmonths},"
          "${InterestOffsetList[i].mamount},"
          "${InterestOffsetList[i].mintrestrate},"
          "'${InterestOffsetList[i].mlastsynsdate}');";
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${InterestOffsetMaster}");
      });
    }
  }

  /*Future createSystemParameterInsert() async {
    //deletSomeUtil();
    var systemParameterServices = new SystemParameterServices();
    var db = await _getDb();
    List<SystemParameterBean> SystemParameterList = new List<SystemParameterBean>();
    await systemParameterServices.getSystemParameterData().then((onValue) {
      print(onValue.length);
      SystemParameterList = onValue;
    });
    for (int i = 0; i < SystemParameterList.length; i++) {
      print(SystemParameterList.length.toString() + " SystemParameterMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${SystemParameterMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mcode} ,"
          "${TablesColumnFile.mrefno} ,"
          "${TablesColumnFile.mfield1value} )"

          "VALUES"
          "(${SystemParameterList[i].mlbrcode} ,"
          "${SystemParameterList[i].mcode} ,"
          "${SystemParameterList[i].mrefno} ,"
          "'${SystemParameterList[i].mfield1value} ');";
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${SystemParameterMaster}");
      });
    }

   await setSystemVariables();

  }*/

  Future createSystemParameterInsert() async {
    //deletSomeUtil();
    var systemParameterServices = new SystemParameterServices();
    var db = await _getDb();
    List<SystemParameterBean> SystemParameterList =
    new List<SystemParameterBean>();
    await systemParameterServices.getSystemParameterData().then((onValue) {
      print(onValue.length);
      SystemParameterList = onValue;
    });
    await AppDatabase.get()
        .deletSomeSyncingActivityFromOmni('SystemParameterMaster');

    for (int i = 0; i < SystemParameterList.length; i++) {
      print(SystemParameterList.length.toString() + " SystemParameterMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${SystemParameterMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mcode} ,"
          "${TablesColumnFile.mcodedesc} ,"
          "${TablesColumnFile.mcodevalue} ,"
          "${TablesColumnFile.mcreateddt})"
          "VALUES"
          "(${SystemParameterList[i].systemParameterCompositeEntity.mlbrcode} ,"
          "'${SystemParameterList[i].systemParameterCompositeEntity.mcode}' ,"
          "'${SystemParameterList[i].mcodedesc} ',"
          "'${SystemParameterList[i].mcodevalue}',"
          "'${SystemParameterList[i].mcreateddt} ');";
      print(insertQuery);
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${SystemParameterMaster}");
      });
    }
  }

  /*Future<CbResultBean> getSystemVariables(int codeType) async {
    var db = await _getDb();
    var str = "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile
        .mrefno} = ${mrefNo}";


    var result;
    CbResultBean retBean = new CbResultBean();


    print(
        "query is" + "SELECT *  FROM $  where ${str}");

    try {
      result = await db
          .rawQuery('SELECT *  FROM $creditBereauResultMaster where ${str};');

      if (result[0] != null) {
        print(result[0]);
        retBean = bindCreditResultBean(result);
      }
      return retBean;
    } catch (e) {
      print(e);
      return null;
    }
  }*/

  Future<SystemParameterBean> getSystemParameter(
      String codeType, int lbrCode) async {
    var db = await _getDb();
    SystemParameterBean retBean = new SystemParameterBean();
    var result;

    result = await db.rawQuery(
        "select * FROM ${SystemParameterMaster} where ${TablesColumnFile.mcode} = '$codeType'  AND ${TablesColumnFile.mlbrcode} = $lbrCode ;");

    try {
      print("result here is " + result.toString());
      if (result[0] != null) {
        retBean = SystemParameterBean.fromMap(result[0]);
      }

      return retBean;
    } catch (_) {
      print("not matched");
    }
    return retBean;
  }

  Future createInterestSlabInsert() async {
    //deletSomeUtil();
    var interestSlabServices = new InterestSlabServices();
    var db = await _getDb();
    List<InterestSlabBean> InterestSlabList = new List<InterestSlabBean>();
    await interestSlabServices.getInterestSlab().then((onValue) {
      print(onValue.length);
      InterestSlabList = onValue;
    });
    await AppDatabase.get()
        .deletSomeSyncingActivityFromOmni('Interest_Slab_Master');
    for (int i = 0; i < InterestSlabList.length; i++) {
      print(InterestSlabList.length.toString() + " InsertSlabMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${InterestSlabMaster} "
          "(${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mcurcd} ,"
          "${TablesColumnFile.minteffdt} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mtoamt} ,"
          "${TablesColumnFile.mintrate} ,"
          "${TablesColumnFile.mmlastsynsdate} )"
          "VALUES"
          "('${InterestSlabList[i].intrestSlabComposite.mprdcd != null ? InterestSlabList[i].intrestSlabComposite.mprdcd.trim() : ""}' ,"
          "'${InterestSlabList[i].intrestSlabComposite.mcurcd}' ,"
          "'${InterestSlabList[i].intrestSlabComposite.minteffdt}' ,"
          "${InterestSlabList[i].intrestSlabComposite.msrno} ,"
          "${InterestSlabList[i].mtoamt},"
          "${InterestSlabList[i].mintrate},"
          "'${InterestSlabList[i].mmlastsynsdate}');";
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${InterestSlabMaster}");
      });
    }
  }

  Future createLookupInsert() async {
    //deletSomeUtil();
    var lookupDataServices = new LookupDataServices();
    var db = await _getDb();
    List<LookupMasterBean> lookupMasterList = new List<LookupMasterBean>();
    await AppDatabase.get().deletSomeSyncingActivityFromOmni('Lookup');
    await lookupDataServices.getLookupData().then((onValue) {
      print(onValue.length);
      lookupMasterList = onValue;
    });

    for (int i = 0; i < lookupMasterList.length; i++) {
      print(lookupMasterList.length.toString() + " lookupMaster");
      print(lookupMasterList[i].mcodedesc.toString() + " mcodedesc");
      print(lookupMasterList[i].lookUpComposite.mcode.toString() + " mcode");
      print(lookupMasterList[i].lookUpComposite.mcodetype.toString() +
          " mcodetype");
      print("field1 value hai  ${lookupMasterList[i].lookUpComposite.mfield1value} ");
      String insertQuery = "INSERT OR REPLACE INTO ${LookupMaster} "
          "(${TablesColumnFile.mcodedesc} ,"
          "${TablesColumnFile.mfield1value} ,"
          "${TablesColumnFile.mcode} ,"
          "${TablesColumnFile.mcodetype} )"
          "VALUES"
          "('${lookupMasterList[i].mcodedesc != null && lookupMasterList[i].mcodedesc != 'null' ? lookupMasterList[i].mcodedesc.trim().replaceAll('\'', "") : ""}' ,"
          "'${lookupMasterList[i].lookUpComposite.mfield1value != null && lookupMasterList[i].lookUpComposite.mfield1value != 'null' ? lookupMasterList[i].lookUpComposite.mfield1value.trim() : ""}' ,"
          "'${lookupMasterList[i].lookUpComposite != null && lookupMasterList[i].lookUpComposite.mcode != null && lookupMasterList[i].lookUpComposite.mcode != 'null' ? lookupMasterList[i].lookUpComposite.mcode.trim() : ""}' ,"
          "${lookupMasterList[i].lookUpComposite.mcodetype});";
      print('Insert query ${insertQuery}');

      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${LookupMaster}");
      });
    }
  }

  Future createSubLookupInsert() async {
    var syncingSubLookupDataServices = new SyncingSubLookupDataServices();
    var db = await _getDb();
    List<LookupMasterBean> lookupMasterList = new List<LookupMasterBean>();
    await AppDatabase.get().deletSomeSyncingActivityFromOmni('SubLookup');
    await syncingSubLookupDataServices.getSubLookupData().then((onValue) {
      print(onValue.length);
      lookupMasterList = onValue;
    });

    for (int i = 0; i < lookupMasterList.length; i++) {
      print(lookupMasterList.length.toString() + " SublookupMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${SubLookupMaster} "
          "(${TablesColumnFile.mcodedesc} ,"
          "${TablesColumnFile.mfield1value} ,"
          "${TablesColumnFile.mcode} ,"
          "${TablesColumnFile.mcodetype} )"
          "VALUES"
          "('${lookupMasterList[i].mcodedesc != null && lookupMasterList[i].mcodedesc != 'null' ? lookupMasterList[i].mcodedesc.trim().replaceAll('\'', "") : ""}' ,"
          "'${lookupMasterList[i].lookUpComposite.mfield1value != null && lookupMasterList[i].lookUpComposite.mfield1value != null && lookupMasterList[i].lookUpComposite.mfield1value != 'null' ? lookupMasterList[i].lookUpComposite.mfield1value : "0"}' ,"
          "'${lookupMasterList[i].lookUpComposite != null && lookupMasterList[i].lookUpComposite.mcode != null && lookupMasterList[i].lookUpComposite.mcode != 'null' ? lookupMasterList[i].lookUpComposite.mcode.trim() : ""}' ,"
          "${lookupMasterList[i].lookUpComposite.mcodetype});";

      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${SubLookupMaster}");
      });
    }
  }

  Future createTDRoiInsert(int branch) async {
    var syncingTDRoiDataServices = new SyncingTDRoiDataServices();
    var syncingTDOffsetInterestMasterServices =
    new SyncingTDOffsetInterestMasterServices();
    var syncingTDParameter = new SyncingTDParameterService();

    var db = await _getDb();
    // List<LookupMasterBean> lookupMasterList = new List<LookupMasterBean>();
    List<TDOffsetInterestMasterBean> TDOffsetInterestMasterList =
    new List<TDOffsetInterestMasterBean>();
    List<ProductwiseInterestTableBean> ProductwiseInterestTableList =
    new List<ProductwiseInterestTableBean>();
    List<TDParameterBean> tdParameterBeanList = new List<TDParameterBean>();

    try {
      await syncingTDOffsetInterestMasterServices
          .getTDOffsetInterestMasterData(branch)
          .then((onValue) async {
        //TODO for TD specific LBRCode
        print(onValue.length);
        if (onValue != null) {
          await AppDatabase.get()
              .deletSomeSyncingActivityFromOmni('TD_Offset_Interest_Master');
        }
        TDOffsetInterestMasterList = onValue;
      });
    } catch (_) {}

    try {
      await syncingTDRoiDataServices
          .getProductwiseInterestTablePrimaryData(branch)
          .then((onValue) async {
        //TODO for TD Speicific  LBRCode
        print(onValue.length);
        if (onValue != null) {
          await AppDatabase.get().deletSomeSyncingActivityFromOmni(
              'TD_Productwise_interest_table');
        }
        ProductwiseInterestTableList = onValue;
      });
    } catch (_) {}

    try {
      await syncingTDParameter.getTDParameterData(branch).then((onValue) async {
        //TODO for TD Speicific  LBRCode
        print(onValue.length);
        if (onValue != null) {
          await AppDatabase.get()
              .deletSomeSyncingActivityFromOmni('TD_Parameter_Master');
        }
        tdParameterBeanList = onValue;
      });
    } catch (_) {}

    // Inserting datea in TDProductwiseInterestTable

    for (int i = 0; i < ProductwiseInterestTableList.length; i++) {
      print(ProductwiseInterestTableList.length.toString() +
          " TDProductwiseInterestTable");
      String insertQuery =
          "INSERT OR REPLACE INTO ${TDProductwiseInterestTable} "
          "(${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mcurcd} ,"
          "${TablesColumnFile.minteffdt} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mdays} ,"
          "${TablesColumnFile.mmonths} ,"
          "${TablesColumnFile.mintrate} ,"
          "${TablesColumnFile.mpenalintrate} ,"
          "${TablesColumnFile.mlowertollimit} ,"
          "${TablesColumnFile.muppertollimit} ,"
          "${TablesColumnFile.mminrate} ,"
          "${TablesColumnFile.mmaxrate} ,"
          "${TablesColumnFile.mfrommonths} ,"
          "${TablesColumnFile.mtomonths} ,"
          "${TablesColumnFile.mmlastsynsdate} )"
          "VALUES"
          "("
          "${ProductwiseInterestTableList[i].tdIntrestSlabComposite.mprdcd},"
          "'${ProductwiseInterestTableList[i].tdIntrestSlabComposite.mcurcd}',"
          "'${ProductwiseInterestTableList[i].tdIntrestSlabComposite.minteffdt}',"
          "${ProductwiseInterestTableList[i].tdIntrestSlabComposite.msrno},"
          "${ProductwiseInterestTableList[i].mdays},"
          "${ProductwiseInterestTableList[i].mmonths},"
          "${ProductwiseInterestTableList[i].mintrate},"
          "${ProductwiseInterestTableList[i].mpenalintrate},"
          "${ProductwiseInterestTableList[i].mlowertollimit},"
          "${ProductwiseInterestTableList[i].muppertollimit},"
          "${ProductwiseInterestTableList[i].mminrate},"
          "${ProductwiseInterestTableList[i].mmaxrate},"
          "${ProductwiseInterestTableList[i].mfrommonths},"
          "${ProductwiseInterestTableList[i].mtomonths},"
          "'${ProductwiseInterestTableList[i].mmlastsynsdate}'"
          "); ";

      print(insertQuery);
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() +
            " id after insert in ${TDProductwiseInterestTable}");
      });
    }

    // Inserting datea in Offset Interest Master - for TD
    for (int i = 0; i < TDOffsetInterestMasterList.length; i++) {
      print(TDOffsetInterestMasterList.length.toString() +
          " TDOffsetInterestMaster");
      String insertQuery = "INSERT OR REPLACE INTO ${TDOffsetInterestMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mcurCd} ,"
          "${TablesColumnFile.maccttype} ,"
          "${TablesColumnFile.meffdate} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mdays} ,"
          "${TablesColumnFile.mmonths} ,"
          "${TablesColumnFile.minvamtfrm} ,"
          "${TablesColumnFile.muptoamt} ,"
          "${TablesColumnFile.moffsetintrate} ,"
          "${TablesColumnFile.mlowertollimit} ,"
          "${TablesColumnFile.muppertollimit} ,"
          "${TablesColumnFile.mmlastsynsdate} )"
          "VALUES"
          "("
          "${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.lBrCode},"
          "${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.prdCd},"
          "${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.CurCd},"
          "${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.acctType},"
          "'${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.effDate}' ,"
          "'${TDOffsetInterestMasterList[i].tdOffsetintrestSlabComposite.srNo}' ,"
          "'${TDOffsetInterestMasterList[i].days}' ,"
          "'${TDOffsetInterestMasterList[i].months}' ,"
          "'${TDOffsetInterestMasterList[i].InvAmtFrm}' ,"
          "'${TDOffsetInterestMasterList[i].UptoAmt}' ,"
          "'${TDOffsetInterestMasterList[i].offSetIntRate}' ,"
          "'${TDOffsetInterestMasterList[i].LowerTolLimit}' ,"
          "'${TDOffsetInterestMasterList[i].UpperTolLimit}' ,"
          "${TDOffsetInterestMasterList[i].mmlastsynsdate} "
          "); ";

      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${TDOffsetInterestMaster}");
      });
    }

    for (int i = 0; i < tdParameterBeanList.length; i++) {
      String insertQuery = "INSERT OR REPLACE INTO ${tdParameterMaster} ("
          "${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mdefbatchcd} ,"
          "${TablesColumnFile.mintfreq},"
          "${TablesColumnFile.mmindepamt} ,"
          "${TablesColumnFile.mmaxdepamt} ,"
          "${TablesColumnFile.mperiodtype} ,"
          "${TablesColumnFile.mmaxperiod} ,"
          "${TablesColumnFile.mminperiod} ,"
          "${TablesColumnFile.mnodaysinyear} ,"
          "${TablesColumnFile.mclintcalctype} ,"
          "${TablesColumnFile.mtaxprojection} "
          ") VALUES ("
          "${tdParameterBeanList[i].tdParameterCompositeEntity.mlbrcode} ,"
          "'${tdParameterBeanList[i].tdParameterCompositeEntity.mprdcd}',"
          "'${tdParameterBeanList[i].mdefbatchcd}' ,"
          "'${tdParameterBeanList[i].mintfreq}',"
          "${tdParameterBeanList[i].mmindepamt} ,"
          "${tdParameterBeanList[i].mmaxdepamt} ,"
          "${tdParameterBeanList[i].mperiodtype} ,"
          "${tdParameterBeanList[i].mmaxperiod} ,"
          "${tdParameterBeanList[i].mminperiod} ,"
          "${tdParameterBeanList[i].mnodaysinyear} ,"
          "${tdParameterBeanList[i].mclintcalctype} ,"
          "'${tdParameterBeanList[i].mtaxprojection}'"
          ") ";

      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
        print(id.toString() + " id after insert in ${tdParameterMaster}");
      });
    }
  }

//Customer Formation code start here

  //Create Table LastStyncedDateTime

  Future _createLastSyncedDateTimeMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${lastSyncedDateTimeMaster} ("
        "${TablesColumnFile.id} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.tTabelDesc} TEXT,"
        "${TablesColumnFile.tlastSyncedFromTab} DATETIME,"
        "${TablesColumnFile.tlastSyncedToTab} DATETIME);";
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  //Create Table CustomerMasterBasicsDetails
  Future _createCustomerFoundationMasterDetailsTable(Database db) {
    String tableCreationQuery =
        "CREATE TABLE ${customerFoundationMasterDetails} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mfathertitle} TEXT,"
        "${TablesColumnFile.mfathername} TEXT,"
        "${TablesColumnFile.mspousetitle} TEXT,"
        "${TablesColumnFile.mhusbandname} TEXT,"
        "${TablesColumnFile.mdob} DATETIME,"
        "${TablesColumnFile.mage} INTEGER,"
        "${TablesColumnFile.mbankacno} TEXT,"
        "${TablesColumnFile.mbankacyn} TEXT,"
        "${TablesColumnFile.mbankifsc} TEXT,"
        "${TablesColumnFile.mbanknamelk} TEXT,"
        "${TablesColumnFile.mbankbranch} TEXT,"
        "${TablesColumnFile.mcuststatus} INTEGER,"
        "${TablesColumnFile.mdropoutdate} DATETIME,"
        "${TablesColumnFile.mmobno} TEXT,"
        "${TablesColumnFile.mpanno} INTEGER,"
        "${TablesColumnFile.mpannodesc} TEXT,"
        "${TablesColumnFile.mtdsyn} TEXT,"
        "${TablesColumnFile.mtdsreasoncd} INTEGER,"
        "${TablesColumnFile.mtdsfrm15subdt} DATETIME,"
        "${TablesColumnFile.memailId} TEXT,"
        "${TablesColumnFile.mcustcategory} INTEGER,"
        "${TablesColumnFile.mtier} INTEGER,"
        "${TablesColumnFile.mAdd1} TEXT,"
        "${TablesColumnFile.mAdd2} TEXT,"
        "${TablesColumnFile.mAdd3} TEXT,"
        "${TablesColumnFile.marea} INTEGER,"
        "${TablesColumnFile.mPinCode} TEXT,"
        "${TablesColumnFile.mCounCd} TEXT,"
        "${TablesColumnFile.mCityCd} TEXT, "
        "${TablesColumnFile.mfname} TEXT, "
        "${TablesColumnFile.mmname} TEXT, "
        "${TablesColumnFile.mlname} TEXT, "
        "${TablesColumnFile.mgender} TEXT, "
        "${TablesColumnFile.mrelegion} TEXT, "
        "${TablesColumnFile.mRuralUrban} INTEGER, "
        "${TablesColumnFile.mcaste} TEXT, "
        "${TablesColumnFile.mqualification} TEXT, "
        "${TablesColumnFile.moccupation} INTEGER, "
        "${TablesColumnFile.mLandType} TEXT, "
        "${TablesColumnFile.mmaritialStatus} INTEGER, "
        "${TablesColumnFile.mTypeOfId} INTEGER, "
        "${TablesColumnFile.mIdDesc} TEXT, "
        "${TablesColumnFile.mInsuranceCovYN} TEXT, "
        "${TablesColumnFile.mTypeofCoverage} INTEGER, "
        "${TablesColumnFile.mcreateddt} DATETIME, "
        "${TablesColumnFile.mcreatedby} TEXT, "
        "${TablesColumnFile.mlastupdatedt} DATETIME, "
        "${TablesColumnFile.mlastupdateby} TEXT, "
        "${TablesColumnFile.mgeolocation} TEXT, "
        "${TablesColumnFile.mgeolatd} TEXT, "
        "${TablesColumnFile.mgeologd} TEXT, "
        "${TablesColumnFile.missynctocoresys} INTEGER, "
        "${TablesColumnFile.mlastsynsdate} DATETIME, "
        "${TablesColumnFile.ifYesThen} TEXT,"
        "${TablesColumnFile.mOccBuisness} TEXT,"
        "${TablesColumnFile.mShopName} TEXT,"
        "${TablesColumnFile.mShpAdd} TEXT,"
        "${TablesColumnFile.mYrsInBz} INTEGER,"
        "${TablesColumnFile.mregNum} TEXT,"
    /* "${TablesColumnFile.mid1} TEXT,"
        "${TablesColumnFile.mid2} TEXT,"*/
        "${TablesColumnFile.mhouse} TEXT,"
        "${TablesColumnFile.mAgricultureType} TEXT,"
        "${TablesColumnFile.mIsMbrGrp} INTEGER,"
        "${TablesColumnFile.mLoanAgreed} INTEGER,"
        "${TablesColumnFile.mGend} INTEGER,"
        "${TablesColumnFile.mInsurance} INTEGER,"
    //"${TablesColumnFile.mRegion} INTEGER,"
        "${TablesColumnFile.mConstruct} INTEGER,"
        "${TablesColumnFile.mToilet} INTEGER,"
    /*"${TablesColumnFile.mBankAccYN} INTEGER,"*/
        "${TablesColumnFile.mhousBizSp} INTEGER,"
        "${TablesColumnFile.mBzRegs} INTEGER,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.misCbCheckDone} INTEGER,"
        "${TablesColumnFile.mBzTrnd} INTEGER,"
        "${TablesColumnFile.mcentername} TEXT,"
        "${TablesColumnFile.mgroupname} TEXT,"
        "${TablesColumnFile.mexpsramt} REAL,"
        "${TablesColumnFile.mcbcheckrprtdt} DATETIME,"
        "${TablesColumnFile.motpvrfdno} TEXT,"
        "${TablesColumnFile.mprofileind} TEXT,"
        "${TablesColumnFile.mhusdob} DATETIME, "
        "${TablesColumnFile.mlangofcust} TEXT,"
        "${TablesColumnFile.mmainoccupn} TEXT,"
        "${TablesColumnFile.msuboccupn} TEXT,"
        "${TablesColumnFile.msecoccupatn} INTEGER,"
        "${TablesColumnFile.mmainoccupndesc} TEXT,"
        "${TablesColumnFile.msuboccupndesc} TEXT,"
        "${TablesColumnFile.mcusttype} TEXT,"
        "${TablesColumnFile.mid1placeofissue} TEXT,"
        "${TablesColumnFile.mid1expdate} DATETIME, "
        "${TablesColumnFile.mid1issuedate} DATETIME, "
        "${TablesColumnFile.mid2placeofissue} TEXT ,"
        "${TablesColumnFile.mid2issuedate} DATETIME,"
        "${TablesColumnFile.mid2expdate} DATETIME, "
        "${TablesColumnFile.mdropoutreason} TEXT,"
        "${TablesColumnFile.mmobilelastsynsdate} DATETIME, "
        "${TablesColumnFile.mutils} INTEGER,"
        " ${TablesColumnFile.mrefcenterid} INTEGER,"
        "${TablesColumnFile.trefcenterid} INTEGER,"
        "${TablesColumnFile.mrefgroupid} INTEGER,"
        "${TablesColumnFile.trefgroupid} INTEGER ,"
        "${TablesColumnFile.meducation} TEXT ,"
        "${TablesColumnFile.mmemberno} INTEGER ,"
        "${TablesColumnFile.designation} TEXT ,"
        "${TablesColumnFile.orgName} TEXT ,"
        "${TablesColumnFile.yearsInOrg} TEXT ,"
        "${TablesColumnFile.mismodify} INTEGER ,"
        "${TablesColumnFile.mNoOfRooms} INTEGER ,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno})"
        ");";
    return db.transaction((Transaction txn) async {
      txn.execute(tableCreationQuery);
    });
  }

  //PPI Bean
  Future _createPPIMaster(Database db) {
    String createTable = "CREATE TABLE ${PPIMaster} ("
        "${TablesColumnFile.tPpirefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mPpirefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mitem} TEXT,"
        "${TablesColumnFile.mhaveyn} TEXT,"
        "${TablesColumnFile.mnoofitems} INTEGER,"
        "${TablesColumnFile.mweightage} REAL,"
        "${TablesColumnFile.mquestiontype} TEXT ,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tPpirefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${PPIMaster}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${PPIMaster}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";
    return db.transaction((Transaction txn) {
      txn.execute(createTable);
    });
  }

  //Create Table Address Details

  Future _createCustomerFoundationAddressDetailsBeanTable(Database db) {
    String createTableQuery =
        "CREATE TABLE ${customerFoundationAddressMasterDetails} ("
        "${TablesColumnFile.taddrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.maddressrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.maddrType} INTEGER,"
        "${TablesColumnFile.maddr1} TEXT,"
        "${TablesColumnFile.maddr2} TEXT,"
        "${TablesColumnFile.maddr3} TEXT,"
        "${TablesColumnFile.mpinCd} INTEGER,"
        "${TablesColumnFile.mtel1} TEXT,"
        "${TablesColumnFile.mtel2} TEXT,"
        "${TablesColumnFile.mcityCd} TEXT,"
        "${TablesColumnFile.mfax1} TEXT,"
        "${TablesColumnFile.mfax2} TEXT,"
        "${TablesColumnFile.mcountryCd} TEXT,"
        "${TablesColumnFile.marea} INTEGER,"
        "${TablesColumnFile.mHouseType} INTEGER,"
        "${TablesColumnFile.mRntLeasAmt} REAL,"
        "${TablesColumnFile.mRntLeasDep} REAL,"
        "${TablesColumnFile.mContLeasExp} DATETIME,"
        "${TablesColumnFile.mRoofCond} INTEGER,"
        "${TablesColumnFile.mUtils} INTEGER,"
        "${TablesColumnFile.mAreaType} INTEGER,"
        "${TablesColumnFile.mLandmark} TEXT,"
        "${TablesColumnFile.mstate} TEXT,"
        "${TablesColumnFile.mYearStay} INTEGER,"
        "${TablesColumnFile.mWardNo} TEXT,"
        "${TablesColumnFile.mMobile} TEXT,"
        "${TablesColumnFile.mEmail} TEXT,"
        "${TablesColumnFile.mPattaName} TEXT,"
        "${TablesColumnFile.mRelationship} TEXT,"
        "${TablesColumnFile.mSourceOfDep} INTEGER,"
        "${TablesColumnFile.mInstAmount} REAL,"
        "${TablesColumnFile.mToietYN} TEXT,"
        "${TablesColumnFile.mNoOfRooms} INTEGER,"
        "${TablesColumnFile.mSpouseYearsStay} INTEGER,"
        "${TablesColumnFile.mDistCd} INTEGER,"
        "${TablesColumnFile.mvillage} INTEGER,"
        "${TablesColumnFile.mCookFuel} INTEGER,"
        "${TablesColumnFile.mSecMobile} TEXT,"
        "${TablesColumnFile.mThana} TEXT,"
        "${TablesColumnFile.mPost} TEXT,"
        "${TablesColumnFile.mplacecd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.taddrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  //Create Table FamilyDetails
  Future _createCustomerFoundationFamilyDetailsTable(Database db) {
    String createTableQuery =
        "CREATE TABLE ${customerFoundationFamilyMasterDetails} ("
        "${TablesColumnFile.tfamilyrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mfamilyrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mname} TEXT,"
        "${TablesColumnFile.mnicno} TEXT,"
        "${TablesColumnFile.mdob} DATETIME,"
        "${TablesColumnFile.mage} INTEGER,"
        "${TablesColumnFile.meducation} TEXT,"
        "${TablesColumnFile.mmemberno} TEXT,"
        "${TablesColumnFile.moccuptype} INTEGER,"
        "${TablesColumnFile.mincome} REAL,"
        "${TablesColumnFile.mhealthstatus} INTEGER,"
        "${TablesColumnFile.mrelationwithcust} TEXT,"
        "${TablesColumnFile.maritalstatus} INTEGER,"
        "${TablesColumnFile.mcontrforhouseexp} REAL,"
        "${TablesColumnFile.macidntlinsurance} TEXT,"
        "${TablesColumnFile.mnomineeyn} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tfamilyrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  //Create Table Borrowing Detials

  Future _createCustomerFoundationBorrowingDetailsTable(Database db) {
    String createTableQuery =
        "CREATE TABLE ${customerFoundationBorrowingMasterDetails} ("
        "${TablesColumnFile.tborrowingrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mborrowingrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mnameofborrower} TEXT,"
        "${TablesColumnFile.msource} TEXT,"
        "${TablesColumnFile.mpurpose} TEXT,"
        "${TablesColumnFile.mamount} REAL,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.memiamt} REAL,"
        "${TablesColumnFile.moutstandingamt} REAL,"
        "${TablesColumnFile.mmemberno} TEXT,"
        "${TablesColumnFile.mloancycle} INTEGER,"
        "${TablesColumnFile.mloanDate} DATETIME,"
        "${TablesColumnFile.mrepaymentDate} DATETIME,"
        "${TablesColumnFile.mloanwthUs} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tborrowingrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  // Create Table TERM DEPOSIT MASTER
  Future _createTermDepositMasterTable(Database db) {
    print("ujk's  table >>>>>>>>>");
    String query = "CREATE TABLE ${TermDepositMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mlongname} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.mcertdate} DATETIME,"
        "${TablesColumnFile.mnoinst} INTEGER,"
        "${TablesColumnFile.mnoofmonths} INTEGER,"
        "${TablesColumnFile.mnoofdays} INTEGER,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mmatval} REAL,"
        "${TablesColumnFile.mmatdate} DATETIME,"
        "${TablesColumnFile.mreceiptstatus} INTEGER,"
        "${TablesColumnFile.mlastrepaydate} DATETIME,"
        "${TablesColumnFile.mmainbalfcy} REAL,"
        "${TablesColumnFile.mintprvdamtfcy} REAL,"
        "${TablesColumnFile.mintpaidamtfcy} REAL,"
        "${TablesColumnFile.mtdsamtfcy} REAL,"
        "${TablesColumnFile.mtdsyn} TEXT,"
        "${TablesColumnFile.mmodeofdeposit} TEXT,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mcenterid} INTEGER,"
        "${TablesColumnFile.mgroupcd} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mcrs} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.mmobilelastsynsdate} DATETIME,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.msourceoffunds} INTEGER,"
        "${TablesColumnFile.mnoticetype} INTEGER,"
        "${TablesColumnFile.mbatchcd} TEXT,"
        "${TablesColumnFile.msetno} INTEGER,"
        "${TablesColumnFile.mscrollno} INTEGER,"
        "${TablesColumnFile.moperationdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno}))";
    print("primary of term deposit table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  // Create Table TD PRODUCTWISE INTEREST TABLE
  Future _createTDProductwiseInterestTable(Database db) {
    print("TDProductwiseInterestTable   >>>>>>>>>");
    String query = "CREATE TABLE ${TDProductwiseInterestTable} ("
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mcurcd} TEXT,"
        "${TablesColumnFile.minteffdt} DATETIME,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mdays} INTEGER,"
        "${TablesColumnFile.mmonths} INTEGER,"
        "${TablesColumnFile.mintrate} REAL,"
        "${TablesColumnFile.mpenalintrate} REAL,"
        "${TablesColumnFile.mlowertollimit} REAL,"
        "${TablesColumnFile.muppertollimit} REAL,"
        "${TablesColumnFile.mminrate} REAL,"
        "${TablesColumnFile.mmaxrate} REAL,"
        "${TablesColumnFile.mfrommonths} INTEGER,"
        "${TablesColumnFile.mtomonths} INTEGER,"
        "${TablesColumnFile.mmlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mprdcd}, ${TablesColumnFile.mcurcd}, ${TablesColumnFile.minteffdt},${TablesColumnFile.msrno}))";
    print("primary of TDProductwiseInterestTable");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  // Create Table TD OFFSET INTERES TMASTER

  Future _createTDOffsetInterestMaster(Database db) {
    print("_createTDOffsetInterestMaster   >>>>>>>>>");
    String query = "CREATE TABLE ${TDOffsetInterestMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER ,"
        "${TablesColumnFile.mprdcd} TEXT ,"
        "${TablesColumnFile.mcurCd} TEXT,"
        "${TablesColumnFile.maccttype} INTEGER,"
        "${TablesColumnFile.meffdate} DATETIME,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mdays} INTEGER,"
        "${TablesColumnFile.mmonths} INTEGER,"
        "${TablesColumnFile.minvamtfrm} REAL,"
        "${TablesColumnFile.muptoamt} REAL,"
        "${TablesColumnFile.moffsetintrate} REAL,"
        "${TablesColumnFile.mlowertollimit} REAL,"
        "${TablesColumnFile.muppertollimit} REAL,"
        "${TablesColumnFile.mmlastsynsdate} DATETIME,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile.mprdcd}, ${TablesColumnFile.maccttype}, ${TablesColumnFile.meffdate}))";
    print("primary of TDOffsetInterestMaster");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createCustomerBusinessDetailMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${customerBusinessDetailMaster} ("
        "${TablesColumnFile.tbussdetailsrefno} INTEGER ,"
        "${TablesColumnFile.mbussdetailsrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcusactivitytype} INTEGER,"
        "${TablesColumnFile.mbusinessname} TEXT,"
        "${TablesColumnFile.mbusaddress1} TEXT,"
        "${TablesColumnFile.mbusaddress2} TEXT,"
        "${TablesColumnFile.mbusaddress3} TEXT,"
        "${TablesColumnFile.mbusaddress4} TEXT,"
        "${TablesColumnFile.mbuscity} TEXT,"
        "${TablesColumnFile.mdistcd} INTEGER,"
        "${TablesColumnFile.mbusstate} TEXT,"
        "${TablesColumnFile.mbuscountry} TEXT,"
        "${TablesColumnFile.mbusarea} INTEGER,"
        "${TablesColumnFile.mbusvillage} INTEGER,"
        "${TablesColumnFile.mbuslandmark} TEXT,"
        "${TablesColumnFile.mbuspin} INTEGER,"
        "${TablesColumnFile.mbusyrsmnths} INTEGER,"
        "${TablesColumnFile.mregisteredyn} TEXT,"
        "${TablesColumnFile.mregistrationno} TEXT,"
        "${TablesColumnFile.mbusothtomanageabsyn} TEXT,"
        "${TablesColumnFile.mbusothmanagername} TEXT,"
        "${TablesColumnFile.mbusothmanagerrel} INTEGER,"
        "${TablesColumnFile.mbusmonthlyincome} REAL,"
        "${TablesColumnFile.mbusseasonalityjan} TEXT,"
        "${TablesColumnFile.mbusseasonalityfeb} TEXT,"
        "${TablesColumnFile.mbusseasonalitymar} TEXT,"
        "${TablesColumnFile.mbusseasonalityapr} TEXT,"
        "${TablesColumnFile.mbusseasonalitymay} TEXT,"
        "${TablesColumnFile.mbusseasonalityjun} TEXT,"
        "${TablesColumnFile.mbusseasonalityjul} TEXT,"
        "${TablesColumnFile.mbusseasonalityaug} TEXT,"
        "${TablesColumnFile.mbusseasonalitysep} TEXT,"
        "${TablesColumnFile.mbusseasonalityoct} TEXT,"
        "${TablesColumnFile.mbusseasonalitynov} TEXT,"
        "${TablesColumnFile.mbusseasonalitydec} TEXT,"
        "${TablesColumnFile.mbushighsales} REAL,"
        "${TablesColumnFile.mbusmediumsales} REAL,"
        "${TablesColumnFile.mbuslowsales} REAL,"
        "${TablesColumnFile.mbushighincome} REAL,"
        "${TablesColumnFile.mbusmediumincom} REAL,"
        "${TablesColumnFile.mbuslowincome} REAL,"
        "${TablesColumnFile.mbusmonthlytotaleval} REAL,"
        "${TablesColumnFile.mbusmonthlytotalverif} REAL,"
        "${TablesColumnFile.mbusincludesurcalcyn} TEXT,"
        "${TablesColumnFile.mbusnhousesameplaceyn} TEXT,"
        "${TablesColumnFile.mbusinesstrend} TEXT,"
        "${TablesColumnFile.mmonthlyincome} REAL,"
        "${TablesColumnFile.mtotalmonthlyincome} REAL,"
        "${TablesColumnFile.mbusinessexpense} REAL,"
        "${TablesColumnFile.mhousehldexpense} REAL,"
        "${TablesColumnFile.mmonthlyemi} REAL,"
        "${TablesColumnFile.mincomeemiratio} REAL,"
        "${TablesColumnFile.mnetamount} REAL,"
        "${TablesColumnFile.mpercentage} REAL,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tbussdetailsrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  //Create Table ImagesMaster
  Future _createImageMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${imageMaster} ("
          "${TablesColumnFile.tImgrefno} INTEGER ,"
          "${TablesColumnFile.trefno} INTEGER,"
          "${TablesColumnFile.mImgrefno} INTEGER,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.imageType} TEXT,"
          "${TablesColumnFile.imageSubType} TEXT,"
          "${TablesColumnFile.desc} TEXT,"
          "${TablesColumnFile.imageString} TEXT,"
          "${TablesColumnFile.mcustno} INTEGER,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tImgrefno})"
          "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);");
    });
  }

  Future _createCustomerCpvMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${customerCpvMaster} ("
        "${TablesColumnFile.tcpvrefno} INTEGER ,"
        "${TablesColumnFile.mcpvrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.maddmatch} TEXT,"
        "${TablesColumnFile.massetvissibledesc} TEXT,"
        "${TablesColumnFile.massetvissiblecode} TEXT,"
        "${TablesColumnFile.myrsmovdin} TEXT,"
        "${TablesColumnFile.mhouseprptystatus} TEXT,"
        "${TablesColumnFile.mhousestructure} TEXT,"
        "${TablesColumnFile.mhousewall} TEXT,"
        "${TablesColumnFile.mhouseroof} TEXT,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tcpvrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";
    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createBusinessExpenseMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${businessExpenseMaster} ("
        "${TablesColumnFile.tbusinexpendrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mbusinexpenrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mbusinexpntype} TEXT,"
        "${TablesColumnFile.mbusinevaluationamt} REAL,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tbusinexpendrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createHouseExpenseMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${houseExpenseMaster} ("
        "${TablesColumnFile.thoushldexpendrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mhoushldexpenrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mhoushldexpntype} TEXT,"
        "${TablesColumnFile.mhoushldevaluationamt} REAL,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.thoushldexpendrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }

  Future _createAssetDetailMaster(Database db) {
    String createTableQuery = "CREATE TABLE ${assetDetailMaster} ("
        "${TablesColumnFile.tassetdetrefno} INTEGER ,"
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.massetdetrefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mitem} INTEGER,"
        "PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.tassetdetrefno})"
        "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
        "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);";

    return db.transaction((Transaction txn) {
      txn.execute(createTableQuery);
    });
  }
  Future _createCustomerFingerPrintMaster(Database db) {
    return db.transaction((Transaction txn) {
      txn.execute("CREATE TABLE ${customerFingerPrintMaster} ("
          "${TablesColumnFile.timagerefno} INTEGER ,"
          "${TablesColumnFile.trefno} INTEGER,"
          "${TablesColumnFile.mimagerefno} INTEGER,"
          "${TablesColumnFile.mrefno} INTEGER,"
          "${TablesColumnFile.mimagetype} TEXT,"
          "${TablesColumnFile.mimagesubtype} TEXT,"
          "${TablesColumnFile.desc} TEXT,"
          "${TablesColumnFile.mimagestring} TEXT,"
          "${TablesColumnFile.mcustno} INTEGER,"
          " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno},${TablesColumnFile.timagerefno})"
          "FOREIGN KEY(${TablesColumnFile.mrefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.mrefno}) ON DELETE CASCADE,"
          "FOREIGN KEY(${TablesColumnFile.trefno}) REFERENCES ${customerFoundationMasterDetails}(${TablesColumnFile.trefno}) ON DELETE CASCADE);");
    });
  }

  Future updateCgt1QaMaster(
      CheckListCGT1Bean checkCgt1Bean, int idValue) async {
    print("trying toinsert or replace $idValue");
    var db = await _getDb();
    String insertQuery = "INSERT OR REPLACE INTO ${cgt1QaMaster}  "
        "("
        "${TablesColumnFile.tclcgt1refno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mclcgt1refno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mquestionid},"
        "${TablesColumnFile.manschecked}"
        ")"
        "VALUES "
        "("
        "${idValue},"
        "${checkCgt1Bean.mrefno},"
        "${checkCgt1Bean.trefno} ,"
        "${checkCgt1Bean.mclcgt1refno},"
        "'${checkCgt1Bean.mleadsid}' ,"
        "'${checkCgt1Bean.mquestionid}' ,"
        "${checkCgt1Bean.manschecked} "
        "); ";
    print(insertQuery);
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }

  Future updateCgt2QaMaster(
      CheckListCGT2Bean checkCgt2Bean, int idValue) async {
    print("trying toinsert or replace $idValue");
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${cgt2QaMaster}  "
        "("
        "${TablesColumnFile.tclcgt2refno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mclcgt2refno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mquestionid},"
        "${TablesColumnFile.manschecked}"
        ")"
        "VALUES "
        "("
        "${idValue},"
        "${checkCgt2Bean.mrefno},"
        "${checkCgt2Bean.trefno} ,"
        "${checkCgt2Bean.mclcgt2refno},"
        "'${checkCgt2Bean.mtabletleadid}' ,"
        "'${checkCgt2Bean.mquestionid}' ,"
        "${checkCgt2Bean.manschecked} "
        "); ";

    print("insert qery in cgt2 questio list  ${insertQuery}");
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }

  Future updateGrtQaMaster(CheckListGRTBean checkGrtBean, int idValue) async {
    print("trying toinsert or replace $idValue");
    var db = await _getDb();

    print("trying to insert or replace ${grtQaMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${grtQaMaster}  "
        "("
        "${TablesColumnFile.tclgrtrefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mclgrtrefno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mquestionid},"
        "${TablesColumnFile.manschecked}"
        ")"
        "VALUES "
        "("
        "${idValue},"
        "${checkGrtBean.mrefno},"
        "${checkGrtBean.trefno},"
        "${checkGrtBean.mclgrtrefno},"
        "'${checkGrtBean.mleadsid}' ,"
        "'${checkGrtBean.mquestionid}' ,"
        "${checkGrtBean.manschecked} "
        "); ";
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }

  //CGT insert
  //search
  Future updateCGT1Master(CGT1Bean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${CGT1Master}  "
        "("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mcgt1doneby},"
        "${TablesColumnFile.mstarttime},"
        "${TablesColumnFile.mendtime},"
        "${TablesColumnFile.mroutefrom},"
        "${TablesColumnFile.mrouteto},"
        "${TablesColumnFile.mremark},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate}"
        ")"
        "VALUES "
        "("
        "${bean.trefno},"
        "${bean.mrefno},"
        "${bean.loantrefno},"
        "${bean.loanmrefno},"
        "'${bean.mleadsid}',"
        "'${bean.mcgt1doneby}',"
        "'${bean.mstarttime}',"
        "'${bean.mendtime}',"
        "'${bean.mroutefrom}',"
        "'${bean.mrouteto}',"
        "'${bean.mremarks}',"
        "'${bean.mcreateddt}',"
        "'${bean.mcreatedby}',"
        "'${bean.mlastupdatedt}',"
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}',"
        "'${bean.mgeolatd}',"
        "'${bean.mgeologd}',"
        "${bean.missynctocoresys},"
        "'${bean.mlastsynsdate}'"
        "); ";
    print("Ban cgt1 " + insertQuery.toString());

    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
    });
  }

  Future updateCGT2Master(CGT2Bean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${CGT2Master}  "
        "("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mcgt2doneby},"
        "${TablesColumnFile.mstarttime},"
        "${TablesColumnFile.mendtime},"
        "${TablesColumnFile.mroutefrom},"
        "${TablesColumnFile.mrouteto},"
        "${TablesColumnFile.mremark},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate}"
        ")"
        "VALUES "
        "("
        "${bean.trefno},"
        "${bean.mrefno},"
        "${bean.loantrefno},"
        "${bean.loanmrefno},"
        "'${bean.mleadsid}',"
        "'${bean.mcgt2doneby}',"
        "'${bean.mstarttime}',"
        "'${bean.mendtime}',"
        "'${bean.mroutefrom}',"
        "'${bean.mrouteto}',"
        "'${bean.mremarks}',"
        "'${bean.mcreateddt}',"
        "'${bean.mcreatedby}',"
        "'${bean.mlastupdatedt}',"
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}',"
        "'${bean.mgeolatd}',"
        "'${bean.mgeologd}',"
        "${bean.missynctocoresys},"
        "'${bean.mlastsynsdate}'"
        "); ";
    print("Ban cgt1 " + insertQuery.toString());

    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${CGT2Master}");
    });
  }

  Future updateGRTMaster(GRTBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${GRTMaster}  "
        "("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mgrtdoneby},"
        "${TablesColumnFile.mstarttime},"
        "${TablesColumnFile.mendtime},"
        "${TablesColumnFile.mroutefrom},"
        "${TablesColumnFile.mrouteto},"
        "${TablesColumnFile.mremark},"
        "${TablesColumnFile.midtype1status},"
        "${TablesColumnFile.midtype2status},"
        "${TablesColumnFile.midtype3status},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mhouseVerifiImg}"
        ")"
        "VALUES "
        "("
        "${bean.trefno},"
        "${bean.mrefno},"
        "${bean.loantrefno},"
        "${bean.loanmrefno},"
        "'${bean.mleadsid}',"
        "'${bean.mgrtdoneby}',"
        "'${bean.mstarttime}',"
        "'${bean.mendtime}',"
        "'${bean.mroutefrom}',"
        "'${bean.mrouteto}',"
        "'${bean.mremarks}',"
        "'${bean.midtype1status}',"
        "'${bean.midtype2status}',"
        "'${bean.midtype3status}',"
        "'${bean.mcreateddt}',"
        "'${bean.mcreatedby}',"
        "'${bean.mlastupdatedt}',"
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}',"
        "'${bean.mgeolatd}',"
        "'${bean.mgeologd}',"
        "${bean.missynctocoresys},"
        "'${bean.mlastsynsdate}',"
        "'${bean.mhouseVerifiImg}'"
        "); ";
    print("insert query is" + insertQuery);
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${GRTMaster}");
    });
  }

  //Grt ends

  //select customer IsDataSynced
  Future<List<CreditBereauBean>> selectProspectListIsDataSynced(
      DateTime lastSyncFromTab) async {
    String selectQueryIsDataSynced = lastSyncFromTab != null &&
        !(lastSyncFromTab == "null")
        ? "SELECT * FROM ${creditBereauMaster}  WHERE ${TablesColumnFile.mcreateddt}  > '${lastSyncFromTab}' OR ${TablesColumnFile.mlastupdatedt}  > '${lastSyncFromTab}'"
        : "SELECT * FROM ${creditBereauMaster}";

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

  Future<CbResultBean> getCreditBereauResultIsSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();
    CbResultBean bean;

    String selectQuery =
        "SELECT * FROM ${creditBereauResultMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${creditBereauResultMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    try {
      print("Credit Bereau result me");
      if (result.isNotEmpty) {
        bean = new CbResultBean();
        bean = bindCreditBereauResultBean(result[0]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    print("returned value is $bean");
    return bean;
  }

  //select CBResultLoan IsDataSynced
  Future<List<CbResultBean>> selectCreditBereauLoanListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${creditBereauLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${creditBereauLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<CbResultBean> listbean = new List<CbResultBean>();
    CbResultBean bean;
    try {
      print("Credit Bereau Loan Details Master m");
      for (int i = 0; i < result.length; i++) {
        bean = new CbResultBean();
        bean = bindCreditBereauResultBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<CGT1Bean>> selectCGT1ListNotSynced() async {
    var db = await _getDb();
    CGT1Bean retBean = new CGT1Bean();
    List<CGT1Bean> n = new List<CGT1Bean>();
    var result;

    String selectQueryIsDataSynced = 'SELECT * FROM ${CGT1Master}  WHERE  '
        '${TablesColumnFile.missynctocoresys}  = 0  OR ${TablesColumnFile.missynctocoresys}  IS NULL ';
    result = await db.rawQuery(selectQueryIsDataSynced);

    //try {
    for (int i = 0; i < result.length; i++) {
      print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }
      print(result[i].runtimeType);
      retBean = bindDataCGT1ListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    /* } catch (e) {
      print(e.toString());
    }*/
    return n;
  }

  Future<List<CGT2Bean>> selectCGT2ListNotSynced() async {
    var db = await _getDb();
    CGT2Bean retBean = new CGT2Bean();
    List<CGT2Bean> n = new List<CGT2Bean>();
    var result;
    String selectQueryIsDataSynced =
        " SELECT * FROM ${CGT2Master}  WHERE ${TablesColumnFile.missynctocoresys} = 0 "
        " OR ${TablesColumnFile.missynctocoresys}  IS NULL";
    print(selectQueryIsDataSynced);
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindDataCGT2ListBean(result[i]);
        print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  CGT1Bean bindDataCGT1ListBean(Map<String, dynamic> result) {
    return CGT1Bean.fromMap(result);
  }

  //select CGT2 isSynced0
  Future<List<CGT2Bean>> selectCGT2ListIsDataSynced(int isDatSynced) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${CGT2Master}  WHERE isDataSynced  = $isDatSynced');

    List<CGT2Bean> listbean = new List<CGT2Bean>();
    CGT2Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CGT2Bean();
        bean = bindDataCGT2ListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  CGT2Bean bindDataCGT2ListBean(Map<String, dynamic> result) {
    return CGT2Bean.fromMap(result);
  }

  Future<List<GRTBean>> selectGRTListIsDataSynced() async {
    var db = await _getDb();
    GRTBean retBean = new GRTBean();
    List<GRTBean> n = new List<GRTBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced =
        'SELECT * FROM ${GRTMaster}  WHERE ${TablesColumnFile.missynctocoresys}  = 0 '
        ' OR ${TablesColumnFile.missynctocoresys}  IS NULL ';
    result = await db.rawQuery(selectQueryIsDataSynced);

    // try {
    for (int i = 0; i < result.length; i++) {
      print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }
      print(result[i].runtimeType);
      retBean = bindDataGRTListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }*/
    return n;
  }

  GRTBean bindDataGRTListBean(Map<String, dynamic> result) {
    return GRTBean.fromMap(result);
  }

  //select checklistData
  /*Future<List<CheckListBean>> selectCheckListIsDataSynced(
      int isDatSynced,String loanNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${checkListMaster}  WHERE isDataSynced  = $isDatSynced AND ${TablesColumnFile.loanNumber} = $loanNumber');

    List<CheckListBean> listbean = new List<CheckListBean>();
    CheckListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListBean();
        bean = bindDataCheckListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  CheckListBean bindDataCheckListBean(Map<String, dynamic> result) {
    return CheckListBean.fromMap(result);
  }*/

  Future<List<CheckListCGT1Bean>> selectCheckListCGT1IsDataSynced(
      int trefno, int mrefno) async {
    var db = await _getDb();
    String selQuery =
        'SELECT * FROM ${cgt1QaMaster}  WHERE ${TablesColumnFile.trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno';
    //String selQuery = 'SELECT * FROM ${cgt1QaMaster}';
    var result = await db.rawQuery(selQuery);
    List<CheckListCGT1Bean> cgt1listbean = new List<CheckListCGT1Bean>();
    CheckListCGT1Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListCGT1Bean();
        bean = bindDataCheckListCGT1Bean(result[i]);
        cgt1listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return cgt1listbean;
  }

  CheckListCGT1Bean bindDataCheckListCGT1Bean(Map<String, dynamic> result) {
    return CheckListCGT1Bean.fromMap(result);
  }

  Future<List<CheckListCGT2Bean>> selectCheckListCGT2IsDataSynced(
      int trefno, int mrefno) async {
    var db = await _getDb();
    String selQuery =
        'SELECT * FROM ${cgt2QaMaster}  WHERE ${TablesColumnFile.trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno';

    var result = await db.rawQuery(selQuery);
    List<CheckListCGT2Bean> cgt2listbean = new List<CheckListCGT2Bean>();
    CheckListCGT2Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListCGT2Bean();
        bean = bindDataCheckListCGT2Bean(result[i]);
        cgt2listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return cgt2listbean;
  }

  CheckListCGT2Bean bindDataCheckListCGT2Bean(Map<String, dynamic> result) {
    return CheckListCGT2Bean.fromMap(result);
  }

  Future<List<CheckListGRTBean>> selectCheckListGRTIsDataSynced(
      int trefno, int mrefno) async {
    var db = await _getDb();
    String selQuery =
        'SELECT * FROM ${grtQaMaster}  WHERE ${TablesColumnFile.trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno';
    //String selQuery = 'SELECT * FROM ${grtQaMaster}';
    var result = await db.rawQuery(selQuery);
    List<CheckListGRTBean> grtlistbean = new List<CheckListGRTBean>();
    CheckListGRTBean bean;
    print("nksjkjsldjsnldsn" + result.toString());
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CheckListGRTBean();
        bean = bindDataCheckListGRTBean(result[i]);
        grtlistbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return grtlistbean;
  }
  CheckListGRTBean bindDataCheckListGRTBean(Map<String, dynamic> result) {
    return CheckListGRTBean.fromMap(result);
  }

  //Generate Customer Number of Tab
  Future<int> generateCustomerNumber() async {
    print("trying to select last row  ${customerFoundationMasterDetails}");
    String insertQuery = "SELECT *"
        "FROM    ${customerFoundationMasterDetails}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${customerFoundationMasterDetails});";
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

  Future<int> generateAccountNumber() async {
    print("trying to select last row  ${savingsMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${savingsMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${savingsMaster});";
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

  Future<int> generateTrefNumber() async {
    print("trying to select last row  ${savingsCollectionMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${savingsCollectionMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${savingsCollectionMaster});";
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

  //Insert Customer Basics details
  Future<int> updateCustomerFoundationMasterDetailsTable(
      CustomerListBean bean, bool fromServer) async {
    /* bean.CreatedDate = DateTime.now();
       bean.UpdatedatedDate = DateTime.now();*/
    List<int> retValue;
    String insertQuery =
        "INSERT OR REPLACE INTO ${customerFoundationMasterDetails} "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupcd} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mlongname} ,"
        "${TablesColumnFile.mfathertitle} ,"
        "${TablesColumnFile.mfathername} ,"
        "${TablesColumnFile.mspousetitle} ,"
        "${TablesColumnFile.mhusbandname} ,"
        "${TablesColumnFile.mdob} ,"
        "${TablesColumnFile.mage} ,"
        "${TablesColumnFile.mbankacno} ,"
        "${TablesColumnFile.mbankacyn} ,"
        "${TablesColumnFile.mbankifsc} ,"
        "${TablesColumnFile.mbanknamelk} ,"
        "${TablesColumnFile.mbankbranch} ,"
        "${TablesColumnFile.mcuststatus} ,"
        "${TablesColumnFile.mdropoutdate} ,"
        "${TablesColumnFile.mmobno} ,"
        "${TablesColumnFile.mpanno} ,"
        "${TablesColumnFile.mpannodesc} ,"
        "${TablesColumnFile.mtdsyn} ,"
        "${TablesColumnFile.mtdsreasoncd} ,"
        "${TablesColumnFile.mtdsfrm15subdt} ,"
        "${TablesColumnFile.memailId} ,"
        "${TablesColumnFile.mcustcategory} ,"
        "${TablesColumnFile.mtier} ,"
        "${TablesColumnFile.mAdd1} ,"
        "${TablesColumnFile.mAdd2} ,"
        "${TablesColumnFile.mAdd3} ,"
        "${TablesColumnFile.marea} ,"
        "${TablesColumnFile.mPinCode} ,"
        "${TablesColumnFile.mCounCd} ,"
        "${TablesColumnFile.mCityCd} , "
        "${TablesColumnFile.mfname} , "
        "${TablesColumnFile.mmname} , "
        "${TablesColumnFile.mlname} , "
        "${TablesColumnFile.mgender} , "
        "${TablesColumnFile.mrelegion} , "
        "${TablesColumnFile.mRuralUrban} , "
        "${TablesColumnFile.mcaste} , "
        "${TablesColumnFile.mqualification} , "
        "${TablesColumnFile.moccupation} , "
        "${TablesColumnFile.mLandType} , "
        "${TablesColumnFile.mmaritialStatus} , "
        "${TablesColumnFile.mTypeOfId} , "
        "${TablesColumnFile.mIdDesc} , "
        "${TablesColumnFile.mInsuranceCovYN} , "
        "${TablesColumnFile.mTypeofCoverage} , "
        "${TablesColumnFile.mcreateddt} , "
        "${TablesColumnFile.mcreatedby} , "
    //"${fromServer == true ? TablesColumnFile.mlastupdatedt + "," : ""}  "
        "${TablesColumnFile.mlastupdatedt} , "
        "${TablesColumnFile.mlastupdateby} , "
        "${TablesColumnFile.mgeolocation} , "
        "${TablesColumnFile.mgeolatd} , "
        "${TablesColumnFile.mgeologd} , "
        "${TablesColumnFile.missynctocoresys} , "
        "${TablesColumnFile.ifYesThen},"
        "${TablesColumnFile.mOccBuisness},"
        "${TablesColumnFile.mShopName},"
        "${TablesColumnFile.mShpAdd},"
        "${TablesColumnFile.mYrsInBz},"
        "${TablesColumnFile.mregNum},"
    /*"${TablesColumnFile.mid1},"
        "${TablesColumnFile.mid2},"*/
        "${TablesColumnFile.mhouse},"
        "${TablesColumnFile.mAgricultureType},"
        "${TablesColumnFile.mIsMbrGrp},"
        "${TablesColumnFile.mLoanAgreed},"
        "${TablesColumnFile.mGend},"
        "${TablesColumnFile.mInsurance},"
    //"${TablesColumnFile.mRegion},"
        "${TablesColumnFile.mConstruct},"
        "${TablesColumnFile.mToilet},"
    /*"${TablesColumnFile.mBankAccYN},"*/
        "${TablesColumnFile.mhousBizSp},"
        "${TablesColumnFile.mBzRegs},"
        "${TablesColumnFile.mBzTrnd},"
        "${TablesColumnFile.mcentername},"
        "${TablesColumnFile.mgroupname},"
        "${TablesColumnFile.misCbCheckDone},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mexpsramt}, "
        "${TablesColumnFile.mcbcheckrprtdt} , "
        "${TablesColumnFile.motpvrfdno}, "
        "${TablesColumnFile.mprofileind},"
        "${TablesColumnFile.mhusdob},"
        "${TablesColumnFile.mlangofcust},"
        "${TablesColumnFile.mmainoccupn},"
        "${TablesColumnFile.msuboccupn},"
        "${TablesColumnFile.msecoccupatn},"
        "${TablesColumnFile.mmainoccupndesc},"
        "${TablesColumnFile.msuboccupndesc},"
        "${TablesColumnFile.mid1placeofissue},"
        "${TablesColumnFile.mid1expdate},"
        "${TablesColumnFile.mid1issuedate},"
        "${TablesColumnFile.mid2placeofissue},"
        "${TablesColumnFile.mid2issuedate},"
        "${TablesColumnFile.mid2expdate},"
        "${TablesColumnFile.mcusttype},"
        "${TablesColumnFile.mdropoutreason},"
        "${TablesColumnFile.mmobilelastsynsdate},"
        "${TablesColumnFile.mutils},"
        "${TablesColumnFile.mrefcenterid} ,"
        "${TablesColumnFile.trefcenterid} ,"
        "${TablesColumnFile.mrefgroupid} ,"
        "${TablesColumnFile.trefgroupid}, "
        "${TablesColumnFile.meducation}, "
        "${TablesColumnFile.mmemberno}, "
        "${TablesColumnFile.designation} ,"
        "${TablesColumnFile.orgName}, "
        "${TablesColumnFile.yearsInOrg} ,"
        "${TablesColumnFile.mismodify} ,"
        "${TablesColumnFile.mNoOfRooms} "
        ")"
        "VALUES"
        "(${bean.trefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "${bean.mlbrcode} ,"
        "${bean.mcenterid} ,"
        "${bean.mgroupcd} ,"
        "'${bean.mnametitle}' ,"
        "'${bean.mlongname}' ,"
        "'${bean.mfathertitle}' ,"
        "'${bean.mfathername}' ,"
        "'${bean.mspousetitle}' ,"
        "'${bean.mhusbandname}' ,"
        "'${bean.mdob}' ,"
        "${bean.mage} ,"
        "'${bean.mbankacno}' ,"
        "'${bean.mbankacyn}' ,"
        "'${bean.mbankifsc}' ,"
        "'${bean.mbanknamelk}' ,"
        "'${bean.mbankbranch}' ,"
        "${bean.mcuststatus} ,"
        "'${bean.mdropoutdate}' ,"
        "'${bean.mmobno}' ,"
        "${bean.mpanno} ,"
        "'${bean.mpannodesc}' ,"
        "'${bean.mtdsyn}' ,"
        "${bean.mtdsreasoncd} ,"
        "'${bean.mtdsfrm15subdt}' ,"
        "'${bean.memailId}',"
        "${bean.mcustcategory} ,"
        "${bean.mtier} ,"
        "'${bean.mAdd1}' ,"
        "'${bean.mAdd2}' ,"
        "'${bean.mAdd3}' ,"
        "${bean.mArea} ,"
        "'${bean.mPinCode}' ,"
        "'${bean.mCounCd}' ,"
        "'${bean.mCityCd}' ,"
        "'${bean.mfname}' ,"
        "'${bean.mmname}' ,"
        "'${bean.mlname}' ,"
        "'${bean.mgender}' ,"
        "'${bean.mrelegion}' ,"
        "${bean.mRuralUrban} ,"
        "'${bean.mcaste}' ,"
        "'${bean.mqualification}' ,"
        "${bean.moccupation} ,"
        "'${bean.mLandType}' ,"
        "${bean.mmaritialStatus} ,"
        "${bean.mTypeOfId} ,"
        "'${bean.mIdDesc}' ,"
        "'${bean.mInsuranceCovYN}' ,"
        "${bean.mTypeofCoverage} ,"
        "'${bean.mcreateddt}' ,"
        "'${bean.mcreatedby}' ,"
        "'${bean.mlastupdatedt}' ,"
    /*"${fromServer == true
        ? "'" + bean.mlastupdatedt.toString() + "',"
        : ""} "*/
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}' ,"
        "'${bean.mgeolatd}' ,"
        "'${bean.mgeologd}' ,"
        "${bean.missynctocoresys} ,"
        " '${bean.ifYesThen}' , "
        " '${bean.mOccBuisness}' , "
        " '${bean.mShopName}' , "
        " '${bean.mShpAdd}' , "
        "${bean.mYrsInBz}, "
        " '${bean.mregNum}' , "
    /*" '${bean.mid1}' , "
        " '${bean.mid2}' , "*/
        " '${bean.mHouse}' , "
        " '${bean.mAgricultureType}' , "
        "${bean.mIsMbrGrp} , "
        "${bean.mLoanAgreed} , "
        "${bean.mGend} , "
        "${bean.mInsurance} , "
    //"${bean.mRegion} , "
        "${bean.mConstruct} , "
        "${bean.mToilet} , "
    /*"${bean.mBankAccYN} , "*/
        "${bean.mhousBizSp} , "
        "${bean.mBzRegs} , "
        "${bean.mBzTrnd}, "
        "'${bean.mcentername}',"
        "'${bean.mgroupname}',"
        "${bean.misCbCheckDone}, "
        "'${bean.merrormessage}',"
        "'${bean.mlastsynsdate}',"
        "${bean.mexpsramt} , "
        "'${bean.mcbcheckrprtdt}',"
        "'${bean.motpvrfdno}', "
        "'${bean.mprofileind}',"
        "'${bean.mhusdob}',"
        "'${bean.mlangofcust}',"
        "'${bean.mmainoccupn}',"
        "'${bean.msuboccupn}',"
        "${bean.msecoccupatn} , "
        "'${bean.mmainoccupndesc}',"
        "'${bean.msuboccupndesc}',"
        "'${bean.mid1placeofissue}',"
        "'${bean.mid1expdate}',"
        "'${bean.mid1issuedate}',"
        "'${bean.mid2placeofissue}',"
        "'${bean.mid2issuedate}',"
        "'${bean.mid2expdate}',"
        "'${bean.mcusttype}',"
        "'${bean.mdropoutreason}',"
        "'${bean.mmobilelastsynsdate}',"
        "${bean.mutils},"
        "${bean.mrefcenterid} ,"
        "${bean.trefcenterid} ,"
        "${bean.mrefgroupid} ,"
        "${bean.trefgroupid}, "
        "'${bean.meducation}',"
        "${bean.mmemberno},"
        "'${bean.designation}',"
        "'${bean.orgName}',"
        "'${bean.yearsInOrg}',"
        "${bean.mismodify} ,"
        "${bean.mnoofrooms} "
        ");";
    print("insert query Customer Formation" + insertQuery);
    int id;
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${customerFoundationMasterDetails}");
    });

    await db.transaction((Transaction txn) async {
      insertQuery = "SELECT last_insert_rowid();";
      var result = await txn.rawQuery(insertQuery);
      print(id.toString() +
          " id after insert in ${customerFoundationMasterDetails}");
      print("value of toooooooo1" + result.toString());
      for (Map<String, dynamic> item in result) {
        retValue = item.values.cast<int>().toList();
      }
    });
    return retValue[0];
  }

/*
  //Generate Family ref Number of Tab
  Future<int> generateFamilyRefNumber() async {
    print(
        "trying to select last row  ${"multiline"}");
    String insertQuery = "SELECT *"
        "FROM    ${customerFoundationFamilyMasterDetails}"
        " WHERE   ${TablesColumnFile.tfamilyrefno} = (SELECT MAX(${TablesColumnFile.tfamilyrefno})  FROM ${customerFoundationFamilyMasterDetails});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.tfamilyrefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }*/

  //Insert Family Basics details
  Future<int> updateCustomerFoundationFamilyDetailsTable(
      FamilyDetailsBean familyDetailsBean) async {
    var db = await _getDb();

    //int tfamilyrefno = await generateFamilyRefNumber();

    String insertQuery =
        "INSERT OR REPLACE INTO ${customerFoundationFamilyMasterDetails} "
        "(${TablesColumnFile.tfamilyrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mfamilyrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mname} ,"
        "${TablesColumnFile.mnicno} ,"
        "${TablesColumnFile.mdob} ,"
        "${TablesColumnFile.mage} ,"
        "${TablesColumnFile.meducation} ,"
        "${TablesColumnFile.mmemberno} ,"
        "${TablesColumnFile.moccuptype} ,"
        "${TablesColumnFile.mincome} ,"
        "${TablesColumnFile.mhealthstatus} ,"
        "${TablesColumnFile.mrelationwithcust} ,"
        "${TablesColumnFile.maritalstatus} ,"
        "${TablesColumnFile.mcontrforhouseexp} ,"
        "${TablesColumnFile.macidntlinsurance} ,"
        "${TablesColumnFile.mnomineeyn} )"
        "VALUES"
        "(${familyDetailsBean.tfamilyrefno} ,"
        "${familyDetailsBean.trefno} ,"
        "${familyDetailsBean.mfamilyrefno} ,"
        "${familyDetailsBean.mrefno} ,"
        "${familyDetailsBean.mcustno} ,"
        "'${familyDetailsBean.mname}' ,"
        "'${familyDetailsBean.mnicno}' ,"
        "'${familyDetailsBean.mdob}' ,"
        "${familyDetailsBean.mage} ,"
        "'${familyDetailsBean.meducation}' ,"
        "'${familyDetailsBean.mmemberno}' ,"
        "${familyDetailsBean.moccuptype} ,"
        "${familyDetailsBean.mincome} ,"
        "${familyDetailsBean.mhealthstatus} ,"
        "'${familyDetailsBean.mrelationwithcust}' ,"
        "${familyDetailsBean.maritalstatus} ,"
        "${familyDetailsBean.mcontrforhouseexp} ,"
        "'${familyDetailsBean.macidntlinsurance}' ,"
        "'${familyDetailsBean.mnomineeyn}');";
    print("insert query is family Details " + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationFamilyMasterDetails}");
    });
    return idAfterInsert;
  }

//Insert Family Basics details List start point
  Future<int> updateCustomerFoundationFamilyDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int custtfamref = 0;
    for (FamilyDetailsBean item in custListBean.familyDetailsList) {
      item.mrefno = custListBean.mrefno;
      custtfamref++;
      item.tfamilyrefno = custtfamref;
      id = await updateCustomerFoundationFamilyDetailsTable(item);
    }
    return id;
  }

/*
  //Generate Address ref Number of Tab
  Future<int> generateAddressRefNumber() async {
    print(
        "trying to select last row  ${"multiline taddrefno"}");
    String insertQuery = "SELECT *"
        "FROM    ${customerFoundationAddressMasterDetails}"
        " WHERE   ${TablesColumnFile.taddrefno} = (SELECT MAX(${TablesColumnFile.taddrefno})  FROM ${customerFoundationAddressMasterDetails});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.taddrefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }*/

  ///Insert Address Basics details
  Future<int> updateCustomerFoundationAddressDetailsBeanTable(
      AddressDetailsBean addressDetailsBean) async {
    var db = await _getDb();
    // int tAddressrefno = await generateAddressRefNumber();

    String insertQuery =
        "INSERT OR REPLACE INTO ${customerFoundationAddressMasterDetails} "
        "(${TablesColumnFile.taddrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.maddressrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.maddrType} ,"
        "${TablesColumnFile.maddr1} ,"
        "${TablesColumnFile.maddr2} ,"
        "${TablesColumnFile.maddr3} ,"
        "${TablesColumnFile.mpinCd} ,"
        "${TablesColumnFile.mtel1} ,"
        "${TablesColumnFile.mtel2} ,"
        "${TablesColumnFile.mcityCd} ,"
        "${TablesColumnFile.mfax1} ,"
        "${TablesColumnFile.mfax2} ,"
        "${TablesColumnFile.mcountryCd} ,"
        "${TablesColumnFile.marea} ,"
        "${TablesColumnFile.mHouseType} ,"
        "${TablesColumnFile.mRntLeasAmt} ,"
        "${TablesColumnFile.mRntLeasDep} ,"
        "${TablesColumnFile.mContLeasExp} ,"
        "${TablesColumnFile.mRoofCond} ,"
        "${TablesColumnFile.mUtils} ,"
        "${TablesColumnFile.mAreaType} ,"
        "${TablesColumnFile.mLandmark} ,"
        "${TablesColumnFile.mstate} ,"
        "${TablesColumnFile.mYearStay} ,"
        "${TablesColumnFile.mWardNo} ,"
        "${TablesColumnFile.mMobile} ,"
        "${TablesColumnFile.mEmail} ,"
        "${TablesColumnFile.mPattaName} ,"
        "${TablesColumnFile.mRelationship} ,"
        "${TablesColumnFile.mSourceOfDep} ,"
        "${TablesColumnFile.mInstAmount} ,"
        "${TablesColumnFile.mToietYN} ,"
        "${TablesColumnFile.mNoOfRooms} ,"
        "${TablesColumnFile.mSpouseYearsStay} ,"
        "${TablesColumnFile.mDistCd} ,"
        "${TablesColumnFile.mvillage} ,"
        "${TablesColumnFile.mCookFuel} ,"
        "${TablesColumnFile.mSecMobile} ,"
        "${TablesColumnFile.mThana},"
        "${TablesColumnFile.mPost},"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mplacecd} )"
        "VALUES"
        "(${addressDetailsBean.taddrefno} ,"
        "${addressDetailsBean.trefno},"
        "${addressDetailsBean.maddressrefno} ,"
        "${addressDetailsBean.mrefno} ,"
        "${addressDetailsBean.mcustno} ,"
        "${addressDetailsBean.maddrType} ,"
        "'${addressDetailsBean.maddr1}' ,"
        "'${addressDetailsBean.maddr2}' ,"
        "'${addressDetailsBean.maddr3}' ,"
        "${addressDetailsBean.mpinCd},"
        "'${addressDetailsBean.mtel1}' ,"
        "'${addressDetailsBean.mtel2}' ,"
        "'${addressDetailsBean.mcityCd}' ,"
        "'${addressDetailsBean.mfax1}',"
        "'${addressDetailsBean.mfax2}' ,"
        "'${addressDetailsBean.mcountryCd}' ,"
        "${addressDetailsBean.marea} ,"
        "${addressDetailsBean.mHouseType} ,"
        "${addressDetailsBean.mRntLeasAmt} ,"
        "${addressDetailsBean.mRntLeasDep} ,"
        "'${addressDetailsBean.mContLeasExp}',"
        "${addressDetailsBean.mRoofCond} ,"
        "${addressDetailsBean.mUtils} ,"
        "${addressDetailsBean.mAreaType} ,"
        "'${addressDetailsBean.mLandmark}',"
        "'${addressDetailsBean.mState}' ,"
        "${addressDetailsBean.mYearStay} ,"
        "'${addressDetailsBean.mWardNo}' ,"
        "'${addressDetailsBean.mMobile}' ,"
        "'${addressDetailsBean.mEmail}' ,"
        "'${addressDetailsBean.mPattaName}' ,"
        "'${addressDetailsBean.mRelationship}',"
        "${addressDetailsBean.mSourceOfDep} ,"
        "${addressDetailsBean.mInstAmount} ,"
        "'${addressDetailsBean.mToietYN}' ,"
        "${addressDetailsBean.mNoOfRooms},"
        "${addressDetailsBean.mSpouseYearsStay} ,"
        "${addressDetailsBean.mDistCd} ,"
        "${addressDetailsBean.mvillage} ,"
        "${addressDetailsBean.mCookFuel} ,"
        "'${addressDetailsBean.mSecMobile}',"
        "'${addressDetailsBean.mThana}' ,"
        "'${addressDetailsBean.mPost}' ,"
        "'${addressDetailsBean.mgeologd}' ,"
        "'${addressDetailsBean.mgeolatd}' ,"
        "'${addressDetailsBean.mplacecd}' );";
    print("insert query  address master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationAddressMasterDetails}");
    });
    return idAfterInsert;
  }

//Insert Family Basics details List start point
  Future<int> updateCustomerFoundationAddressDetailsListTable(
      CustomerListBean custListBean, bool fromServer) async {
    int id;
    int taddref = 0;
    for (AddressDetailsBean item in custListBean.addressDetails) {
      if (fromServer) {
        //print("item.mcityCd ${item.mcityCd}");
        item.mplacecd = item.mcityCd;
      }
      item.mrefno = custListBean.mrefno;
      taddref++;
      item.taddrefno = taddref;

      id = await updateCustomerFoundationAddressDetailsBeanTable(item);
    }
    return id;
  }

/*
  //Generate Borrowing ref Number of Tab
  Future<int> generateBorrowingRefNumber() async {
    print(
        "trying to select last row  ${"multiline taddrefno"}");
    String insertQuery = "SELECT *"
        "FROM    ${customerFoundationBorrowingMasterDetails}"
        " WHERE   ${TablesColumnFile.tborrowingrefno} = (SELECT MAX(${TablesColumnFile.tborrowingrefno})  FROM ${customerFoundationBorrowingMasterDetails});";
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.taddrefno];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue + 1;
  }*/

//Insert Borrowing Basics details
  Future<int> updateCustomerFoundationBorrowingDetailsTable(
      BorrowingDetailsBean borrowingDetails) async {
    var db = await _getDb();
    //int tBorrowingrefno = await generateBorrowingRefNumber();

    String insertQuery =
        "INSERT OR REPLACE INTO ${customerFoundationBorrowingMasterDetails} "
        "(${TablesColumnFile.tborrowingrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mborrowingrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mnameofborrower} ,"
        "${TablesColumnFile.msource} ,"
        "${TablesColumnFile.mpurpose} ,"
        "${TablesColumnFile.mamount} ,"
        "${TablesColumnFile.mintrate} ,"
        "${TablesColumnFile.memiamt} ,"
        "${TablesColumnFile.moutstandingamt} ,"
        "${TablesColumnFile.mmemberno} ,"
        "${TablesColumnFile.mloanDate},"
        "${TablesColumnFile.mrepaymentDate},"
        "${TablesColumnFile.mloanwthUs},"
        "${TablesColumnFile.mloancycle} )"
        "VALUES"
        "(${borrowingDetails.tborrowingrefno} ,"
        "${borrowingDetails.trefno},"
        "${borrowingDetails.mborrowingrefno} ,"
        "${borrowingDetails.mrefno} ,"
        "${borrowingDetails.mcustno} ,"
        "'${borrowingDetails.mnameofborrower}' ,"
        "'${borrowingDetails.msource}' ,"
        "'${borrowingDetails.mpurpose}' ,"
        "${borrowingDetails.mamount} ,"
        "${borrowingDetails.mintrate} ,"
        "${borrowingDetails.memiamt} ,"
        "${borrowingDetails.moutstandingamt} ,"
        "'${borrowingDetails.mmemberno}' ,"
        "'${borrowingDetails.mloanDate}' ,"
        "'${borrowingDetails.mrepaymentDate}' ,"
        "'${borrowingDetails.mloanwthUs}',"
        "${borrowingDetails.mloancycle});";

    print("insert query is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationBorrowingMasterDetails}");
    });
    return idAfterInsert;
  }

  //Insert Business Basics details
  Future<int> updateCustomerFoundationBusinessDetailsTable(
      CustomerListBean custBussDetails) async {
    var db = await _getDb();
    String insertQuery =
        "INSERT OR REPLACE INTO ${customerBusinessDetailMaster} "
        "(${TablesColumnFile.tbussdetailsrefno}  ,"
        "${TablesColumnFile.mbussdetailsrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcusactivitytype} ,"
        "${TablesColumnFile.mbusinessname} ,"
        "${TablesColumnFile.mbusaddress1} ,"
        "${TablesColumnFile.mbusaddress2} ,"
        "${TablesColumnFile.mbusaddress3} ,"
        "${TablesColumnFile.mbusaddress4} ,"
        "${TablesColumnFile.mbuscity} ,"
        "${TablesColumnFile.mdistcd} ,"
        "${TablesColumnFile.mbusstate} ,"
        "${TablesColumnFile.mbuscountry} ,"
        "${TablesColumnFile.mbusarea} ,"
        "${TablesColumnFile.mbusvillage} ,"
        "${TablesColumnFile.mbuslandmark} ,"
        "${TablesColumnFile.mbuspin} ,"
        "${TablesColumnFile.mbusyrsmnths} ,"
        "${TablesColumnFile.mregisteredyn} ,"
        "${TablesColumnFile.mregistrationno} ,"
        "${TablesColumnFile.mbusothtomanageabsyn} ,"
        "${TablesColumnFile.mbusothmanagername} ,"
        "${TablesColumnFile.mbusothmanagerrel} ,"
        "${TablesColumnFile.mbusmonthlyincome} ,"
        "${TablesColumnFile.mbusseasonalityjan} ,"
        "${TablesColumnFile.mbusseasonalityfeb} ,"
        "${TablesColumnFile.mbusseasonalitymar} ,"
        "${TablesColumnFile.mbusseasonalityapr} ,"
        "${TablesColumnFile.mbusseasonalitymay} ,"
        "${TablesColumnFile.mbusseasonalityjun} ,"
        "${TablesColumnFile.mbusseasonalityjul} ,"
        "${TablesColumnFile.mbusseasonalityaug} ,"
        "${TablesColumnFile.mbusseasonalitysep} ,"
        "${TablesColumnFile.mbusseasonalityoct} ,"
        "${TablesColumnFile.mbusseasonalitynov} ,"
        "${TablesColumnFile.mbusseasonalitydec} ,"
        "${TablesColumnFile.mbushighsales} ,"
        "${TablesColumnFile.mbusmediumsales} ,"
        "${TablesColumnFile.mbuslowsales} ,"
        "${TablesColumnFile.mbushighincome} ,"
        "${TablesColumnFile.mbusmediumincom} ,"
        "${TablesColumnFile.mbuslowincome} ,"
        "${TablesColumnFile.mbusmonthlytotaleval} ,"
        "${TablesColumnFile.mbusmonthlytotalverif} ,"
        "${TablesColumnFile.mbusincludesurcalcyn} ,"
        "${TablesColumnFile.mbusnhousesameplaceyn} ,"
        "${TablesColumnFile.mbusinesstrend} ,"
        "${TablesColumnFile.mmonthlyincome} ,"
        "${TablesColumnFile.mtotalmonthlyincome} ,"
        "${TablesColumnFile.mbusinessexpense} ,"
        "${TablesColumnFile.mhousehldexpense} ,"
        "${TablesColumnFile.mmonthlyemi} ,"
        "${TablesColumnFile.mincomeemiratio} ,"
        "${TablesColumnFile.mnetamount} ,"
        "${TablesColumnFile.mpercentage} )"
        "VALUES"
        "(${custBussDetails.customerBusinessDetailsBean.tbussdetailsrefno} ,"
        "${custBussDetails.customerBusinessDetailsBean.mbussdetailsrefno},"
        "${custBussDetails.customerBusinessDetailsBean.trefno} ,"
        "${custBussDetails.mrefno} ,"
        "${custBussDetails.customerBusinessDetailsBean.mcusactivitytype} ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbusinessname}' ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbusaddress1}' ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbusaddress2}' ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbusaddress3}' ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbusaddress4}' ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbuscity}' ,"
        "${custBussDetails.customerBusinessDetailsBean.mdistcd} ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbusstate}' ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbuscountry}' ,"
        "${custBussDetails.customerBusinessDetailsBean.mbusarea} ,"
        "${custBussDetails.customerBusinessDetailsBean.mbusvillage} ,"
        "'${custBussDetails.customerBusinessDetailsBean.mbuslandmark}',"
        "${custBussDetails.customerBusinessDetailsBean.mbuspin} ,"
        "${custBussDetails.customerBusinessDetailsBean.mbusyrsmnths},"
        "'${custBussDetails.customerBusinessDetailsBean.mregisteredyn}',"
        "'${custBussDetails.customerBusinessDetailsBean.mregistrationno}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusothtomanageabsyn}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusothmanagername}',"
        "${custBussDetails.customerBusinessDetailsBean.mbusothmanagerrel},"
        "${custBussDetails.customerBusinessDetailsBean.mbusmonthlyincome},"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalityjan}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalityfeb}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalitymar}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalityapr}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalitymay}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalityjun}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalityjul}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalityaug}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalitysep}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalityoct}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalitynov}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusseasonalitydec}',"
        "${custBussDetails.customerBusinessDetailsBean.mbushighsales},"
        "${custBussDetails.customerBusinessDetailsBean.mbusmediumsales},"
        "${custBussDetails.customerBusinessDetailsBean.mbuslowsales},"
        "${custBussDetails.customerBusinessDetailsBean.mbushighincome},"
        "${custBussDetails.customerBusinessDetailsBean.mbusmediumincom},"
        "${custBussDetails.customerBusinessDetailsBean.mbuslowincome},"
        "${custBussDetails.customerBusinessDetailsBean.mbusmonthlytotaleval},"
        "${custBussDetails.customerBusinessDetailsBean.mbusmonthlytotalverif},"
        "'${custBussDetails.customerBusinessDetailsBean.mbusincludesurcalcyn}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusnhousesameplaceyn}',"
        "'${custBussDetails.customerBusinessDetailsBean.mbusinesstrend}',"
        "${custBussDetails.customerBusinessDetailsBean.mmonthlyincome},"
        "${custBussDetails.customerBusinessDetailsBean.mtotalmonthlyincome},"
        "${custBussDetails.customerBusinessDetailsBean.mbusinessexpense},"
        "${custBussDetails.customerBusinessDetailsBean.mhousehldexpense},"
        "${custBussDetails.customerBusinessDetailsBean.mmonthlyemi},"
        "${custBussDetails.customerBusinessDetailsBean.mincomeemiratio},"
        "${custBussDetails.customerBusinessDetailsBean.mnetamount},"
        "${custBussDetails.customerBusinessDetailsBean.mpercentage});";

    print("insert query is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationBorrowingMasterDetails}");
    });
    return idAfterInsert;
  }

  //Insert Business Basics details
  Future<int> updateCustomerCpvTable(CustomerListBean custBussDetails) async {
    var db = await _getDb();
    String insertQuery = "INSERT OR REPLACE INTO ${customerCpvMaster} "
        "(${TablesColumnFile.tcpvrefno}  ,"
        "${TablesColumnFile.mcpvrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.maddmatch} ,"
        "${TablesColumnFile.massetvissibledesc} ,"
        "${TablesColumnFile.massetvissiblecode} ,"
        "${TablesColumnFile.myrsmovdin} ,"
        "${TablesColumnFile.mhouseprptystatus} ,"
        "${TablesColumnFile.mhousestructure} ,"
        "${TablesColumnFile.mhousewall} ,"
        "${TablesColumnFile.mhouseroof} )"
        "VALUES"
        "(${custBussDetails.contactPointVerificationBean.tcpvrefno} ,"
        "${custBussDetails.contactPointVerificationBean.mcpvrefno},"
        "${custBussDetails.contactPointVerificationBean.trefno} ,"
        "${custBussDetails.mrefno} ,"
        "'${custBussDetails.contactPointVerificationBean.maddmatch}' ,"
        "'${custBussDetails.contactPointVerificationBean.massetvissibledesc}' ,"
        "'${custBussDetails.contactPointVerificationBean.massetvissiblecode}' ,"
        "'${custBussDetails.contactPointVerificationBean.myrsmovdin}' ,"
        "'${custBussDetails.contactPointVerificationBean.mhouseprptystatus}' ,"
        "'${custBussDetails.contactPointVerificationBean.mhousestructure}' ,"
        "'${custBussDetails.contactPointVerificationBean.mhousewall}' ,"
        "'${custBussDetails.contactPointVerificationBean.mhouseroof}');";
    print("insert query is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerCpvMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerFoundationBusinessDetailsTableFromMiddleware(
      CustomerListBean custBussDetails) async {
    var db = await _getDb();
    print("details bean of business : " +
        custBussDetails.customerBusinessDetailsBean.toString());
    CustomerBusinessDetailsBean customerBusinessDetailsBean =
        custBussDetails.customerBusinessDetailsBean;
    // customerBusinessDetailsBean.tbussdetailsrefno=1;
    String insertQuery =
        "INSERT OR REPLACE INTO ${customerBusinessDetailMaster} "
        "(${TablesColumnFile.tbussdetailsrefno}  ,"
        "${TablesColumnFile.mbussdetailsrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcusactivitytype} ,"
        "${TablesColumnFile.mbusinessname} ,"
        "${TablesColumnFile.mbusaddress1} ,"
        "${TablesColumnFile.mbusaddress2} ,"
        "${TablesColumnFile.mbusaddress3} ,"
        "${TablesColumnFile.mbusaddress4} ,"
        "${TablesColumnFile.mbuscity} ,"
        "${TablesColumnFile.mdistcd} ,"
        "${TablesColumnFile.mbusstate} ,"
        "${TablesColumnFile.mbuscountry} ,"
        "${TablesColumnFile.mbusarea} ,"
        "${TablesColumnFile.mbusvillage} ,"
        "${TablesColumnFile.mbuslandmark} ,"
        "${TablesColumnFile.mbuspin} ,"
        "${TablesColumnFile.mbusyrsmnths} ,"
        "${TablesColumnFile.mregisteredyn} ,"
        "${TablesColumnFile.mregistrationno} ,"
        "${TablesColumnFile.mbusothtomanageabsyn} ,"
        "${TablesColumnFile.mbusothmanagername} ,"
        "${TablesColumnFile.mbusothmanagerrel} ,"
        "${TablesColumnFile.mbusmonthlyincome} ,"
        "${TablesColumnFile.mbusseasonalityjan} ,"
        "${TablesColumnFile.mbusseasonalityfeb} ,"
        "${TablesColumnFile.mbusseasonalitymar} ,"
        "${TablesColumnFile.mbusseasonalityapr} ,"
        "${TablesColumnFile.mbusseasonalitymay} ,"
        "${TablesColumnFile.mbusseasonalityjun} ,"
        "${TablesColumnFile.mbusseasonalityjul} ,"
        "${TablesColumnFile.mbusseasonalityaug} ,"
        "${TablesColumnFile.mbusseasonalitysep} ,"
        "${TablesColumnFile.mbusseasonalityoct} ,"
        "${TablesColumnFile.mbusseasonalitynov} ,"
        "${TablesColumnFile.mbusseasonalitydec} ,"
        "${TablesColumnFile.mbushighsales} ,"
        "${TablesColumnFile.mbusmediumsales} ,"
        "${TablesColumnFile.mbuslowsales} ,"
        "${TablesColumnFile.mbushighincome} ,"
        "${TablesColumnFile.mbusmediumincom} ,"
        "${TablesColumnFile.mbuslowincome} ,"
        "${TablesColumnFile.mbusmonthlytotaleval} ,"
        "${TablesColumnFile.mbusmonthlytotalverif} ,"
        "${TablesColumnFile.mbusincludesurcalcyn} ,"
        "${TablesColumnFile.mbusnhousesameplaceyn} ,"
        "${TablesColumnFile.mbusinesstrend} )"
        "VALUES"
        "(${1} ,"
        "${customerBusinessDetailsBean.mbussdetailsrefno},"
        "${customerBusinessDetailsBean.trefno} ,"
        "${custBussDetails.mrefno} ,"
        "${customerBusinessDetailsBean.mcusactivitytype} ,"
        "'${customerBusinessDetailsBean.mbusinessname}' ,"
        "'${customerBusinessDetailsBean.mbusaddress1}' ,"
        "'${customerBusinessDetailsBean.mbusaddress2}' ,"
        "'${customerBusinessDetailsBean.mbusaddress3}' ,"
        "'${customerBusinessDetailsBean.mbusaddress4}' ,"
        "'${customerBusinessDetailsBean.mbuscity}' ,"
        "${customerBusinessDetailsBean.mdistcd} ,"
        "'${customerBusinessDetailsBean.mbusstate}' ,"
        "'${customerBusinessDetailsBean.mbuscountry}' ,"
        "${customerBusinessDetailsBean.mbusarea} ,"
        "${customerBusinessDetailsBean.mbusvillage} ,"
        "'${customerBusinessDetailsBean.mbuslandmark}',"
        "${customerBusinessDetailsBean.mbuspin} ,"
        "${customerBusinessDetailsBean.mbusyrsmnths},"
        "'${customerBusinessDetailsBean.mregisteredyn}',"
        "'${customerBusinessDetailsBean.mregistrationno}',"
        "'${customerBusinessDetailsBean.mbusothtomanageabsyn}',"
        "'${customerBusinessDetailsBean.mbusothmanagername}',"
        "${customerBusinessDetailsBean.mbusothmanagerrel},"
        "${customerBusinessDetailsBean.mbusmonthlyincome},"
        "'${customerBusinessDetailsBean.mbusseasonalityjan}',"
        "'${customerBusinessDetailsBean.mbusseasonalityfeb}',"
        "'${customerBusinessDetailsBean.mbusseasonalitymar}',"
        "'${customerBusinessDetailsBean.mbusseasonalityapr}',"
        "'${customerBusinessDetailsBean.mbusseasonalitymay}',"
        "'${customerBusinessDetailsBean.mbusseasonalityjun}',"
        "'${customerBusinessDetailsBean.mbusseasonalityjul}',"
        "'${customerBusinessDetailsBean.mbusseasonalityaug}',"
        "'${customerBusinessDetailsBean.mbusseasonalitysep}',"
        "'${customerBusinessDetailsBean.mbusseasonalityoct}',"
        "'${customerBusinessDetailsBean.mbusseasonalitynov}',"
        "'${customerBusinessDetailsBean.mbusseasonalitydec}',"
        "${customerBusinessDetailsBean.mbushighsales},"
        "${customerBusinessDetailsBean.mbusmediumsales},"
        "${customerBusinessDetailsBean.mbuslowsales},"
        "${customerBusinessDetailsBean.mbushighincome},"
        "${customerBusinessDetailsBean.mbusmediumincom},"
        "${customerBusinessDetailsBean.mbuslowincome},"
        "${customerBusinessDetailsBean.mbusmonthlytotaleval},"
        "${customerBusinessDetailsBean.mbusmonthlytotalverif},"
        "'${customerBusinessDetailsBean.mbusincludesurcalcyn}',"
        "'${customerBusinessDetailsBean.mbusnhousesameplaceyn}',"
        "'${customerBusinessDetailsBean.mbusinesstrend}');";

    print("insert query is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${customerFoundationBorrowingMasterDetails}");
    });
    return idAfterInsert;
  }

  //Insert Borrowing Basics details List start point
  Future<int> updateCustomerFoundationBorrowingDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int custtborref = 0;
    for (BorrowingDetailsBean item in custListBean.borrowingDetailsBean) {
      item.mrefno = custListBean.mrefno;
      custtborref++;
      item.tborrowingrefno = custtborref;
      id = await updateCustomerFoundationBorrowingDetailsTable(item);
    }
    return id;
  }

// business and house hold expense detail
  Future<int> updateCustomerBusinessExpenseBeanTable(
      BusinessExpenditureDetailsBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${businessExpenseMaster} "
        "(${TablesColumnFile.tbusinexpendrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mbusinexpenrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mbusinexpntype} ,"
        "${TablesColumnFile.mbusinevaluationamt} )"
        "VALUES"
        "(${bean.tbusinexpendrefno} ,"
        "${bean.trefno},"
        "${bean.mbusinexpenrefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "'${bean.mbusinexpntype}' ,"
        "${bean.mbusinevaluationamt}  );";
    print("insert query  address master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${businessExpenseMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerBusinessExpenseDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int businexpendrefno = 0;
    for (BusinessExpenditureDetailsBean item
    in custListBean.businessExpendDetailsList) {
      item.mrefno = custListBean.mrefno;
      businexpendrefno++;
      item.tbusinexpendrefno = businexpendrefno;
      id = await updateCustomerBusinessExpenseBeanTable(item);
    }
    return id;
  }

  Future<int> updateCustomerHouseholdExpenseBeanTable(
      HouseholdExpenditureDetailsBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${houseExpenseMaster} "
        "(${TablesColumnFile.thoushldexpendrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mhoushldexpenrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mhoushldexpntype} ,"
        "${TablesColumnFile.mhoushldevaluationamt} )"
        "VALUES"
        "(${bean.thoushldexpendrefno} ,"
        "${bean.trefno},"
        "${bean.mhoushldexpenrefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "'${bean.mhoushldexpntype}' ,"
        "${bean.mhoushldevaluationamt}  );";
    print("insert query  address master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${houseExpenseMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerHouseholdExpenseDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int hhexpendrefno = 0;
    for (HouseholdExpenditureDetailsBean item
    in custListBean.householdExpendDetailsList) {
      item.mrefno = custListBean.mrefno;
      hhexpendrefno++;
      item.thoushldexpendrefno = hhexpendrefno;
      id = await updateCustomerHouseholdExpenseBeanTable(item);
    }
    return id;
  }

  Future<List<NewTermDepositBean>> selectTDListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${TermDepositMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime" AND ${TablesColumnFile.mprdacctid} IS NULL'
        : 'SELECT * FROM ${TermDepositMaster} ; ';

    print(selectQueryIsDataSynced);
    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<NewTermDepositBean> listbean = new List<NewTermDepositBean>();
    NewTermDepositBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new NewTermDepositBean();
        bean = bindDataTDListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //kyc data sycned
  KycMasterBean bindDataKycListBean(Map<String, dynamic> result) {
    KycMasterBean kycListBean = new KycMasterBean();
    return KycMasterBean.fromMap(result);
  }

  Future<List<KycMasterBean>> selectKycMasterListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${kycMaster} '
        'WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime" '
        ' OR ${TablesColumnFile.mcreateddt} > "${lastSyncDateTime}" '
        : 'SELECT * FROM ${kycMaster} ; ';

    print(selectQueryIsDataSynced);

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    print("result  " + result.toString());
    List<KycMasterBean> listbean = new List<KycMasterBean>();

    KycMasterBean bean;

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new KycMasterBean();
        bean = bindDataKycListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  NewTermDepositBean bindDataTDListBean(Map<String, dynamic> result) {
    NewTermDepositBean savingsListBean = new NewTermDepositBean();
    return NewTermDepositBean.fromMap(result);
  }

  Future<int> updateCustomerAssetBeanTable(AssetDetailsBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${assetDetailMaster} "
        "(${TablesColumnFile.tassetdetrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.massetdetrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mitem} )"
        "VALUES"
        "(${bean.tassetdetrefno} ,"
        "${bean.trefno},"
        "${bean.massetdetrefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "${bean.mitem} );";
    print("insert query  address master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() +
          " id after insert in ${assetDetailMaster}");
    });
    return idAfterInsert;
  }

  Future<int> updateCustomerAssetDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int assetrefno = 0;
    for (AssetDetailsBean item in custListBean.assetDetailsList) {
      item.mrefno = custListBean.mrefno;
      assetrefno++;
      item.tassetdetrefno = assetrefno;
      id = await updateCustomerAssetBeanTable(item);
    }
    return id;
  }

  //Insert ImageMaster
  Future updateImageMaster(ImageBean listImgBean, int tImagerefNo) async {
    var db = await _getDb();

    print(listImgBean.imgString.toString());
    String insertQuery = "INSERT OR REPLACE INTO ${imageMaster} "
        "( ${TablesColumnFile.tImgrefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mImgrefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.imageType}  ,"
        "${TablesColumnFile.imageSubType}  ,"
        "${TablesColumnFile.desc},"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.imageString} "
        " ) VALUES ("
        "${tImagerefNo} ,"
        "${listImgBean.trefno} ,"
        "${listImgBean.mImgrefno} ,"
        "${listImgBean.mrefno} ,"
        "'${listImgBean.imgType}' ,"
        "'${listImgBean.imgSubType}' ,"
        "'${listImgBean.desc}' ,"
        "${listImgBean.mcustno} ,"
        "'${listImgBean.imgString}' "
        " );";

    print("insert query is ${insertQuery}");

    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${imageMaster}");
    });
  }

  //ends

  TradeAndNeighbourRefCheckBean bindTradeAndNeighbourRefFormBean(
      Map<String, dynamic> result) {
    TradeAndNeighbourRefCheckBean tradeAndNeighbourRefCheckBean =
    new TradeAndNeighbourRefCheckBean();
    return TradeAndNeighbourRefCheckBean.fromMap(result);
  }

  DeviationFormBean bindDataDeviationFormBean(Map<String, dynamic> result) {
    DeviationFormBean deviationFormBean = new DeviationFormBean();
    return DeviationFormBean.fromMap(result);
  }

  SocialAndEnvironmentalBean bindSocialAndEnvironmentalFormBean(
      Map<String, dynamic> result) {
    SocialAndEnvironmentalBean socialAndEnvironmentalBean =
    new SocialAndEnvironmentalBean();
    return SocialAndEnvironmentalBean.fromMap(result);
  }

  SavingsListBean bindDataSavingsListBean(Map<String, dynamic> result) {
    SavingsListBean savingsListBean = new SavingsListBean();
    return SavingsListBean.fromMap(result);
  }

  CenterDetailsBean bindDataCenterListBean(Map<String, dynamic> result) {
    CenterDetailsBean centerListBean = new CenterDetailsBean();
    return CenterDetailsBean.fromMap(result);
  }

  DisbursmentBean bindDataDisbursmentListBean(Map<String, dynamic> result) {
    DisbursmentBean disbursmentBean = new DisbursmentBean();
    return DisbursmentBean.fromMap(result);
  }

  GroupFoundationBean bindDataGroupListBean(Map<String, dynamic> result) {
    GroupFoundationBean groupListBean = new GroupFoundationBean();
    return GroupFoundationBean.fromMap(result);
  }

  LoanUtilizationBean bindDataLoanUtilizationBean(Map<String, dynamic> result) {
    LoanUtilizationBean loanUtilizationBean = new LoanUtilizationBean();
    return LoanUtilizationBean.fromMap(result);
  }

  //Select Customer BindData
  CustomerListBean bindDataCustomerListBean(Map<String, dynamic> result) {
    CustomerListBean customerListBean = new CustomerListBean();
    return CustomerListBean.fromMap(result, false);
  }

  Future<List<SavingsListBean>> selectSavingsList(int mcenterid, int mgroupid,
      int mcustno, int mprdcd, int trefno, int mrefno) async {
    var db = await _getDb();
    SavingsListBean retBean = new SavingsListBean();
    List<SavingsListBean> n = new List<SavingsListBean>();
    var result;

    String seleQuery = "";

    if (mcustno != 0 && mcustno != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " + TablesColumnFile.mprdcd + " = " + mprdcd.toString()} "
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
          " AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    } else if (mprdcd != 0 && mprdcd != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
          " AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    } else if (mcenterid != 0 && mcenterid != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " + TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
          " AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    } else if (mgroupid != 0 && mgroupid != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mgroupcd + " = " + mgroupid.toString()}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " + TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
          " AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    } else if (trefno != 0 && trefno != null) {
      seleQuery = "Select * from ${savingsMaster} WHERE "
          "${TablesColumnFile.mcusttrefno + " = " + trefno.toString() + " AND " + TablesColumnFile.mcustmrefno + " = " + mrefno.toString()}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " + TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
          " AND ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3;";
    } else {
      seleQuery =
      "Select * from ${savingsMaster} WHERE ${TablesColumnFile.macctstat} <> 3 AND ${TablesColumnFile.mfreezetype} <> 4 AND ${TablesColumnFile.mfreezetype} <> 3  ";
      print("seleQuery----------------" + seleQuery.toString());
    }
    print("seleQuery123----------------" + seleQuery.toString());

    result = await db.rawQuery(seleQuery);

    try {
      for (int i = 0; i < result.length; i++) {
        /*      print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);*/
        retBean = SavingsListBean.fromMap(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future<List<DisbursmentBean>> selectDisbursmentList(
      int mcenterid,
      int mgroupid,
      int mcustno,
      DateTime fromdate,
      DateTime todate,
      routeType) async {
    var db = await _getDb();
    String todayDate = DateTime.now().toString();

    // print(todayDate);

    todayDate = todayDate.replaceRange(11, 26, "00:00:00.000000");
    //  print(todayDate);

    DateTime date = DateTime.parse(todayDate);
    DisbursmentBean retBean = new DisbursmentBean();
    List<DisbursmentBean> n = new List<DisbursmentBean>();
    String tableName = "";

    var result;
    print("fromdate" + fromdate.toString());
    print("todate" + todate.toString());
    String testQuery =
        "Select ${TablesColumnFile.mleadsid} FROM ${disbursedMaster} ";

    result = await db.rawQuery(testQuery);
    print("result" + result.toString());

    String seleQuery = "";
    if (routeType == "Disbursment Approval") {
      if (mcenterid != 0 && mcenterid != null) {
        seleQuery = "Select * from ${disbursedMaster} WHERE "
            "${TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
            "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
            "${fromdate == 0 || fromdate == null ? " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"} "
            "${todate == 0 || todate == null ? " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            " AND ${TablesColumnFile.mdisbstatus} = 1 "
            " ; ";
      } else if (mgroupid != 0 && mgroupid != null) {
        seleQuery = "Select * from ${disbursedMaster} WHERE "
            "${TablesColumnFile.mgroupcd + " = " + mgroupid.toString()}"
            "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
            "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${fromdate == 0 || fromdate == null ? " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"} "
            "${todate == 0 || todate == null ? " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            " AND ${TablesColumnFile.mdisbstatus} = 1 "
            " ; ";
      } else if (mcustno != 0 && mcustno != null) {
        seleQuery = "Select * from ${disbursedMaster} WHERE "
            "${TablesColumnFile.mcustno + " = " + mcustno.toString()}"
            "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
            "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${fromdate == 0 || fromdate == null ? " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"} "
            "${todate == 0 || todate == null ? " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            " AND ${TablesColumnFile.mdisbstatus} = 1 "
            "; ";
      } else if (fromdate != 0 && fromdate != null) {
        seleQuery = "Select * from ${disbursedMaster} WHERE "
            "${TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"}"
            "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
            "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
            "${todate == 0 || todate == null ? " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            " AND ${TablesColumnFile.mdisbstatus} = 1 "
            "; ";
      } else if (todate != 0 && todate != null) {
        seleQuery = "Select * from ${disbursedMaster} WHERE "
            "${TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
            "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
            "${fromdate == 0 || fromdate == null ? " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"}"
            " AND ${TablesColumnFile.mdisbstatus} = 1 "
            " ; ";
      } else {
        seleQuery = "Select * from ${disbursedMaster} ; ";

        print("seleQuery----------------" + seleQuery.toString());
      }
    } else {
      if (mcenterid != 0 && mcenterid != null) {
        seleQuery = "Select * from ${disbursmentMaster} WHERE "
            "${TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
            "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
            "${fromdate == 0 || fromdate == null ? " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"} "
            "${todate == 0 || todate == null ? " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            " AND ${TablesColumnFile.mleadsid} NOT IN (Select ${TablesColumnFile.mleadsid} FROM ${disbursedMaster} ); ";
      } else if (mgroupid != 0 && mgroupid != null) {
        seleQuery = "Select * from ${disbursmentMaster} WHERE "
            "${TablesColumnFile.mgroupcd + " = " + mgroupid.toString()}"
            "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
            "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${fromdate == 0 || fromdate == null ? " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"} "
            "${todate == 0 || todate == null ? " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            " AND ${TablesColumnFile.mleadsid} NOT IN (Select ${TablesColumnFile.mleadsid} FROM ${disbursedMaster} ); ";
      } else if (mcustno != 0 && mcustno != null) {
        seleQuery = "Select * from ${disbursmentMaster} WHERE "
            "${TablesColumnFile.mcustno + " = " + mcustno.toString()}"
            "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
            "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${fromdate == 0 || fromdate == null ? " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"} "
            "${todate == 0 || todate == null ? " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            " AND ${TablesColumnFile.mleadsid} NOT IN (Select ${TablesColumnFile.mleadsid} FROM ${disbursedMaster} ); ";
      } else if (fromdate != 0 && fromdate != null) {
        seleQuery = "Select * from ${disbursmentMaster} WHERE "
            "${TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"}"
            "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
            "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
            "${todate == 0 || todate == null ? " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            " AND ${TablesColumnFile.mleadsid} NOT IN (Select ${TablesColumnFile.mleadsid} FROM ${disbursedMaster} ); ";
      } else if (todate != 0 && todate != null) {
        seleQuery = "Select * from ${disbursmentMaster} WHERE "
            "${TablesColumnFile.mdisburseddate + " <= " + "'$todate'"}"
            "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
            "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
            "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupcd + " = " + mgroupid.toString()} "
            "${fromdate == 0 || fromdate == null ? " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$date'" : " AND " + TablesColumnFile.mdisburseddate + " >= " + "'$fromdate'"}"
            " AND ${TablesColumnFile.mleadsid} NOT IN (Select ${TablesColumnFile.mleadsid} FROM ${disbursedMaster} ); ";
      } else {
        seleQuery = "Select * from ${disbursmentMaster} WHERE"
            " ${TablesColumnFile.mleadsid} NOT IN (Select ${TablesColumnFile.mleadsid} FROM ${disbursedMaster} ); ";

        print("seleQuery----------------" + seleQuery.toString());
      }
    }
    print("seleQuery123----------------" + seleQuery.toString());
    result = await db.rawQuery(seleQuery);
    print("result" + result.toString());
    try {
      for (int i = 0; i < result.length; i++) {
        /*      print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);*/
        retBean = DisbursmentBean.fromMap(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future<List<SavingsListBean>> selectSavingsListForWithdrawl() async {
    var db = await _getDb();
    var result =
    // await db.rawQuery("SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile.mcenterid}=$mcenterid OR ${TablesColumnFile.mgroupcd}=$mgroupid OR ${TablesColumnFile.mcustno}=${mcustno} AND ${TablesColumnFile.mprdcd}=${mprdcd.toString()} AND ${TablesColumnFile.mprdacctId} IS NOT NULL AND ${TablesColumnFile.mprdacctId} != 'null'");
    await db.rawQuery(
        "SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile.mprdacctid} IS NOT NULL AND ${TablesColumnFile.mprdacctid} != 'null'");

    var result1 = await db.rawQuery(
        "SELECT COUNT(*) FROM ${savingsMaster}  WHERE ${TablesColumnFile.mprdacctid} IS NOT NULL AND ${TablesColumnFile.mprdacctid} != 'null'");
    print("savings list count");
    print("result" + result.toString());
    print(result1);
    List<SavingsListBean> listbean = new List<SavingsListBean>();
    SavingsListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        //print("result" + result[i].toString());
        bean = new SavingsListBean();
        bean = bindDataSavingsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //Select CustomerList
  Future<List<CustomerListBean>> selectCustomerList() async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationMasterDetails} Order by ${TablesColumnFile.mlastupdatedt} DESC');
    var result1 = await db
        .rawQuery('SELECT COUNT(*) FROM ${customerFoundationMasterDetails}');
    print("customer count");
    print(result1);
    List<CustomerListBean> listbean = new List<CustomerListBean>();
    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        //print("result" + result[i].toString());
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //Select SpeedoMeter BindData
  SpeedoMeterBean bindDataSpeedoMeterListBean(Map<String, dynamic> result) {
    SpeedoMeterBean speedoMeterBean = new SpeedoMeterBean();
    return SpeedoMeterBean.fromMap(result);
  }

  //Select SpeedoMeterList
  Future<List<SpeedoMeterBean>> selectSpeedoMeterList() async {
    var db = await _getDb();
    String query = 'SELECT * FROM ${speedoMeterMaster}';
    print(query);
    var result = await db.rawQuery(query);
    print(result);
    List<SpeedoMeterBean> listbean = new List<SpeedoMeterBean>();
    SpeedoMeterBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SpeedoMeterBean();
        bean = bindDataSpeedoMeterListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select single customer images
  Future<CustomerListBean> selectSingleCustomer(
      int loanTebRefno, int loanMrefno) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationMasterDetails} where ${TablesColumnFile.trefno} = $loanTebRefno AND ${TablesColumnFile.mrefno} = $loanMrefno');

    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<ImageBean>> selectSingleCustomerImages(
      int loanTebRefno, int loanMrefno) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${imageMaster} where ${TablesColumnFile.trefno} = $loanTebRefno AND ${TablesColumnFile.mrefno} = $loanMrefno');

    List<ImageBean> listbean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindImageListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<ImageBean>> getFingerList(int trefno, int mrefno) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${imageMaster} where ${TablesColumnFile.trefno} = $trefno AND ${TablesColumnFile.mrefno} = $mrefno AND ${TablesColumnFile.imageType} = "FingerPrint" ');
    print("result" + result.toString());
    List<ImageBean> listbean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindImageListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<CustomerListBean> getTrefAndMrefByCustno(int custno) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationMasterDetails} where  ${TablesColumnFile.mcustno} = $custno');
    print("result" + result.toString());
    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<SavingsListBean>> selectSavingsCollectionListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${savingsCollectionMaster}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${savingsCollectionMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    List<SavingsListBean> listbean = new List<SavingsListBean>();
    SavingsListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SavingsListBean();
        bean = bindDataSavingsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<SavingsListBean>> selectSavingsListIsDataSynced() async {
    String selectQueryIsDataSynced =  "SELECT * FROM ${savingsMaster}  WHERE "
        " ${TablesColumnFile.missynctocoresys}  IS NULL OR  ${TablesColumnFile.missynctocoresys} = 0 ";
    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<SavingsListBean> listbean = new List<SavingsListBean>();
    SavingsListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SavingsListBean();
        bean = bindDataSavingsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<DisbursmentBean>> selectDisbursmentListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    /*  ? 'SELECT * FROM ${savingsMaster}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime" AND ${TablesColumnFile.trefno}>0'
        : 'SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile.trefno}>0 ';*/
        ? 'SELECT * FROM ${disbursmentMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${disbursmentMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<DisbursmentBean> listbean = new List<DisbursmentBean>();
    DisbursmentBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DisbursmentBean();
        bean = bindDataDisbursmentListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<CenterDetailsBean>> selectCenterListIsDataSynced() async {
    String selectQueryIsDataSynced =  "SELECT * FROM ${centerDetailsMaster}  "
        " WHERE  ${TablesColumnFile.missynctocoresys} =  0 ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<CenterDetailsBean> listbean = new List<CenterDetailsBean>();
    CenterDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CenterDetailsBean();
        bean = bindDataCenterListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<TradeAndNeighbourRefCheckBean>>
  selectTradeAndNeighbourRefListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${tradeNeighbourRefCheckMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${tradeNeighbourRefCheckMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<TradeAndNeighbourRefCheckBean> listbean =
    new List<TradeAndNeighbourRefCheckBean>();
    TradeAndNeighbourRefCheckBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new TradeAndNeighbourRefCheckBean();
        bean = bindTradeAndNeighbourRefFormBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<SocialAndEnvironmentalBean>>
  selectSocialAndEnvironmentalListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${socialEnvironmentMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${socialEnvironmentMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<SocialAndEnvironmentalBean> listbean =
    new List<SocialAndEnvironmentalBean>();
    SocialAndEnvironmentalBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SocialAndEnvironmentalBean();
        bean = bindSocialAndEnvironmentalFormBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<DeviationFormBean>> selectDeviationFormListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${deviationFormMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${deviationFormMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<DeviationFormBean> listbean = new List<DeviationFormBean>();
    DeviationFormBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DeviationFormBean();
        bean = bindDataDeviationFormBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<SocialAndEnvironmentalBean> getSocialAndEnvValues(
      int loantrefno, int loanmrefno) async {
    var db = await _getDb();
    SocialAndEnvironmentalBean retBean = new SocialAndEnvironmentalBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'SELECT *  FROM $socialEnvironmentMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    var result = await db.rawQuery(
        'SELECT *  FROM $socialEnvironmentMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    try {
      if (result[0] != null) {
        print(result);
        retBean = bindSocialAndEnvironmentalFormBean(result[0]);
      }
    } catch (_) {
      retBean = null;
    }
    return retBean;
  }

  Future<DeviationFormBean> getDeviationFormValues(
      int loantrefno, int loanmrefno) async {
    var db = await _getDb();
    DeviationFormBean retBean = new DeviationFormBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'SELECT *  FROM $deviationFormMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    var result = await db.rawQuery(
        'SELECT *  FROM $deviationFormMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    try {
      if (result[0] != null) {
        print(result);
        retBean = bindDataDeviationFormBean(result[0]);
      }
    } catch (_) {
      retBean = null;
    }
    return retBean;
  }

  Future<TradeAndNeighbourRefCheckBean> getTradeAndNeighValues(
      int loantrefno, int loanmrefno) async {
    var db = await _getDb();
    TradeAndNeighbourRefCheckBean retBean = new TradeAndNeighbourRefCheckBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'SELECT *  FROM $tradeNeighbourRefCheckMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    var result = await db.rawQuery(
        'SELECT *  FROM $tradeNeighbourRefCheckMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    try {
      if (result[0] != null) {
        print(result);
        retBean = bindTradeAndNeighbourRefFormBean(result[0]);
      }
    } catch (_) {
      retBean = null;
    }
    return retBean;
  }

  Future<List<GroupFoundationBean>> selectGroupListIsDataSynced() async {
    String  selectQueryIsDataSynced=   'SELECT * FROM ${groupFoundationMaster}  WHERE  ${TablesColumnFile.missynctocoresys} = 0';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<GroupFoundationBean> listbean = new List<GroupFoundationBean>();
    GroupFoundationBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GroupFoundationBean();
        bean = bindDataGroupListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<List<LoanUtilizationBean>> selectLoanUtilListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    /*  ? 'SELECT * FROM ${savingsMaster}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime" AND ${TablesColumnFile.trefno}>0'
        : 'SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile.trefno}>0 ';*/
        ? 'SELECT * FROM ${loanUtilizationMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${loanUtilizationMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<LoanUtilizationBean> listbean = new List<LoanUtilizationBean>();
    LoanUtilizationBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new LoanUtilizationBean();
        bean = bindLoanUtilizationBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select customer based on last synced date time
  Future<List<CustomerListBean>> selectCustomerListIsDataSynced(
      DateTime lastSyncDateTime) async {
    print("lastSyncDateTime");
    print(lastSyncDateTime);
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    //? 'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        ? 'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${customerFoundationMasterDetails} ';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    List<CustomerListBean> listbean = new List<CustomerListBean>();
    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<LoanUtilizationBean> selectLoanUtilizationListOnUsername(
      String musername) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${loanUtilizationMaster}  WHERE  ${TablesColumnFile.musrname}  = "${musername}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    LoanUtilizationBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new LoanUtilizationBean();
        bean = bindDataLoanUtilizationBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<SavingsListBean> selectSavingsListOnTref(
      int trefno, int mrefno ) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${savingsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = ${mrefno} ';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    if (result.isEmpty) {
      selectQueryIsDataSynced =
      'SELECT * FROM ${savingsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = ${0} ';

      result = await db.rawQuery(selectQueryIsDataSynced);
    }


    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    SavingsListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SavingsListBean();
        bean = bindDataSavingsListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<DisbursmentBean> selectDisbursmentListOnTref(
      int trefno, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${disbursedMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    if (result.isEmpty) {
      selectQueryIsDataSynced =
      'SELECT * FROM ${disbursedMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno AND ${TablesColumnFile.mrefno}  = 0';

      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    DisbursmentBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DisbursmentBean();
        bean = bindDataDisbursmentListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<CenterDetailsBean> selectCenterListOnTref(
      int trefno, String mcreatedby, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${centerDetailsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mcreatedby}"  '
        ' AND ${TablesColumnFile.mrefno} = $mrefno ';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);


    if(result.isEmpty){
      selectQueryIsDataSynced =
      'SELECT * FROM ${centerDetailsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mcreatedby}"  '
          ' AND ${TablesColumnFile.mrefno} = 0 ';

      result = await db.rawQuery(selectQueryIsDataSynced);

    }

    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CenterDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CenterDetailsBean();
        bean = bindDataCenterListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<DeviationFormBean> selectDeviationFormListOnTref(
      int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${deviationFormMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    DeviationFormBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DeviationFormBean();
        bean = bindDataDeviationFormBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<TradeAndNeighbourRefCheckBean> selectTradeNeighbourRefListOnTref(
      int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${tradeNeighbourRefCheckMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = '${mCreatedBy}'";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    TradeAndNeighbourRefCheckBean bean;
    try {
      bean = new TradeAndNeighbourRefCheckBean();
      bean = bindTradeAndNeighbourRefFormBean(result[0]);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<SocialAndEnvironmentalBean> selectSocialAndEnvironmentalListOnTref(
      int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${socialEnvironmentMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    SocialAndEnvironmentalBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SocialAndEnvironmentalBean();
        bean = bindSocialAndEnvironmentalFormBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<GroupFoundationBean> selectGroupListOnTref(
      int trefno, String mCreatedBy, int mrefno ) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${groupFoundationMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = '${mCreatedBy}'  "
        "  AND  ${TablesColumnFile.mrefno}  = '${mrefno}' ";



    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);


    if(result.isEmpty){
      selectQueryIsDataSynced =
      "SELECT * FROM ${groupFoundationMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = '${mCreatedBy}'  "
          "  AND  ${TablesColumnFile.mrefno}  = '${0}' ";

      result = await db.rawQuery(selectQueryIsDataSynced);

    }


    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    GroupFoundationBean bean;
    try {
      bean = new GroupFoundationBean();
      bean = bindDataGroupListBean(result[0]);

    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  //select customer based on Tref
  Future<CustomerListBean> selectCustomerOnTref(
      int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  //select FamilyList
  Future<List<FamilyDetailsBean>> selectCustomerFamilyDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${customerFoundationFamilyMasterDetails}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${customerFoundationFamilyMasterDetails}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<FamilyDetailsBean> listbean = new List<FamilyDetailsBean>();
    FamilyDetailsBean bean;
    try {
      print("family mai");
      for (int i = 0; i < result.length; i++) {
        bean = new FamilyDetailsBean();
        bean = bindDataCustomerFamilyDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  // select household and business expenditure

  Future<List<BusinessExpenditureDetailsBean>>
  selectCustomerBusinessExpenseListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${businessExpenseMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${businessExpenseMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<BusinessExpenditureDetailsBean> listbean =
    new List<BusinessExpenditureDetailsBean>();
    BusinessExpenditureDetailsBean bean;
    try {
      print("business expenditure mai");
      for (int i = 0; i < result.length; i++) {
        bean = new BusinessExpenditureDetailsBean();
        bean = bindDataCustomerBusinessExpenseListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  BusinessExpenditureDetailsBean bindDataCustomerBusinessExpenseListBean(
      Map<String, dynamic> result) {
    return BusinessExpenditureDetailsBean.fromMap(result);
  }

  Future<List<HouseholdExpenditureDetailsBean>>
  selectCustomerHouseholdExpenseListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${houseExpenseMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${houseExpenseMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<HouseholdExpenditureDetailsBean> listbean =
    new List<HouseholdExpenditureDetailsBean>();
    HouseholdExpenditureDetailsBean bean;
    try {
      print("household expenditure mai");
      for (int i = 0; i < result.length; i++) {
        bean = new HouseholdExpenditureDetailsBean();
        bean = bindDataCustomerHouseholdExpenseListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  HouseholdExpenditureDetailsBean bindDataCustomerHouseholdExpenseListBean(
      Map<String, dynamic> result) {
    return HouseholdExpenditureDetailsBean.fromMap(result);
  }

  Future<List<AssetDetailsBean>> selectCustomerAssetDetailListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${assetDetailMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${assetDetailMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<AssetDetailsBean> listbean = new List<AssetDetailsBean>();
    AssetDetailsBean bean;
    try {
      print("asset detail mai");
      for (int i = 0; i < result.length; i++) {
        bean = new AssetDetailsBean();
        bean = bindDataCustomerAssetDetailListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  AssetDetailsBean bindDataCustomerAssetDetailListBean(
      Map<String, dynamic> result) {
    return AssetDetailsBean.fromMap(result);
  }

  //select Borrowing IsDataSynced
  Future<List<BorrowingDetailsBean>>
  selectCustomerBorrowingDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${customerFoundationBorrowingMasterDetails}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<BorrowingDetailsBean> listbean = new List<BorrowingDetailsBean>();
    BorrowingDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new BorrowingDetailsBean();
        bean = bindDataCustomerBorrowingDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select AddressDetailsBean IsDataSynced
  Future<List<AddressDetailsBean>> selectCustomerAddressDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${customerFoundationAddressMasterDetails}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<AddressDetailsBean> listbean = new List<AddressDetailsBean>();
    AddressDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new AddressDetailsBean();
        bean = bindDataCustomerAddressDetailsBeanListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select ImagesMaster IsDataSynced
  Future<List<ImageBean>> selectImagesListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${imageMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<ImageBean> listbean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindDataImagessListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select BusinessDetails IsDataSynced
  Future<CustomerBusinessDetailsBean> selectCustomerBussinessDetails(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${customerBusinessDetailMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(selectQuery);

    CustomerBusinessDetailsBean bean;
    try {
      print("Business Details mai");
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerBusinessDetailsBean();
        print(result[i]);
        bean = bindDataCustomerBussDetailsListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  //Bind CustomerBusinessDetailsBean
  CustomerBusinessDetailsBean bindDataCustomerBussDetailsListBean(
      Map<String, dynamic> result) {
    return CustomerBusinessDetailsBean.fromMap(result);
  }

  //select CPV IsDataSynced
  Future<ContactPointVerificationBean> selectCustomerCpvDetails(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();
    String selectQuery =
        "SELECT * FROM ${customerCpvMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(selectQuery);
    ContactPointVerificationBean bean;
    try {
      print("ContactPointVerificationBean Details mai");
      for (int i = 0; i < result.length; i++) {
        bean = new ContactPointVerificationBean();
        print(result[i]);
        bean = bindDataCustomerCpvBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  //Bind CPV
  ContactPointVerificationBean bindDataCustomerCpvBean(
      Map<String, dynamic> result) {
    return ContactPointVerificationBean.fromMap(result);
  }

  //Bind ImageMaster
  ImageBean bindDataImagessListBean(Map<String, dynamic> result) {
    return ImageBean.fromMap(result);
  }

  FamilyDetailsBean bindDataCustomerFamilyDetailsListBean(
      Map<String, dynamic> result) {
    return FamilyDetailsBean.fromMap(result);
  }

  //select FamilyMasterList
  Future<List<FamilyDetailsBean>> selectCustomerFamilyDetailsList(
      String customerNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationFamilyMasterDetails} WHERE customerNumberOfTab  = $customerNumber');

    List<FamilyDetailsBean> listbean = new List<FamilyDetailsBean>();
    FamilyDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new FamilyDetailsBean();
        bean = bindDataCustomerFamilyDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //Bind BorrowingDetails
  BorrowingDetailsBean bindDataCustomerBorrowingDetailsListBean(
      Map<String, dynamic> result) {
    return BorrowingDetailsBean.fromMap(result);
  }

  //select BorrowingDetails
  Future<List<BorrowingDetailsBean>> selectCustomerBorrowingDetailsList(
      String customerNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationBorrowingMasterDetails} WHERE customerNumberOfTab  = $customerNumber');

    List<BorrowingDetailsBean> listbean = new List<BorrowingDetailsBean>();
    BorrowingDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new BorrowingDetailsBean();
        bean = bindDataCustomerBorrowingDetailsListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //bind Address
  AddressDetailsBean bindDataCustomerAddressDetailsBeanListBean(
      Map<String, dynamic> result) {
    return AddressDetailsBean.fromMap(result);
  }

  // select AddressDetailsBean
  Future<List<AddressDetailsBean>> selectCustomerAddressDetailsList(
      String customerNumber) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT * FROM ${customerFoundationAddressMasterDetails} WHERE customerNumberOfTab  = $customerNumber');

    List<AddressDetailsBean> listbean = new List<AddressDetailsBean>();
    AddressDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new AddressDetailsBean();
        bean = bindDataCustomerAddressDetailsBeanListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //bind images
  ImageBean bindImageListBean(Map<String, dynamic> result) {
    return ImageBean.fromMap(result);
  }

  //select imageMaster
  Future<List<ImageBean>> selectImageList(
      String customerNumber, String type) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "SELECT * FROM ${imageMaster} WHERE customerNumberOfTab  = $customerNumber  AND imageSubType = '$type'");

    List<ImageBean> listBean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindImageListBean(result[i]);
        listBean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listBean;
  }

  Future updateSavingsMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${savingsMaster} SET ${query}");
    });
  }

  Future updateDisbursmentListMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${disbursmentMaster} SET ${query}");
    });
  }

  Future updateCenterMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${centerDetailsMaster} SET ${query}");
    });
  }

  Future updateSocialEnvMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${socialEnvironmentMaster} SET ${query}");
    });
  }

  Future updateTradeNeighbourRefMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${tradeNeighbourRefCheckMaster} SET ${query}");
    });
  }

  Future updateDeviationMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${deviationFormMaster} SET ${query}");
    });
  }

  Future updateSavingsCollectionMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${savingsCollectionMaster} SET ${query}");
    });
  }

  Future updateGroupMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${groupFoundationMaster} SET ${query}");
    });
  }

  Future updateCustomerMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn
          .rawQuery("UPDATE ${customerFoundationMasterDetails} SET ${query}");
    });
  }

  Future updateFamily(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Family --- UPDATE ${customerFoundationFamilyMasterDetails} SET ${query}");
      await txn.rawQuery(
          "UPDATE ${customerFoundationFamilyMasterDetails} SET ${query}");
    });
  }

  Future updateBorrowing(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Borrowing --- UPDATE ${customerFoundationBorrowingMasterDetails} SET ${query}");
      await txn.rawQuery(
          "UPDATE ${customerFoundationBorrowingMasterDetails} SET ${query}");
    });
  }

  Future updateAddress(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Address --- UPDATE ${customerFoundationAddressMasterDetails} SET ${query}");
      await txn.rawQuery(
          "UPDATE ${customerFoundationAddressMasterDetails} SET ${query}");
    });
  }

  Future updateBussinessDetail(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Business --- UPDATE ${customerBusinessDetailMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${customerBusinessDetailMaster} SET ${query}");
    });
  }

  Future updateCpvDetail(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Business --- UPDATE ${customerCpvMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${customerCpvMaster} SET ${query}");
    });
  }

  Future updateImage(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Image --- UPDATE ${imageMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${imageMaster} SET ${query}");
    });
  }

  //customer ends here

  Future<List<CreditBereauBean>> getNonSmsVerifiedCreditMasterObjects() async {
    var db = await _getDb();
    CreditBereauBean retBean = new CreditBereauBean();
    List<CreditBereauBean> n = new List<CreditBereauBean>();
    var str = "${TablesColumnFile.motpverified} = 0";

    var result;

    print("query is" + "SELECT *  FROM $creditBereauMaster where ${str} ");
    result =
    await db.rawQuery('SELECT *  FROM $creditBereauMaster  where ${str};');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCreditBereauBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    print(n.length);
    return n;
  }

  CreditBereauBean bindCreditBereauBean(Map<String, dynamic> result) {
    return CreditBereauBean.fromMap(result);
  }

  Future<String> verifyCreditBereauSmsResult(int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile.mrefno} = ${mrefNo}";

    print('xxxxxxxxxxxxxxquery is here : ' +
        'Update $creditBereauMaster SET ${TablesColumnFile.motpverified} = 1 WHERE $str ');
    var result = await db.rawQuery(
        'Update $creditBereauMaster SET ${TablesColumnFile.motpverified} = 1 WHERE $str ');

    print("CreditBereauMaster Updated");
  }

  Future<String> updateCreditBereauSmsOTP(int contactNo, int OTP, int trefNo,
      int mrefNo, DateTime lastUpdateDate) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile.mrefno} = ${mrefNo}";

    print('xxxxxxxxxxxxxxquery is here : ' +
        'Update $creditBereauMaster SET ${TablesColumnFile.motp} = ${OTP},${TablesColumnFile.mlastupdatedt} = "${lastUpdateDate}" WHERE $str ');
    var result = await db.rawQuery(
        "Update $creditBereauMaster SET ${TablesColumnFile.motp} = ${OTP} ,${TablesColumnFile.mlastupdatedt} = '${lastUpdateDate}' WHERE $str ");

    print("CreditBereauMaster Updated");

    print(result.toString());
    return (result.toString());
  }

  Future updateTDMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${TermDepositMaster} SET ${query}");
    });
  }

  //kyc Raw query
  Future updateKycListMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${kycMaster} SET ${query}");
    });
  }

  Future<NewTermDepositBean> selectTermDepositOnTref(
      int trefno, String mCreatedBy,int mrefno) async {

    String selectQueryIsDataSynced =
        'SELECT * FROM ${TermDepositMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = ${mrefno} ';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    if (result.isEmpty) {
      selectQueryIsDataSynced =
      'SELECT * FROM ${TermDepositMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = ${0} ';

      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    NewTermDepositBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new NewTermDepositBean();
        bean = bindTermDepositListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<KycMasterBean> selectKycMasterOnTrefAndMrefNo(
      int trefno, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${kycMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno  AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty) {
      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${kycMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno  AND ${TablesColumnFile.mrefno}  = 0 ';
      print(selectQueryIsDataSynced);
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    //var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    KycMasterBean bean;
    //try {
    for (int i = 0; i < result.length; i++) {
      bean = new KycMasterBean();
      bean = bindKycMasterListBean(result[i]);
    }
    /* } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }*/
    return bean;
  }

  NewTermDepositBean bindTermDepositListBean(Map<String, dynamic> result) {
    NewTermDepositBean savingsListBean = new NewTermDepositBean();
    return NewTermDepositBean.fromMap(result);
  }

  KycMasterBean bindKycMasterListBean(Map<String, dynamic> result) {
    KycMasterBean savingsKycListBean = new KycMasterBean();
    return KycMasterBean.fromMap(result);
  }

  Future<int> getSMSOTP(int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile.mrefno} = ${mrefNo}  ";
    CreditBereauBean cbbbBean = new CreditBereauBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'Select ${TablesColumnFile.motp} from ${creditBereauMaster} WHERE $str');
    var result = await db.rawQuery(
        'Select ${TablesColumnFile.motp} from ${creditBereauMaster} WHERE $str ');

    print("CreditBereauMaster Updated");

    try {
      if (result[0] != null) {
        return result[0][TablesColumnFile.motp];
      }

      print("going for check");
      return result[0]['check'];
    } catch (e) {
      print("inside catches");
      return null;
    }
  }

  Future<String> getCenterName(int mcenterid) async {
    var db = await _getDb();
    var result;

    print("query is" +
        "SELECT ${TablesColumnFile.mcentername}  FROM $centerDetailsMaster WHERE ${TablesColumnFile.mcenterid} = $mcenterid");
    result = await db.rawQuery(
        'SELECT ${TablesColumnFile.mcentername}  FROM $centerDetailsMaster WHERE ${TablesColumnFile.mcenterid} = $mcenterid;');

    print("getCenterName ${result}");

    try {
      if (result.length > 0) {
        return result[0]["mcentername"].toString();
      }

      return result[0]['check'];
    } catch (e) {
      print("inside catches");
      return null;
    }
  }

  Future<String> getGroupName(int mgroupcd) async {
    var db = await _getDb();
    var result;

    print("query is" +
        "SELECT ${TablesColumnFile.mgroupname}  FROM $groupFoundationMaster WHERE ${TablesColumnFile.mgroupid} = $mgroupcd");
    result = await db.rawQuery(
        'SELECT ${TablesColumnFile.mgroupname}  FROM $groupFoundationMaster WHERE ${TablesColumnFile.mgroupid} = $mgroupcd;');

    print("getCenterName ${result}");

    try {
      if (result.length > 0) {
        return result[0]["mgroupname"].toString();
      }

      return result[0]['check'];
    } catch (e) {
      print("inside catches");
      return null;
    }
  }

//customer formation code ends here

  Future<List<ProductBean>> getProductList(
      int moduleType, int branchCode, int isInd) async {
    var db = await _getDb();
    ProductBean retBean = new ProductBean();
    List<ProductBean> n = new List<ProductBean>();

    var result;
    //if(future!=null) {
    print("query is" +
        "SELECT *  FROM $productMaster WHERE ${TablesColumnFile.mmoduletype} = $moduleType AND ${TablesColumnFile.mlbrcode} = $branchCode");
    result = await db.rawQuery(
        'SELECT *  FROM $productMaster WHERE ${TablesColumnFile.mmoduletype} = $moduleType AND ${TablesColumnFile.mlbrcode} = $branchCode;');

    if (moduleType == 30) {
      if (isInd == 0) {
        result = await db.rawQuery(
            'SELECT *  FROM $productMaster WHERE ${TablesColumnFile.mmoduletype} = $moduleType AND ${TablesColumnFile.mlbrcode} = $branchCode AND ${TablesColumnFile.mdivisiontype} IN ("","I","B");');
      } else {
        result = await db.rawQuery(
            'SELECT *  FROM $productMaster WHERE ${TablesColumnFile.mmoduletype} = $moduleType AND ${TablesColumnFile.mlbrcode} = $branchCode AND ${TablesColumnFile.mdivisiontype} IN ("","G","B");');
      }
    }
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindProduct(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  ProductBean bindProduct(Map<String, dynamic> result) {
    return ProductBean.fromJson(result);
  }

//fo getting id type which is there in sublookup table (MIS D001107 )
  Future<List<LookupBeanData>> getFromSubLookupDataFromLocalDb(
      int codeType) async {
    var db = await _getDb();
    LookupBeanData retBean = new LookupBeanData();
    List<LookupBeanData> n = new List<LookupBeanData>();
    var result;

    print("query is" + "SELECT *  FROM $SubLookupMaster ");
    result = await db.rawQuery(
        'select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile.mcodetype},${TablesColumnFile.mcode},${TablesColumnFile.mfield1value} from ${SubLookupMaster} where ${TablesColumnFile.mcodetype} = $codeType ;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = LookupBeanData.fromJson(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future<List<SubLookupForSubPurposeOfLoan>>
      getSunPurposeOfLoanListFromSubLookpTable(
          int hardcodedValue, int position ,[String questionType]) async {
    var db = await _getDb();

    SubLookupForSubPurposeOfLoan retBean = new SubLookupForSubPurposeOfLoan();
    List<SubLookupForSubPurposeOfLoan> n =
        new List<SubLookupForSubPurposeOfLoan>();
    var result;

    if(questionType==null){

      print('SELECT *  FROM $SubLookupMaster where ${TablesColumnFile.mcodetype}  = ${hardcodedValue + position};');
      result = await db.rawQuery(
          'SELECT *  FROM $SubLookupMaster where ${TablesColumnFile.mcodetype}  = ${hardcodedValue + position};');
    }else{
      print("SELECT *  FROM $SubLookupMaster where ${TablesColumnFile.mcodetype}  = ${hardcodedValue + position} AND ${TablesColumnFile.mfield1value} LIKE '${questionType}~%'  ;");
      result = await db.rawQuery(
          "SELECT *  FROM $SubLookupMaster where ${TablesColumnFile.mcodetype}  = ${hardcodedValue + position}"
              " AND ${TablesColumnFile.mfield1value} LIKE '${questionType}~%'  ;");
    }

    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindPurposeOfLoan(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  SubLookupForSubPurposeOfLoan bindPurposeOfLoan(Map<String, dynamic> result) {
    return SubLookupForSubPurposeOfLoan.fromMap(result);
  }

  Future updateProductMaster(ProductBean prodObj) async {
    print("trying to insert or replace ${productMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${productMaster} ("
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mprdCd},"
        "${TablesColumnFile.mname},"
        "${TablesColumnFile.mintrate},"
        "${TablesColumnFile.mmoduletype},"
        "${TablesColumnFile.mcurCd},"
        "${TablesColumnFile.mnoofguaranter},"
        "${TablesColumnFile.mdivisiontype},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.mgraceperyn} ,"
        "${TablesColumnFile.mgraceperinmnths}, "
        "${TablesColumnFile.mgraceperindays} "
        ")"
        "VALUES"
        "(${prodObj.productComposieEntity.mlbrcode},"
        "'${prodObj.productComposieEntity.mprdcd}',"
        "'${prodObj.mname}',"
        "${prodObj.mintrate},"
        "${prodObj.mmoduletype},"
        "'${prodObj.mcurCd}',"
        "${prodObj.mnoofguaranter},"
        "'${prodObj.mdivisiontype}',"
        "'${prodObj.mlastsynsdate}',"
        "'${prodObj.mgraceperyn}' ,"
        "${prodObj.mgraceperinmnths} ,"
        "${prodObj.mgraceperindays} "
        ");";

    print(insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${productMaster}");
    });
  }

  Future<List<CustomerLoanDetailsBean>> getCustomerLoanDetails(int type) async {
    var db = await _getDb();
    CustomerLoanDetailsBean retBean = new CustomerLoanDetailsBean();
    List<CustomerLoanDetailsBean> loanDetailsList =
    new List<CustomerLoanDetailsBean>();
    /*String query =type=="LoanApp"? "SELECT *  FROM $customerLoanDetailsMaster":"SELECT *  FROM $customerLoanDetailsMaster WHERE ${TablesColumnFile.mleadstatus} = '${type}'";*/
    String query = type == 0
        ? "SELECT *  FROM $customerLoanDetailsMaster Order by ${TablesColumnFile.mlastupdatedt} DESC"
        : "SELECT *  FROM $customerLoanDetailsMaster WHERE ${TablesColumnFile.mleadstatus} = '${type}' Order by ${TablesColumnFile.mlastupdatedt} DESC";
    var result;

    print("query is" + "SELECT *  FROM $customerLoanDetailsMaster ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindCustomerLoanDetails(result[i]);
        loanDetailsList.add(retBean);
      }
    } catch (e) {}
    // await new Future.delayed(new Duration(seconds: 5));
    return loanDetailsList;
  }

  Future<List<CustomerLoanDetailsBean>>
  getCustomerLoanDetailsNotSynced() async {
    var db = await _getDb();
    CustomerLoanDetailsBean retBean = new CustomerLoanDetailsBean();
    List<CustomerLoanDetailsBean> n = new List<CustomerLoanDetailsBean>();
    var result;
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerLoanDetailsMaster}  '
        'WHERE  ${TablesColumnFile.missynctocoresys}  = 0 ';

    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindCustomerLoanDetails(result[i]);
        print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  CustomerLoanDetailsBean bindCustomerLoanDetails(Map<String, dynamic> result) {
    return CustomerLoanDetailsBean.fromMap(result);
  }

/*  SavingsListBean bindSavingsList(Map<String, dynamic> result) {
    return SavingsListBean.fromMap(result);
  }*/
/*
  Future<List<SavingsListBean>> getSavingsListNotSynced() async {
    var db = await _getDb();
    SavingsListBean retBean = new SavingsListBean();
    List<SavingsListBean> n = new List<SavingsListBean>();
    var result;
    print("query is" +
        "SELECT *  FROM $savingsMaster where ${TablesColumnFile.isDataSynced}= 0 OR ${TablesColumnFile.isDataSynced} IS NULL ");
    result = await db.rawQuery(
        'SELECT *  FROM $savingsMaster where ${TablesColumnFile.isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} IS NULL;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindSavingsList(result[i]);
        print("exiting from map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }
*/

  Future<List<SpeedoMeterBean>> getSpeedoMeterDetailsNotSynced() async {
    var db = await _getDb();
    SpeedoMeterBean retBean = new SpeedoMeterBean();
    List<SpeedoMeterBean> n = new List<SpeedoMeterBean>();
    var result;
    print("query is" +
        "SELECT *  FROM $speedoMeterMaster where ${TablesColumnFile.isDataSynced}= 0 OR ${TablesColumnFile.isDataSynced} IS NULL ");
    result = await db.rawQuery(
        'SELECT *  FROM $speedoMeterMaster where ${TablesColumnFile.isDataSynced} = 0 OR ${TablesColumnFile.isDataSynced} IS NULL;');
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindSpeedoMeterDetails(result[i]);
        print("exiting from map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  SpeedoMeterBean bindSpeedoMeterDetails(Map<String, dynamic> result) {
    return SpeedoMeterBean.fromMap(result);
  }

  Future updateSavingsListIsDataSynced(
      DateTime mcreateddt, DateTime mlastupdatedt) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${savingsMaster} SET ${TablesColumnFile.isDataSynced} = '${1}' WHERE ${TablesColumnFile.mcreateddt} = '${mcreateddt}' AND ${TablesColumnFile.mlastupdatedt}='${mlastupdatedt}' ");
    });
  }

  Future updateSpeedometerIsDataSynced(String userName, DateTime dt) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${speedoMeterMaster} SET ${TablesColumnFile.isDataSynced} = '${1}' WHERE ${TablesColumnFile.usrName} = '${userName}' AND ${TablesColumnFile.effDate} = '${dt}'");
    });
  }

  Future<int> getMaxCustomerAccountNumber() async {
    print("trying to select last row  ${savingsMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${savingsMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${savingsMaster});";
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

  //Generate Customer Number of Tab
  Future<int> getMaxCustomerLoanNumber() async {
    String insertQuery = "SELECT *"
        "FROM    ${customerLoanDetailsMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${customerLoanDetailsMaster});";
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
  Future<int> getLoanCycle(int mcustno) async {
    String insertQuery =
        'SELECT * FROM ${CustomerProductwiseCycleMaster}  WHERE ${TablesColumnFile
        .mcustno}  = $mcustno';
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retValue = result[0][TablesColumnFile.mcycle];
      });
    } catch (_) {
      retValue = 0;
    }
    return retValue;
  }
  Future<int> getLoanCyclebyPrdcd(String mprdcd,int mcustno ) async {
    String insertQuery =
        "SELECT * FROM ${CustomerProductwiseCycleMaster}  WHERE ${TablesColumnFile.mprdcd}  "
        " = '${mprdcd}' and  ${TablesColumnFile.mcustno} = ${mcustno} ";

    print(insertQuery);
    var db = await _getDb();
    int retValue;
    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        print(result);
        retValue = result[0][TablesColumnFile.mcycle];
      });
    } catch (_) {
      print("Jab value nai hti to fatta hai");
      retValue = 0;
    }
    return retValue;
  }
  /*
  Future<CustomerLoanDetailsBean> getMaxCustomerLoanNumber() async {
    var db = await _getDb();
    var result;
    CustomerLoanDetailsBean custLoanObj = new CustomerLoanDetailsBean();
    print("entering database");
    try {

      result = await db.rawQuery(
          'SELECT max(${TablesColumnFile.trefno}) as loanNumber  FROM $customerLoanDetailsMaster ');

      print(result);
      var map = new Map();

      if (result[0] != null) {
        custLoanObj =
            CustomerLoanDetailsBean(trefno: result[0]['loanNumber']);
        if(custLoanObj.trefno==null){
          custLoanObj=null;
        }
      }
    } catch (e) {
      print(e);
      return null;
    }
    return custLoanObj;
  }*/

  Future updateAll() async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${customerFoundationMasterDetails} SET ${TablesColumnFile.isDataSynced} = '${0}' ");
    });
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(
          "UPDATE ${imageMaster} SET ${TablesColumnFile.isDataSynced} = '${0}' ");
    });
  }

  Future<List<SavingsListBean>> getSavingsList() async {
    var db = await _getDb();
    SavingsListBean retBean = new SavingsListBean();
    List<SavingsListBean> n = new List<SavingsListBean>();
    var result;

    print("query saving wali" + "SELECT *  FROM $savingsCollectionMaster ");
    result = await db.rawQuery('select * from ${SavingsListBean} ');
    //  try {
    print("print data savings list" + result.toString());
    for (int i = 0; i < result.length; i++) {
      print("appdatabase " + result[i].toString());
      for (var items in result[i].toString().split(",")) {
        print(items);
      }

      print(result[i].runtimeType);
      //retBean = SavingsListBean.fromMap(result[i],null);
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }
    */
    return n;
  }

  Future<List<SettingsBean>> getApiUrl() async {
    var db = await _getDb();
    SettingsBean retBean = new SettingsBean();
    List<SettingsBean> n = new List<SettingsBean>();
    var result;

    print("query is jasja" + "SELECT *  FROM $settingsMaster ");
    result = await db.rawQuery('select * from ${settingsMaster} ');
    //  try {
    print("print data settings" + result.toString());
    for (int i = 0; i < result.length; i++) {
      print("appdatabase " + result[i].toString());
      for (var items in result[i].toString().split(",")) {
        print(items);
      }

      print(result[i].runtimeType);
      retBean = SettingsBean.fromJson(result[i]);
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }
    */
    return n;
  }

  Future<List<LookupBeanData>> getLookupDataFromLocalDb(int codeType,
      [String field1Value]) async {
    var db = await _getDb();
    LookupBeanData retBean = new LookupBeanData();
    List<LookupBeanData> n = new List<LookupBeanData>();
    var result;

    if (field1Value == null) {
      print(
          'select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile.mcodetype},${TablesColumnFile.mcode},${TablesColumnFile.mfield1value} from lookup_master where ${TablesColumnFile.mcodetype} = $codeType ORDER BY ${TablesColumnFile.mcodedesc} ;');
      result = await db.rawQuery(
          'select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile.mcodetype},${TablesColumnFile.mcode},${TablesColumnFile.mfield1value} from lookup_master where ${TablesColumnFile.mcodetype} = $codeType ORDER BY ${TablesColumnFile.mcodedesc} ;');
    } else {
      print(
          "select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile.mcodetype},${TablesColumnFile.mcode},${TablesColumnFile.mfield1value} from lookup_master where ${TablesColumnFile.mcodetype} = $codeType "
              "  AND  ${TablesColumnFile.mfield1value} LIKE '${field1Value}~%' ORDER BY ${TablesColumnFile.mcodedesc} ; ");
      result = await db.rawQuery(
          "select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile.mcodetype},${TablesColumnFile.mcode},${TablesColumnFile.mfield1value} from lookup_master where ${TablesColumnFile.mcodetype} = $codeType "
          "  AND  ${TablesColumnFile.mfield1value} LIKE '${field1Value}~%' ORDER BY ${TablesColumnFile.mcodedesc} ; ");
    }

    try {
      for (int i = 0; i < result.length; i++) {
        //print(result[i]);
        for (var items in result[i].toString().split(",")) {
          //print(items);
        }
        //print(result[i].runtimeType);
        retBean = LookupBeanData.fromJson(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future deletSomeUtil() async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete("Delete FROM ${customerFoundationMasterDetails} ");
    });
    await db.transaction((Transaction txn) async {
      await txn.rawDelete("Delete FROM ${imageMaster} ");
    });
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          "Delete FROM ${customerFoundationBorrowingMasterDetails} ");
    });
    await db.transaction((Transaction txn) async {
      await txn
          .rawDelete("Delete FROM ${customerFoundationAddressMasterDetails} ");
    });
    await db.transaction((Transaction txn) async {
      await txn
          .rawDelete("Delete FROM ${customerFoundationFamilyMasterDetails} ");
    });
  }

  Future deletSomeLoanUtil() async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(
          "Delete FROM ${customerLoanDetailsMaster} Where loanNumber in (2,1,3)");
    });
  }

  Future<String> getImageStringPath(String imageString) async {
    print("image String is ${imageString}");
    if (imageString != null &&
        imageString != "null" &&
        imageString.trim() != "") {
      Uint8List bytes = base64.decode(imageString);
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures/eco_mfi/syncedNOCImage';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${timestamp()}.jpg';
      File file = new File(filePath);

      await file.writeAsBytes(bytes);
      return filePath;
    }

    return "";
  }

  Future insertStaticTablesLastSyncedMaster(
      List<LastSyncedDateTime> staticValues, int idValue) async {
    print("trying toinsert or replace $idValue");
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT ${TablesColumnFile.id} FROM ${lastSyncedDateTimeMaster} where ${TablesColumnFile.id} = $idValue');
    bool isInsert = false;
    int id;
    try {
      if (result[0][TablesColumnFile.id].toString() != null) {
        id = result[0][TablesColumnFile.id];
        isInsert = true;
      }
    } catch (_) {
      print("exception here ");
    }

    print("trying to insert or replace ${lastSyncedDateTimeMaster}");
    if (!isInsert) {
      for (int i = 0; i < staticValues.length; i++) {
        String insertQuery =
            "INSERT OR REPLACE INTO ${lastSyncedDateTimeMaster}  "
            "(${TablesColumnFile.id},"
            "${TablesColumnFile.tTabelDesc},"
            "${TablesColumnFile.tlastSyncedFromTab},"
            "${TablesColumnFile.tlastSyncedToTab})"
            "VALUES "
            "("
            "${staticValues[i].id},"
            "'${staticValues[i].tTabelDesc}',"
            "'${staticValues[i].tlastSyncedFromTab}',"
            "'${staticValues[i].tlastSyncedToTab}'); ";

        await db.transaction((Transaction txn) async {
          int id = await txn.rawInsert(insertQuery);
        });
      }
    }
  }

  Future<DateTime> selectStaticTablesLastSyncedMaster(
      int idValue, bool toMiddleware) async {
    print("trying toinsert or replace $idValue");
    String selectQuery = toMiddleware
        ? 'SELECT ${TablesColumnFile.tlastSyncedToTab} FROM ${lastSyncedDateTimeMaster} where ${TablesColumnFile.id} = $idValue'
        : 'SELECT ${TablesColumnFile.tlastSyncedFromTab} FROM ${lastSyncedDateTimeMaster} where ${TablesColumnFile.id} = $idValue';
    var db = await _getDb();
    var result = await db.rawQuery(selectQuery);

    try {
      if (result[0].length > 0 && toMiddleware
          ? result[0][TablesColumnFile.tlastSyncedToTab].toString() != null
          : result[0][TablesColumnFile.tlastSyncedFromTab].toString() != null) {
        return DateTime.parse(toMiddleware
            ? result[0][TablesColumnFile.tlastSyncedToTab]
            : result[0][TablesColumnFile.tlastSyncedFromTab]);
      }
    } catch (_) {
      print("exception here ");
    }
  }

  Future<Null> updateStaticTablesLastSyncedMaster(int idValue) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "UPDATE ${lastSyncedDateTimeMaster} SET ${TablesColumnFile.tlastSyncedFromTab} = '${DateTime.now()}' WHERE ${TablesColumnFile.id} = ${idValue}");

    print(
        "UPDATE ${lastSyncedDateTimeMaster} SET ${TablesColumnFile.tlastSyncedFromTab} = '${DateTime.now()}' WHERE ${TablesColumnFile.id} = ${idValue}");
  }

  Future<Null> updateStaticTablesLastSyncedMasterGetFromServer(
      int idValue, DateTime updateDateimeAfterUpdate) async {
    var db = await _getDb();
    var result = await db.rawQuery(
        "UPDATE ${lastSyncedDateTimeMaster} SET ${TablesColumnFile.tlastSyncedToTab} = '${updateDateimeAfterUpdate}' WHERE ${TablesColumnFile.id} = ${idValue}");

    print("aafter update result hai ${result}");
    print(result);
    // var result1 =
    //     await db.rawQuery('SELECT * FROM ${lastSyncedDateTimeMaster} where  ${TablesColumnFile.id} = ${idValue} ');
    // print("query -- updateStaticTablesLastSyncedMaster");
    // print("Kya vo table exist krta hai ${result1}");
  }

  Future deletSomeSyncingActivityFromOmni(String forWhat) async {
    var db = await _getDb();
    String deleteQueryFor = "";
    if (forWhat == 'Center') {
      deleteQueryFor = "Delete FROM ${centerDetailsMaster}";
    } else if (forWhat == 'Group') {
      deleteQueryFor = "Delete FROM ${groupFoundationMaster}";
    } else if (forWhat == 'Lookup') {
      deleteQueryFor = "Delete FROM ${LookupMaster}";
    } else if (forWhat == 'SubLookup') {
      deleteQueryFor = "Delete FROM ${SubLookupMaster}";
    } else if (forWhat == 'Product') {
      deleteQueryFor = "Delete FROM ${productMaster}";
    } else if (forWhat == 'Collection') {
      deleteQueryFor = "Delete FROM ${collectionMaster}";
    } else if (forWhat == 'Loan_Cycle_Parameter_Secondary_Master') {
      deleteQueryFor = "Delete FROM ${LoanCycleParameterSecondaryMaster}";
    } else if (forWhat == 'Loan_Cycle_Parameter_Primary_Master') {
      deleteQueryFor = "Delete FROM ${LoanCycleParameterPrimaryMaster}";
    } else if (forWhat == 'Interest_Offset_Master') {
      deleteQueryFor = "Delete FROM ${InterestOffsetMaster}";
    } else if (forWhat == 'Interest_Slab_Master') {
      deleteQueryFor = "Delete FROM ${InterestSlabMaster}";
    } else if (forWhat == 'collectedLoansAmtMaster') {
      deleteQueryFor = "Delete FROM ${collectedLoansAmtMaster}";
    } else if (forWhat == 'SystemParameterMaster') {
      deleteQueryFor = "Delete FROM ${SystemParameterMaster}";
    } else if (forWhat == 'Loan_Approval_limit_Master') {
      deleteQueryFor = "Delete FROM ${loanApprovalLimitMaster}";
    } else if (forWhat == 'Branch_Master') {
      deleteQueryFor = "Delete FROM ${branchMaster}";
    } else if (forWhat == 'TD_Productwise_interest_table') {
      deleteQueryFor = "Delete FROM ${TDProductwiseInterestTable}";
    } else if (forWhat == 'TD_Offset_Interest_Master') {
      deleteQueryFor = "Delete FROM ${TDOffsetInterestMaster}";
    } else if (forWhat == 'TD_Parameter_Master') {
      deleteQueryFor = "Delete FROM ${tdParameterMaster}";
    } else if (forWhat == 'User_Rights_table') {
      deleteQueryFor = "Delete FROM ${UserRightsTable}";
    } else if (forWhat == 'MENUS_MASTER') {
      deleteQueryFor = "Delete FROM ${MenuMaster}";
    } else if (forWhat == 'Disbursment_Master') {
      deleteQueryFor = "Delete FROM ${disbursmentMaster}";
    } else if (forWhat == 'User_Vault_Balance') {
      deleteQueryFor = "Delete FROM ${userVaultBalance}";
    } else if (forWhat == 'Charts_Master') {
      deleteQueryFor = "Delete FROM ${CHARTMASTER}";
    }
    await db.transaction((Transaction txn) async {
      await txn.rawDelete(deleteQueryFor);
    });
  }

  Future<double> selectSlabIntRate(String prdCode, String mcurcd,
      double appliedAmout, int mlbrCd, int installment, int loanCycle) async {
    String selectSlabRoiQuery =
        'SELECT   ${TablesColumnFile.mintrate} FROM ${InterestSlabMaster} WHERE '
        '${TablesColumnFile.mprdcd} = "${prdCode}"  AND ${TablesColumnFile.mcurcd} = "${mcurcd}" '
        'AND ${TablesColumnFile.minteffdt} = (SELECT max(${TablesColumnFile.minteffdt}) FROM '
        '${InterestSlabMaster} WHERE ${TablesColumnFile.mprdcd} = "${prdCode}" AND ${TablesColumnFile.mcurcd}'
        ' = "${mcurcd}") AND ${TablesColumnFile.mtoamt} >= $appliedAmout  ORDER BY ${TablesColumnFile.msrno} LIMIT 1';
    print(selectSlabRoiQuery);
    try {
      double salbInt = 0.0;
      var db = await _getDb();
      var result = await db.rawQuery(selectSlabRoiQuery);
      if (result.length > 0 && result[0] != null) {
        salbInt = result[0][TablesColumnFile.mintrate];
      }

      String selectOffsetRoiQuery =
          'SELECT  ${TablesColumnFile.mintrestrate} FROM ${InterestOffsetMaster} WHERE '
          '${TablesColumnFile.mlbrcode} = ${mlbrCd} AND ${TablesColumnFile.mprdCd} = "$prdCode" AND '
          '${TablesColumnFile.mloantype} = 1 AND ${TablesColumnFile.mloancycle} = $loanCycle   AND '
          '${TablesColumnFile.meffdate} = (SELECT max(${TablesColumnFile.meffdate}) FROM '
          '${InterestOffsetMaster} WHERE ${TablesColumnFile.mlbrcode} = ${mlbrCd} AND '
          '${TablesColumnFile.mprdcd} = "$prdCode" AND ${TablesColumnFile.mloantype} = 1 AND '
          '${TablesColumnFile.mloancycle} = $loanCycle)   AND ${TablesColumnFile.mmonths} >= $installment AND '
          '${TablesColumnFile.mamount} >= $appliedAmout  ORDER BY ${TablesColumnFile.msrno} LIMIT 1';

      print("selectSlabRoiQuery " + selectSlabRoiQuery.toString());
      print("selectOffsetRoiQuery " + selectOffsetRoiQuery.toString());

      double offsetInt = 0.0;
      result = await db.rawQuery(selectOffsetRoiQuery);
      print("print data " + result.toString());
      if (result.length > 0 && result[0] != null) {
        offsetInt = result[0][TablesColumnFile.mintrestrate];
      } else {
        selectOffsetRoiQuery =
        'SELECT  ${TablesColumnFile.mintrestrate} FROM ${InterestOffsetMaster} WHERE '
            '${TablesColumnFile.mlbrcode} = ${mlbrCd} AND ${TablesColumnFile.mprdCd} = "$prdCode" AND '
            '${TablesColumnFile.mloantype} = 1 AND ${TablesColumnFile.mloancycle} = 99   AND '
            '${TablesColumnFile.meffdate} = (SELECT max(${TablesColumnFile.meffdate}) FROM '
            '${InterestOffsetMaster} WHERE ${TablesColumnFile.mlbrcode} = ${mlbrCd} AND '
            '${TablesColumnFile.mprdcd} = "$prdCode" AND ${TablesColumnFile.mloantype} = 1 AND '
            '${TablesColumnFile.mloancycle} = 99)   AND ${TablesColumnFile.mmonths} >= $installment AND '
            '${TablesColumnFile.mamount} >= $appliedAmout  ORDER BY ${TablesColumnFile.msrno} LIMIT 1';

        result = await db.rawQuery(selectOffsetRoiQuery);

        print("selectOffsetRoiQuery99 " + selectOffsetRoiQuery.toString());

        if (result.length > 0 && result[0] != null) {
          offsetInt = result[0][TablesColumnFile.mintrestrate];
        }
      }

      return salbInt + (offsetInt);
    } catch (_) {
      print("exception here ");
    }
  }

  void bubbleSortAlgo(List<InterestSlabBean> interestSlabBean) {
    int mainListLength = interestSlabBean.length;
    for (int firstElement = 0;
    firstElement < mainListLength - 1;
    firstElement++)
      for (int compareNext = 0;
      compareNext < mainListLength - firstElement - 1;
      compareNext++)
        if (interestSlabBean[compareNext].mtoamt >
            interestSlabBean[compareNext + 1].mtoamt &&
            interestSlabBean[compareNext]
                .minteffdt
                .isAfter(interestSlabBean[compareNext + 1].minteffdt)) {
          // swap arr[j+1] and arr[i]
          InterestSlabBean temp = interestSlabBean[compareNext];
          interestSlabBean[compareNext] = interestSlabBean[compareNext + 1];
          interestSlabBean[compareNext + 1] = temp;
        }
  }

  Future<DateTime> selectlastSyncedDateTimeToTab(int idValue) async {
    print("trying fetch  $idValue");
    var db = await _getDb();
    var result = await db.rawQuery(
        'SELECT ${TablesColumnFile.tlastSyncedToTab} FROM ${lastSyncedDateTimeMaster} where ${TablesColumnFile.id} = $idValue');

    try {
      if (result[0][TablesColumnFile.tlastSyncedToTab] != null &&
          result[0][TablesColumnFile.tlastSyncedToTab] != 'null') {
        return DateTime.parse(result[0][TablesColumnFile.tlastSyncedToTab]);
      } else {
        print("Returning null");
        return null;
      }
    } catch (_) {
      print("exception here ");
    }
  }

  Future<CreditBereauBean> checkTrefMref(int trefNo, int mrefNo) async {
    CreditBereauBean bean;
    var db = await _getDb();
    String query =
        'SELECT *  FROM ${creditBereauMaster} where ${TablesColumnFile.trefno} = $trefNo And '
        '${TablesColumnFile.mrefno} = $mrefNo';

    print(query);
    var result = await db.rawQuery(query);

    print("result");

    try {
      print("Credit Bereau me");
      if (result.isNotEmpty) {
        bean = bindCreditBereauBean(result[0]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }

    return bean;
  }

  Future updateCreditBereauMasterMrefFromTref(CreditBereauBean cbb, int trefNo,
      int mrefNo, DateTime mlastSynsDate, bool alreadyExist) async {
    var db = await _getDb();
    var str = alreadyExist == true
        ? " ${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile.mrefno} = ${mrefNo}"
        : " ${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile.mrefno} = 0";

    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mrefno} = ${mrefNo} "
        ",${TablesColumnFile.mlastsynsdate} = '$mlastSynsDate' WHERE $str";
    print(" heyyy update query is $query");

    var result = await db.rawQuery(query);

    print("CreditBereauMaster Updated");
  }

  Future updateCreditBereauMasterlstUpdtDate(
      DateTime lastSynsDate, int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        " ${TablesColumnFile.trefno} = $trefNo AND ${TablesColumnFile.mrefno} = $mrefNo";

    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mrefno} = ${mrefNo} "
        ",${TablesColumnFile.mlastsynsdate} = '$lastSynsDate' WHERE $str";
    print(query);

    var result = await db.rawQuery(query);

    print("CreditBereauMaster Updated For ABM ");
  }

  Future updatelastSyncDateTimeMasterFromTab(
      DateTime lastSyncedFromTab, int id) async {
    var db = await _getDb();
    var str = "${TablesColumnFile.id} = $id";

    String query =
        "Update $lastSyncedDateTimeMaster SET ${TablesColumnFile.tlastSyncedFromTab} = '$lastSyncedFromTab' "
        " WHERE $str";
    print(query);

    var result = await db.rawQuery(query);

    print("last Synced Master Updated ");
  }

  Future updatelastSyncDateTimeMasterToTab(
      DateTime tLastSyncedToTab, int id) async {
    var db = await _getDb();
    var str = "${TablesColumnFile.id} = $id";

    String query =
        "Update $lastSyncedDateTimeMaster SET ${TablesColumnFile.tlastSyncedToTab} = '$tLastSyncedToTab' "
        " WHERE $str";
    print(query);

    var result = await db.rawQuery(query);

    print("last Synced To Tab  Master Updated ");
  }

  Future updateCreditBereauLoanDetailsForImage(
      CbResultBean creditBereauResultBean, int trefsrno) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${creditBereauLoanDetailsMaster}( "
        "${TablesColumnFile.trefno}  ,"
        "${TablesColumnFile.mrefno}  ,"
        "${TablesColumnFile.mrefsrno}  ,"
        "${TablesColumnFile.trefsrno}  ,"
        "${TablesColumnFile.maccounttype}  ,"
        "${TablesColumnFile.mcurrentbalance}  ,"
        "${TablesColumnFile.mcustbankacnum}  ,"
        "${TablesColumnFile.mdatereported}  ,"
        "${TablesColumnFile.mdisbursedamount}  ,"
        "${TablesColumnFile.mnameofmfi}  ,"
        "${TablesColumnFile.mnocimagestring}  ,"
        "${TablesColumnFile.moverdueamount}  ,"
        "${TablesColumnFile.mwriteoffamount},"
        "${TablesColumnFile.mmfiid}"
        ")VALUES("
        "${creditBereauResultBean.trefno} ,"
        "${creditBereauResultBean.mrefno} ,"
        "${creditBereauResultBean.mrefsrno}, "
        "${trefsrno} ,"
        "'${creditBereauResultBean.maccounttype}' ,"
        "${creditBereauResultBean.mcurrentbalance} ,"
        "'${creditBereauResultBean.mcustbankacnum}' ,"
        "'${creditBereauResultBean.mdatereported}' ,"
        "${creditBereauResultBean.mdisbursedamount} ,"
        "'${creditBereauResultBean.mnameofmfi}' ,"
        "'${await getImageStringPath(creditBereauResultBean.mnocimagestring)}' ,"
        "${creditBereauResultBean.moverdueamount} ,"
        "${creditBereauResultBean.mwriteoffamount},"
        "'${creditBereauResultBean.mmfiid}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${creditBereauLoanDetailsMaster}");
    });
  }

  Future updateCreditBereauLoanDetailsTrefSrNo(
      CbResultBean creditBereauResultBean,
      int trefsrno,
      bool alreadyExist) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery;

    if (alreadyExist == false) {
      insertQuery =
      "Update ${creditBereauLoanDetailsMaster}  SET ${TablesColumnFile.mrefsrno} =  ${creditBereauResultBean.mrefsrno},"
          "${TablesColumnFile.mrefno} = ${creditBereauResultBean.mrefno}"
          " WHERE ${TablesColumnFile.trefno} = ${creditBereauResultBean.trefno}  AND "
          " ${TablesColumnFile.mrefno} =  0 "
          "AND ${TablesColumnFile.trefsrno} =  ${trefsrno}"
          ";";
    } else {
      insertQuery =
      "Update ${creditBereauLoanDetailsMaster}  SET ${TablesColumnFile.mrefsrno} =  ${creditBereauResultBean.mrefsrno}"
          " WHERE ${TablesColumnFile.trefno} = ${creditBereauResultBean.trefno}  AND "
          " ${TablesColumnFile.mrefno} = ${creditBereauResultBean.mrefno} "
          " AND ${TablesColumnFile.trefsrno} =  ${trefsrno}"
          ";";
    }

    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() +
          " id after insert in ${creditBereauLoanDetailsMaster}");
    });
  }

  Future searchMrefTref(int mrefno, int trefno) async {
    String searchQuery =
        "SELECT * FROM ${creditBereauMaster} WHERE ${TablesColumnFile.mrefno} = ${mrefno}  "
        "AND ${TablesColumnFile.trefno} = $trefno";

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(searchQuery);
      print(id.toString() +
          " Search query after ${creditBereauLoanDetailsMaster}");
    });
  }

  Future updateCrdtBreuMastrPrspctStatus(int trefNo, int mrefNo,
      int prospectStatus, DateTime mlastUpdatedt, DateTime lastSynsDate) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile.mrefno} = ${mrefNo}";
    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mprospectstatus} "
        "= ${prospectStatus} , ${TablesColumnFile.mlastsynsdate} "
        "= '${lastSynsDate}',${TablesColumnFile.mlastupdatedt} = '$mlastUpdatedt' WHERE $str";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("CreditBereauMaster Updated");
  }

  Future trialrun(int trefNo, int mrefNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile.mrefno} = ${mrefNo}";
    String query1 = "delete from  $creditBereauResultMaster "
        "where ${TablesColumnFile.trefno}  = $trefNo AND  ${TablesColumnFile.mrefno} = ${mrefNo} ";
    String query2 = "delete from  $creditBereauLoanDetailsMaster "
        "where ${TablesColumnFile.trefno}  = $trefNo AND  ${TablesColumnFile.mrefno} = ${mrefNo} ";

    String query3 =
        "update ${creditBereauMaster} set ${TablesColumnFile.misuploaded} = 0  ,"
        "${TablesColumnFile.mrefno} = 0  ,${TablesColumnFile.mlastsynsdate} = '${DateTime.now()}',"
        "${TablesColumnFile.mlastupdatedt} = '${DateTime.now()}' "
        "where ${TablesColumnFile.trefno}  = $trefNo";
    print("xxxxxxxxxxxxxxquery is here : " + query1);
    var result = await db.rawQuery(query1);
    result = await db.rawQuery(query2);
    result = await db.rawQuery(query3);
    print("CreditBereauMaster Updated");
  }

  Future updateCreditBereauResultTrefSrNo(
      CbResultBean creditBereauResultBean, int trefsrno) async {
    print("trying to insert or replace ${creditBereauLoanDetailsMaster}");
    String insertQuery =
        "Update ${creditBereauResultMaster}  SET ${TablesColumnFile.mrefno} =  ${creditBereauResultBean.mrefno}"
        " WHERE ${TablesColumnFile.trefno} = ${creditBereauResultBean.trefno}  AND "
        " ${TablesColumnFile.mrefno} = 0"
        ";";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${creditBereauResultMaster}");
    });
  }

  Future<int> getMinMrefNoCreditBereauMaster(int trefNo) async {
    int minMref;

    var db = await _getDb();
    var str = "${TablesColumnFile.trefno} = ${trefNo} ";
    String query =
        "SELECT MIN(${TablesColumnFile.mrefno}) AS ${TablesColumnFile.mrefno} "
        "FROM  $creditBereauMaster  WHERE $str";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    try {
      var result = await db.rawQuery(query);
      print(result);
      minMref = result[0][TablesColumnFile.mrefno];
    } catch (_) {
      print("returning null");
    }

    return minMref;
  }

  Future updateCreditBereauMasterMrefFromminMref(CreditBereauBean cbb,
      int trefNo, int mrefNo, DateTime mlastSynsDate) async {
    var db = await _getDb();
    var str =
        " ${TablesColumnFile.trefno} = ${trefNo} AND ${TablesColumnFile.mrefno} = 0";

    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.mrefno} = ${mrefNo} "
        ", ${TablesColumnFile.mprospectstatus} = ${cbb.mprospectstatus} "
        " ,  ${TablesColumnFile.mlastupdatedt} = '${cbb.mlastupdatedt}'"
        ",  ${TablesColumnFile.mlastupdateby} = '${cbb.mlastupdateby}'"
        ",${TablesColumnFile.mlastsynsdate} = '$mlastSynsDate' WHERE $str";
    print(query);

    var result = await db.rawQuery(query);

    print("CreditBereauMaster Updated");
  }

  //select CGT1 based on Tref
  Future<CGT1Bean> selectCGT1OnTref(int trefno, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CGT1Master}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = ${mrefno} ';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    if (result.isEmpty) {
      selectQueryIsDataSynced =
      'SELECT * FROM ${CGT1Master}  WHERE ${TablesColumnFile.trefno}  = $trefno '
          ' AND ${TablesColumnFile.mrefno}  = 0 ';

      result = await db.rawQuery(selectQueryIsDataSynced);
    }
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CGT1Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CGT1Bean();
        bean = bindDataCGT1ListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateCGT1MasterAfterSync(String query) async {
    print("data from cgt master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CGT1Master} SET ${query}");
    });
  }

  Future updateCGT1QAMasterAfterSync(String query) async {
    print("data from cgt1 qa master " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${cgt1QaMaster} SET ${query}");
    });
  }

  Future<CGT2Bean> selectCGT2OnTref(int trefno, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CGT2Master}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = $mrefno';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    if (result.isEmpty) {
      selectQueryIsDataSynced =
      'SELECT * FROM ${CGT2Master}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = 0 ';

      result = await db.rawQuery(selectQueryIsDataSynced);
    }
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CGT2Bean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CGT2Bean();
        bean = bindDataCGT2ListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateCGT2MasterAfterSync(String query) async {
    print("datafrom cgt2 master " + query.toString());
    print("datafrom cgt2 master " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CGT2Master} SET ${query}");
    });
  }

  Future updateCGT2QAMasterAfterSync(String query) async {
    print("data from cgt2QA master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${cgt2QaMaster} SET ${query}");
    });
  }

  Future<GRTBean> selectGRTOnTref(int trefno, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${GRTMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno'
        ' AND ${TablesColumnFile.mrefno}  = $mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    if (result.isEmpty) {
      selectQueryIsDataSynced =
      'SELECT * FROM ${GRTMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno '
          ' AND ${TablesColumnFile.mrefno}  = 0}';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    GRTBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GRTBean();
        bean = bindDataGRTListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateGRTMasterAfterSync(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${GRTMaster} SET ${query}");
    });
  }

  Future updateGRTQAMasterAfterSync(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${grtQaMaster} SET ${query}");
    });
  }

  Future updateCG1WhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CGT1Master} SET ${query}");
    });
  }

  Future updateCG2WhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CGT2Master} SET ${query}");
    });
  }

  Future updateGRTWhileLoanSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${GRTMaster} SET ${query}");
    });
  }

  //select FamilyList
  Future<List<HouseholdExpenditureDetailsBean>>
  selectCustomerHouseHoldExpDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${houseExpenseMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${houseExpenseMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<HouseholdExpenditureDetailsBean> listbean =
    new List<HouseholdExpenditureDetailsBean>();
    HouseholdExpenditureDetailsBean bean;
    try {
      print("family mai");
      for (int i = 0; i < result.length; i++) {
        bean = new HouseholdExpenditureDetailsBean();
        bean = bindDataCustomerHouseholdExpenseListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //select FamilyList
  Future<List<BusinessExpenditureDetailsBean>>
  selectCustomerBussHoldExpDetailsListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${businessExpenseMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${businessExpenseMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<BusinessExpenditureDetailsBean> listbean =
    new List<BusinessExpenditureDetailsBean>();
    BusinessExpenditureDetailsBean bean;
    try {
      print("family mai");
      for (int i = 0; i < result.length; i++) {
        bean = new BusinessExpenditureDetailsBean();
        bean = bindDataCustomerBusinessExpenseListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future updateBussExpDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print(
          "Business Expense --- UPDATE ${businessExpenseMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${businessExpenseMaster} SET ${query}");
    });
  }

  Future updateHouseHolddExpDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Borrowing --- UPDATE ${houseExpenseMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${houseExpenseMaster} SET ${query}");
    });
  }

  Future updateHouseHoldExpDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Household Expense --- UPDATE ${houseExpenseMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${houseExpenseMaster} SET ${query}");
    });
  }

  Future updateAssetDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("Asset Detail --- UPDATE ${assetDetailMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${assetDetailMaster} SET ${query}");
    });
  }

  Future<int> updateCustomerPPIDetailsListTable(
      CustomerListBean custListBean) async {
    int id;
    int ppirefno = 0;
    for (PPIMasterBean item in custListBean.pPIMasterBean) {
      item.mrefno = custListBean.mrefno;
      ppirefno++;
      item.tPpirefno = ppirefno;
      id = await updateCustomerPPIBeanTable(item);
    }
    return id;
  }

  // business and house hold expense detail
  Future<int> updateCustomerPPIBeanTable(PPIMasterBean bean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${PPIMaster} "
        "(${TablesColumnFile.tPpirefno}  ,"
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mPpirefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mitem} ,"
        "${TablesColumnFile.mhaveyn} ,"
        "${TablesColumnFile.mnoofitems} ,"
        "${TablesColumnFile.mweightage} ,"
        "${TablesColumnFile.mquestiontype} "
        " )"
        "VALUES"
        "(${bean.tPpirefno} ,"
        "${bean.trefno},"
        "${bean.mPpirefno} ,"
        "${bean.mrefno} ,"
        "${bean.mcustno} ,"
        "'${bean.mitem}' ,"
        "'${bean.mhaveyn}' ,"
        "${bean.mnoofitems} ,"
        "${bean.mweightage} , "
        "'${bean.mquestiontype}'"
        " );";
    print("insert query  PPIMaster master is" + insertQuery);
    int idAfterInsert;
    await db.transaction((Transaction txn) async {
      idAfterInsert = await txn.rawInsert(insertQuery);
      print(idAfterInsert.toString() + " id after insert in ${PPIMaster}");
    });
    return idAfterInsert;
  }

  Future<List<PPIMasterBean>> selectCustomerPPIListIsDataSynced(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();

    String selectQuery =
        "SELECT * FROM ${PPIMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo";
    print("select query is ${selectQuery} ");
    var result = await db.rawQuery(
        "SELECT * FROM ${PPIMaster}  WHERE ${TablesColumnFile.trefno}  = $tRefNo AND  ${TablesColumnFile.mrefno} = $mRefNo");
    List<PPIMasterBean> listbean = new List<PPIMasterBean>();
    PPIMasterBean bean;
    try {
      print("household expenditure mai");
      for (int i = 0; i < result.length; i++) {
        bean = new PPIMasterBean();
        bean = bindDataCustomerPPIListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  PPIMasterBean bindDataCustomerPPIListBean(Map<String, dynamic> result) {
    return PPIMasterBean.fromMap(result);
  }

  Future updatePpiDetails(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      print("PPI --- UPDATE ${PPIMaster} SET ${query}");
      await txn.rawQuery("UPDATE ${PPIMaster} SET ${query}");
    });
  }

  Future updateCreditBereauMasterisCuCrtd(
      String mpanNo, String imdDesc, int iscustCretedFlag, int custNo) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.mpanno} = '${mpanNo}' OR ${TablesColumnFile.mpanno} = '${imdDesc}' OR "
        "${TablesColumnFile.mid1desc} = '${mpanNo}' OR ${TablesColumnFile.mid1desc} = '${imdDesc}'";
    String query =
        "Update $creditBereauMaster SET ${TablesColumnFile.miscustcreated} "
        "= ${iscustCretedFlag}"
        ", ${TablesColumnFile.mcustno}  = ${custNo}"
        " WHERE $str";

    print("xxxxxxxxxxxxxx query is here : " + query);
    var result = await db.rawQuery(query);
    print(result);
    print("CreditBereauMaster Updated");
  }

  Future<CustomerListBean> custTrefMrefFromId(
      String mpanNo, String mid1) async {
    var db = await _getDb();
    CustomerListBean bean;
    var str =
        "${TablesColumnFile.mpannodesc} = '${mpanNo}' OR ${TablesColumnFile.mpannodesc} = '${mid1}' OR "
        "${TablesColumnFile.mIdDesc} = '${mpanNo}' OR ${TablesColumnFile.mIdDesc} = '${mid1}'";
    String query =
        "SELECT * FROM ${customerFoundationMasterDetails}  where $str ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("customer Foundation mater select query");

    try {
      bean = new CustomerListBean();
      bean = bindDataCustomerListBean(result[0]);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<StateDropDownList> getState(stateCd) async {
    var db = await _getDb();
    StateDropDownList bean;
    var str = "${TablesColumnFile.stateCd} = '${stateCd}' ";
    String query = "SELECT * FROM ${stateMaster}  where $str ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    try {
      print(result[0].runtimeType);
      bean = bindStateDropDownBean(result[0]);
    } catch (e) {
      print(e.toString());
    }
    return bean;
  }

  Future<DistrictDropDownList> getdist(distCd) async {
    var db = await _getDb();
    DistrictDropDownList bean;
    var str = "${TablesColumnFile.distCd} = '${distCd}' ";
    String query = "SELECT * FROM ${districtMaster}  where $str ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    try {
      print(result[0].runtimeType);
      bean = bindDistrictDropDownBean(result[0]);
    } catch (e) {
      print(e.toString());
    }
    return bean;
  }

  Future<CustomerListBean> updateCustHighRprtDate(String mpanNo, String mid1,
      double expsrAmt, DateTime mcbcheckrprtdt, int cbCheckStat) async {
    var db = await _getDb();
    CustomerListBean bean;
    var str =
        "${TablesColumnFile.mpannodesc} = '${mpanNo}' OR ${TablesColumnFile.mpannodesc} = '${mid1}' OR "
        "${TablesColumnFile.mIdDesc} = '${mpanNo}' OR ${TablesColumnFile.mIdDesc} = '${mid1}'";
    String query = "UPDATE ${customerFoundationMasterDetails} SET "
        "${TablesColumnFile.mexpsramt} = $expsrAmt "
        ",${TablesColumnFile.misCbCheckDone} = $cbCheckStat"
        ",${TablesColumnFile.mcbcheckrprtdt} = '$mcbcheckrprtdt' "
        "WHERE $str ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("customer Foundation mater update query");

    return bean;
  }

  Future<String> getQuesDesc(int mcodetype, String mitem,
      [mfield1value]) async {
    var db = await _getDb();

    var result;
    LookupBeanData bean;
    if (mfield1value == null) {
      print("query is" +
          "select * from  ${LookupMaster} where ${TablesColumnFile.mcodetype} =  $mcodetype AND ${TablesColumnFile.mcode} = '${mitem}' ");
      await db.transaction((Transaction txn) async {
        result = await txn.rawQuery(
            "select * from  ${LookupMaster} where ${TablesColumnFile.mcodetype} =  $mcodetype AND ${TablesColumnFile.mcode} = '${mitem}' ");
      });
    } else {
      print("query is" +
          "select * from  ${LookupMaster} where ${TablesColumnFile.mcodetype} =  $mcodetype AND ${TablesColumnFile.mcode} = '${mitem}' "
              " AND ${TablesColumnFile.mfield1value} LIKE '${mfield1value}~%' ");
      await db.transaction((Transaction txn) async {
        result = await txn.rawQuery(
            "select * from  ${LookupMaster} where ${TablesColumnFile.mcodetype} =  $mcodetype AND ${TablesColumnFile.mcode} = '${mitem}' "
            " AND ${TablesColumnFile.mfield1value} LIKE '${mfield1value}~%' ");
      });
    }

    try {
      for (int i = 0; i < result.length; i++) {
        //print(result[i]);
        // for (var items in result[i].toString().split(",")) {
        //   print(items);
        // }
        //print(result[i].runtimeType);
        bean = LookupBeanData.fromJson(result[i]);
        break;
      }
    } catch (e) {
      print(e.toString());
    }
    return bean != null && bean.mcodedesc != null && bean.mcodedesc != 'null'
        ? bean.mcodedesc
        : "";
  }

  Future<String> getAnswerDesc(int mcodetype, String mitem) async {
    var db = await _getDb();
    var result;
    LookupBeanData bean;
    print("query is" +
        "select * from  ${SubLookupMaster} where ${TablesColumnFile.mcodetype} =  $mcodetype AND ${TablesColumnFile.mcode} = '${mitem}' ");
    await db.transaction((Transaction txn) async {
      result = await txn.rawQuery(
          "select * from  ${SubLookupMaster} where ${TablesColumnFile.mcodetype} =  $mcodetype AND ${TablesColumnFile.mcode} = '${mitem}' ");
    });

    try {
      for (int i = 0; i < result.length; i++) {
        // print(result[i]);
        // for (var items in result[i].toString().split(",")) {
        //   print(items);
        // }
        //print(result[i].runtimeType);
        bean = LookupBeanData.fromJson(result[i]);
        break;
      }
    } catch (e) {
      print(e.toString());
    }
    return bean != null && bean.mcodedesc != null && bean.mcodedesc != 'null'
        ? bean.mcodedesc
        : "";
  }

  Future<CreditBereauBean> getLastProspectFromId(
      String mpanNo, String mid1) async {
    var db = await _getDb();
    CreditBereauBean bean;
    var str =
        "${TablesColumnFile.mpanno} = '${mpanNo}' OR ${TablesColumnFile.mpanno} = '${mid1}' OR "
        "${TablesColumnFile.mid1desc} = '${mpanNo}' OR ${TablesColumnFile.mid1desc} = '${mid1}'";
    String query = "SELECT * FROM ${creditBereauMaster}  where $str  "
        "ORDER BY ${TablesColumnFile.mcreateddt} DESC ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print("Credit Bereau Master updated");

    try {
      bean = bindCreditBereauBean(result[0]);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  //collection master

  Future<List<CollectionMasterBean>> getCollectionMasterDataFromLocalDb(
      int mcenterid,
      int mgroupid,
      DateTime fromDate,
      DateTime toDate,
      int mcustno,
      int mprdcd,
      bool memOfGrpYN,
      int skipAlredyColl) async {
    var db = await _getDb();
    CollectionMasterBean retBean = new CollectionMasterBean();
    List<CollectionMasterBean> n = new List<CollectionMasterBean>();
    var result;

    String seleQuery = "";

    if (mcustno != 0 && mcustno != null) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " + TablesColumnFile.mprdcd + " = " + mprdcd.toString()} "
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupid + " = " + mgroupid.toString()} ";
      "${memOfGrpYN == true ? "" : " AND " + TablesColumnFile.mappliedasind + " <> 'Y'"} ; ";
    } else if (mprdcd != 0 && mprdcd != null) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupid + " = " + mgroupid.toString()} ";
      "${memOfGrpYN == true ? "" : " AND " + TablesColumnFile.mappliedasind + " <> 'Y'"} ; ";
    } else if (mcenterid != 0 && mcenterid != null) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " + TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()}"
          "${mgroupid == 0 || mgroupid == null ? "" : " AND " + TablesColumnFile.mgroupid + " = " + mgroupid.toString()}  ";
      "${memOfGrpYN == true ? "" : " AND " + TablesColumnFile.mappliedasind + " <> 'Y'"} ; ";
    } else if (mgroupid != 0 && mgroupid != null) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mgroupid + " = " + mgroupid.toString()}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " + TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcenterid == 0 || mcenterid == null ? "" : " AND " + TablesColumnFile.mcenterid + " = " + mcenterid.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} "
          "${memOfGrpYN == true ? "" : " AND " + TablesColumnFile.mappliedasind + " <> 'Y'"} ; ";
    } else {
      seleQuery = "Select * from ${collectionMaster} ";
    }

    if (memOfGrpYN != null && memOfGrpYN == false) {
      seleQuery = "Select * from ${collectionMaster} WHERE "
          "${TablesColumnFile.mappliedasind + " = 'Y'"}"
          "${mprdcd == 0 || mprdcd == null ? "" : " AND " + TablesColumnFile.mprdcd + " = " + mprdcd.toString()}"
          "${mcustno == 0 || mcustno == null ? "" : " AND " + TablesColumnFile.mcustno + " = " + mcustno.toString()} ; ";
    }

    print("seleQuery" + seleQuery);
    if (seleQuery != null && seleQuery != "") {
      result = await db.rawQuery(seleQuery);
    }

    try {
      if (result.length > 0 && result[0] != null) {
        for (int i = 0; i < result.length; i++) {
          retBean = CollectionMasterBean.fromMap(result[i]);
          if (skipAlredyColl == 1) {
            await AppDatabase.get()
                .getCollectedMasterDataFromLocalDb(retBean.mprdacctid)
                .then((List<CollectionMasterBean> collectedMasterBean) async {
              print("collectedMasterBean.length ${collectedMasterBean.length}");
              if (collectedMasterBean != null &&
                  collectedMasterBean.length > 0) {
              } else {
                n.add(retBean);
              }
            });
          } else {
            n.add(retBean);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future createCollectionInsert(
      CollectionMasterBean collectionMasterBean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${collectionMaster} "
        "(${TablesColumnFile.masondate} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.macctstat} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupid} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mfocode} ,"
        "${TablesColumnFile.mleadsid} ,"
        "${TablesColumnFile.mloancycle} ,"
        "${TablesColumnFile.midealbaldate} ,"
        "${TablesColumnFile.modamt} ,"
        "${TablesColumnFile.memiamt} ,"
        "${TablesColumnFile.mcurrentdue} ,"
        "${TablesColumnFile.midealbal} ,"
        "${TablesColumnFile.memino} ,"
        "${TablesColumnFile.mexpdate} ,"
        "${TablesColumnFile.mexpprnpaid} ,"
        "${TablesColumnFile.mexpintpaid} ,"
        "${TablesColumnFile.mpaidprn} ,"
        "${TablesColumnFile.mpaidint} ,"
        "${TablesColumnFile.mprnos} ,"
        "${TablesColumnFile.mintos} ,"
        "${TablesColumnFile.mclosint} ,"
        "${TablesColumnFile.mappliedasind} ,"
        "${TablesColumnFile.mcreateddt} , "
        "${TablesColumnFile.mcreatedby} , "
        "${TablesColumnFile.mlastupdatedt} , "
        "${TablesColumnFile.mlastupdateby} , "
        "${TablesColumnFile.mgeolocation} , "
        "${TablesColumnFile.mgeolatd} , "
        "${TablesColumnFile.mgeologd} , "
        "${TablesColumnFile.mprdcd} , "
        "${TablesColumnFile.mfrequency} , "
        "${TablesColumnFile.mlongname} , "
        "${TablesColumnFile.mlastopendate} , "
        "${TablesColumnFile.mexcesspaid} ,"
        "${TablesColumnFile.msdbal} ,"
        "${TablesColumnFile.malmeffdate} ,"
        "${TablesColumnFile.moverdueint} ,"
        "${TablesColumnFile.mpenalos} ,"
        "${TablesColumnFile.moverdueprn} ,"
        "${TablesColumnFile.mschemiint} ,"
        "${TablesColumnFile.mschemiprn} "
        " )"
        "VALUES"
        "('${collectionMasterBean.masondate} ',"
        "${collectionMasterBean.mlbrcode} ,"
        "'${collectionMasterBean.mprdacctid}' ,"
        "${collectionMasterBean.macctstat} ,"
        "${collectionMasterBean.mcenterid} ,"
        "${collectionMasterBean.mgroupid} ,"
        "${collectionMasterBean.mcustno} ,"
        "'${collectionMasterBean.mfocode}' ,"
        "'${collectionMasterBean.mleadsid}' ,"
        "${collectionMasterBean.mloancycle} ,"
        "'${collectionMasterBean.midealbaldate}' ,"
        "${collectionMasterBean.modamt} ,"
        "${collectionMasterBean.memiamt} ,"
        "${collectionMasterBean.mcurrentdue} ,"
        "${collectionMasterBean.midealbal} ,"
        "${collectionMasterBean.memino} ,"
        "'${collectionMasterBean.mexpdate} ',"
        "${collectionMasterBean.mexpprnpaid} ,"
        "${collectionMasterBean.mexpintpaid} ,"
        "${collectionMasterBean.mpaidprn} ,"
        "${collectionMasterBean.mpaidint} ,"
        "${collectionMasterBean.mprnos} ,"
        "${collectionMasterBean.mintos} ,"
        "${collectionMasterBean.mclosint} ,"
        "'${collectionMasterBean.mappliedasind}' ,"
        "'${collectionMasterBean.mcreateddt}' ,"
        "'${collectionMasterBean.mcreatedby}' ,"
        "'${collectionMasterBean.mlastupdatedt}' ,"
        "'${collectionMasterBean.mlastupdateby}',"
        "'${collectionMasterBean.mgeolocation}' ,"
        "'${collectionMasterBean.mgeolatd}' ,"
        "'${collectionMasterBean.mgeologd}' ,"
        "'${collectionMasterBean.mprdcd}' ,"
        "'${collectionMasterBean.mfrequency}' ,"
        "'${collectionMasterBean.mlongname}' ,"
        "'${collectionMasterBean.mlastopendate}' ,"
        "${collectionMasterBean.mexcesspaid} ,"
        "${collectionMasterBean.msdbal} ,"
        "'${collectionMasterBean.malmeffdate}',"
        "${collectionMasterBean.moverdueint} ,"
        "${collectionMasterBean.mpenalos} ,"
        "${collectionMasterBean.moverdueprn} ,"
        "${collectionMasterBean.mschemiint} ,"
        "${collectionMasterBean.mschemiprn} "
        " );";

    await db.transaction((Transaction txn) async {
      var id = await txn.rawInsert(insertQuery);
    });
  }

  Future createCollectedAmtInsert(
      CollectionMasterBean collectionMasterBean) async {
    var db = await _getDb();

    String insertQuery = "INSERT OR REPLACE INTO ${collectedLoansAmtMaster} "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mlbrcode} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupid} ,"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mfocode} ,"
        "${TablesColumnFile.memino} ,"
        "${TablesColumnFile.malmeffdate} ,"
        "${TablesColumnFile.madjfrmsd} ,"
        "${TablesColumnFile.madjfrmexcss} ,"
        "${TablesColumnFile.mpaidbygrp} ,"
        "${TablesColumnFile.mattndnc} ,"
        "${TablesColumnFile.mremarks} ,"
        "${TablesColumnFile.mcollamt} ,"
        "${TablesColumnFile.mcreateddt} , "
        "${TablesColumnFile.mcreatedby} , "
        "${TablesColumnFile.midealbaldate} , "
        "${TablesColumnFile.mlastupdatedt} , "
        "${TablesColumnFile.mlastupdateby} , "
        "${TablesColumnFile.mgeolocation} , "
        "${TablesColumnFile.mgeolatd} , "
        "${TablesColumnFile.mbatchcd} , "
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlongname},"
        "${TablesColumnFile.moverdueint} ,"
        "${TablesColumnFile.mpenalos} ,"
        "${TablesColumnFile.moverdueprn} ,"
        "${TablesColumnFile.mschemiint} ,"
        "${TablesColumnFile.mschemiprn}, "
        "${TablesColumnFile.macctstat} , "
        "${TablesColumnFile.loanoutbal},  "
        "${TablesColumnFile.mintos} , "
        "${TablesColumnFile.mlastopendate}, "
        "${TablesColumnFile.missynctocoresys}  "
        " )"
        "VALUES"
        "(${collectionMasterBean.trefno} ,"
        "${collectionMasterBean.mrefno} ,"
        "${collectionMasterBean.mlbrcode} ,"
        "'${collectionMasterBean.mprdacctid}' ,"
        "${collectionMasterBean.mcenterid} ,"
        "${collectionMasterBean.mgroupid} ,"
        "${collectionMasterBean.mcustno} ,"
        "'${collectionMasterBean.mfocode}' ,"
        "${collectionMasterBean.memino} ,"
        "'${collectionMasterBean.malmeffdate}' ,"
        "${collectionMasterBean.madjFrmSD} ,"
        "${collectionMasterBean.madjfrmexcss} ,"
        "${collectionMasterBean.mpaidByGrp} ,"
        "${collectionMasterBean.mattendence} ,"
        "'${collectionMasterBean.mremarks}' ,"
        "${collectionMasterBean.mcollAmt} ,"
        "'${collectionMasterBean.mcreateddt}' ,"
        "'${collectionMasterBean.mcreatedby}' ,"
        "'${collectionMasterBean.midealbaldate}' ,"
        "'${collectionMasterBean.mlastupdatedt}' ,"
        "'${collectionMasterBean.mlastupdateby}',"
        "'${collectionMasterBean.mgeolocation}' ,"
        "'${collectionMasterBean.mgeolatd}' ,"
        "'${collectionMasterBean.mbatchcd}',"
        "'${collectionMasterBean.mgeologd}',"
        "'${collectionMasterBean.mlongname}', "
        "${collectionMasterBean.moverdueint} ,"
        "${collectionMasterBean.mpenalos} ,"
        "${collectionMasterBean.moverdueprn} ,"
        "${collectionMasterBean.mschemiint} ,"
        "${collectionMasterBean.mschemiprn} ,"
        "${collectionMasterBean.macctstat} ,"
        "${collectionMasterBean.loanoutbal} ,"
        "${collectionMasterBean.mintos} , "
        "'${collectionMasterBean.mlastopendate}' ,"
        "${collectionMasterBean.missynctocoresys} "
        " );";

    await db.transaction((Transaction txn) async {
      var id = await txn.rawInsert(insertQuery);
    });
  }

  Future<List<CollectionMasterBean>> getDailyColletedNotSynced() async {
    var db = await _getDb();
    CollectionMasterBean retBean = new CollectionMasterBean();
    List<CollectionMasterBean> n = new List<CollectionMasterBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced =
        'SELECT * FROM ${collectedLoansAmtMaster}  WHERE  ${TablesColumnFile.missynctocoresys}  IS NULL '
        ' OR  ${TablesColumnFile.missynctocoresys} = 0 ';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindDailyColleted(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  CollectionMasterBean bindDailyColleted(Map<String, dynamic> result) {
    return CollectionMasterBean.fromMap(result);
  }

  Future<List<LoanCycleParameterSecondaryBean>> selectMaxLoanAmtCanApply(
      String prdCode, int loanCycle, int mlbrcd, String mfrequ) async {
    String selectMaxLoanAmtCanApply =
        'SELECT   * FROM ${LoanCycleParameterSecondaryMaster} WHERE '
        '${TablesColumnFile.mlbrcode} = ${mlbrcd}  AND ${TablesColumnFile.mloancycle} = ${loanCycle} '
        'AND ${TablesColumnFile.mprdcd} = "${prdCode.trim()}" AND ${TablesColumnFile.mfrequency} = "${mfrequ}" order by ${TablesColumnFile.meffdate} desc limit 2';

    try {
      List<LoanCycleParameterSecondaryBean>
      listLoanCycleParameterSecondaryBean =
      new List<LoanCycleParameterSecondaryBean>();
      var db = await _getDb();
      var result = await db.rawQuery(selectMaxLoanAmtCanApply);
      print("cycle amt " + selectMaxLoanAmtCanApply);

      if (result.length > 0 && result[0] != null) {
        for (int i = 0; i < result.length; i++) {
          var bean = LoanCycleParameterSecondaryBean.fromLocalDb(result[i]);
          listLoanCycleParameterSecondaryBean.add(bean);
        }
      } else {
        selectMaxLoanAmtCanApply =
        'SELECT   * FROM ${LoanCycleParameterSecondaryMaster} WHERE '
            '${TablesColumnFile.mlbrcode} = ${mlbrcd}  AND ${TablesColumnFile.mloancycle} = 99 '
            'AND ${TablesColumnFile.mprdcd} = "${prdCode.trim()}" AND ${TablesColumnFile.mfrequency} = "${mfrequ}" order by ${TablesColumnFile.meffdate} desc limit 2';

        result = await db.rawQuery(selectMaxLoanAmtCanApply);

        if (result.length > 0 && result[0] != null) {
          for (int i = 0; i < result.length; i++) {
            var bean = LoanCycleParameterSecondaryBean.fromLocalDb(result[i]);
            listLoanCycleParameterSecondaryBean.add(bean);
          }
        }
      }
      print("cycle amt " + selectMaxLoanAmtCanApply);
      return listLoanCycleParameterSecondaryBean;
    } catch (_) {
      print("exception here ");
    }
  }

// calculating the Terrm deposit Rate of Interest
// according to number of days and number of months
  Future<double> getTDRateOfInterestTenure(double mainBalfcy) async {
    String selectSlabRoiQuery =
        'SELECT   ${TablesColumnFile.mintrate} FROM ${TDProductwiseInterestTable} WHERE '
        '(${TablesColumnFile.mlowertollimit} < ${mainBalfcy}  '
        'AND ${TablesColumnFile.muppertollimit} > ${mainBalfcy} ) OR'
        ' ${TablesColumnFile.mlowertollimit} = ${mainBalfcy}   OR '
        ' ${TablesColumnFile.muppertollimit} = ${mainBalfcy} '
        'AND ${TablesColumnFile.minteffdt} = (SELECT max(${TablesColumnFile.minteffdt}) FROM '
        '${TDProductwiseInterestTable} WHERE '
        '(${TablesColumnFile.mlowertollimit} < ${mainBalfcy}  '
        'AND ${TablesColumnFile.muppertollimit} > ${mainBalfcy} ) OR'
        ' ${TablesColumnFile.mlowertollimit} = ${mainBalfcy}   OR '
        ' ${TablesColumnFile.muppertollimit} = ${mainBalfcy}'
        '  ) ;';

    print(selectSlabRoiQuery);
    // try {
    double salbInt = 0.0;
    double salbofInt = 0.0;
    var db = await _getDb();
    var result = await db.rawQuery(selectSlabRoiQuery);
    print(result);
    if (result.length > 0 && result[0] != null) {
      salbInt = result[0][TablesColumnFile.mintrate];
    }

    return salbInt + (salbofInt);
    /* } catch (_) {
      print("exception here ");s
    }*/
  }

  // calculating the Terrm deposit Rate of Interest
// according to number of days and number of months PLUS Amount
  Future<double> getTDRateOfInterestTenureAndAmount(
      int mnoofdays, int mnoofmonths, double mmainbalfcy) async {
    String selectSlabRoiQuery =
        'SELECT   ${TablesColumnFile.mintrate} FROM ${TDProductwiseInterestTable} WHERE '
        '${TablesColumnFile.mdays} = "${mnoofdays}"  AND ${TablesColumnFile.mmonths} = "${mnoofmonths}" '
        'AND ${TablesColumnFile.minteffdt} = (SELECT max(${TablesColumnFile.minteffdt}) FROM '
        '${TDProductwiseInterestTable} WHERE ${TablesColumnFile.mdays} = "${mnoofdays}" AND ${TablesColumnFile.mmonths}'
        ' = "${mnoofmonths}") AND ${TablesColumnFile.mpenalintrate} >= $mmainbalfcy ORDER BY ${TablesColumnFile.msrno} LIMIT 1';

    print(selectSlabRoiQuery);
    //  try {
    double salbInt = 0.0;
    double salbofInt = 0.0;
    var db = await _getDb();
    var result = await db.rawQuery(selectSlabRoiQuery);
    if (result.length > 0 && result[0] != null) {
      salbInt = result[0][TablesColumnFile.mintrate];
    }

    String selectTDOffsetRoiQuery =
        'SELECT   ${TablesColumnFile.moffsetintrate} FROM ${TDOffsetInterestMaster} WHERE '
        '${TablesColumnFile.mdays} = "${mnoofdays}"  AND ${TablesColumnFile.mmonths} = "${mnoofmonths}" '
        'AND ${TablesColumnFile.meffdate} = (SELECT max(${TablesColumnFile.meffdate}) FROM '
        '${TDOffsetInterestMaster} WHERE ${TablesColumnFile.mdays} = "${mnoofdays}" AND ${TablesColumnFile.mmonths}'
        ' = "${mnoofmonths}") AND ${TablesColumnFile.muptoamt} >= $mmainbalfcy ORDER BY ${TablesColumnFile.msrno} LIMIT 1';

    result = await db.rawQuery(selectTDOffsetRoiQuery);
    if (result.length > 0 && result[0] != null) {
      salbofInt = result[0][TablesColumnFile.moffsetintrate];
    }

    return salbInt + (salbofInt);
    /* } catch (_) {
      print("exception here ");
    }*/
  }

  Future<LoginBean> getLoginPass(LoginBean loginBean) async {
    var db = await _getDb();
    var userCode = "${TablesColumnFile.musrcode} = '${loginBean.musrcode}'";
    LoginBean retBean = new LoginBean();

    print('query is here : ' +
        'SELECT * FROM $userMasterTable  WHERE  $userCode');
    var result =
    await db.rawQuery('SELECT * FROM $userMasterTable  WHERE  $userCode');
    try {
      if (result[0] != null) {
        print(result[0]);
        retBean = bindDataLoginBEan(result);
        // retBean = bindDataLoginBEan(result);
      }
    } catch (_) {
      print("Exception Occured");
    }
    return retBean;
  }

  Future updateUserPassword(LoginBean loginBean) async {
    var db = await _getDb();
    String query =
        "Update ${userMasterTable} set ${TablesColumnFile.musrpass} = '${loginBean.musrpass}' "
        " Where  ${TablesColumnFile.musrcode} = '${loginBean.musrcode}' ";

    print("xxxxxxxxxxxxxxquery is here : " + query);
    var result = await db.rawQuery(query);
    print(result);
  }

  Future<CreditBereauBean> getPrspctFrmMrefAndTerf(
      int mrefno, int trefno) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${creditBereauMaster} WHERE ${TablesColumnFile.mrefno} = ${mrefno} AND "
        " ${TablesColumnFile.trefno} = ${trefno} ";

    print("select query is ${selectQueryIsDataSynced}");

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    CreditBereauBean bean;
    try {
      if (result != null && result.isNotEmpty)
        bean = bindDataProspectbean(result[0]);
      else
        bean = null;
    } catch (_) {
      print(error.toString());
    }
    return bean;
  }

  //select customer based on Tref
  Future<CustomerLoanDetailsBean> selectCustomerLoanOnTref(
      int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CustomerLoanDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanDetailsBean();
        bean = bindCustomerLoanDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<int> generateTDNumber() async {
    print("trying to select last row  ${TermDepositMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${TermDepositMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${TermDepositMaster});";
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

  Future<CustomerListBean> getCustomerByTrefAndMref(
      int trefno, int mrefno) async {
    var db = await _getDb();

    String query =
        'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.trefno}  = $trefno'
        ' AND ${TablesColumnFile.mrefno}  = $mrefno ;';
    print(query);
    var result = await db.rawQuery(query);

    CustomerListBean bean;
    try {
      if (result.isNotEmpty)
        bean = bindDataCustomerListBean(result[0]);
      else {
        print("result is ${result}");
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future _createLoanApprovalLimitMasterTable(Database db) {
    String query = "CREATE TABLE ${loanApprovalLimitMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER,"
        "${TablesColumnFile.mgrpcd} INTEGER,"
        "${TablesColumnFile.musercode} TEXT,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mlimitamt} REAL,"
        "${TablesColumnFile.moverduedays} INTEGER,"
        "${TablesColumnFile.mloanacmindrbal} REAL,"
        "${TablesColumnFile.mloanacmincrbal} REAL,"
        "${TablesColumnFile.mwriteoffamat} REAL,"
        "${TablesColumnFile.mcheqlimitamt} REAL,"
        "${TablesColumnFile.mminintrate} REAL,"
        "${TablesColumnFile.mmaxintrate} REAL,"
        "${TablesColumnFile.mremarks} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode},${TablesColumnFile.mgrpcd},${TablesColumnFile.musercode},${TablesColumnFile.msrno}))";
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future createLoanApprovalLimitInsert(
      int lbrCode, String musercode, int mgrpcd) async {
    //deletSomeUtil();
    var loanApprovalLimitService = new LoanApprovalLimitService();
    var db = await _getDb();
    List<LoanApprovalLimitBean> loanApprovalLimitList =
    new List<LoanApprovalLimitBean>();
    await loanApprovalLimitService
        .getLoanApprovalLimitData(lbrCode, musercode, mgrpcd)
        .then((onValue) {
      print(onValue.length);
      loanApprovalLimitList = onValue;
    });
    await AppDatabase.get()
        .deletSomeSyncingActivityFromOmni('Loan_Approval_limit_Master');
    for (int i = 0; i < loanApprovalLimitList.length; i++) {
      String insertQuery = "INSERT OR REPLACE INTO ${loanApprovalLimitMaster} "
          "(${TablesColumnFile.mlbrcode} ,"
          "${TablesColumnFile.mgrpcd} ,"
          "${TablesColumnFile.musercode} ,"
          "${TablesColumnFile.msrno} ,"
          "${TablesColumnFile.mprdcd} ,"
          "${TablesColumnFile.mlimitamt} ,"
          "${TablesColumnFile.moverduedays} ,"
          "${TablesColumnFile.mloanacmindrbal} ,"
          "${TablesColumnFile.mloanacmincrbal} ,"
          "${TablesColumnFile.mwriteoffamat} ,"
          "${TablesColumnFile.mcheqlimitamt} ,"
          "${TablesColumnFile.mminintrate} ,"
          "${TablesColumnFile.mmaxintrate} ,"
          "${TablesColumnFile.mremarks}  )"
          "VALUES"
          "(${loanApprovalLimitList[i].loanApprovalLimitComposite.mlbrcode},"
          "${loanApprovalLimitList[i].loanApprovalLimitComposite.mgrpcd},"
          "'${loanApprovalLimitList[i].loanApprovalLimitComposite.musercode}',"
          "${loanApprovalLimitList[i].loanApprovalLimitComposite.msrno},"
          "'${loanApprovalLimitList[i].mprdcd}',"
          "${loanApprovalLimitList[i].mlimitamt},"
          "${loanApprovalLimitList[i].moverduedays},"
          "${loanApprovalLimitList[i].mloanacmindrbal},"
          "${loanApprovalLimitList[i].mloanacmincrbal},"
          "${loanApprovalLimitList[i].mwriteoffamat},"
          "${loanApprovalLimitList[i].mcheqlimitamt},"
          "${loanApprovalLimitList[i].mminintrate},"
          "${loanApprovalLimitList[i].mmaxintrate},"
          "'${loanApprovalLimitList[i].mremarks}');";

      print("insert query is" + insertQuery);
      await db.transaction((Transaction txn) async {
        var id = await txn.rawInsert(insertQuery);
      });
    }
  }

  Future<double> getLoanApprovalLimit(String mprdcd, String musercode) async {
    var db = await _getDb();
    LoanApprovalLimitBean loanApprovalLimitBean;
    try {
      String query =
          'SELECT * FROM ${loanApprovalLimitMaster}  WHERE ${TablesColumnFile.mprdcd}  = "${mprdcd.trim()}"  AND ${TablesColumnFile.musercode}  = "${musercode.trim()}" ;';
      print(query);
      var result = await db.rawQuery(query);

      if (result.isNotEmpty)
        loanApprovalLimitBean = bindDataLoanApprovalLimitBean(result[0]);
      else {
        String query =
            'SELECT * FROM ${loanApprovalLimitMaster}  WHERE ${TablesColumnFile.mprdcd}  = "${mprdcd.trim()}"  ;';
        print(query);
        var result = await db.rawQuery(query);
        loanApprovalLimitBean = bindDataLoanApprovalLimitBean(result[0]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    if (loanApprovalLimitBean != null &&
        loanApprovalLimitBean.mlimitamt != null) {
      return loanApprovalLimitBean.mlimitamt;
    } else {
      return 0.0;
    }
  }

  LoanApprovalLimitBean bindDataLoanApprovalLimitBean(
      Map<String, dynamic> result) {
    return LoanApprovalLimitBean.fromLocalDb(result);
  }

  Future<double> getUnsyncedDailyCollectedLaonAmt(String mprdacctid) async {
    var db = await _getDb();
    CollectionMasterBean collectionMasterBean;
    double unSyncedAmt = 0.0;
    try {
      String query =
          'SELECT * FROM ${collectedLoansAmtMaster}  WHERE ${TablesColumnFile.mprdacctid}  = "${mprdacctid.trim()}"  ;';
      print(query);
      var result = await db.rawQuery(query);

      if (result.isNotEmpty)
        try {
          for (int i = 0; i < result.length; i++) {
            collectionMasterBean = CollectionMasterBean.fromMap(result[i]);
            if (collectionMasterBean.mcollAmt != null) {
              unSyncedAmt += collectionMasterBean.mcollAmt;
            }
          }
        } catch (e) {
          print(e.toString());
        }
      return unSyncedAmt;
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
  }

  Future<CenterDetailsBean> getSingleCenter(int mcenterid) async {
    var db = await _getDb();

    CenterDetailsBean retBean = new CenterDetailsBean();

    var result;
    print("query is" + "SELECT *  FROM $centerDetailsMaster ");
    result = await db.rawQuery(
        'SELECT *  FROM $centerDetailsMaster where  ${TablesColumnFile.mcenterid} = ${mcenterid};');

    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindCenterDetailsBean(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }

    return retBean;
  }

  Future<LookupBeanData> getLookupDataPurposeOfLoanFromLocalDb(
      int codeType, String code) async {
    var db = await _getDb();
    LookupBeanData retBean = new LookupBeanData();
    List<LookupBeanData> n = new List<LookupBeanData>();
    var result;

    print("query is" + "SELECT *  FROM $LookupMaster ");
    result = await db.rawQuery(
        'select DISTINCT ${TablesColumnFile.mcodedesc},${TablesColumnFile.mcodetype},${TablesColumnFile.mcode},${TablesColumnFile.mfield1value} from lookup_master where ${TablesColumnFile.mcodetype} = $codeType  AND ${TablesColumnFile.mcode} = "$code" ORDER BY ${TablesColumnFile.mcodedesc} ;');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = LookupBeanData.fromJson(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<CountryDropDownBean> getCountryNameViaCountryCode(
      String cntryCd) async {
    var db = await _getDb();
    CountryDropDownBean retBean = new CountryDropDownBean();
    List<CountryDropDownBean> n = new List<CountryDropDownBean>();
    var result;

    print("query is" + "SELECT *  FROM $countryMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile.countryName} from Country_Master where ${TablesColumnFile.cntryCd} = "$cntryCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = CountryDropDownBean.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<StateDropDownList> getStateNameViaStateCode(String stateCd) async {
    var db = await _getDb();
    StateDropDownList retBean = new StateDropDownList();
    List<StateDropDownList> n = new List<StateDropDownList>();
    var result;

    print("query is" + "SELECT *  FROM $stateMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile.stateDesc} from State_Master where ${TablesColumnFile.stateCd} = "$stateCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = StateDropDownList.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<DistrictDropDownList> getDistrictNameViaDistrictCode(
      String distCd) async {
    var db = await _getDb();
    DistrictDropDownList retBean = new DistrictDropDownList();
    List<DistrictDropDownList> n = new List<DistrictDropDownList>();
    var result;

    print("query is" + "SELECT *  FROM $districtMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile.distDesc} from District_Master where ${TablesColumnFile.distCd} = "$distCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = DistrictDropDownList.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<SubDistrictDropDownList> getPlaceNameViaPlaceCode(
      String placeCd) async {
    var db = await _getDb();
    SubDistrictDropDownList retBean = new SubDistrictDropDownList();
    List<SubDistrictDropDownList> n = new List<SubDistrictDropDownList>();
    var result;

    print("query is" + "SELECT *  FROM $subDistrictMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile.placeCdDesc} from SubDistrict_Master where ${TablesColumnFile.placeCd} = "$placeCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = SubDistrictDropDownList.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<AreaDropDownList> getAreaNameViaAreaCode(String areaCd) async {
    var db = await _getDb();
    AreaDropDownList retBean = new AreaDropDownList();
    List<AreaDropDownList> n = new List<AreaDropDownList>();
    var result;

    print("query is" + "SELECT *  FROM $areaMaster ");
    result = await db.rawQuery(
        'select  ${TablesColumnFile.areaDesc} from Area_Master where ${TablesColumnFile.areaCd} = "$areaCd";');
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = AreaDropDownList.fromMap(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<ProductBean> getProductOnPrdCd(
      int moduleType, int branchCode, String mprdcd) async {
    var db = await _getDb();
    ProductBean retBean = new ProductBean();

    var result;

    result = await db.rawQuery(
        "SELECT *  FROM $productMaster WHERE ${TablesColumnFile.mmoduletype} = $moduleType AND ${TablesColumnFile.mlbrcode} = $branchCode AND ${TablesColumnFile.mprdcd} = '${mprdcd}' ;");
    print(
        "SELECT *  FROM $productMaster WHERE ${TablesColumnFile.mmoduletype} = $moduleType AND ${TablesColumnFile.mlbrcode} = $branchCode AND ${TablesColumnFile.mprdcd} = '${mprdcd}' ;");
    try {
      print("result result " + result.toString());
      for (int i = 0; i < result.length; i++) {
        retBean = bindProduct(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  GuarantorDetailsBean bindGuarantorDetails(Map<String, dynamic> result) {
    return GuarantorDetailsBean.fromMap(result);
  }

  Future updateExposureFromMrefTref(
      int trefNo, int mrefNo, double maxRange) async {
    var db = await _getDb();
    var str =
        "${TablesColumnFile.trefno} = ${trefNo} AND  ${TablesColumnFile.mrefno} = ${mrefNo}";
    String query =
        "Update $creditBereauResultMaster SET ${TablesColumnFile.mexpsramt} "
        "= ${maxRange}  WHERE $str";

    print("xxxxxxxxxxxxxxquery  update exposure amount is here : " + query);
    var result = await db.rawQuery(query);
    print("Credit Bereau Result Master Updated");
  }

  Future<GuarantorDetailsBean> selectGuarantorOnTref(
      int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    GuarantorDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GuarantorDetailsBean();
        bean = bindGuarantorDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<GuarantorDetailsBean>> getGuarantorsNotSynced() async {
    var db = await _getDb();
    GuarantorDetailsBean retBean = new GuarantorDetailsBean();
    List<GuarantorDetailsBean> n = new List<GuarantorDetailsBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced =  'SELECT * FROM ${gaurantorMaster}  WHERE  '
        '${TablesColumnFile.missynctocoresys} = 0  OR   ${TablesColumnFile.missynctocoresys} IS NULL ';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i]);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }
        print(result[i].runtimeType);
        retBean = bindGuarantorDetails(result[i]);
        print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future updateGuarantorMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${gaurantorMaster} SET ${query}");
    });
  }

  Future<int> generateSrNoForGuarantor(int loantrefno) async {
    print("trying to select last row  ${gaurantorMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${gaurantorMaster}"
        " WHERE   ${TablesColumnFile.msrno} = (SELECT MAX(${TablesColumnFile.msrno})  FROM ${gaurantorMaster} where ${TablesColumnFile.mloantrefno}=${loantrefno});";
    print('insertQuery ${insertQuery}');
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

  Future<int> generateTrefnoForGuarantor() async {
    print("trying to select last row  ${gaurantorMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${gaurantorMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${gaurantorMaster});";
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

  Future<int> generateTrefnoForCenterCreation() async {
    print("trying to select last row  ${centerDetailsMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${centerDetailsMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${centerDetailsMaster});";
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

  Future<int> generateTradeAndNeighbourRef() async {
    print("trying to select last row  ${tradeNeighbourRefCheckMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${tradeNeighbourRefCheckMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${tradeNeighbourRefCheckMaster});";
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

  Future<int> generateSocialEnvironment() async {
    print("trying to select last row  ${socialEnvironmentMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${socialEnvironmentMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${socialEnvironmentMaster});";
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

  Future<int> generateDeviationForm() async {
    print("trying to select last row  ${deviationFormMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${deviationFormMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${deviationFormMaster});";
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

  Future<int> getCenterRepayFromTo() async {
    print("trying to select row  ${SystemParameterMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${SystemParameterMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${centerDetailsMaster});";
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

  Future<int> generateTrefnoForGroupCreation() async {
    print("trying to select last row  ${groupFoundationMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${groupFoundationMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${groupFoundationMaster});";
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

  Future updateBranchMaster(BranchMasterBean brnchObj) async {
    print("trying to insert or replace ${branchMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${branchMaster} ("
        "${TablesColumnFile.mpbrcode}  ,"
        "${TablesColumnFile.mname} ,"
        "${TablesColumnFile.mshortname} ,"
        "${TablesColumnFile.madd1} ,"
        "${TablesColumnFile.madd2} ,"
        "${TablesColumnFile.madd3} ,"
        "${TablesColumnFile.mcitycd} ,"
        "${TablesColumnFile.mpincode} ,"
        "${TablesColumnFile.mcountrycd} ,"
        "${TablesColumnFile.mbranchtype} ,"
        "${TablesColumnFile.mtele1} ,"
        "${TablesColumnFile.mtele2} ,"
        "${TablesColumnFile.mfaxno1} ,"
        "${TablesColumnFile.mswiftaddr} ,"
        "${TablesColumnFile.mpostcode} ,"
        "${TablesColumnFile.mweekoff1} ,"
        "${TablesColumnFile.mweekoff2} ,"
        "${TablesColumnFile.mparentbrcode} ,"
        "${TablesColumnFile.mbranchtype1} ,"
        "${TablesColumnFile.mbranchcat} ,"
        "${TablesColumnFile.mformatndt} ,"
        "${TablesColumnFile.mdistrict} ,"
        "${TablesColumnFile.mbrnmanager} ,"
        "${TablesColumnFile.mstate} ,"
        "${TablesColumnFile.mmingroupmembers} ,"
        "${TablesColumnFile.mmaxgroupmembers} ,"
        "${TablesColumnFile.msector} ,"
        "${TablesColumnFile.mbranchemailid} ,"
        "${TablesColumnFile.mbiccode} ,"
        "${TablesColumnFile.mlegacybrncd} ,"
        "${TablesColumnFile.mlatitude} ,"
        "${TablesColumnFile.mlongitude} ,"
        "${TablesColumnFile.mlastopendate}  )"
        "VALUES"
        "(${brnchObj.mpbrcode},"
        "'${brnchObj.mname}',"
        "'${brnchObj.mshortname}',"
        "'${brnchObj.madd1}',"
        "'${brnchObj.madd2}',"
        "'${brnchObj.madd3}',"
        "'${brnchObj.mcitycd}',"
        "${brnchObj.mpincode},"
        "'${brnchObj.mcountrycd}',"
        "${brnchObj.mbranchtype},"
        "'${brnchObj.mtele1}',"
        "'${brnchObj.mtele2}',"
        "'${brnchObj.mfaxno1}',"
        "'${brnchObj.mswiftaddr}',"
        "'${brnchObj.mpostcode}',"
        "${brnchObj.mweekoff1},"
        "${brnchObj.mweekoff2},"
        "${brnchObj.mparentbrcode},"
        "${brnchObj.mbranchtype1},"
        "${brnchObj.mbranchcat},"
        "'${brnchObj.mformatndt}',"
        "'${brnchObj.mdistrict}',"
        "'${brnchObj.mbrnmanager}',"
        "'${brnchObj.mstate}',"
        "${brnchObj.mmaxgroupmembers},"
        "${brnchObj.mmingroupmembers},"
        "${brnchObj.msector},"
        "'${brnchObj.mbranchemailid}',"
        "'${brnchObj.mbiccode}',"
        "'${brnchObj.mlegacybrncd}',"
        "${brnchObj.mlatitude},"
        "${brnchObj.mlongitude},"
        "'${brnchObj.mlastopendate}'"
        ");";

    print(insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${productMaster}");
    });
  }

  Future<BranchMasterBean> getBranchNameOnPbrCd(int branchCd) async {
    var db = await _getDb();
    BranchMasterBean retBean = new BranchMasterBean();
    var result;

    result = await db.rawQuery(
        "SELECT *  FROM $branchMaster WHERE ${TablesColumnFile.mpbrcode} = $branchCd ;");
    print(
        "SELECT *  FROM $branchMaster WHERE ${TablesColumnFile.mpbrcode} = $branchCd ;" +
            result.toString() +
            result.length.toString());
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindBranch(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  BranchMasterBean bindBranch(Map<String, dynamic> result) {
    return BranchMasterBean.fromMiddleware(result);
  }

  Future<GroupFoundationBean> getGroupFromGrpId(int grpId) async {
    GroupFoundationBean retBean = new GroupFoundationBean();
    print("trying to select Group row  ${groupFoundationMaster}");
    String insertQuery = "SELECT * FROM    ${groupFoundationMaster} WHERE  "
        " ${TablesColumnFile.mgroupid} =  ${grpId};";
    var db = await _getDb();

    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retBean = bindGroupFoundationBean(result[0]);
      });
    } catch (_) {
      print("Getting Group fat gya");
    }
    return retBean;
  }

  Future<CenterDetailsBean> getCenterFromCenterId(int centerId) async {
    CenterDetailsBean retBean = new CenterDetailsBean();
    print("trying to select Group row  ${centerDetailsMaster}");
    String insertQuery = "SELECT * FROM    ${centerDetailsMaster} WHERE  "
        " ${TablesColumnFile.mCenterId} =  ${centerId};";
    var db = await _getDb();

    try {
      await db.transaction((Transaction txn) async {
        var result = await txn.rawQuery(insertQuery);
        retBean = bindCenterDetailsBean(result[0]);
      });
    } catch (_) {
      print("Getting Center fat gya");
    }
    return retBean;
  }

  Future<List<SavingsListBean>> getSavingListOnCenter(int CenterId) async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      SavingsListBean retBean = new SavingsListBean();
      List<SavingsListBean> n = new List<SavingsListBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $savingsCollectionMaster WHERE ${TablesColumnFile.mcenterid} = $CenterId ;");

      result = await db.rawQuery(
          'SELECT *  FROM $savingsCollectionMaster where  ${TablesColumnFile.mcenterid} = $CenterId');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = bindDataSavingsListBean(result[i]);
          print("exiting from map");
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

  Future<List<SavingsListBean>> getSavingListOnGroup(int GroupId) async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      SavingsListBean retBean = new SavingsListBean();
      List<SavingsListBean> n = new List<SavingsListBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $savingsCollectionMaster WHERE ${TablesColumnFile.mgroupcd} = $GroupId ;");

      result = await db.rawQuery(
          'SELECT *  FROM $savingsCollectionMaster where  ${TablesColumnFile.mgroupcd} = $GroupId');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = bindDataSavingsListBean(result[i]);
          print("exiting from map");
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

  Future<List<SavingsListBean>> getSavingListOnCustNo(int CustNo) async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      SavingsListBean retBean = new SavingsListBean();
      List<SavingsListBean> n = new List<SavingsListBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $savingsCollectionMaster WHERE ${TablesColumnFile.mcustno} = $CustNo ;");

      result = await db.rawQuery(
          'SELECT *  FROM $savingsCollectionMaster where  ${TablesColumnFile.mcustno} = $CustNo');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = bindDataSavingsListBean(result[i]);
          print("exiting from map");
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

  Future<List<SavingsListBean>> getTodaysSavingList() async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      SavingsListBean retBean = new SavingsListBean();
      List<SavingsListBean> n = new List<SavingsListBean>();

      String todayDate = DateTime.now().toString();
      print(todayDate);

      todayDate = todayDate.replaceRange(11, 26, "00:00:00.000000");
      print(todayDate);

      DateTime date = DateTime.parse(todayDate);
      print(date);

      var result;
      print("query is" +
          "SELECT *  FROM $savingsCollectionMaster WHERE ${TablesColumnFile.mcreateddt} >= '$date';");

      result = await db.rawQuery(
          "SELECT *  FROM $savingsCollectionMaster Where ${TablesColumnFile.mcreateddt} >= '$date';");

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = bindDataSavingsListBean(result[i]);
          print("exiting from map");
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

  Future<List<ChartsBean>> getChartsDetailsList(String defaultType) async {
    var db = await _getDb();
    String seleQuery = "";
    ChartsBean retBean = new ChartsBean();
    List<ChartsBean> chartsBeanList = new List<ChartsBean>();
    var result;

    if (defaultType == '999') {
      seleQuery = "Select * from ${CHARTMASTER} ;";
    } else {
      seleQuery = "Select * from ${CHARTMASTER};";
    }

    result = await db.rawQuery(seleQuery);

    print("xxxxxxxxxhoraha hai hone do ${result}");
    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {
        print("chartsxxxxxxxxxxxxxxxxx ${items.toString()}");
      }

      retBean = bindChartsDetailsBean(result[i]);
      print("exiting from map");
      chartsBeanList.add(retBean);
    }
    return chartsBeanList;
  }

  ChartsBean bindChartsDetailsBean(Map<String, dynamic> result) {
    return ChartsBean.fromMap(result);
  }

  Future updateChartsMaster(ChartsBean chartsBean) async {
    print("trying to insert or replace ${CHARTMASTER}");
    String insertQuery = "INSERT OR REPLACE INTO ${CHARTMASTER}( "
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mchartid} ,"
        "${TablesColumnFile.mtitle} ,"
        "${TablesColumnFile.mxcatg} ,"
        "${TablesColumnFile.mycatg} ,"
        "${TablesColumnFile.mzcatg} ,"
        "${TablesColumnFile.mdatasource} ,"
        "${TablesColumnFile.misonline} ,"
        "${TablesColumnFile.mquerydesc} ,"
        "${TablesColumnFile.mquery} ,"
        "${TablesColumnFile.mdefaulttype} ,"
        "${TablesColumnFile.subtitle} ,"
        "${TablesColumnFile.subdescription} ,"
        "${TablesColumnFile.image} ,"
        "${TablesColumnFile.status} ,"
        "${TablesColumnFile.subdisplaytype} ,"
        "${TablesColumnFile.mkey} ,"
        "${TablesColumnFile.codelink} ,"
        "${TablesColumnFile.premetivedatatype} ,"
        "${TablesColumnFile.parenttype} ,"
        "${TablesColumnFile.childtype} ,"
        "${TablesColumnFile.mtype}, "
        "${TablesColumnFile.xminval} ,"
        "${TablesColumnFile.yminval} ,"
        "${TablesColumnFile.xinterval} ,"
        "${TablesColumnFile.yinterval} ,"
        "${TablesColumnFile.xcaption},"
        "${TablesColumnFile.ycaption},"
        "${TablesColumnFile.isfavalwed},"
        "${TablesColumnFile.xcaprot} ,"
        "${TablesColumnFile.ycaprot} ,"
        "${TablesColumnFile.xaxisvsbl} ,"
        "${TablesColumnFile.yaxisvsbl} ,"
        "${TablesColumnFile.islegvis} "
        ")"
        "VALUES("
        "${chartsBean.trefno} ,"
        "${chartsBean.mrefno} ,"
        "${chartsBean.mchartid},"
        "'${chartsBean.mtitle}',"
        "'${chartsBean.mxcatg}',"
        "'${chartsBean.mycatg}',"
        "'${chartsBean.mzcatg}',"
        "'${chartsBean.mdatasource}',"
        "${chartsBean.misonline} ,"
        "'${chartsBean.mquerydesc}',"
        "'${chartsBean.mquery}',"
        "'${chartsBean.mdefaulttype}',"
        "'${chartsBean.subtitle}',"
        "'${chartsBean.subdescription}',"
        "'${chartsBean.image}',"
        "'${chartsBean.status}',"
        "'${chartsBean.subdisplaytype}',"
        "'${chartsBean.mkey}',"
        "'${chartsBean.codeLink}',"
        "${chartsBean.premetivedatatype},"
        "'${chartsBean.parenttype}',"
        "'${chartsBean.childtype}',"
        "'${chartsBean.mtype}',"
        "${chartsBean.xminval},"
        "${chartsBean.yminval},"
        "${chartsBean.xinterval},"
        "${chartsBean.yinterval},"
        "'${chartsBean.xcaption}',"
        "'${chartsBean.ycaption}',"
        "${chartsBean.isfavalwed},"
        "${chartsBean.xcaprot} ,"
        "${chartsBean.ycaprot} ,"
        "${chartsBean.xaxisvsbl} ,"
        "${chartsBean.yaxisvsbl} ,"
        "${chartsBean.islegvis} "
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${CHARTMASTER}");
    });
  }

  // await AppDatabase.get().getQueryNumTypeBean(charttype).then((onValue) async {

  Future<List<NumTypeBean>> getQueryNumTypeBean(ChartsBean bean) async {
    var db = await _getDb();

    List<NumTypeBean> salesDataList = new List<NumTypeBean>();
    var result;
    if (!bean.mquery.contains("Query")) {
      //try {

      print("bean.mquery" + bean.mquery);
      result = await db.rawQuery(bean.mquery);
      for (int i = 0; i < result.length; i++) {
        print("result[i]" + result[i].toString());

        dynamic xcat = result[i]["x"];
        dynamic ycat = result[i]["y"];
        dynamic y1cat = result[i]["y1"];

        print("xcat" +
            xcat.toString() +
            "         xxxxxxxxxxxycat" +
            ycat.toString());

        int xAxis = 0;
        int yAxis = 0;
        int y1Axis = 0;
        // xcat = || xcat==0?"0":"";
        //if(xcat!=null) {
        if (xcat != null && xcat != 'null') {
          switch (xcat.runtimeType) {
            case int:
              print("X is Int ${xcat}");
              xAxis = xcat;
              break;
            case String:
              print("X is String");
              xAxis = int.parse(xcat);

              break;
            default:
              print("x is nothing");
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
              print("Y1 is  Int");
              y1Axis = y1cat;
              break;
            case String:
              print("Y1 is  String");
              try {
                y1Axis = int.parse(y1cat);
              } catch (_) {
                yAxis = 0;
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

        NumTypeBean salesData = new NumTypeBean(xAxis, yAxis, y1Axis);
        print("salesData salesData ${salesData}");
        salesDataList.add(salesData);
      }
      /*} catch (_) {


        print("exception aaya  chutye");
      }*/
    }
    return salesDataList;
  }

  Future<List<ChartSampleData>> getQuerySimpleBarChart(String query) async {
    var db = await _getDb();

    List<ChartSampleData> salesDataList = new List<ChartSampleData>();
    var result;
    if (!query.contains("Query")) {
      try {
        print("bean.mquery" + query);
        result = await db.rawQuery(query);
        for (int i = 0; i < result.length; i++) {
          print("result[i]" + result[i].toString());

          dynamic xcat = result[i]["x"];
          dynamic ycat = result[i]["y"];

          print("xcat" +
              xcat.toString() +
              "         xxxxxxxxxxxycat" +
              ycat.toString());

          String xAxis = "";
          int yAxis = 0;
          // xcat = || xcat==0?"0":"";
          if (xcat != null) {
            switch (xcat.runtimeType) {
              case int:
                print("X is Int ${xcat}");
                xAxis = xcat.toString();
                break;
              case String:
                print("X is String");
                xAxis = xcat;
                break;
              default:
                print("x is nothing");
                xAxis = xcat.toString();
                break;
            }
          } else {
            xAxis = "";
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

          ChartSampleData salesData = new ChartSampleData();
          salesData.xValue = xAxis;
          salesData.yValue = yAxis;
          print("salesData salesData ${salesData}");
          salesDataList.add(salesData);
        }
      } catch (_) {
        print("exception aaya  chutye");
      }
    }
    return salesDataList;
  }
/*  Future<List<AxisBean>> getQuery(ChartsBean bean) async {
    var db = await _getDb();

    List<AxisBean> salesDataList = new List<AxisBean>();
    var result;
    if (!bean.mquery.contains("Query")) {

        print("bean.mquery bean.mquery ${bean.mquery}");

      try {
        result = await db.rawQuery(bean.mquery);
        for (int i = 0; i < result.length; i++) {
          print("result[i]" + result[i].toString());
          var xcat = result[i][bean.mxcatg];
          var ycat = result[i][bean.mycatg];
          print("xcat" + xcat.toString() + "xcat" + ycat.toString());
          xcat = xcat == null || xcat == 0 ? "0" : xcat;
          ycat = ycat == null || ycat == 0 ? 1 : ycat;
          print("xcat" + xcat.toString() + "xcat" + ycat.toString());
          AxisBean salesData = new AxisBean(xcat, ycat);
          salesDataList.add(salesData);
        }
      } catch (_) {}
    }
    return salesDataList;
  }*/

  Future<CustomerListBean> getCustMrefAndTref(int custNo) async {
    var db = await _getDb();
    CustomerListBean retBean = new CustomerListBean();
    var result;

    result = await db.rawQuery(
        "SELECT *  FROM $customerFoundationMasterDetails WHERE ${TablesColumnFile.mcustno} = $custNo ;");
    print(
        "SELECT *  FROM $customerFoundationMasterDetails WHERE ${TablesColumnFile.mcustno} = $custNo ;" +
            result.toString() +
            result.length.toString());
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindDataCustomerListBean(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<ProductwiseInterestTableBean> getTDTenureFromProd(
      String prdCode) async {
    String selectSlabRoiQuery =
        'SELECT   * FROM ${TDProductwiseInterestTable} WHERE '
        ' ${TablesColumnFile.mprdcd} = ${prdCode} '
        'ORDER BY ${TablesColumnFile.msrno} LIMIT 1';
    print(selectSlabRoiQuery);

    ProductwiseInterestTableBean prodIntObj;
    var db = await _getDb();
    var result = await db.rawQuery(selectSlabRoiQuery);

    print('result is $result');

    try {
      prodIntObj = bindTD(result[0]);
    } catch (_) {}
    print("returning  $prodIntObj");
    return prodIntObj;
  }

  ProductwiseInterestTableBean bindTD(Map<String, dynamic> result) {
    return ProductwiseInterestTableBean.fromMap(result);
  }

  Future _createTDParameterMasterMasterTable(Database db) {
    print("shadab's  table xxxxxxxxxxxxx");
    String query = "CREATE TABLE ${tdParameterMaster} ("
        "${TablesColumnFile.mlbrcode} INTEGER ,"
        "${TablesColumnFile.mprdcd} TEXT,"
        "${TablesColumnFile.mdefbatchcd} TEXT,"
        "${TablesColumnFile.mintfreq} TEXT,"
        "${TablesColumnFile.mmindepamt} REAL,"
        "${TablesColumnFile.mmaxdepamt} REAL,"
        "${TablesColumnFile.mperiodtype} TEXT,"
        "${TablesColumnFile.mmaxperiod} INTEGER,"
        "${TablesColumnFile.mminperiod} INTEGER,"
        "${TablesColumnFile.mnodaysinyear} INTEGER,"
        "${TablesColumnFile.mclintcalctype} INTEGER,"
        "${TablesColumnFile.mtaxprojection} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.mlbrcode}, ${TablesColumnFile.mprdcd}))";
    print("primary of TDOffsetInterestMaster");

    ");";
    print("table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future<TDParameterBean> getParameterForProduct(
      String prdCd, int lbrCd) async {
    TDParameterBean retBean;

    String query = "Select * from ${tdParameterMaster} where "
        " ${TablesColumnFile.mprdcd} = ${prdCd}  AND  ${TablesColumnFile.mlbrcode} = ${lbrCd} ";

    var db = await _getDb();
    var result = await db.rawQuery(query);

    print('result is $result');

    // try {

    retBean = bindTDParameter(result[0]);
    //}catch(_){

    //}

    return retBean;
  }

  TDParameterBean bindTDParameter(Map<String, dynamic> result) {
    return TDParameterBean.fromMapWitoutComposite(result);
  }

  Future updateGLAccountMaster(GLAccountBean bean) async {
    print("trying to insert or replace ${glAccountMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${glAccountMaster} ("
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mlongname})"
        "VALUES"
        "(${bean.trefno},"
        "${bean.mrefno},"
        "${bean.mlbrcode},"
        "'${bean.mprdacctid}',"
        "'${bean.mlongname}'"
        ");";

    print(insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${glAccountMaster}");
    });
  }

  Future updateLoanCycleWiseLimitMaster(LoanCycleWiseLimitBean bean) async {
    print("trying to insert or replace ${loanCycleWiseLimitMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${loanCycleWiseLimitMaster} ("
        "${TablesColumnFile.mloancycle},"
        "${TablesColumnFile.mloanlimit}"
        " ) VALUES "
        "(${bean.mloancycle},"
        "${bean.mloanlimit}"
        ");";

    print(insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${glAccountMaster}");
    });
  }

  Future<List<DisbursmentBean>> getDisbursedListForIndvPrint(int CustNo) async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      DisbursmentBean retBean = new DisbursmentBean();
      List<DisbursmentBean> n = new List<DisbursmentBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $disbursedMaster WHERE ${TablesColumnFile.mcustno} = $CustNo ;");

      result = await db.rawQuery(
          'SELECT *  FROM $disbursedMaster where  ${TablesColumnFile.mcustno} = $CustNo');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = bindDataDisbursmentListBean(result[i]);
          print("exiting from map");
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

  Future<CustomerListBean> selectCustomerOnTrefANDMrefno(
      int trefno, String mCreatedBy, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CustomerListBean bean;
    if (result.isEmpty) {
      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      print(selectQueryIsDataSynced);
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<CustomerLoanDetailsBean> selectCustomerLoanOnTrefAndMref(
      int trefno, String mCreatedBy, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = $mrefno';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty) {
      print("return query is empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0';

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    CustomerLoanDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanDetailsBean();
        bean = bindCustomerLoanDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<GLAccountBean>> getGLAccountList() async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    GLAccountBean retBean = new GLAccountBean();
    List<GLAccountBean> n = new List<GLAccountBean>();

    var result;

    //if(future!=null) {

    print("query is" + "SELECT *  FROM $glAccountMaster order by ${TablesColumnFile
        .mrefno}; ");
    result = await db.rawQuery(
        'SELECT *  FROM $glAccountMaster order by ${TablesColumnFile
            .mrefno};');

    try {
      for (int i = 0; i < result.length; i++) {
        //print(result[i]);
        //print(result[i].runtimeType);
        retBean = bindGLAccountBean(result[i]);
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }

    print("Returning n is ${n}");

    return n;
  }

  GLAccountBean bindGLAccountBean(Map<String, dynamic> result) {
    return GLAccountBean.fromMap(result);
  }

  Future<List<ImageBean>> getFingerListByCustNo(int mcustno) async {
    var db = await _getDb();
    var result = [];

    result = await db.rawQuery(
        'SELECT * FROM ${imageMaster} where ${TablesColumnFile.mrefno} = (Select ${TablesColumnFile.mrefno} from ${customerFoundationMasterDetails} '
            ' WHERE ${TablesColumnFile.mcustno} = ${mcustno} )'
            ' AND ${TablesColumnFile.imageType} = "FingerPrint" ');
    print("result" + result.toString());
    List<ImageBean> listbean = new List<ImageBean>();
    ImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new ImageBean();
        bean = bindImageListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  //Create Menu Master
  Future _createMenuMasterTable(Database db) {
    String query = "CREATE TABLE ${MenuMaster} ("
        "${TablesColumnFile.menuid} INTEGER,"
        "${TablesColumnFile.menuDesc} TEXT,"
        "${TablesColumnFile.menutype} TEXT,"
        "${TablesColumnFile.parenttype} TEXT,"
        "${TablesColumnFile.mapplicationtype} TEXT,"
        "${TablesColumnFile.mparentmenuid} INTEGER,"
        "${TablesColumnFile.mchartid} INTEGER,"
        "${TablesColumnFile.murl} TEXT,"
        "PRIMARY KEY (${TablesColumnFile.menuid}))";
    print("primary of menu master table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  // Create User Rights Table
  Future _createUserRightsTable(Database db) {
    String query = "CREATE TABLE ${UserRightsTable} ("
        "${TablesColumnFile.mgrpcd} INTEGER,"
        "${TablesColumnFile.musrcode} TEXT,"
        "${TablesColumnFile.menuId} INTEGER,"
        "${TablesColumnFile.mchartid} INTEGER,"
        "${TablesColumnFile.create} INTEGER,"
        "${TablesColumnFile.modify} INTEGER,"
        "${TablesColumnFile.browse} INTEGER,"
        "${TablesColumnFile.authority} INTEGER,"
        "${TablesColumnFile.delete} INTEGER,"
        " PRIMARY KEY (${TablesColumnFile.mgrpcd}, ${TablesColumnFile.musrcode},${TablesColumnFile.menuId})"
        ")";
    print("primary of user Rights table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future _createLoanLevelMaster(Database db) {
    String query = "CREATE TABLE ${loanLevelMaster} ("
        "${TablesColumnFile.mrefno} INTEGER PRIMARY KEY ,"
        "${TablesColumnFile.mbuttonid} INTEGER,"
        "${TablesColumnFile.mbuttonname} TEXT,"
        "${TablesColumnFile.mstageid} INTEGER,"
        "${TablesColumnFile.mproductname} TEXT,"
        "${TablesColumnFile.mprdcd} TEXT ,"
        "${TablesColumnFile.morderid} INTEGER,"
        "${TablesColumnFile.mismandatory} INTEGER "
        ")";
    print("Loan level master table");
    print(query.toString());
    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future<List<UserRightBean>> getUserRights(
      UserRightBean getBean, String menuType) async {
    try {
      var db = await _getDb();
      UserRightBean retBean = new UserRightBean();
      List<UserRightBean> n = new List<UserRightBean>();
      String queryForGetMenu =
          'SELECT userRights.createe,userRights.modifye,userRights.browsee,userRights.authoritye,userRights.deletee,menuMaster.menuid,menuMaster.menuDesc,menuMaster.menutype, '
          'menuMaster.parenttype,menuMaster.murl FROM ${UserRightsTable} as userRights  '
          'INNER JOIN  ${MenuMaster} AS menuMaster  on menuMaster.menuid = userRights.menuid WHERE menutype = "${menuType}" AND userRights.musrcode = "${getBean.musrcode}" ';
      var result;

      result = await db.rawQuery(queryForGetMenu);

      if (result.length > 0 && result[0] != null) {
        try {
          for (int i = 0; i < result.length; i++) {
            retBean = bindDataUserRightBeanListBean(result[i]);

            n.add(retBean);
          }
        } catch (e) {
          print(e.toString());
        }
      } else {
        queryForGetMenu =
        'SELECT userRights.createe,userRights.modifye,userRights.browsee,userRights.authoritye,userRights.deletee,menuMaster.menuid,menuMaster.menuDesc,menuMaster.menutype, '
            'menuMaster.parenttype,menuMaster.murl FROM ${UserRightsTable} as userRights  '
            'INNER JOIN  ${MenuMaster} AS menuMaster  on menuMaster.menuid = userRights.menuid WHERE menutype = "${menuType}" AND userRights.musrcode = "ALLUSERS" ';

        result = await db.rawQuery(queryForGetMenu);

        if (result.length > 0 && result[0] != null) {
          try {
            for (int i = 0; i < result.length; i++) {
              retBean = bindDataUserRightBeanListBean(result[i]);

              n.add(retBean);
            }
          } catch (e) {
            print(e.toString());
          }
        }
      }

      return n;
    } catch (e) {
      return null;
    }
  }

  UserRightBean bindDataUserRightBeanListBean(Map<String, dynamic> result) {
    return UserRightBean.fromJoinMap(result);
  }

  Future updateUserRightsMaster(UserRightBean userRightBean) async {
    print("trying to insert or replace ${UserRightsTable}");
    String insertQuery = "INSERT OR REPLACE INTO ${UserRightsTable}( "
        "${TablesColumnFile.mgrpcd} ,"
        "${TablesColumnFile.musrcode},"
        "${TablesColumnFile.menuId},"
        "${TablesColumnFile.create},"
        "${TablesColumnFile.modify},"
        "${TablesColumnFile.browse},"
        "${TablesColumnFile.authority},"
        "${TablesColumnFile.delete}"
        ")"
        "VALUES("
        "${userRightBean.userAccressRightsCompositeEntity.mgrpcd} ,"
        "'${userRightBean.userAccressRightsCompositeEntity.usrcode}' ,"
        "${userRightBean.userAccressRightsCompositeEntity.menuid},"
        "${userRightBean.create},"
        "${userRightBean.modify},"
        "${userRightBean.browse},"
        "${userRightBean.authority},"
        "${userRightBean.delete}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${UserRightsTable}");
    });
  }

  Future updateMenuMaster(MenuMasterBean menuMasterBean) async {
    print("trying to insert or replace ${MenuMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${MenuMaster}( "
        "${TablesColumnFile.menuid} ,"
        "${TablesColumnFile.menuDesc} ,"
        "${TablesColumnFile.menutype} ,"
        "${TablesColumnFile.parenttype} ,"
        "${TablesColumnFile.mapplicationtype},"
        "${TablesColumnFile.mparentmenuid},"
        "${TablesColumnFile.mchartid},"
        "${TablesColumnFile.murl} "
        ")"
        "VALUES("
        "${menuMasterBean.menuid} ,"
        "'${menuMasterBean.menuDesc}' ,"
        "'${menuMasterBean.menutype}',"
        "'${menuMasterBean.parenttype}',"
        "'${menuMasterBean.mapplicationtype}',"
        "${menuMasterBean.mparentmenuid} ,"
        "${menuMasterBean.mchartid} ,"
        "'${menuMasterBean.murl}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${MenuMaster}");
    });
  }

  Future<List<MenuMasterBean>> getMenuRights() async {
    try {
      var db = await _getDb();
      MenuMasterBean retBean = new MenuMasterBean();
      List<MenuMasterBean> n = new List<MenuMasterBean>();
      var result;
      result = await db.rawQuery('SELECT *  FROM $MenuMaster');
      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = bindDataMenuBeanListBean(result[i]);
          print("exiting from map");
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

  MenuMasterBean bindDataMenuBeanListBean(Map<String, dynamic> result) {
    return MenuMasterBean.fromMap(result);
  }

  Future<List<GLAccountBean>> doNothing() async {
    return List<GLAccountBean>();
  }

  Future<AddressDescBean> getAddressHererchyInDescOrder(
      String placeCd, int area) async {
    try {
      var db = await _getDb();

      AddressDescBean retBean = new AddressDescBean();
      // List<AddressDescBean> n = new List<AddressDescBean>();

      String queryForGetMenu =
          'SELECT *  FROM $areaMaster where areaCd = $areaCd;';
      var result;
      result = await db.rawQuery(queryForGetMenu);

      AreaDropDownList areaBean = new AreaDropDownList();

      try {
        for (int i = 0; i < result.length; i++) {
          areaBean = bindAreaDropDownBean(result[i]);
        }
      } catch (e) {
        print(e.toString());
      }

      //City
      queryForGetMenu =
      'SELECT *  FROM $subDistrictMaster where placeCd = $placeCd;';
      result = await db.rawQuery(queryForGetMenu);

      SubDistrictDropDownList subDistBean = new SubDistrictDropDownList();

      try {
        for (int i = 0; i < result.length; i++) {
          subDistBean = bindSubDistrictDropDownBean(result[i]);
        }
      } catch (e) {
        print(e.toString());
      }

      //District
      queryForGetMenu =
      'SELECT *  FROM $districtMaster where distCd = ${subDistBean.distCd};';
      result = await db.rawQuery(queryForGetMenu);

      DistrictDropDownList distBean = new DistrictDropDownList();

      try {
        for (int i = 0; i < result.length; i++) {
          distBean = bindDistrictDropDownBean(result[i]);
        }
      } catch (e) {
        print(e.toString());
      }

      //State
      queryForGetMenu =
      'SELECT *  FROM $stateMaster where stateCd = "${distBean.stateCd}";';
      result = await db.rawQuery(queryForGetMenu);

      StateDropDownList stateDropDownList = new StateDropDownList();

      try {
        for (int i = 0; i < result.length; i++) {
          stateDropDownList = bindStateDropDownBean(result[i]);
        }
      } catch (e) {
        print(e.toString());
      }

      //Country
      queryForGetMenu =
      'SELECT *  FROM $countryMaster where countryId = "${stateDropDownList.cntryCd}";';
      result = await db.rawQuery(queryForGetMenu);

      CountryDropDownBean countryDropDownBean = new CountryDropDownBean();

      try {
        for (int i = 0; i < result.length; i++) {
          countryDropDownBean = bindCountryDropDownBean(result[i]);
        }
      } catch (e) {
        print(e.toString());
      }

      try {
        retBean.cuntryBean = countryDropDownBean;
        retBean.stateDropDownBean = stateDropDownList;
        retBean.districtDropDownBean = distBean;
        retBean.subDistrictDropDownBean = subDistBean;
        retBean.areaDropDownList = areaBean;
      } catch (e) {
        print(e.toString());
      }

      return retBean;
    } catch (e) {
      return null;
    }
  }

  Future<List<CollectionMasterBean>> getCollectionListOnGroup(
      int GroupId) async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      CollectionMasterBean retBean = new CollectionMasterBean();
      List<CollectionMasterBean> n = new List<CollectionMasterBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $collectedLoansAmtMaster WHERE ${TablesColumnFile.mgroupid} = $GroupId ;");

      result = await db.rawQuery(
          'SELECT *  FROM $collectedLoansAmtMaster where  ${TablesColumnFile.mgroupid} = $GroupId');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = CollectionMasterBean.fromMap(result[i]);
          print("exiting from map");
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

  Future<List<CollectionMasterBean>> getTodaysCollectionList() async {
    try {
      String todayDate = DateTime.now().toString();
      print(todayDate);

      todayDate = todayDate.replaceRange(11, 26, "00:00:00.000000");
      DateTime date = DateTime.parse(todayDate);
      var db = await _getDb();

      print("inside get ALl Objects");
      CollectionMasterBean retBean = new CollectionMasterBean();
      List<CollectionMasterBean> n = new List<CollectionMasterBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $collectedLoansAmtMaster WHERE ${TablesColumnFile.mcreateddt} >= '$date ; ");

      result = await db.rawQuery(
          "SELECT *  FROM $collectedLoansAmtMaster where   ${TablesColumnFile.mcreateddt} >= '$date' ;");

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = CollectionMasterBean.fromMap(result[i]);
          print("exiting from map");
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

  Future<List<CollectionMasterBean>> getCollectionListOnCustNo(
      int custNo) async {
    try {
      var db = await _getDb();

      print("inside get By Custno ");
      CollectionMasterBean retBean = new CollectionMasterBean();
      List<CollectionMasterBean> n = new List<CollectionMasterBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $collectedLoansAmtMaster WHERE ${TablesColumnFile.mcustno} = $custNo ;");

      result = await db.rawQuery(
          'SELECT *  FROM $collectedLoansAmtMaster where  ${TablesColumnFile.mcustno} = $custNo');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = CollectionMasterBean.fromMap(result[i]);
          print("exiting from map");
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

  Future<List<CollectionMasterBean>> getCollectionListOnCenter(
      int centerid) async {
    try {
      var db = await _getDb();

      print("inside get By Custno ");
      CollectionMasterBean retBean = new CollectionMasterBean();
      List<CollectionMasterBean> n = new List<CollectionMasterBean>();

      var result;
      print("query is" +
          "SELECT *  FROM $collectedLoansAmtMaster WHERE ${TablesColumnFile.mcenterid} = $centerid ;");

      result = await db.rawQuery(
          'SELECT *  FROM $collectedLoansAmtMaster where  ${TablesColumnFile.mcenterid} = $centerid');

      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = CollectionMasterBean.fromMap(result[i]);
          print("exiting from map");
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

  Future upadateLoanLevelMaster(LoanLevel loanLevel) async {
    print("trying to insert or replace ${loanLevelMaster}");

    String insertQuery = "INSERT OR REPLACE INTO ${loanLevelMaster}( "
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mbuttonid},"
        "${TablesColumnFile.mbuttonname},"
        "${TablesColumnFile.mstageid},"
        "${TablesColumnFile.mproductname},"
        "${TablesColumnFile.mprdcd},"
        "${TablesColumnFile.morderid},"
        "${TablesColumnFile.mismandatory}"
        ")"
        "VALUES("
        "${loanLevel.mrefno},"
        "${loanLevel.mbuttonid},"
        "'${loanLevel.mbuttonname}',"
        "${loanLevel.mstageid},"
        "'${loanLevel.mproductname}',"
        "'${loanLevel.mprdcd}',"
        "${loanLevel.morderid},"
        "${loanLevel.mismandatory}"
        ");";

    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${loanLevelMaster}");
    });
  }

  Future<List<LoanLevel>> getLoanLevelForStage(
      int stageid, String mprdCd) async {
    try {
      var db = await _getDb();

      print("inside get By Custno ");
      LoanLevel retBean = new LoanLevel();
      List<LoanLevel> n = new List<LoanLevel>();

      //todo -- order by ${TablesColumnFile.morderid}
      var result;

      if (stageid == 0) {
        print("query is" +
            " Select * from ${loanLevelMaster} WHERE  ${TablesColumnFile.mprdcd} = '${mprdCd}' ORDER BY ${TablesColumnFile.morderid} ;");

        result = await db.rawQuery(
            " Select * from ${loanLevelMaster} WHERE  ${TablesColumnFile.mprdcd} = '${mprdCd}' ORDER BY ${TablesColumnFile.morderid}  ;");
      } else {
        print("query is" +
            " Select * from ${loanLevelMaster} WHERE  ${TablesColumnFile.mstageid} = ${stageid}  AND   ${TablesColumnFile.mprdcd} = '${mprdCd}' ORDER BY ${TablesColumnFile.morderid} ;");

        result = await db.rawQuery(
            " Select * from ${loanLevelMaster} WHERE  ${TablesColumnFile.mstageid} = ${stageid} AND   ${TablesColumnFile.mprdcd} = '${mprdCd}' ORDER BY ${TablesColumnFile.morderid}  ;");
      }

      print(result);
      try {
        for (int i = 0; i < result.length; i++) {
          for (var items in result[i].toString().split(",")) {}
          print(result[i].runtimeType);
          retBean = LoanLevel.fromJson(result[i]);
          print("exiting from map");
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

  Future updateCustomerLoanCashFlowMaster(
      CustomerLoanCashFlowAnalysisBean loanCahFlowBean) async {
    print("trying to insert or replace ${CosutomerLoanCashFlowMaster}");
    String insertQuery =
        "INSERT OR REPLACE INTO ${CosutomerLoanCashFlowMaster}( "
        "${TablesColumnFile.mrefno}  ,"
        "${TablesColumnFile.trefno}  ,"
        "${TablesColumnFile.mleadsid}  ,"
        "${TablesColumnFile.mfimainbsinc}  ,"
        "${TablesColumnFile.mfisubbusinc}  ,"
        "${TablesColumnFile.mfirentalinc}  ,"
        "${TablesColumnFile.mfiotherinc}  ,"
        "${TablesColumnFile.mfitotalInc}  ,"
        "${TablesColumnFile.mbepurequipments}  ,"
        "${TablesColumnFile.mbepetrolcost}  ,"
        "${TablesColumnFile.mbewages}  ,"
        "${TablesColumnFile.mberent}  ,"
        "${TablesColumnFile.mbeeemi}  ,"
        "${TablesColumnFile.mbetotalbusexp}  ,"
        "${TablesColumnFile.mfefoodexp}  ,"
        "${TablesColumnFile.mfemobileexp}  ,"
        "${TablesColumnFile.mfemedicalexp}  ,"
        "${TablesColumnFile.mfeschoolfees}  ,"
        "${TablesColumnFile.mfecollegefees}  ,"
        "${TablesColumnFile.mfemiscellaneous}  ,"
        "${TablesColumnFile.mfeelectricity}  ,"
        "${TablesColumnFile.mfesocialcharity}  ,"
        "${TablesColumnFile.mfetotalfaminc}  ,"
        "${TablesColumnFile.mfetotalexp}  ,"
        "${TablesColumnFile.msurpluscash}  ,"
        "${TablesColumnFile.mdbr}  ,"
        "${TablesColumnFile.mcreateddt}  ,"
        "${TablesColumnFile.mcreatedby}  ,"
        "${TablesColumnFile.mlastupdatedt}  ,"
        "${TablesColumnFile.mlastupdateby}  ,"
        "${TablesColumnFile.mgeolocation}  ,"
        "${TablesColumnFile.mgeolatd}  ,"
        "${TablesColumnFile.mgeologd}  ,"
        "${TablesColumnFile.missynctocoresys}  ,"
        "${TablesColumnFile.mlastsynsdate}  ,"
        "${TablesColumnFile.mloanmrefno}  ,"
        "${TablesColumnFile.mloantrefno}  ,"
        "${TablesColumnFile.mcustmrefno}  ,"
        "${TablesColumnFile.mcusttrefno}  "
        ") VALUES ("
        "${loanCahFlowBean.mrefno}  ,"
        "${loanCahFlowBean.trefno}  ,"
        "'${loanCahFlowBean.mleadsid}'  ,"
        "${loanCahFlowBean.mfimainbsinc}  ,"
        "${loanCahFlowBean.mfisubbusinc}  ,"
        "${loanCahFlowBean.mfirentalinc}  ,"
        "${loanCahFlowBean.mfiotherinc}  ,"
        "${loanCahFlowBean.mfitotalInc}  ,"
        "${loanCahFlowBean.mbepurequipments}  ,"
        "${loanCahFlowBean.mbepetrolcost}  ,"
        "${loanCahFlowBean.mbewages}  ,"
        "${loanCahFlowBean.mberent}  ,"
        "${loanCahFlowBean.mbeeemi}  ,"
        "${loanCahFlowBean.mbetotalbusexp}  ,"
        "${loanCahFlowBean.mfefoodexp}  ,"
        "${loanCahFlowBean.mfemobileexp}  ,"
        "${loanCahFlowBean.mfemedicalexp}  ,"
        "${loanCahFlowBean.mfeschoolfees}  ,"
        "${loanCahFlowBean.mfecollegefees}  ,"
        "${loanCahFlowBean.mfemiscellaneous}  ,"
        "${loanCahFlowBean.mfeelectricity}  ,"
        "${loanCahFlowBean.mfesocialcharity}  ,"
        "${loanCahFlowBean.mfetotalfaminc}  ,"
        "${loanCahFlowBean.mfetotalexp}  ,"
        "${loanCahFlowBean.msurpluscash}  ,"
        "${loanCahFlowBean.mdbr}  ,"
        "'${loanCahFlowBean.mcreateddt}'  ,"
        "'${loanCahFlowBean.mcreatedby}'  ,"
        "'${loanCahFlowBean.mlastupdatedt}'  ,"
        "'${loanCahFlowBean.mlastupdateby}'  ,"
        "'${loanCahFlowBean.mgeolocation}'  ,"
        "'${loanCahFlowBean.mgeolatd}'  ,"
        "'${loanCahFlowBean.mgeologd}'  ,"
        "${loanCahFlowBean.missynctocoresys}  ,"
        "'${loanCahFlowBean.mlastsynsdate}'  ,"
        "${loanCahFlowBean.mloanmrefno}  ,"
        "${loanCahFlowBean.mloantrefno}  ,"
        "${loanCahFlowBean.mcustmrefno}  ,"
        "${loanCahFlowBean.mcusttrefno}  "
        ") ";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${TermDepositMaster}");
    });
  }

  Future<CustomerLoanCashFlowAnalysisBean> getCashFlowAnalysis(
      int loantrefno, int loanmrefno) async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CustomerLoanCashFlowAnalysisBean retBean =
    new CustomerLoanCashFlowAnalysisBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'SELECT *  FROM $CosutomerLoanCashFlowMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    var result = await db.rawQuery(
        'SELECT *  FROM $CosutomerLoanCashFlowMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    try {
      if (result[0] != null) {
        print(result);
        retBean = bindCashFlowBean(result[0]);
      }
    } catch (_) {
      retBean = null;
    }

    return retBean;
  }

  CustomerLoanCashFlowAnalysisBean bindCashFlowBean(
      Map<String, dynamic> result) {
    return CustomerLoanCashFlowAnalysisBean.fromMap(result);
  }

  Future<int> getMaxtrefNumber() async {
    String insertQuery = "SELECT *"
        "FROM    ${CosutomerLoanCashFlowMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${CosutomerLoanCashFlowMaster});";
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

  Future<List<CustomerLoanCashFlowAnalysisBean>> selectCashFlowListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CustomerLoanCashFlowAnalysisBean retBean =
    new CustomerLoanCashFlowAnalysisBean();
    List<CustomerLoanCashFlowAnalysisBean> n =
    new List<CustomerLoanCashFlowAnalysisBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${CosutomerLoanCashFlowMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${CosutomerLoanCashFlowMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    // try {
    for (int i = 0; i < result.length; i++) {
      print(result[i]);

      print(result[i].runtimeType);
      retBean = bindCashFlowBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }

    return n;
  }

  Future<CustomerLoanCashFlowAnalysisBean> selectCashFlowonTrefAndMref(
      int trefno, String mCreatedBy, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CosutomerLoanCashFlowMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CustomerLoanCashFlowAnalysisBean bean;
    if (result.isEmpty) {
      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${CosutomerLoanCashFlowMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      print(selectQueryIsDataSynced);
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanCashFlowAnalysisBean();
        bean = bindCashFlowBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateCustomerLoanCashFlowMasterMrefno(String query) async {
    var db = await _getDb();
    print("UPDATE ${CosutomerLoanCashFlowMaster} SET ${query}");
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CosutomerLoanCashFlowMaster} SET ${query}");
    });
  }

  //kycMaster
  Future _createKycMaster(Database db) {
    String query = "CREATE TABLE ${kycMaster} ("
        "${TablesColumnFile.trefno} INTEGER  ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mloantrefno} INTEGER,"
        "${TablesColumnFile.mloanmrefno} INTEGER,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mbackground} INTEGER,"
        "${TablesColumnFile.mjob} INTEGER,"
        "${TablesColumnFile.mlifestyle} INTEGER,"
        "${TablesColumnFile.mloanrepay} INTEGER,"
        "${TablesColumnFile.mnetworth} INTEGER,"
        "${TablesColumnFile.mcomments} TEXT,"
        "${TablesColumnFile.mverifiedinfo} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";

    print("xxxxxxxxxxxxxxxxxxx ${kycMaster} table Query Here is : " + query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

//kyc master Tref genration
  Future<int> generateTrefnoForKycMaster() async {
    print("trying to select last row  ${kycMaster}");
    String insertQuery =
        "SELECT * FROM    ${kycMaster}  WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${kycMaster});";
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

  //LoanCPVBusinessRecord CREATE

  Future _createLoanCPVBusinessRecord(Database db) {
    String query = "CREATE TABLE ${LoanCPVBusinessRecord} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mloantrefno} INTEGER ,"
        "${TablesColumnFile.mloanmrefno} INTEGER,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mhblocated} TEXT,"
        "${TablesColumnFile.mbusinessname} TEXT,"
        "${TablesColumnFile.mbusinessaddress} TEXT,"
        "${TablesColumnFile.maddresschanged} TEXT,"
        "${TablesColumnFile.mbusinesslicense} TEXT,"
        "${TablesColumnFile.mstartedym} DATETIME,"
        "${TablesColumnFile.mpropertystatus} INTEGER,"
        "${TablesColumnFile.mshopcondition} INTEGER,"
        "${TablesColumnFile.mbuslocation} TEXT,"
        "${TablesColumnFile.mpremisesphoto} TEXT,"
        "${TablesColumnFile.mpremisesphotosec} TEXT,"
        "${TablesColumnFile.mpremisesphotothird} TEXT,"
        "${TablesColumnFile.mnoofcustomers} TEXT,"
        "${TablesColumnFile.mcuslocation} INTEGER,"
        "${TablesColumnFile.mcusdealing} INTEGER,"
        "${TablesColumnFile.mcreditsales} TEXT,"
        "${TablesColumnFile.mperiodsale} TEXT,"
        "${TablesColumnFile.mapplicantsrole} INTEGER,"
        "${TablesColumnFile.mbuspartner} TEXT,"
        "${TablesColumnFile.mkeyperson} INTEGER,"
        "${TablesColumnFile.mcusbehaviour} INTEGER,"
        "${TablesColumnFile.mtransrecord} TEXT,"
        "${TablesColumnFile.mrecpurandsal} INTEGER,"
        "${TablesColumnFile.mbooksupdated} INTEGER,"
        "${TablesColumnFile.mivlandrecord} INTEGER,"
        "${TablesColumnFile.mivsalesregister} INTEGER,"
        "${TablesColumnFile.mivcreditregister} INTEGER,"
        "${TablesColumnFile.mivinventoryregister} INTEGER,"
        "${TablesColumnFile.mivsalaryslip} INTEGER,"
        "${TablesColumnFile.mivpassbook} INTEGER,"
        "${TablesColumnFile.mbuscategories} INTEGER,"
        "${TablesColumnFile.mleadstatus} INTEGER,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.missynctocoresys} INTEGER,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "PRIMARY KEY (${TablesColumnFile.trefno},${TablesColumnFile.mrefno})"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${LoanCPVBusinessRecord} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future _createCustomerLoanImageMaster(Database db) {
    String query = "CREATE TABLE ${customerLoanImageMaster} ( "
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.mloantrefno} INTEGER ,"
        "${TablesColumnFile.mloanmrefno} INTEGER,"
        "${TablesColumnFile.mcusttrefno} INTEGER,"
        "${TablesColumnFile.mcustmrefno} INTEGER,"
        "${TablesColumnFile.mimagestring} TEXT,"
        "${TablesColumnFile.mimagebyteorfolder} TEXT,"
        "${TablesColumnFile.mimagetype} Text,"
        "${TablesColumnFile.timgrefno} INTEGER ,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.missynctocoresys} DATETIME,"
        " PRIMARY KEY (${TablesColumnFile.mloantrefno},${TablesColumnFile.mloanmrefno},${TablesColumnFile.timgrefno} ) ) ;";

    print(
        "xxxxxxxxxxxxxxxxxxx ${customerLoanImageMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

//Genrate TREFNO for Loan CPV
  Future<int> generateTrefnoForLoanCPVBusinessRecord() async {
    print("trying to select last row  ${LoanCPVBusinessRecord}");
    String insertQuery =
        "SELECT * FROM    ${LoanCPVBusinessRecord}  WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${LoanCPVBusinessRecord});";
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

  Future<int> updateLoanCPVBusinessRecord(
      CustomerLoanCPVBusinessRecordBean loanCPVBusinessRecordObj) async {
    print("trying to insert or replace ${LoanCPVBusinessRecord}");
    String insertQuery = 'INSERT OR REPLACE INTO ${LoanCPVBusinessRecord} '
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.mloantrefno} ,"
        "${TablesColumnFile.mloanmrefno},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mcustmrefno}  ,"
        "${TablesColumnFile.mcusttrefno}  ,"
        "${TablesColumnFile.mhblocated},"
        "${TablesColumnFile.mbusinessname},"
        "${TablesColumnFile.mbusinessaddress},"
        "${TablesColumnFile.maddresschanged},"
        "${TablesColumnFile.mbusinesslicense},"
        "${TablesColumnFile.mstartedym},"
        "${TablesColumnFile.mpropertystatus},"
        "${TablesColumnFile.mshopcondition},"
        "${TablesColumnFile.mbuslocation},"
        "${TablesColumnFile.mpremisesphoto},"
        "${TablesColumnFile.mpremisesphotosec},"
        "${TablesColumnFile.mpremisesphotothird},"
        "${TablesColumnFile.mnoofcustomers},"
        "${TablesColumnFile.mcuslocation},"
        "${TablesColumnFile.mcusdealing},"
        "${TablesColumnFile.mcreditsales},"
        "${TablesColumnFile.mperiodsale},"
        "${TablesColumnFile.mapplicantsrole},"
        "${TablesColumnFile.mbuspartner},"
        "${TablesColumnFile.mkeyperson},"
        "${TablesColumnFile.mcusbehaviour},"
        "${TablesColumnFile.mtransrecord},"
        "${TablesColumnFile.mrecpurandsal},"
        "${TablesColumnFile.mbooksupdated},"
        "${TablesColumnFile.mivlandrecord},"
        "${TablesColumnFile.mivsalesregister},"
        "${TablesColumnFile.mivcreditregister},"
        "${TablesColumnFile.mivinventoryregister},"
        "${TablesColumnFile.mivsalaryslip},"
        "${TablesColumnFile.mivpassbook},"
        "${TablesColumnFile.mbuscategories},"
        "${TablesColumnFile.mleadstatus},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.missynctocoresys},"
        "${TablesColumnFile.mlastsynsdate})"
        "VALUES"
        "(${loanCPVBusinessRecordObj.trefno} ,"
        "${loanCPVBusinessRecordObj.mrefno} ,"
        "${loanCPVBusinessRecordObj.mloantrefno} ,"
        "${loanCPVBusinessRecordObj.mloanmrefno},"
        "'${loanCPVBusinessRecordObj.mleadsid}',"
        "${loanCPVBusinessRecordObj.mcusttrefno},"
        "${loanCPVBusinessRecordObj.mcustmrefno},"
        "'${loanCPVBusinessRecordObj.mhblocated}',"
        "'${loanCPVBusinessRecordObj.mbusinessname}',"
        "'${loanCPVBusinessRecordObj.mbusinessaddress}',"
        "'${loanCPVBusinessRecordObj.maddresschanged}',"
        "'${loanCPVBusinessRecordObj.mbusinesslicense}',"
        "'${loanCPVBusinessRecordObj.mstartedym}',"
        "${loanCPVBusinessRecordObj.mpropertystatus},"
        "${loanCPVBusinessRecordObj.mshopcondition},"
        "'${loanCPVBusinessRecordObj.mbuslocation}',"
        "'${loanCPVBusinessRecordObj.mpremisesphoto}',"
        "'${loanCPVBusinessRecordObj.mpremisesphotosec}',"
        "'${loanCPVBusinessRecordObj.mpremisesphotothird}',"
        "'${loanCPVBusinessRecordObj.mnoofcustomers}',"
        "${loanCPVBusinessRecordObj.mcuslocation},"
        "${loanCPVBusinessRecordObj.mcusdealing},"
        "'${loanCPVBusinessRecordObj.mcreditsales}',"
        "'${loanCPVBusinessRecordObj.mperiodsale}',"
        "${loanCPVBusinessRecordObj.mapplicantsrole},"
        "'${loanCPVBusinessRecordObj.mbuspartner}',"
        "${loanCPVBusinessRecordObj.mkeyperson},"
        "${loanCPVBusinessRecordObj.mcusbehaviour},"
        "'${loanCPVBusinessRecordObj.mtransrecord}',"
        "${loanCPVBusinessRecordObj.mrecpurandsal},"
        "${loanCPVBusinessRecordObj.mbooksupdated},"
        "${loanCPVBusinessRecordObj.mivlandrecord},"
        "${loanCPVBusinessRecordObj.mivsalesregister},"
        "${loanCPVBusinessRecordObj.mivcreditregister},"
        "${loanCPVBusinessRecordObj.mivinventoryregister},"
        "${loanCPVBusinessRecordObj.mivsalaryslip},"
        "${loanCPVBusinessRecordObj.mivpassbook},"
        "${loanCPVBusinessRecordObj.mbuscategories},"
        "${loanCPVBusinessRecordObj.mleadstatus},"
        "'${loanCPVBusinessRecordObj.mcreateddt}',"
        "'${loanCPVBusinessRecordObj.mcreatedby}',"
        "'${loanCPVBusinessRecordObj.mlastupdatedt}',"
        "'${loanCPVBusinessRecordObj.mlastupdateby}',"
        "'${loanCPVBusinessRecordObj.mgeolocation}',"
        "'${loanCPVBusinessRecordObj.mgeologd}',"
        "'${loanCPVBusinessRecordObj.mgeolatd}',"
        "${loanCPVBusinessRecordObj.missynctocoresys},"
        "'${loanCPVBusinessRecordObj.mlastsynsdate}'"
        ");";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${LoanCPVBusinessRecord}");
    });
  }

  Future<CustomerLoanCPVBusinessRecordBean> selectLoanCPVBusinessRecordOnTref(
      int trefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${LoanCPVBusinessRecord}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = '${mCreatedBy}'";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CustomerLoanCPVBusinessRecordBean bean;
    try {
      bean = new CustomerLoanCPVBusinessRecordBean();
      bean = bindLoanCPVBusinessRecordBean(result[0]);
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<CustomerLoanCPVBusinessRecordBean>>
  selectLoanCPVBusinessRecordIsDataSynced(DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${LoanCPVBusinessRecord}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${LoanCPVBusinessRecord}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<CustomerLoanCPVBusinessRecordBean> listbean =
    new List<CustomerLoanCPVBusinessRecordBean>();
    CustomerLoanCPVBusinessRecordBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanCPVBusinessRecordBean();
        bean = bindLoanCPVBusinessRecordBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<CustomerLoanCPVBusinessRecordBean> getLoanCPVValues(
      int loantrefno, int loanmrefno) async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    CustomerLoanCPVBusinessRecordBean retBean =
    new CustomerLoanCPVBusinessRecordBean();

    print('xxxxxxxxxxxxxxquery is here : ' +
        'SELECT *  FROM $LoanCPVBusinessRecord WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    var result = await db.rawQuery(
        'SELECT *  FROM $LoanCPVBusinessRecord WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    try {
      if (result[0] != null) {
        print(result);
        retBean = bindLoanCPVBusinessRecordBean(result[0]);
      }
    } catch (_) {
      retBean = null;
    }

    return retBean;
  }

  CustomerLoanCPVBusinessRecordBean bindLoanCPVBusinessRecordBean(
      Map<String, dynamic> result) {
    CustomerLoanCPVBusinessRecordBean customerLoanCPVBusinessRecordBean =
    new CustomerLoanCPVBusinessRecordBean();
    return CustomerLoanCPVBusinessRecordBean.fromMap(result);
  }

  Future updateCPVBusinessRecord(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${LoanCPVBusinessRecord} SET ${query}");
    });
  }

  Future updateCashFlowMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${CosutomerLoanCashFlowMaster} SET ${query}");
    });

    print(
        "Update cashFlow query is UPDATE ${CosutomerLoanCashFlowMaster} SET ${query} ");
  }

  Future<CustomerLoanCashFlowAnalysisBean> selectCashFlowonLoanTrefLoanmerefno(
      int mloanterfno, int mloanmrefno, bool bothCond) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${CosutomerLoanCashFlowMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty && bothCond == true) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${CosutomerLoanCashFlowMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno AND ${TablesColumnFile.mloanmrefno}  = 0 ";

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    CustomerLoanCashFlowAnalysisBean bean;
    //try {
    for (int i = 0; i < result.length; i++) {
      bean = new CustomerLoanCashFlowAnalysisBean();
      bean = bindCashFlowBean(result[i]);
    }
    /* } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }*/
    return bean;
  }

  Future<KycMasterBean> getKycMasterObj(int loantrefno, int loanmrefno) async {
    var db = await _getDb();
    // var adhaarNo = "${TablesColumnFile.adhaarNo} = ${creditBereauBean.adhaarNo}";
    KycMasterBean retBean;

    print('xxxxxxxxxxxxxxquery is here : ' +
        'SELECT *  FROM $kycMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    var result = await db.rawQuery(
        'SELECT *  FROM $kycMaster WHERE ${TablesColumnFile.mloantrefno} = ${loantrefno}'
            '  AND ${TablesColumnFile.mloanmrefno} = ${loanmrefno} ');
    try {
      if (result[0] != null) {
        print(result);
        retBean = bindKycMasterListBean(result[0]);
      }
    } catch (_) {
      retBean = null;
    }

    return retBean;
  }

  Future<DeviationFormBean> selectDeviationFormTrefLoanmerefno(
      int mloanterfno, int mloanmrefno, bool bothCondition) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${deviationFormMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty && bothCondition == true) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${deviationFormMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno AND ${TablesColumnFile.mloanmrefno}  = 0 ";

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    DeviationFormBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DeviationFormBean();
        bean = bindDataDeviationFormBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<SocialAndEnvironmentalBean> selectSocialAndEnvTrefLoanmerefno(
      int mloanterfno, int mloanmrefno, bool bothCondition) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${socialEnvironmentMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty && bothCondition == true) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${socialEnvironmentMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno AND ${TablesColumnFile.mloanmrefno}  = 0 ";

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    SocialAndEnvironmentalBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new SocialAndEnvironmentalBean();
        bean = bindSocialAndEnvironmentalFormBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<TradeAndNeighbourRefCheckBean> selectTradeAndNeighTrefLoanmerefno(
      int mloanterfno, int mloanmrefno, bool bothCondition) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${tradeNeighbourRefCheckMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty && bothCondition == true) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${tradeNeighbourRefCheckMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno AND ${TablesColumnFile.mloanmrefno}  = 0 ";

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    TradeAndNeighbourRefCheckBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new TradeAndNeighbourRefCheckBean();
        bean = bindTradeAndNeighbourRefFormBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<CustomerLoanCPVBusinessRecordBean> selectCPVTrefLoanmerefno(
      int mloanterfno, int mloanmrefno, bool bothCondition) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${LoanCPVBusinessRecord}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty && bothCondition == true) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${LoanCPVBusinessRecord}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno AND ${TablesColumnFile.mloanmrefno}  = 0 ";

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    CustomerLoanCPVBusinessRecordBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanCPVBusinessRecordBean();
        bean = bindLoanCPVBusinessRecordBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<SubLookupForSubPurposeOfLoan> getOccupation(
      int hardcodedValue, int position, String code) async {
    var db = await _getDb();

    SubLookupForSubPurposeOfLoan retBean = new SubLookupForSubPurposeOfLoan();

    print(
        "SELECT *  FROM $SubLookupMaster where ${TablesColumnFile.mcodetype}  = ${hardcodedValue + position}   AND   ${TablesColumnFile.mcode} = '${code}' ");

    var result;
    result = await db.rawQuery(
        "SELECT *  FROM $SubLookupMaster where ${TablesColumnFile.mcodetype}  = ${hardcodedValue + position}   AND   ${TablesColumnFile.mcode} = '${code}' ");
    try {
      retBean = bindPurposeOfLoan(result[0]);
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  Future<int> updateAgentBiometric(String userCode, String fingerType,
      String agentleftfinger, String agentrightfinger) async {
    var db = await _getDb();
    String query;
    if (fingerType == "LH") {
      query = "Update $userMasterTable SET ${TablesColumnFile.agentleftfinger} "
          "= '${agentleftfinger}'";
      // " WHERE ${TablesColumnFile.musrcode}  = '${userCode}' ";
    } else if (fingerType == "RH") {
      query =
      "Update $userMasterTable SET ${TablesColumnFile.agentrightfinger} "
          "='${agentrightfinger}' ";
      // " WHERE ${TablesColumnFile.musrcode}  = '${userCode}' ";
    } else if (fingerType == "BOTH") {
      query = "Update $userMasterTable SET ${TablesColumnFile.agentleftfinger} "
          "= '${agentleftfinger}'"
          ", ${TablesColumnFile.agentrightfinger}  = '${agentrightfinger}'";
      // "  WHERE ${TablesColumnFile.musrcode}  = '${userCode}' ";
    }

    print("xxxxxxxxxxxxxx query is here : " + query);
    //var result = await db.rawQuery(query);
    int id = 0;
    try {
      await db.transaction((Transaction txn) async {
        id = await txn.rawInsert(query);
        print(id.toString() + " id after insert in ${userMasterTable}");
        return id;
      });
    } catch (_) {
      id = 0;
      return id;
    }
  }

  Future<LoginBean> getAgentFingerPrint() async {
    var db = await _getDb();
    LoginBean retBean = new LoginBean();

    print('query is here : ' +
        'SELECT ${TablesColumnFile.agentleftfinger},${TablesColumnFile.agentrightfinger}'
            ' FROM $userMasterTable ');
    var result = await db.rawQuery(
        'SELECT ${TablesColumnFile.agentleftfinger},${TablesColumnFile.agentrightfinger}'
            ' FROM $userMasterTable ');
    try {
      if (result[0] != null) {
        print(result[0]);
        retBean = bindDataLoginBEan(result);
      }
    } catch (_) {
      print("Exception Occured");
    }
    return retBean;
  }

  Future<GuarantorDetailsBean> selectGuarantorTrefLoanmerefno(
      int mloanterfno, int mloanmrefno, bool bothCodition) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty && bothCodition == true) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno AND ${TablesColumnFile.mloanmrefno}  = 0 ";

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    GuarantorDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GuarantorDetailsBean();
        bean = bindLoanGuarantorDetailsBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<SavingsListBean>> getSavingListOnOfflienCust(
      int trefno, int mrefno) async {
    try {
      var db = await _getDb();
      print("trefno is ${trefno}"  );
      print("mrefno is ${mrefno}");

      print("inside get ALl Objects");
      SavingsListBean retBean;
      SavingsListBean retBean2;
      List<SavingsListBean> n = new List<SavingsListBean>();

      var result;
      var savingCollectionResult;

      result = await db.rawQuery(
          'SELECT *  FROM $savingsMaster WHERE ${TablesColumnFile.mcusttrefno}  = $trefno AND  '
              '${TablesColumnFile.mcustmrefno}   = $mrefno ');
      try {
        retBean = new SavingsListBean();
        retBean = bindDataSavingsListBean(result[0]);
      } catch (_) {
        print("No Account Found");
      }
      if (result.isNotEmpty && retBean != null) {
        print("query is" +
            "SELECT *  FROM $savingsCollectionMaster WHERE "
                " ${TablesColumnFile.msvngacctrefno}  =  ${retBean.trefno}  AND "
                " ${TablesColumnFile.msvngaccmrefno}  =  ${retBean.mrefno}");

        savingCollectionResult = await db.rawQuery(
            "SELECT *  FROM $savingsCollectionMaster WHERE "
                " ${TablesColumnFile.msvngacctrefno}  =  ${retBean.trefno}  AND "
                " ${TablesColumnFile.msvngaccmrefno}  =  ${retBean.mrefno}  ");
      } else {
        savingCollectionResult = null;
      }

      try {
        for (int i = 0; i < savingCollectionResult.length; i++) {
          retBean2 = new  SavingsListBean();
          retBean2 = bindDataSavingsListBean(savingCollectionResult[i]);
          print("exiting from map");
          n.add(retBean2);
        }

      } catch (e) {
        retBean2 = null;
        n.add(retBean2);
        print(e.toString());
      }

      return n;
    } catch (e) {
      return null;
    }
  }

  Future<List<CustomerLoanImageBean>> selectCustomerLoanImage(
      int tRefNo, int mRefNo) async {
    var db = await _getDb();
    var result;
    if (mRefNo == 0 || mRefNo == null) {
      result = await db.rawQuery(
          "SELECT * FROM ${customerLoanImageMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $tRefNo "
          "AND  ( ${TablesColumnFile.mloanmrefno} = 0 OR ${TablesColumnFile.mloanmrefno} IS NULL )  ");
    } else {
      result = await db.rawQuery(
          "SELECT * FROM ${customerLoanImageMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $tRefNo "
          "AND  ${TablesColumnFile.mloanmrefno} = $mRefNo");
    }

    List<CustomerLoanImageBean> listbean = new List<CustomerLoanImageBean>();
    CustomerLoanImageBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanImageBean();
        bean = bindLoanDataImagessListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  CustomerLoanImageBean bindLoanDataImagessListBean(
      Map<String, dynamic> result) {
    return CustomerLoanImageBean.fromMap(result);
  }

  Future updateCustomerLoanImageQuery(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${customerLoanImageMaster} SET ${query}");
    });
  }

  Future<CustomerLoanImageBean> selectCustomerLoanImageOnmreftref(
      int mloanterfno, int mloanmrefno) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${customerLoanImageMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${customerLoanImageMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno AND  ${TablesColumnFile.mloanmrefno}  = 0 ";

      print(" Query after empty ${selectQueryIsDataSynced}");

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);

      print("Result is after first check ${result}");
    }

    CustomerLoanImageBean bean;
    //try {
    for (int i = 0; i < result.length; i++) {
      bean = new CustomerLoanImageBean();
      bean = bindLoanDataImagessListBean(result[i]);
    }
    /* } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }*/
    return bean;
  }

  Future<List<CustomerLoanImageBean>> selectCustomerLoanImageNotSynced() async {
    var db = await _getDb();
    CustomerLoanImageBean retBean = new CustomerLoanImageBean();
    List<CustomerLoanImageBean> n = new List<CustomerLoanImageBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerLoanImageMaster}  WHERE  ${TablesColumnFile.missynctocoresys} = 0 OR '
        ' ${TablesColumnFile.missynctocoresys} IS NULL ';
    result = await db.rawQuery(selectQueryIsDataSynced);

    // try {
    for (int i = 0; i < result.length; i++) {
      print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }
      print(result[i].runtimeType);
      retBean = bindLoanDataImagessListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }*/
    return n;
  }

  Future<List<CustomerLoanImageBean>> getCustomerLoanImage(
      int mrefno, int trefno) async {
    var db = await _getDb();
    CustomerLoanImageBean retBean = new CustomerLoanImageBean();
    List<CustomerLoanImageBean> customerLoanImageList =
    new List<CustomerLoanImageBean>();
    String query =
        "SELECT *  FROM $customerLoanImageMaster  WHERE  ${TablesColumnFile.mloanmrefno} = ${mrefno} AND ${TablesColumnFile.mloantrefno} = ${trefno}";
    var result;
    print("query is" + "SELECT *  FROM $customerLoanImageMaster ");
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        print("yes yaha cgt1 " + result[i].toString());
        print(result[i].runtimeType);
        for (var items in result[i].toString().split(",")) {
          print(items);
        }

        retBean = bindLoanDataImagessListBean(result[i]);

        customerLoanImageList.add(retBean);
      }
    } catch (e) {
      print(StackTrace.current);
      debugPrintStack();
      print(e.toString());
    }
    return customerLoanImageList;
  }

  Future<int> getMaxCustomerLoanImageNumber() async {
    String insertQuery = "SELECT *"
        "FROM    ${customerLoanImageMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${customerLoanImageMaster});";
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

  Future<List<LastSyncDateTimeBean>> getDateTime() async {
    var db = await _getDb();
    LastSyncDateTimeBean retBean = new LastSyncDateTimeBean();
    List<LastSyncDateTimeBean> n = new List<LastSyncDateTimeBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced =
        'SELECT * FROM ${lastSyncedDateTimeMaster} ';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        //print(result[i].runtimeType);
        retBean = bindLastSyncMaster(result[i]);
        //print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  LastSyncDateTimeBean bindLastSyncMaster(Map<String, dynamic> result) {
    return LastSyncDateTimeBean.fromMap(result);
  }

  Future<KycMasterBean> selectKycMasterTrefLoanmerefno(
      int mloanterfno, int mloanmrefno) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${kycMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${kycMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno  AND ${TablesColumnFile.mloanmrefno}  = 0 ";

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    KycMasterBean bean;
    //try {
    for (int i = 0; i < result.length; i++) {
      bean = new KycMasterBean();
      bean = bindKycMasterListBean(result[i]);
    }
    /* } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }*/
    return bean;
  }

  Future updateKYC(String query) async {
    print("update kyc me aaya");
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${kycMaster} SET ${query}");
      print("updatekyczzzzzzzzzzzzzzzzzzzz ${kycMaster} SET ${query} ");
    });
  }

  Future updateDisbursedMaster(DisbursmentBean disbursmentBean) async {
    print("trying to insert or replace ${disbursedMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${disbursedMaster}( "
        "${TablesColumnFile.trefno},"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.mlbrcode},"
        "${TablesColumnFile.mcustno},"
        "${TablesColumnFile.mprdacctid},"
        "${TablesColumnFile.mlongname},"
        "${TablesColumnFile.mgroupcd},"
        "${TablesColumnFile.mefffromdate},"
        "${TablesColumnFile.mdisburseddate},"
        "${TablesColumnFile.minstlstartdate},"
        "${TablesColumnFile.minstlamt},"
        "${TablesColumnFile.minstlintcomp},"
        "${TablesColumnFile.mleadsid},"
        "${TablesColumnFile.mappliedasindvyn},"
        "${TablesColumnFile.mnewtopupflag},"
        "${TablesColumnFile.msancdate},"
        "${TablesColumnFile.mdisbursedamt},"
        "${TablesColumnFile.msdamt},"
        "${TablesColumnFile.mrebateamt},"
        "${TablesColumnFile.mchargesamt},"
        "${TablesColumnFile.mdisbursedamtcoltd},"
        "${TablesColumnFile.msdamtcoltd},"
        "${TablesColumnFile.mrebateamtcoltd},"
        "${TablesColumnFile.mchargesamtcoltd},"
        "${TablesColumnFile.mdisbursedamtflag},"
        "${TablesColumnFile.msdamtflag},"
        "${TablesColumnFile.mrebateamtflag},"
        "${TablesColumnFile.mchargesamtflag},"
        "${TablesColumnFile.mreason},"
        "${TablesColumnFile.msetno},"
        "${TablesColumnFile.mscrollno},"
        "${TablesColumnFile.mentrydate},"
        "${TablesColumnFile.mbatchcd},"
        "${TablesColumnFile.mmainscrollno},"
        "${TablesColumnFile.mbatchnumber},"
        "${TablesColumnFile.mnarration},"
        "${TablesColumnFile.mcenterid},"
        "${TablesColumnFile.mcrs},"
        "${TablesColumnFile.msuspbatchcd},"
        "${TablesColumnFile.msuspsetno},"
        "${TablesColumnFile.msuspscrollno},"
        "${TablesColumnFile.msspmainscrollno},"
        "${TablesColumnFile.mpartcashamount},"
        "${TablesColumnFile.mpartcashbatchcd},"
        "${TablesColumnFile.mpartcashsetno},"
        "${TablesColumnFile.mpartcashscrollno},"
        "${TablesColumnFile.mpartcashmainscrollno},"
        "${TablesColumnFile.mneftclsrBatchCd},"
        "${TablesColumnFile.mneftclsrsetno},"
        "${TablesColumnFile.mneftclsrscrollno},"
        "${TablesColumnFile.mneftclsrmainscrollno},"
        "${TablesColumnFile.mcreateddt},"
        "${TablesColumnFile.mcreatedby},"
        "${TablesColumnFile.mlastupdatedt},"
        "${TablesColumnFile.mlastupdateby},"
        "${TablesColumnFile.mgeolocation},"
        "${TablesColumnFile.mgeolatd},"
        "${TablesColumnFile.mgeologd},"
        "${TablesColumnFile.mlastsynsdate},"
        "${TablesColumnFile.merrormessage},"
        "${TablesColumnFile.mdisbamount},"
        "${TablesColumnFile.mchargesamt1},"
        "${TablesColumnFile.mchargesamt2},"
        "${TablesColumnFile.mchargesamt0},"
        "${TablesColumnFile.mchargesamt3},"
        "${TablesColumnFile.mchargesamt4},"
        "${TablesColumnFile.mchargesamt5},"
        "${TablesColumnFile.mchargesamt6},"
        "${TablesColumnFile.mchargesamt7},"
        "${TablesColumnFile.mchargesamt8},"
        "${TablesColumnFile.mchargesamt9},"
        "${TablesColumnFile.mcheckbiometric} ,"
        "${TablesColumnFile.mdisbstatus} ,"
        "${TablesColumnFile.mrouteto} ,"
        "${TablesColumnFile.mremarks},"
        "${TablesColumnFile.misauthorized},"
        "${TablesColumnFile.mamttodisb},"
        "${TablesColumnFile.missynctocoresys}"
        ")"
        "VALUES("
        "${disbursmentBean.trefno},"
        "${disbursmentBean.mrefno},"
        "${disbursmentBean.mlbrcode},"
        "${disbursmentBean.mcustno},"
        "'${disbursmentBean.mprdacctid}',"
        "'${disbursmentBean.mlongname}',"
        "${disbursmentBean.mgroupcd},"
        "'${disbursmentBean.mefffromdate}',"
        "'${disbursmentBean.mdisburseddate}',"
        "'${disbursmentBean.minstlstartdate}',"
        "${disbursmentBean.minstlamt},"
        "${disbursmentBean.minstlintcomp},"
        "'${disbursmentBean.mleadsid}',"
        "'${disbursmentBean.mappliedasindvyn}',"
        "${disbursmentBean.mnewtopupflag},"
        "'${disbursmentBean.msancdate}',"
        "${disbursmentBean.mdisbursedamt},"
        "${disbursmentBean.msdamt},"
        "${disbursmentBean.mrebateamt},"
        "${disbursmentBean.mchargesamt},"
        "${disbursmentBean.mdisbursedamtcoltd},"
        "${disbursmentBean.msdamtcoltd},"
        "${disbursmentBean.mrebateamtcoltd},"
        "${disbursmentBean.mchargesamtcoltd},"
        "${disbursmentBean.mdisbursedamtflag},"
        "${disbursmentBean.msdamtflag},"
        "${disbursmentBean.mrebateamtflag},"
        "${disbursmentBean.mchargesamtflag},"
        "'${disbursmentBean.mreason}',"
        "${disbursmentBean.msetno},"
        "${disbursmentBean.mscrollno},"
        "'${disbursmentBean.mentrydate}',"
        "'${disbursmentBean.mbatchcd}',"
        "${disbursmentBean.mmainscrollno},"
        "'${disbursmentBean.mbatchnumber}',"
        "'${disbursmentBean.mnarration}',"
        "${disbursmentBean.mcenterid},"
        "'${disbursmentBean.mcrs}',"
        "'${disbursmentBean.msuspbatchcd}',"
        "${disbursmentBean.msuspsetno},"
        "${disbursmentBean.msuspscrollno},"
        "${disbursmentBean.msspmainscrollno},"
        "${disbursmentBean.mpartcashamount},"
        "'${disbursmentBean.mpartcashbatchcd}',"
        "${disbursmentBean.mpartcashsetno},"
        "${disbursmentBean.mpartcashscrollno},"
        "${disbursmentBean.mpartcashmainscrollno},"
        "'${disbursmentBean.mneftclsrBatchCd}',"
        "${disbursmentBean.mneftclsrsetno},"
        "${disbursmentBean.mneftclsrscrollno},"
        "${disbursmentBean.mneftclsrmainscrollno},"
        "'${disbursmentBean.mcreateddt}',"
        "'${disbursmentBean.mcreatedby}',"
        "'${disbursmentBean.mlastupdatedt}',"
        "'${disbursmentBean.mlastupdateby}',"
        "'${disbursmentBean.mgeolocation}',"
        "'${disbursmentBean.mgeolatd}',"
        "'${disbursmentBean.mgeologd}',"
        "'${disbursmentBean.mlastsynsdate}',"
        "'${disbursmentBean.merrormessage}',"
        "${disbursmentBean.mdisbamount},"
        "${disbursmentBean.mchargesamt1},"
        "${disbursmentBean.mchargesamt2},"
        "${disbursmentBean.mchargesamt0},"
        "${disbursmentBean.mchargesamt3},"
        "${disbursmentBean.mchargesamt4},"
        "${disbursmentBean.mchargesamt5},"
        "${disbursmentBean.mchargesamt6},"
        "${disbursmentBean.mchargesamt7},"
        "${disbursmentBean.mchargesamt8},"
        "${disbursmentBean.mchargesamt9},"
        "${disbursmentBean.mcheckbiometric},"
        "${disbursmentBean.mdisbstatus} ,"
        "'${disbursmentBean.mrouteto}' ,"
        "'${disbursmentBean.mremarks}',"
        "${disbursmentBean.misauthorized},"
        "${disbursmentBean.mamttodisb},"
        "${0}"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${disbursedMaster}");
    });
  }

  Future<List<DisbursmentBean>> selectDisbursedListIsDataSynced(
      DateTime lastSyncDateTime) async {
    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    /*  ? 'SELECT * FROM ${savingsMaster}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime" AND ${TablesColumnFile.trefno}>0'
        : 'SELECT * FROM ${savingsMaster} WHERE ${TablesColumnFile.trefno}>0 ';*/
        ? 'SELECT * FROM ${disbursedMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${disbursedMaster}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print("result" + result.toString());
    List<DisbursmentBean> listbean = new List<DisbursmentBean>();
    DisbursmentBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new DisbursmentBean();
        bean = bindDataDisbursmentListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future updateDisbursedListMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${disbursedMaster} SET ${query}");
    });
  }

  Future<CustomerListBean> getDedupCustomerIfPresent(
      String nid, DateTime mdob, bool isFullrtn) async {
    var db = await _getDb();
    CustomerListBean retBean = null;
    var result;
    String selectCustQuery = "";
    if (isFullrtn) {
      String nidSubs = "";
      print(nid);
      try {
        nidSubs = nid.substring(nid.length - 6, nid.length);
      } catch (_) {
        print("nidSubs");
      }

      selectCustQuery =
      "SELECT *FROM ${customerFoundationMasterDetails} where ${TablesColumnFile.mdob} = '$mdob' AND   substr(mpannodesc,length(mpannodesc)-5,6) ='$nidSubs';";

      print("dedup offline ${selectCustQuery}");
    } else {
      selectCustQuery =
      "SELECT *FROM ${customerFoundationMasterDetails} where ${TablesColumnFile.mpannodesc} = '${nid}';";
    }
    try {
      result = await db.rawQuery(selectCustQuery);
      print("result here is " + result.toString());
      if (result[0] != null) {
        retBean = CustomerListBean.fromMapMiddlewareDedup(result[0], true);
      }

      return retBean;
    } catch (_) {
      print("not matched");
    }
    return retBean;
  }

  Future<List<Map<String, dynamic>>> selectTableName(String tableName) async {
    String selectQueryIsDataSynced = tableName;

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty) {}
    return result;
  }

  Future<List<GuarantorDetailsBean>> selectGuarantorListObjOnTrefLoanmerefno(
      int mloanterfno, int mloanmrefno, bool bothCodition) async {
    String selectQueryIsDataSynced =
        "SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno And ${TablesColumnFile.mloanmrefno}  = ${mloanmrefno} ";

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());
    if (result.isEmpty && bothCodition == true) {
      print("return query is empty");
      selectQueryIsDataSynced =
      "SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.mloantrefno}  = $mloanterfno AND ${TablesColumnFile.mloanmrefno}  = 0 ";

      var db = await _getDb();
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    List<GuarantorDetailsBean> listbean = new List<GuarantorDetailsBean>();

    GuarantorDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GuarantorDetailsBean();
        bean = bindLoanGuarantorDetailsBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future<GuarantorDetailsBean>
  selectGuarantorOnTrefMrerfoForMiddlewareResponseUpdate(
      int trefno, String mCreatedBy, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    GuarantorDetailsBean bean;
    if (result.isEmpty) {
      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${gaurantorMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      print(selectQueryIsDataSynced);
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new GuarantorDetailsBean();
        bean = bindGuarantorDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<LoanCycleParameterPrimaryBean>> selectPrimaryTableForValidtion(
      String prdCode, int loanCycle, int mlbrcd, String mfrequ) async {
    String selectQuery =
        'SELECT   * FROM ${LoanCycleParameterPrimaryMaster} WHERE '
        '${TablesColumnFile.mlbrcode} = ${mlbrcd}  AND ${TablesColumnFile.mloancycle} = ${loanCycle} '
        'AND ${TablesColumnFile.mprdcd} = "${prdCode.trim()}" AND ${TablesColumnFile.mfrequency} = "${mfrequ}" order by ${TablesColumnFile.meffdate} desc limit 1';

    print("cycle amt " + selectQuery);

    // try {
    List<LoanCycleParameterPrimaryBean> loanCycleParameterPrimaryBean =
    new List<LoanCycleParameterPrimaryBean>();
    var db = await _getDb();
    var result = await db.rawQuery(selectQuery);
    print("cycle amt " + selectQuery);

    if (result.length > 0 && result[0] != null) {
      for (int i = 0; i < result.length; i++) {
        print("result ${result} ");
        var bean = LoanCycleParameterPrimaryBean.fromMapData(result[i]);
        loanCycleParameterPrimaryBean.add(bean);
      }
    } else {
      selectQuery = 'SELECT   * FROM ${LoanCycleParameterPrimaryMaster} WHERE '
          '${TablesColumnFile.mlbrcode} = ${mlbrcd}  AND ${TablesColumnFile.mloancycle} = 99 '
          'AND ${TablesColumnFile.mprdcd} = "${prdCode.trim()}" AND ${TablesColumnFile.mfrequency} = "${mfrequ}" order by ${TablesColumnFile.meffdate} desc limit 1';

      result = await db.rawQuery(selectQuery);

      if (result.length > 0 && result[0] != null) {
        for (int i = 0; i < result.length; i++) {
          print("result ${result} ");
          var bean = LoanCycleParameterPrimaryBean.fromMapData(result[i]);
          loanCycleParameterPrimaryBean.add(bean);
        }
      }
    }
    print("cycle amt " + selectQuery);
    return loanCycleParameterPrimaryBean;
    /*} catch (_) {
      print("exception here ");
    }*/
  }

  //select customer based on last synced date time
  Future<List<CustomerListBean>> selectCustomerListIsDataSyncedZero(
      int isDataSynced) async {
    String selectQueryIsDataSynced =
    /*lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
    //? 'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.mcreateddt}  > "$lastSyncDateTime" OR ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        ? 'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile
        .mlastupdatedt}  > "$lastSyncDateTime"'
        : */
        'SELECT * FROM ${customerFoundationMasterDetails} WHERE ${TablesColumnFile.missynctocoresys}  = $isDataSynced ';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    List<CustomerListBean> listbean = new List<CustomerListBean>();
    CustomerListBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
        listbean.add(bean);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return listbean;
  }

  Future deleteQuery(List<String> rawQuery) async {
    var db = await _getDb();
    for (String query in rawQuery) {
      try {
        await db.transaction((Transaction txn) async {
          await txn.rawDelete(query);
        });
      } catch (_) {}
    }
  }

  Future<List<PrintEntity>> getSummaryOfSavings() async {
    try {
      var db = await _getDb();

      print("inside get ALl Objects");
      PrintEntity retBean = new PrintEntity();
      List<PrintEntity> n = new List<PrintEntity>();

      String todayDate = DateTime.now().toString();
      print(todayDate);

      todayDate = todayDate.replaceRange(11, 26, "00:00:00.000000");
      print(todayDate);

      DateTime date = DateTime.parse(todayDate);
      print(date);

      var result;
      /* print("query is" +
          "SELECT *  FROM $savingsCollectionMaster WHERE ${TablesColumnFile
              .mcreateddt} >= '$date';");

      result = await db.rawQuery(
          "SELECT *  FROM $savingsCollectionMaster Where ${TablesColumnFile
              .mcreateddt} >= '$date';");*/

      String query =
          "SELECT SUM(${savingsCollectionMaster}.${TablesColumnFile.mcollectedamount}) AS ${TablesColumnFile.mtotal},"
          "${groupFoundationMaster}.${TablesColumnFile.mgroupid} AS ${TablesColumnFile.mgroupid} ,"
          "${groupFoundationMaster}.${TablesColumnFile.mgroupname} AS ${TablesColumnFile.mgroupname} FROM "
          "${savingsCollectionMaster} INNER JOIN ${savingsMaster} ON "
          " ${savingsCollectionMaster}.${TablesColumnFile.msvngacctrefno} =  ${savingsMaster}.${TablesColumnFile.trefno} AND "
          " ${savingsCollectionMaster}.${TablesColumnFile.msvngaccmrefno} =  ${savingsMaster}.${TablesColumnFile.mrefno} AND "
          "${savingsCollectionMaster}.${TablesColumnFile.mcreateddt} >= '$date' "
          "LEFT JOIN ${groupFoundationMaster} "
          "ON ${groupFoundationMaster}.${TablesColumnFile.mgroupid} = ${savingsMaster}.${TablesColumnFile.mgroupcd} "
          "GROUP BY ${groupFoundationMaster}.${TablesColumnFile.mgroupid},${groupFoundationMaster}.${TablesColumnFile.mgroupname}";

      print(query);

      result = await db.rawQuery(query);

      try {
        for (int i = 0; i < result.length; i++) {
          print(result[i].runtimeType);
          retBean = bindDataPrintBean(result[i]);
          print("exiting from map");
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

  PrintEntity bindDataPrintBean(Map<String, dynamic> result) {
    PrintEntity printBean = new PrintEntity();
    return PrintEntity.fromMap(result);
  }

  Future<List<DisbursmentBean>> getDisbursmentStatusList([DateTime disbDate]) async {
    DisbursmentBean disBean = new DisbursmentBean();
    List<DisbursmentBean> retBeanList = new List<DisbursmentBean>();
    /*WHERE ${TablesColumnFile.missynctocoresys} IN (0,2)*/
    String query ;
    if(disbDate==null) query = "SELECT * FROM ${disbursedMaster} ";
    else query = "SELECT * FROM ${disbursedMaster}  WHERE ${TablesColumnFile.mdisburseddate} = '${disbDate}' ";
    print(query);
    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        //for (var items in result[i].toString().split(",")) {}
        print(result[i].runtimeType);
        disBean = bindDataDisbursmentListBean(result[i]);
        print("exiting from map");
        retBeanList.add(disBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBeanList;
  }

  //collection master

  Future<List<CollectionMasterBean>> getCollectedMasterDataFromLocalDb(
      String prdcdid) async {
    var db = await _getDb();
    CollectionMasterBean retBean = new CollectionMasterBean();
    List<CollectionMasterBean> n = new List<CollectionMasterBean>();
    var result;

    String seleQuery =
        "SELECT *  FROM $collectedLoansAmtMaster WHERE ${TablesColumnFile.mprdacctid} ='${prdcdid}' ";

    print("seleQuery" + seleQuery);
    if (seleQuery != null && seleQuery != "") {
      result = await db.rawQuery(seleQuery);
    }

    try {
      if (result.length > 0 && result[0] != null) {
        for (int i = 0; i < result.length; i++) {
          retBean = CollectionMasterBean.fromMap(result[i]);
          n.add(retBean);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future<List<PrintEntityDailyCollection>> getSummaryOfDailyCollection() async {
    try {
      var db = await _getDb();
      print("inside get ALl Objects");
      PrintEntityDailyCollection retBean = new PrintEntityDailyCollection();
      List<PrintEntityDailyCollection> n =
      new List<PrintEntityDailyCollection>();
      String todayDate = DateTime.now().toString();
      print(todayDate);
      todayDate = todayDate.replaceRange(11, 26, "00:00:00.000000");
      print(todayDate);
      DateTime date = DateTime.parse(todayDate);
      print(date);
      var result;
      String query =
          "SELECT SUM(${collectedLoansAmtMaster}.${TablesColumnFile.mcollamt}) AS ${TablesColumnFile.mtotal},"
          "${groupFoundationMaster}.${TablesColumnFile.mgroupid} AS ${TablesColumnFile.mgroupid} ,"
          "${groupFoundationMaster}.${TablesColumnFile.mgroupname} AS ${TablesColumnFile.mgroupname} FROM "
          "${collectedLoansAmtMaster} INNER JOIN ${collectionMaster} ON "
          " ${collectedLoansAmtMaster}.${TablesColumnFile.mprdacctid} =  ${collectionMaster}.${TablesColumnFile.mprdacctid} AND "
          "${collectedLoansAmtMaster}.${TablesColumnFile.mcreateddt} >= '$date' "
          "LEFT JOIN ${groupFoundationMaster} "
          "ON ${groupFoundationMaster}.${TablesColumnFile.mgroupid} = ${collectionMaster}.${TablesColumnFile.mgroupid} "
          "GROUP BY ${groupFoundationMaster}.${TablesColumnFile.mgroupid},${groupFoundationMaster}.${TablesColumnFile.mgroupname}";
      print(query);
      result = await db.rawQuery(query);
      try {
        for (int i = 0; i < result.length; i++) {
          print(result[i].runtimeType);
          retBean = bindDataPrintdcBean(result[i]);
          print("exiting from map");
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

  PrintEntityDailyCollection bindDataPrintdcBean(Map<String, dynamic> result) {
    PrintEntityDailyCollection printBean = new PrintEntityDailyCollection();
    return PrintEntityDailyCollection.fromMap(result);
  }

  Future<UserVaultBalanceBean> getVaultBalance(String userCd) async {
    var db = await _getDb();
    UserVaultBalanceBean retBean = new UserVaultBalanceBean();
    var result;

    result = await db.rawQuery(
        "SELECT *  FROM $userVaultBalance WHERE ${TablesColumnFile.musercode} = '${userCd}' ;");
    print(
        "SELECT *  FROM $userVaultBalance WHERE ${TablesColumnFile.musercode} = '$userCd' ;" +
            result.toString() +
            result.length.toString());
    try {
      for (int i = 0; i < result.length; i++) {
        retBean = bindVault(result[i]);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBean;
  }

  UserVaultBalanceBean bindVault(Map<String, dynamic> result) {
    return UserVaultBalanceBean.fromMap(result);
  }



  Future updateUserActivityMaster(UserActivityBean bean) async {
    print("trying to insert or replace ${UserActivityMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${UserActivityMaster}  "
        "(${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno},"
        "${TablesColumnFile.musercode1},"
        "${TablesColumnFile.mcustno} ,"
        "${TablesColumnFile.mcenterid} ,"
        "${TablesColumnFile.mgroupcd} ,"
        "${TablesColumnFile.mtxnamount} ,"
        "${TablesColumnFile.msystemnarration}, "
        "${TablesColumnFile.musernarration} ,"
        "${TablesColumnFile.mactivity} ,"
        "${TablesColumnFile.mmoduletype}, "
        "${TablesColumnFile.mtxnrefno} ,"
        "${TablesColumnFile.mcorerefno}, "
        "${TablesColumnFile.status} ,"
        "${TablesColumnFile.screenname}, "
        "${TablesColumnFile.mcreateddt}  ,"
        "${TablesColumnFile.mcreatedby}  ,"
        "${TablesColumnFile.mlastupdatedt}  ,"
        "${TablesColumnFile.mlastupdateby}  ,"
        "${TablesColumnFile.mgeolocation}  ,"
        "${TablesColumnFile.mgeolatd}  ,"
        "${TablesColumnFile.mgeologd}  ,"
        "${TablesColumnFile.mlastsynsdate}  ,"
        "${TablesColumnFile.missynctocoresys} ,"
        "${TablesColumnFile.mentrydate}, "
        "${TablesColumnFile.mprdacctid} "
        ") "
        "VALUES "
        "(${bean.trefno} ,"
        "${bean.mrefno} ,"
        "'${bean.musercode}' ,"
        "${bean.mcustno},"
        "${bean.mcenterid},"
        "${bean.mgroupcd},"
        "'${bean.mtxnamount}',"
        "'${bean.msystemnarration}',"
        "'${bean.musernarration}',"
        "'${bean.mactivity}',"
        "${bean.mmoduletype},"
        "'${bean.mtxnrefno}',"
        "'${bean.mcorerefno}',"
        "'${bean.status}',"
        "'${bean.screenname}',"
        "'${bean.mcreateddt}',"
        "'${bean.mcreatedby}',"
        "'${bean.mlastupdatedt}',"
        "'${bean.mlastupdateby}',"
        "'${bean.mgeolocation}',"
        "'${bean.mgeologd}',"
        "'${bean.mgeolatd}',"
        "'${bean.mlastsynsdate}',"
        "${bean.missynctocoresys},"
        "'${bean.mentrydate}' ,"
        "'${bean.mprdacctid}' "
        "); ";
    print("insert query is" + insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(insertQuery.toString() +
          " insertQuery after insert in ${UserActivityMaster}");
    });
  }

  Future UpdateByQuery(String query) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(query);
    });
  }

  Future<LoanCycleParameterPrimaryBean> getMinMaxGroupSize(
      int lbrcode, String prdCode) async {
    String selectQuery =
        "SELECT * FROM ${LoanCycleParameterPrimaryMaster} WHERE "
        " ${TablesColumnFile.mlbrcode} = ${lbrcode} "
        "AND ${TablesColumnFile.mprdcd} = '${prdCode.trim()}' "
        " order by ${TablesColumnFile.meffdate} DESC LIMIT 1 ";

    print("Select Query is " + selectQuery);

    // try {
    LoanCycleParameterPrimaryBean loanCycleParameterPrimaryBean;
    var db = await _getDb();
    var result = await db.rawQuery(selectQuery);
    print("cycle amt " + selectQuery);
    print("result ${result} ");

    //try{

    if (result.length > 0 && result[0] != null) {
      loanCycleParameterPrimaryBean =
          LoanCycleParameterPrimaryBean.fromMapData(result[0]);
    } else {
      return null;
    }
    print("Select Query is  " + selectQuery);
    return loanCycleParameterPrimaryBean;

    // }catch(_){

    //   print("SomeException Occured while getting max group size");
    //   return null;
    // }
  }

  Future<CollateralBasicSelectionBean> selectCollateralBasicOnTrefANDMrefno(
      int trefno, String mCreatedBy, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${collateralsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CollateralBasicSelectionBean bean;
    if (result.isEmpty) {
      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${collateralsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralBasicSelectionBean();
        bean = bindDataCollateralBasicListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  CollateralBasicSelectionBean bindDataCollateralBasicListBean(
      Map<String, dynamic> result) {
    return CollateralBasicSelectionBean.fromMap(result);
  }

  Future updateCollateralBasicMasterAfterSync(String query) async {
    print("data from cgt master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${collateralsMaster} SET ${query}");
    });
  }

  Future updateCollateralVehicleWhileBasicCollSyncMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${collateralVehicleMaster} SET ${query}");
    });
  }

  Future updateCollateralREMMasterAfterSync(String query) async {
    print("data from cgt master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn
          .rawQuery("UPDATE ${CollateralREMlandandhouseMaster} SET ${query}");
    });
  }

  Future<List<CollateralBasicSelectionBean>>
  selectCollateralMasterListNotSynced(DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CollateralBasicSelectionBean retBean = new CollateralBasicSelectionBean();
    List<CollateralBasicSelectionBean> n =
    new List<CollateralBasicSelectionBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${collateralsMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${collateralsMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        /*print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }*/
        // print(result[i].runtimeType);
        retBean = bindDataCollateralBasicListBean(result[i]);
        print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future<CollateralVehicleBean> selectCollateralVehicleOnTrefANDMrefno(
      int trefno, String mCreatedBy, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${collateralVehicleMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CollateralVehicleBean bean;
    if (result.isEmpty) {
      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${collateralVehicleMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralVehicleBean();
        bean = bindDataCollateralVehicleListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  CollateralVehicleBean bindDataCollateralVehicleListBean(
      Map<String, dynamic> result) {
    return CollateralVehicleBean.fromMap(result);
  }

  Future updateCollateralVehicleMasterAfterSync(String query) async {
    print("data from cgt master" + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${collateralVehicleMaster} SET ${query}");
    });
  }

  Future<List<CollateralVehicleBean>> selectCollateralVehicleListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CollateralVehicleBean retBean = new CollateralVehicleBean();
    List<CollateralVehicleBean> n = new List<CollateralVehicleBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${collateralVehicleMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${collateralVehicleMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    try {
      for (int i = 0; i < result.length; i++) {
        /*print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }*/
        // print(result[i].runtimeType);
        retBean = bindDataCollateralVehicleListBean(result[i]);
        print("exiting ffrom map");
        n.add(retBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return n;
  }

  Future<List<CollateralREMlandandhouseBean>> selectCollateralREMListNotSynced(
      DateTime lastSyncDateTime) async {
    var db = await _getDb();
    CollateralREMlandandhouseBean retBean = new CollateralREMlandandhouseBean();
    List<CollateralREMlandandhouseBean> n =
    new List<CollateralREMlandandhouseBean>();
    var result;
    //if(future!=null) {

    String selectQueryIsDataSynced = lastSyncDateTime != null &&
        !(lastSyncDateTime == 'null')
        ? 'SELECT * FROM ${CollateralREMlandandhouseMaster}  WHERE  ${TablesColumnFile.mlastupdatedt}  > "$lastSyncDateTime"'
        : 'SELECT * FROM ${CollateralREMlandandhouseMaster}';
    result = await db.rawQuery(selectQueryIsDataSynced);

    // try {
    for (int i = 0; i < result.length; i++) {
      /*print(result[i]);
      for (var items in result[i].toString().split(",")) {
        print(items);
      }*/
      // print(result[i].runtimeType);
      retBean = bindDataCollateralREMListBean(result[i]);
      print("exiting ffrom map");
      n.add(retBean);
    }
    /*} catch (e) {
      print(e.toString());
    }*/
    return n;
  }

  CollateralREMlandandhouseBean bindDataCollateralREMListBean(
      Map<String, dynamic> result) {
    return CollateralREMlandandhouseBean.fromMap(result);
  }

  Future<CollateralREMlandandhouseBean> selectCollateralREMOnTrefANDMrefno(
      int trefno, String mCreatedBy, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CollateralREMlandandhouseMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = ${mrefno}';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CollateralREMlandandhouseBean bean;
    if (result.isEmpty) {
      print("Result Was Empty");
      selectQueryIsDataSynced =
      'SELECT * FROM ${CollateralREMlandandhouseMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}" AND ${TablesColumnFile.mrefno}  = 0 ';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralREMlandandhouseBean();
        bean = bindDataCollateralREMListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future updateCollateralsMaster(
      CollateralBasicSelectionBean collateralBasicSelectionBean) async {
    String insertQuery = "INSERT OR REPLACE INTO ${collateralsMaster}( "
        "${TablesColumnFile.trefno} ,"
        "${TablesColumnFile.mrefno} ,"
        "${TablesColumnFile.loanmrefno} ,"
        "${TablesColumnFile.loantrefno} ,"
        "${TablesColumnFile.mprdacctid} ,"
        "${TablesColumnFile.mcollateralsid} ,"
        "${TablesColumnFile.mleadsid} ,"
        "${TablesColumnFile.msrno} ,"
        "${TablesColumnFile.mcustno}, "
        "${TablesColumnFile.mapplicanttype} ,"
        "${TablesColumnFile.mrelationwithcust} ,"
        "${TablesColumnFile.merrormessage} ,"
        "${TablesColumnFile.mcreateddt} ,"
        "${TablesColumnFile.mcreatedby} ,"
        "${TablesColumnFile.mlastupdatedt} ,"
        "${TablesColumnFile.mlastupdateby} ,"
        "${TablesColumnFile.mgeolocation} ,"
        "${TablesColumnFile.mgeolatd} ,"
        "${TablesColumnFile.mgeologd} ,"
        "${TablesColumnFile.mcollatrlTyp} ,"
        "${TablesColumnFile.mcollatrlcat} ,"
        "${TablesColumnFile.mnametitle} ,"
        "${TablesColumnFile.mfname} , "
        "${TablesColumnFile.mmname} , "
        "${TablesColumnFile.mlname} , "
        "${TablesColumnFile.minsurance} ,"
        "${TablesColumnFile.mcolltrltitle} ,"
        "${TablesColumnFile.misappctprimary} ,"
        "${TablesColumnFile.mislmap} ,"
        "${TablesColumnFile.mnoofattchmnt} ,"
        "${TablesColumnFile.mnameoftitledoc} ,"
        "${TablesColumnFile.mcollbookno} ,"
        "${TablesColumnFile.mcollpageno} ,"
        "${TablesColumnFile.mplaceofuse} ,"
        "${TablesColumnFile.mwithdrawcond} ,"
        "${TablesColumnFile.mlastsynsdate} ,"
        "${TablesColumnFile.isDataSynced} ,"
        "${TablesColumnFile.msubcolltrl} ,"
        "${TablesColumnFile.msubocolltrldesc} ,"
        "${TablesColumnFile.msubcolltrlcat} ,"
        "${TablesColumnFile.msubocolltrlcatdesc} "
        ")"
        "VALUES("
        "${collateralBasicSelectionBean.trefno},"
        "${collateralBasicSelectionBean.mrefno},"
        "${collateralBasicSelectionBean.loanmrefno},"
        "${collateralBasicSelectionBean.loantrefno},"
        "'${collateralBasicSelectionBean.mprdacctid}',"
        "'${collateralBasicSelectionBean.mcollateralsid}',"
        "'${collateralBasicSelectionBean.mleadsid}',"
        "${collateralBasicSelectionBean.msrno},"
        "${collateralBasicSelectionBean.mcustno},"
        "'${collateralBasicSelectionBean.mapplicanttype}',"
        "'${collateralBasicSelectionBean.mrelationwithcust}',"
        "'${collateralBasicSelectionBean.merrormessage}',"
        "'${collateralBasicSelectionBean.mcreateddt}',"
        "'${collateralBasicSelectionBean.mcreatedby}',"
        "'${collateralBasicSelectionBean.mlastupdatedt}',"
        "'${collateralBasicSelectionBean.mlastupdateby}',"
        "'${collateralBasicSelectionBean.mgeolocation}',"
        "'${collateralBasicSelectionBean.mgeolatd}',"
        "'${collateralBasicSelectionBean.mgeologd}',"
        "'${collateralBasicSelectionBean.collatrlTyp}',"
        "'${collateralBasicSelectionBean.collatrlcat}',"
        "'${collateralBasicSelectionBean.nametitle}',"
        "'${collateralBasicSelectionBean.mfname}',"
        "'${collateralBasicSelectionBean.mmname}',"
        "'${collateralBasicSelectionBean.mlname}',"
        "'${collateralBasicSelectionBean.insurance}',"
        "'${collateralBasicSelectionBean.colltrltitle}',"
        "'${collateralBasicSelectionBean.misappctprimary}',"
        "'${collateralBasicSelectionBean.mislmap}',"
        "'${collateralBasicSelectionBean.mnoofattchmnt}',"
        "'${collateralBasicSelectionBean.mnameoftitledoc}',"
        "'${collateralBasicSelectionBean.mcollbookno}',"
        "'${collateralBasicSelectionBean.mcollpageno}',"
        "'${collateralBasicSelectionBean.mplaceofuse}',"
        "'${collateralBasicSelectionBean.mwithdrawcond}',"
        "'${collateralBasicSelectionBean.mlastsynsdate}',"
        "${0},"
        "'${collateralBasicSelectionBean.msubcolltrl}',"
        "'${collateralBasicSelectionBean.msubocolltrldesc}',"
        "'${collateralBasicSelectionBean.msubcolltrlcat}',"
        "'${collateralBasicSelectionBean.msubocolltrlcatdesc}'"
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${gaurantorMaster}");
    });
  }

  Future<int> generateTrefnoForCollaterals() async {
    print("trying to select last row  ${collateralsMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${collateralsMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${collateralsMaster});";
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

  Future<CollateralREMlandandhouseBean>
  selectCollateralREMBeanOnCollateralMTrefAndTrefno(
      int trefno, int mrefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${CollateralREMlandandhouseMaster}   WHERE ${TablesColumnFile.colleteraltrefno}  = $trefno And ${TablesColumnFile.colleteralmrefno}  = $mrefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);

    if (result.length > 0 && result[0] != null) {
    } else {
      selectQueryIsDataSynced =
      'SELECT * FROM ${CollateralREMlandandhouseMaster}   WHERE ${TablesColumnFile.colleteraltrefno}  = $trefno  And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    CollateralREMlandandhouseBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralREMlandandhouseBean();
        bean = bindDataCollateralREMListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  //select collateralVehicleMaster based on Tref
  Future<CollateralVehicleBean>
  selectCollateralVehicleBeanOnCollateralMTrefAndTrefno(
      int trefno, int mrefno, String mCreatedBy) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${collateralVehicleMaster}  WHERE ${TablesColumnFile.colleteraltrefno}  = $trefno And ${TablesColumnFile.colleteralmrefno}  = $mrefno And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    if (result.length > 0 && result[0] != null) {
    } else {
      selectQueryIsDataSynced =
      'SELECT * FROM ${collateralVehicleMaster}   WHERE ${TablesColumnFile.colleteraltrefno}  = $trefno  And ${TablesColumnFile.mcreatedby}  = "${mCreatedBy}"';
      result = await db.rawQuery(selectQueryIsDataSynced);
    }

    CollateralVehicleBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CollateralVehicleBean();
        bean = bindDataCollateralVehicleListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<CustomerLoanDetailsBean> selectCustomerLoanOnTrefAndMrefno(
      int trefno, int mrefno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerLoanDetailsMaster}  WHERE ${TablesColumnFile.trefno}  = $trefno And ${TablesColumnFile.mrefno}  = $mrefno';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    /*print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());*/

    CustomerLoanDetailsBean bean;
    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerLoanDetailsBean();
        bean = bindCustomerLoanDetails(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }

  Future<List<CollateralBasicSelectionBean>> getCollatrlDetailsList(
      int trefno, int mrefno) async {
    var db = await _getDb();
    String seleQuery = "";
    CollateralBasicSelectionBean retBean = new CollateralBasicSelectionBean();
    List<CollateralBasicSelectionBean> collateralBasicSelectionBean =
    new List<CollateralBasicSelectionBean>();
    var result;
    seleQuery = "Select * from ${collateralsMaster} WHERE "
        "${TablesColumnFile.loantrefno + " = " + trefno.toString()}"
        "${mrefno == 0 || mrefno == null ? "" : " AND " + TablesColumnFile.loanmrefno + " = " + mrefno.toString()}; ";

    result = await db.rawQuery(seleQuery);

    for (int i = 0; i < result.length; i++) {
      for (var items in result[i].toString().split(",")) {}
      print(result[i].runtimeType);
      retBean = bindLoanCollatrlDetailsBean(result[i]);
      print("exiting from map");
      collateralBasicSelectionBean.add(retBean);
    }
    return collateralBasicSelectionBean;
  }

  CollateralBasicSelectionBean bindLoanCollatrlDetailsBean(
      Map<String, dynamic> result) {
    return CollateralBasicSelectionBean.fromMap(result);
  }

  Future deleCollateral(String query) async {
    var db = await _getDb();
    print("query" + query);
    await db.transaction((Transaction txn) async {
      await txn.rawDelete("Delete FROM ${query}");
    });
  }

  Future deleData(String query) async {
    var db = await _getDb();
    print("Delete FROM ${query} ");
    await db.transaction((Transaction txn) async {
      await txn.rawDelete("Delete FROM ${query} ");
    });
  }

  Future<int> getMaxCollateralREMlandandhouseTrefNo() async {
    print("trying to select last row  ${CollateralREMlandandhouseMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${CollateralREMlandandhouseMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${CollateralREMlandandhouseMaster});";
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

  Future _createCollateralsMaster(Database db) {
    String query = "CREATE TABLE ${collateralsMaster} ("
        "${TablesColumnFile.trefno} INTEGER,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.loanmrefno} INTEGER,"
        "${TablesColumnFile.loantrefno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT,"
        "${TablesColumnFile.mcollateralsid} TEXT,"
        "${TablesColumnFile.mleadsid} TEXT,"
        "${TablesColumnFile.msrno} INTEGER,"
        "${TablesColumnFile.mcustno} INTEGER,"
        "${TablesColumnFile.mapplicanttype} TEXT,"
        "${TablesColumnFile.mrelationwithcust} TEXT,"
        "${TablesColumnFile.merrormessage} TEXT,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT,"
        "${TablesColumnFile.mgeolocation} TEXT,"
        "${TablesColumnFile.mgeolatd} TEXT,"
        "${TablesColumnFile.mgeologd} TEXT,"
        "${TablesColumnFile.mcollatrlTyp} TEXT,"
        "${TablesColumnFile.mcollatrlcat} TEXT,"
        "${TablesColumnFile.mnametitle} TEXT,"
        "${TablesColumnFile.mfname} TEXT, "
        "${TablesColumnFile.mmname} TEXT, "
        "${TablesColumnFile.mlname} TEXT, "
        "${TablesColumnFile.minsurance} TEXT,"
        "${TablesColumnFile.mcolltrltitle} TEXT,"
        "${TablesColumnFile.mnameoftitledoc} TEXT,"
        "${TablesColumnFile.mcollbookno} TEXT,"
        "${TablesColumnFile.mcollpageno} TEXT,"
        "${TablesColumnFile.mplaceofuse} TEXT,"
        "${TablesColumnFile.mwithdrawcond} TEXT,"
        "${TablesColumnFile.misappctprimary} TEXT,"
        "${TablesColumnFile.mislmap} TEXT,"
        "${TablesColumnFile.mnoofattchmnt} TEXT,"
        "${TablesColumnFile.msubcolltrl} TEXT,"
        "${TablesColumnFile.msubocolltrldesc} TEXT,"
        "${TablesColumnFile.msubcolltrlcat} TEXT,"
        "${TablesColumnFile.msubocolltrlcatdesc} TEXT,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        "${TablesColumnFile.isDataSynced} INTEGER DEFAULT 0, "
        "PRIMARY KEY (${TablesColumnFile.mrefno}, ${TablesColumnFile.trefno}))";
    print("primary of gaurantor table");
    print(query.toString());

    return db.transaction((Transaction txn) {
      txn.execute(query);
    });
  }

  Future createCollateralREMlandandhouseMasterTable(Database db) {
    print(
        "xxxxxxxxxxxxxxxxxxx123456 ${CollateralREMlandandhouseMaster} table Query Here is : ");
    String query = "CREATE TABLE ${CollateralREMlandandhouseMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER ,"
        "${TablesColumnFile.loantrefno} INTEGER ,"
        "${TablesColumnFile.loanmrefno} INTEGER,"
        "${TablesColumnFile.colleteraltrefno} INTEGER,"
        "${TablesColumnFile.colleteralmrefno} INTEGER,"
        "${TablesColumnFile.mprdacctid} TEXT ,"
        "${TablesColumnFile.mtitle} TEXT ,"
        "${TablesColumnFile.mfname} TEXT ,"
        "${TablesColumnFile.mmname} TEXT ,"
        "${TablesColumnFile.mlname} TEXT ,"
        "${TablesColumnFile.maddress1} TEXT ,"
        "${TablesColumnFile.maddress2} TEXT ,"
        "${TablesColumnFile.mcountry} TEXT ,"
        "${TablesColumnFile.mstate} TEXT ,"
        "${TablesColumnFile.mdist} TEXT ,"
        "${TablesColumnFile.msubdist} TEXT ,"
        "${TablesColumnFile.marea} TEXT ,"
        "${TablesColumnFile.mhousebuilttype} TEXT ,"
        "${TablesColumnFile.menvdescription} TEXT ,"
        "${TablesColumnFile.mlotarea} REAL ,"
        "${TablesColumnFile.mfloorarea} REAL ,"
        "${TablesColumnFile.mdescofproperty} TEXT ,"
        "${TablesColumnFile.msizeofproperty} TEXT ,"
        "${TablesColumnFile.msizeofpropertyl} TEXT ,"
        "${TablesColumnFile.msizeofpropertyh} TEXT ,"
        "${TablesColumnFile.mtctno} INTEGER ,"
        "${TablesColumnFile.msrno} INTEGER ,"
        "${TablesColumnFile.mregdate} DATETIME ,"
        "${TablesColumnFile.mepebdate} DATETIME ,"
        "${TablesColumnFile.mrescodeorremark} TEXT ,"
        "${TablesColumnFile.mepebno} INTEGER ,"
        "${TablesColumnFile.mregofdeedslocation} TEXT ,"
        "${TablesColumnFile.mcreateddt} DATETIME ,"
        "${TablesColumnFile.mcreatedby} TEXT ,"
        "${TablesColumnFile.mlastupdatedt} DATETIME ,"
        "${TablesColumnFile.mlastupdateby} TEXT ,"
        "${TablesColumnFile.mgeolocation} TEXT ,"
        "${TablesColumnFile.mgeolatd} TEXT ,"
        "${TablesColumnFile.mgeologd} TEXT ,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.merrormessage} TEXT ,"
        "${TablesColumnFile.mcollno} INTEGER ,"
        "${TablesColumnFile.mpriorsec} TEXT ,"
        "${TablesColumnFile.mcolltype} TEXT ,"
        "${TablesColumnFile.mcollsubtype} TEXT ,"
        "${TablesColumnFile.mtypeofproperty} TEXT ,"
        "${TablesColumnFile.mltypeofownercerti} TEXT ,"
        "${TablesColumnFile.mhtypeofownercerti} TEXT ,"
        "${TablesColumnFile.mlissuednoprop} TEXT ,"
        "${TablesColumnFile.mhissuednoprop} TEXT ,"
        "${TablesColumnFile.mlissueby} TEXT ,"
        "${TablesColumnFile.mhissueby} TEXT ,"
        "${TablesColumnFile.mlsizeprop} TEXT ,"
        "${TablesColumnFile.mhsizeprop} TEXT ,"
        "${TablesColumnFile.mlnpropborder} TEXT ,"
        "${TablesColumnFile.mhnpropborder} TEXT ,"
        "${TablesColumnFile.mlspropborder} TEXT ,"
        "${TablesColumnFile.mhspropborder} TEXT ,"
        "${TablesColumnFile.mlwpropborder} TEXT ,"
        "${TablesColumnFile.mhwpropborder} TEXT ,"
        "${TablesColumnFile.mlepropborder} TEXT ,"
        "${TablesColumnFile.mhepropborder} TEXT ,"
        "${TablesColumnFile.mllocprop} TEXT ,"
        "${TablesColumnFile.mhlocprop} TEXT ,"
        "${TablesColumnFile.mltitleowener} TEXT ,"
        "${TablesColumnFile.mhtitleowener} TEXT ,"
        "${TablesColumnFile.mllocalauthvalue} REAL ,"
        "${TablesColumnFile.mhlocalauthvalue} REAL ,"
        "${TablesColumnFile.mlrealestatecmpnyvalue} REAL ,"
        "${TablesColumnFile.mhrealestatecmpnyvalue} REAL ,"
        "${TablesColumnFile.mlaskneighonvalue} REAL ,"
        "${TablesColumnFile.mhaskneighonvalue} REAL ,"
        "${TablesColumnFile.mlsumonvalprop} REAL ,"
        "${TablesColumnFile.mhsumonvalprop} REAL ,"
        "${TablesColumnFile.mlissuedt} DATETIME ,"
        "${TablesColumnFile.mhissuedt} DATETIME ,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno}) "
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx123456 ${CollateralREMlandandhouseMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future createCollateralVehicleMasterTable(Database db) {
    String query = "CREATE TABLE ${collateralVehicleMaster} ("
        "${TablesColumnFile.msrno} INTEGER ,"
        "${TablesColumnFile.mlbrcode} INTEGER ,"
        "${TablesColumnFile.mprdacctid} TEXT ,"
        "${TablesColumnFile.msectype} TEXT ,"
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER,"
        "${TablesColumnFile.loantrefno} INTEGER ,"
        "${TablesColumnFile.loanmrefno} INTEGER,"
        "${TablesColumnFile.colleteraltrefno} INTEGER,"
        "${TablesColumnFile.colleteralmrefno} INTEGER,"
        "${TablesColumnFile.mbusinessname} TEXT ,"
        "${TablesColumnFile.mownername} TEXT ,"
        "${TablesColumnFile.mtel} TEXT ,"
        "${TablesColumnFile.maddress1} TEXT ,"
        "${TablesColumnFile.maddress2} TEXT ,"
        "${TablesColumnFile.mcountry} TEXT ,"
        "${TablesColumnFile.mstate} TEXT ,"
        "${TablesColumnFile.mdist} TEXT ,"
        "${TablesColumnFile.msubdist} TEXT ,"
        "${TablesColumnFile.marea} TEXT ,"
        "${TablesColumnFile.mvillage} TEXT ,"
        "${TablesColumnFile.mbrand} TEXT ,"
        "${TablesColumnFile.mnoofaxles} INTEGER ,"
        "${TablesColumnFile.mtype} TEXT ,"
        "${TablesColumnFile.mnoofcylinder} INTEGER ,"
        "${TablesColumnFile.mcolor} TEXT ,"
        "${TablesColumnFile.msizeofcylinder} INTEGER ,"
        "${TablesColumnFile.mbodyno} TEXT ,"
        "${TablesColumnFile.menginepower} REAL ,"
        "${TablesColumnFile.mengineno} TEXT ,"
        "${TablesColumnFile.myearmade} INTEGER ,"
        "${TablesColumnFile.mchassisno} TEXT ,"
        "${TablesColumnFile.mmadeby} TEXT ,"
        "${TablesColumnFile.midentitycarno} TEXT ,"
        "${TablesColumnFile.mcarpricing} REAL ,"
        "${TablesColumnFile.mstdpricing} REAL ,"
        "${TablesColumnFile.minsurancepricing} REAL ,"
        "${TablesColumnFile.mpriceafterevaluation} REAL ,"
        "${TablesColumnFile.mltv} REAL ,"
        "${TablesColumnFile.mcartype} TEXT ,"
        "${TablesColumnFile.mltvdd} TEXT ,"
        "${TablesColumnFile.mloantovalueltv} TEXT ,"
        "${TablesColumnFile.mwhobelongocarowner} TEXT ,"
        "${TablesColumnFile.mcarlegality} INTEGER ,"
        "${TablesColumnFile.mreason} TEXT ,"
        "${TablesColumnFile.mdescription} TEXT ,"
        "${TablesColumnFile.mcarcanbeused} TEXT,"
        "${TablesColumnFile.mcredittenor} TEXT,"
        "${TablesColumnFile.mdmirror} TEXT ,"
        "${TablesColumnFile.mddoor} TEXT ,"
        "${TablesColumnFile.mdmirrorbacklock} TEXT ,"
        "${TablesColumnFile.mdcolororspot} TEXT ,"
        "${TablesColumnFile.mfcolorandspot} TEXT ,"
        "${TablesColumnFile.mftireandyan} TEXT ,"
        "${TablesColumnFile.mfcapofsplatter} TEXT ,"
        "${TablesColumnFile.mhmirror} TEXT ,"
        "${TablesColumnFile.mhvent} TEXT ,"
        "${TablesColumnFile.mhlightfarl} TEXT ,"
        "${TablesColumnFile.mhlightfarr} TEXT ,"
        "${TablesColumnFile.mhsignal} TEXT ,"
        "${TablesColumnFile.mhwincap} TEXT ,"
        "${TablesColumnFile.mpmirror} TEXT ,"
        "${TablesColumnFile.mpdoor} TEXT ,"
        "${TablesColumnFile.mpbackmirror} TEXT ,"
        "${TablesColumnFile.mpcolororspot} TEXT ,"
        "${TablesColumnFile.mftcolorandspot} TEXT ,"
        "${TablesColumnFile.mfttanandyan} TEXT ,"
        "${TablesColumnFile.mftcap} TEXT ,"
        "${TablesColumnFile.mftsplattercap} TEXT ,"
        "${TablesColumnFile.mbpmirror} TEXT ,"
        "${TablesColumnFile.mbpdoor} TEXT ,"
        "${TablesColumnFile.mbpcolorandspot} TEXT ,"
        "${TablesColumnFile.mbtcolorandsport} TEXT ,"
        "${TablesColumnFile.mbttanandyan} TEXT ,"
        "${TablesColumnFile.mbtcap} TEXT ,"
        "${TablesColumnFile.mbcbacklightr} TEXT ,"
        "${TablesColumnFile.mbcturnsignal} TEXT ,"
        "${TablesColumnFile.mbcmessagesignal} TEXT ,"
        "${TablesColumnFile.mbcsignal} TEXT ,"
        "${TablesColumnFile.mbcbacklightl} TEXT ,"
        "${TablesColumnFile.mbcbackdoor} TEXT ,"
        "${TablesColumnFile.mbccranes} TEXT ,"
        "${TablesColumnFile.mbctakelock} TEXT ,"
        "${TablesColumnFile.mbcholdlock} TEXT ,"
        "${TablesColumnFile.mbchandcranes} TEXT ,"
        "${TablesColumnFile.mbcreservetire} TEXT,"
        "${TablesColumnFile.mbcbackmirror} TEXT ,"
        "${TablesColumnFile.mbcantenna} TEXT ,"
        "${TablesColumnFile.mbtlcolororspot} TEXT ,"
        "${TablesColumnFile.mbtltanandyan} TEXT ,"
        "${TablesColumnFile.mbtlcap} TEXT ,"
        "${TablesColumnFile.mhheadcap} TEXT ,"
        "${TablesColumnFile.mbtlsplattercap} TEXT ,"
        "${TablesColumnFile.mbtrcolororspot} TEXT ,"
        "${TablesColumnFile.mbtrtireandyan} TEXT ,"
        "${TablesColumnFile.mbtrcap} TEXT ,"
        "${TablesColumnFile.mbtrsplattercap} TEXT ,"
        "${TablesColumnFile.mibarsun} TEXT ,"
        "${TablesColumnFile.midescriptionbook} TEXT ,"
        "${TablesColumnFile.miautosystem} TEXT ,"
        "${TablesColumnFile.miairconditioner} TEXT ,"
        "${TablesColumnFile.mimirrorremote} TEXT ,"
        "${TablesColumnFile.misafebell} TEXT ,"
        "${TablesColumnFile.mimiddlebox} TEXT ,"
        "${TablesColumnFile.mregdate} DATETIME,"
        "${TablesColumnFile.mregexpdate} DATETIME,"
        "${TablesColumnFile.mcreateddt} DATETIME,"
        "${TablesColumnFile.mcreatedby} TEXT  ,"
        "${TablesColumnFile.mlastupdatedt} DATETIME,"
        "${TablesColumnFile.mlastupdateby} TEXT  ,"
        "${TablesColumnFile.mgeolocation} TEXT ,"
        "${TablesColumnFile.mgeolatd} TEXT ,"
        "${TablesColumnFile.missynctocoresys} INTEGER ,"
        "${TablesColumnFile.mgeologd} TEXT ,"
        "${TablesColumnFile.mlastsynsdate} DATETIME,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno})"
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx ${collateralVehicleMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }


  Future createInternalBankTransfer(Database db) {
    String query = "CREATE TABLE ${internalBankTransferMaster} ("
        "${TablesColumnFile.trefno} INTEGER ,"
        "${TablesColumnFile.mrefno} INTEGER ,"
        "${TablesColumnFile.mcashtr} INTEGER ,"
        "${TablesColumnFile.mcrdr} TEXT ,"
        "${TablesColumnFile.mremark} TEXT ,"
        "${TablesColumnFile.mnarration} TEXT ,"
        "${TablesColumnFile.mamt} REAL ,"
        "${TablesColumnFile.maccid} TEXT ,"
        "${TablesColumnFile.mdraccid} TEXT ,"
        "${TablesColumnFile.mcraccid} TEXT ,"
        "${TablesColumnFile.mlbrcode} INTEGER ,"
        "${TablesColumnFile.mcreateddt} DATETIME ,"
        "${TablesColumnFile.mcreatedby} TEXT ,"
        "${TablesColumnFile.mlastupdatedt} DATETIME ,"
        "${TablesColumnFile.mlastupdateby} TEXT ,"
        "${TablesColumnFile.mgeolocation} TEXT ,"
        "${TablesColumnFile.mgeolatd} TEXT ,"
        "${TablesColumnFile.mgeologd} TEXT ,"
        "${TablesColumnFile.mlastsynsdate} DATETIME ,"
        "${TablesColumnFile.merrormessage} TEXT ,"
        "${TablesColumnFile.missynctocoresys} INTEGER ,"
        "${TablesColumnFile.moperationdate} DATETIME ,"
        "${TablesColumnFile.mlongname} TEXT ,"
        " PRIMARY KEY (${TablesColumnFile.trefno}, ${TablesColumnFile.mrefno}) "
        ");";

    print(
        "xxxxxxxxxxxxxxxxxxx123456 ${internalBankTransferMaster} table Query Here is : " +
            query);
    return db.transaction((Transaction txn) async {
      txn.execute(query);
    });
  }

  Future<LoginBean> getLoginDataOnFingerPrint() async {
    var db = await _getDb();

    LoginBean retBean =new LoginBean();
    print('query is here : ' +
        'SELECT *FROM   $userMasterTable ');
    var result = await db.rawQuery(
        'SELECT *  FROM $userMasterTable ');
    if (result[0] != null) {
      print(" yes login ofline " + result[0].toString());
      retBean = bindDataLoginBEan(result);
      //  retBean = bindDataLoginBEan(result);
    }
    return retBean;
  }


  Future<CustomerListBean> selectCustomerOnCustNo(int mcustno) async {
    String selectQueryIsDataSynced =
        'SELECT * FROM ${customerFoundationMasterDetails}  WHERE ${TablesColumnFile.mcustno}  = $mcustno ';

    var db = await _getDb();
    var result = await db.rawQuery(selectQueryIsDataSynced);
    print(selectQueryIsDataSynced.toString() +
        " and select que " +
        result.toString());

    CustomerListBean bean;

    try {
      for (int i = 0; i < result.length; i++) {
        bean = new CustomerListBean();
        bean = bindDataCustomerListBean(result[i]);
      }
    } catch (error, stackTrace) {
      print(error.toString());
      print(stackTrace);
    }
    return bean;
  }


  Future<GuarantorDetailsBean> findByMnationalId(DateTime mdob, String nationalId, int type) async{
    String selectQuery ="";
    if(type ==1 ){
      selectQuery =  'SELECT * FROM  ${gaurantorMaster} WHERE mdob = ${mdob} AND  substring(mpannodesc,len(mpannodesc)-5,6)= ${nationalId} ';
    }
    else{
      selectQuery =   "SELECT * FROM  ${gaurantorMaster} where mpannodesc=${nationalId}";
    }

    GuarantorDetailsBean retBean;
    var db = await _getDb();
    var result = await db.rawQuery(selectQuery);
    for (int i = 0; i < result.length; i++) {
      print(result[i].runtimeType);
      retBean = bindLoanGuarantorDetailsBean(result[i]);
    }
    return retBean;
  }


  Future<int> generateTrefnoUserActivityMaster() async {
    print("trying to select last row  ${UserActivityMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${UserActivityMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${UserActivityMaster});";
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

  Future updateUserVaultBalance(int lbrCd, String  usrCd, String curCd, String diffInAmt) async {
    var db = await _getDb();
    String updateQuery;
    updateQuery="UPDATE ${userVaultBalance} SET ${TablesColumnFile.mbalance} ="
        "((SELECT ${TablesColumnFile.mbalance} FROM  ${UserActivityMaster} WHERE  ${TablesColumnFile.mlbrcode} = ${lbrCd} "
        "AND ${TablesColumnFile.musercode} = '${usrCd}' AND ${TablesColumnFile.mcurcd} = '${curCd}')${diffInAmt})"
        "WHERE  ${TablesColumnFile.mlbrcode} = ${lbrCd} AND ${TablesColumnFile.musercode} = '${usrCd}'"
        "AND ${TablesColumnFile.mcurcd} = '${curCd}'";

    print(updateQuery);
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(updateQuery);
    });
  }


  Future updateCollectionMaster(String query) async {
    print("data " + query.toString());
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("UPDATE ${collectedLoansAmtMaster} SET ${query}");
    });
  }

  Future deleteFromCollectedMaster(DateTime operationDate) async {
    print("Delete krne ki operation Date hai  " + operationDate.toString());
    var db = await _getDb();

    print("Query is DELETE  from ${collectedLoansAmtMaster} WHERE ${TablesColumnFile.mlastopendate} < '${operationDate}' ");
    await db.transaction((Transaction txn) async {
      await txn.rawQuery("DELETE  from ${collectedLoansAmtMaster} WHERE ${TablesColumnFile.mlastopendate} < '${operationDate}' ");
    });
  }

  Future<int> getMaxTrefNoCollection() async {
    print("trying to select last row  ${creditBereauMaster}");
    String insertQuery = "SELECT *"
        "FROM    ${collectedLoansAmtMaster}"
        " WHERE   ${TablesColumnFile.trefno} = (SELECT MAX(${TablesColumnFile.trefno})  FROM ${collectedLoansAmtMaster});";
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

  Future<Null> deleAddDetails(int mrefno,int trefno) async {

    String insertQuery = "DELETE FROM ${customerFoundationAddressMasterDetails} WHERE ${TablesColumnFile.mrefno} = ${mrefno} "
        " AND ${TablesColumnFile.trefno} = ${trefno} ";
    print(insertQuery);

    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      await txn.rawQuery(insertQuery);
    });
    return;
  }

  Future<Null> updateUserActivity(String updateQuery) async {
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(updateQuery);
      print(updateQuery.toString() +
          " insertQuery after insert in ${UserActivityMaster}");
    });
  }


  Future updateInternalTransactionMaster(InternalBankTransferBean  internalTransaction ) async {
    print("trying to insert or replace ${internalBankTransferMaster}");
    String insertQuery = "INSERT OR REPLACE INTO ${internalBankTransferMaster}( "
        "${TablesColumnFile.trefno}   ,"
        "${TablesColumnFile.mrefno}   ,"
        "${TablesColumnFile.mcashtr}   ,"
        "${TablesColumnFile.mcrdr}  ,"
        "${TablesColumnFile.mremark}  ,"
        "${TablesColumnFile.mnarration}  ,"
        "${TablesColumnFile.mamt}   ,"
        "${TablesColumnFile.maccid}  ,"
        "${TablesColumnFile.mdraccid}  ,"
        "${TablesColumnFile.mcraccid}  ,"
        "${TablesColumnFile.merrormessage}  ,"
        "${TablesColumnFile.mlbrcode}   ,"
        "${TablesColumnFile.mcreateddt}   ,"
        "${TablesColumnFile.mcreatedby}  ,"
        "${TablesColumnFile.mlastupdatedt}   ,"
        "${TablesColumnFile.mlastupdateby}  ,"
        "${TablesColumnFile.mgeolocation}  ,"
        "${TablesColumnFile.mgeolatd}  ,"
        "${TablesColumnFile.mgeologd}  ,"
        "${TablesColumnFile.mlastsynsdate}   ,"
         "${TablesColumnFile.missynctocoresys} ,    "
        "${TablesColumnFile.moperationdate} ,  "
        "${TablesColumnFile.mlongname}   "
        ")"
        "VALUES("
        "${internalTransaction.trefno} ,"
        "${internalTransaction.mrefno}  ,"
        " ${internalTransaction.mcashtr}  ,"
        "'${internalTransaction.mcrdr}'  ,"
        "'${internalTransaction.mremark}'  ,"
        "'${internalTransaction.mnarration}'  ,"
        "${internalTransaction.mamt} ,"
        "'${internalTransaction.maccid}'  ,"
        "'${internalTransaction.mdraccid}'  ,"
        "'${internalTransaction.mcraccid}' ,"
        "'${internalTransaction.merrormessage}'  ,"
        "${internalTransaction.mlbrcode} ,"
        "'${internalTransaction.mcreateddt}'  ,"
        "'${internalTransaction.mcreatedby}'  ,"
        "'${internalTransaction.mlastupdatedt}'  ,"
        "'${internalTransaction.mlastupdateby}'  ,"
        "'${internalTransaction.mgeolocation}'  ,"
        "'${internalTransaction.mgeolatd}'  ,"
        "'${internalTransaction.mgeologd}'  ,"
        "'${internalTransaction.mlastsynsdate}'  ,"
         "${internalTransaction.missynctocoresys} , "
        "'${internalTransaction.moperationdate}', "
        "'${internalTransaction.mlongname}' "
        ");";
    print("insert query is" + insertQuery);
    var db = await _getDb();
    await db.transaction((Transaction txn) async {
      int id = await txn.rawInsert(insertQuery);
      print(id.toString() + " id after insert in ${UserRightsTable}");
    });
  }




  Future<List<InternalBankTransferBean>>  getInternalTransactionList(String pageType , String transactionType , DateTime operationDate) async {
    InternalBankTransferBean disBean = new InternalBankTransferBean();
    List<InternalBankTransferBean> retBeanList =
    new List<InternalBankTransferBean>();
    String query = "";


    if(pageType == "statusList"){
      query =
      "SELECT y.${TablesColumnFile.mcraccid},x.${TablesColumnFile.mlongname} AS ${TablesColumnFile.mcraccidname} , y.${TablesColumnFile.mdraccid}, "
          " z.${TablesColumnFile.mlongname} AS ${TablesColumnFile.mdraccidname},y.${TablesColumnFile.maccid} ,"
          " y.${TablesColumnFile.mrefno}, y.${TablesColumnFile.mcreatedby}, y.${TablesColumnFile.mcreateddt}, y.${TablesColumnFile.mgeolatd}, "
          "y.${TablesColumnFile.mgeolocation}, y.${TablesColumnFile.mgeologd}, y.${TablesColumnFile.missynctocoresys}, y.${TablesColumnFile.mlastsynsdate}, "
          "y.${TablesColumnFile.mlastupdateby}, y.${TablesColumnFile.mlastupdatedt}, y.${TablesColumnFile.mamt}, y.${TablesColumnFile.mcashtr}, "
          "y.${TablesColumnFile.mcrdr}, y.${TablesColumnFile.merrormessage},  y.${TablesColumnFile.mlbrcode}, "
          "y.${TablesColumnFile.mnarration}, y.${TablesColumnFile.mremark},  y.${TablesColumnFile.trefno} "
          "FROM ${AppDatabase.internalBankTransferMaster} y , ${AppDatabase.glAccountMaster} x, ${AppDatabase.glAccountMaster} z "
          "WHERE (y.${TablesColumnFile.mcashtr} =2  AND y.${TablesColumnFile.mcraccid} = x.${TablesColumnFile.mprdacctid} AND y.${TablesColumnFile.mdraccid} = z.${TablesColumnFile.mprdacctid}) "
          "OR ( ${TablesColumnFile.mcashtr} =1 AND y.${TablesColumnFile.maccid} = x.${TablesColumnFile.mprdacctid} AND y.${TablesColumnFile.maccid} = z.${TablesColumnFile.mprdacctid} ) "
          " ORDER BY ${TablesColumnFile.mcreateddt} DESC ";

    }else{


      query =
      "SELECT y.${TablesColumnFile.mcraccid},x.${TablesColumnFile.mlongname} AS ${TablesColumnFile.mcraccidname} , y.${TablesColumnFile.mdraccid}, "
          " z.${TablesColumnFile.mlongname} AS ${TablesColumnFile.mdraccidname},y.${TablesColumnFile.maccid} ,"
          " y.${TablesColumnFile.mrefno}, y.${TablesColumnFile.mcreatedby}, y.${TablesColumnFile.mcreateddt}, y.${TablesColumnFile.mgeolatd}, "
          "y.${TablesColumnFile.mgeolocation}, y.${TablesColumnFile.mgeologd}, y.${TablesColumnFile.missynctocoresys}, y.${TablesColumnFile.mlastsynsdate}, "
          "y.${TablesColumnFile.mlastupdateby}, y.${TablesColumnFile.mlastupdatedt}, y.${TablesColumnFile.mamt}, y.${TablesColumnFile.mcashtr}, "
          "y.${TablesColumnFile.mcrdr}, y.${TablesColumnFile.merrormessage},  y.${TablesColumnFile.mlbrcode}, "
          "y.${TablesColumnFile.mnarration}, y.${TablesColumnFile.mremark},  y.${TablesColumnFile.trefno} "
          "FROM ${AppDatabase.internalBankTransferMaster} y , ${AppDatabase.glAccountMaster} x, ${AppDatabase.glAccountMaster} z "
          "WHERE ((y.${TablesColumnFile.mcashtr} =2  AND y.${TablesColumnFile.mcraccid} = x.${TablesColumnFile.mprdacctid} AND y.${TablesColumnFile.mdraccid} = z.${TablesColumnFile.mprdacctid}) "
          "OR ( ${TablesColumnFile.mcashtr} =1 AND y.${TablesColumnFile.maccid} = x.${TablesColumnFile.mprdacctid} AND y.${TablesColumnFile.maccid} = z.${TablesColumnFile.mprdacctid} ) )"
          " AND y.${TablesColumnFile.mcrdr}  = '${transactionType}' AND y.${TablesColumnFile.mcashtr}  = 1 AND  y.${TablesColumnFile.moperationdate} = '$operationDate' "
          " ORDER BY ${TablesColumnFile.mcreateddt} DESC";




    }


    print(query);

    var result;
    var db = await _getDb();
    result = await db.rawQuery(query);
    try {
      for (int i = 0; i < result.length; i++) {
        print(result[i].runtimeType);
        disBean = bindInternalBankTransferDetails(result[i]);
        print("exiting from map");
        retBeanList.add(disBean);
      }
    } catch (e) {
      print(e.toString());
    }
    return retBeanList;
  }




  InternalBankTransferBean bindInternalBankTransferDetails(
      Map<String, dynamic> result) {
    return InternalBankTransferBean.fromMap(result);
  }
}
