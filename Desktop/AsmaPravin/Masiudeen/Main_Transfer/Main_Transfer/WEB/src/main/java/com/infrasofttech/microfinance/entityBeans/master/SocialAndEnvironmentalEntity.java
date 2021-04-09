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
@Table(name = "md045802")
@Data
public class SocialAndEnvironmentalEntity extends BaseEntity {
	
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
	 @Column (name = "mbrwexclist", columnDefinition = "numeric(1) default 0")
	 private int mbrwexclist = 0; 
     @Column (name = "mbrwnontargetlist", columnDefinition = "numeric(1) default 0")
     private int mbrwnontargetlist = 0; 
     @Column (name = "mbrwairemission", columnDefinition = "numeric(1) default 0")
     private int mbrwairemission = 0; 
     @Column (name = "mbrwwastewater", columnDefinition = "numeric(1) default 0")
     private int mbrwwastewater = 0; 
     @Column (name = "mbrwsolidhazardous", columnDefinition = "numeric(1) default 0")
     private int mbrwsolidhazardous = 0; 
     @Column (name = "mbrwchemicalfuels", columnDefinition = "numeric(1) default 0")
     private int mbrwchemicalfuels = 0; 
     @Column (name = "mbrwnoisefumes", columnDefinition = "numeric(1) default 0")
     private int mbrwnoisefumes = 0; 
     @Column (name = "mbrwresconsuption", columnDefinition = "numeric(1) default 0")
     private int mbrwresconsuption = 0; 
     @Column (name = "mcinodesignation", columnDefinition = "numeric(1) default 0")
     private int mcinodesignation = 0; 
     @Column (name = "mcinci", columnDefinition = "numeric(1) default 0")
     private int mcinci = 0; 
     @Column (name = "msilar", columnDefinition = "numeric(1) default 0")
     private int msilar = 0; 
     @Column (name = "msidrofls", columnDefinition = "numeric(1) default 0")
     private int msidrofls = 0; 
     @Column (name = "msiils", columnDefinition = "numeric(1) default 0")
     private int msiils = 0; 
     @Column (name = "msiiip", columnDefinition = "numeric(1) default 0")
     private int msiiip = 0; 
     @Column (name = "msicnc", columnDefinition = "numeric(1) default 0")
     private int msicnc = 0; 
     @Column (name = "msiasc", columnDefinition = "numeric(1) default 0")
     private int msiasc = 0; 
     @Column (name = "msinsi", columnDefinition = "numeric(1) default 0")
     private int msinsi = 0; 
     @Column (name = "mlinpp", columnDefinition = "numeric(1) default 0")
     private int mlinpp = 0; 
     @Column (name = "mliieh", columnDefinition = "numeric(1) default 0")
     private int mliieh = 0; 
     @Column (name = "mliiwc", columnDefinition = "numeric(1) default 0")
     private int mliiwc = 0; 
     @Column (name = "mliite", columnDefinition = "numeric(1) default 0")
     private int mliite = 0; 
     @Column (name = "mliueo", columnDefinition = "numeric(1) default 0")
     private int mliueo = 0; 
     @Column (name = "mlipmw", columnDefinition = "numeric(1) default 0")
     private int mlipmw = 0; 
     @Column (name = "mliema", columnDefinition = "numeric(1) default 0")
     private int mliema = 0; 
     @Column (name = "mlicfl", columnDefinition = "numeric(1) default 0")
     private int mlicfl = 0; 
     @Column (name = "mlipevc", columnDefinition = "numeric(1) default 0")
     private int mlipevc = 0; 
     @Column (name = "mlireou", columnDefinition = "numeric(1) default 0")
     private int mlireou = 0; 
     @Column (name = "mlinli", columnDefinition = "numeric(1) default 0")
     private int mlinli = 0; 
     @Column (name = "mbrwcat", columnDefinition = "numeric(1) default 0")
     private int mbrwcat = 0;
     @Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )
 	 private String merrormessage = "";
     @Column(name = "mcustmrefno", columnDefinition = "numeric(8) default 0")
	 private int mcustmrefno=0;
	 @Column(name = "mcusttrefno", columnDefinition = "numeric(8) default 0")
	 private int mcusttrefno=0;
	 
	 
	  
}
