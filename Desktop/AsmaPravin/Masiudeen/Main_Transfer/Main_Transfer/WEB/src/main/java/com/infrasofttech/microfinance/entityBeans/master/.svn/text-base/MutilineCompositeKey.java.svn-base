package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class MutilineCompositeKey implements Serializable{

	@Column(nullable = false)
	private Long customerNumberTab;
	@Column
	private Long idValue;
	@Column
	private String userCode;	

	public MutilineCompositeKey() {

	}


	public MutilineCompositeKey(Long idValue, Long customerNumberOfTab,String usrCode) {
		this.idValue=idValue;
		this.userCode = usrCode;
		this.customerNumberTab = customerNumberOfTab;
	}
	
	
	public Long getCustomerNumberOfTab() {
		return customerNumberTab;
	}


	public void setCustomerNumberOfTab(Long customerNumberOfTab) {
		this.customerNumberTab = customerNumberOfTab;
	}
	
	public Long getId() {
		return idValue;
	}


	public void setId(Long idValue) {
		this.idValue = idValue;
	}


	public String getUsrCode() {
		return userCode;
	}


	public void setUsrCode(String usrCode) {
		this.userCode = usrCode;
	}
	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof CustomerCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getId(), this.getId()) &&
            Objects.equals(getUsrCode(), this.getUsrCode()) && Objects.equals(getCustomerNumberOfTab(), this.getCustomerNumberOfTab());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getId(),getUsrCode(),getCustomerNumberOfTab());
	}


	
	
}
