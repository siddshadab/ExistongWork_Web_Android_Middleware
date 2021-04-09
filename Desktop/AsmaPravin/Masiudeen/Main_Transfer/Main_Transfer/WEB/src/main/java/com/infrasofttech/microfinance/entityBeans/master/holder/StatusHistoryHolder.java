package com.infrasofttech.microfinance.entityBeans.master.holder;


import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT1Entity;

import lombok.Data;

@Data
public class StatusHistoryHolder {	
	
	
	@JsonIgnore
	@JsonProperty(value = "mcustno")
	private int mcustno;
	@JsonIgnore
	@JsonProperty(value = "mleadsid")
	private String mleadsid;
	@JsonIgnore
	@JsonProperty(value = "mleadsstatus")
	private int mleadsstatus;
	@JsonIgnore
	@JsonProperty(value = "mleadsstatusdesc")
	private String mleadsstatusdesc;
	@JsonIgnore
	@JsonProperty(value = "mleadsstage")
	private String mleadsstage;
	@JsonIgnore
	@JsonProperty(value = "mproductacctid")
	private String mproductacctid;	
	@JsonIgnore
	@JsonProperty(value = "mstarttime")
	private LocalDateTime mstarttime;
	@JsonIgnore
	@JsonProperty(value = "mendtime")
	private LocalDateTime mendtime;
	@JsonIgnore
	@JsonProperty(value = "mroutefrom")
	private String mroutefrom;
	@JsonIgnore
	@JsonProperty(value = "mrouteto")
	private String mrouteto;
	@JsonIgnore
	@JsonProperty(value = "mremark")
	private String mremark;
	@JsonIgnore
	@JsonProperty(value = "mcreateddt")
	private LocalDateTime mcreateddt;
	@JsonIgnore
	@JsonProperty(value = "mcreatedby")
	private String mcreatedby;
	@JsonIgnore
	@JsonProperty(value = "mlastupdatedt")
	private LocalDateTime mlastupdatedt;
	@JsonIgnore
	@JsonProperty(value = "mlastupdateby")
	private String mlastupdateby;	
	@JsonIgnore
	@JsonProperty(value = "mgeolocation")
	private String mgeolocation;	
	@JsonIgnore
	@JsonProperty(value = "mgeolatd")
	private String mgeolatd;	
	@JsonIgnore
	@JsonProperty(value = "mgeologd")
	private String mgeologd;	
	@JsonIgnore
	@JsonProperty(value = "mlastsynsdate")
	private LocalDateTime mlastsynsdate;
	@JsonIgnore
	@JsonProperty(value = "mresponsestatuscd")
	private int mresponsestatuscd;
	@JsonIgnore
	@JsonProperty(value = "mresponsestatusmessage")
	private String mresponsestatusmessage;
	@JsonIgnore
	@JsonProperty(value = "mauthcd")
	private int mauthcd;


	
	
}
