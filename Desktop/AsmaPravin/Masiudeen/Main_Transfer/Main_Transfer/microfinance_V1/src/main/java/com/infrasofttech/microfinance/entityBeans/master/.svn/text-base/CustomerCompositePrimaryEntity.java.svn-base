package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;


@Embeddable
public class CustomerCompositePrimaryEntity  implements Serializable{


	@Column(nullable = false)
	private Long customerNumberOfTab;
	@Column
	private String usrCode;	

	public CustomerCompositePrimaryEntity() {

	}


	public CustomerCompositePrimaryEntity(Long customerNumberOfTab, String usrCode) {
		this.customerNumberOfTab=customerNumberOfTab;
		this.usrCode = usrCode;
	}
	
	
	public Long getCustomerNumberOfTab() {
		return customerNumberOfTab;
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
	if(! (obj instanceof CustomerCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getCustomerNumberOfTab(), this.getCustomerNumberOfTab()) &&
            Objects.equals(getUsrCode(), this.getUsrCode());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getCustomerNumberOfTab(),getUsrCode());
	}


	
	
}
