package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;

public class TDParameterCompositeEntity implements Serializable {

	@Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0" )	
	private int mlbrcode;	
	
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(30)" )	
	private String mprdcd;		
	
	
	

	public TDParameterCompositeEntity() {

	}


	public TDParameterCompositeEntity(int mlbrcode, String mprdcd ) {
		this.mlbrcode=mlbrcode;
		this.mprdcd=mprdcd;
	
	}
	
	
	public int getmlbrcode() {
		return mlbrcode;
	}


	public void setmlbrcode(int mlbrcode) {
		this.mlbrcode = mlbrcode;
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
	if(! (obj instanceof TDParameterCompositeEntity)){
		return false;
	}
	
	return Objects.equals(getmprdcd(), this.getmprdcd()) &&
            Objects.equals(getmlbrcode(), this.getmlbrcode());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmprdcd(),getmlbrcode());
	}


	
	
	
	
	
	
}
