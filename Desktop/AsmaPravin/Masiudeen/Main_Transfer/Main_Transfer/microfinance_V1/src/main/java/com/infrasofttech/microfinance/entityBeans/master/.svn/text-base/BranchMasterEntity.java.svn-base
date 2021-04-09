package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md001003")
@Data
public class BranchMasterEntity  {


	@Id
	@Column(name = "mpbrcode", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mpbrcode;
	@Column(name = "mname", columnDefinition = "NVarChar(30) default ''")
	private String mname = "";
	@Column(name = "mshortname", columnDefinition = "NVarChar(15) default ''")
	private String mshortname = "";
	@Column(name = "madd1", columnDefinition = "NVarChar(100) default ''")
	private String madd1 = "";
	@Column(name = "madd2", columnDefinition = "NVarChar(100) default ''")
	private String madd2 = "";
	@Column(name = "madd3", columnDefinition = "NVarChar(100) default ''")
	private String madd3 = "";	
	@Column(name = "mcitycd", columnDefinition = "NVarChar(6) default ''")
	private String mcitycd = "";
	@Column(name = "mpincode", columnDefinition = "numeric(8) default 0")
	private int mpincode = 0;	
	@Column(name = "mcountrycd", columnDefinition = "NVarChar(3) default ''")
	private String mcountrycd = "";	
	@Column(name = "mbranchtype", columnDefinition = "numeric(4) default 0")
	private int mbranchtype = 0;
	@Column(name = "mtele1", columnDefinition = "NVarChar(15) default ''")
	private String mtele1 = "";
	@Column(name = "mtele2", columnDefinition = "NVarChar(15) default ''")
	private String mtele2 = "";	
	@Column(name = "mfaxno1", columnDefinition = "NVarChar(15) default ''")
	private String mfaxno1 = "";	
	@Column(name = "mswiftaddr", columnDefinition = "NVarChar(15) default ''")
	private String mswiftaddr = "";	
	@Column(name = "mpostcode", columnDefinition = "NVarChar(15) default ''")
	private String mpostcode = "";
	@Column(name = "mweekoff1", columnDefinition = "numeric(4) default 0")
	private int mweekoff1 = 0;
	@Column(name = "mweekoff2", columnDefinition = "numeric(4) default 0")
	private int mweekoff2 = 0;
	@Column(name = "mparentbrcode", columnDefinition = "numeric(8) default 0")
	private int mparentbrcode = 0;
	@Column(name = "mbranchtype1", columnDefinition = "numeric(4) default 0")
	private int mbranchtype1 = 0;
	@Column(name = "mbranchcat", columnDefinition = "numeric(4) default 0")
	private int mbranchcat = 0;
	@Column(name = "mformatndt"  )		 
	private LocalDateTime mformatndt ;
	@Column(name = "mdistrict", columnDefinition = "NVarChar(15) default ''")
	private String mdistrict = "";
	@Column(name = "mbrnmanager", columnDefinition = "NVarChar(15) default ''")
	private String mbrnmanager = "";
	@Column(name = "mstate", columnDefinition = "NVarChar(15) default ''")
	private String mstate = "";
	@Column(name = "mmaxgroupmembers", columnDefinition = "numeric(4) default 0")
	private int mmaxgroupmembers = 0;
	@Column(name = "mmingroupmembers", columnDefinition = "numeric(4) default 0")
	private int mmingroupmembers = 0;
	@Column(name = "msector", columnDefinition = "numeric(4) default 0")
	private int msector = 0;
	@Column(name = "mbranchemailid", columnDefinition = "NVarChar(60) default ''")
	private String mbranchemailid = "";
	@Column(name = "mbiccode", columnDefinition = "NVarChar(15) default ''")
	private String mbiccode = "";
	@Column(name = "mlegacybrncd", columnDefinition = "NVarChar(15) default ''")
	private String mlegacybrncd = "";
	@Column(name = "mlatitude")
	private Double mlatitude = 0d;	
	@Column(name = "mlongitude")
	private Double mlongitude = 0d;	
	 @Column(name = "mlastopendate"  )		 
	 private LocalDateTime mlastopendate ;
	@Override
	public String toString() {
		return "BranchMasterEntity [mpbrcode=" + mpbrcode + ", mname=" + mname + ", mshortname=" + mshortname
				+ ", madd1=" + madd1 + ", madd2=" + madd2 + ", madd3=" + madd3 + ", mcitycd=" + mcitycd + ", mpincode="
				+ mpincode + ", mcountrycd=" + mcountrycd + ", mbranchtype=" + mbranchtype + ", mtele1=" + mtele1
				+ ", mtele2=" + mtele2 + ", mfaxno1=" + mfaxno1 + ", mswiftaddr=" + mswiftaddr + ", mpostcode="
				+ mpostcode + ", mweekoff1=" + mweekoff1 + ", mweekoff2=" + mweekoff2 + ", mparentbrcode="
				+ mparentbrcode + ", mbranchtype1=" + mbranchtype1 + ", mbranchcat=" + mbranchcat + ", mformatndt="
				+ mformatndt + ", mdistrict=" + mdistrict + ", mbrnmanager=" + mbrnmanager + ", mstate=" + mstate
				+ ", mmaxgroupmembers=" + mmaxgroupmembers + ", mmingroupmembers=" + mmingroupmembers + ", msector="
				+ msector + ", mbranchemailid=" + mbranchemailid + ", mbiccode=" + mbiccode + ", mlegacybrncd="
				+ mlegacybrncd + ", mlatitude=" + mlatitude + ", mlongitude=" + mlongitude + ", mlastopendate="
				+ mlastopendate + "]";
	}


}
