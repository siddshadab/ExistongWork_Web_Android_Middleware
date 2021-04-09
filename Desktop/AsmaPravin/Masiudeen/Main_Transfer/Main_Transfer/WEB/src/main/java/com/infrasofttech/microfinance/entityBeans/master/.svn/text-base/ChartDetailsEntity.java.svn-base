package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;


@Entity
@Table(name = "ChartDetails")
@Data
public class ChartDetailsEntity {
	
     @Id	
	 @Column(name = "chartid", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int chartid;
	 
	 @Column(name = "query", columnDefinition = "NVarChar(250) default ''")
	 private String query = "";
}
