package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;

public class ProspectCompositeLoanEntity implements Serializable {
	
	@Column(nullable = false)
	private Long adhaarNo;
	@Column
	private String agentUserName;
	@Column
	private  Long loanDetailSeq;
	
	
	
	public ProspectCompositeLoanEntity() {

	}


	public ProspectCompositeLoanEntity(Long adhaarNo, String agentUserName) {
		this.adhaarNo=adhaarNo;
		this.agentUserName = agentUserName;
	}
	public ProspectCompositeLoanEntity(Long segmentIdentifier, String agentUserName,Long adhaarNo) {
		this.loanDetailSeq=loanDetailSeq;
		this.agentUserName = agentUserName;
		this.adhaarNo = adhaarNo;
	}
	
	public Long getLoanDetailSeq() {
		return loanDetailSeq;
	}


	public Long getAdhaarNo() {
		return adhaarNo;
	}


	public void setAdhaarNo(Long adhaarNo) {
		this.adhaarNo = adhaarNo;
	}


	public void setLoanDetailSeq(Long loanDetailSeq) {
		this.loanDetailSeq = loanDetailSeq;
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
	if(! (obj instanceof ProspectCompositeLoanEntity)){
		return false;
	}
	
	return Objects.equals(getLoanDetailSeq(), this.getLoanDetailSeq()) &&
            Objects.equals(getAgentUserName(), this.getAgentUserName())&&Objects.equals(getAdhaarNo(), this.getAdhaarNo());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getAdhaarNo(),getAgentUserName(),getAdhaarNo());
	}

	

}
