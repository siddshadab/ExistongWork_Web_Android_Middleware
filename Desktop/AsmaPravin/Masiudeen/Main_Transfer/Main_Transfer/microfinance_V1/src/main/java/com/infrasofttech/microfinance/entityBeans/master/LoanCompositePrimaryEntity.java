package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;

public class LoanCompositePrimaryEntity implements Serializable{

	
	@Column(nullable = false)
	private Long customerNumberOfTab;
	@Column
	private String usrCode;
	@Column(nullable = false)
	private Long loanNumberOfTab;
	

	public LoanCompositePrimaryEntity() {

	}


	public LoanCompositePrimaryEntity(Long customerNumberOfTab, String usrCode) {
		this.customerNumberOfTab=customerNumberOfTab;
		this.usrCode = usrCode;
	}
	public LoanCompositePrimaryEntity(Long customerNumberOfTab, String usrCode,Long loanNumberOfTab) {
		this.customerNumberOfTab=customerNumberOfTab;
		this.usrCode = usrCode;
		this.loanNumberOfTab = loanNumberOfTab;
	}
	
	public Long getCustomerNumberOfTab() {
		return customerNumberOfTab;
	}


	public Long getLoanNumberOfTab() {
		return loanNumberOfTab;
	}


	public void setLoanNumberOfTab(Long loanNumberOfTab) {
		this.loanNumberOfTab = loanNumberOfTab;
	}


	public void setCustomerNumberOfTab(Long customerNumberOfTab) {
		this.customerNumberOfTab = customerNumberOfTab;
	}


	public String getUsrCode() {
		return usrCode;
	}


	public void setUsrCode(String usrCode) {
		this.usrCode = usrCode;
	}
	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof LoanCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getCustomerNumberOfTab(), this.getCustomerNumberOfTab()) &&
            Objects.equals(getUsrCode(), this.getUsrCode())&&Objects.equals(getLoanNumberOfTab(), this.getLoanNumberOfTab());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getLoanNumberOfTab(),getUsrCode(),getLoanNumberOfTab());
	}


}
