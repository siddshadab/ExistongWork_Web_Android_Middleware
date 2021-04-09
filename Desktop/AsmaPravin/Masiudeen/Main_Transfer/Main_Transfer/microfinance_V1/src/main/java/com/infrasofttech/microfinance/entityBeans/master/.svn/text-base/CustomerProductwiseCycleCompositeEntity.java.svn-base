package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class CustomerProductwiseCycleCompositeEntity   implements Serializable{
	

	
	
	@Column(name = "mcustno",  columnDefinition = "numeric(8)" )      	
	private int mcustno;   	
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(8)" )     	
	private String mprdcd;  	


	public CustomerProductwiseCycleCompositeEntity() {

	}


	public CustomerProductwiseCycleCompositeEntity(int custno, String prdcd) {
		this.mcustno=custno;
		this.mprdcd=prdcd;

	}
	
	
	public int getmcustno() {
		return mcustno;
	}


	public void setmcustno(int custno) {
		this.mcustno = custno;
	}


	public String getmprdcd() {
		return mprdcd;
	}


	public void setmprdcd(String prdcd) {
		this.mprdcd = prdcd;
	}
	



	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof CustomerProductwiseCycleCompositeEntity)){
		return false;
	}
	
	return Objects.equals(getmcustno(), this.getmcustno()) &&
            Objects.equals(getmprdcd(), this.getmprdcd()
);

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmcustno(),getmprdcd());
	}


	

}
