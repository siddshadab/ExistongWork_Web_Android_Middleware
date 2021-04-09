package com.infrasofttech.microfinance.entityBeans.master;



import java.time.LocalDate;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import lombok.Data;

@Entity
@Table(name = "mgd009011", indexes = {
		@Index(columnList = "trefno", name = "trefno_hidx"),
		/*
		 * @Index(columnList = "mcustno", name = "mcustno_hidx"),
		 */		@Index(columnList = "mcreatedby", name = "mcreatedby_hidx"),
		@Index(columnList = "mlastsynsdate", name = "mlastsynsdate_hidx"),
		@Index(columnList = "mcreateddt", name = "mcreateddt_hidx"),
		@Index(columnList = "mlastupdatedt", name = "mlastupdatedt_hidx")
})
@Data
public class GroupsFoundationEntity extends BaseEntity{
	

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno; 	
	@Column(name = "trefno",  columnDefinition = "numeric(8) default 0" )	
	private int trefno;		
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mgroupid",  columnDefinition = "numeric(8)" )	
	private int mgroupid;		
	@Column(name = "mgroupname",  columnDefinition = "nvarchar(100)" )	
	private String mgroupname;		
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )	
	private int mlbrcode;		
	@Column(name = "magentcd",  columnDefinition = "nvarchar(8)" )	
	private String magentcd;		
	@Column(name = "mcenterid",  columnDefinition = "numeric(8)" )	
	private int mcenterid;		
	@Column(name = "mgrprecogtestdate")	
	private LocalDateTime mgrprecogtestdate;		
	@Column(name = "mmaxgroupmembers",  columnDefinition = "numeric(8)" )	
	private int mmaxgroupmembers;		
	@Column(name = "mmingroupmembers",  columnDefinition = "numeric(8)" )	
	private int mmingroupmembers;		
	@Column(name = "mgrouptype",  columnDefinition = "nvarchar(2)" )	
	private String mgrouptype;		
	@Column(name = "mgrtapprovedby",  columnDefinition = "nvarchar(8)" )	
	private String mgrtapprovedby;		
	@Column(name = "mloanlimit" )	
	private double mloanlimit;		
	@Column(name = "meetingday",  columnDefinition = "numeric(2)" )	
	private int meetingday;		
	@Column(name = "mcreateddt")	
	private LocalDateTime mcreateddt;		
	@Column(name = "mcreatedby",  columnDefinition = "nvarchar(8)" )	
	private String mcreatedby;		
	@Column(name = "mlastupdatedt")	
	private LocalDateTime mlastupdatedt;		
	@Column(name = "mlastupdateby",  columnDefinition = "nvarchar(8)" )	
	private String mlastupdateby;		
	@Column(name = "mgeolocation",  columnDefinition = "nvarchar(250)" )	
	private String mgeolocation;		
	@Column(name = "mgeolatd",  columnDefinition = "nvarchar(20)" )	
	private String mgeolatd;		
	@Column(name = "mgeologd",  columnDefinition = "nvarchar(20)" )	
	private String mgeologd;		
	@Column(name = "mlastsynsdate")	
	private LocalDateTime mlastsynsdate;
	@Column(name = "mgroupprdcode",  columnDefinition = "nvarchar(8) default ''" )	
	private String mgroupprdcode;	
	@Column(name = "mgroupgender",  columnDefinition = "nvarchar(4) default ''" )	
	private String mgroupgender;				
	@Column(name = "trefcenterid", nullable = false, columnDefinition = "int default 0" )
	private int trefcenterid; 	
	@Column(name = "mrefcenterid", nullable = false, columnDefinition = "int default 0" )	
	private int mrefcenterid;	
	
	@Column(name = "merrormessage",  columnDefinition = "nvarchar(250) default ''" )
	private String merrormessage ="";	
	
	
}
