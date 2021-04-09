package com.infrasofttech.microfinance.entityBeans.master.holder;


import java.time.LocalDateTime;
import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.ContactPointVerificationEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerAssetDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPaymentMethodDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;

import lombok.Data;

@Data
public class CustomerHolderBean {	

	private int trefno; 
	private int mrefno;
	private int mcustno;	 
	private int mlbrcode;	 
	private int mcenterid;	 
	private int mgroupcd;	 
	private String mnametitle;	 
	private String mlongname;	 
	private String mfathertitle;	 
	private String mfathername;	 
	private String mspousetitle;	 
	private String mhusbandname;
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime mdob;	 
	private int mage;	 
	private String mbankacno;		 
	private String mbankacyn;		 
	private String mbankifsc;		 
	private String mbanknamelk;	 
	private String mbankbranch;	 
	private int mcuststatus;	
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime mdropoutdate;	 
	private String mmobno;	 
	private int mpanno;	 
	private String mpannodesc;	 
	private String mtdsyn;	 
	private int mtdsreasoncd;	 
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime mtdsfrm15subdt;		 
	private String memailid;	 
	private int mcustcategory;	 
	private int mtier;	 
	private String madd1;	 
	private String madd2;	 
	private String madd3;	 
	private int marea;	 
	private String mpincode;	 
	private String mcouncd;	 
	private String mcitycd;		 
	private String mfname;	 
	private String mmname;	 
	private String mlname;	 
	private String mgender;	  
	private String mrelegion;	  
	private int mruralurban;	  
	private String mcaste;	  
	private String mqualification;	  
	private int moccupation;	  
	private String mlandtype;	  
	private String mlandmeasurement;	  
	private int mmaritialstatus;	  
	private int mtypeofid;	  
	private String middesc;	  
	private String mloanagreed;	  
	private String minsurancecovyn;	  
	private int mtypeofcoverage;
	//int mtypeofCoverage;
	private LocalDateTime mcreateddt;	   
	private String mcreatedby;
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime mlastupdatedt;		
	private String mlastupdateby;		
	private String mgeolocation;	
	private String mgeolatd;	
	private String mgeologd;	
	private int missynctocoresys;
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime mlastsynsdate;	
	private Double mexpsramt = 0d;	 
	private LocalDateTime mcbcheckrprtdt;
	private int miscbcheckdone;	
	private String mprofileind;	 
	private LocalDateTime mhusdob;	
	private int mhusage;
	private String mcrs; 
	private String motpvrfdno; 
	private String mlangofcust;
	private String mmainoccupn;
	private String msuboccupn;
	private int msecoccupatn;
	private String mcusttype;
	private LocalDateTime mid1expdate;
	private LocalDateTime mid1issuedate;
	private LocalDateTime mid2issuedate;
	private LocalDateTime mid2expdate;
	private String mdropoutreason;

	//CustomerEntity customerholderBean;
	CustomerBusinessDetailsEntity customerBussDetails;
	private List<CustomerFamilyDetailsEntity> familyDetails ;
	private List<CustomerBorrowingDetailsEntity> borrowingDetails ;
	private List<CustomerAddressDetailsEntity> addressDetails ;
	private List<CustomerPaymentMethodDetailsEntity> paymentDetailsDetails ;
	private List<ImageMasterEntity> imageMaster ;
	private List<CustomerPPIDetailsEntity> customerPPIDetailsEntity ;
	private List<CustomerBusinessExpenseEntity> customerBusinessExpenseEntity ;
	private List<CustomerHouseholdExpenseEntity> customerHouseholdExpenseEntity ;
	private List<CustomerAssetDetailsEntity> customerAssetDetailsEntity;
	CustomerLoanEntity customerLoanDetails ;
	private String mlegacybrncd;
	private int mretry;
	private LocalDateTime mmobilelastsynsdate;
	private int  mutils;
	private ContactPointVerificationEntity contactPointVerificationEntity;
	private int mmemberno;
	 private String designation = "";
	 private String orgname = "";
	 private String yearsinorg = "";
}
