package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;


@Embeddable
public class CGTCompositePrimaryEntity  implements Serializable{


	@Column(nullable = false)
	private Long id;
	@Column
	private Long loanNumber;	
	@Column
	private String usrCode;	

	public CGTCompositePrimaryEntity() {

	}


	public CGTCompositePrimaryEntity(Long id,Long loanNumber, String usrCode) {
		this.id=id;
		this.loanNumber = loanNumber;
		this.usrCode = usrCode;
	}
	
	

	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public Long getLoanNumber() {
		return loanNumber;
	}


	public void setLoanNumber(Long loanNumber) {
		this.loanNumber = loanNumber;
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
	if(! (obj instanceof CGTCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getId(), this.getId()) &&
			Objects.equals(getLoanNumber(), this.getLoanNumber()) &&
            Objects.equals(getUsrCode(), this.getUsrCode());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getId(),getLoanNumber(),getUsrCode());
	}


	
	
}
