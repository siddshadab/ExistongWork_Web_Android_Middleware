package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md045011" , indexes = {
@Index(name = "mclustered_hidx",columnList= "mcreatedby,mrouteto,mlastupdatedt,mcreateddt,mleadstatus,missynctocoresys"),
@Index(name = "mleadsid_idx",columnList= "mleadsid"),
@Index(name = "custref_idx",columnList= "mcusttrefno,mcustmrefno"),
@Index(name = "custno_idx",columnList= "mcustno"),
})
@Data
public class CustomerLoanEntity extends BaseEntity {

	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8) default 0")
	private int trefno =0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno;
	@Column(name = "mleadsid", columnDefinition = "NVarChar(16) default ''" )
	private String mleadsid ="";
	@Column(name = "mappldloanamt")
	private Double mappldloanamt = 0d;
	@Column(name = "mapprvdloanamt")
	private Double mapprvdloanamt = 0d;
	@Column(name = "mcustno", columnDefinition = "numeric(8) default 0")
	private int mcustno =0;
	@Column(name = "mcusttrefno", columnDefinition = "numeric(8) default 0")
	private int mcusttrefno =0;
	@Column(name = "mcustcategory",  columnDefinition = "numeric(4) default 0")
	private int mcustcategory = 0;
	@Column(name = "mcustmrefno", columnDefinition = "numeric(8)")
	private int mcustmrefno;
	@Column(name = "mloanamtdisbd")
	private Double mloanamtdisbd = 0d;
	@Column(name = "mloandisbdt")	
	private LocalDateTime mloandisbdt;
	@Column(name = "mleadstatus", columnDefinition = "numeric(2) default 0")
	private int mleadstatus =0;
	@Column(name = "mexpdt")	
	private LocalDateTime mexpdt;
	@Column(name = "minstamt")
	private Double minstamt = 0d;
	@Column(name = "minststrtdt")
	private LocalDateTime minststrtdt;
	@Column(name = "minterestamount")
	private Double minterestamount = 0d;	
	@Column(name = "mrepaymentmode", columnDefinition = "numeric(2) default 0")
	private int mrepaymentmode =0;
	@Column(name = "mmodeofdisb", columnDefinition = "numeric(2) default 0")
	private int mmodeofdisb =0;
	@Column(name = "mperiod", columnDefinition = "numeric(3) default 0")//numOfInstallment
	private int mPeriod=0;
	@Column(name = "mprdcd", columnDefinition = "NVarChar(8) default ''" )
	private String mprdcd ="";
	@Column(name = "mpurposeofloan", columnDefinition = "numeric(3) default 0")
	private int mpurposeofloan =0;	
	@Column(name = "msubpurposeofloan", columnDefinition = "numeric(6) default 0")
	private int msubpurposeofloan =0;
	@Column(name = "mintrate")
	private Double mintrate = 0d;
	@Column(name = "mroutefrom",  columnDefinition = "NVarChar(8) default ''" )
	private String mroutefrom ="";
	@Column(name = "mrouteto",  columnDefinition = "NVarChar(8) default ''" ) 
	private String mrouteto ="";
	@Column(name = "mprdacctid",  columnDefinition = "NVarChar(32) default ''" )//loanAccountNumberOfCore;
	private String mprdacctid ="";
	@Column(name = "mloancycle", columnDefinition = "numeric(2) default 0")
	private int mloancycle =0;
	@Column(name = "mfrequency", columnDefinition = "NVarChar(1) default ''" )
	private String mfrequency ="";
	@Column(name ="mapprovaldesc", columnDefinition = "NVarChar(80) default ''" )
	private  String mapprovaldesc ="";
	@Column(name = "merrormessage",  columnDefinition = "nvarchar(250) default ''" )
	private String merrormessage ="";	
	@Column(name = "mappliedasind", columnDefinition = "nvarchar(1) default ''" ) 
	private String mappliedasind;
	@Column(name = "mretry", columnDefinition = "numeric(2) default 0")
	private int mretry =0;
	
	@Column(name = "mcheckresaddchng", nullable = false, columnDefinition = "int default 0" )
	private int mcheckresaddchng; 	
	
	@Column(name = "mspouserelname", columnDefinition = "nvarchar(100) default ''" ) 
	private String mspouserelname;
	@Column(name = "mcheckspouserepay", nullable = false, columnDefinition = "int default 0" )	
	private int mcheckspouserepay;	
	@Column(name = "mcheckbiometric", nullable = false, columnDefinition = "int default 0" )	
	private int mcheckbiometric;	
	@Column(name = "momnileadstatus", nullable = false, columnDefinition = "int default 0" )
	private int momnileadstatus; 	
	@Column(name = "mlbrcode", nullable = false, columnDefinition = "int default 0" )
	private int mlbrcode; 	

	@Column(name = "misdisbursed", nullable = false, columnDefinition = "int default 0" )
	private int misdisbursed;
	
	
}
