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
@Table(name = "focollectedsheet" , indexes = {
		@Index(name = "mcrtdbyMlbrAndIsSynctoCbs_hidx",columnList= "mlbrcode,mcreatedby,missynctocoresys"),
})

@Data

public class DailyLoanCollectedEntity extends BaseEntity {


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
	@Column(name = "mcenterid",  columnDefinition = "numeric(8) default 0")	
	private int mcenterid=0;		
	@Column(name = "mgroupid",  columnDefinition = "numeric(8) default 0")	
	private int mgroupid=0;			
	@Column(name = "mfocode", columnDefinition = "nvarchar(8) default ''" ) 
	private String mfocode;	
	@Column(name = "memino",  columnDefinition = "numeric(8) default 0")	
	private int memino=0;		
	@Column(name = "malmeffdate") 
	private LocalDateTime malmeffdate;		
	@Column(name ="madjfrmsd", columnDefinition = "numeric(2) default 0")	
	private int madjfrmsd =0;	
	@Column(name = "madjfrmexcss" ,  columnDefinition = "numeric(2) default 0")	
	private int madjfrmexcss=0;	
	@Column(name = "mpaidbygrp" ,  columnDefinition = "numeric(2) default 0")	
	private int mpaidbygrp=0;
	@Column(name = "mattndnc" ,  columnDefinition = "numeric(2) default 0")	
	private int mattndnc=0;	
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")	
	private int mcustno=0;	
	@Column(name = "mremarks", columnDefinition = "nvarchar(60) default ''" ) 
	private String mremarks;
	@Column(name = "mcollamt" , nullable = true) 
	private Double mcollamt= 0d;
	@Column(name = "midealbaldate") 
	private LocalDateTime midealbaldate;	
	@Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )
	private String merrormessage = "";
	@Column(name = "mbatchcd", columnDefinition = "nvarchar(20) default ''" ) 
	private String mbatchcd;
	@Column(name = "srno", nullable = false, columnDefinition = "int default 0" )	
	private int srno;

}
