package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "DataSourceMaster")
@Data
public class DataSourceMasterEntity {

	@Id
	@Column(name = "msystemid", unique = true, nullable = false, columnDefinition = "NVarChar(30) default ''")
	private String msystemid;
	
	@Column(name = "muserid", columnDefinition = "NVarChar(30) default ''")
	private String muserid;

	@Column(name = "mpassword", columnDefinition = "NVarChar(30) default ''")
	private String mpassword;

	@Column(name = "murl", columnDefinition = "NVarChar(150) default ''")
	private String murl;
	
	@Column(name = "mdatabase", columnDefinition = "NVarChar(30) default ''")
	private String mdatabase = "";
	
	@Column(name = "mservertype", columnDefinition = "NVarChar(30) default ''")
	private String mservertype;
	
	
	@Column(name = "mdriverclass", columnDefinition = "NVarChar(100) default ''")
	private String mdriverclass;
}
