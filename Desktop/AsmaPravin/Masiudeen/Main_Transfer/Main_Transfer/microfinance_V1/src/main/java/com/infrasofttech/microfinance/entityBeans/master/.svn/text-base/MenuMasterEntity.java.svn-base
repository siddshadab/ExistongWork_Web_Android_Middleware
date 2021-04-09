package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "MenuMaster")
@Data
public class MenuMasterEntity {

	 private static final long serialVersionUID = 1L;


	 @Id	
	 @Column(name = "menuid", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int menuid;	
	 @Column(name = "menudesc",  columnDefinition = "NVarChar(150) default ''")
	 private String menudesc = "";
	 @Column(name = "menutype",  columnDefinition = "NVarChar(50) default ''")
	 private String menutype = "";
	 @Column(name = "parenttype",  columnDefinition = "NVarChar(50) default ''")
	 private String parenttype = "";
	 @Column(name = "murl",  columnDefinition = "NVarChar(250) default ''")
	 private String murl = "";	
	 @Column(name = "mchartid", columnDefinition = "numeric(8) default 0")
	 private int mchartid = 0;
	 
	 @Column(name = "mparentmenuid", columnDefinition = "numeric(8) default 0")
	 private int mparentmenuid = 0;
	 
	 @Column(name = "mapplicationtype",  columnDefinition = "NVarChar(30) default ''")
	 private String mapplicationtype = "";	
}
