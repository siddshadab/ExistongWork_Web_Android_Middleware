package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class SystemParameterCompositeEntity   implements Serializable{
	


	@Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0" )	
	private int mlbrcode = 0;		
	
    @Column(name = "mcode", columnDefinition ="nvarchar(30) default ''" ) 
    private String mcode = "";  
	
	

	public SystemParameterCompositeEntity() {

	}


	public SystemParameterCompositeEntity(int lbrcode, String code) {
		this.mlbrcode=lbrcode;
		this.mcode = code;
	}
	
	
	public int getmlbrcode() {
		return mlbrcode;
	}


	public void setmlbrcode(int codeType) {
		this.mlbrcode = codeType;
	}


	public String getmcode() {
		return mcode;
	}


	public void setmcode(String code) {
		this.mcode = code;
	}
	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof SystemParameterCompositeEntity)){
		return false;
	}
	
	return Objects.equals(getmlbrcode(), this.getmlbrcode()) &&
            Objects.equals(getmcode(), this.getmcode());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmlbrcode(),getmcode());
	}


	

}
