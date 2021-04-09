package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.util.List;

import lombok.Data;

@Data
public class DeleteBranchHolder {
	
	private int  merror;
	private String merrormsg;
	private List<Integer> mpbrcode;
}
