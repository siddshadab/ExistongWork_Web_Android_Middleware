package com.infrasofttech.microfinance.entityBeans.master.holder;


import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerAssetDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPaymentMethodDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class CIFLoanClosureHolderBean extends BaseEntity {	
	
	private String mprdacctid;	
	private String mentrydate;
	private String mloandetailsgrid;
	private String mapplicationdt;
	private String mappliedamt;
	private String mapproveddt;
	private String mapprovedamt;
	private String mstartdt;
	private String mdisbursementdt;
	private String mdisbursementamt;
	private String minstallmentstartdt;
	private String minstallmentamt;
	private String minstallmentfrequency;
	private String mnoofinstallments;
	private String mrateofinterest;
	private String menddt;
	private String minsurancepremiumamt;
	private String msecuritydetailsgrid;
	private String msecuritydepositdt;
	private String mamtondepositcreation;
	private String mcurrentbal;
	private String mexcessbal;
	private String mclosuredetailsgrid;
	private String minterestaccruedtilldt;
	private String mclosurecharges;
	private String mclosureamtasondate;
	private String mwaiveoffamt;
	private String mamttobepaidforclosure;
	private String mtotaloutstandinggrid;
	private String mprincipalos;
	private String minterestos;
	private String mpenalos;
	private String motherchargesos;
	private String mtotaloutstanding;
	private String mtotalpaymentgrid;
	private String mprincipalpaid;
	private String minterestpaid;
	private String mpenalpaid;
	private String motherchargespaid;
	private String mnoofinslpaid;
	private String mnoofdefaults;
	private String mtotalpaid;
	private String mduebutnotpaidgrid;
	private String mprincipalosdue;
	private String minterestosdue;
	private String mpenalosdue;
	private String motherchargesosdue;
	private String mtotaldue;
	private String momnimsg;
	private String mremark;
	private int mpaymntmode;
	private String merror;
	private int mlbrcode;	
	private String mbatchcd;
	private int msetno;
	private double mamt;
	private int mscrollno;
	private String mcurcd;

}
