package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Lob;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md045801", indexes = { @Index(columnList = "mrefno", name = "md045801AltKey1")})
@Data
public class CustomerLoanCPVBusinessRecordEntity extends BaseEntity {

	
	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8) default 0")
	private int trefno =0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno;
	
	@Column(name = "mleadsid", columnDefinition = "NVarChar(16) default ''" )
	private String mleadsid =""; 
	
	@Column(name = "mhblocated", columnDefinition = "NVarChar(10) default ''" )
	private String mhblocated;
	@Column(name = "mbusinessname", columnDefinition = "NVarChar(50) default ''" )
	private String mbusinessname;
	@Column(name = "mbusinessaddress", columnDefinition = "NVarChar(250) default ''" )
	private String mbusinessaddress;
	@Column(name = "maddresschanged", columnDefinition = "NVarChar(10) default ''" )
	private String maddresschanged;
	@Column(name = "mstartedym")
	private LocalDateTime   mstartedym;
	 @Column(name = "mpropertystatus",  columnDefinition = "numeric(8) default 0")
	private int mpropertystatus;
	 @Column(name = "mshopcondition",  columnDefinition = "numeric(8) default 0")
	private int mshopcondition;
	  @Column(name = "mbuslocation", columnDefinition = "NVarChar(10) default ''" )
	  private String mbuslocation;
	  @Column(name = "mnoofcustomers", columnDefinition = "NVarChar(20) default ''" )
	  private String mnoofcustomers;
	  @Column(name = "mcuslocation",  columnDefinition = "numeric(8) default 0")
	  private int mcuslocation;
	  @Column(name = "mcusdealing",  columnDefinition = "numeric(8) default 0")
	  private int mcusdealing;
	  @Column(name = "mcreditsales", columnDefinition = "NVarChar(10) default ''" )
	  private String mcreditsales;
	  @Column(name = "mperiodsale", columnDefinition = "NVarChar(10) default ''" )
	  private String mperiodsale;
	  @Column(name = "mapplicantsrole",columnDefinition = "numeric(8) default 0")
	  private int mapplicantsrole;
	  @Column(name = "mbuspartner", columnDefinition = "NVarChar(10) default ''" )
	  private String mbuspartner;
	  @Column(name = "mkeyperson", columnDefinition = "numeric(8) default 0")
	  private int mkeyperson;
	  @Column(name = "mcusbehaviour", columnDefinition = "numeric(8) default 0")
	  private int mcusbehaviour;
	  
	  @Column(name = "mtransrecord", columnDefinition = "NVarChar(10) default ''" )
	  private String mtransrecord;
	  @Column(name = "mrecpurandsal", columnDefinition = "numeric(8) default 0")
	  private int mrecpurandsal;
	  @Column(name = "mbooksupdated", columnDefinition = "numeric(8) default 0")
	  private int mbooksupdated;
	  @Column(name = "mivlandrecord", columnDefinition = "numeric(2) default 0")
	  private int mivlandrecord;
	  @Column(name = "mivsalesregister", columnDefinition = "numeric(2) default 0")
	  int mivsalesregister;
	  @Column(name = "mivcreditregister", columnDefinition = "numeric(2) default 0")
	  private int mivcreditregister;
	  @Column(name = "mivinventoryregister", columnDefinition = "numeric(2) default 0")
	  private int mivinventoryregister;
	  @Column(name = "mivsalaryslip", columnDefinition = "numeric(2) default 0")
	  private int mivsalaryslip;
	  @Column(name = "mivpassbook", columnDefinition = "numeric(2) default 0")
	  private int mivpassbook;
	  @Column(name = "mbuscategories", columnDefinition = "numeric(8) default 0")
	  private int mbuscategories;
	  @Column(name = "mloanmrefno", columnDefinition = "numeric(8) default 0")
	   private int mloanmrefno =0;
	   @Column(name = "mloantrefno", columnDefinition = "numeric(8) default 0")
	   private int mloantrefno=0;
	   @Column(name = "mcustmrefno", columnDefinition = "numeric(8) default 0")
	   private int mcustmrefno=0;
	   @Column(name = "mcusttrefno", columnDefinition = "numeric(8) default 0")
	   private int mcusttrefno=0;
	   @Column(name = "mleadstatus", columnDefinition = "numeric(2) default 0")
	   private int mleadstatus =0;
	   @Column 
		@Lob
		private byte[] mbusinesslicense;
		@Column 
		@Lob
		private byte[] mpremisesphoto;
		@Column 
		@Lob
		private byte[] mpremisesphotosec;
		@Column 
		@Lob
		private byte[] mpremisesphotothird;
		
		@Column(name = "merrormessage",  columnDefinition = "nvarchar(250) default ''" )
		private String merrormessage ="";
	
	
	
	
}
