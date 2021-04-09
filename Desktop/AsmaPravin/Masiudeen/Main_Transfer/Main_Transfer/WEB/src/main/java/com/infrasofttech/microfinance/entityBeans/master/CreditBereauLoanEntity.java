package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "cbresultdetails")
@Data
public class CreditBereauLoanEntity implements Serializable{



	private static final long serialVersionUID = 1L;

	@Id
	 @GeneratedValue(strategy=GenerationType.IDENTITY)
	 @Column(name = "mrefsrno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int mrefsrno;
	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno;
	@Column(name = "trefsrno", columnDefinition = "numeric(8)")               
	private int trefsrno;
	@Column(name = "maccounttype", columnDefinition = "nvarchar(20)" )    	
	private String maccounttype;    	                
	@Column(name = "mcurrentbalance") 	
	private Double mcurrentbalance =0d; 	                
	@Column(name = "mcustbankacnum", columnDefinition = "nvarchar(20)" )  	
	private String mcustbankacnum;  	                
	@Column(name = "mdatereported", columnDefinition = "nvarchar(20)" )   	
	private String mdatereported;   	                
	@Column(name = "mdisbursedamount")                	
	private Double mdisbursedamount=0d;                	
	@Column(name = "mnameofmfi", columnDefinition = "nvarchar(50)" )      	
	private String mnameofmfi;      	                
	@Column(name = "mnocimagestring")
	@Lob
	private byte[] mnocimagestring; 	                
	@Column(name = "moverdueamount")  	
	private double moverdueamount=0d;
	@Column(name = "mwriteoffamount")
	private Double mwriteoffamount = 0d;
/*	@Column(name = "mwriteoffamount", columnDefinition = "nvarchar(10)" ) 	
	private String mwriteoffamount; 	                */
	@Column(name = "madhaarno", columnDefinition = "nvarchar(15)" )      	
	private String madhaarno;      	                
	@Column(name = "magentusername", columnDefinition = "nvarchar(15)" )  	
	private String magentusername;  	 
	
	@Column(name = "mmfiid", columnDefinition = "nvarchar(50)" )      	
	private String mmfiid;      	

	@ManyToOne(fetch = FetchType.EAGER, cascade=CascadeType.ALL)
	@JoinColumns({
		@JoinColumn(name = "mrefno"),
	})	
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private ProspectCreationEntity  loanDetailsProspectEntity;
	
 	


}
