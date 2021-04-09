package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;

import javax.persistence.Column;

public interface LoanApprovalLimitPrm {

	public  int getMlbrcode();	   	
	public int getMgrpcd();  	  	
	public String getMusercd();              	
	public int getMsrno(); 
	
	public String getMprdcd(); 		
	public Double getMlimitamt();		         	
	public int getMoverduedays();
	public Double getMloanacmindrbal();
	public Double getMloanacmincrbal();		
	public Double getMwriteoffamt();			
	public String getMremarks();	
	public Double getMcheqlimitamt();
	public Double getMminintrate();		
	public Double getMmaxintrate();		  	
	public LocalDateTime getMlastsynsdate();
	public String getMprdname(); 
}
