package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;

import lombok.EqualsAndHashCode;

public class ReportFilterCompositeEntity  implements Serializable{
	
	@Column(name = "mchartid",  nullable = false, columnDefinition = "numeric(8)")               
	private int mchartid = 0;	
	@Column(name = "mfieldname",  columnDefinition = "NVarChar(20) default ''")
	private String mfieldname = "";
	public int getMchartid() {
		return mchartid;
	}
	public void setMchartid(int mchartid) {
		this.mchartid = mchartid;
	}
	public String getMfieldname() {
		return mfieldname;
	}
	public void setMfieldname(String mfieldname) {
		this.mfieldname = mfieldname;
	}
	
	@Override
	public boolean equals(Object obj) {
		if(this==obj) {
			return true;
		}
		else if(! (obj instanceof ReportFilterCompositeEntity) ) {
			return false;
		}
		return Objects.equals(getMchartid(),this.mchartid)&&Objects.equals(getMfieldname(),this.mfieldname);
	}

	@Override
	public int hashCode() {
		
		return Objects.hash(getMchartid(),getMfieldname());
		
	}
	

}
