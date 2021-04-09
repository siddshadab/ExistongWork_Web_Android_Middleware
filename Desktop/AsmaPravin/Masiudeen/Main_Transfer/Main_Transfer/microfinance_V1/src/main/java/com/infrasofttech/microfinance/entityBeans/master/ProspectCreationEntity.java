package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.IndexColumn;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnore;
/*
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.IndexColumn;*/
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md970555" , indexes = {
		@Index(columnList = "trefno", name = "trefno_hidx"),
		@Index(columnList = "mrefno", name = "mrefno_hidx"),
		@Index(columnList = "mcreatedby", name = "mcreatedby_hidx"),
		@Index(columnList = "mlastsynsdate", name = "mlastsynsdate_hidx"),
		@Index(columnList = "mcreateddt", name = "mcreateddt_hidx"),
		@Index(columnList = "mlastupdatedt", name = "mlastupdatedt_hidx")
})
@Data
public class ProspectCreationEntity extends BaseEntity{
	
	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int  trefno;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )	 
	private int mlbrcode;
	@Column(name = "mqueueno",  columnDefinition = "numeric(8)" )	 
	private int mqueueno;
	@Column(name = "mprospectdt") 
	private LocalDateTime mprospectdt;
	@Column(name = "mnametitle",  columnDefinition = "nvarchar(6)" )	 
	private String mnametitle;
	@Column(name = "mprospectname",  columnDefinition = "nvarchar(60)" )	 
	private String mprospectname;
	@Column(name = "mmobno",  columnDefinition = "nvarchar(15)" )
	private String mmobno;
	@Column(name = "mdob" )	 
	private LocalDateTime mdob;
	@Column(name = "motpverified",  columnDefinition = "numeric(1)" )	  
	private int motpverified;
	@Column(name = "mcbcheckstatus",  columnDefinition = "nvarchar(5)" )	 
	private String mcbcheckstatus;
	@Column(name = "mprospectstatus",  columnDefinition = "numeric(2)" )	 
	private int mprospectstatus;
	@Column(name = "madd1",  columnDefinition = "nvarchar(75)" )	 
	private String madd1;
	@Column(name = "madd2",  columnDefinition = "nvarchar(75)" )	 
	private String madd2;
	@Column(name = "madd3",  columnDefinition = "nvarchar(75)" )	 
	private String madd3;
	@Column(name = "mhomeloc",  columnDefinition = "nvarchar(75)" )	 
	private String mhomeloc;
	@Column(name = "mareacd",  columnDefinition = "numeric(8)" )	 
	private int mareacd;
	@Column(name = "mvillage",  columnDefinition = "nvarchar(50)" )	 
	private String mvillage;
	@Column(name = "mdistcd",  columnDefinition = "numeric(8)" )	  
	private int mdistcd;
	@Column(name = "mstatecd",  columnDefinition = "nvarchar(8)" )	 
	private String mstatecd;
	@Column(name = "mcountrycd",  columnDefinition = "nvarchar(8)" )	 
	private String mcountrycd;
	@Column(name = "mpincode",  columnDefinition = "numeric(15)" )	 
	private int  mpincode;
	@Column(name = " mcountryoforigin",  columnDefinition = "nvarchar(8)" )	 
	private String  mcountryoforigin;
	@Column(name = "mnationality",  columnDefinition = "nvarchar(8)" )	 
	private String mnationality;
	@Column(name = "mpanno",  columnDefinition = "nvarchar(20)" )	 
	private String mpanno;
	@Column(name = " mpannodesc",  columnDefinition = "nvarchar(20)" )	 
	private String  mpannodesc;
	@Column(name = " misuploaded",  columnDefinition = "numeric(1)" )	 
	private int  misuploaded;
	@Column(name = "mspousename",  columnDefinition = "nvarchar(50)" )	 
	private String mspousename;
	@Column(name = "mspouserelation",  columnDefinition = "nvarchar(5)" )
	private String mspouserelation;
	@Column(name = " mnomineename",  columnDefinition = "nvarchar(50)" )
	private String  mnomineename;
	@Column(name = "mnomineerelation",  columnDefinition = "nvarchar(30)" )	 
	private String mnomineerelation;
	@Column(name = " mcreditenqpurposetype",  columnDefinition = "nvarchar(40)" )
	private String  mcreditenqpurposetype;
	@Column(name = " mcreditequstage",  columnDefinition = "nvarchar(40)" )	 
	private String  mcreditequstage;
	@Column(name = " mcreditreporttransdatetype" )
	private LocalDateTime  mcreditreporttransdatetype;
	@Column(name = " mcreditreporttransid",  columnDefinition = "nvarchar(40)" )
	private String  mcreditreporttransid;
	@Column(name = " mcreditrequesttype",  columnDefinition = "nvarchar(40)" )	 
	private String  mcreditrequesttype;
	/*@Column(name = "mcreateddt",  columnDefinition = "nvarchar(50)" )	 
	private LocalDateTime mcreateddt;
	@Column(name = " mcreatedby",  columnDefinition = "nvarchar(8)" )	 
	private String  mcreatedby;
	@Column(name = "  mlastupdatedt",  columnDefinition = "nvarchar(50)" )	 
	private LocalDateTime   mlastupdatedt;
	@Column(name = "mlastupdateby",  columnDefinition = "nvarchar(8)" )
	private String mlastupdateby;
	@Column(name = "mgeolocation",  columnDefinition = "nvarchar(250)" )	 
	private String mgeolocation;
	@Column(name = "mgeolatd",  columnDefinition = "nvarchar(20)" )	 
	private String mgeolatd;
	@Column(name = "mgeologd",  columnDefinition = "nvarchar(20)" )	 
	private String mgeologd;
	@Column(name = "missync",  columnDefinition = "numeric(1)" )	 
	private int  missync;
	@Column(name = "mlastsynsdate",  columnDefinition = "nvarchar(50)" )	 
	private LocalDateTime mlastsynsdate;*/
	
	@Column(name = " mstreet",  columnDefinition = "nvarchar(100)" )	 
	private String  mstreet;
	@Column(name = "mhouse",  columnDefinition = "nvarchar(100)" )
	private String mhouse;
	@Column(name = "mcity",  columnDefinition = "nvarchar(25)" )	 
	private String mcity;
	@Column(name = "mstate",  columnDefinition = "nvarchar(25)" )	 
	private String mstate;
	@Column(name = "mid1",  columnDefinition = "nvarchar(20)" )	 
	private String mid1;
	@Column(name = "mid1desc",  columnDefinition = "nvarchar(20)" )	 
	private String mid1desc;
	@Column(name = "mroutedto",  columnDefinition = "nvarchar(8)" )	 
	private String mroutedto;
	@Column(name = "iscustcreated",  columnDefinition = "numeric(1)" )	 
	private int iscustcreated;
	@Column(name = "mtier",  columnDefinition = "numeric(1)")
	private int mtier;
	@Column(name = "mcustno",  columnDefinition = "numeric(8)")
	private int mcustno;
	@Column(name = " mhighmarkchkdt" )
	private LocalDateTime  mhighmarkchkdt;
	
    
    @OneToOne(mappedBy = "resultDetailsProspectEntity", cascade = CascadeType.ALL,fetch=FetchType.EAGER)
	@Fetch(FetchMode.SELECT)
	@IndexColumn(name="INDEX_COL")
	/*@JsonIgnore
  	@LazyCollection(LazyCollectionOption.FALSE)*/
    private CreditBereauResultMasterEntity cbResultMasterDetails;
    

    @OneToMany(mappedBy = "loanDetailsProspectEntity", cascade = CascadeType.ALL,fetch=FetchType.EAGER)
    @Fetch(FetchMode.SELECT)
	@IndexColumn(name="INDEX_COL")
	/*@JsonIgnore
	    	@LazyCollection(LazyCollectionOption.FALSE)*/
	private List<CreditBereauLoanEntity> cbLoanDetails = new ArrayList<CreditBereauLoanEntity>();
    
    

    
}
