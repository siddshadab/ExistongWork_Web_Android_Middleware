package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class LookupComposieEntity   implements Serializable{
	

	
	
	@Override
	public String toString() {
		return "LookupComposieEntity [mcode=" + mcode + ", mcodetype=" + mcodetype + "]";
	}

	@Column(name = "mcode",  columnDefinition = "nvarchar(30)" )	
	private String mcode;		
	@Column(name = "mcodetype",  columnDefinition = "numeric(8)" )	
	private int mcodetype;	

	public LookupComposieEntity() {

	}


	public LookupComposieEntity(int codeType, String code) {
		this.mcodetype=codeType;
		this.mcode = code;
	}
	
	
	public int getmcodetype() {
		return mcodetype;
	}


	public void setmcodetype(int codeType) {
		this.mcodetype = codeType;
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
	if(! (obj instanceof LookupComposieEntity)){
		return false;
	}
	
	return Objects.equals(getmcodetype(), this.getmcodetype()) &&
            Objects.equals(getmcode(), this.getmcode());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmcodetype(),getmcode());
	}


	

}
