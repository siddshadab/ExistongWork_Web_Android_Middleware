package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md045805")
@Data
public class DeviationFormEntity extends BaseEntity {
	
	 @Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	 private int trefno;
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)" )
	 private int mrefno;
	 @Column(name = "mloantrefno",  columnDefinition =  "numeric(8) default 0" )	
	 private int mloantrefno;
	 @Column(name = "mloanmrefno",  columnDefinition =  "numeric(8) default 0")	
	 private int mloanmrefno;
	 @Column(name = "mleadsid", columnDefinition = "NVarChar(16) default ''" )
	 private String mleadsid ="";
	 @Column(name = "mleadstatus", columnDefinition = "numeric(2) default 0")
	 private int mleadstatus =0;
	 @Column(name = "mdevloanapp", columnDefinition = "NVarChar(10) default ''" )
     private String mdevloanapp ="";
	 @Column (name = "mdrnrc", columnDefinition = "numeric(1) default 0")
	 private int mdrnrc = 0; 
     @Column (name = "mdrmni", columnDefinition = "numeric(1) default 0")
     private int mdrmni = 0; 
     @Column (name = "mdrdbr", columnDefinition = "numeric(1) default 0")
     private int mdrdbr = 0; 
     @Column (name = "mdrmfi", columnDefinition = "numeric(1) default 0")
     private int mdrmfi = 0; 
     @Column (name = "mdrbl", columnDefinition = "numeric(1) default 0")
     private int mdrbl = 0; 
     @Column(name = "mdevapproval", columnDefinition = "NVarChar(200) default ''" )
     private String mdevapproval ="";
     @Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )
 	 private String merrormessage = "";
     @Column(name = "mcustmrefno", columnDefinition = "numeric(8) default 0")
	 private int mcustmrefno=0;
	 @Column(name = "mcusttrefno", columnDefinition = "numeric(8) default 0")
	 private int mcusttrefno=0;
	 
	 
	  
}
