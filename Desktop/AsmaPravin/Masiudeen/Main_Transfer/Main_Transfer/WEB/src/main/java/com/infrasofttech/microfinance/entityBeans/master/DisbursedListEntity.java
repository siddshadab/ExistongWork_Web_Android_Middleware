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
@Table(name = "md009343")
@Data
public class DisbursedListEntity extends BaseEntity {


	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;
	@Id
    @Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;   
	@Column(name = "mcustno", columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;
	 @Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mlbrcode;
	 @Column(name = "mprdacctid",  columnDefinition = "nvarchar(32) default ''" )	  
	 private String mprdacctid;
	 @Column(name = "mlongname", columnDefinition = "nvarchar(250) default ''")
	private String mlongname = "";
	@Column(name = "mgroupcd", columnDefinition = "numeric(8) default 0")
	private int mgroupcd = 0;
	 @Column(name = "mefffromdate" )	  
	 private LocalDateTime mefffromdate;
	 @Column(name = "mdisburseddate")	  
	 private LocalDateTime mdisburseddate;
	 @Column(name = "minstlstartdate")	  
	 private LocalDateTime minstlstartdate;
	 @Column(name = "minstlamt")	  
	 private double minstlamt= 0d;
	 @Column(name = "minstlintcomp")	 
	 private double minstlintcomp= 0d;
	 @Column(name = "mleadsid",  columnDefinition = "nvarchar(16) default ''" )	  
	 private String mleadsid;
	 @Column(name = "mappliedasindvyn",  columnDefinition = "nvarchar(1) default ''" )	  
	 private String mappliedasindvyn;
	 @Column(name = "mnewtopupflag",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mnewtopupflag;
	 @Column(name = "msancdate" )	  
	 private LocalDateTime msancdate;
	 @Column(name = "mdisbursedamt")	  
	 private double mdisbursedamt= 0d;
	 @Column(name = "msdamt")	  
	 private double msdamt= 0d;
	 @Column(name = "mrebateamt")	  
	 private double mrebateamt= 0d;
	 @Column(name = "mchargesamt")	  
	 private double mchargesamt= 0d;
	 @Column(name = "mdisbursedamtcoltd")	  
	 private double mdisbursedamtcoltd= 0d;
	 @Column(name = "msdamtcoltd" )	  
	 private double msdamtcoltd= 0d;
	 @Column(name = "mrebateamtcoltd")	  
	 private double mrebateamtcoltd= 0d;
	 @Column(name = "mchargesamtcoltd")	  
	 private double mchargesamtcoltd= 0d;
	 @Column(name = "mdisbursedamtflag",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mdisbursedamtflag;
	 @Column(name = "msdamtflag",  columnDefinition = "numeric(8) default 0"  )	  
	 private int msdamtflag;
	 @Column(name = "mrebateamtflag",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mrebateamtflag;
	 @Column(name = "mchargesamtflag",  columnDefinition = "numeric(8) default 0" )	  
	 private int mchargesamtflag;
	 @Column(name = "mreason",  columnDefinition = "nvarchar(250) default ''" )	  
	 private String mreason;
	 @Column(name = "msetno",  columnDefinition = "numeric(8) default 0"  )	  
	 private int msetno;
	 @Column(name = "mscrollno",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mscrollno;
	 @Column(name = "mentrydate")	  
	 private LocalDateTime mentrydate;
	 @Column(name = "mbatchcd",  columnDefinition = "nvarchar(8) default ''" )	  
	 private String mbatchcd;
	 @Column(name = "mmainscrollno",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mmainscrollno;
	 @Column(name = "mbatchnumber",  columnDefinition = "nvarchar(20) default ''" )	  
	 private String mbatchnumber;
	 @Column(name = "mnarration",  columnDefinition = "nvarchar(50) default ''" )	  
	 private String mnarration;
	 @Column(name = "mcenterid",  columnDefinition = "numeric(8) default 0" )	  
	 private int mcenterid;
	 @Column(name = "mcrs",  columnDefinition = "nvarchar(8) default ''" )	  
	 private String mcrs;
	 @Column(name = "msuspbatchcd",  columnDefinition = "nvarchar(8) default ''" )	  
	 private String msuspbatchcd;
	 @Column(name = "msuspsetno",  columnDefinition ="numeric(8) default 0" )	  
	 private int msuspsetno;
	 @Column(name = "msuspscrollno",  columnDefinition = "numeric(8) default 0" )	  
	 private int msuspscrollno;
	 @Column(name = "msspmainscrollno",  columnDefinition ="numeric(8) default 0" )	  
	 private int msspmainscrollno;
	 @Column(name = "mpartcashamount" )	  
	 private double mpartcashamount= 0d;
	 @Column(name = "mpartcashbatchcd",  columnDefinition = "nvarchar(32) default ''" )	  
	 private String mpartcashbatchcd;
	 @Column(name = "mpartcashsetno",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mpartcashsetno;
	 @Column(name = "mpartcashscrollno",  columnDefinition = "numeric(8) default 0" )	  
	 private int mpartcashscrollno;
	 @Column(name = "mpartcashmainscrollno",  columnDefinition ="numeric(8) default 0"  )	  
	 private int mpartcashmainscrollno;
	 @Column(name = "mneftclsrbatchcd",  columnDefinition = "nvarchar(8) default ''" )	  
	 private String mneftclsrbatchcd;
	 @Column(name = "mneftclsrsetno",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mneftclsrsetno;
	 @Column(name = "mneftclsrscrollno",  columnDefinition = "numeric(8) default 0"  )	  
	 private int mneftclsrscrollno;
	 @Column(name = "mneftclsrmainscrollno",  columnDefinition = "numeric(8) default 0"  )	 
	 private int mneftclsrmainscrollno;
	 @Column(name = "mcreateddt")	  
	 private LocalDateTime mcreateddt;
	 @Column(name = "mcreatedby",  columnDefinition = "nvarchar(32) default ''" )	  
	 private String mcreatedby;
	 @Column(name = "mlastupdatedt")	  
	 private LocalDateTime mlastupdatedt;
	 @Column(name = "mlastupdateby",  columnDefinition = "nvarchar(32) default ''" )	  
	 private String mlastupdateby;
	 @Column(name = "mgeolocation",  columnDefinition = "nvarchar(32) default ''" )	  
	 private String mgeolocation;
	 @Column(name = "mgeolatd",  columnDefinition = "nvarchar(32) default ''" )	  
	 private String mgeolatd;
	 @Column(name = "mgeologd",  columnDefinition = "nvarchar(32) default ''" )	  
	 private String mgeologd;
	 @Column(name = "mlastsynsdate")	 
	 private LocalDateTime mlastsynsdate;
	 @Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )	  
	 private String merrormessage;
	 @Column(name = "mdisbamount" )	  
	 private double mdisbamount= 0d;
	 @Column(name = "mchargesamt0")	  
	 private double mchargesamt0= 0d;
	 @Column(name = "mchargesamt1")	  
	 private double mchargesamt1= 0d;
	 @Column(name = "mchargesamt2")	  
	 private double mchargesamt2= 0d;
	 @Column(name = "mchargesamt3")	  
	 private double mchargesamt3= 0d;
	 @Column(name = "mchargesamt4")	  
	 private double mchargesamt4= 0d;
	 @Column(name = "mchargesamt5")	  
	 private double mchargesamt5= 0d;
	 @Column(name = "mchargesamt6")	  
	 private double mchargesamt6= 0d;
	 @Column(name = "mchargesamt7")	  
	 private double mchargesamt7= 0d;
	 @Column(name = "mchargesamt8")	  
	 private double mchargesamt8= 0d;
	 @Column(name = "mchargesamt9")	  
	 private double mchargesamt9= 0d;
	 @Column(name = "mcheckbiometric", nullable = false, columnDefinition = "int default 0" )
	 private int mcheckbiometric; 
	 @Column(name = "mdisbstatus", nullable = false, columnDefinition = "int default 0" )
	 private int mdisbstatus;
	 @Column(name = "mrouteto",  columnDefinition = "nvarchar(50) default ''" )	  
	 private String mrouteto;
	 @Column(name = "mremarks",  columnDefinition = "nvarchar(50) default ''" )	  
	 private String mremarks;
	 @Column(name = "mamttodisb",  columnDefinition = "FLOAT default 0" )	  
	 private String mamttodisb;
	 
	


}
