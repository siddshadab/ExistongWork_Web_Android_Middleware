package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class TDOffsetInterstSlabHolder extends BaseEntity{

	private int mlbrcode;	
	
	private String mprdcd;		
	
	private int maccttype;	
	
	private LocalDateTime meffdate;
	
	private int msrno;		
		
	private String mcurcd;    
	
	private int mdays;
    
	private int mmonths;
    
	private Double minvamtfrm;	
	
	private Double muptoamt;  
	
	private Double mlowertollimit;
	
	private Double muppertollimit;	
	
	private Double moffsetintrate;		
	
	private LocalDateTime mmlastsynsdate;
	
	private int merror;
	
	private String merrormsg;
	
}
