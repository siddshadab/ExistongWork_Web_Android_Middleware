package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;



@Entity
@Table(name = "ChartsFilterMaster")
@Data
public class ChartsFilterMasterEntity {

	private static final long serialVersionUID = 1L;



	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;    	

	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;

	@Column(name = "mchartid",  nullable = false, columnDefinition = "numeric(8)")               
	private int mchartid = 0;
	
	@Column(name = "mfilterid",  columnDefinition = "NVarChar(150) default ''")
	private String mfilterid = "";
	
	@Column(name = "mdesc",  columnDefinition = "NVarChar(50) default ''")
	private String mdesc = "";
	@Column(name = "mdatatype",  columnDefinition = "NVarChar(50) default ''")
	private String mdatatype = "";
	
	@Column(name = "mdatalen", columnDefinition = "numeric(4) default 0")
	private int mdatalen = 0;

	@Column(name = "mfield1value",  columnDefinition = "NVarChar(250) default ''")
	private String mfield1value = "";
	
	@Column(name = "mdefaultvalue",  columnDefinition = "NVarChar(50) default ''")
	private String mdefaultvalue = "";
	@Column(name = "mdatatypedynamicquery",  columnDefinition = "NVarChar(250) default ''")
	private String mdatatypedynamicquery = "";
	
	@Column(name = "xminimumValue",  nullable = false, columnDefinition = "numeric(8)")               
	private int xminimumValue = 0;
	
	@Column(name = "yminimumValue",  nullable = false, columnDefinition = "numeric(8)")               
	private int yminimumValue = 0;
	
	@Column(name = "xinterval",  nullable = false, columnDefinition = "numeric(8)")               
	private int xinterval = 0;
	
	@Column(name = "yinterval",  nullable = false, columnDefinition = "numeric(8)")               
	private int yinterval = 0;
	
	
	
}


