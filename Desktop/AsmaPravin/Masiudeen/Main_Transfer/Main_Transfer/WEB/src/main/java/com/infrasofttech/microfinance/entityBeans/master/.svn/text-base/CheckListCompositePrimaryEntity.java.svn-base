package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;


@Embeddable
public class CheckListCompositePrimaryEntity  implements Serializable{


	@Column(nullable = false)
	private Long id;		
	@Column
	private String usrCode;	
	@Column(insertable = false, updatable = false)
	private Long loanNumber;	

	public CheckListCompositePrimaryEntity() {

	}


	public CheckListCompositePrimaryEntity(Long id,Long loanNumber, String usrCode ){
		this.id=id;		
		this.usrCode = usrCode;
		this.loanNumber= loanNumber;
	}
	
	

	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getUsrCode() {
		return usrCode;
	}

	

	public void setUsrCode(String usrCode) {
		this.usrCode = usrCode;
	}
	
	public void setLoanNumber(Long loanNumber) {
		this.loanNumber = loanNumber;
	}
	
	public Long getLoanNumber() {
		return loanNumber;
	}

	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof CheckListCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getId(), this.getId()) &&			
            Objects.equals(getUsrCode(), this.getUsrCode()) &&  Objects.equals(getLoanNumber(), this.getLoanNumber());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getId(),getUsrCode(),getLoanNumber());
	}


	
	
}
