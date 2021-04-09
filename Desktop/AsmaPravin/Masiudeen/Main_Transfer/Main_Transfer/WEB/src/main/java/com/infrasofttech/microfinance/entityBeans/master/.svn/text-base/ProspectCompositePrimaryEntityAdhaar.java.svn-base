package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;

public class ProspectCompositePrimaryEntityAdhaar implements Serializable{

	@Column(nullable = false)
	private Long adhaarNo;
	@Column
	private String agentUserName;	

	public ProspectCompositePrimaryEntityAdhaar() {

	}


	public ProspectCompositePrimaryEntityAdhaar(Long adhaarNo, String agentUserName) {
		this.adhaarNo=adhaarNo;
		this.agentUserName = agentUserName;
	}
	
	
	public Long getAdhaarNo() {
		return adhaarNo;
	}


	public void setAdhaarNo(Long segmentIdentifier) {
		this.adhaarNo = segmentIdentifier;
	}


	public String getAgentUserName() {
		return agentUserName;
	}


	public void setAgentUserName(String agentUserName) {
		this.agentUserName = agentUserName;
	}
	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof ProspectCompositePrimaryEntityAdhaar)){
		return false;
	}
	
	return Objects.equals(getAdhaarNo(), this.getAdhaarNo()) &&
            Objects.equals(getAgentUserName(), this.getAgentUserName());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getAdhaarNo(),getAgentUserName());
	}



}
