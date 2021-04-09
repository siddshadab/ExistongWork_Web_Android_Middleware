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
@Table(name = "md009022")
@Data
public class SavingsListEntity extends BaseEntity {


	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;    	
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0" )
	private int mlbrcode;     
    @Column(name = "mcusttrefno", columnDefinition = "numeric(8) default 0")
    private int mcusttrefno; 
    @Column(name = "mcustmrefno", columnDefinition = "numeric(8)")
	private int mcustmrefno;  
	 @Column(name = "mprdacctid",  columnDefinition = "nvarchar(32) default ''" )
	 private String mprdacctid;	
	 @Column(name = "mmobno",  columnDefinition = "nvarchar(15) default ''" )
	 private String mmobno;	
	 @Column(name = "mlongname",  columnDefinition = "nvarchar(200) default ''" )
	 private String mlongname;	
	 @Column(name = "mcurcd",  columnDefinition = "nvarchar(3) default ''" )
	 private String mcurcd;	
	 @Column(name = "mprdcd",  columnDefinition = "nvarchar(8) default ''" )
	 private String mprdcd;	
	 @Column(name = "mdateopen" )
	 private LocalDateTime mdateopen;	
	 @Column(name = "mdateclosed" )
	 private LocalDateTime mdateclosed;	
	 @Column(name = "mfreezetype",  columnDefinition = "numeric(2) default 0" )
	 private int mfreezetype;	
	 @Column(name = "macctstat",  columnDefinition = "numeric(2) default 0" )
	 private int macctstat;	
	 @Column(name = "mcustno",  columnDefinition = "numeric(8) default 0" )
	 private int mcustno;	
	 @Column(name = "macttotbalfcy" )
	 private double mactTotbalfcy= 0d;	
	 @Column(name = "mtotallienfcy" )
	 private double mtotallienfcy= 0d;
	 @Column(name = "mmoduletype",  columnDefinition = "numeric(4) default 0" )
	 private int mmoduletype;	
	 @Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )
		private String merrormessage = "";
	 @Column(name = "mcenterid",  columnDefinition = "numeric(8) default 0" )
	 private int mcenterid;
	 @Column(name = "mgroupcd",  columnDefinition = "numeric(8) default 0" )
	 private int mgroupcd;
	 @Column(name = "mcrs",  columnDefinition = "nvarchar(8) default ''" )
	 private String mcrs;	
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
