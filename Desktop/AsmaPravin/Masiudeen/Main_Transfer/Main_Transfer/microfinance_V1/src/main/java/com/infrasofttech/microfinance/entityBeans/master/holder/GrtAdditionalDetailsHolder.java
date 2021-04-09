package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class GrtAdditionalDetailsHolder {
	private String mleadsid;
	private LocalDateTime minststrtdt;
	private LocalDateTime minstEndDate;
	private double  msdamount;
	private String merrormessage;
	private int missynctocoresys;
	private double  mcusrrentsavingbal;
	private double  mleinamount;
	
	

}
