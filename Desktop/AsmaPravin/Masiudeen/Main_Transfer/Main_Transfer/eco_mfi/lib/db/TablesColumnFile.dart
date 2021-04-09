import 'package:intl/intl.dart';

class TablesColumnFile {
  //common

  static final LoginTime = "LoginTime";
  static final agentUserName = "agentUserName";
  static final isDataSynced = "isDataSynced";
  static final CreatedDate = "createdDate";
  static final CreatedBy = "createdBy";
  static final UpdatedBy = "updatedBy";
  static final UpdatedatedDate = "updatedatedDate";
  static final geoLocation = "geoLocation";
  static final geoLongitude = "geoLongitude";
  static final geoLatitude = "geoLatitude";
  static final Title = "title";
  static final startTime = "startTime";
  static final endTime = "endTime";

//UserMaster Table
  static final usrCode = "usrCode";
  static final usrPass = "usrPass";
  static final usrShortName = "usrShortName";
  static final usrName = "usrName";
  static final usrBrCode = "usrBrCode";
  static final regDeviceMacId = "regDeviceMacId";
  static final grpCd = "grpCd";
  static final status = "status";
  static final isCurrentlyLogedIn = "isCurrentlyLogedIn";
  static final usrDesignation = "usrDesignation";
  static final autoLogoutYN = "autoLogoutYN";
  static final autoLogoutAfterSecs = " autoLogoutAfterSecs";
  static final pwdChgForcedYN = "pwdChgForcedYN";
  static final pwdChgPeriodDays = " pwdChgPeriodDays";
  static final maxBadLiPerDay = " maxBadLiPerDay";
  static final maxBadLiPerInst = "maxBadLiPerInst";
  static final lastPwdChgDt = " lastPwdChgDt";
  static final nextPwdChgDt = " nextPwdChgDt";
  static final lastSysLiDt = " lastSysLiDt";
  static final nextSysLiDt = " nextSysLiDt";
  static final badLoginsDt = " badLoginsDt";
  static final noOfBadLogins = "noOfBadLogins";
  static final activeInStn = "activeInStn";
  static final ExtnNo = "extnNo";
  static final IsActive = "isActive";
  static final CustAccessLvl = "custAccessLvl";
  static final emailId = "emailId";
  static final mobile = "mobile";
  static final error = "error";
  static final merrormessage = "merrormessage";
  static final reportingUser = "reportingUser";

//UserMaster Table ends here

  //CenterCreation starts here
  static final centerName = 'centerName';
  static final assignedTo = 'assignedTo';
  static final branch = 'branch';
  static final state = 'state';
  static final districts = 'districts';
  static final subDistricts = 'subDistricts';
  static final villageName = 'villageName';
  static final villagePopulation = 'villagePopulation';
  static final distanceFromBranch = 'distanceFromBranch';
  static final serVeyType = 'serVeyType';

  //CenterCreation ends here

//Group Foundation Starts here
  static final groupNumber = "groupNumber";
  static final branchCode = "branchCode";
  static final centerCode = "centerCode";
  static final groupType = "groupType";
  static final groupRecognitionTestDate = "groupRecognitionTestDate";
  static final GRTApprovedBy = "GRTApprovedBy";
  static final meetingDay = "meetingDay";
  static final loanAmountLimit = "loanAmountLimit";
  static final groupName = "groupName";
  static final groupSize = "groupSize";
  static final branchGroupID = "branchGroupID";

//Group Foundation Ends here

//Credit Bereau Master table
  /*static final adhaarNo = 'AdhaarNo';
  static final aplicantName = 'aplicantName';
  static final contactNo = 'contactNo';
  static final spouseName = 'spouseName';
  static final house = 'house';
  static final street = 'street';
  static final city = 'city';
  static final pinCode = 'pinCode';
  static final DOB = 'DOB';
  static final idType2 = 'idType2';
  static final id2 = 'id2';
  static final nomineeName = 'nomineeName';
  static final nomineeRelation = 'nomineeRelation';
  static final branchId = 'branchId';
  static final kendraId = 'kendraId';
  static final memberId = 'memberId';
  static final queueNo = 'queueNo';
  static final segmentIdentifier = 'segmentIdentifier';

  static final creditRequestType = "creditRequestType";
  static final creditReportTransctionId = "creditReportTransctionId";
  static final creditEnquiryPurposeType = "creditEnquiryPurposeType";
  static final creditEquiryStage = "creditEquiryStage";
  static final allSaved = "allSaved";
  static final creditReportTransactionDateType =
      "creditReportTransactionDateType";
  static final OTP = "OTP";
  static final OTPVerified = "OTPVerified";

  static final prospectStatus = "prospectStatus";*/
  static final mCenterId = 'mcenterid';
  static final mEffectiveDt = 'meffectivedt';
  static final mlbrcode = 'mlbrcode';
  static final mcentername = 'mcentername';
  static final mcrs = 'mcrs';
  static final mareatype = 'mareatype';
  static final mformatndt = 'mformatndt';
  static final mmeetingfreq = 'mmeetingfreq';
  static final mmeetinglocn = 'mmeetinglocn';
  static final mmeetingday = 'mmeetingday';
  static final mcentermthhmm = 'mcentermthhmm';
  static final mcentermtampm = 'mcentermtampm';
  static final mfirstmeetngdt = 'mfirstmeetngdt';
  static final mnextmeetngdt = 'mnextmeetngdt';
  static final mlastmeetngdt = 'mlastmeetngdt';
  static final mrepayfrom = 'mrepayfrom';
  static final mrepayto = 'mrepayto';
  static final mcurrnoOfmembers = 'mcurrnoOfmembers';
  static final mcenterstatus = 'mcenterstatus';

  static final mgroupid = "mgroupid";
  static final mgroupname = "mgroupname";
  static final magentcd = "magentcd";
  static final mcenterid = "mcenterid";
  static final mrefcenterid = "mrefcenterid";
  static final trefcenterid = "trefcenterid";
  static final mGrprecogTestDate = "mgrprecogtestdate";
  static final mMaxGroupMembers = "mmaxgroupmembers";
  static final mMinGroupMembers = "mmingroupmembers";
  static final mgrouptype = "mgrouptype";
  static final mgrtapprovedby = "mgrtapprovedby";
  static final mloanlimit = "mloanlimit ";
  static final meetingday = "meetingday";
  static final mgroupprdcode = "mgroupprdcode";
  static final mgroupgender = "mgroupgender";
  static final trefno = 'trefno';
  static final mrefno = 'mrefno';
  static final loantrefno = 'loantrefno';
  static final loanmrefno = 'loanmrefno';
  //static final mlbrcode= 'mlbrcode';
  static final mqueueno = 'mqueueno';
  static final maadharno = 'maadharno';
  static final mprospectdt = 'mprospectdt';
  static final mnametitle = 'mnametitle';
  static final mprospectname = 'mprospectname';
  static final mmobno = 'mmobno';
  static final mdob = 'mdob';
  static final motpverified = 'motpverified';
  static final mcbcheckstatus = 'mcbcheckstatus';
  static final mprospectstatus = 'mprospectstatus';
  static final madd1 = 'madd1';
  static final madd2 = 'madd2';
  static final madd3 = 'madd3';
  static final mhomeloc = 'mhomeloc';
  static final mareacd = 'mareacd';
  static final mvillage = 'mvillage';
  static final mdistcd = 'mdistcd';
  static final mstate = 'mstate';
  static final mcountrycd = 'mcountrycd';
  static final mpincode = 'mpincode';
  static final mcountryoforigin = 'mcountryoforigin';
  static final mnationality = 'mnationality';
  static final mpanno = 'mpanno';
  static final mProspectStatus = 'mProspectStatus';
  static final mpannodesc = 'mpannodesc';
  static final missynced = 'missynced';
  static final misuploaded = 'misuploaded';
  static final mspousename = 'mspousename';
  static final mspouserelation = 'mspouserelation';
  static final mnomineename = 'mnomineename';
  static final mnomineerelation = 'mnomineerelation';
  static final mcreditenqpurposetype = 'mcreditenqpurposetype';
  static final mcreditequstage = 'mcreditequstage';
  static final mcreditreporttransdatetype = 'mcreditreporttransdatetype';
  static final mcreditreporttransid = 'mcreditreporttransid';
  static final mcreditrequesttype = 'mcreditrequesttype';
  static final mcreateddt = 'mcreateddt';
  static final mcreatedby = 'mcreatedby';
  static final mlastupdatedt = 'mlastupdatedt';
  static final mlastupdateby = 'mlastupdateby';
  static final mgeolocation = 'mgeolocation';
  static final mgeolatd = 'mgeolatd';
  static final mgeologd = 'mgeologd';
  // static final  missync= 'missync';
  static final missynctocoresys = 'missynctocoresys';
  static final mlastsynsdate = 'mlastsynsdate';
  static final mcodetype = "mcodetype";
  static final mcode = "mcode";
  static final mcodedesc = "mcodedesc";
  static final mcodevalue = "mcodevalue";
  static final mfield1value = "mfield1value";
  static final mdatatype = "mdatatype";
  static final mdatalen = "mdatalen";
  static final mcodedatatype = "mcodedatatype";
  static final mcodedatalen = "mcodedatalen";
  static final mdefaultvalue = "mdefaultvalue";
  static final mdatatypedynamicquery = "mdatatypedynamicquery";
  // static final  missynctocoresys= 'missynctocoresys';
  static final cbResultMasterDetails = 'cbResultMasterDetails';
  static final cbLoanDetails = 'cbLoanDetails';
  static final mstreet = 'mstreet';
  static final mhouse = 'mhouse';
  static final mcity = 'mcity';
  static final id1Desc = 'id1Desc';
  static final motp = 'motp';
  static final mroutedto = 'mroutedto';
  static final miscustcreated = "miscustcreated";
  static final mhighmarkchkdt = "mhighmarkchkdt";
  /*static final mcbchkstat = "mcbchkstat";*/

  static final merrordescription = "merrordescription";
  static final mcollectedamt = "mcollectedamt";
  static final mpaybygrpyn = "mpaybygrpyn";
  static final madjfrmexcessactyn = "madjfrmexcessactyn";
  static final mmemattandedyn = "mmemattandedyn";
  static final mIdealbaldate = "mIdealbaldate";
  //static final mprdacctId = "mprdacctId";

//Credit Bereau Master table

  static final maxRowCount = 'maxRowCount';
  static final isUploaded = 'isUploaded';
  static final maxSegmentIdentifier = 'maxSegmentIdentifier';
  /* static final routedTo = 'routedTo';
  static final routedFrom = 'routedFrom';*/
  static final createdBy = 'createdBy';
  static final updatedBy = 'updatedBy';
  static final NOCApprovalStatus = 'NOCApprovalStatus';

//CbResultBean

  /*static final dateOfRequest = "dateOfRequest";
  static final preparedFor = "preparedFor";
  static final dateOfIssue = "dateOfIssue";
  static final reportId = "reportId";
  static final primaryNoOfAccounts = "primaryNoOfAccounts";
  static final primaryNoOfActiveAccounts = "primaryNoOfActiveAccounts";
  static final primaryNoOfOverdueAccounts = "primaryNoOfOverdueAccounts";
  static final primaryCurrentBalance = "primaryCurrentBalance";
  static final secondaryNoOfAccounts = "secondaryNoOfAccounts";
  static final secondaryNoOfActiveAccounts = "secondaryNoOfActiveAccounts";
  static final secondaryNoOfOverdueAccounts = "secondaryNoOfOverdueAccounts";
  static final secondaryCurrentBalance = "secondaryCurrentBalance";
  static final secondarySanctionedAmount = "secondarySanctionedAmount";
  static final customerBankAccountNumber = "customerBankAccountNumber";
  static final IFSC = "customerBankIFSC";
  static final nameOfMfi = "nameOfMfi";
  static final dateReported = "dateReported";
  static final disbursedAmount = "disbursedAmount";
  static final overdueAmount = "overdueAmount";
  static final currentBalance = "currentBalance";
  static final writeOffAmount = "writeOffAmount";
  static final accountType = "accountType";
  static final cbCheckStatus = "cbCheckStatus";
  static final loanDetailSeq = "loanDetailSeq";
  static final nameOfMfI = "nameOfMfI";
  static final isCustomerCreated = "isCustomerCreated";*/

  /* static final  trefno			 = "trefno";
  static final  mrefno			 = "mrefno";
  static final  mcbcheckstatus           			 = "mcbcheckstatus";
 */
  static final mdateofissue = "mdateofissue";
  static final mdateofrequest = "mdateofrequest";
  static final miscustomercreated = "miscustomercreated";
  static final mpreparedfor = "mpreparedfor";
  static final mreportid = "mreportid";
/*  static final  mprimarycurrentbal  			 = "mprimarycurrentbal";
  static final  mprimarynoofaccounts     			 = "mprimarynoofaccounts";
  static final  mprimaryoverdueamount     			 = "mprimaryoverdueamount";
  static final  mprimarynoofactiveacs   			 = "mprimarynoofactiveacs";
  static final  mprimarynoofodaccs       			 = "mprimarynoofodaccs";

  static final  msecondarycurrentbalance 			 = "msecondarycurrentbalance";
  static final  msecondarynoofaccs       			 = "msecondarynoofaccs";
  static final  msecondaryoverdueamount       			 = "msecondaryoverdueamount";
  static final  msecondarynoofactiveaccs 			 = "msecondarynoofactiveaccs";
  static final  msecondarynoofodacs     			 = "msecondarynoofodacs";
  static final  msecondarysanctionedamt  			 = "msecondarysanctionedamt";*/

  static final mothrmficnt = "mothrmficnt";
  static final mothrmficurbal = "mothrmficurbal";
  static final mothrmfiovrdueamt = "mothrmfiovrdueamt";
  static final mothrmfidisbamt = "mothrmfidisbamt";
  static final mtotovrdueaccno = "mtotovrdueaccno";
  static final mmfitotdisbamt = "mmfitotdisbamt";
  static final mmfitotcurrentbal = "mmfitotcurrentbal";
  static final mmfitotovrdueamt = "mmfitotovrdueamt";
  static final mtotcurrentbal = "mtotcurrentbal";
  static final mtotdisbamt = "mtotdisbamt";
  static final mtotovrdueamt = "mtotovrdueamt";
  static final mexpsramt = "mexpsramt";
  static final mcbresultblob = "mcbresultblob";

  static final madhaarno = "madhaarno";
  static final magentusername = "magentusername";
  static final SrNo = "SrNo";
  static final trefsrno = "trefsrno";
  static final mrefsrno = "mrefsrno";
  static final trefresultsrno = "trefresultsrno";
  static final mrefresultsrno = "mrefresultsrno";

  static final maccounttype = "maccounttype";
  static final mcurrentbalance = "mcurrentbalance";
  static final mcustbankacnum = "mcustbankacnum";
  static final mdatereported = "mdatereported";
  static final mdisbursedamount = "mdisbursedamount";
  static final mnameofmfi = "mnameofmfi";
  static final mnocimagestring = "mnocimageString";
  static final moverdueamount = "moverdueamount";
  static final mwriteoffamount = "mwriteoffamount";
  static final maccountNumber = "maccountNumber";
  static final mmfiid = "mmfiid";

  //GroupFoundation

//static final meetingDay = "meeting_day";
//static final meetingDay = "meeting_day";

//Center Foundation

  static final id = "id";
  static final effectiveDate = "effectiveDate";
  static final lbrCode = "lbrCode";

  //static final centerName="centerName";
  static final BrnCenterId = "BrnCenterId";
  static final maxGroup = "maxGroup";
  static final currNoOfGroup = "currNoOfGroup";
  static final maxGroupMember = "maxGroupMember";
  static final add1 = "add1";
  static final add2 = "add2";
  static final area = "area";
  static final landmark = "landmark";
  static final cityCode = "cityCode";
  static final stateCd = "stateCd";
  static final countryCd = "countryCd";
  static final pinCd = "pinCd";
  static final phone1 = "phone1";
  static final fax = "fax";
  static final formatdt = "formatdt";
  static final meetingFreq = "meetingFreq";

  // static final usrCode="usrCode";
  static final meetingloc = "meetingloc";
  static final centerlead = "centerlead";
  static final village = "village";
  static final market = "market";

  // static final meetingDay="meetingDay";
  static final centerMeetingTime = "centerMeetingTime";
  static final centerMeetingHrsMin = "centerMeetingHrsMin";
  static final centerMeetingAmPm = "centerMeetingAmPm";
  static final firstMeetinDt = "firstMeetinDt";
  static final nextMeetingDt = "nextMeetingDt";
  static final adhocNextMeetingDt = "adhocNextMeetingDt";
  static final lastMeetingDt = "lastMeetingDt";
  static final groupNoCnt = "groupNoCnt";
  static final meetingSchedule = "meetingSchedule";
  static final repayFrom = "repayFrom";
  static final repayTo = "repayTo";
  static final areaType = "areaType";
  static final wardNo = "wardNo";
  static final noOfMeetingHelds = "noOfMeetingHelds";
  static final CRSEffcetiveDt = "CRSEffcetiveDt";
  static final CRS = "CRS";
  static final feesAmount = "feesAmount";
  static final feesCrAcctId = "feesCrAcctId";
  static final clusterName = "clusterName";
  static final blockName = "blockName";
  static final distFrmHomeBranch = "distFrmHomeBranch";
  static final sexCode = "sexCode";
  static final samityChairman = "samityChairman";
  static final maxCenterMembers = "maxCenterMembers";
  static final currnoOfMembers = "currnoOfMembers";
  static final villageAdd = "villageAdd";
  static final distCd = "distCd";
  static final centerStatus = "centerStatus";
  static final dropOutDt = "dropOutDt";
  static final dbtrAddMk = "dbtrAddMk";
  static final dbtrAddMb = "dbtrAddMb";
  static final dbtrAddMs = "dbtrAddMs";
  static final dbtrAddMd = "dbtrAddMd";
  static final dbtrAddMt = "dbtrAddMt";
  static final dbtrAddck = "dbtrAddck";
  static final dbtrAddCb = "dbtrAddCb";
  static final dbtrAddCs = "dbtrAddCs";
  static final dbtrAddCd = "dbtrAddCd";
  static final dbtrAddCt = "dbtrAddCt";
  static final dbtrLupdMk = "dbtrLupdMk";
  static final dbtrLupdMb = "dbtrLupdMb";
  static final dbtrLupdMs = "dbtrLupdMs";
  static final dbtrLupdMd = "dbtrLupdMd";
  static final dbtrLupdMt = "dbtrLupdMt";
  static final dbtrLupdck = "dbtrLupdck";
  static final dbtrLupdCb = "dbtrLupdCb";
  static final dbtrLupdCs = "dbtrLupdCs";
  static final dbtrLupdCd = "dbtrLupdCd";
  static final dbtrLupdCt = "dbtrLupdCt";
  static final dbtrTAuthDone = "dbtrTAuthDone";
  static final dbtrRecStat = "dbtrRecStat";
  static final dbtrAuthDone = "dbtrAuthDone";
  static final dbtrAuthNeeded = "dbtrAuthNeeded";
  static final dbtrUpdChekId = "dbtrUpdChekId";
  static final dbtrlhistmNo = "dbtrlhistmNo";
  static final weekNo = "weekNo";
  static final addinfo1 = "addinfo1";
  static final addinfo2 = "addinfo2";
  static final changedManual = "changedManual";
  static final distfromSubOffice = "distfromSubOffice";
  static final postofficeCd = "postofficeCd";
  static final subOfficeCd = "subOfficeCd";
  static final lastmonitringDate = "lastmonitringDate";
  static final lastMonitoringAmPm = "lastMonitoringAmPm";
  static final lastMonitiringHHMM = "lastMonitiringHHMM";
  static final nextmonitringDate = "nextmonitringDate";
  static final nextMonitoringAmPm = "nextMonitoringAmPm";
  static final nextMonitiringHHMM = "nextMonitiringHHMM";
  static final counter = "counter";
  static final refrence = "refrence";

  // static final agentUserName="agentUserName";
  //static final isDataSynced="isDataSynced";

  static final imageType = "imageType";
  static final imageSubType = "imageSubType";
  static final imageString = "imageString";
  static final mImgPath = "mImgPath ";

//CUstomer formation screen

//Customer Details of group etc	//Customer Details of group etc
  static final imageFilePathGlobalCustomerprofilePic =
      "imageFilePathGlobalCustomerprofilePic";
  static final customerNumber = "customerNumberOfTab";
  static final applicationDate = "applicationDate";

  //static final centerName = 	   "centerName" ;
  static final centerNo = "centerNo";
  static final grouopName = "grouopName";
  static final groupNo = "groupNo";

//Customer personal info 1	//Customer personal info 1
  static final personalInfobean1 = "personalInfobean1";
  static final personalInfo1 = "personalInfo1";
  static final applicantName = "applicantName";
  static final firstName = "firstName";
  static final middleName = "middleName";
  static final lastName = "lastName";
  static final applicantDob = "applicantDob";
  static final applicantFatherName = "applicantFatherName";
  static final applicantSpouseName = "applicantSpouseName";
  /* static final loanAgreed = "loanAgreed ";*/
  static final insurance = "insurance";
  static final ifYesThen = "ifYesThen";
  static final gender = "gender";
  static final relegion = "relegion";
  static final maritialStatus = "maritialStatus";
  static final qualification = "qualification";
  static final occupation = "occupation";
  static final caste = "caste";
  static final region = "region";
  static final mhusage = "mhusage";
  static final mhusdob = "mhusdob";
  static final mprofileind = "mprofileind";
  static final mlangofcust = "mlangofcust";
  static final mmainoccupn = "mmainoccupn";
  static final msuboccupn = "msuboccupn";
  static final msecoccupatn = "msecoccupatn";
  static final mmainoccupndesc = "mmainoccupndesc";
  static final msuboccupndesc = "msuboccupndesc";

  //Customer Kyc 1	//Customer Kyc 1
  static final kyc1PassBook1TagPicCustomer = "kyc1PassBook1TagPicCustome";
  static final kyc1PassBook2TagPicCustomer = "kyc1PassBook2TagPicCustome";
  static final kyc1PassBook3TagPicCustomer = "kyc1PassBook3TagPicCustome";
  static final kyc1PassBook4TagPicCustomer = "kyc1PassBook4TagPicCustome";
  static final kyc1AppId1PicTagCustomer = "kyc1AppId1PicTagCustome";
  static final kyc1AppId12PicTagCustomer = "kyc1AppId12PicTagCustome";
  static final kyc1AppId13PicTagCustomer = "kyc1AppId13PicTagCustome";
  static final kyc1AppId2PicTagCustomer = "kyc1AppId2PicTagCustome";
  static final kyc1AppId22PicTagCustomer = "kyc1AppId22PicTagCustome";
  static final kyc1AppId23PicTagCustomer = "kyc1AppId23PicTagCustome";
  static final kyc1AppId24PicTagCustomer = "kyc1AppId24PicTagCustome";
  static final kyc1AppId25PicTagCustomer = "kyc1AppId25PicTagCustome";
  static final kyc1AppId26PicTagCustomer = "kyc1AppId26PicTagCustome";
  static final idType1 = "idType1";

  //static final idType2=	   "idType2";
//kyc details 2	//kyc details 2
  static final addressType = "addressType";
  static final currentAddress = "currentAddress";
  static final district = "district";
  static final thana = "thana";
  static final pin = "pin";
  static final post = "post";
  static final mobileNumber = "mobileNumber";
  static final landLineNumber = "landLineNumber";

//familyDetails	//familyDetails
  static final familyMember = "familyMember";
  static final age = "age";
  static final education = "education";
  static final relationship = "relationship";

  //static final occupation=	   "occupation";
  static final income = "income";
  static final dependent = "dependent";

//socialFinancial Details	//socialFinancial Details
  static final socialFinancial1 = "socialFinancial1";
  static final socialFinancialDetailsBean = "socialFinancialDetailsBean";

  //static final house=	   "house";
  static final construction = "construction";
  static final toilet = "toilet";
  static final bankAccount = "customerBankAccount";
  static final agriculturalLandOwner = "agriculturalLandOwner";
  static final loanFromOtherBankOrPerson = "loanFromOtherBankOrPerson";
  static final customModelsAssetsDetails = "customModelsAssetsDetails";
  static final customModelsSavingsDetails = "customModelsSavingsDetails";

  static final accountNumber = "accountNumber";
  static final customerBankName = "customerBankName";
  static final customerBankBranch = "customerBankBranch";

  //static final branch=	   "branch";
//BorrowingDetails	//BorrowingDetails
  static final loanNumber = "loanNumber";
  static final isChecked = "isChecked";
  static final name = "name";
  static final loanAmount = "loanAmount";
  static final loanDate = "loanDate";
  static final oustandingAmount = "oustandingAmount";
  static final currentLoanWithUs = "currentLoanWithUs";
  static final repayMentDate = "repayMentDate";
  static final loanDetailsloanFromOthers = "loanDetailsloanFromOthers";
  static final borrowingDetailsBean = "borrowingDetailsBean";

// business Details	// business Details
  static final businessDetails = "businessDetails";
  static final businessDetailsBean = "businessDetailsBean";
  static final shopName = "shopName";
  static final businessAddress = "businessAddress";
  static final businessAge = "businessAge";
  static final registrationNumber = "registrationNumber";

//Business CashFLow	//Business CashFLow
  static final businessCashFlow = "businessCashFlow";

//PPI

  static final tPpirefno = "tppirefno";
  static final mPpirefno = "mppirefno";
  static final mitem = "mitem";
  static final mhaveyn = "mhaveyn";
  static final mnoofitems = "mnoofitems";
  static final mweightage = "mweightage";

//Declaration Form	//Declaration Form
  static final imageFilePathGlobalDeclarationFormCustomerSignature =
      "imageFilePathGlobalDeclarationFormCustomerSignature";
  static final imageFilePathGlobalDeclarationFormSpouseSignature =
      "imageFilePathGlobalDeclarationFormSpouseSignature";
  static final accepted = "accepted";

//extra
  static final key = "key";
  static final value = "value";
  static final fieldCaption = "fieldCaption";
  static final desc = "description";
  static final imgPath = "imgPath";

  static final mOccBuisness = "mOccBuisness";
  static final mShopName = "mShopName";
  static final mShpAdd = "mShpAdd";
  static final mYrsInBz = "mYrsInBz";
  static final mregNum = "mregNum";
  static final mid1 = "mid1";
  static final mid2 = "mid2";
  static final mAgricultureType = "mAgricultureType";
  static final mIsMbrGrp = "mIsMbrGrp";
  static final mLoanAgreed = "mLoanAgreed";
  static final mGend = "mGend";
  static final mInsurance = "mInsurance";
  static final mRegion = "mRegion";
  static final mConstruct = "mConstruct";
  static final mToilet = "mToilet";
  //static final mBankAccYN = 			  "mBankAccYN";
  static final mhousBizSp = "mhousBizSp";
  static final mBzRegs = "mBzRegs";
  static final mBzTrnd = "mBzTrnd";
  static final mIdDesc = "middesc";
  static final mcbcheckrprtdt = "mcbcheckrprtdt";
  static final motpvrfdno = "motpvrfdno";

//Customer Formation screen ends

//Product
  static final productId = "productId";
  static final productName = "productName";
  static final ROI = "roi";
  static final moduletype = "moduletype";
  static final toAmount = "toAmount";
  static final currencyCode = "currencyCode";
  static final srNo = "srNo";
  static final purposeId = "purposeId";
  static final purposeName = "purposeName";
  static final purposeDescription = "purposeDescription";
  static final transactionModeId = "transactionModeId";
  static final transactionMode = "transactionMode";
  static final transactionModeDescription = "transactionModeDescription";
  static final customerName = "customerName";
  static final repaymentFrequencyId = "repaymentFrequencyId";

  static final repaymentFrequencyDescription = "repaymentFrequencyDescription";
  static final omniLoanNumber = "omniLoanNumber";
  static final purpose = "purpose";
  static final subPurposeId = "subPurposeId";
  static final subPurpose = "subPurpose";
  static final appliedAmount = "appliedAmount";
  static final disbursmentDate = "disbursmentDate";
  static final repaymentFrequency = "repaymentFrequency";
  static final numOfInstallment = "numOfInstallment";
  static final interestAmount = "interestAmount";
  static final endDate = "endDate";
  static final installmentStartDate = "installmentStartDate";
  static final installmentAmount = "installmentAmount";
  static final approvedAmount = "approvedAmount";
  static final omniCustomerNumber = "omniCustomerNumber";
  static final disbursmentAmount = "disbursmentAmount";
  static final ModeOfCollectionId = "ModeOfCollectionId";
  static final ModeOfCollection = "ModeOfCollection";
  static final ModeOfDisbursmentId = "ModeOfDisbursmentId";
  static final ModeOfDisbursment = "ModeOfDisbursment";

  static var isDataSyncedToCoreSystem = "isDataSyncedToCoreSystem";

  static var customerNumberOfTab = "customerNumberOfTab";
  static var customerNumberOfCore = "customerNumberOfCore";
  static var loanNumberOfTab = "loanNumberOfTab";
  static final DisbursmentStatus = "distbursmentStatus";
  //static final DisbursmentStatus = "DisbursmentStatus";
  static final routeTo = "routeTo";
  static final routeFrom = "routeFrom";

  //LookupTable And sublookup

  static final code = "code";
  static final codeType = "codeType";
  static final codeDescription = "codeDescription";
  static final fieldValue = "fieldValue";
  static final extraFieldForLaterOn = "extraFieldForLaterOn";
//NOC
  static final serialNo = "serialNo";
  static final NOCImageString = "NOCImageString";
  static final createdAt = "createdAt";
  static final updatedAt = "updatedAt";

  //checkListMaster

//static final questionId = "questionId";

  static final loanId = "loanId";

  static final mremarks = "mremarks";

  static final idType3Status = 'idType3Status';
  static final idType2Status = "idType2Status";
  static final idType1Status = "idType1Status";

//SpeedoMeter
  static final startingFromImg = 'startingFromImg';
  static final endingFromImg = 'endingFromImg';
  static final startingPoint = 'startingPoint';
  static final endingPoint = 'endingPoint';
  static final totMeterReading = 'totMeterReading';
  static final effDate = 'effDate';
  static final centreName = 'centreName';
  static final purposeOfLoan = 'purposeOfLoan';
  static final actualUtilization = 'actualUtilization';

  //Country
  static final cntryCd = 'countryId';
  static final countryName = 'countryName';
  static final mcountryid = 'mcountryid';
  static final mcountryname = 'mcountryname';
  static final mloanagreed = "mloanagreed";
  //State
  static final statesID = 'statesID';
  static final stateDesc = 'stateDesc';
  static final mstatecd = 'mstatecd';
  static final mstatedesc = 'mstatedesc';
  //District
  static final distDesc = 'distDesc';
  static final mdistdesc = 'mdistdesc';
  //SubDistrict
  static final placeCd = 'placeCd';
  static final placeCdDesc = 'placeCdDesc';
  static final mplacecd = 'mplacecd';
  static final mplacecddesc = 'mplacecddesc';
  //Area
  static final areaCd = 'areaCd';
  static final areaDesc = 'areaDesc';
  static final mareadesc = 'mareadesc';
  //After restructure common
  static final tTabelDesc = "tTabelDesc";
  static final tlastSyncedFromTab = "tlastSyncedFromTab";
  static final tlastSyncedToTab = "tlastSyncedToTab";

  /*static final mlastsynsdate="mlastsynsdate";*/
  //customer
  static final mcusttrefno = "mcusttrefno";
  static final mcustmrefno = "mcustmrefno";
  static final mcustno = "mcustno";
  static final mgroupcd = "mgroupcd";
  static final mlongname = "mlongname";
  static final mfathertitle = "mfathertitle";
  static final mfathername = "mfathername";
  static final mspousetitle = "mspousetitle";
  static final mhusbandname = "mhusbandname";
  static final mage = "mage";
  static final mbankacno = "mbankacno";
  static final mbankacyn = "mbankacyn";
  static final mbankifsc = "mbankifsc";
  static final mbanknamelk = "mbanknamelk";
  static final mbankbranch = "mbankbranch";
  static final mcuststatus = "mcuststatus";
  static final mdropoutdate = "mdropoutdate";
  static final mlastmonitoringdate = "mlastmonitoringdate";
  static final mtdsyn = "mtdsyn";
  static final mtdsreasoncd = "mtdsreasoncd";
  static final mtdsfrm15subdt = "mtdsfrm15subdt";
  static final memailId = "memailid";
  static final mcustcategory = "mcustcategory";
  static final mtier = "mtier";
  static final mAdd1 = "madd1";
  static final mAdd2 = "madd2";
  static final mAdd3 = "madd3";
  static final mPinCode = "mpincode";
  static final mCounCd = "mcouncd";
  static final mCityCd = "mcitycd";
  static final mfname = "mfname";
  static final mmname = "mmname";
  static final mlname = "mlname";
  static final mgender = "mgender";
  static final mrelegion = "mrelegion";
  static final mRuralUrban = "mruralurban";
  static final mcaste = "mcaste";
  static final mqualification = "mqualification";
  static final moccupation = "moccupation";
  static final mLandType = "mlandtype";
  static final mLandMeasurement = "mlandmeasurement";
  static final mmaritialStatus = "mmaritialstatus";
  static final mTypeOfId = "mtypeofid";
  static final mid1desc = "mid1desc";
  static final mInsuranceCovYN = "minsurancecovyn";
  static final mTypeofCoverage = "mtypeofcoverage";
  static final misCbCheckDone = "miscbcheckdone";
  //static final merrormessage= "merrormessage";

//Borrowing details
  static final mborrowingrefno = "mborrowingrefno";
  static final tborrowingrefno = "tborrowingrefno";
  static final mnameofborrower = "mnameofborrower";
  static final msource = "msource";
  static final mpurpose = "mpurpose";
  static final mamount = "mamount";
  static final mintrate = "mintrate";
  static final memiamt = "memiamt";
  static final moutstandingamt = "moutstandingamt";
  static final mmemberno = "mmemberno";
  static final mloancycle = "mloancycle";
  static final mloanDate = "mloanDate";
  static final mrepaymentDate = "mrepaymentDate";
  static final mloanwthUs = "mloanwthUs";

//FamilyDetails

  static final mprdCd = "mprdcd";
  static final mmoduletype = "mmoduletype";
  static final mcurCd = "mcurcd";

  static final mfamilyrefno = "mfamilyrefno";
  static final mname = "mname";
  static final mnicno = "mnicno";
  static final meducation = "meducation";
  static final moccuptype = "moccuptype";
  static final mincome = "mincome";
  static final mhealthstatus = "mhealthstatus";
  static final mrelationwithcust = "mrelationwithcust";
  static final maritalstatus = "maritalstatus";
  static final mcontrforhouseexp = "mcontrforhouseexp";
  static final macidntlinsurance = "macidntlinsurance";
  static final mnomineeyn = "mnomineeyn";
  static final tfamilyrefno = "tfamilyrefno";

  //address Details
  static final taddrefno = "taddrefno";
  static final maddressrefno = "maddressrefno";
  static final maddrType = "maddrtype";
  static final maddr1 = "maddr1";
  static final maddr2 = "maddr2";
  static final maddr3 = "maddr3";
  static final mpinCd = "mpincd";
  static final mtel1 = "mtel1";
  static final mtel2 = "mtel2";
  static final mcityCd = "mcitycd";
  static final mfax1 = "mfax1";
  static final mfax2 = "mfax2";
  static final mcountryCd = "mcountrycd";
  static final marea = "marea";
  static final mHouseType = "mhousetype";
  static final mRntLeasAmt = "mrntleasamt";
  static final mRntLeasDep = "mrntleasdep";
  static final mContLeasExp = "mcontleasexp";
  static final mRoofCond = "mroofcond";
  static final mUtils = "mutils";
  static final mAreaType = "mareatype";
  static final mLandmark = "mlandmark";
  static final mYearStay = "myearstay";
  static final mWardNo = "mwardno";
  static final mMobile = "mmobile";
  static final mEmail = "memail";
  static final mPattaName = "mpattaname";
  static final mRelationship = "mrelationship";
  static final mSourceOfDep = "msourceofdep";
  static final mInstAmount = "minstamount";
  static final mToietYN = "mtoietyn";
  static final mNoOfRooms = "mnoofrooms";
  static final mSpouseYearsStay = "mspouseyearsstay";
  static final mDistCd = "mdistcd";
  static final mCookFuel = "mcookfuel";
  static final mSecMobile = "msecmobile";
  static final mrefgroupid = "mrefgroupid";
  static final trefgroupid = "trefgroupid";

//img

  /*static final mImgrefno = "mimgrefno";
  static final tImgrefno = "timgrefno";
*/
  static final mImgrefno = "mimgrefno";
  static final tImgrefno = "timgrefno";
  //static final miscustcreated = "miscustcreated";

  //Extra fields

  static final addressDetails = "addressDetails";
  static final imageMaster = "imageMaster";
  static final borrowingDetails = "borrowingDetails";
  static final familyDetails = "familyDetails";
  static final customerBussDetails = "customerBussDetails";
  static final custBussDetails = "customerBussDetailsCustomerEntity";
  static final businessExpendDetails = "customerBusinessExpenseEntity";
  static final householdExpendDetails = "customerHouseholdExpenseEntity";
  static final assetDetailsList = "customerAssetDetailsEntity";
  static final ppiDetails = "customerPPIDetailsEntity";

  //Business details

  static final mbussdetailsrefno = "mbussdetailsrefno";
  static final tbussdetailsrefno = "tbussdetailsrefno";
  static final mcusactivitytype = "mcusactivitytype";
  static final mbusinessname = "mbusinessname";
  static final mbusaddress1 = "mbusaddress1";
  static final mbusaddress2 = "mbusaddress2";
  static final mbusaddress3 = "mbusaddress3";
  static final mbusaddress4 = "mbusaddress4";
  static final mbuscity = "mbuscity";
  static final mbusstate = "mbusstate";
  static final mbuscountry = "mbuscountry";
  static final mbusarea = "mbusarea";
  static final mbusvillage = "mbusvillage";
  static final mbuslandmark = "mbuslandmark";
  static final mbuspin = "mbuspin";
  static final mbusyrsmnths = "mbusyrsmnths";
  static final mregisteredyn = "mregisteredyn";
  static final mregistrationno = "mregistrationno";
  static final mbusothtomanageabsyn = "mbusothtomanageabsyn";
  static final mbusothmanagername = "mbusothmanagername";
  static final mbusothmanagerrel = "mbusothmanagerrel";
  static final mbusmonthlyincome = "mbusmonthlyincome";
  static final mbusseasonalityjan = "mbusseasonalityjan";
  static final mbusseasonalityfeb = "mbusseasonalityfeb";
  static final mbusseasonalitymar = "mbusseasonalitymar";
  static final mbusseasonalityapr = "mbusseasonalityapr";
  static final mbusseasonalitymay = "mbusseasonalitymay";
  static final mbusseasonalityjun = "mbusseasonalityjun";
  static final mbusseasonalityjul = "mbusseasonalityjul";
  static final mbusseasonalityaug = "mbusseasonalityaug";
  static final mbusseasonalitysep = "mbusseasonalitysep";
  static final mbusseasonalityoct = "mbusseasonalityoct";
  static final mbusseasonalitynov = "mbusseasonalitynov";
  static final mbusseasonalitydec = "mbusseasonalitydec";
  static final mbushighsales = "mbushighsales";
  static final mbusmediumsales = "mbusmediumsales";
  static final mbuslowsales = "mbuslowsales";
  static final mbushighincome = "mbushighincome";
  static final mbusmediumincom = "mbusmediumincom";
  static final mbuslowincome = "mbuslowincome";
  static final mbuslocownership = "mbuslocownership";
  //mbusmonthlytotalEval
  static final mbusmonthlytotaleval = "mbusmonthlytotaleval";
  //mbusmonthlytotalVerif
  static final mbusmonthlytotalverif = "mbusmonthlytotalverif";
  static final mbusincludesurcalcyn = "mbusincludesurcalcyn";
  static final mbusnhousesameplaceyn = "mbusnhousesameplaceyn";
  static final mbusinesstrend = "mbusinesstrend";

  // added for

  static final musrcode = "musrcode";
  static final mcustaccesslvl = "mcustaccesslvl";
  static final mextnno = "mextnno";
  static final mactiveinstn = "mactiveinstn";
  static final mautologoutperiod = "mautologoutperiod";
  static final mautologoutyn = "mautologoutyn";
  static final mbadloginsdt = "mbadloginsdt";
  static final memailid = "memailid";
  static final merror = "merror";
  static final mgrpcd = "mgrpcd";
  static final misloggedinyn = "misloggedinyn";
  static final mlastpwdchgdt = "mlastpwdchgdt";
  static final mlastsyslidt = "mlastsyslidt";
  static final mmaxbadlginperday = "mmaxbadlginperday";
  static final mmaxbadlginperinst = "mmaxbadlginperinst";
  static final mmobile = "mmobile";
  static final mnextpwdchgdt = "mnextpwdchgdt";
  static final mnextsyslgindt = "mnextsyslgindt";
  static final mnoofbadlogins = "mnoofbadlogins";
  static final mpwdchgforcedyn = "mpwdchgforcedyn";
  static final mpwdchgperioddays = "mpwdchgperioddays";
  static final mregdevicemacid = "mregdevicemacid";
  static final mreportinguser = "mreportinguser";
  static final mstatus = "mstatus";
  static final musrbrcode = "musrbrcode";
  static final musrdesignation = "musrdesignation";
  static final musrname = "musrname";
  static final musrpass = "musrpass";
  static final musrshortname = "musrshortname";
  static final mReason = "mreason";
  static final mSusDate = "msusdate";
  static final mJoinDate = "mjoindate";
  static final mTableadsid = "mtableadsid";
  static final mleadsid = "mleadsid";
  static final mcgt1doneby = "mcgt1doneby";
  static final mstarttime = "mstarttime";
  static final mendtime = "mendtime";
  static final mroutefrom = "mroutefrom";
  static final mrouteto = "mrouteto";
  static final mremark = "mremark";
  static final mcgt2doneby = "mcgt2doneby";
  static final mgrtdoneby = "mgrtdoneby";
  static final mquestionid = "mquestionid";
  static final manschecked = "manschecked";
  static final mquestiondesc = "mquestiondesc";
  static final mproctype = "mproctype";
  static final midtype1status = "midtype1status";
  static final midtype2status = "midtype2status";
  static final midtype3status = "midtype3status";
  static final tclcgt1refno = "tclcgt1refno";
  static final mclcgt1refno = "mclcgt1refno";
  static final tclcgt2refno = "tclcgt2refno";
  static final mclcgt2refno = "mclcgt2refno";
  static final tclgrtrefno = "tclgrtrefno";
  static final mclgrtrefno = "mclgrtrefno";
  static final mhouseVerifiImg = "mhouseVerifiImg";
  static final mappldloanamt = "mappldloanamt";
  static final mapprvdloanamt = "mapprvdloanamt";
  static final mloanamtdisbd = "mloanamtdisbd";
  static final mloandisbdt = "mloandisbdt";
  static final mleadstatus = "mleadstatus";
  static final mexpdt = "mexpdt";
  static final minstamt = "minstamt";
  static final minststrtdt = "minststrtdt";
  static final minterestamount = "minterestamount";
  static final mrepaymentmode = "mrepaymentmode";
  static final mmodeofdisb = "mmodeofdisb";
  static final mperiod = "mperiod";
  static final mprdcd = "mprdcd";
  static final mpurposeofLoan = "mpurposeofloan";
  static final mactualutilization = "mactualutilization";
  static final msubpurposeofloan = "msubpurposeofloan";
  static final mprdacctid = "mprdacctid";
  static final mfrequency = "mfrequency";
  static final mprdname = "mprdname";
  static final mcustname = "mcustname";
  static final mpurposeofloandesc = "mpurposeofloandesc";
  static final msubpurposeofloandesc = "msubpurposeofloandesc";
  static final lookupComposite = "lookupComposite";
  static final interestOffsetComposite = "interestOffsetCompositeEntity";
  static final loanCycleParameterSecondaryComposite =
      "loanCycleParameterSecondaryCompositeEntity";
  static final loanCycleParameterPrimaryComposite =
      "loanCycleParameterPrimaryCompositeEntity";
  static final sublookupComposite = "lookupComposieEntity";
  static final productComposieEntity = "productComposieEntity";
  static final mcenterName = "mcentername";
  static final mgroupName = "mgroupname";
  static final mThana = "mThana";
  static final mPost = "mPost";
  static final mApprovalDesc = "mapprovaldesc";
  static final mValidity = "mValidity";

  static final mcurcd = "mcurcd";
  static final minteffdt = "minteffdt";
  static final msrno = "msrno";
  static final mtoamt = "mtoamt";
  static final mmlastsynsdate = "mmlastsynsdate";

  static final mloantype = "mloantype";
  static final meffdate = "meffdate";
  static final mmonths = "mmonths";
  static final mintrestrate = "mintrestrate";

  static final mPrdCd = "mPrdCd";
  static final mcusttype = "mcusttype";
  static final mgrtype = "mgrtype";
  static final mminamount = "mminamount";
  static final mmaxamount = "mmaxamount";
  static final mminperiod = "mminperiod";
  static final mmaxperiod = "mmaxperiod";
  static final mminnoofgrpmems = "mminnoofgrpmems";
  static final mmaxnoofgrpmems = "mmaxnoofgrpmems";
  static final mminage = "mminage";
  static final mmaxage = "mmaxage";
  static final mgrpcycyn = "mgrpcycyn";
  static final mlogic = "mlogic";
  static final mtenor = "mtenor";
  static final mincramount = "mincramount";
  static final mnoofinstlclosure = "mnoofinstlclosure";
  static final mmultiplefactor = "mmultiplefactor";

  static final mruletype = "mruletype";
  static final muptoamount = "muptoamount";

  static final interestSlabCompositeEntity = "interestSlabCompositeEntity";
  static final srno = "srno";
  static final mipaddress = "mipaddress";
  static final mportno = "mportno";
  static final yesno = "yesno";
  static final mactTotbalfcy = "mactTotbalfcy";
  static final mlcytrnamt = "mlcytrnamt";
  static final mdateopen = "mdateopen";
  static final masondate = "masondate";
  static final mdateclosed = "mdateclosed";
  static final macctstat = "macctstat";
  static final mfocode = "mfocode";
  static final midealbaldate = "midealbaldate";
  static final modamt = "modamt";
  static final mcurrentdue = "mcurrentdue";
  static final midealbal = "midealbal";
  static final memino = "memino";
  static final mexpdate = "mexpdate";
  static final mexpprnpaid = "mexpprnpaid";
  static final mexpintpaid = "mexpintpaid";
  static final mpaidprn = "mpaidprn";
  static final mpaidint = "mpaidint";
  static final mprnos = "mprnos";
  static final mintos = "mintos";
  static final mclosint = "mclosint";
  static final mappliedasind = "mappliedasind";
  static final malmeffdate = "malmeffdate";
  static final madjfrmsd = "madjfrmsd";
  static final madjfrmexcss = "madjfrmexcss";
  static final mpaidbygrp = "mpaidbygrp";
  static final mattndnc = "mattndnc";
  static final mcollamt = "mcollamt";

  static final checkListCgt1Details = "checkListCgt1Details";
  static final checkListCgt2Details = "checkListCgt2Details";
  static final checkListGrtDetails = "checkListGrtDetails";

  static final id1 = "id1";
  static final id2 = "id2";
  static final cgt1Bean = "cgt1Bean";
  static final cgt2Bean = "cgt2Bean";
  static final grtBean = "grtBean";
  static final custBean = "custBean";

  //Business and Household Expenditure Detail
  static final tbusinexpendrefno = "tbusinexpendrefno";
  static final mbusinexpenrefno = "mbusinexpenrefno";
  static final mbusinexpntype = "mbusinexpntype";
  static final mbusinevaluationamt = "mbusinevaluationamt";
  static final mhoushldexpntype = "mhoushldexpntype";
  static final mhoushldevaluationamt = "mhoushldevaluationamt";
  static final mmonthlyincome = "mmonthlyincome";
  static final mtotalmonthlyincome = "mtotalmonthlyincome";
  static final mbusinessexpense = "mbusinessexpense";
  static final mhousehldexpense = "mhousehldexpense";
  static final mincomeemiratio = "mincomeemiratio";
  static final mmonthlyemi = "mmonthlyemi";
  static final mnetamount = "mnetamount";
  static final mpercentage = "mpercentage";
  static final thoushldexpendrefno = "thoushldexpendrefno";
  static final mhoushldexpenrefno = "mhoushldexpenrefno";
  //Assest Detail
  static final tassetdetrefno = "tassetdetrefno";
  static final massetdetrefno = "massetdetrefno";

  //detached for wasasas\

  static final mIsProspectNeeded = "mIsProspectNeeded";
  static final mIsProspectRepeatNeeded = "mIsProspectRepeatNeeded";
  static final mCenterRepayFromTo = "mCenterRepayFromTo";

  static final mgrttype = "mgrttype";
  static final mfreezetype = "mfreezetype";
  static final macttotbalfcy = "macttotbalfcy";
  static final mcollectiondate = "mcollectiondate";
  static final mcollectedamount = "mcollectedamount";

  static final mcashflow = "mcashflow";
  static final mentrydate = "mentrydate";
  static final mbatchcd = "mbatchcd";
  static final msetno = "msetno";
  static final mscrollno = "mscrollno";
  static final mtotallienfcy = "mtotallienfcy";
  static final macttotballcy = "macttotballcy";
  static final mbramchname = "mbramchname";
  static final mparticulars = "mparticulars";
  static final mshadowbalance = "mshadowbalance";
  static final mCompanyName = "mCompanyName";
  static final mTdparam = "mTdparam";
  static final mcompanyLogoName = "mcompanyLogoName";
  static final mLoanApprovalLimit = "mLoanApprovalLimit";

  static final newpassword = "newpassword";
  static final FOGrpCode = "FOGrpCode";
  static final BMGrpCode = "BMGrpCode";
  static final ABMGrpCode = "ABMGrpCode";
  static final mdrcr = "mdrcr";

// TermDeposit creation
  static final mcertdate = "mcertdate";
  static final mnoinst = "mnoinst";
  static final mnoofmonths = "mnoofmonths";
  static final mnoofdays = "mnoofdays";
  static final mmatval = "mmatval";
  static final mmatdate = "mmatdate";
  static final mreceiptstatus = "mreceiptstatus";
  static final mlastrepaydate = "mlastrepaydate";
  static final mmainbalfcy = "mmainbalfcy";
  static final mintprvdamtfcy = "mintprvdamtfcy";
  static final mintpaidamtfcy = "mintpaidamtfcy";
  static final mtdsamtfcy = "mtdsamtfcy";
  static final mmodeofdeposit = "mmodeofdeposit";
  static final mnoticetype = "mnoticetype";
  static final msourceoffunds = "msourceoffunds";

  //  Productwise Interest Table - for TD

  static final mdays = "mdays";
  static final mpenalintrate = "mpenalintrate";
  static final mlowertollimit = "mlowertollimit";
  static final muppertollimit = "muppertollimit";
  static final mminrate = "mminrate";
  static final mmaxrate = "mmaxrate";
  static final mfrommonths = "mfrommonths";
  static final mtomonths = "mtomonths";

//Offset Interest Master - for TD

  static final lBrCode = "lBrCode";
  static final prdCd = "prdCd";
  static final CurCd = "CurCd";
  static final acctType = "acctType";
  static final days = "days";
  static final months = "months";
  static final InvAmtFrm = "InvAmtFrm";
  static final UptoAmt = "UptoAmt";
  static final offSetIntRate = "offSetIntRate";
  static final LowerTolLimit = "LowerTolLimit";
  static final UpperTolLimit = "UpperTolLimit";
  static final minvamtfrm = "minvamtfrm";
  static final muptoamt = "muptoamt";
  static final moffsetintrate = "moffsetintrate";
  // static final mlowertollimit = "LowerTolLimit";
  // static final UpperTolLimit = "UpperTolLimit";

  static final loanApprovalLimitComposite = "loanApprovalLimitCompositeEntity";
  static final musercode = "musercd";
  static final mlimitamt = "mlimitamt";
  static final moverduedays = "moverduedays";
  static final mloanacmindrbal = "mloanacmindrbal";
  static final mloanacmincrbal = "mloanacmincrbal";
  static final mwriteoffamat = "mwriteoffamat";
  static final mcheqlimitamt = 'mcheqlimitamt';
  static final mminintrate = "mminintrate";
  static final mmaxintrate = "mmaxintrate";
  static final CGT1toCGT2Gap = "CGT1toCGT2Gap";
  static final CGT2toGRTGap = "CGT1toCGT2Gap";

  static final mmainballcy = "mmainballcy";

  static final mIsGroupLendingNeeded = "mIsGroupLendingNeeded";
  static final mlastopendate = "mlastopendate";
  static final mexcesspaid = "mexcesspaid";
  static final msdbal = "msdbal";
  //Guarantor Details
  static final mapplicanttype = "mapplicanttype";
  static final mexistingcustyn = "mexistingcustyn";
  static final mnameofguar = "mnameofguar";
  static final mrelationsince = "mrelationsince";
  static final mphone = "mphone";
  static final maddress = "maddress";
  static final moccupationtype = "moccupationtype";
  static final mmainoccupation = "mmainoccupation";
  static final mworkexpinyrs = "mworkexpinyrs";
  static final mincomeothsources = "mincomeothsources";
  static final mtotalincome = "mtotalincome";
  static final mhousetype = "mhousetype";
  static final mworkingaddress = "mworkingaddress";
  static final mworkphoneno = "mworkphoneno";
  static final mmothermaidenname = "mmothermaidenname";
  static final mpromissorynote = "mpromissorynote";
  static final mnationalidtype = "mnationalidtype";
  static final mnationalid = "mnationalid";
  static final mnationaliddesc = "mnationaliddesc";
  static final maddress2 = "maddress2";
  static final maddress3 = "maddress3";
  static final maddress4 = "maddress4";
  static final mmaritalstatus = "mmaritalstatus";
  static final mreligioncd = "mreligioncd";
  static final meducationalqual = "meducationalqual";
  static final memailaddr = "memailaddr";
  static final memployername = "memployername";
  static final mdivisiontype = "mdivisiontype";
  static final systemParameterCompositeEntity =
      "systemParameterCompositeEntity";
  static final CENTERCAPTION = "CENTERCAPTION";
  static final GROUPCAPTION = "GROUPCAPTION";
  static final mnoofguaranter = "mnoofguaranter";
  static final mpbrcode = "mpbrcode";
  static final mshortname = "mshortname";
  static final mcitycd = "mcitycd";
  static final mbranchtype = "mbranchtype";
  static final mtele1 = "mtele1";
  static final mtele2 = "mtele2";
  static final mfaxno1 = "mfaxno1";
  static final mswiftaddr = "mswiftaddr";
  static final mpostcode = "mpostcode";
  static final mweekoff1 = "mweekoff1";
  static final mweekoff2 = "mweekoff2";
  static final mparentbrcode = "mparentbrcode";
  static final mbranchtype1 = "mbranchtype1";
  static final mbranchcat = "mbranchcat";
  static final mbrnmanager = "mbrnmanager";
  static final mdistrict = "mdistrict";
  static final mlatitude = "mlatitude";
  static final mlongitude = "mlongitude";
  static final mmingroupmembers = "mmingroupmembers";
  static final mmaxgroupmembers = "mmaxgroupmembers";
  static final mbranchemailid = "mbranchemailid";
  static final mbiccode = "mbiccode";
  static final msector = "msector";
  static final mlegacybrncd = "mlegacybrncd";
  static final mIsGroupNeeded = "mIsGroupNeeded";
  static final tdInterestSlabCompositeEntity = "tdInterestSlabCompositeEntity";
  static final tdOffsetInterestSlabCompositeEntity =
      "tdOffsetInterestSlabCompositeEntity";
  static final maccttype = "maccttype";
  //CIF
  static final mnid = "mnid";
  static final mshadowclearbal = "mshadowclearbal";
  static final mshadowtotalbal = "mshadowtotalbal";
  static final mactualclearbal = "mactualclearbal";
  static final mactualtotalbal = "mactualtotalbal";
  static final mlienamt = "mlienamt";
  static final mmainbal = "mmainbal";
  static final minterestamt = "minterestamt";
  static final mtdsamt = "mtdsamt";
  static final middesc = "middesc";
  static final mreloff = "mreloff";
  static final msexcode = "msexcode";
  //static final mreligioncd = "mreligioncd";
  //static final mmaritalstatus = "mmaritalstatus";
  static final mmailingaddr1 = "mmailingaddr1";
  static final mmailingaddr2 = "mmailingaddr2";
  static final mmailingaddr3 = "mmailingaddr3";
  static final mhomeaddr1 = "mhomeaddr1";
  static final mhomeaddr2 = "mhomeaddr2";
  static final mhomeaddr3 = "mhomeaddr3";
  static final mofficeaddr1 = "mofficeaddr1";
  static final mofficeaddr2 = "mofficeaddr2";
  static final mofficeaddr3 = "mofficeaddr3";
  static final macctstatdesc = "macctstatdesc";
  static final mcrdr = "mcrdr";
  static final mamt = "mamt";
  static final minterestprov = "minterestprov";
  static final minterestpaid = "minterestpaid";
  static final mmaturityvalue = "mmaturityvalue";
  static final mpenalprov = "mpenalprov";
  static final mpenalpaid = "mpenalpaid";
  static final mdisbursedamt = "mdisbursedamt";
  static final mexcessamt = "mexcessamt";
  static final mnarration = "mnarration";
  static final momnitxnrefno = "momnitxnrefno";
  static final mwsenddate = "mwsenddate";
  static final mwseffcontractamt = "mwseffcontractamt";
  static final mwsintamount = "mwsintamount";
  static final mwsidealbal = "mwsidealbal";
  static final mwsopenbal = "mwsopenbal";
  static final mbranchname = "mbranchname";
  // CIF Loan Closure
  static final mloandetailsgrid = "mloandetailsgrid";
  static final mapplicationdt = "mapplicationdt";
  static final mappliedamt = "mappliedamt";
  static final mapproveddt = "mapproveddt";
  static final mapprovedamt = "mapprovedamt";
  static final mstartdt = "mstartdt";
  static final mdisbursementdt = "mdisbursementdt";
  static final mdisbursementamt = "mdisbursementamt";
  static final minstallmentstartdt = "minstallmentstartdt";
  static final minstallmentamt = "minstallmentamt";
  static final minstallmentfrequency = "minstallmentfrequency";
  static final mnoofinstallments = "mnoofinstallments";
  static final mrateofinterest = "mrateofinterest";
  static final menddt = "menddt";
  static final minsurancepremiumamt = "minsurancepremiumamt";
  static final msecuritydetailsgrid = "msecuritydetailsgrid";
  static final msecuritydepositdt = "msecuritydepositdt";
  static final mamtondepositcreation = "mamtondepositcreation";
  static final mcurrentbal = "mcurrentbal";
  static final mexcessbal = "mexcessbal";
  static final mclosuredetailsgrid = "mclosuredetailsgrid";
  static final minterestaccruedtilldt = "minterestaccruedtilldt";
  static final mclosurecharges = "mclosurecharges";
  static final mclosureamtasondate = "mclosureamtasondate";
  static final mwaiveoffamt = "mwaiveoffamt";
  static final mamttobepaidforclosure = "mamttobepaidforclosure";
  static final mtotaloutstandinggrid = "mtotaloutstandinggrid";
  static final mprincipalos = "mprincipalos";
  static final minterestos = "minterestos";
  static final mpenalos = "mpenalos";
  static final motherchargesos = "motherchargesos";
  static final mtotaloutstanding = "mtotaloutstanding";
  static final mtotalpaymentgrid = "mtotalpaymentgrid";
  static final mprincipalpaid = "mprincipalpaid";
  static final motherchargespaid = "motherchargespaid";
  static final mnoofinslpaid = "mnoofinslpaid";
  static final mnoofdefaults = "mnoofdefaults";
  static final mtotalpaid = "mtotalpaid";
  static final mduebutnotpaidgrid = "mduebutnotpaidgrid";
  static final mprincipalosdue = "mprincipalosdue";
  static final minterestosdue = "minterestosdue";
  static final mpenalosdue = "mpenalosdue";
  static final motherchargesosdue = "motherchargesosdue";
  static final mtotaldue = "mtotaldue";
  static final mpaymntmode = "mpaymntmode";
  static final momnimsg = "momnimsg";

  // customer business tab
  static final massets = "massets";
  static final mpresentamt = "mpresentamt";
  static final mnextmonthamount = "mnextmonthamount";
  static final tfixedassetrefno = "tfixedassetrefno";
  static final mfixedassetrefno = "mfixedassetrefno";
  static final mfixedassets = "mfixedassets";
  static final tcurrentassetrefno = "tcurrentassetrefno";
  static final mcurrentassetrefno = "mcurrentassetrefno";
  static final mcurrentassets = "mcurrentassets";
  static final tlngtrmliabiltyrefno = "tlngtrmliabiltyrefno";
  static final mlngtrmliabiltyrefno = "mlngtrmliabiltyrefno";
  static final mlngtrmliabilty = "mlngtrmliabilty";
  static final tshrttrmliabiltyrefno = "tfixedassetrefno";
  static final mshrttrmliabiltyrefno = "mfixedassetrefno";
  static final mshrttrmliabilty = "mshrttrmliabilty";
  static final tequityrefno = "tequityrefno";
  static final mequityrefno = "mequityrefno";
  static final mequity = "mequity";
  static final fixedAssetsList = "fixedAssetsList";
  static final currentAssetsList = "currentAssetsList";
  static final longTermLiabilitiesList = "longTermLiabilitiesList";
  static final shortTermLiabilitiesList = "shortTermLiabilitiesList";
  static final equityList = "equityList";
  static final isCGT2Needed = "isCGT2Needed";
  static final isWASASA = "isWASASA";
  static final maleValidation = "maleValidation";
  static final femaleValidaton = "femaleValidaton";
  static final marriedTitles = "marriedTitles";
  static final isSaiaja = "isSaiaja";

  /* static final mpanplaceofissue = "mpanplaceofissue";
  static final mpanexpdt = "mpanexpdt";
  static final mpanissuedt= "mpanissuedt";

  static final midplaceofissue= "midplaceofissue";
  static final midexpdt= "midexpdt";
  static final midissuedt= "midissuedt";



  this.mcusttype,
  this.mid1placeofissue,
  this.mid1expdate,
  this.mid1issuedate,
  this.mid2placeofissue,
  this.mid2expdate,
  this.mid2issuedate*/

  static final exceptionTitles = "exceptionTitles";
  static final mid1placeofissue = "mid1placeofissue";
  static final mid1expdate = "mid1expdate";
  static final mid1issuedate = "mid1issuedate";
  static final mid2placeofissue = "mid2placeofissue";
  static final mid2issuedate = "mid2issuedate";
  static final mid2expdate = "mid2expdate";
  static final mdropoutreason = "mdropoutreason";

  static final msvngacctrefno = "msvngacctrefno";
  static final msvngaccmrefno = "msvngaccmrefno";
  static final bluetoothAddress = "bluetoothAddress";
  static final dialCode = "dialCode";
  static final ISBIOMETRICNEEDED = "ISBIOMETRICNEEDED";
  static final ISVPN = "ISVPN";
  static final branchname = "branchname";
  //CHARTS mASter Start

  static final mchartid = "mchartid";
  static final mtitle = "mtitle";
  static final mxcatg = "mxcatg";
  static final mycatg = "mycatg";
  static final mzcatg = "mzcatg";
  static final misonline = "misonline";
  static final mquerydesc = "mquerydesc";
  static final mquery = "mquery";
  static final mdefaulttype = "mdefaulttype";
//type

  static final mfilterid = "mfilterid";
  static final mtype = "mtype";
  static final mdatasource = "mdatasource";
  static final mdesc = "mdesc";
  // Bulk Loan Pre-Closure
  static final minststartdt = "minststartdt";
  static final minstlamt = "minstlamt";
  static final mamttocollect = "mamttocollect";
  static final mprincipleos = "mprincipleos";
  static final issubmit = "issubmit";
//Ends
//UtilityBillPayment starts
  static final mutilitymode = "mutilitymode";
  static final mutilitytype = "mutilitytype";
  static final minquirytype = "mdesc";
  static final mutilityprovider = "mutilityprovider";
  static final mnic = "mnic";
  static final mrefrenceno = "mrefrenceno";
  static final mrefrencecnfrm = "mrefrencecnfrm";
  static final mutilityproviderdesc = "mutilityproviderdesc";

  static final mdefbatchcd = "mdefbatchcd";
  static final mintfreq = "mintfreq";
  static final mmindepamt = "mmindepamt";
  static final mmaxdepamt = "mmaxdepamt";
  static final mperiodtype = "mperiodtype";
  static final mnodaysinyear = "mnodaysinyear";
  static final mtaxprojection = "mtaxprojection";
  static final mclintcalctype = "mclintcalctype";
  static final tdParameterCompositeEntity = "tdParameterCompositeEntity";
  static final mcustid = "mcustid";

  static final mmobilelastsynsdate = "mmobilelastsynsdate";
  static final mutils = 'mutils';

  //Internal Bank Transfer
  static final mcashtr = "mcashtr";
  static final maccid = "maccid";
  static final mdraccid = "mdraccid";
  static final mcraccid = "mcraccid";
  //Disbursment

  static final mefffromdate = "mefffromdate";
  static final mdisburseddate = "mdisburseddate";
  static final minstlstartdate = "minstlstartdate";
  static final minstlintcomp = "minstlintcomp";
  static final mappliedasindvyn = "mappliedasindvyn";
  static final mnewtopupflag = "mnewtopupflag";
  static final msancdate = "msancdate";
  static final msdamt = "msdamt";
  static final mrebateamt = "mrebateamt";
  static final mchargesamt = "mchargesamt";
  static final mdisbursedamtcoltd = "mdisbursedamtcoltd";
  static final msdamtcoltd = "msdamtcoltd";
  static final mrebateamtcoltd = "mrebateamtcoltd";
  static final mchargesamtcoltd = "mchargesamtcoltd";
  static final mdisbursedamtflag = "mdisbursedamtflag";
  static final msdamtflag = "msdamtflag";
  static final mrebateamtflag = "mrebateamtflag";
  static final mchargesamtflag = "mchargesamtflag";
  static final mreason = "mreason";
  static final mmainscrollno = "mmainscrollno";
  static final mbatchnumber = "mbatchnumber";
  static final msuspbatchcd = "msuspbatchcd";
  static final msuspsetno = "msuspsetno";
  static final msuspscrollno = "msuspscrollno";
  static final msspmainscrollno = "msspmainscrollno";
  static final mpartcashamount = "mpartcashamount";
  static final mpartcashbatchcd = "mpartcashbatchcd";
  static final mpartcashsetno = "mpartcashsetno";
  static final mpartcashscrollno = "mpartcashscrollno";
  static final mpartcashmainscrollno = "mpartcashmainscrollno";
  static final mneftclsrBatchCd = "mneftclsrBatchCd";
  static final mneftclsrsetno = "mneftclsrsetno";
  static final mneftclsrscrollno = "mneftclsrscrollno";
  static final mneftclsrmainscrollno = "mneftclsrmainscrollno";
  static final mdisbamount = "mdisbamount";
  static final mchargesamt1 = "mchargesamt1";
  static final mchargesamt2 = "mchargesamt2";
  static final mchargesamt0 = "mchargesamt0";
  static final mchargesamt3 = "mchargesamt3";
  static final mchargesamt4 = "mchargesamt4";
  static final mchargesamt5 = "mchargesamt5";
  static final mchargesamt6 = "mchargesamt6";
  static final mchargesamt7 = "mchargesamt7";
  static final mchargesamt8 = "mchargesamt8";
  static final mchargesamt9 = "mchargesamt9";
  // Menu master
  static final menuid = "menuid";
  static final menuDesc = "menudesc";
  static final menuimagepath = "menuimagepath";
  static final menutype = "menutype";
  static final parenttype = "parenttype";
  static final mapplicationtype = "mapplicationtype";
  static final mparentmenuid = "mparentmenuid";
  static final murl = "murl";
  static final msystemid="msystemid";
  // User Rights Table
  static final userGroup = "usergroup";
  static final userCode = "usercode";
  static final menuId = "menuid";
  static final create = "createe";
  static final modify = "modifye";
  static final browse = "browsee";
  static final authority = "authoritye";
  static final delete = "deletee";
  static final userAccressRightsCompositeEntity =
      "userAccressRightsCompositeEntity";
  static final usrcd = "usrcode";

  //TD Closure
  static final maccountopenningdt = "maccountopenningdt";
  static final mmatdt = "mmatdt";
  static final mdepositamt = "mdepositamt";
  static final mmatamt = "mmatamt";
  static final mintprovided = "mintprovided";
  static final mcalintamount = "mcalintamount";
  static final mbranchoperdt = "mbranchoperdt";
  static final mcshorsav = "mcshorsav";
  static final mtds = "mtds";
  static final mselectedsavingacc = "mselectedsavingacc";

  static final mmatintamt = "mmatintamt";
  static final mclosintamt = "mclosintamt";
  static final mclosdt = "mclosdt";
  static final mclosmatamt = "mclosmatamt";
  static final mclosintrate = "mclosintrate";
  static final mclostds = "mclostds";

  static final ISADDDESC = "ISADDDESC";
  //CPV Verification
  static final contactPointVerificationEntity =
      "contactPointVerificationEntity";
  static final tcpvrefno = "tcpvrefno";
  static final mcpvrefno = "mcpvrefno";
  static final maddmatch = "maddmatch";
  static final massetvissibledesc = "massetvissibledesc";
  static final myrsmovdin = "myrsmovdin";
  static final mhouseprptystatus = "mhouseprptystatus";
  static final mhousestructure = "mhousestructure";
  static final mhousewall = "mhousewall";
  static final mhouseroof = "mhouseroof";
  static final massetvissiblecode = "massetvissiblecode";

  static final branchOperationalDate = "branchOperationalDate";

  static final mbuttonid = "mbuttonid";
  static final mbuttonname = "mbuttonname";
  static final mstageid = "mstageid";
  static final mproductname = "mproductname";
  static final misIndividual = "misIndividual";
  static final currentAddressCode = "currentAddressCode";

  static final rHMinFingCount = "rHMinFingCount";
  static final lHMinFingCount = "lHMinFingCount";
  static final morderid = "morderid";
  static final mismandatory = "mismandatory";

  //Social And Environmental
  static final mbrwexclist = "mbrwexclist";
  static final mbrwnontargetlist = "mbrwnontargetlist";
  static final mbrwairemission = "mbrwairemission";
  static final mbrwwastewater = "mbrwwastewater";
  static final mbrwsolidhazardous = "mbrwsolidhazardous";
  static final mbrwchemicalfuels = "mbrwchemicalfuels";
  static final mbrwnoisefumes = "mbrwnoisefumes";
  static final mbrwresconsuption = "mbrwresconsuption";
  static final mcinodesignation = "mcinodesignation";
  static final mcinci = "mcinci";
  static final msilar = "msilar";
  static final msidrofls = "msidrofls";
  static final msiils = "msiils";
  static final msiiip = "msiiip";
  static final msicnc = "msicnc";
  static final msiasc = "msiasc";
  static final msinsi = "msinsi";
  static final mlinpp = "mlinpp";
  static final mliieh = "mliieh";
  static final mliiwc = "mliiwc";
  static final mliite = "mliite";
  static final mliueo = "mliueo";
  static final mlipmw = "mlipmw";
  static final mliema = "mliema";
  static final mlicfl = "mlicfl";
  static final mlipevc = "mlipevc";
  static final mlireou = "mlireou";
  static final mlinli = "mlinli";
  static final mbrwcat = "mbrwcat";
  // static final mloanterfno = "mloanterfno";
  static final mloanmrefno = "mloanmrefno";

  //Trade and Neighbour Reference Check
  static final msupname = "msupname";
  static final msupaddress = "msupaddress";
  static final msupcontact = "msupcontact";
  static final msupcredit = "msupcredit";
  static final msuponcredit = "msuponcredit";
  static final mclientdelay = "mclientdelay";
  static final mdefpayment = "mdefpayment";
  static final mproductsup = "mproductsup";
  static final msalcycles = "msalcycles";
  static final mvalsalcycles = "mvalsalcycles";
  static final mloanlender = "mloanlender";
  static final mfacility = "mfacility";
  static final mturnover = "mturnover";
  static final mbuyersname = "mbuyersname";
  static final mbuyersaddress = "mbuyersaddress";
  static final mcontactno = "mcontactno";
  static final mbuyingperiod = "mbuyingperiod";
  static final mcreditbuying = "mcreditbuying";
  static final mproducts = "mproducts";
  static final mmonthlypur = "mmonthlypur";
  static final mquality = "mquality";
  static final mreliableper = "mreliableper";
  static final mcusremarks = "mcusremarks";
  static final mneigname = "mneigname";
  static final mneigadd = "mneigadd";
  static final mknownclient = "mknownclient";
  static final mimprovement = "mimprovement";
  static final mrelperson = "mrelperson";

  //deviation form
  static final mdevloanapp = "mdevloanapp";
  static final mdrnrc = "mdrnrc";
  static final mdrmni = "mdrmni";
  static final mdrdbr = "mdrdbr";
  static final mdrmfi = "mdrmfi";
  static final mdrbl = "mdrbl";
  static final mdevapproval = "mdevapproval";

  //Loan cpv businees receord

  static final mhblocated = "mhblocated";
  //static final mbusinessname="mbusinessname";
  static final mbusinessaddress = "mbusinessaddress";
  static final maddresschanged = "maddresschanged";
  static final mbusinesslicense = "mbusinesslicense";
  static final mstartedym = "mstartedym";
  static final mpropertystatus = "mpropertystatus";
  static final mshopcondition = "mshopcondition";
  static final mbuslocation = "mbuslocation";
  static final mpremisesphoto = "mpremisesphoto";
  static final mnoofcustomers = "mnoofcustomers";
  static final mcuslocation = "mcuslocation";
  static final mcusdealing = "mcusdealing";
  static final mcreditsales = "mcreditsales";
  static final mperiodsale = "mperiodsale";
  static final mapplicantsrole = "mapplicantsrole";
  static final mbuspartner = "mbuspartner";
  static final mkeyperson = "mkeyperson";
  static final mcusbehaviour = "mcusbehaviour";
  static final mtransrecord = "mtransrecord";
  static final mrecpurandsal = "mrecpurandsal";
  static final mbooksupdated = "mbooksupdated";
  static final mivlandrecord = "mivlandrecord";
  static final mivsalesregister = "mivsalesregister";
  static final mivcreditregister = "mivcreditregister";
  static final mivinventoryregister = "mivinventoryregister";
  static final mivsalaryslip = "mivsalaryslip";
  static final mivpassbook = "mivpassbook";
  static final mbuscategories = "mbuscategories";
  static final mpremisesphotosec = "mpremisesphotosec";
  static final mpremisesphotothird = "mpremisesphotothird";

  //Customer Loan  CashFlow

  static final mfimainbsinc = "mfimainbsinc";
  static final mfisubbusinc = "mfisubbusinc";
  static final mfirentalinc = "mfirentalinc";
  static final mfiotherinc = "mfiotherinc";
  static final mfitotalInc = "mfitotalInc";
  static final mbepurequipments = "mbepurequipments";
  static final mbepetrolcost = "mbepetrolcost";
  static final mbewages = "mbewages";
  static final mberent = "mberent";
  static final mbeeemi = "mbeeemi";
  static final mbetotalbusexp = "mbetotalbusexp";
  static final mfefoodexp = "mfefoodexp";
  static final mfemobileexp = "mfemobileexp";
  static final mfemedicalexp = "mfemedicalexp";
  static final mfeschoolfees = "mfeschoolfees";
  static final mfecollegefees = "mfecollegefees";
  static final mfemiscellaneous = "mfemiscellaneous";
  static final mfeelectricity = "mfeelectricity";
  static final mfesocialcharity = "mfesocialcharity";
  static final mfetotalfaminc = "mfetotalfaminc";
  static final mfetotalexp = "mfetotalexp";
  static final msurpluscash = "msurpluscash";
  static final mdbr = "mdbr";

  //static final mloanmrefno=	  "mloanmrefno";
  static final mloantrefno = "mloantrefno";

  //KYC Master
  /* static final mloantrefno = "mloantrefno";
  static final mloanmrefno = "mloanmrefno";*/
  static final mbackground = "mbackground";
  static final mjob = "mjob";
  static final mlifestyle = "mlifestyle";
  static final mloanrepay = "mloanrepay";
  static final mnetworth = "mnetworth";
  static final mcomments = "mcomments";
  static final mverifiedinfo = "mverifiedinfo";

  //Guarantor
  static final mtownship = "mtownship";
  static final mwardno = "mwardno";
  static final mbuspropownership = "mbuspropownership";
  static final mbusownership = "mbusownership";
  static final mbustoaassetval = "mbustoaassetval";
  static final mbusleninyears = "mbusleninyears";
  static final mbusmonexpense = "mbusmonexpense";
  static final mbusmonhlynetprof = "mbusmonhlynetprof";
  static final msamevillageorward = "msamevillageorward";
  static final mfacecapture = "mfacecapture";
  static final mnrcphoto = "mnrcphoto";
  static final mnrcsecphoto = "mnrcsecphoto";
  static final mhouseholdphoto = "mhouseholdphoto";
  static final mhouseholdsecphoto = "mhouseholdsecphoto";
  static final maddressphoto = "maddressphoto";
  static final msignature = "msignature";
  static final ISINDONUSERCD = "ISINDONUSERCD";
  static final ISFULLERTON = "ISFULLERTON";

  static final userType = "USERTYPE";
  // for user master
  static final agentleftfinger = "agentleftfinger";
  static final agentrightfinger = "agentrightfinger";
  static final ISGLOONUSERCD = "ISGLOONUSERCD";

  //CIF
  static final misbiometricdeclareflagyn = "misbiometricdeclareflagyn";
  static final mprinccurrdue = "mprinccurrdue";
  static final mprincoverdue = "mprincoverdue";
  static final mintdue = "mintdue";
  static final contactPointVerification = "contactPointVerification";
  static final designation = "designation";
  static final orgName = "orgname";
  static final yearsInOrg = "yearsinorg";
  static final ISONLYLONGNAME = "ISONLYLONGNAME";

  static final mcheckresaddchng = "mcheckresaddchng";
  static final mspouserelname = "mspouserelname";
  static final mcheckspouserepay = "mcheckspouserepay";
  static final loanimageBeans = "loanimageBeans";
  static final mcheckbiometric = "mcheckbiometric";
  static final mimagestring = "mimagestring";
  static final mimagebyteorfolder = "mimagebyteorfolder";
  static final mimagetype = "mimagetype";
  static final timgrefno = "timgrefno";
  static final AGEVALIDATION = "AGEVALIDATION";
  static final AGEVALIDATIONMIN = "AGEVALIDATIONMIN";
  static final AGEVALIDATIONMAX = "AGEVALIDATIONMAX";
  static final NIDDEFAULTTYPE = "NIDDEFAULTTYPE";
  static final resAddCode = "resAddCode";
  static final SpouseDeclarationTab = "SpouseDeclarationTab";

  static final wasasa = "wasasa";
  static final fullerton = "fullerton";

  static final mopendate = "mopendate";
  static final mlcybal = "mlcybal";
  static final mtotallien = "mtotallien";
  static final mintapplied = "mintapplied";

  static final mstatecddesc = "mstatecddesc";
  static final mtownshipdesc = "mtownshipdesc";
  static final mvillagedesc = "mvillagedesc";
  static final mwardnodesc = "mwardnodesc";
  static final mdisbstatus = "mdisbstatus";
  static final mauthorizedby = "mauthorizedby";
  static final mauthorizedttime = "mauthorizedttime";
  static final monileadstatus = "monileadstatus";
  static final rsfLbrCodes = "rsfLbrCodes";
  static final chargesCodes = "chargesCodes";
  static final businessAddCode = "businessAddCode";

  static final MANDATORYCOLOR = "MANDATORYCOLOR";

  static final PROJECTCODE = "PROJECTCODE";
  static final misauthorized = "misauthorized";
  static final isHttps = "isHttps";
  static final isPortRequired = "isPortRequired";
  static final ContactNo = "ContactNo";
  static final ISDEDUPREQUIRED = "ISDEDUPREQUIRED";
  static final mchargescollectiontype = "mchargescollectiontype";
  static final msdcollectiontype = "msdcollectiontype";
  static final mthirdpartyamount = "mthirdpartyamount";
  static final PrintingCode = "PrintingCode";
  static final mamttodisb = "mamttodisb";
  static final HIDESHOWPASSWORDFIELD = "HIDESHOWPASSWORDFIELD";

  static final AUTOLOGOUTPERIOD = "AUTOLOGOUTPERIOD";
  static final disbursedBean = "disbursedBean";
  static final msancamt = "msancamt";
  static final mtotal = "mtotal";
  static final acctStat = "acctStat";
  static final cashtype = "cashtype";
  static final magenta = "magenta";
  static final currency = "currency";
  static final usertype = "usertype";
  static final mbalance = "mbalance";

  static final musercode1 = "musercode";

  static final IFVIDEONEDED = "IFVIDEONEDED";

  static final mtxnamount = "mtxnamount";
  static final msystemnarration = "msystemnarration";
  static final musernarration = "musernarration";
  static final mactivity = "mactivity";

  static final mtxnrefno = "mtxnrefno";
  static final mcorerefno = "mcorerefno";

  static final screenname = "screenname";

  static final GUARANTORAPPLICANTTYPE = "GUARANTORAPPLICANTTYPE";
  static final userVaultBalanceCompositetEntity =
      "userVaultBalanceCompositetEntity";

  static final subtitle = "subtitle";
  static final description = "description";
  static final image = "image";
  static final displaytype = "displaytype";
  static final type = "type";
  static final codelink = "codelink";
  static final premetivedatatype = "premetivedatatype";
  static final childtype = "childtype";

  static final subdescription = "subdescription";
  static final subdisplaytype = "subdisplaytype";
  static final mkey = "mkey";
  // Added for Collateral module
  static final colleteraltrefno = "colleteraltrefno";
  static final colleteralmrefno = "colleteralmrefno";
  static final mcollateralsid = "mcollateralsid";
  static final mcollatrlTyp = "mcollatrltyp";
  static final msubcolltrl = "msubcolltrl";
  static final msubocolltrldesc = "msubocolltrldesc";
  static final msubcolltrlcat = "msubcolltrlcat";
  static final msubocolltrlcatdesc = "msubocolltrlcatdesc";
  static final mcollatrlcat = "mcollatrlcat";
  static final minsurance = "minsurance";
  static final mcolltrltitle = "mcolltrltitle";
  static final mnameoftitledoc = "mnameoftitledoc";
  static final mcollbookno = "mcollbookno";
  static final mcollpageno = "mcollpageno";
  static final mplaceofuse = "mplaceofuse";
  static final mwithdrawcond = "mwithdrawcond";
  static final misappctprimary = "misappctprimary";
  static final mislmap = "mislmap";
  static final mnoofattchmnt = "mnoofattchmnt";
  static final msectype = "msectype";
  static final mownername = "mownername";
  static final mtel = "mtel";
  static final maddress1 = "maddress1";
  static final msubdist = "msubdist";
  static final mbrand = "mbrand";
  static final mnoofaxles = "mnoofaxles";
  static final mnoofcylinder = "mnoofcylinder";
  static final mcolor = "mcolor";
  static final msizeofcylinder = "msizeofcylinder";
  static final mbodyno = "mbodyno";
  static final menginepower = "menginepower";
  static final mengineno = "mengineno";
  static final myearmade = "myearmade";
  static final mchassisno = "mchassisno";
  static final mmadeby = "mmadeby";
  static final midentitycarno = "midentitycarno";
  static final mcarpricing = "mcarpricing";
  static final mstdpricing = "mstdpricing";
  static final minsurancepricing = "minsurancepricing";
  static final mpriceafterevaluation = "mpriceafterevaluation";
  static final mltv = "mltv";
  static final mcartype = "mcartype";
  static final mltvdd = "mltvdd";
  static final mloantovalueltv = "mloantovalueltv";
  static final mwhobelongocarowner = "mwhobelongocarowner";
  static final mcarlegality = "mcarlegality";
  static final mdescription = "mdescription";
  static final mcarcanbeused = "mcarcanbeused";
  static final mcredittenor = "mcredittenor";
  static final mdmirror = "mdmirror";
  static final mddoor = "mddoor";
  static final mdmirrorbacklock = "mdmirrorbacklock";
  static final mdcolororspot = "mdcolororspot";
  static final mfcolorandspot = "mfcolorandspot";
  static final mftireandyan = "mftireandyan";
  static final mfcapofsplatter = "mfcapofsplatter";
  static final mhmirror = "mhmirror";
  static final mhvent = "mhvent";
  static final mhlightfarl = "mhlightfarl";
  static final mhlightfarr = "mhlightfarr";
  static final mhsignal = "mhsignal";
  static final mhwincap = "mhwincap";
  static final mpmirror = "mpmirror";
  static final mpdoor = "mpdoor";
  static final mpbackmirror = "mpbackmirror";
  static final mpcolororspot = "mpcolororspot";
  static final mftcolorandspot = "mftcolorandspot";
  static final mfttanandyan = "mfttanandyan";
  static final mftcap = "mftcap";
  static final mftsplattercap = "mftsplattercap";
  static final mbpmirror = "mbpmirror";
  static final mbpdoor = "mbpdoor";
  static final mbpcolorandspot = "mbpcolorandspot";
  static final mbtcolorandsport = "mbtcolorandsport";
  static final mbttanandyan = "mbttanandyan";
  static final mbtcap = "mbtcap";
  static final mbcbacklightr = "mbcbacklightr";
  static final mbcturnsignal = "mbcturnsignal";
  static final mbcmessagesignal = "mbcmessagesignal";
  static final mbcsignal = "mbcsignal";
  static final mbcbacklightl = "mbcbacklightl";
  static final mbcbackdoor = "mbcbackdoor";
  static final mbccranes = "mbccranes";
  static final mbctakelock = "mbctakelock";
  static final mbcholdlock = "mbcholdlock";
  static final mbchandcranes = "mbchandcranes";
  static final mhheadcap = "mhheadcap";
  static final mbcreservetire = "mbcreservetire";
  static final mbcbackmirror = "mbcbackmirror";
  static final mbcantenna = "mbcantenna";
  static final mbtlcolororspot = "mbtlcolororspot";
  static final mbtltanandyan = "mbtltanandyan";
  static final mbtlcap = "mbtlcap";
  static final mbtlsplattercap = "mbtlsplattercap";
  static final mbtrcolororspot = "mbtrcolororspot";
  static final mbtrtireandyan = "mbtrtireandyan";
  static final mbtrcap = "mbtrcap";
  static final mbtrsplattercap = "mbtrsplattercap";
  static final mibarsun = "mibarsun";
  static final midescriptionbook = "midescriptionbook";
  static final miautosystem = "miautosystem";
  static final miairconditioner = "miairconditioner";
  static final mimirrorremote = "mimirrorremote";
  static final misafebell = "misafebell";
  static final mimiddlebox = "mimiddlebox";
  static final mregexpdate = "mregexpdate";
  static final mregdate = "mregdate";
  static final mcountryrisk = "mcountryrisk";
  static final mdist = "mdist";
  static final mcountry = "mcountry";
  static final mpoboxno = "mpoboxno";
  static final mhousebuilttype = "mhousebuilttype";
  static final menvdescription = "menvdescription";
  static final mlotarea = "mlotarea";
  static final mfloorarea = "mfloorarea";
  static final mdescofproperty = "mdescofproperty";
  static final msizeofproperty = "msizeofproperty";
  static final msizeofpropertyl = "msizeofpropertyl";
  static final msizeofpropertyh = "msizeofpropertyh";
  static final mtctno = "mtctno";
  static final mepebdate = "mepebdate";
  static final mrescodeorremark = "mrescodeorremark";
  static final mepebno = "mepebno";
  static final mregofdeedslocation = "mregofdeedslocation";
  static final mcollno = "mcollno";
  static final mpriorsec = "mpriorsec";
  static final mcolltype = "mcolltype";
  static final mcollsubtype = "mcollsubtype";
  static final mtypeofproperty = "mtypeofproperty";
  static final mltypeofownercerti = "mltypeofownercerti";
  static final mhtypeofownercerti = "mhtypeofownercerti";
  static final mlissuednoprop = "mlissuednoprop";
  static final mhissuednoprop = "mhissuednoprop";
  static final mlissueby = "mlissueby";
  static final mhissueby = "mhissueby";
  static final mlsizeprop = "mlsizeprop";
  static final mhsizeprop = "mhsizeprop";
  static final mlnpropborder = "mlnpropborder";
  static final mhnpropborder = "mhnpropborder";
  static final mlspropborder = "mlspropborder";
  static final mhspropborder = "mhspropborder";
  static final mlwpropborder = "mlwpropborder";
  static final mhwpropborder = "mhwpropborder";
  static final mlepropborder = "mlepropborder";
  static final mhepropborder = "mhepropborder";
  static final mllocprop = "mllocprop";
  static final mhlocprop = "mhlocprop";
  static final mltitleowener = "mltitleowener";
  static final mhtitleowener = "mhtitleowener";
  static final mllocalauthvalue = "mllocalauthvalue";
  static final mhlocalauthvalue = "mhlocalauthvalue";
  static final mlrealestatecmpnyvalue = "mlrealestatecmpnyvalue";
  static final mhrealestatecmpnyvalue = "mhrealestatecmpnyvalue";
  static final mlaskneighonvalue = "mlaskneighonvalue";
  static final mhaskneighonvalue = "mhaskneighonvalue";
  static final mlsumonvalprop = "mlsumonvalprop";
  static final mhsumonvalprop = "mhsumonvalprop";
  static final mlissuedt = "mlissuedt";
  static final mhissuedt = "mhissuedt";
  static final mdisbursmentdate = "mdisbursmentdate";
  static final moperationdate = "moperationdate";
  static final moverdueint  = "moverdueint";
  static final  moverdueprn = "moverdueprn";
  static final  mschemiint = "mschemiint";
  static final  mschemiprn = "mschemiprn";
   static final loanoutbal = "loanoutbal";
   static final mcycle="mcycle";
   static final mloanrepayprin="mloanrepayprin";
   static final mloanrepayint="mloanrepayint";
   static final mothrchrgpen="mothrchrgpen";
   static final mloanoutbal="mloanoutbal";
   static final mismodify = "mismodify";
  static final LOANCYCLETYPE="LOANCYCLETYPE";
   static final moverdueintcoll = "moverdueintcoll";
   static final customerProductwiseCycleCompositeEntity = "customerProductwiseCycleCompositeEntity";
  //static final msystemid ="msystemid";
  static final GUARANTORAGEVALIDATION = "GUARANTORAGEVALIDATION";
  static final mval = "mval";
    static final lastsynctotab = "lastsynctotab";
  static final  mtableid = "mtableid";
  static final  lastsynctotabcompositeentity = "lastsynctotabcompositeentity";
  static final  mrefnolist = "mrefnolist";
  static final  DISBBIOMETRICCHECKNEEDED = "DISBBIOMETRICCHECKNEEDED";
  static final  missyncfromcoresys = "missyncfromcoresys";
  static final apkversion = "apkversion";
  static final mlicensekey = "mlicensekey";
  static final STOPOVERPAYMENT = "STOPOVERPAYMENT";
  static final CGT1LEADNEEDED = "CGT1LEADNEEDED";
  static final minstEndDate = "minstEndDate";
  static final msdamount = "msdamount";
  static final mcusrrentsavingbal = "mcusrrentsavingbal";
  static final mleinamount= "mleinamount";
  static final msubmitamt = "msubmitamt";
  static final response = "response";
  static final  mquestiontype= "mquestiontype";
  static final  PRINTHEADER = "PRINTHEADER";
  static final   mcraccidname = "mcraccidname";
  static final   mdraccidname = "mdraccidname";
  static final vaultbalance = "vaultbalance";
  static final usercode = "usercode";
  static final totalinflow = "totalinflow";
  static final totaloutflow = "totaloutflow";
  static final offlineLoanCollection = "offlineLoanCollection";
  static final offlinesavingscollection = "offlinesavingscollection";
  static final onlineLoanCollection = "onlineLoanCollection";
  static final onlinesavingsCollection = "onlinesavingsCollection";
  static final onlineloanclosure = "onlineloanclosure";
  static final inflowcahstransaction = "inflowcahstransaction";

  static final onlinesavingscollection = "onlinesavingscollection";
  static final outflowcashtransaction = "outflowcashtransaction";

  static final WITHDRAWAL = "WITHDRAWAL";
  static final DEPOSIT = "DEPOSIT";
  static final INSTALPAY = "INSTALPAY";
  static final mtxndate = "mtxndate";
  static final msavingacctno = "msavingacctno";
  static final mwithdrawalamt = "mwithdrawalamt";
  static final totalflow = "totalflow";
  static final CLOSURE = "CLOSURE";
  static final onlinesavingswithdrawal = "onlinesavingswithdrawal";
  static final onlinesavingsclosure = "onlinesavingsclosure";
  static final overallsavingscollection = "overallsavingscollection";
  static final overallloancollection = "overallloancollection";
  static final outflowtdclosure = "outflowtdclosure";
  static final inflowtdopening = "inflowtdopening";

  static final transactioncount = "transactioncount";

  static final oflnloancolltrnsnos = "oflnloancolltrnsnos";
  static final onlnloancolltrnsnos = "onlnloancolltrnsnos";
  static final oflnsvngcolltrnsnos = "oflnsvngcolltrnsnos";
  static final onlnnsvngcolltrnsnos = "onlnnsvngcolltrnsnos";
  static final loanclsrtrnsnos = "loanclsrtrnsnos";
  static final svngclsrtrnsnos = "svngclsrtrnsnos";
  static final tdopngtrnsnos = "tdopngtrnsnos";
  static final tdclsrtrnsnos = "tdclsrtrnsnos";
  static final onlnsvngwdrwltrnsno = "onlnsvngwdrwltrnsno";
  static final inflowtrnsnos = "inflowtrnsnos";
  static final outflowtrnsnos = "outflowtrnsnos";
  static final TDCLOSURE = "TDCLOSURE";
  static final BULKLOANCLOSURE = "BULKLOANCLOSURE";
  static final INTERNALBANKTRANSFERDR = "INTERNALBANKTRANSFERDR";
  static final INTERNALBANKTRANSFERCR = "INTERNALBANKTRANSFERCR";
  static final TDOPENING = "TDOPENING";
  static final onlineLoanDisbursment = "onlineLoanDisbursment";
  static final offlineLoanDisbursment = "offlineLoanDisbursment";
  static final onlnloandisbtrnsno = "onlnloandisbtrnsno";
  static final oflnloandisbtrnsno = "oflnloandisbtrnsno";
  static final overallLoanDisbursment = "overallLoanDisbursment";
  static final DISBURSMENT = "DISBURSMENT";
  static final LOANCYCLELIMIT = "LOANCYCLELIMIT";
  static final onlineBulkloanclosure = "onlineBulkloanclosure";
  static final blkloanclsrtrnsnos = "blkloanclsrtrnsnos";
  static final overallloanclosure = "overallloanclosure";
  static final NONMFIIDS = "NONMFIIDS";

  static final mdtOfPayment = "mdtOfPayment";
  static final mdtIdealrePayment = "mdtIdealrePayment";
  static final mdiffInDay = "mdiffInDay";
  static final minstAmt = "minstAmt";
  static final mamtOfTrans = "mamtOfTrans";
  static final mprincRecvd = "mprincRecvd";
  static final mintRecvd = "mintRecvd";
  static final mpenalIntRecvd = "mpenalIntRecvd";
  static final mchrgsRecvd = "mchrgsRecvd";
  static final mwriteOffAmtRecvd = "mwriteOffAmtRecvd";
  static final mprincOutstand = "mprincOutstand";
  static final mwriteOffAmt = "mwriteOffAmt";
  static final mcommissRecvd = "mcommissRecvd";
  static final minstNumber = "minstNumber";
    static final inflowservicecharge = "inflowservicecharge";
  static final inflowinsureancecharge = "inflowinsureancecharge";
  static final mentrydt = "mentrydt";
  static final mclosureamtpaid = "mclosureamtpaid";
    static final   timagerefno= "timagerefno";
  static final   mimagerefno= "mimagerefno";
  static final   mimagesubtype= "mimagesubtype";
  static final   customerfingerprintlist = "customerfingerprintlist";
  static final   CURCD = "CURCD";
  static final   xminval = "xminval";
  static final   yminval = "yminval";
  static final   xinterval = "xinterval";
  static final   yinterval = "yinterval";
  static final   xcaption = "xcaption";
  static final   ycaption = "ycaption";
  static final mcharttype = "mcharttype";
  static const areadefault = "area default";
  static const columnrounded = "column rounded";
  static const columndefault = "column default";
  static const linedashed = "line dashed";
  static const customizedline = "customized line";
  static final chartbean = "chartbean";

  static const multipleaxis = "multiple axis";
  static const columnwidthspace = "column width and spacing";
  static const stackedarea = "stacked area";
  static const piegrouping = "pie grouping";
  static final  isfavalwed = "isfavalwed";
  static final  xcaprot = "xcaprot";
  static final  ycaprot = "ycaprot";
  static final  xaxisvsbl = "xaxisvsbl";
  static final  yaxisvsbl = "yaxisvsbl";
  static final  islegvis = "islegvis";
  static final  manimdur = "manimdur";
  static final  profileimage = "profileimage";

  static final mlocationtrackeronoff="mlocationtrackeronoff";
  static final mpathtrackeronoff="mpathtrackeronoff";
  static final GRAPHMAPNED = "GRAPHMAPNED";
  static final oflninflwdisbamt = "oflninflwdisbamt";
  static final oflninflwdisbtrnsnos = "oflninflwdisbtrnsnos";

  static final CheckPreviousLat="CheckPreviousLat";
  static final CheckPreviousLong="CheckPreviousLong";
  static final PATHTRACEAFTERMINUTES="PATHTRACEAFTERMINUTES";
    static const stackedcolumn = "stacked column";
  static const defaultbar = "default bar";
  static const stackedbar = "stacked bar";
  static const  mprspcttrefno = "mprspcttrefno";
  static const  mprspctmrefno = "mprspctmrefno";
  static const verticalgradient = "vertical gradient";
  static const funnelwithsmartlabel = "funnel with smart label";
  static const pyramidlwithsmartlabel = "pyramid with smart label";
  static const exporting = "exporting";
  static const chartwithannotation = "chart with annotation";

  static final idealbaldate= "idealbaldate";
  static final principle= "principle";
  static final interest= "interest";
  static final outstandingprinciple= "outstandingprinciple";
  static final openingbalance= "openingbalance";
  static final typeName = "typeName";
  static final  mchartfavtype = "mchartfavtype";
  static final mgraceperyn = "mgraceperyn";
  static final mgraceperinmnths = "mgraceperinmnths";
  static final mgraceperindays = "mgraceperindays";
  static final balance = "balance";
  static final installment = "installment";
  static final TRNSMSG = "TRNSMSG";
  static final PROSPECTVALIDITYDAYS = "PROSPECTVALIDITYDAYS";
  static final columnCount = "columnCount";
  static final rowCount = "rowCount";

  static final EXTRNLAGNTGRPCD = "EXTRNLAGNTGRPCD";

  static final mfieldname = "mfieldname";
  static final reportFilterComposite = "reportFilterComposite";
  static final mdisplay = "mdisplay";
  //static final mismandatory = "mismandatory";
  static final mfieldid = "mfieldid";
  static final mdefaultval = "mdefaultval";
  static final String PDF = "PDF";
  static final String EXCEL = "EXCEL";
  static final String HTML = "HTML";
  static final format = DateFormat("yyyy-MM-dd");
  static final secondFormat = DateFormat("yyyy/MM/dd");
  static final english = "english";
  static final alfanoromo = "alfanoromo";
  static final PRINTINGDEVICE = "PRINTINGDEVICE";
  static final UNIPOS = "UNIPOS";
  static final FALCON = "FALCON";
  static final LEADVALIDITYDAYS = "LEADVALIDITYDAYS";
  static final misdisbursed = "misdisbursed";
}
