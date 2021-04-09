package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class LookupComposieEntity   implements Serializable{
	

	
	
	@Column(name = "mcode",  columnDefinition = "nvarchar(30)" )	
	private String mcode;		
	@Column(name = "mcodetype",  columnDefinition = "numeric(8)" )	
	private int mcodetype;	
	@Column(name = "mfield1value",  columnDefinition = "nvarchar(30) default '' " )	
	private String mfield1value = "";	

	public LookupComposieEntity() {

	}


	public LookupComposieEntity(int codeType, String code,String mfield1value ) {
		this.mcodetype=codeType;
		this.mcode = code;
		this.mfield1value = mfield1value;
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
	
	
	
	
	public String getMfield1value() {
		return mfield1value;
	}


	public void setMfield1value(String mfield1value) {
		this.mfield1value = mfield1value;
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
            Objects.equals(getmcode(), this.getmcode()) &&
            Objects.equals(getMfield1value(), this.getMfield1value())
            ;

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmcodetype(),getmcode());
	}


	@Override
	public String toString() {
		return "LookupComposieEntity [mcode=" + mcode + ", mcodetype=" + mcodetype + ", mfield1value=" + mfield1value
				+ "]";
	}


	

}
