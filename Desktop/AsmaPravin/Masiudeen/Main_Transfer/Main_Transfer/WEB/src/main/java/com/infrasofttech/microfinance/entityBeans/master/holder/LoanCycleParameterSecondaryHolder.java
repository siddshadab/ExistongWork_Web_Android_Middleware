package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import org.hibernate.annotations.GenericGenerator;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class LoanCycleParameterSecondaryHolder extends BaseEntity{

      	
	private int mlbrcode;   	
     	
	private String mprdcd;  	
    	
	private int mloancycle; 	
     	
	private int mcusttype;  	
   	
	private int mgrtype;	
    
	private LocalDateTime meffdate; 	
   	
	private String mfrequency;	
   	
	private int mruletype;		  

	private int msrno;
	
	private Double muptoamount;	
	   	
	private Double mminamount;	
	   	
	private Double mmaxamount;	
	   	
	private LocalDateTime mlastsynsdate;
	
	private String merrormsg;
	
	private int merror;
}
