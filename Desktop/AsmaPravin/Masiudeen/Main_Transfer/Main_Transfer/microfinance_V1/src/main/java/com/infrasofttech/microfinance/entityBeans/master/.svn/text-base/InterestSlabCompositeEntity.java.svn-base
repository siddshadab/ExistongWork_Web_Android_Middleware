package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class InterestSlabCompositeEntity   implements Serializable{
	

	
	
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(30)" )	
	private String mprdcd;		
	@Column(name = "mcurcd",  columnDefinition = "nvarchar(8)" )	
	private String mcurcd;	
	@Column(name = "minteffdt" )	
	private LocalDateTime minteffdt;
	@Column(name = "msrno",  columnDefinition = "numeric(8)" )	
	private int msrno;

	public InterestSlabCompositeEntity() {

	}


	public InterestSlabCompositeEntity(String prdcd, String curcd,LocalDateTime inteffdt ,int srno) {
		this.mprdcd=prdcd;
		this.mcurcd = curcd;
		this.minteffdt=inteffdt;
		this.msrno=srno;
	}
	
	
	public String getmprdcd() {
		return mprdcd;
	}


	public void setmprdcd(String prdcd) {
		this.mprdcd = prdcd;
	}


	public String getmcurcd() {
		return mcurcd;
	}


	public void setmcurcd(String curcd) {
		this.mcurcd = curcd;
	}

	public LocalDateTime getminteffdt() {
		return minteffdt;
	}


	public void setminteffdt(LocalDateTime inteffdt) {
		this.minteffdt = inteffdt;
	}
	public int getmsrno() {
		return msrno;
	}


	public void setmsrno(int srno) {
		this.msrno = srno;
	}
	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof CustomerCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getmprdcd(), this.getmprdcd()) &&
            Objects.equals(getmcurcd(), this.getmcurcd()) &&
            Objects.equals(getminteffdt(), this.getminteffdt()) &&
            Objects.equals(getmsrno(), this.getmsrno());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmprdcd(),getmcurcd(),getminteffdt(),getmsrno());
	}


	

}
