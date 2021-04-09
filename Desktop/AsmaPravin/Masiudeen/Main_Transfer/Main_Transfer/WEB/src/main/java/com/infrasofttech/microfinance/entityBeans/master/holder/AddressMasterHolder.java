package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.util.List;

import lombok.Data;

@Data
public class AddressMasterHolder {

	
	
	//private 
	
	int merror;
	String Merrormsg;
	
	//country
	private List<String> mcountryid;
	
	//State
	private List<String> mstatecd;
	
	//district
	private List<Integer> mdistcd;
	
	//sub-dist
	private List<String> mplacecd;
	
}
