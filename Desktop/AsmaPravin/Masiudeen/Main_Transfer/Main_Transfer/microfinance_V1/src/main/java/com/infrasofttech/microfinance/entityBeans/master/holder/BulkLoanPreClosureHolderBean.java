package com.infrasofttech.microfinance.entityBeans.master.holder;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class BulkLoanPreClosureHolderBean extends BaseEntity {	
	
	private int mgroupcd;
	private int mlbrcode;
	private int mcustno;
	private String mcustname;
	private String mprdacctid;
	private String minststartdt;
	private double mexcessamt;
	private double minstlamt;
	private double mamttocollect;
	private double mprincipleos;
	private double minterestos;
	private double mcollamt;
	private String momnimsg;
	private String mremarks;
	private String mentrydt;
	private String mbatchcd;
	private int msetno;
	private String mcurcd;
	private double mclosureamtpaid;
}
