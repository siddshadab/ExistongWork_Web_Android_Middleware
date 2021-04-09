package com.infrasofttech.microfinance.entityBeans.master.holder;
import java.time.LocalDateTime;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class MiniStatementHolderBean extends BaseEntity {	
	
	private int mlbrcode; 
	private String mprdacctid;
	private String mbramchname;
	private double mlcytrnamt= 0d;
	private double macttotballcy= 0d;
	private double mtotallienfcy= 0d;
	private String mentrydate;	
	private String mdrcr;
	private String mlongname;
	private String mparticulars;




}
