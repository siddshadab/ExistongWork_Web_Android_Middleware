package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;
import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Data
public class ProductMasterHolder extends BaseEntity{

	private int mlbrcode;   
	private String mprdcd;  
	private String mname;   
	private double mintrate;
	private int mmoduletype;
	private String mcurcd; 
	private LocalDateTime mlastsynsdate;
	private String mdivisiontype;
	private int mnoofguaranter;	
	
	private int merror;
	private String merrormsg;
	
	List<ProductMasterHolder> code ;
	
//	List<Integer> mlbrcd;
//	List<String> mprcode;
	
}
