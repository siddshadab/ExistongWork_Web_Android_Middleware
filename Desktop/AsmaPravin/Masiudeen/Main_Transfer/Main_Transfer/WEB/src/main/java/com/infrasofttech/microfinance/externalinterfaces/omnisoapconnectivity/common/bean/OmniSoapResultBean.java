package com.infrasofttech.microfinance.externalinterfaces.omnisoapconnectivity.common.bean;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class OmniSoapResultBean {
	
/*	int mCustRefNo;
	int mCustNo;
	Long  loanNumberOfTab;
	String loanNumberOfCore;	
	String createdBy;
    int status;*/
	
    
	int mCustRefNo;
	int mLoanRefNo;
	int tRefno;
	int mRefno;
	int mCustNo;
	int mlbrcode;
	String mprdcd;
	Long  loanNumberOfTab;
	String loanLeadIdOfCore;
	String loanAccountNumberOfCore;
	String mleadsid;
	String mprdacctid;
	String mlongname;

	String createdBy;	
	int status;
	String error;
	String mcrs;
	double mmatval;
	int mreceiptstatus;
	int centerId;
	int groupId;
	
	
	LocalDateTime mentrydate;
	String mbatchcd;
	int msetno;
	int mscrollno;
	
	
    double mfcytrnamt= 0d;
    String mdrcr;
    
	
	
	
	/*int mCustRefNo;
	int mCustNo;
	Long  loanNumberOfTab;
	String loanNumberOfCore;	
	String createdBy;*/

}
