package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
@Embeddable
public class ProspectCompositePrimaryEntity implements Serializable{

	

	@Column(unique = true, nullable = false)
	private Long adhaarNo;
	@Column
	private String agentUserName;	

	public ProspectCompositePrimaryEntity() {

	}


	public ProspectCompositePrimaryEntity(Long segmentIdentifier, String agentUserName) {
		this.adhaarNo=segmentIdentifier;
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
	if(! (obj instanceof ProspectCompositePrimaryEntity)){
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
