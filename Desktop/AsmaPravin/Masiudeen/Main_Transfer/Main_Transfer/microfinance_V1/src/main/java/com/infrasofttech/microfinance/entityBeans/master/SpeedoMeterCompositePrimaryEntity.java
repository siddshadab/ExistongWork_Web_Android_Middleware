package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;


@Embeddable
public class SpeedoMeterCompositePrimaryEntity  implements Serializable{


	@Column(nullable = false)
	private String usrname;	
	@Column 
	private LocalDate effdate;	
	

	public SpeedoMeterCompositePrimaryEntity() {

	}


	public SpeedoMeterCompositePrimaryEntity(String usrname, LocalDate effdate) {
		this.usrname = usrname;
		this.effdate = effdate;
	}
	
	
	public String getUsrname() {
		return usrname;
	}


	public void setUsrname(String usrname) {
		this.usrname = usrname;
	}


	public LocalDate getEffdate() {
		return effdate;
	}


	public void setEffdate(LocalDate effdate) {
		this.effdate = effdate;
	}


	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof SpeedoMeterCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getUsrname(), this.getUsrname()) &&
			Objects.equals(getEffdate(), this.getEffdate()) ;

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getUsrname(),getEffdate());
	}


	
	
}
