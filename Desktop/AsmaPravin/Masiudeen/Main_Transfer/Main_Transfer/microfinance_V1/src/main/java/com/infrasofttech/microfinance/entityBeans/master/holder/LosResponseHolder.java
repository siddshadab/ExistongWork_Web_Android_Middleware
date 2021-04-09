package com.infrasofttech.microfinance.entityBeans.master.holder;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class LosResponseHolder {
	
	@JsonIgnore
	@JsonProperty(value = "leadsId")
	private Long leadsId;
	@JsonIgnore
	@JsonProperty(value = "Status")
	private int Status; 
	@JsonIgnore
	@JsonProperty(value = "customerId")
	private Long customerId;
	@JsonIgnore
	@JsonProperty(value = "error")
	private String error;

	
	
/*	public Long getleadsid() {
		return leadsid;
	}
	public void setleadsid(Long leadsid) {
		this.leadsid = leadsid;
	}
	public int getstatus() {
		return status;
	}
	public void setstatus(int status) {
		this.status = status;
	}
	public Long getcustomerid() {
		return customerid;
	}
	public void setcustomerid(Long customerid) {
		this.customerid = customerid;
	}
	public String geterror() {
		return error;
	}
	public void seterror(String error) {
		this.error = error;
	}
*/
	
}
