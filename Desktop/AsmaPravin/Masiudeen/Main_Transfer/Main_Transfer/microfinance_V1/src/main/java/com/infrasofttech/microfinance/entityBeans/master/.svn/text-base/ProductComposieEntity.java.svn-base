package com.infrasofttech.microfinance.entityBeans.master;


import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class ProductComposieEntity   implements Serializable{
	

	
	
	@Column(name = "mlbrcode", nullable = false,  columnDefinition = "numeric(8)")
	private int mlbrcode;   	 	

	@Column(name = "mprdcd",  nullable = false, columnDefinition = "nvarchar(8)")               
	private String mprdcd;   
	
	public int getMlbrcode() {
		return mlbrcode;
	}


	public void setMlbrcode(int mlbrcode) {
		this.mlbrcode = mlbrcode;
	}


	public String getMprdcd() {
		return mprdcd;
	}


	public void setMprdcd(String mprdcd) {
		this.mprdcd = mprdcd;
	}


	public ProductComposieEntity() {

	}


	public ProductComposieEntity(int mlbrcode, String mprdcd) {
		this.mlbrcode=mlbrcode;
		this.mprdcd = mprdcd;
	}
	
	

	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof ProductComposieEntity)){
		return false;
	}
	
	return Objects.equals(getMlbrcode(), this.getMlbrcode()) &&
            Objects.equals(getMprdcd(), this.getMprdcd());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getMlbrcode(),getMprdcd());
	}


	

}
