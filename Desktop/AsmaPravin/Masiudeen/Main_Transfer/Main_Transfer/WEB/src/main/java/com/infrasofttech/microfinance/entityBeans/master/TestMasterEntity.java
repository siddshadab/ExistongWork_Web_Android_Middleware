package com.infrasofttech.microfinance.entityBeans.master;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "TestMaster")
@Data
public class TestMasterEntity {
	 @Id	
	 @Column(name = "categoryid", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int categoryid;	
	 
	 @Column(name = "title",  columnDefinition = "NVarChar(150) default ''")
	 private String title = "";	 
	
	 @Column(name = "parentid", columnDefinition = "numeric(8)")
	 private int parentid;
	 
	
	 
	 
	 
}
