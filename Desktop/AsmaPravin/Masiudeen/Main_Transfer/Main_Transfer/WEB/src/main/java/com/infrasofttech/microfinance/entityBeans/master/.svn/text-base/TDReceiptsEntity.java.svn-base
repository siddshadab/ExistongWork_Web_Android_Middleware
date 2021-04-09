package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;


@Entity
@Table(name = "md020004")
@Data
public class TDReceiptsEntity extends BaseEntity{
	
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
	@Column(name = "mnametitle",  columnDefinition = "nvarchar(5) default ''" )
	private String mnametitle;	
	@Column(name = "mlongname",  columnDefinition = "nvarchar(200) default ''" )
	private String mlongname;
	@Column(name = "mcurcd",  columnDefinition = "nvarchar(3) default ''" )
	private String mcurcd;
	@Column(name = "mcertdate" )
	private LocalDateTime mcertdate;
	@Column(name = "mnoinst",  columnDefinition = "numeric(4) default 0" )
	private int mnoinst;  
	@Column(name = "mnoofmonths",  columnDefinition = "numeric(4) default 0" )
	private int mnoofmonths;  
	@Column(name = "mnoofdays",  columnDefinition = "numeric(4) default 0" )
	private int mnoofdays; 
	@Column(name = "mintrate" , nullable = true )
	private double mintrate= 0d;	
	@Column(name = "mmatval" , nullable = true )
	private double mmatval= 0d;
	@Column(name = "mmatdate" )
	private LocalDateTime mmatdate;
	@Column(name = "mreceiptstatus",  columnDefinition = "numeric(2) default 0" )
	private int mreceiptstatus;
	@Column(name = "mlastrepaydate" )
	private LocalDateTime mlastrepaydate;
	@Column(name = "mmainbalfcy" , nullable = true )
	private double mmainbalfcy= 0d;
	@Column(name = "mintprvdamtfcy" , nullable = true )
	private double mintprvdamtfcy= 0d;
	@Column(name = "mintpaidamtfcy" , nullable = true ) 
	private double mintpaidamtfcy= 0d;
	@Column(name = "mtdsamtfcy" , nullable = true )
	private double mtdsamtfcy= 0d;
	@Column(name = "mtdsyn",  columnDefinition = "nvarchar(1) default ''" )
	private String mtdsyn;
	@Column(name = "mmodeofdeposit",  columnDefinition = "nvarchar(20) default ''" )
	private String mmodeofdeposit;
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0" )
	private int mcustno;
	@Column(name = "mcenterid",  columnDefinition = "numeric(8) default 0" )
	private int mcenterid;
	@Column(name = "mgroupcd",  columnDefinition = "numeric(8) default 0" )
	private int mgroupcd;
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(8) default ''" )
	private String mprdcd;
	@Column(name = "mcrs",  columnDefinition = "nvarchar(8) default ''" )
	private String mcrs;
	 @Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )
		private String merrormessage = "";
	 @Column(name = "mmobilelastsynsdate" )
		private LocalDateTime mmobilelastsynsdate; 
	 
	 @Column(name = "msourceoffunds",  columnDefinition = "numeric(2) default 0" )
		private int msourceoffunds;
	 @Column(name = "mnoticetype",  columnDefinition = "numeric(2) default 0" )
		private int mnoticetype;
	 
	 

}
