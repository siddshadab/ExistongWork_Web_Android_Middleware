package com.infrasofttech.microfinance.entityBeans.master.holder;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class CIFLoanPaymentHistoryHolderBean extends BaseEntity {	
	
	private String mprdacctid;	
	private String mdtOfPayment;
	private String mdtIdealrePayment;
	private String mdiffInDay;
	private String mtype;
	private double minstAmt;
	private double mamtOfTrans;
	private double mprincRecvd;
	private double mintRecvd;
	private double mpenalIntRecvd;
	private double mchrgsRecvd;
	private double mwriteOffAmtRecvd;
	private double mprincOutstand;
	private double mwriteOffAmt;
	private double mcommissRecvd;
	private String mnarration;
	private String minstNumber;
	private int mlbrcode;
	
}
