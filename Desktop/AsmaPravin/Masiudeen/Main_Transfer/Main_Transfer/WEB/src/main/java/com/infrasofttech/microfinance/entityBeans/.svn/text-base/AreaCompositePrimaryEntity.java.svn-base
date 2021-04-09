package com.infrasofttech.microfinance.entityBeans;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;


@Embeddable
public class AreaCompositePrimaryEntity  implements Serializable{
	
	@Column(nullable = true , columnDefinition = "numeric(11) default 0")
	private int mareacd;
	
	@Column(columnDefinition = "NVarChar(6)")
	private String mplacecd;
	

	public AreaCompositePrimaryEntity() {

	}


	public AreaCompositePrimaryEntity(int mareacd, String mplacecd) {
		this.mareacd = mareacd;
		this.mplacecd = mplacecd;
	}
	
	
	


	public int getMareacd() {
		return mareacd;
	}


	public void setMareacd(int mareacd) {
		this.mareacd = mareacd;
	}


	public String getMplacecd() {
		return mplacecd;
	}


	public void setMplacecd(String mplacecd) {
		this.mplacecd = mplacecd;
	}


	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof AreaCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getMareacd(), this.getMplacecd()) &&
			Objects.equals(getMareacd(), this.getMplacecd()) ;

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getMareacd(),getMplacecd());
	}


	
	
}
