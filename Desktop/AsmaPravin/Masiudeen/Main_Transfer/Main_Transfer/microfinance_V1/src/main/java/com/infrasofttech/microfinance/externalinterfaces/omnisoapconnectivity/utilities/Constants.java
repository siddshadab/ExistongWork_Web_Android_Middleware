package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.utilities;

import java.time.LocalDateTime;
import java.util.HashMap;
import javax.sql.DataSource;

public class Constants {

	// public static String OMNIUSER = "itl";

	// public static String OMNIPASS = "infra#123";

	//
	//public static String ENDPOINT = "http://sezcpu102/SAIJA/OmniService.asmx";
	 //public static String OMNIUSER = "10";
	 //public static String OMNIPASS = "Infra#123";
	 
	
	public static String ENDPOINT = "http://Tango/SAIJA/OmniService.asmx";
	//public static String ENDPOINT = "http://104.211.166.232/SAIJA/OmniService.asmx";
	 //public static String OMNIUSER = "EKO102";
	 //public static String OMNIPASS = "Saija#123";
	 
	 //without schedule
	 public static String OMNIUSER = "";
	 public static String OMNIPASS = "";

	 
	// Wasasa Constant

		// public static String ENDPOINT ="http://172.21.1.34/WASASA_UAT/OmniService.asmx";
		// public static String OMNIUSER = "0396";
		// public static String OMNIPASS = "2019";
	
	 //public static String ENDPOINT = "http://localhost/Saija/OmniService.asmx";
     //public static String OMNIUSER = "a2256";
	// public static String OMNIPASS ="Saija#123";

	 //public static String OMNIUSER = "itl";
	 //public static String OMNIPASS = "infra#123";
	 
	 
	 //Saija UAT 2
	// public static String ENDPOINT = "http://localhost/Saija/OmniService.asmx";
     //public static String OMNIUSER = "bk751";
	 //public static String OMNIPASS ="Saija@2";
	 
	 
	 
	 

	public static String Field204 = "";
	public static String Field1 = "";
	public static String Field203 = "";
	 //public static String ENDPOINT =
	 //"http://172.21.1.34/WASASA_UAT/OmniService.asmx";

	
	// public static String ENDPOINT =
	// "http://192.168.0.226/SAIJA/OmniService.asmx";
	// public static String ENDPOINT =
	// "http://104.211.166.232/SAIJA/OmniService.asmx";
	// public static String ENDPOINT =
	// "http://192.168.0.226/SAIJA/OmniService.asmx";
	

	

	public static int maxBranchesNumber = 400;
	public static final String BLANKINT0 = "0";
	public static final String BLANKINT1 = "1";
	public static final String BLANKSTRING = "NA";
	public static final String EMPTYSTRING = "";
	public static final String TILDA = "~";
	public static final String NA = "NA";
	public static final String YES = "Y";
	public static final String NO = "N";
	public static final String HIFEN = "-";
	public static final String NOTAPPROVED = "NOTAPPROVED";
	public static final String exclamation = "!";
	public static final String space= " ";
	public static final String VCREATE= "VCREATE";
	public static final String FROMMOB= "FROMMOB";
	public static final String SESSIONERROR = "session";
	public static final String SESSIONERRORONE= "Session Token Not matching with User Web Session Token";
	public static final String SESSIONERRORTWO= "Session Token Not matching with User";
	public static final String SESSIONERRORTHREE= "User Not Found From Web Session";
	
	public static int allowedNoOfUsers =  0;
    public static int allowedNoOfBranches =  0;
    public static LocalDateTime allowedLicenseDate;
    public static String apkversion  = "" ;
   
    public static int currentNoOfUsers =  0;
    public static int currentNoOfBranches =  0;
    public static LocalDateTime currentLicenseDate;
    public static String licenseKey = "9891022";
    public static String licenseUpdateURL = "//LicenseController/add/";
	public static String  ISBIOREQFORAUTH = "ISBIOREQFORAUTH";
	public static final String NULL= "null";
	public static final String DEDUPCHECKERROR= "Dedup Check Failed";
	public static final String ALREADYUPDATEERROR = "Already Updated";
	public static final String MissingLeadError= "Missing Lead";
	public static final String OPERATIONDATEMISMATCHERROR= "Mpl Operation Date Not set properly";
	public static final String ISPOSQUEING = "ISPOSQUEING";
	
	public static String  getImages = "";
	public static String  getFingerPrint = "";
	
	public static String prospectValidityDays = "30";
	public static int leadValidityDays = 30;
	
	//public static String loginTokenOmni ="";

}