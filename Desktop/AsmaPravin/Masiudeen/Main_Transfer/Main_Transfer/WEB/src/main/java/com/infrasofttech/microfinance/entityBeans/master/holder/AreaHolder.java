package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;
@Data
public class AreaHolder extends BaseEntity{
	
	private int mareacd;
	
	private String mplacecd;
		 
	private String mareadesc;	
	
	private int merror;
	
	private String merrormsg;
}
