package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;
import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;


@Data
public class LoanCyclePrimarySecondaryHolder extends BaseEntity {
	
	//primary 
	private int mlbrcode;		

	private String mprdcd;
	
    private LocalDateTime meffdate;  
    
    private int mloancycle;
	
	private int mcusttype;        	

	private int mgrtype;	
	
	private Double mminamount;  	
	
	private Double mmaxamount;    	
	
	private int mminperiod;       	
	
	private int mmaxperiod;       	
	
	private int mminnoofgrpmems;  	
	
	private int mmaxnoofgrpmems;  	
	
	private String mgender;       	
	
	private int mminage;          	
	
	private int mmaxage;          	
	
	private String mgrpcycyn;    	
	
	private int mlogic;           	
	
	private int mtenor;           	
	
	private String mfrequency;    	
	
	private Double mincramount;   	
	
	private int mnoofinstlclosure;	
	
	private int mmultiplefactor;  	
	
	//private LocalDateTime mlastsynsdate;
	
	//secodary
   	
	private int mruletype;	
	            	
	private int msrno;	
	   	
	private Double muptoamount;	
	   	
	//private Double mminamount;	
	   	
	//private Double mmaxamount;	
	   	
	//private LocalDateTime mlastsynsdate;
	
	private int merror;
	
	private String merrormsg;
	
	private List<LoanCyclePrimarySecondaryHolder> code;
	
	
}
