package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md001120")
@Data
public class SavingsCollectionListEntity extends BaseEntity {


	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;       	    	
	 @Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0" )      	
	 private int mlbrcode;       	
	 @Column(name = "mprdacctid",  columnDefinition = "nvarchar(32) default ''" )	
	 private String mprdacctid;	
	 @Column(name = "mcollectiondate")	
	 private LocalDateTime mcollectiondate;	
	 @Column(name = "mcollectedamount" )	
	 private double mcollectedamount;	
	 @Column(name = "mmoduletype",  columnDefinition = "numeric(4) " )	
	 private int mmoduletype;	
	 @Column(name = "mremark",  columnDefinition = "nvarchar(50) default ''" )    	
	 private String mremark;     	

	 @Column(name = "mcashflow",  columnDefinition = "nvarchar(1) default ''" )    	
	 private String mcashflow;  
	 
	 @Column(name = "mentrydate")	
	 private LocalDateTime mentrydate;	
	 

	 @Column(name = "mbatchcd",  columnDefinition = "nvarchar(20) default ''" )    	
	 private String mbatchcd;  
	 
	 @Column(name = "msetno",  columnDefinition = "numeric(8) default 0" )      	
	 private int msetno;  
	 
	 @Column(name = "mscrollno",  columnDefinition = "numeric(8) default 0" )      	
	 private int mscrollno;  
	 @Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )
	private String merrormessage = "";
	 
	 
	 @Column(name = "msvngacctrefno",  nullable = false, columnDefinition = "numeric(8)")               
		private int msvngacctrefno = 0;
	 
	 
	 
	 @Column(name = "msvngaccmrefno",  nullable = false, columnDefinition = "numeric(8)")               
		private int msvngaccmrefno = 0;
	 
	 
	 
	 
	 
	
	/*
	 * @Column(name = "mcreateddt" ) private LocalDateTime mcreateddt;
	 * 
	 * @Column(name = "mcreatedby", columnDefinition = "nvarchar(8)" ) private
	 * String mcreatedby;
	 * 
	 * @Column(name = "mlastupdatedt" ) private LocalDateTime mlastupdatedt;
	 * 
	 * @Column(name = "mlastupdateby", columnDefinition = "nvarchar(8)" ) private
	 * String mlastupdateby;
	 * 
	 * @Column(name = "mgeolocation", columnDefinition = "nvarchar(250)" ) private
	 * String mgeolocation;
	 * 
	 * @Column(name = "mgeolatd", columnDefinition = "nvarchar(20)" ) private String
	 * mgeolatd;
	 * 
	 * @Column(name = "mgeologd", columnDefinition = "nvarchar(20)" ) private String
	 * mgeologd;
	 * 
	 * @Column(name = "mlastsynsdate" ) private LocalDateTime mlastsynsdate;
	 */


}
