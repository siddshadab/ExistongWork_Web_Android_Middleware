package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class CIFSavingAuthHolder extends BaseEntity {

	  private String musercode;
	  private int missynctocoresys;
	  private String mcustname;
	  private double msubmitamt;
	  private String merrormessage;
	  private String mcreatedby;
	  private int response;
	  
	  private int mlbrcode;
	  private LocalDateTime mtxndate;
	  private String msavingacctno;
	  private double macttotbalfcy ;
	  private double mtotallienfcy ; 
	  private double mwithdrawalamt;
	  private String  mremarks ; 
	  private LocalDateTime mentrydate;
	  private String  mbatchcd  ;
	  private int msetno;
	  
}
