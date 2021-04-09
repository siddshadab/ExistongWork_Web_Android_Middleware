package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Id;

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
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;

import lombok.Data;


@Data
public class DisbursmentHolderBean {

	
	

	
	private int trefno = 0;

	private int mrefno;   

	private int mcustno = 0;

	 private int mlbrcode;
	 
	 private String mprdacctid;
	 
	private String mlongname = "";
	
	private int mgroupcd = 0;
	 
	 private LocalDateTime mefffromdate;
	 
	 private LocalDateTime mdisburseddate;
	 
	 private LocalDateTime minstlstartdate;
	 
	 private double minstlamt= 0d;
	 
	 private double minstlintcomp= 0d;
	 
	 private String mleadsid;
	 
	 private String mappliedasindvyn;
	 
	 private int mnewtopupflag;
	 
	 private LocalDateTime msancdate;
	 
	 private double mdisbursedamt= 0d;
	 
	 private double msdamt= 0d;
	 
	 private double mrebateamt= 0d;
	 
	 private double mchargesamt= 0d;
	 
	 private double mdisbursedamtcoltd= 0d;
	 
	 private double msdamtcoltd= 0d;
	 
	 private double mrebateamtcoltd= 0d;
	 
	 private double mchargesamtcoltd= 0d;
	 
	 private int mdisbursedamtflag;
	 
	 private int msdamtflag;
	 
	 private int mrebateamtflag;
	 
	 private int mchargesamtflag;
	 
	 private String mreason;
	 
	 private int msetno;
	 
	 private int mscrollno;
	 
	 private LocalDateTime mentrydate;
	 
	 private String mbatchcd;
	 
	 private int mmainscrollno;
	 
	 private String mbatchnumber;
	 
	 private String mnarration;

	 private int mcenterid;

	 private String mcrs;

	 private String msuspbatchcd;

	 private int msuspsetno;

	 private int msuspscrollno;

	 private int msspmainscrollno;

	 private double mpartcashamount= 0d;

	 private String mpartcashbatchcd;

	 private int mpartcashsetno;

	 private int mpartcashscrollno;

	 private int mpartcashmainscrollno;

	 private String mneftclsrbatchcd;

	 private int mneftclsrsetno;

	 private int mneftclsrscrollno;

	 private int mneftclsrmainscrollno;

	 private LocalDateTime mcreateddt;

	 private String mcreatedby;

	 private LocalDateTime mlastupdatedt;

	 private String mlastupdateby;

	 private String mgeolocation;

	 private String mgeolatd;

	 private String mgeologd;

	 private LocalDateTime mlastsynsdate;

	 private String merrormessage;

	 private double mdisbamount;

	 private double mchargesamt0;

	 private double mchargesamt1;

	 private double mchargesamt2;

	 private double mchargesamt3;

	 private double mchargesamt4;;

	 private double mchargesamt5;

	 private double mchargesamt6;

	 private double mchargesamt7;

	 private double mchargesamt8;

	 private double mchargesamt9;
	
	 private int mcheckbiometric;
	
	 private int mdisbstatus;
	   
	 private String mrouteto;
	 
	 private String mremarks;
	 	  
	 private String mamttodisb;
	 
	 private DisbursedListEntity disbursedBean;
}
