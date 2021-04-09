package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class TDClosureHolder   extends BaseEntity{

	private int mlbrcode;
	private  String mprdacctid;
	private  String maccountopenningdt;
	private  LocalDateTime mmatdt;
	private  double mmatamt;
	private  double mintrate;
	private double mtds;
	
	private double mmatintamt;
	
	
	private  double mclosintamt;
	private  LocalDateTime mclosdt;
	private  double mclosmatamt;
	private  double mclosintrate;
	private double mclostds;
	
	private LocalDateTime mbranchoperdt;
	
	
	
	private  double mdepositamt;
	private  double mmainbal;
	private double mintprovided;
	private String merrormessage;
	private int mstatus;
	private String mcreatedby;
	private String mlongname;
	private double mcalintamount;
	
	private int mcshorsav;
	
	private  String mselectedsavingacc;
	
	
	
	
}
