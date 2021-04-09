package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class CIFHolderBean extends BaseEntity {	
	
	private int mcustno;
	private String mnid;
	private int mlbrcode;
	private String mprdacctid;	
	private int mmoduletype;
	private int macctstat;
	private int mtier;
	private double mshadowclearbal; 
	private double mshadowtotalbal; 
	private double mactualclearbal; 
	private double mactualtotalbal; 
	private double mlienamt; 
	private double mmainbal; 
	//private double minterestamt; 
	private double mtdsamt; 	
	private String mnametitle;
	private String mlongname;
	private double minterestprov; 
	private double minterestpaid; 
	private double mmaturityvalue; 
	private double mpenalprov; 
	private double mpenalpaid; 
	private double mdisbursedamt; 
	private double mexcessamt;
	private int msrno;
	private String mwsenddate;
	private double mwseffcontractamt;
	private double mwsintamount;
	private double mwsidealbal;
	private double mwsopenbal;
	private int mfreezetype;
	private String mleadsid;
	private String mbranchname;
	private String musrcode;
	private String merror;
	private String mpannodesc;
	private int mcuststatus;
	private double mprinccurrdue;
	private double mprincoverdue;
	private double mintdue;
	
	private String mopendate;
	private double mlcybal;
	private double mtotallien;
	private double mintapplied;
	private String macctstatdesc;
	private String momnimsg;
	
	private String mbatchcd; 
	private int msetno; 
	private double mlcytrnamt;
	private String mdisbursedflag;
	private LocalDateTime mdisbursmentdate;
	private LocalDateTime moperationdate;
	private String mval;
	private String mentrydate;


}
