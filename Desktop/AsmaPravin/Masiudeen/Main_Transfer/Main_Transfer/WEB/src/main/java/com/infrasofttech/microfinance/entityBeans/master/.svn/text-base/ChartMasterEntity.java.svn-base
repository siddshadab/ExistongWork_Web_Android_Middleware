package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "ChartMaster")
@Data
public class ChartMasterEntity {	

	 @Id	
	 @Column(name = "chartid", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int chartid;
	 
	 @Column(name = "name", columnDefinition = "NVarChar(150) default ''")
	 private String name = "";
	 
	 @Column(name = "xcatg", columnDefinition = "NVarChar(150) default ''")
	 private String xcatg = "";

	 @Column(name = "ycatg", columnDefinition = "NVarChar(150) default ''")
	 private String ycatg = "";

	 @Column(name = "type", columnDefinition = "NVarChar(50) default ''")
	 private String type = "";


}
