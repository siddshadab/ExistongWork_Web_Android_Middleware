package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md045038")
@Data
public class GuarantorEntity extends BaseEntity {


	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;    	
	@Column(name = "mloantrefno",  columnDefinition =  "numeric(8) default 0" )	
	private int mloantrefno;
	@Column(name = "mloanmrefno",  columnDefinition =  "numeric(8) default 0")	
	private int mloanmrefno;
	@Column(name = "mleadsid",  columnDefinition = "nvarchar(16) default ''" )	
	private String mleadsid;
	@Column(name = "mprdacctid",  columnDefinition = "nvarchar(32) default ''" )	
	private String mprdacctid;
	@Column(name = "msrno",  columnDefinition =  "numeric(8) default 0" )	
	private int msrno ;
	@Column(name = "mapplicanttype",  columnDefinition =  "numeric(8) default 0" )	
	private int mapplicanttype ;
	@Column(name = "mexistingcustyn",  columnDefinition = "nvarchar(1) default ''" )	
	private String mexistingcustyn ;
	@Column(name = "mcustno",  columnDefinition =  "numeric(8) default 0" )	
	private int mcustno ;
	@Column(name = "mnameofguar",  columnDefinition = "nvarchar(250) default ''" )	
	private String mnameofguar ;
	@Column(name = "mgender",  columnDefinition = "nvarchar(1) default ''" )	
	private String mgender ;
	@Column(name = "mrelationwithcust",  columnDefinition = "nvarchar(3) default ''" )	
	private String mrelationwithcust ;
	@Column(name = "mrelationsince",  columnDefinition =  "numeric(8) default 0" )	
	private int mrelationsince ;
	@Column(name = "mage",  columnDefinition =  "numeric(8) default 0")	
	private int mage ;
	@Column(name = "mphone",  columnDefinition = "nvarchar(15) default ''" )	
	private String mphone ;
	@Column(name = "mmobile",  columnDefinition = "nvarchar(12) default ''" )	
	private String mmobile ;
	@Column(name = "maddress",  columnDefinition = "nvarchar(120) default ''" )	
	private String maddress ;
	@Column(name = "mmonthlyincome")	
	private Double mmonthlyincome ;
	@Column(name = "mdob")	
	private LocalDateTime mdob ;
	@Column(name = "moccupationtype",  columnDefinition =  "numeric(8) default 0" )	
	private int moccupationtype ;
	@Column(name = "mmainoccupation",  columnDefinition =  "numeric(8) default 0")	
	private int mmainoccupation ;
	@Column(name = "mworkexpinyrs",  columnDefinition =  "numeric(8) default 0" )	
	private int mworkexpinyrs ;
	@Column(name = "mincomeothsources")	
	private Double mincomeothsources ;
	@Column(name = "mtotalincome")	
	private Double mtotalincome ;
	@Column(name = "mhousetype",  columnDefinition =  "numeric(8) default 0")	
	private int mhousetype ;
	@Column(name = "mworkingaddress",  columnDefinition = "nvarchar(100) default ''" )	
	private String mworkingaddress ;
	@Column(name = "mworkphoneno",  columnDefinition = "nvarchar(15) default ''" )	
	private String mworkphoneno ;
	@Column(name = "mmothermaidenname",  columnDefinition = "nvarchar(50) default ''" )	
	private String mmothermaidenname ;
	@Column(name = "mpromissorynote",  columnDefinition = "nvarchar(50) default ''" )	
	private String mpromissorynote ;
	@Column(name = "mnationalidtype",  columnDefinition =  "numeric(8) default 0" )	
	private int mnationalidtype ;
	@Column(name = "mnationalid",  columnDefinition =  "numeric(8) default 0")	
	private int mnationalid ;
	@Column(name = "mnationaliddesc",  columnDefinition = "nvarchar(30) default ''" )	
	private String mnationaliddesc ;
	@Column(name = "maddress2",  columnDefinition = "nvarchar(50) default ''" )	
	private String maddress2 ;
	@Column(name = "maddress3",  columnDefinition = "nvarchar(50) default ''" )	
	private String maddress3 ;
	@Column(name = "maddress4",  columnDefinition = "nvarchar(50) default ''" )	
	private String maddress4 ;
	@Column(name = "mmaritalstatus",  columnDefinition =  "numeric(8) default 0" )	
	private int mmaritalstatus ;
	@Column(name = "mreligioncd",  columnDefinition =  "numeric(8) default 0" )	
	private int mreligioncd ;
	@Column(name = "meducationalqual",  columnDefinition = "nvarchar(15) default ''" )	
	private String meducationalqual ;
	@Column(name = "memailaddr",  columnDefinition = "nvarchar(35) default ''" )	
	private String memailaddr ;
	@Column(name = "memployername",  columnDefinition = "nvarchar(50) default ''" )	
	private String memployername ;
	@Column(name = "mbusinessname",  columnDefinition = "nvarchar(50) default ''" )	
	private String mbusinessname ;
	@Column(name = "merrormessage", columnDefinition = "nvarchar(100) default ''")
	private String merrormessage = "";	
	@Column(name = "mspousename", columnDefinition = "nvarchar(50) default ''")
	private String mspousename = "";
	@Column(name = "mstatecd", columnDefinition = "nvarchar(3) default ''")
	private String mstatecd = "";
	@Column(name = "mtownship", columnDefinition = "nvarchar(6) default ''")
	private String mtownship = "";
	@Column(name = "mvillage",  columnDefinition =  "numeric(6) default 0" )	
	private int mvillage =0;
	@Column(name = "mwardno", columnDefinition = "nvarchar(6) default ''")
	private String mwardno = "";
	@Column(name = "mbuspropownership",  columnDefinition =  "numeric(2) default 0" )	
	private int mbuspropownership =0;
	@Column(name = "mbusownership",  columnDefinition =  "numeric(2) default 0" )	
	private int mbusownership =0;
	@Column(name = "mbustoaassetval")
	private Double mbustoaassetval = 0d;
	@Column(name = "mbusleninyears",  columnDefinition =  "nvarchar(100) default ''")	
	private String mbusleninyears ="";
	@Column(name = "mbusmonexpense")
	private Double mbusmonexpense = 0d;
	@Column(name = "mbusmonhlynetprof")
	private Double mbusmonhlynetprof = 0d;
	@Column(name = "msamevillageorward", columnDefinition = "nvarchar(1) default ''")
	private String msamevillageorward = "";
	@Column 
	@Lob
	private byte[] mfacecapture;
	@Column 
	@Lob
	private byte[] mnrcphoto;
	@Column 
	@Lob
	private byte[] mnrcsecphoto;
	@Column 
	@Lob
	private byte[] mhouseholdphoto;
	@Column 
	@Lob
	private byte[] mhouseholdsecphoto;
	@Column 
	@Lob
	private byte[] maddressphoto;	
	@Column 
	@Lob
	private byte[] msignature;
	private String mleads;

}
