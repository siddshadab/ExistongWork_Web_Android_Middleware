import 'dart:convert';
import 'dart:ui';
import 'dart:ui';
import 'package:eco_mfi/Utilities/networt_util.dart';
import 'package:eco_mfi/db/AppdatabaseExtended.dart';
import 'package:eco_mfi/pages/reports/ConfiguredRreportsBean.dart';
import 'package:eco_mfi/pages/timelines/ChartsBean.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/Utils/model.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/cartesian_charts/bar_series/default_bar_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/circular_charts/pie_series/default_pie_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/circular_charts/pie_series/pie_with_grouping.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_column_chart.dart';
import 'package:eco_mfi/pages/timelines/DashBoardNewArchitect/chart/default_line_chart.dart';
import 'package:eco_mfi/pages/todo/home/ColourPalleteGenerater.dart';
import 'package:eco_mfi/pages/workflow/Kyc/KycMaster.dart';
import 'package:eco_mfi/pages/workflow/Collateral/Collateral/AddCollaterals.dart';
import 'package:eco_mfi/pages/workflow/Collateral/Collateral/CollateralList.dart';
import 'package:eco_mfi/pages/workflow/Kyc/KycMaster.dart';
import 'package:eco_mfi/MenuAndRights/MenuMasterBean.dart';
import 'package:eco_mfi/pages/workflow/Guarantor/GuarantorDetails.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanCPVBusinessRecord.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/CustomerLoanCashFlow.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/List/CustomerLoanDetailsList.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCPVBusinessRecordBean.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanCashFlowAnalysisBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/DeviationForm.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/SocialAndEnvironmental.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/TradeAndNeighbourRefCheck.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/DeviationFormBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/SocialAndEnvironmentalBean.dart';
import 'package:eco_mfi/pages/workflow/LoanDataCapture/bean/TradeAndNeighbourRefCheckBean.dart';
import 'package:eco_mfi/pages/workflow/customerFormation/ContactPointVerification.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/LoanLevelService.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingMenusMaster.dart';
import 'package:eco_mfi/pages/workflow/syncingActivity/SyncingUSerAccessRights.dart';
import 'package:flutter/services.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/Utilities/SessionTimeOut.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_version/get_version.dart';
import 'package:eco_mfi/db/AppDatabase.dart';
import 'package:eco_mfi/db/TablesColumnFile.dart';
import 'package:eco_mfi/main.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT1Bean.dart';
import 'package:eco_mfi/pages/workflow/CGT/bean/CheckListCGT2Bean.dart';
import 'package:eco_mfi/pages/workflow/GRT/bean/CheckListGRTBean.dart';
import 'package:eco_mfi/pages/workflow/LookupMasterBean.dart';
import 'package:eco_mfi/pages/workflow/SystemParameter/SystemParameterBean.dart';
import 'package:eco_mfi/pages/workflow/creditBereau/Bean/SettingsBean.dart';
import 'package:intl/intl.dart';
import 'package:permission/permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;
import 'package:eco_mfi/MenuAndRights/UserRightsBean.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:eco_mfi/pages/workflow/LoanApplication/bean/CustomerLoanDetailsBean.dart';
import 'package:eco_mfi/Utilities/globals.dart' as globals;

const double PADDING_TINY = 2.0;
const double PADDING_VERY_SMALL = 4.0;
const double PADDING_SMALL = 8.0;
const double PADDING_MEDIUM = 16.0;
const double PADDING_LARGE = 24.0;
const double PADDING_VERY_LARGE = 32.0;

const double FONT_VERY_SMALL = 4.0;
const double FONT_SMALL = 8.0;
const double FONT_MEDIUM = 16.0;
const double FONT_LARGE = 24.0;
const double FONT_VERY_LARGE = 32.0;

//For Task Row
const double FONT_SIZE_TITLE = 16.0;
const double FONT_SIZE_LABEL = 14.0;
const double FONT_SIZE_DATE = 12.0;

const String TWITTER_URL = " ";
const String FACEBOOK_URL = " ";
const String GITHUB_URL = " ";
const String PROJECT_URL = " ";
const String ISSUE_URL = " ";
const String README_URL = " ";
const String EMAIL_URL = " ";
const String captionValue = "Purpose of loan";
//loan COllection

/*const String BRANCH = "डाली";
const String ISINDIVIDUAL = "IBL";
const String LOANOFFICER = "ऋण अधिकारी";
const String CENTERID = "केंद्र आईडी";
const String GROUPID = "समूह आईडी";
const String CUSTOMERNUMBER = "ग्राहक संख्या";
const String PRODUCTS = "उत्पाद";*/
const String BRANCH = "Branch";
const String ISINDIVIDUAL = "IBL";
const String LOANOFFICER = "Loan Officer";
const String CENTERID = "Center Id";
const String GROUPID = "Group Id";
const String CUSTOMERNUMBER = "Customer Number";
const String PRODUCTS = "Product";
const String fromDate = "From Date";
const String toDate = "To Date";
const String PAGESCOUNT = "Page Count Of Collection";
const String ENTERPAGESCOUNT = "Enter Page Count Of Collection";

//Credit BereauCallSubmission
//lebelText
const String trefNo = "Reference No";
const String queueNo = "Queue No";
const String scanUIDQRHere = "Scan UID QR here";
const String scannedUIDQRName = "Applicant Name";
const String scanUIDQRHouse = "Applicant House No";
const String scanUIDQstreet = "Applicant Street";
const String scannedUIDCity = "Applicant City";
const String scannedUIDState = "ApplicantState";
const String scannedUIDPincode = "Applicant Pincode";
const String selectDOB = "Select DOB";
const String contactNo = "Contact No";
const String enterOTP = "Enter OTP";
const String enterSpouseNameHere = "Enter Spouse Name Here";
const String enterNomineeHere = "Enter Nominee Here";
const String enterBranchId = "Enter Branch Id";
const String enterMemberId = "Enter Member Id";
const String enterApplicantID2Here = "Enter Applicant ID 2 here";
const String enterCreditRequestTypeHere = "Enter Credit Request Type Here";
const String creditReportTransactionIDHere =
    "Credit Report Transaction ID Here";
const String creditInquiryPurposeTypeHere = "Credit Inquiry Purpose Type Here";
const String creditInquiryStageHere = "credit Inquiry Stage Here";
const String creditReportTransactionDateTypeHere =
    "Credit Report Transaction Date Type Here";
//hintText
const String htrefNo = "Enter Tref Here ";
const String scanUIDQR = "Scan UID QR";
const String applicantName = "Applicant Name";
const String houseNumber = "Applicant House No";
const String street = "Applicant Street";
const String applicantCity = "Applicant City";
const String applicantState = "Applicant State";
const String applicantPincode = "Applicant Pincode";
const String dateOfBirth = "Date Of Birth";
const String OTP1 = "OTP";
const String spouseName = "Spouse Name";
const String nomineeName = "Nominee Name";
const String nomineeRelation = "Nominee Relationship";

const String branchId = "Branch Id";
const String memberId = "Member Id";
const String applicantID2 = "Applicant ID 2";

//passwordChange

const String userCode = "userCode";

//HighMark
const String creditRequestType = "Credit Request Type";
const String creditReportTransactionID = "Credit Report Transaction ID";
const String creditInquiryPurposeType = "Credit Inquiry Purpose Type";
const String creditInquiryStage = "credit Inquiry Stage";
const String creditReportTransactionDateType =
    "Credit Report Transaction Date Type";

//product
const String highmarkUrl =
    "https://hub.crifhighmark.com/Inquiry/doGet.service/requestResponse";
const String highmarkUserId = "chmprod@saija.in";
const String highmarkPass = "2B751AC20331A7CF2C502136A9C6E62DC0E6F7A9";

//NOC Approval

const String noLoansFound = "No Loans Found";
const String nameOfMFI = "Name Of MFI";
const String balance = "Balance";
const String status = "Status";
const String expAmt = "Exp Amt";
const String details = "Details";
const String result = "Result";
const String mfiOd = "MFI OD";
const String odAcounts = "OD Acounts";
const String mfiCurrBal = "MFI Curr Bal";

//demo
/*
const String highmarkUrl = "https://test.crifhighmark.com/Inquiry/doGet.service/requestResponse";
const String highmarkUserId="chmuat@saija.in";
const String highmarkPass="ACA9F2284300A98B40524076DDA38290BEE3DDDF";
*/

const String creditRequestTypeVal = "JOIN";
const String creditReportTransactionIDVal = "Required";
const String creditInquiryPurposeTypeVal = "ACCT-ORIG";
const String creditInquiryStageVal = "PRE-DISB";
const String mfiId = "MFI0000056";
const String subMbrId = "SAIJA";
const String productType = "INDV";
const String productVersion = "1.0";

const String searchList = "Confirm Search";
const String viewList = "View";

//prefixText
const String mobNoPrefix = "+91";

//loan details

const String maxAmountApplyminAmountcanApply = 'Min - Max Amount Apply';
const String maxInstApply = 'Min - Max Installment Can Apply';

//Button
const String bScanQR = "Scan UID QR";
const String bGenerateOtp = "Generate OTP";
const String bResendOtp = "Resend OTP";
const String bVerify = "Verify";

//Scaffold Messages
const String generateOTPfirst = "Generate an OTP first";
const String entrVldNum = "Enter a valid number";
const String bankName = "Bank Name";

class Constant {
  static const JsonCodec JSON = const JsonCodec();
/*static String apiURL = "http://115.248.230.170:8090/";
static String myPublicURL = "http://115.248.230.170:8090/";
static String myPrivateURL = "http://115.248.230.170:8090/";*/

  static var gridDashBoardMenus = List<UserRightBean>();
  static var loanDashBoardMenus = List<UserRightBean>();
  static var savingsDashBoardMenus = List<UserRightBean>();
  static var sideDrawerMenus = List<UserRightBean>();
  static var adminDashBoardModules = List<UserRightBean>();
  
//my Machine Public
  static String apiURL = "http://14.141.164.238:8090/";
  static String myPublicURL = "http://14.141.164.238:8090/";
  static String myPrivateURL = "http://14.141.164.238:8090/";

  static bool isHttpsCallNeeded = false;

  //static String apiURL = "http://115.248.230.170:8090/";//common m/c

/*  //Saija UAT
  static String apiURL = "http://223.31.12.91:8090/";
  static String myPublicURL = "http://223.31.12.91:8090/";
  static String myPrivateURL = "http://223.31.12.91:8090/";*/

  // Development Environment
/*  static String apiURL = "http://115.248.230.170:8090/";
  static String myPublicURL = "http://115.248.230.170:8090/";
  static String myPrivateURL = "http://115.248.230.170:8090/";*/
// new Development Environment

/*static String apiURL = "http://14.141.164.236:8090/";
  static String myPublicURL = "http://14.141.164.236:8090/";
  static String myPrivateURL = "http://14.141.164.236:8090/";*/

  //wasasa local ip not public
  /*static String apiURL = "http://172.21.1.30:8090/";
  static String myPublicURL = "http://172.21.1.30:8090/";
  static String myPrivateURL = "http://172.21.1.30:8090/";*/
/*
//SAIJA UAT 2
  static String apiURL = "http://52.249.64.23:8090/";
  static String myPublicURL = "http://52.249.64.23:8090/";
  static String myPrivateURL = "http://52.249.64.23:8090/";
*/

  //Saija Production
/*
 static String apiURL = "http://104.211.159.5:8090/";
  static String myPublicURL = "http://104.211.159.5:8090/";
  static String myPrivateURL = "http://104.211.159.5:8090/";
*/

  static List<UserRightBean> accessRights = new List<UserRightBean>();

  static bool isCustTab1Show = true;
  static bool isCustTab2Show = true;
  static bool isCustTab3Show = true;
  static bool isCustTab4Show = true;
  static bool isCustTab5Show = true;
  static bool isCustTab6Show = true;
  static bool isCustTab7Show = true;
  static bool isCustTab8Show = true;
  static bool isCustTab9Show = true;
  static bool isCustTab10Show = true;
  static bool isCustTab11Show = true;
  static bool isCustTab12Show = true;
  static bool isCustTab13Show = true;
  static bool isCustTab14Show = true;

  static bool isGraphTabShow = false;
  static bool isDashBoardTabShow = true;
  static bool isMapTabShow = false;
  static bool isToDoTabShow = true;


  static bool isSpouseTabNeeded = true;

  static int mngrGrpCode = 33;
  static int foGrpCode = 22;
  static Color mandatoryColor = Colors.grey[300];
  static Color readonlyColor = Colors.black12;
  static Color semiMandatoryColor = Colors.grey[300];

//GridWorkflow AppPermissions
  static List<int> prospectCreationMenu = [22];
  static List<int> nocAprovalMenu = [14];

//Syncing Activity Menu
  // Function Permission
  static List<int> syncCenter = [22];
  static List<int> syncGroup = [22];
  static List<int> syncLookups = [22];
  static List<int> syncInterestSlab = [22];
  static List<int> syncInterestOffset = [22];
  static List<int> syncLoanCycleParameterPrimary = [22];
  static List<int> syncLoanCycleParameterSecondary = [22];
  static List<int> syncDailyCollection = [22];

  static List<int> syncSubLookups = [22];
  static List<int> syncProduct = [22];
  static List<int> syncPurpose = [22];
  static List<int> uploadNOCCheckRes = [14, 13];
  static List<int> syncProspect = [22, 14, 13];
  static List<int> syncCustomer = [22, 14, 13];
  static List<int> syncLoanDetails = [22, 14, 13];
  static List<int> syncCGT1 = [22, 14, 13];
  static List<int> syncCGT2 = [22, 14, 13];
  static List<int> syncGRT = [14, 13];
  static List<int> getNOCPendingData = [14];
  static List<int> getNOCCheckResult = [22];
  static List<int> getWorkingLoan = [22];
  static List<int> getWorkingCustomer = [22];
  static List<int> getAllProspectData = [22, 14];
  static List<int> syncSystemParameter = [22, 14];

  //Scaffold Messages
  static String gettingWorkingLoans = "Getting working Loans";
  static String gettingWorkingCustomer = "Getting Working Customer";
  static String gettingSavingsList = "Getting Savings List";
  static String gettingDisbursmentList = "Getting Disbursment List";
    static String gettingproductwiseLoancycle = "Getting Product wise Loan Cycle";

  static String gettingNOCPendingData = "Getting NOC Pending Data";
  static String gettingNOCCheckResult = "Getting NOC Check Result";
  static String syncingSubLookup = "Syncing.... Sub Lookup";
  static String syncingProduct = "Syncing... Product";
  static String syncingCGT1 = "Syncing CGT 1";
  static String syncingCGT2 = "Syncing CGT 2";
  static String syncingProspect = "Syncing Prospect";
  static String syncingLookups = "Syncing.... Lookups";
  static String syncingInterestSlab = "Syncing.... Interest Slab";
  static String syncingInterestOffset = "Syncing... Interest Offset";
  static String syncingLoanCycleParameterPrimary =
      "Syncing... Loan Cycle Parameter Primary ";
  static String syncingLoanCycleParameterSecondary =
      "Syncing... Loan Cycle Parameter Secondary ";
  static String syncingDailyCollection = "Syncing Daily Collection";
  static String syncingTDRoiTables = "Syncing.... TD R.O.I Tables";
  static String syncingLoanApprovalLimit = "Syncing... Loan Approval Limit";
  static String syncingBranch = "Syncing.... BranchMaster";
  static String syncLoanApprovalLimit = "Loan Approval Limit";

  static String syncingVaultBalanceMaster = "Syncing.... Vault Balance Master";
  static String valutaultBalanceMaster = "Vault Balance Master";
//
  static String syncingUserAccessRights = "Syncing.... User Access Rights";
  static String syncingConfiguredCharts = "Syncing.... Configured Charts";
  static String userAccessRights = "User Access Rights";
  static String syncConfiguredCharts = "Sync Configured Charts";

  static String fetchMenusMaster = "Syncing.... Menus Master";

  static String menusMaster = "Menus Master";

  static String gettingALLProspect = "Getting ALL Prospect";
  static String syncingAddress = "Syncing... Address";
  static String noGroups = "No groups assigned to selected center";

  //labels
  static String syncCenterlab = "Center";
  static String syncedgrouplab = "Group";
  static String syncedLookupsLab = "Dropdowns";
  static String syncedInterestSlabLab = "Interest Rates";
  static String syncedInterestOffsetLab = "Cyclewise Interest Offset";
  static String syncedLoanCycleParameterPrimaryLab =
      "Loan Cycle Parameter Primary";
  static String syncedLoanCycleSecondaryPrimaryLab =
      "Loan Cycle Parameter Secondary";
  static String syncedDailyCollection = "Daily Collection";
  static String syncingSystemParameter = "Syncing... System Parameter";
  static String syncLoanData = "Captured Loan Data";

  static String syncSubLookupLab = "Dependent Dropdowns";
  static String syncProductLab = "Product";
  static String syncToServerLab = "To Server";
  static String syncProspectLab = "Prospect";
  static String syncCustomerLab = "Customer";
  static String syncCustomerProductWiseCycle = "Customer Productwise Cycle";

  static String syncSavingsLab = "Savings";
  static String syncGuarantorLab = "Guarantor";

  static String syncLoanUtilization = "Loan Utilization";
  static String syncBranchLab = "Branch";
  static String syncSavingsCollectionLab = "Savings Collection";

  static String syncLoanDetailsLab = "Loan Details And Approval Process";
  static String syncCGT1Lab = "CGT1";
  static String syncCGT2Lab = "CGT 2";
  static String syncGRTLab = "GRT";
  static String uploadNOCCheckResultLab = "Upload NOC Check Result";
  static String getNOCPendingDataLab = "Get NOC Pending Data";
  static String getNOCCheckResultLab = "Get NOC Check result";
  static String getWorkingLoanLab = "Loan Portfolio";
  static String getWorkingCustomersLab = "Customer";
  static String getAllSavingsListLab = "Savings";
  static String getAllDisbursmentListLab = "To get All Disbursment List";

  static String getFromCenterId = "Customer From Center";

  static String syncFromServerLab = "From Server";
  static String getAllProspectDataLab = "Prospect";
  static String syncAddress = "Address";
  static String syncedSystemParameterLab = 'System Parameter';
  static String getDailyCollectionData = 'Daily Collection';
  static String syncDailyLoanCollected = "Daily Loan Collected";
  static String syncedTdROI = 'TD Productwise and Offset';
  static String syncGlAccount = 'GL Accounts';
  static String syncingGLAccounts = "Syncing GL Accounts";

  //CustomerPersonalInfo
  static String applicantDOB = "Applicant DOB";
  static String institutionName = "Institution Name";
  static String institutionEstablishmntDate = "Date Of Establishment";
  static String husDob = "Spouse DOB";

  //CustomerFormationLoanDetails
  static String loanDate = "Loan Date";
  static String repaymentDate = "Repayment Date";
  static String loandisbdt = "Disbursement date";
  static String loaninstStrtDt = "Installment Start Date";

  //errors for customer
  static String errorMaxExceedChar = "Field must Not have more than";
  static String errorChar = "charater";

  //family
  static String errorFamName = "Family member name on grid position";
  static String errorFamNIC = "Family member NIC on grid position";
  static String errorFamAge = "Family member Age on grid position";
  static String errorFamEducation =
      "System issue!! Family member Education on grid position ";
  static String errorFammemberNumber = "Family member Number on grid position";
  static String errorFamOccupation =
      "System issue!! Family member Occupation type on grid position ";
  static String errorFamRelationship =
      "System issue!! Family member Relationship on grid position";
  static String errorFamMarrital =
      "Family member Marrital status on grid position";
  static String errorFamAccidential =
      "Family member Accidential insurance on grid position";
  static String errorFamNominee = "Family member Dependent on grid position";

  //Address
  static String errorAddrType = "Address Type name on grid position";
  static String errorAddr1 = "Address Line 1  on grid position";
  static String errorAddr2 = "Address Line 2 on grid position";
  static String errorAddr3 = "Address Line 3 on grid position ";
  static String errorPinCd = "Pin Code on grid position";
  static String errorTel1 = "Tel1 on grid position ";
  static String errorTel2 = "Tel2 on grid position";
  static String errorCityCd = "City Code on grid position";
  static String errorFax1 = "Fax 1 on grid position";
  static String errorFax2 = "Fax 2 on grid position";
  static String errorContCD = "Country Code on grid position";
  static String errorArea = "Area on grid position";
  static String errorHouseType = "HouseType on grid position";
  static String errorRntLeasAmt = "Rent Leas Amount on grid position";
  static String errorRntLeasDep = "Rent Leas Dep on grid position";
  static String errorRntLeasExp = "Rent Leas Exp on grid position";
  static String errorRoofCont = "Roof Cont on grid position";
  static String errorUtils = "Utils on grid position";
  static String errorAreaType = "AreaType on grid position";
  static String errorLandmark = "Landmark on grid position";
  static String errorState = "State on grid position";
  static String errorYearStay = "YearStay on grid position";
  static String errorWardNo = "WardNo on grid position";
  static String errorMobile = "Mobile on grid position";
  static String errorEmail = "Email on grid position";
  static String errorPattaName = "PattaName on grid position";
  static String errorRelationship = "Relationship on grid position";
  static String errorSourceOfDep = "SourceOfDep on grid position";
  static String errorInstAmount = "InstAmount on grid position";
  static String errorToietYN = "Toilet on grid position";
  static String errorNorooms = "No Of rooms on grid position";
  static String errorSpouseYearsStay = "SpouseYearsStay on grid position";

  static String errorDistCd = "DistCd on grid position";
  static String errorvillage = "Village on grid position";
  static String errorCookFuel = "CookFuel on grid position";
  static String errorSecMobile = "SecMobile on grid position";

//borrowing details

  static String errorBorrName = "Borrowing Details name on grid position";
  static String errorBorrSource = "Borrowing Details source on grid position";
  static String errorBorrPurpose = "Borrowing Details Purpose on grid position";
  static String errorBorrMemberNo =
      " Borrowing Details MemberNo on grid position ";
  static String errorBorrmemberLoanCycle =
      "Borrowing Details LoanCycle on grid position";

  //collection
  //label
  static String productNameNo = "Product Name / No";
  static String centerNameNo = "Cutomer Name/No";
  static String accountNo = "Acc No";
  static String paidByGrp = "Paid By Group";
  static String adjFrmSD = "From SD";
  static String adjFrmExcs = "From Excess";
  static String attendence = "Attendence";
  static String paid = "Paid";

  static String chkExstngCustIp = "/customerData/getCustomerbyID/";

  //Term Deposit
  static String certificateDate = "Certificate Date";
  static String tenure = "Tenure: ";
  static String appBarLabelNewTermDeposit = "New Term Deposit";
  static String labelCustName = "Cutomer Name/No";
  static String labelProdName = "Product Name/No";
  static String labelMaturityDate = "Maturity Date";
  static String labelRateOfInterest = "Rate of Interest";
  static String labelModeOfPayout = "Mode of Payout";
  static String labelAccountNo = "Accout No :";

  //labels for FPS
  static String label_biometric_scan = "Biometric Scan";
  static String label_please_select_rt_hand_fngr =
      "Please select fingers of your Right hand for scannning";
  static String label_please_select_lt_hand_fngr =
      "Please select fingers of your Left hand for scannning";
  static String label_thumb_finger = "Thumb";
  static String label_index_finger = "Index Finger";
  static String label_middle_finger = "Middle Finger";
  static String label_ring_finger = "Ring Finger";
  static String label_pinky_finger = "Pinky Finger";

  //putting everything in constant

  static String somethingWentWrong = "Something went wrong";
  static String error = "Error";
  static String loginPage = "LoginPage";
  static String trefno = "Trefno : ";
  /* static String loginPage="LoginPage";
  static String loginPage="LoginPage";
  static String loginPage="LoginPage";*/

  static String INSTFREQ_W = "W-F-B-M-U-T";
  static String INSTFREQ_F = "F";
  static String INSTFREQ_M = "M-U-Y-H-T";
  static String INSTFREQ_B = "B-M";

  //Guarantor
  static String dateOfBirth = "Date Of Birth";

  static var SMSVerURL = 'https://api.textlocal.in/send/?';
  static String otpMessage =
      "This is your OTP from Bank Please verify same to customer";

  String loginTime;
  int usrGrpCode = 0;
  String username;
  String usrRole;
  String geoLocation;
  String geoLatitude;
  String geoLongitude;
  String branch = "";

  //Center Creation
  static String newCenterCreation = "New Center Creation";
  static String centerNumber = "Center Number";
  static String centerName = "Center Name";
  static String centerCreationDate = "Center Creation Date";
  static String firstMeetingDate = "First Meeting Date";
  static String centerMeetingLocation = "Center Meeting Location";
  static String meetingFrequency = "Meeting Frequency";
  static String meetingDay = "Center Meeting Day";
  static String repayBtwn = "Repayment Between";
  static String nextMeetingDate = "Next Meeting Date";

  static String getProspectStatus(int prospectStatus) {
    if (prospectStatus == 0)
      return "CB Check Pending";
    else if (prospectStatus == 1)
      return "CB Checked";
    else if (prospectStatus == 2)
      return "Pass";
    else if (prospectStatus == 3)
      return "Fail";
    else if (prospectStatus == 4)
      return "NOC Pending";
    /* else if(prospectStatus == 4)return "NOC Pending";
   else if(prospectStatus == 4)return "NOC Pending";*/
    else if (prospectStatus == 5)
      return "NOC Rejected";
    else if (prospectStatus == 6)
      return "NOC Verified";
    else if (prospectStatus == 7)
      return "Customer Created";
    else if (prospectStatus == 8)
      return "Loan Creted";
    else if (prospectStatus == 9)
      return "CGT 1 Done";
    else if (prospectStatus == 10)
      return "CGT 2 Done";
    else if (prospectStatus == 11) return "Loan Disbursed";
  }

  static String getLoanStatus(int loanStatus) {
    if (loanStatus == 1)
      return "New";
    else if (loanStatus == 5)
      return "CGT1";
    else if (loanStatus == 6)
      return "CGT2";
    else if (loanStatus == 7)
      return "GRT Approved";
    else if (loanStatus == 99)
      return "GRT Rejected";
    else
      return "";
  }

  static String getSavingsAccountStatus(int savingsStatus) {
    if (savingsStatus == 1)
      return "Normal/Operative";
    else if (savingsStatus == 2)
      return "New";
    else if (savingsStatus == 3)
      return "Closed";
    else if (savingsStatus == 14)
      return "WrittenOff";
    else if (savingsStatus == 11)
      return "NPA";
    else
      return "";
  }

  Future<Null> getSessionVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    branch = prefs.get(TablesColumnFile.musrbrcode).toString();
    username = prefs.getString(TablesColumnFile.usrCode);
    usrRole = prefs.getString(TablesColumnFile.usrDesignation);
    usrGrpCode = prefs.getInt(TablesColumnFile.grpCd);
    loginTime = prefs.getString(TablesColumnFile.LoginTime);
    geoLocation = prefs.getString(TablesColumnFile.geoLocation);
    geoLatitude = prefs.get(TablesColumnFile.geoLatitude).toString();
    geoLongitude = prefs.get(TablesColumnFile.geoLongitude).toString();
  }

  static Future<Null> setVer() async {
    try {
      globals.version = await GetVersion.projectVersion;
      // globals.version = await GetVersion.projectVersion;
      print("aagya kya apk globals" + globals.version.toString());
    } on PlatformException {
      globals.version = 'Failed to get project version.';
    }
  }

  static getPermissionStatus() async {
    get = '';
    List<Permissions> permissions = await Permission.getPermissionsStatus([
      PermissionName.Calendar,
      PermissionName.Camera,
      PermissionName.Contacts,
      PermissionName.Location,
      PermissionName.Microphone,
      PermissionName.Phone,
      PermissionName.Sensors,
      PermissionName.SMS,
      PermissionName.Storage,
    ]);
    permissions.forEach((permission) {
      get += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    ;
    print(get);
  }

  static requestPermissions() async {
    final res = await Permission.requestPermissions([
      PermissionName.Calendar,
      PermissionName.Camera,
      PermissionName.Contacts,
      PermissionName.Location,
      PermissionName.Microphone,
      PermissionName.Phone,
      PermissionName.Sensors,
      PermissionName.SMS,
      PermissionName.Storage
    ]);
    res.forEach((permission) {});
  }

  static generateUrl() async {
    print("data of on value Api Url");
    await AppDatabase.get().getApiUrl().then((onValue) {
      print(onValue.length.toString());
      for (int settingsList = 0;
          settingsList < onValue.length;
          settingsList++) {
        print("data of on value Api Url" + onValue[settingsList].mipaddress);
        settingsBean = new SettingsBean();
        settingsBean.musrcode = onValue[settingsList].musrcode;
        settingsBean.musrpass = onValue[settingsList].musrpass;
        settingsBean.mipaddress = onValue[settingsList].mipaddress;
        settingsBean.mportno = onValue[settingsList].mportno;
        settingsBean.isHttps = onValue[settingsList].isHttps;
        settingsBean.isPortRequired = onValue[settingsList].isPortRequired;
        print("settingsBean.isHttps ${settingsBean.isHttps}");
        print("settingsBean.isHttps ${settingsBean.isPortRequired}");
        //TODO take request type from system params table eg(http/https)
        Constant.isHttpsCallNeeded = settingsBean.isHttps == 1 ? true : false;
        String isHttpsVal =
            "${settingsBean.isHttps == 1 ? "https://" : "http://"}";
        String isPortRequiredVal =
            "${settingsBean.isPortRequired == 1 ? "" : ":${settingsBean.mportno}"}";

        Constant.apiURL = isHttpsVal +
            settingsBean.mipaddress.toString() +
            isPortRequiredVal +
            "/";
        //Constant.apiURL = isHttpsVal+settingsBean.mipaddress.toString()+":"+settingsBean.mportno.toString()+"/";
        print(Constant.apiURL.toString() + " jhsjahsashhasjajh");
        //  globals.dropdownCaptionsValuesPersonalInfo[1].add(bean);
      }
    });
  }

  static assetsVisible(bool isWithReverse, String splitValues) async {
    //CPV Assets vidible
    await AppDatabase.get().getLookupDataFromLocalDb(909141).then((onValue) {
      globals.dropdownCaptionsValuesCpvMuliselect =
          List<CheckBoxesChecked>(onValue.length);
      for (int i = 0; i < onValue.length; i++) {
        CheckBoxesChecked checkList = new CheckBoxesChecked();
        checkList.mquestiondesc = onValue[i].mcodedesc;
        //checkList.fieldValue1 = onValue[i].fieldValue1;
        checkList.mquestionid = onValue[i].mcode;
        globals.dropdownCaptionsValuesCpvMuliselect[i] = checkList;
      }
      if (isWithReverse) {
        try {
          if (splitValues != null) {
            // for (var items in splitValues.split("~")) {
            var items = splitValues.split("~");
            for (int i = 0;
                i < globals.dropdownCaptionsValuesCpvMuliselect.length;
                i++) {
              print(
                  "xxxxxxxxxxxxxxxxxx Problem here in CPV Assets Visible ${globals.dropdownCaptionsValuesCpvMuliselect[i].toString()}");
              if (items.contains(globals
                  .dropdownCaptionsValuesCpvMuliselect[i].mquestionid
                  .trim())) {
                globals.dropdownCaptionsValuesCpvMuliselect[i].manschecked = 1;
              } else {
                globals.dropdownCaptionsValuesCpvMuliselect[i].manschecked = 0;
              }
            }
            //  }
            globals.dropdownCaptionsValuesCpvMuliselect =
                globals.dropdownCaptionsValuesCpvMuliselect;
          }
        } catch (_) {
          print("xxxxxxxxxxxxxxxxxx Problem here in CPV Assets Visible");
        }
      }
    });
  }

  static getDropDownInitialize() async {
//prospect

//nominee relationship
    await AppDatabase.get().getLookupDataFromLocalDb(909009).then((onValue) {
      globals.dropdownCaptionsValuesProspectInf[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesProspectInf[0].add(bean);
      }
    });

    //documentId id type 2
    await AppDatabase.get().getLookupDataFromLocalDb(909066).then((onValue) {
      globals.dropdownCaptionsValuesProspectInf[1].clear();
      globals.dropdownCaptionsValuesKyc[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesProspectInf[1].add(bean);
        globals.dropdownCaptionsValuesKyc[1].add(bean);
      }
    });

//social financial
    await AppDatabase.get().getLookupDataFromLocalDb(909003).then((onValue) {
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[0].add(bean);

        /*LookUpDescriptionValueObj lookup = new LookUpDescriptionValueObj();
      Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[0].add(map);*/
      }
    });
    //if yes the
    await AppDatabase.get().getLookupDataFromLocalDb(909015).then((onValue) {
      globals.dropdownCaptionsValuesFamilyDetails[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        //globals.dropdownCaptionsValuesPersonalInfo[0].add(bean);
        globals.dropdownCaptionsValuesFamilyDetails[1].add(bean);
      }
    });

    //relegion
    await AppDatabase.get().getLookupDataFromLocalDb(1132).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[1].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(1063).then((onValue) {
      //frequency
      globals.dropdownCaptionsValuesSavingsListInfo[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesSavingsListInfo[1].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(1057).then((onValue) {
      //purpose of loan
      globals.dropdownCaptionsValuesSavingsListInfo[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesSavingsListInfo[0].add(bean);
      }
    });

    //is married
    await AppDatabase.get().getLookupDataFromLocalDb(1154).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[2].clear();
      globals.dropdownCaptionsValuesGuarantorInfo[7].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[2].add(bean);
        globals.dropdownCaptionsValuesGuarantorInfo[7].add(bean);
      }
    });

    //is educated
    await AppDatabase.get().getLookupDataFromLocalDb(1159).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[3].clear();
      globals.dropdownCaptionsValuesFamilyDetails[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[3].add(bean);
        globals.dropdownCaptionsValuesFamilyDetails[0].add(bean);
      }
    });

    //occupation
    await AppDatabase.get().getLookupDataFromLocalDb(2000).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[4].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[4].add(bean);
      }
    });

    //mother tongue
    await AppDatabase.get().getLookupDataFromLocalDb(38999).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[7].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[7].add(bean);
      }
    });

    //secondary occupation and is occupation
    await AppDatabase.get().getLookupDataFromLocalDb(909011).then((onValue) {
      globals.dropdownCaptionsValuesFamilyDetails[2].clear();
      globals.dropdownCaptionsValuesPersonalInfo[8].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesFamilyDetails[2].add(bean);
        globals.dropdownCaptionsValuesPersonalInfo[8].add(bean);
      }
    });
    //caste
    await AppDatabase.get().getLookupDataFromLocalDb(48004).then((onValue) {
      //10022
      globals.dropdownCaptionsValuesPersonalInfo[5].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[5].add(bean);
      }
    });
    //Title
    await AppDatabase.get().getLookupDataFromLocalDb(1059).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[6].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[6].add(bean);
      }
    });
//gender
    await AppDatabase.get().getLookupDataFromLocalDb(1139).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[9].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[9].add(bean);
      }
    });
    //Region Rural Urban
    await AppDatabase.get().getLookupDataFromLocalDb(46007).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[10].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[10].add(bean);
      }
    });
    //education
    await AppDatabase.get().getLookupDataFromLocalDb(1000000).then((onValue) {
      globals.dropdownCaptionsValuesPersonalInfo[11].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesPersonalInfo[11].add(bean);
      }
    });
//id type 1 , pan no
    await AppDatabase.get().getLookupDataFromLocalDb(1075).then((onValue) {
      //1321
      globals.dropdownCaptionsValuesKyc[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesKyc[0].add(bean);
        //      globals.dropdownCaptionsValuesKyc[1].add(bean);
      }
    });
    //custType
    await AppDatabase.get().getLookupDataFromLocalDb(101004).then((onValue) {
      globals.dropdownCaptionsValuesProfileDetails[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesProfileDetails[1].add(bean);
      }
    });

    //GroupType
    await AppDatabase.get().getLookupDataFromLocalDb(1076).then((onValue) {
      //globals.dropdownCaptionsValuesProfileDetails[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("setting required values ${onValue[i].mcodedesc}");
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.mGroupType.add(bean);
      }
    }); //GroupType
    await AppDatabase.get().getLookupDataFromLocalDb(1076).then((onValue) {
      globals.mGroupType.clear();
      for (int i = 0; i < onValue.length; i++) {
        print("setting required values ${onValue[i].mcodedesc}");
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.mGroupType.add(bean);
      }
    });

    //Customer Status
    await AppDatabase.get().getLookupDataFromLocalDb(909051).then((onValue) {
      globals.dropdownCaptionsValuesProfileDetails[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("setting required values ${onValue[i].mcodedesc}");
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesProfileDetails[2].add(bean);
      }
    });

    //id type
    /*await  AppDatabase.get().getFromSubLookupDataFromLocalDb(102).then((onValue){//1321
    for(int i = 0;i<onValue.length;i++){
      print("data of on value code desription" + onValue[i].mcodedesc);
      LookupBeanData bean = new LookupBeanData();
      bean.mcodedesc = onValue[i].mcodedesc;
      bean.mcode = onValue[i].mcode ;
      bean.mcodetype = onValue[i].mcodetype ;
      bean.mfield1value = onValue[i].mfield1value ;
      globals.dropdownCaptionsValuesKyc[1].add(bean);
    }
  });*/
    //contact
    await AppDatabase.get().getLookupDataFromLocalDb(909002).then((onValue) {
      globals.dropdownCaptionsValuesKycDetails2[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);

        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesKycDetails2[0].add(bean);
      }
    });
    //business owned
    await AppDatabase.get().getLookupDataFromLocalDb(5).then((onValue) {
      globals.dropDownCaptionValuesBusinessDetails[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesBusinessDetails[0].add(bean);
        /* Map<String,String> map = new Map<String,String>();;
      map[onValue[i].code] =  onValue[i].mcodedesc;

      globals.dropDownCaptionValuesBusinessDetails[0].add(map);*/
      }
    });

    //LoanLimitDetails

    //CGT1

    await AppDatabase.get().getLookupDataFromLocalDb(7070).then((onValue) {
      globals.questionCGT1 = List<CheckListCGT1Bean>(onValue.length);
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription here is data is " +
            onValue[i].mcodedesc);
        CheckListCGT1Bean checkList = new CheckListCGT1Bean();
        checkList..mquestiondesc = onValue[i].mcodedesc;
        //checkList.fieldValue1 = onValue[i].fieldValue1;
        checkList.mquestionid = onValue[i].mcode;
        globals.questionCGT1[i] = checkList;
      }
    });
//CGT2
    await AppDatabase.get().getLookupDataFromLocalDb(7071).then((onValue) {
      globals.questionCGT2 = List<CheckListCGT2Bean>(onValue.length);
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription here is data is " +
            onValue[i].mcodedesc);
        CheckListCGT2Bean checkList = new CheckListCGT2Bean();
        checkList.mquestiondesc = onValue[i].mcodedesc;
        //checkList.fieldValue1 = onValue[i].fieldValue1;
        checkList.mquestionid = onValue[i].mcode;
        globals.questionCGT2[i] = checkList;
      }
    });

    //GRT

    await AppDatabase.get().getLookupDataFromLocalDb(7072).then((onValue) {
      globals.questionGRT = List<CheckListGRTBean>(onValue.length);
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription here is data is " +
            onValue[i].mcodedesc);
        CheckListGRTBean checkList = new CheckListGRTBean();
        checkList.mquestiondesc = onValue[i].mcodedesc;
        //checkList.fieldValue1 = onValue[i].fieldValue1;
        checkList.mquestionid = onValue[i].mcode;
        globals.questionGRT[i] = checkList;
      }
    });
//change here --- bhawpriya

    await AppDatabase.get().getLookupDataFromLocalDb(909022).then((onValue) {
      //purpose of loan
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[0].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909019).then((onValue) {
      //frequency
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[1].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909999).then((onValue) {
      //repayment mode
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[2].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909094).then((onValue) {
      // mode of disb
      globals.dropdownCaptionsValuesCustLoanDetailsInfo[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCustLoanDetailsInfo[3].add(bean);
      }
    });

    //expense detail , business
    await AppDatabase.get().getLookupDataFromLocalDb(1100).then((onValue) {
      globals.dropdownCaptionsValuesExpenseDetails[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesExpenseDetails[0].add(bean);
      }
    });

    //expense detail , household
    await AppDatabase.get().getLookupDataFromLocalDb(1500).then((onValue) {
      globals.dropdownCaptionsValuesExpenseDetails[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesExpenseDetails[1].add(bean);
      }
    });

    // name of bank
    await AppDatabase.get().getLookupDataFromLocalDb(909050).then((onValue) {
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[2].add(bean);
        //globals.dropDownCaptionValuesCOdeKeysSocialFinancial[2].sort((a, b) => a.mcodedesc.compareTo(b.mcodedesc));
      }
    });

    // asset detail
    await AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue) {
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[3].add(bean);
      }
    });

    // construct
    await AppDatabase.get().getLookupDataFromLocalDb(909006).then((onValue) {
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[4].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[4].add(bean);
      }
    });

    // Toilet
    await AppDatabase.get().getLookupDataFromLocalDb(909007).then((onValue) {
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[5].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[5].add(bean);
      }
    });
    //Utils
    await AppDatabase.get().getLookupDataFromLocalDb(909005).then((onValue) {
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[6].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[6].add(bean);
      }
    });

    //PPI Question

    await AppDatabase.get().getLookupDataFromLocalDb(70771).then((onValue) {
      globals.dropdownCaptionsValuePPIDetails[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuePPIDetails[0].add(bean);
      }
    });

    //agriculture land type
    await AppDatabase.get().getLookupDataFromLocalDb(1800).then((onValue) {
      globals.dropDownCaptionValuesCOdeKeysSocialFinancial[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCOdeKeysSocialFinancial[1].add(bean);
      }
    });

    //role of member
    await AppDatabase.get().getLookupDataFromLocalDb(1260).then((onValue) {
      globals.dropdownCaptionsValuesProfileDetails[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesProfileDetails[0].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(1130).then((onValue) {
      //mode of payout
      globals.dropdownCaptionsValuesModeOfPayout[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesModeOfPayout[0].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(1127).then((onValue) {
      //mode of payout
      globals.dropdownCaptionsValuesModeOfPayout[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesModeOfPayout[1].add(bean);
      }
    });

    //Guarantor
    await AppDatabase.get().getLookupDataFromLocalDb(1075).then((onValue) {
      globals.dropdownCaptionsValuesGuarantorInfo[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);

        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[0].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(909018).then((onValue) {
      globals.dropdownCaptionsValuesGuarantorInfo[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);

        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[1].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(1140).then((onValue) {
      globals.dropdownCaptionsValuesGuarantorInfo[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);

        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[2].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(909009).then((onValue) {
      globals.dropdownCaptionsValuesGuarantorInfo[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);

        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[3].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(909003).then((onValue) {
      globals.dropdownCaptionsValuesGuarantorInfo[4].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);

        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[4].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(2000).then((onValue) {
      globals.dropdownCaptionsValuesGuarantorInfo[5].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);

        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[5].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(909011).then((onValue) {
      globals.dropdownCaptionsValuesGuarantorInfo[6].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);

        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[6].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(450058).then((onValue) {
      //buspropownership
      globals.dropdownCaptionsValuesGuarantorInfo[8].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[8].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(450059).then((onValue) {
      //busownership
      globals.dropdownCaptionsValuesGuarantorInfo[9].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[9].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(1002).then((onValue) {
      globals.dropdownCaptionsValuesGuarantorInfo[10].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGuarantorInfo[10].add(bean);
      }
    });

    // business detais
    // fixed assets
    await AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue) {
      globals.dropDownCaptionValuesCodeKeysBusiness[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCodeKeysBusiness[0].add(bean);
      }
    });

    // current assets
    await AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue) {
      globals.dropDownCaptionValuesCodeKeysBusiness[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCodeKeysBusiness[1].add(bean);
      }
    });

    // long term liability
    await AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue) {
      globals.dropDownCaptionValuesCodeKeysBusiness[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCodeKeysBusiness[2].add(bean);
      }
    });

    // short term liability
    await AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue) {
      globals.dropDownCaptionValuesCodeKeysBusiness[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCodeKeysBusiness[3].add(bean);
      }
    });

    // equity
    await AppDatabase.get().getLookupDataFromLocalDb(909041).then((onValue) {
      globals.dropDownCaptionValuesCodeKeysBusiness[4].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionValuesCodeKeysBusiness[4].add(bean);
      }
    });

    // CIF
    await AppDatabase.get().getLookupDataFromLocalDb(1014).then((onValue) {
      globals.dropdownCaptionsValuesCif[0].clear();
      globals.dropdownCaptionsValuesTransaction[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCif[0].add(bean);
        globals.dropdownCaptionsValuesTransaction[2].add(bean);
      }
    });

    //Center Frequency
    await AppDatabase.get().getLookupDataFromLocalDb(909119).then((onValue) {
      globals.dropdownCaptionsValuesCenterFormation[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCenterFormation[0].add(bean);
      }
    });

    //Center Meeting Day
    await AppDatabase.get().getLookupDataFromLocalDb(1019).then((onValue) {
      globals.dropdownCaptionsValuesCenterFormation[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCenterFormation[1].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(909091).then((onValue) {
      globals.dropdownCaptionsValuesCifLoanClosure[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCifLoanClosure[0].add(bean);
      }
    });

    //dropout reason
    await AppDatabase.get().getLookupDataFromLocalDb(111215).then((onValue) {
      globals.dropdownCaptionsValuesProfileDetails[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesProfileDetails[3].add(bean);
      }
    });

    //Group Type
    await AppDatabase.get().getLookupDataFromLocalDb(1076).then((onValue) {
      globals.dropdownCaptionsValuesGroupFormation[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGroupFormation[0].add(bean);
      }
    });

    //Gender
    await AppDatabase.get().getLookupDataFromLocalDb(1140).then((onValue) {
      globals.dropdownCaptionsValuesGroupFormation[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesGroupFormation[1].add(bean);
      }
    });
//Utility Bills start here
    await AppDatabase.get().getLookupDataFromLocalDb(992030).then((onValue) {
      globals.dropDownCaptionUtilityBillPayment[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionUtilityBillPayment[0].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4444).then((onValue) {
      globals.dropDownCaptionUtilityBillPayment[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionUtilityBillPayment[1].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(5555).then((onValue) {
      globals.dropDownCaptionUtilityBillPayment[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionUtilityBillPayment[2].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(6666).then((onValue) {
      globals.dropDownCaptionUtilityBillPayment[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownCaptionUtilityBillPayment[3].add(bean);
      }
    });

    // Internal Bank Transfer Screen, Transaction Type
    await AppDatabase.get().getLookupDataFromLocalDb(5555).then((onValue) {
      globals.dropdownCaptionsValuesTransaction[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTransaction[0].add(bean);
      }
    });

    // Internal Bank Transfer, CR/DR
    await AppDatabase.get().getLookupDataFromLocalDb(1110).then((onValue) {
      globals.dropdownCaptionsValuesTransaction[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTransaction[1].add(bean);
      }
    });
    //Ends

    //CPV starts
    await AppDatabase.get().getLookupDataFromLocalDb(909007).then((onValue) {
      globals.dropdownCaptionsValuesCpv[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCpv[0].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909003).then((onValue) {
      globals.dropdownCaptionsValuesCpv[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCpv[1].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(909146).then((onValue) {
      globals.dropdownCaptionsValuesCpv[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCpv[2].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(909147).then((onValue) {
      globals.dropdownCaptionsValuesCpv[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCpv[3].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909006).then((onValue) {
      globals.dropdownCaptionsValuesCpv[4].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesCpv[4].add(bean);
      }
    });

    assetsVisible(false, null);
    // social and environmental
    await AppDatabase.get().getLookupDataFromLocalDb(450030).then((onValue) {
      globals.dropdownCaptionsValuesSocialAndEnv[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesSocialAndEnv[0].add(bean);
      }
    });

    //trade and neighbour reference check

    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[0].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[1].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(450032).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[2].add(bean);
      }
    });
    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[3].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(90422).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[4].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[4].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[5].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[5].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[6].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[6].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909073).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[7].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[7].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(450033).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[8].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[8].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[9].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[9].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909073).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[10].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[10].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[11].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[11].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(450034).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[12].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[12].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(450035).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[13].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[13].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesTradeNeighbour[14].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesTradeNeighbour[14].add(bean);
      }
    });

    //deviatin form

    await AppDatabase.get().getLookupDataFromLocalDb(909099).then((onValue) {
      globals.dropdownCaptionsValuesDeviationForm[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesDeviationForm[0].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(450031).then((onValue) {
      globals.dropdownKycMaster[0].clear();
      globals.dropdownKycMaster[1].clear();
      globals.dropdownKycMaster[2].clear();
      globals.dropdownKycMaster[3].clear();
      globals.dropdownKycMaster[4].clear();
      globals.dropdownKycMaster[5].clear();
      globals.dropdownKycMaster[6].clear();
      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownKycMaster[0].add(bean);
        globals.dropdownKycMaster[1].add(bean);
        globals.dropdownKycMaster[2].add(bean);
        globals.dropdownKycMaster[3].add(bean);
        globals.dropdownKycMaster[4].add(bean);
        globals.dropdownKycMaster[5].add(bean);
        globals.dropdownKycMaster[6].add(bean);
      }
    });

    //CONTACT POINT VERIFICATION BUSINESS & OFFICE
    await AppDatabase.get().getLookupDataFromLocalDb(1002).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[0].clear();
      globals.dropdownCaptionsValuesLoanCPV[1].clear();
      globals.dropdownCaptionsValuesLoanCPV[4].clear();
      globals.dropdownCaptionsValuesLoanCPV[6].clear();
      globals.dropdownCaptionsValuesLoanCPV[7].clear();
      globals.dropdownCaptionsValuesLoanCPV[9].clear();
      globals.dropdownCaptionsValuesLoanCPV[12].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[0].add(bean);
        globals.dropdownCaptionsValuesLoanCPV[1].add(bean);
        globals.dropdownCaptionsValuesLoanCPV[4].add(bean);
        globals.dropdownCaptionsValuesLoanCPV[6].add(bean);
        globals.dropdownCaptionsValuesLoanCPV[7].add(bean);
        globals.dropdownCaptionsValuesLoanCPV[9].add(bean);
        globals.dropdownCaptionsValuesLoanCPV[12].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4521).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[2].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[2].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4529).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[3].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[3].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4522).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[5].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[5].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4523).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[8].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[8].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4524).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[10].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[10].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4525).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[11].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[11].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4526).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[13].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[13].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4527).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[14].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[14].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(4528).then((onValue) {
      globals.dropdownCaptionsValuesLoanCPV[15].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesLoanCPV[15].add(bean);
      }
    });

    await AppDatabase.get().getLookupDataFromLocalDb(30107).then((onValue) {
      globals.dropdownCaptionsValuesDisbursment[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("OnVAlue codedesc ${onValue[i].mcode}");
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuesDisbursment[0].add(bean);
      }
    });

    //PPI question Type
    await AppDatabase.get().getLookupDataFromLocalDb(46002).then((onValue) {
      globals.dropdownCaptionsValuePPIDetails[1].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownCaptionsValuePPIDetails[1].add(bean);
      }
    });

    //CPV ENds
    //static insert lastsynced table
    //baad mai insert this using list obj
    List<LastSyncedDateTime> lastSyncedDateTimeBean =
        new List<LastSyncedDateTime>();
    LastSyncedDateTime lastSyncObj = LastSyncedDateTime();
    lastSyncObj.id = 1;
    lastSyncObj.tTabelDesc = "customerFoundationMasterDetails";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 1);

    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 2;
    lastSyncObj.tTabelDesc = "Credit_Bereau_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 2);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 3;
    lastSyncObj.tTabelDesc = "CGT1_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 3);

    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 4;
    lastSyncObj.tTabelDesc = "CGT2_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 4);

    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 5;
    lastSyncObj.tTabelDesc = "GRT_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 5);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 6;
    lastSyncObj.tTabelDesc = "customer_Loan_Details_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 6);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 7;
    lastSyncObj.tTabelDesc = "collected_LoansAmt_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 7);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 8;
    lastSyncObj.tTabelDesc = "System_Parameter_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 8);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 9;
    lastSyncObj.tTabelDesc = "Lookup_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 9);

    // List<LastSyncedDateTime> lastSyncedDateTimeBeanLoan = new List<LastSyncedDateTime>();
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 10;
    lastSyncObj.tTabelDesc = "Sub_Lookup_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 10);

    // Savings list
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 11;
    lastSyncObj.tTabelDesc = "savings_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 11);

    // Savings Collection list
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 12;
    lastSyncObj.tTabelDesc = "savings_Collection_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 12);

    // Savings Collection list
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 13;
    lastSyncObj.tTabelDesc = "Term_Deposit_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 13);

    // Center Creation list
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 14;
    lastSyncObj.tTabelDesc = "Center_Details_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 14);

    // Group Creation list
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 15;
    lastSyncObj.tTabelDesc = "Group_Foundation";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 15);
    // USerAccessRights
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 16;
    lastSyncObj.tTabelDesc = "USER_ACCESS_RIGHTS";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 16);
    //Trade And Neighbour Reference Check
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 17;
    lastSyncObj.tTabelDesc = "Trade_Neighbour_Ref_Check_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 17);

    //Social Environment
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 18;
    lastSyncObj.tTabelDesc = "Social_Environment_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 18);

    //Deviation Form
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 19;
    lastSyncObj.tTabelDesc = "Deviation_Form_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 19);
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 21;
    lastSyncObj.tTabelDesc = "Customer_Loan_Cash_Flow_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 21);
    //CONTACT POINT VERIFICATION BUSINESS & OFFICE
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 22;
    lastSyncObj.tTabelDesc = "Loan_CPVBusiness_Record";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 22);

    //Guarantor Information Checklist
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 23;
    lastSyncObj.tTabelDesc = "gaurantor_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 23);

    //kycMaster sync
    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 20;
    lastSyncObj.tTabelDesc = "Kyc_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 20);

    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 24;
    lastSyncObj.tTabelDesc = "customer_loan_image_master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 24);

    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 26;
    lastSyncObj.tTabelDesc = "disbursed_master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 26);

    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 27;
    lastSyncObj.tTabelDesc = "Customer_Productwise_Cycle_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 27);


    lastSyncedDateTimeBean.clear();
    lastSyncObj = null;
    lastSyncObj = new LastSyncedDateTime();
    lastSyncObj.id = 28;
    lastSyncObj.tTabelDesc = "internal_Bank_Transfer_Master";
    lastSyncObj.tlastSyncedFromTab = null;
    lastSyncObj.tlastSyncedToTab = null;
    lastSyncedDateTimeBean.add(lastSyncObj);
    await AppDatabase.get()
        .insertStaticTablesLastSyncedMaster(lastSyncedDateTimeBean, 28);    

    //kyc Master
    await AppDatabase.get().getLookupDataFromLocalDb(450031).then((onValue) {
      globals.dropdownKycMaster[0].clear();
      globals.dropdownKycMaster[1].clear();
      globals.dropdownKycMaster[2].clear();
      globals.dropdownKycMaster[3].clear();
      globals.dropdownKycMaster[4].clear();
      globals.dropdownKycMaster[5].clear();
      globals.dropdownKycMaster[6].clear();

      for (int i = 0; i < onValue.length; i++) {
        Map<String, String> map = new Map<String, String>();
        ;
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropdownKycMaster[0].add(bean);
        globals.dropdownKycMaster[1].add(bean);
        globals.dropdownKycMaster[2].add(bean);
        globals.dropdownKycMaster[3].add(bean);
        globals.dropdownKycMaster[4].add(bean);
        globals.dropdownKycMaster[5].add(bean);
        globals.dropdownKycMaster[6].add(bean);
      }
    });

    //Language
    await AppDatabase.get().getLookupDataFromLocalDb(77777).then((onValue) {
      globals.dropDownLanguage[0].clear();
      for (int i = 0; i < onValue.length; i++) {
        print("data of on value code desription" + onValue[i].mcodedesc);
        LookupBeanData bean = new LookupBeanData();
        bean.mcodedesc = onValue[i].mcodedesc;
        bean.mcode = onValue[i].mcode;
        bean.mcodetype = onValue[i].mcodetype;
        bean.mfield1value = onValue[i].mfield1value;
        globals.dropDownLanguage[0].add(bean);
      }
    });
  }

  static Future setSystemVariables(String fromPage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SystemParameterBean sysBean = new SystemParameterBean();
    int lbrcode = prefs.getInt(TablesColumnFile.musrbrcode);
    print(
        lbrcode); // if(AppDatabase.get().getSystemParameter(1,lbrcode)!=null){


    try {
      await setHomeTabsToDisplay ();
    } catch (_) {}
    sysBean = await AppDatabase.get().getSystemParameter('1', lbrcode);
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.mValidity, sysBean.mcodevalue);
    }

    // if(AppDatabase.get().getSystemParameter(2,lbrcode)!=null){
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('2', 0);
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.mIsProspectNeeded, sysBean.mcodevalue);
    }

    //if (AppDatabase.get().getSystemParameter(3, lbrcode) != null) {
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('3', 0);
    if (sysBean != null) {
      prefs.setString(
          TablesColumnFile.mIsProspectRepeatNeeded, sysBean.mcodevalue);
    }

    // if (AppDatabase.get().getSystemParameter(4, lbrcode) != null) {
    /* sysBean = new SystemParameterBean();
       sysBean = await AppDatabase.get().getSystemParameter(4, 0);
    if(sysBean !=null){
      prefs.setString(TablesColumnFile.mCompanyName, sysBean.mcodevalue);
    }
*/

    // for Term Deposit RATE OF INTEREST logic
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('5', 0); // id
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.mTdparam, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('8', 0);
    if (sysBean != null) {
      print(sysBean.mcodevalue);
      int CGT1toCGT2Gap = 0;
      try {
        CGT1toCGT2Gap = int.parse(sysBean.mcodevalue);
      } catch (_) {
        print("Exception in parsing");
      }

      prefs.setInt(TablesColumnFile.CGT1toCGT2Gap, CGT1toCGT2Gap);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('7', 0);
    if (sysBean != null) {
      print(sysBean.mcodevalue);
      int CgtToGrtgap = 0;
      try {
        CgtToGrtgap = int.parse(sysBean.mcodevalue);
      } catch (_) {
        print("Exception in parsing");
      }

      prefs.setInt(TablesColumnFile.CGT2toGRTGap, CgtToGrtgap);
    }

    // starts
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.ISINDONUSERCD, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setString(TablesColumnFile.ISINDONUSERCD, sysBean.mcodevalue);
      } catch (_) {
        prefs.setString(TablesColumnFile.ISINDONUSERCD, "");
      }
    }
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.ISGLOONUSERCD, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setString(TablesColumnFile.ISGLOONUSERCD, sysBean.mcodevalue);
      } catch (_) {
        prefs.setString(TablesColumnFile.ISGLOONUSERCD, "");
      }
    }
    //ends
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('11', 0);
    prefs.setString(TablesColumnFile.mIsGroupLendingNeeded, "0");
    if (sysBean != null) {
      prefs.setString(
          TablesColumnFile.mIsGroupLendingNeeded, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('12', 0);
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.mCompanyName, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('CENTER', 0);
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.CENTERCAPTION, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('GROUP', 0);
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.GROUPCAPTION, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('14', 0);
    print("Setting system paramaetr for iscgt2 needed");
    prefs.setString(TablesColumnFile.isCGT2Needed, "0");
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.isCGT2Needed, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('15', 0);
    print("Setting system paramaetr for  IS WASASA");
    prefs.setString(TablesColumnFile.isWASASA, "0");
    if (sysBean != null && sysBean.mcodevalue != null) {
      prefs.setInt(
          TablesColumnFile.isWASASA, int.parse(sysBean.mcodevalue.trim()));
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('16', 0);
    print("Setting system paramaetr for  IS Male Validation");
    prefs.setString(TablesColumnFile.maleValidation, "0");
    if (sysBean != null && sysBean.mcodevalue != null) {
      prefs.setString(TablesColumnFile.maleValidation, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('17', 0);
    print("Setting system paramaetr for  IS Female Validation");
    prefs.setString(TablesColumnFile.femaleValidaton, "0");
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.femaleValidaton, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('18', 0);
    print("Setting system paramaetr for  IS Married Title");
    prefs.setString(TablesColumnFile.marriedTitles, " ");
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.marriedTitles, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('13', 0);
    print("Getting IS Country  Code");
    prefs.setString(TablesColumnFile.mcountryCd, "0");
    if (sysBean != null && sysBean.mcodevalue != null) {
      prefs.setString(TablesColumnFile.mcountryCd, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('19', 0);
    print("Getting IS Saija for  Saija Code");
    prefs.setInt(TablesColumnFile.isSaiaja, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      prefs.setInt(TablesColumnFile.isSaiaja, int.parse(sysBean.mcodevalue));
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('9', 0);
    print("Getting Dialing Code");
    prefs.setString(TablesColumnFile.dialCode, "+91");
    if (sysBean != null && sysBean.mcodevalue != null) {
      prefs.setString(TablesColumnFile.dialCode, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('CNTRREPAYFROMTO', 0);
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.mCenterRepayFromTo, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('21', 0);
    print("Setting system paramaetr for  exception Titles ");
    prefs.setString(TablesColumnFile.exceptionTitles, " ");
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.exceptionTitles, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter('22', 0);
    print("Getting Biometric  Code");
    prefs.setInt(TablesColumnFile.ISBIOMETRICNEEDED, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(
            TablesColumnFile.ISBIOMETRICNEEDED, int.parse(sysBean.mcodevalue));
      }
      //prefs.setInt(TablesColumnFile.ISBIOMETRICNEEDED, int.parse(sysBean.mcodevalue));
      catch (_) {
        prefs.setInt(TablesColumnFile.ISBIOMETRICNEEDED, 0);
      }
    }
    try {
      await setCustomerTabDisplay();
    } catch (_) {}

    if (fromPage != "login") {
      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get().getSystemParameter('23', 0);
      print("Getting IS VPN Code");
      prefs.setInt(TablesColumnFile.ISVPN, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(TablesColumnFile.ISVPN, int.parse(sysBean.mcodevalue));
        }
        //prefs.setInt(TablesColumnFile.ISBIOMETRICNEEDED, int.parse(sysBean.mcodevalue));
        catch (_) {
          prefs.setInt(TablesColumnFile.ISVPN, 0);
        }
      }
      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.ISADDDESC, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(
              TablesColumnFile.ISADDDESC, int.parse(sysBean.mcodevalue));
        } catch (_) {
          prefs.setInt(TablesColumnFile.ISADDDESC, 0);
        }
      }

      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.lHMinFingCount, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(
              TablesColumnFile.lHMinFingCount, int.parse(sysBean.mcodevalue));
        } catch (_) {
          prefs.setInt(TablesColumnFile.lHMinFingCount, 0);
        }
      }

      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.rHMinFingCount, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(
              TablesColumnFile.rHMinFingCount, int.parse(sysBean.mcodevalue));
        } catch (_) {
          prefs.setInt(TablesColumnFile.rHMinFingCount, 0);
        }
      }

      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.currentAddressCode, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(TablesColumnFile.currentAddressCode,
              int.parse(sysBean.mcodevalue));
        } catch (_) {
          prefs.setInt(TablesColumnFile.currentAddressCode, 0);
        }
      }
      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.misIndividual, 0);
      prefs.setString(TablesColumnFile.misIndividual, "0");
      if (sysBean != null) {
        prefs.setString(TablesColumnFile.misIndividual, sysBean.mcodevalue);
      }

      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.resAddCode, 0);
      prefs.setInt(TablesColumnFile.resAddCode, 1);
      if (sysBean != null) {
        try {
          prefs.setInt(
              TablesColumnFile.resAddCode, int.parse(sysBean.mcodevalue));
        } catch (_) {}
      }

      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.businessAddCode, 0);
      prefs.setInt(TablesColumnFile.businessAddCode, 1);
      if (sysBean != null) {
        try {
          prefs.setInt(
              TablesColumnFile.businessAddCode, int.parse(sysBean.mcodevalue));
        } catch (_) {}
      }

      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.ISFULLERTON, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(
              TablesColumnFile.ISFULLERTON, int.parse(sysBean.mcodevalue));
        } catch (_) {
          prefs.setInt(TablesColumnFile.ISFULLERTON, 0);
        }
      }
      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.ISONLYLONGNAME, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(
              TablesColumnFile.ISONLYLONGNAME, int.parse(sysBean.mcodevalue));
        } catch (_) {
          prefs.setInt(TablesColumnFile.ISONLYLONGNAME, 0);
        }
      }

      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.AGEVALIDATION, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          List listValue;
          if (sysBean.mcodevalue != null && sysBean.mcodevalue != "null") {
            listValue = sysBean.mcodevalue.split("~");
          }

          try {
            prefs.setInt(
                TablesColumnFile.AGEVALIDATIONMIN, int.parse(listValue[0]));
          } catch (_) {}

          try {
            prefs.setInt(
                TablesColumnFile.AGEVALIDATIONMAX, int.parse(listValue[1]));
          } catch (_) {}
        } catch (_) {
          prefs.setInt(TablesColumnFile.AGEVALIDATION, 0);
        }
      }
      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.SpouseDeclarationTab, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          if (int.parse(sysBean.mcodevalue) == 0) {
            isSpouseTabNeeded = false;
          } else {
            isSpouseTabNeeded = true;
          }
        } catch (_) {
          prefs.setInt(TablesColumnFile.SpouseDeclarationTab, 0);
        }
      }

      sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.NIDDEFAULTTYPE, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(
              TablesColumnFile.NIDDEFAULTTYPE, int.parse(sysBean.mcodevalue));
        } catch (_) {
          prefs.setInt(TablesColumnFile.NIDDEFAULTTYPE, 0);
        }
      }

      try {
        await setCustomerTabDisplay();
      } catch (_) {}
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.rsfLbrCodes, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setString(TablesColumnFile.rsfLbrCodes, sysBean.mcodevalue);
      } catch (_) {
        prefs.setString(TablesColumnFile.rsfLbrCodes, "");
      }
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.chargesCodes, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setString(TablesColumnFile.chargesCodes, sysBean.mcodevalue);
      } catch (_) {
        prefs.setString(TablesColumnFile.chargesCodes, "");
      }
    }
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.MANDATORYCOLOR, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        print("Print statment annd fat gya colors mai ${sysBean.mcodevalue}");
        if (sysBean.mcodevalue != null) {
          int color = int.parse(sysBean.mcodevalue);
          mandatoryColor = Color(color);
          semiMandatoryColor = Color(color);
        }
      } catch (_) {
        print("Print statment annd fat gya colors mai ");
      }
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.PROJECTCODE, 0);
    if (sysBean != null) {
      prefs.setString(TablesColumnFile.PROJECTCODE, sysBean.mcodevalue);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.ISDEDUPREQUIRED, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(
            TablesColumnFile.ISDEDUPREQUIRED, int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.ISDEDUPREQUIRED, 0);
      }
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.ContactNo, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setString(TablesColumnFile.ContactNo, sysBean.mcodevalue);
      } catch (_) {
        prefs.setInt(TablesColumnFile.ContactNo, 0);
      }
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.PrintingCode, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(
            TablesColumnFile.PrintingCode, int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.PrintingCode, 0);
      }
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.HIDESHOWPASSWORDFIELD, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(TablesColumnFile.HIDESHOWPASSWORDFIELD,
            int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.HIDESHOWPASSWORDFIELD, 0);
      }
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.AUTOLOGOUTPERIOD, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(
            TablesColumnFile.AUTOLOGOUTPERIOD, int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.AUTOLOGOUTPERIOD, 0);
      }
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.IFVIDEONEDED, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(
            TablesColumnFile.IFVIDEONEDED, int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.IFVIDEONEDED, 0);
      }
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.GUARANTORAPPLICANTTYPE, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(TablesColumnFile.GUARANTORAPPLICANTTYPE,
            int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.GUARANTORAPPLICANTTYPE, 0);
      }
    }

sysBean = new SystemParameterBean();
      sysBean = await AppDatabase.get()
          .getSystemParameter(TablesColumnFile.LOANCYCLETYPE, 0);
      if (sysBean != null && sysBean.mcodevalue != null) {
        try {
          prefs.setInt(
              TablesColumnFile.LOANCYCLETYPE, int.parse(sysBean.mcodevalue));
        } catch (_) {
          prefs.setInt(TablesColumnFile.LOANCYCLETYPE, 1);
        }
      }


          sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.GUARANTORAGEVALIDATION, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setString(TablesColumnFile.GUARANTORAGEVALIDATION, sysBean.mcodevalue);
      } catch (_) {
        prefs.setString(TablesColumnFile.GUARANTORAGEVALIDATION,"");
      }
    }



        sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.DISBBIOMETRICCHECKNEEDED, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(TablesColumnFile.DISBBIOMETRICCHECKNEEDED, int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.DISBBIOMETRICCHECKNEEDED,1);
      }
    }
    else{
       prefs.setInt(TablesColumnFile.DISBBIOMETRICCHECKNEEDED,1);
    }


    
        sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.STOPOVERPAYMENT, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(TablesColumnFile.STOPOVERPAYMENT, int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.STOPOVERPAYMENT,0);
      }
    }
    else{
       prefs.setInt(TablesColumnFile.STOPOVERPAYMENT,0);
    }



     sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.CGT1LEADNEEDED, 0);
    if (sysBean != null && sysBean.mcodevalue != null) {
      try {
        prefs.setInt(TablesColumnFile.CGT1LEADNEEDED, int.parse(sysBean.mcodevalue));
      } catch (_) {
        prefs.setInt(TablesColumnFile.CGT1LEADNEEDED,0);
      }
    }
    else{
       prefs.setInt(TablesColumnFile.CGT1LEADNEEDED,0);
    }

  sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get().getSystemParameter(TablesColumnFile.PRINTHEADER ,0);
    print("Setting System parameter for printing header");
    prefs.setString(TablesColumnFile.PRINTHEADER, "");
    try{
      if (sysBean != null && sysBean.mcodevalue != null) {
      prefs.setString(TablesColumnFile.PRINTHEADER, sysBean.mcodevalue);
    }else{
      prefs.setString(TablesColumnFile.PRINTHEADER, "");
    }
    }catch(_){
      prefs.setString(TablesColumnFile.PRINTHEADER, "");
    }
    
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.LOANCYCLELIMIT, 0);
    print("Setting System parameter for printing header");
    prefs.setString(TablesColumnFile.NONMFIIDS, "");
    try {
      if (sysBean != null && sysBean.mcodevalue != null) {
        prefs.setString(TablesColumnFile.NONMFIIDS, sysBean.mcodevalue);
      } else {
        prefs.setString(TablesColumnFile.NONMFIIDS, "");
      }
    } catch (_) {
      prefs.setString(TablesColumnFile.NONMFIIDS, "");
    }


    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.CURCD, 0);
    print("Setting System parameter for printing header");
    prefs.setString(TablesColumnFile.CURCD, "");
    try {
      if (sysBean != null && sysBean.mcodevalue != null) {
        prefs.setString(TablesColumnFile.CURCD, sysBean.mcodevalue);
      } else {
        prefs.setString(TablesColumnFile.CURCD, "");
      }
    } catch (_) {
      prefs.setString(TablesColumnFile.CURCD, "");
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.PATHTRACEAFTERMINUTES, 0);
    print("Setting System parameter for printing header");
    prefs.setInt(TablesColumnFile.PATHTRACEAFTERMINUTES, 10);
    try {
      if (sysBean != null && sysBean.mcodevalue != null) {
        prefs.setInt(TablesColumnFile.PATHTRACEAFTERMINUTES, int.parse(sysBean.mcodevalue));
      } else {
        prefs.setInt(TablesColumnFile.PATHTRACEAFTERMINUTES, 10);
      }
    } catch (_) {
      prefs.setInt(TablesColumnFile.PATHTRACEAFTERMINUTES, 10);
    }

    sysBean = new SystemParameterBean();
    sysBean =
        await AppDatabase.get().getSystemParameter(TablesColumnFile.TRNSMSG, 0);
    //print("Setting System parameter for printing header");
    prefs.setInt(TablesColumnFile.TRNSMSG, 0);
    try {
      if (sysBean != null && sysBean.mcodevalue != null) {
        prefs.setInt(TablesColumnFile.TRNSMSG, int.parse(sysBean.mcodevalue));
      } else {
        prefs.setInt(TablesColumnFile.TRNSMSG, 0);
      }
    } catch (_) {
      prefs.setInt(TablesColumnFile.TRNSMSG, 0);
    }

    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.PROSPECTVALIDITYDAYS, 0);
    //print("Setting System parameter for printing header");
    prefs.setInt(TablesColumnFile.PROSPECTVALIDITYDAYS, 0);
    try {
      if (sysBean != null && sysBean.mcodevalue != null) {
        prefs.setInt(TablesColumnFile.PROSPECTVALIDITYDAYS,
            int.parse(sysBean.mcodevalue));
      } else {
        prefs.setInt(TablesColumnFile.PROSPECTVALIDITYDAYS, 0);
      }
    } catch (_) {
      prefs.setInt(TablesColumnFile.PROSPECTVALIDITYDAYS, 0);
    }
    sysBean = new SystemParameterBean();
    sysBean = await AppDatabase.get()
        .getSystemParameter(TablesColumnFile.LEADVALIDITYDAYS, 0);
    //print("Setting System parameter for external agent group code");
    prefs.setString(TablesColumnFile.LEADVALIDITYDAYS, TablesColumnFile.FALCON);
    try {
      if (sysBean != null && sysBean.mcodevalue != null) {
        prefs.setInt(TablesColumnFile.LEADVALIDITYDAYS,
            int.parse(sysBean.mcodevalue.trim()));
      } else {
        prefs.setInt(TablesColumnFile.LEADVALIDITYDAYS, 60);
      }
    } catch (_) {
      prefs.setInt(TablesColumnFile.LEADVALIDITYDAYS, 60);
    }
  }

  static setCustomerTabDisplay() async {
    for (int tabNo = 1; tabNo < 15; tabNo++) {
      // int tabPos = tabNo+1;
      await AppDatabase.get()
          .getSystemParameter('ISCUSTTAB' + tabNo.toString(), 0)
          .then((onValue) {
        //print("tabNo"+tabNo.toString());
        // print("'ISCUSTTAB'+tabPos.toString()"+'ISCUSTTAB'+tabNo.toString());
        if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "1") {
          if (tabNo == 1) isCustTab1Show = false;
          if (tabNo == 2) isCustTab2Show = false;
          if (tabNo == 3) isCustTab3Show = false;
          if (tabNo == 4) isCustTab4Show = false;
          if (tabNo == 5) isCustTab5Show = false;
          if (tabNo == 6) isCustTab6Show = false;
          if (tabNo == 7) isCustTab7Show = false;
          if (tabNo == 8) isCustTab8Show = false;
          if (tabNo == 9) isCustTab9Show = false;
          if (tabNo == 10) isCustTab10Show = false;
          if (tabNo == 11) isCustTab11Show = false;
          if (tabNo == 12) isCustTab12Show = false;
          if (tabNo == 13) isCustTab13Show = false;
          if (tabNo == 14) isCustTab14Show = false;
        }
      });
    }
  }


  static setHomeTabsToDisplay() async {

      await AppDatabase.get()
          .getSystemParameter('ISGRAPHTAB' , 0)
          .then((onValue) {
        //print("tabNo"+tabNo.toString());
        // print("'ISCUSTTAB'+tabPos.toString()"+'ISCUSTTAB'+tabNo.toString());
        if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "1") {
          isGraphTabShow = true;
        }
        else if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "0") {
          isGraphTabShow = false;
        }
      });
      await AppDatabase.get()
          .getSystemParameter('ISDASHBOARDTAB' , 0)
          .then((onValue) {
        //print("tabNo"+tabNo.toString());
        // print("'ISCUSTTAB'+tabPos.toString()"+'ISCUSTTAB'+tabNo.toString());
        if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "1") {
          isDashBoardTabShow = true;
        }
        else if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "0") {
          isDashBoardTabShow = false;
        }
      });

      await AppDatabase.get()
          .getSystemParameter('ISMAPTAB' , 0)
          .then((onValue) {
        //print("tabNo"+tabNo.toString());
        // print("'ISCUSTTAB'+tabPos.toString()"+'ISCUSTTAB'+tabNo.toString());
        if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "1") {
          isMapTabShow = true;
        }
        else if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "0") {
          isMapTabShow = false;
        }

      });

      await AppDatabase.get()
          .getSystemParameter('ISTODOTAB' , 0)
          .then((onValue) {
        //print("tabNo"+tabNo.toString());
        // print("'ISCUSTTAB'+tabPos.toString()"+'ISCUSTTAB'+tabNo.toString());
        if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "1") {
          isToDoTabShow = true;
        }
        else if (onValue != null &&
            onValue.mcodevalue != null &&
            onValue.mcodevalue.trim() != '' &&
            onValue.mcodevalue.trim() == "0") {
          isToDoTabShow = false;
        }
      });


  }

  static syncingUserAccessRightsData(username, usrGrpCode) async {
    //if(Constant.syncLoanCycleParameterSecondary.contains(22)){
    var syncingUserAccessRights = new SyncingUserAccessRights();
    List<UserRightBean> userRightBeanList = new List<UserRightBean>();
    try {
      await syncingUserAccessRights
          .getUserRightBean(username, usrGrpCode)
          .then((onValue) {
        print(onValue.length);
        userRightBeanList = onValue;
      });
      await AppDatabase.get()
          .deletSomeSyncingActivityFromOmni('User_Rights_table');
      for (int i = 0; i < userRightBeanList.length; i++) {
        await AppDatabase.get().updateUserRightsMaster(userRightBeanList[i]);
      }
    } catch (_) {}
  }

  static getAccessRights(UserRightBean beanGet) async {
    print("DASHBOARD MENUS");
    gridDashBoardMenus = List<UserRightBean>();
    loanDashBoardMenus = List<UserRightBean>();
    savingsDashBoardMenus = List<UserRightBean>();
    adminDashBoardModules = List<UserRightBean>();
    await AppDatabase.get()
        .getUserRights(beanGet, "GRIDDASHBOARD")
        .then((onvalue) {
      // for (int addMenus = 0; addMenus < onvalue.length; addMenus++) {
      gridDashBoardMenus.addAll(onvalue);
      // }
    }).then((onValue) {});
    await AppDatabase.get()
        .getUserRights(beanGet, 'LOANDASHBOARD')
        .then((onvalue) {
      // for (int addMenus = 0; addMenus < onvalue.length; addMenus++) {

      print("onvalue is ${onvalue}");
      loanDashBoardMenus.addAll(onvalue);
      // }
    }).then((onValue) {});

    await AppDatabase.get()
        .getUserRights(beanGet, 'SAVINGSDASHBOARD')
        .then((onvalue) {
      // for (int addMenus = 0; addMenus < onvalue.length; addMenus++) {

      print("onvalue is ${onvalue}");
      savingsDashBoardMenus.addAll(onvalue);
      // }
    }).then((onValue) {});


      await AppDatabase.get()
        .getUserRights(beanGet, 'ADMINTABDASHBOARD')
        .then((onvalue) {
      // for (int addMenus = 0; addMenus < onvalue.length; addMenus++) {

      print("ye vali value aa rahi hai ${onvalue}");
      adminDashBoardModules.addAll(onvalue);
      // }
    }).then((onValue) {});


  await AppDatabaseExtended.get().updatedefaultColorPalleteTable();
    //await AppDatabaseExtended.get().updateDefaultchartFavouriteType();
   await AppDatabaseExtended.get().getSelectedColor().then((ColorPalleteBean val){
     loadColorPallete(val);
   });

  }


  static loadColorPallete(ColorPalleteBean beanGet) async {

    if(beanGet.appbar!=null){
      globals.appbar = beanGet.appbar;}
    else{
      globals.appbar = null;
    }

    if(beanGet.subappbar!=null){
    globals.subappbar = beanGet.subappbar;}
    else{
      globals.subappbar =null;
    }

    if(beanGet.appbaricon!=null){
    globals.appbaricon = beanGet.appbaricon ;}
    else{
      globals.appbaricon =null;
    }

    if(beanGet.subappbaricon!=null){
    globals.subappbaricon = beanGet.subappbaricon;}
    else{
      globals.subappbaricon =null;
    }

    if(beanGet.appbartext!=null){
    globals.appbartext = beanGet.appbartext ;}
    else{
      globals.appbartext =null;
    }

    if(beanGet.subappbartext!=null){
    globals.subappbartext = beanGet.subappbartext ;}
    else{
      globals.subappbartext =null;
    }

    if(beanGet.icon!=null){
    globals.icon = beanGet.icon ;}
    else{
      globals.icon =null;
    }

    if(beanGet.chrtnavbtn!=null){
    globals.chrtnavbtn= beanGet.chrtnavbtn  ;
    }
    else{
      globals.chrtnavbtn =null;
    }

    if(beanGet.chrttitle!=null){
    globals.chrttitle = beanGet.chrttitle ;}
    else{
      globals.chrttitle = null;
    }

    if(beanGet.chrttitleborder!=null)
    globals.chrttitleborder = beanGet.chrttitleborder ;
    else{
      globals.chrttitleborder =null;
    }






  }
  static var formatter = new DateFormat('dd/MM/yyyy');
  static seySyncedUserMaster() async {
    var syncingMenusMaster = new SyncingMenusMaster();
    List<MenuMasterBean> menuMasterBean = new List<MenuMasterBean>();
    await syncingMenusMaster.getMenuMasterBean().then((onValue) {
      print(onValue.length);
      menuMasterBean = onValue;
    });
    await AppDatabase.get().deletSomeSyncingActivityFromOmni('MENUS_MASTER');
    for (int i = 0; i < menuMasterBean.length; i++) {
      await AppDatabase.get().updateMenuMaster(menuMasterBean[i]);
    }
  }

  static Future<List<TimelineModel>> generateeTimlineList(BuildContext context,
      List<LoanLevel> loanLevelList, CustomerLoanDetailsBean loanObject) async {
    listWorkflow = new List<TimelineModel>();
    // globals.globalCashFlowObject  =  await AppDatabase.get().getCashFlowAnalysis(loanObject.trefno,loanObject.mrefno);

    /* CustomerLoanCPVBusinessRecordBean  cpvCashFlowObj =  await AppDatabase.get().getLoanCPVValues(loanObject.trefno,loanObject.mrefno);
    print("returned cpvCashFlowObj " +cpvCashFlowObj.toString());
    globals.globalCPVBusinessObject = cpvCashFlowObj;*/

    /*SocialAndEnvironmentalBean  socialCashFlowObj =  await AppDatabase.get().getSocialAndEnvValues(loanObject.trefno,loanObject.mrefno);
    print("returned socialCashFlowObj " +socialCashFlowObj.toString());
    globals.globalSocialAndEnvObject = socialCashFlowObj;*/

    /*DeviationFormBean  deviationCashFlowObj =  await AppDatabase.get().getDeviationFormValues(loanObject.trefno,loanObject.mrefno);
    print("returned deviationCashFlowObj " +deviationCashFlowObj.toString());
    globals.globalDeviationFormObject = deviationCashFlowObj;*/

    /* TradeAndNeighbourRefCheckBean  tradeCashFlowObj =  await AppDatabase.get().getTradeAndNeighValues(loanObject.trefno,loanObject.mrefno);
    print("returned tradeCashFlowObj " +tradeCashFlowObj.toString());
    globals.globalTradeAndNeigObject = tradeCashFlowObj;*/

    //globals.globalKycMasterObj = await AppDatabase.get().getKycMasterObj(loanObject.trefno,loanObject.mrefno);

    print(globals.globalKycMasterObj);

    bool positionHolderBool = true;

    for (LoanLevel loanLevel in loanLevelList) {
      TimelineModel model;
      if (loanLevel.mbuttonid == 1) {
        model = TimelineModel(
            generaateTimemline(
                context,
                loanObject.mrefno,
                loanObject.trefno,
                loanObject.mprdacctid,
                loanObject.mleadsid,
                loanLevel.mbuttonid,
                loanLevel.mbuttonname,
                loanLevel.mismandatory,
                loanObject),
            position: positionHolderBool
                ? TimelineItemPosition.left
                : TimelineItemPosition.right,
            icon: Icon(
              Icons.check,
              color: Colors.green,
            ));
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      } else if (loanLevel.mbuttonid == 2) {
        model = TimelineModel(
          generaateTimemline(
              context,
              loanObject.mrefno,
              loanObject.trefno,
              loanObject.mprdacctid,
              loanObject.mleadsid,
              loanLevel.mbuttonid,
              loanLevel.mbuttonname,
              loanLevel.mismandatory,
              loanObject),
          position: positionHolderBool
              ? TimelineItemPosition.left
              : TimelineItemPosition.right,
        );
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      } else if (loanLevel.mbuttonid == 3) {
        model = TimelineModel(
          generaateTimemline(
              context,
              loanObject.mrefno,
              loanObject.trefno,
              loanObject.mprdacctid,
              loanObject.mleadsid,
              loanLevel.mbuttonid,
              loanLevel.mbuttonname,
              loanLevel.mismandatory,
              loanObject),
          position: positionHolderBool
              ? TimelineItemPosition.left
              : TimelineItemPosition.right,
        );
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      } else if (loanLevel.mbuttonid == 4) {
        model = TimelineModel(
          generaateTimemline(
              context,
              loanObject.mrefno,
              loanObject.trefno,
              loanObject.mprdacctid,
              loanObject.mleadsid,
              loanLevel.mbuttonid,
              loanLevel.mbuttonname,
              loanLevel.mismandatory,
              loanObject),
          position: positionHolderBool
              ? TimelineItemPosition.left
              : TimelineItemPosition.right,
        );
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      } else if (loanLevel.mbuttonid == 5) {
        model = TimelineModel(
          generaateTimemline(
              context,
              loanObject.mrefno,
              loanObject.trefno,
              loanObject.mprdacctid,
              loanObject.mleadsid,
              loanLevel.mbuttonid,
              loanLevel.mbuttonname,
              loanLevel.mismandatory,
              loanObject),
          position: positionHolderBool
              ? TimelineItemPosition.left
              : TimelineItemPosition.right,
        );
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      } else if (loanLevel.mbuttonid == 6) {
        model = TimelineModel(
          generaateTimemline(
              context,
              loanObject.mrefno,
              loanObject.trefno,
              loanObject.mprdacctid,
              loanObject.mleadsid,
              loanLevel.mbuttonid,
              loanLevel.mbuttonname,
              loanLevel.mismandatory,
              loanObject),
          position: positionHolderBool
              ? TimelineItemPosition.left
              : TimelineItemPosition.right,
        );
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      } else if (loanLevel.mbuttonid == 7) {
        model = TimelineModel(
          generaateTimemline(
              context,
              loanObject.mrefno,
              loanObject.trefno,
              loanObject.mprdacctid,
              loanObject.mleadsid,
              loanLevel.mbuttonid,
              loanLevel.mbuttonname,
              loanLevel.mismandatory,
              loanObject),
          position: positionHolderBool
              ? TimelineItemPosition.left
              : TimelineItemPosition.right,
        );
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      } else if (loanLevel.mbuttonid == 8) {
        DateTime lastUpdtDate;

        //lastUpdtDate = globals.globalCashFlowObject.mlastupdatedt==null?DateTime.now():globals.globalCashFlowObject.mlastupdatedt;

        model = TimelineModel(
          generaateTimemline(
              context,
              loanObject.mrefno,
              loanObject.trefno,
              loanObject.mprdacctid,
              loanObject.mleadsid,
              loanLevel.mbuttonid,
              loanLevel.mbuttonname,
              loanLevel.mismandatory,
              loanObject,
              DateTime.now()),
          position: positionHolderBool
              ? TimelineItemPosition.left
              : TimelineItemPosition.right,
        );
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      } else if (loanLevel.mbuttonid == 9) {
        model = TimelineModel(
          generaateTimemline(
              context,
              loanObject.mrefno,
              loanObject.trefno,
              loanObject.mprdacctid,
              loanObject.mleadsid,
              loanLevel.mbuttonid,
              loanLevel.mbuttonname,
              loanLevel.mismandatory,
              loanObject),
          position: positionHolderBool
              ? TimelineItemPosition.left
              : TimelineItemPosition.right,
        );
        listWorkflow.add(model);
        positionHolderBool = (!positionHolderBool);
      }
    }

    return listWorkflow;
  }

  static List<TimelineModel> listWorkflow = new List<TimelineModel>();
  static Widget generaateTimemline(
      BuildContext context,
      int mrefno,
      int trefno,
      String mprcdaccid,
      String leadId,
      int forWhat,
      String buttonName,
      int isMandatory,
      CustomerLoanDetailsBean loanObject,
      [DateTime lastUpdatedt]) {
    return new Container(
        //width: MediaQuery.of(context).size.width,
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
      onTap: () async {
        Constant.openOnBasesOfMenuId(context, mrefno, trefno, mprcdaccid,
            leadId, forWhat, buttonName, loanObject);
      },
      child: new Card(
        color: isMandatory == 1 ? mandatoryColor : Colors.yellow[50],
        elevation: 5.0,
        child: new ListTile(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(buttonName, style: TextStyle(fontSize: 20.0)),
              ],
            ),

            /* Text(buttonName),*/
            subtitle: new Column(
              children: <Widget>[
                SizedBox(
                  height: 18.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.calendar_today,
                            color: Colors.green, size: 18.0),
                        new Text(
                          "${lastUpdatedt == null ? formatter.format(DateTime.now()) : formatter.format(lastUpdatedt)}",
                          style: TextStyle(fontSize: 8.0),
                        )
                      ],
                    ),
                  ],
                )
              ],
            )),
      ),
    ));
  }

  static void openOnBasesOfMenuId(
      BuildContext context,
      int mrefno,
      int trefno,
      String mprcdaccid,
      String leadId,
      int forWhat,
      String buttonName,
      CustomerLoanDetailsBean loanObject) async {
    if (forWhat == 1) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                /* new GuarantorDetails(leadId, mrefno,
                trefno,loanObject)),*/ //When Authorized Navigate to the next screen
                new CollateralList(null, 0, 0)),
      );
    }
    if (forWhat == 2) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new GuarantorDetails(leadId, mrefno, trefno,
                loanObject)), //When Authorized Navigate to the next screen
      );
    }
    if (forWhat == 3) {
      CustomerLoanCPVBusinessRecordBean cpvCashFlowObj = await AppDatabase.get()
          .getLoanCPVValues(loanObject.trefno, loanObject.mrefno);
      print("returned cpvCashFlowObj " + cpvCashFlowObj.toString());
      globals.globalCPVBusinessObject = cpvCashFlowObj;
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CustomerLoanCPVBusinessRecord(
                globals.globalCPVBusinessObject,
                loanObject)), //When Authorized Navigate to the next screen
      );
    }
    if (forWhat == 4) {
      SocialAndEnvironmentalBean socialCashFlowObj = await AppDatabase.get()
          .getSocialAndEnvValues(loanObject.trefno, loanObject.mrefno);
      print("returned socialCashFlowObj " + socialCashFlowObj.toString());
      globals.globalSocialAndEnvObject = socialCashFlowObj;
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new SocialAndEnvironmental(
                globals.globalSocialAndEnvObject,
                loanObject)), //When Authorized Navigate to the next screen
      );
    }
    if (forWhat == 5) {
      globals.globalKycMasterObj = await AppDatabase.get()
          .getKycMasterObj(loanObject.trefno, loanObject.mrefno);
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new KycMaster(globals.globalKycMasterObj,
                loanObject)), //When Authorized Navigate to the next screen
      );
    }
    if (forWhat == 6) {
      TradeAndNeighbourRefCheckBean tradeCashFlowObj = await AppDatabase.get()
          .getTradeAndNeighValues(loanObject.trefno, loanObject.mrefno);
      print("returned tradeCashFlowObj " + tradeCashFlowObj.toString());
      globals.globalTradeAndNeigObject = tradeCashFlowObj;
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new TradeAndNeighbourRefCheck(
                globals.globalTradeAndNeigObject,
                loanObject)), //When Authorized Navigate to the next screen
      );
    }
    if (forWhat == 7) {
      SocialAndEnvironmentalBean socialCashFlowObj = await AppDatabase.get()
          .getSocialAndEnvValues(loanObject.trefno, loanObject.mrefno);
      print("returned socialCashFlowObj " + socialCashFlowObj.toString());
      globals.globalSocialAndEnvObject = socialCashFlowObj;
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new DeviationForm(
                globals.globalDeviationFormObject,
                loanObject)), //When Authorized Navigate to the next screen
      );
    }
    if (forWhat == 8) {
      globals.globalCashFlowObject = await AppDatabase.get()
          .getCashFlowAnalysis(loanObject.trefno, loanObject.mrefno);
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new CustomerLoanCashFlow(
                globals.globalCashFlowObject,
                loanObject)), //When Authorized Navigate to the next screen
      );
    }
    if (forWhat == 9) {
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new GuarantorDetails(leadId, mrefno, trefno,
                loanObject)), //When Authorized Navigate to the next screen
      );
    }
  }

}

