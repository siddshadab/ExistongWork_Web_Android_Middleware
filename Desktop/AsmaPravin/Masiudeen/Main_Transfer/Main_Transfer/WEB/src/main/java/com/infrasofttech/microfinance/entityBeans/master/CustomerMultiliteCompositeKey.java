package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;


@Embeddable
public class CustomerMultiliteCompositeKey  implements Serializable{

	@Column(nullable = false)
	private Long idVal;
	@Column(nullable = false)
	private Long customerNumberOfTabMultiline;
	@Column
	private String usrCodeMultiline;	

	public CustomerMultiliteCompositeKey() {

	}


	public CustomerMultiliteCompositeKey(Long idVal,Long customerNumberOfTabMultiline, String usrCodeMultiline) {
		this.idVal=idVal;
		this.customerNumberOfTabMultiline=customerNumberOfTabMultiline;
		this.usrCodeMultiline = usrCodeMultiline;
	}
	
	public Long getId() {
		return customerNumberOfTabMultiline;
	}


	public void setId(Long idVal) {
		this.idVal = idVal;
	}

	
	public Long getCustomerNumberOfTab() {
		return customerNumberOfTabMultiline;
	}


	public void setCustomerNumberOfTab(Long customerNumberOfTab) {
		this.customerNumberOfTabMultiline = customerNumberOfTab;
	}


	public String getUsrCode() {
		return usrCodeMultiline;
	}


	public void setUsrCode(String usrCodeMultiline) {
		this.usrCodeMultiline = usrCodeMultiline;
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
            Objects.equals(getUsrCode(), this.getUsrCode()) &&
            Objects.equals(getId(), this.getId());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getCustomerNumberOfTab(),getUsrCode(),getId());
	}


	
	
}
