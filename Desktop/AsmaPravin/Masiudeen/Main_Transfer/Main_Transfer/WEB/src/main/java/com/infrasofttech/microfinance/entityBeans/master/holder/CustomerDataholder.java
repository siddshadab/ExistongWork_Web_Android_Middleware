package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.util.Date;

import javax.persistence.Column;

import lombok.Data;

@Data
public class CustomerDataholder {

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
	 private Date mdob;
	 private int mage;
	 private int mbankacno;	
	 private String mbankacyn;	
	 private String mbankifsc;	
	 private String mbanknamelk;
	 private String mbankbranch;
	 private int mcuststatus;
	 private Date mdropoutdate;
	 private String mmobno;
	 private int mpanno;
	 private String mpannodesc;
	 private String mtdsyn;
	 private int mtdsreasoncd;	 
	 private Date mtdsfrm15subdt;		 
	 private String memailId;
	 private int mcustcategory;
	 private int mtier;
	 private String mAdd1;
	 private String mAdd2;
	 private String mAdd3;
	 private int mArea;
	 private String mPinCode;
	 private String mCounCd;
	 private String mCityCd;
	 private String mfname;
	 private String mmname;
	 private String mlname;
	 private String mgender;
	 private String mrelegion;
	 private int mRuralUrban;
	 private String mcaste;
	 private String mqualification;
	 private int moccupation;
	 private String mLandType;
	 private String mLandMeasurement;
	 private String mmaritialStatus;
	 private int mTypeOfId;
	 private String mIdDesc;
	 private String mloanAgreed;
	 private String mInsuranceCovYN;
	 private int mTypeofCoverage;	
	 private int mmemberno;
	 private String designation = "";
	 private String orgname = "";
	 private String yearsinorg = "";
	
}
