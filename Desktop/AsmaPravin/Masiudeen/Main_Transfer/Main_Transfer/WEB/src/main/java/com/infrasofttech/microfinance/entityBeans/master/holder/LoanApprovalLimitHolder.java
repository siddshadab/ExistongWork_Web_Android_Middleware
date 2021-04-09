package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;
import java.util.List;

import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitCompositeEntity;

import lombok.Data;

@Data
public class LoanApprovalLimitHolder {

	public int mlbrcode;	
	public int mgrpcd; 	
	public String musercd;    
	public int msrno;  
	public String mprdcd; 	
	public Double mlimitamt;	
	public int moverduedays;	
	public Double mloanacmindrbal;	
	public Double mloanacmincrbal;	
	public Double mwriteoffamt;	
	public String mremarks;		
	public Double mcheqlimitamt;	
	public Double mminintrate;	
	public Double mmaxintrate;	
	public LocalDateTime mlastsynsdate;
	public String mname;
	public int merror;
	public String merrormsg;
	
	List<LoanApprovalLimitCompositeEntity> code;

	
	
	
}
