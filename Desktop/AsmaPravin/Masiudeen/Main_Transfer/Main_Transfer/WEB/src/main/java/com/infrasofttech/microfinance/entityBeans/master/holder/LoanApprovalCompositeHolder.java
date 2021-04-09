package com.infrasofttech.microfinance.entityBeans.master.holder;

import lombok.Data;

@Data
public class LoanApprovalCompositeHolder {
	public int mlbrcode;	
	public int mgrpcd; 	
	public String musercd;    
	public int msrno;
	
	public LoanApprovalCompositeHolder(int mlbrcode, int mgrpcd, String musercd, int msrno) {
		super();
		this.mlbrcode = mlbrcode;
		this.mgrpcd = mgrpcd;
		this.musercd = musercd;
		this.msrno = msrno;
	} 
	
	
}
