package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import javax.persistence.Column;

import lombok.Data;

@Data
public class LoanApprovalHolder {


	public String mprdcd; 
	
	public Double mlimitamt = 0d;
	         	
	public int moverduedays;
	public Double mloanacmindrbal = 0d;

	public Double mloanacmincrbal = 0d;
	
	public Double mwriteoffamt = 0d;
		
	public String mremarks;	

	public Double mcheqlimitamt= 0d;

	public Double mminintrate= 0d;
	
	public Double mmaxintrate = 0d;
	  	
	public LocalDateTime mlastsynsdate;	

	public String mname;

	public LoanApprovalHolder(String mprdcd, Double mlimitamt,int moverduedays, Double mloanacmindrbal, Double mloanacmincrbal, Double mwriteoffamt, String mremarks,
			Double mcheqlimitamt, Double mminintrate, Double mmaxintrate, LocalDateTime mlastsynsdate, String mname) {
		super();

		this.mlimitamt = mlimitamt;
		this.moverduedays = moverduedays;
		this.mloanacmindrbal = mloanacmindrbal;
		this.mloanacmincrbal = mloanacmincrbal;
		this.mwriteoffamt = mwriteoffamt;
		this.mremarks = mremarks;
		this.mcheqlimitamt = mcheqlimitamt;
		this.mminintrate = mminintrate;
		this.mmaxintrate = mmaxintrate;
		this.mlastsynsdate = mlastsynsdate;
		this.mname = mname;
	}

	
	
	
}
