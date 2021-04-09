package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "focollectionsheet" , indexes = {


@Index(name = "mcrtdbyMlbr_hidx",columnList= "mlbrcode,mcreatedby"),


})
@Data
public class DailyLoanCollectionEntity extends BaseEntity {


	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;

	@Column(name = "trefno",  columnDefinition = "numeric(8) default 0" )	
	private int trefno=0;	
	@Column(name = "masondate") 
	private LocalDateTime masondate;
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0")	
	private int mlbrcode=0;		
	@Column(name = "mprdacctid", columnDefinition = "nvarchar(32) default ''" ) 
	private String mprdacctid;
	@Column(name = "macctstat",  columnDefinition = "numeric(8) default 0")	
	private int macctstat=0;	
	@Column(name = "mcenterid",  columnDefinition = "numeric(8) default 0")	
	private int mcenterid=0;		
	@Column(name = "mgroupid",  columnDefinition = "numeric(8) default 0")	
	private int mgroupid=0;		
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")	
	private int mcustno=0;		
	@Column(name = "mfocode", columnDefinition = "nvarchar(8) default ''" ) 
	private String mfocode;
	@Column(name = "mleadsid", columnDefinition = "nvarchar(16) default ''" ) 
	private String mleadsid;	
	@Column(name = "mloancycle",  columnDefinition = "numeric(8) default 0")	
	private int mloancycle=0;		
	@Column(name = "midealbaldate") 
	private LocalDateTime midealbaldate;	
	@Column(name = "modamt")
	private Double modamt = 0d;
	@Column(name = "memiamt")
	private Double memiamt = 0d;
	@Column(name = "mcurrentdue")
	private Double mcurrentdue = 0d;
	@Column(name = "midealbal")
	private Double midealbal = 0d;	
	@Column(name = "memino",  columnDefinition = "numeric(8) default 0")	
	private int memino=0;	
	@Column(name = "mexpdate") 
	private LocalDateTime mexpdate;
	@Column(name = "mexpprnpaid")
	private Double mexpprnpaid = 0d;
	@Column(name = "mexpintpaid")
	private Double mexpintpaid = 0d;
	@Column(name = "mpaidprn")
	private Double mpaidprn = 0d;
	@Column(name = "mpaidint")
	private Double mpaidint = 0d;	
	@Column(name = "mprnos")
	private Double mprnos = 0d;
	@Column(name = "mintos")
	private Double mintos = 0d;
	@Column(name = "mclosint")
	private Double mclosint = 0d;	
	@Column(name = "mappliedasind", columnDefinition = "nvarchar(1) default ''" ) 
	private String mappliedasind;
	@Column(name = "malmeffdate") 
	private LocalDateTime malmeffdate;
	@Column(name = "mlongname", columnDefinition = "nvarchar(200) default ''" ) 
	private String mlongname;
	@Column(name = "mexcesspaid")
	private Double mexcesspaid = 0d;
	@Column(name = "mprdcd", columnDefinition = "nvarchar(75) default ''" ) 
	private String mprdcd;
	@Column(name = "mfrequency", columnDefinition = "nvarchar(1) default ''" ) 
	private String mfrequency;
	@Column(name = "mlastopendate") 
	private LocalDateTime mlastopendate;
	@Column(name = "msdbal")
	private Double msdbal = 0d;
	
}
