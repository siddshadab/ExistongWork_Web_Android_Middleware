package com.infrasofttech.microfinance.entityBeans.master;

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
@Table(name = "md045806", indexes = { @Index(columnList = "mrefno", name = "md045806AltKey")})
@Data
public class CustomerLoanCashFlowEntity extends BaseEntity {

	
	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8) default 0")
	private int trefno =0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno;
	
	@Column(name = "mleadsid", columnDefinition = "NVarChar(16) default ''" )
	private String mleadsid =""; 
	@Column(name = "mfimainbsinc")
	private Double mfimainbsinc= 0d;            
	  @Column(name = "mfisubbusinc")
	private Double mfisubbusinc= 0d;              
	  @Column(name = "mfirentalinc")
	private Double mfirentalinc = 0d;             
	  @Column(name = "mfiotherinc")
	private Double mfiotherinc = 0d;              
	  @Column(name = "mfitotalInc")
	private Double mfitotalInc  = 0d;             
	  @Column(name = "mbepurequipments")
	private Double mbepurequipments= 0d;            
	@Column(name = "mbepetrolcost")
	private Double  mbepetrolcost = 0d;          
	  @Column(name = "mbewages")
	private Double  mbewages = 0d;                 
	  @Column(name = "mberent")
	private Double  mberent  = 0d;                 
	  @Column(name = "mbeeemi")
	private Double mbeeemi = 0d;                  
	  @Column(name = "mbetotalbusexp")
	private Double  mbetotalbusexp = 0d;           
	  @Column(name = "mfefoodexp")
	private Double mfefoodexp = 0d;                 
	@Column(name = "mfemobileexp")
	private Double  mfemobileexp = 0d;           
	  @Column(name = "mfemedicalexp")
	private Double  mfemedicalexp= 0d;             
	  @Column(name = "mfeschoolfees")
	private Double mfeschoolfees = 0d;            
	  @Column(name = "mfecollegefees")
	private Double  mfecollegefees= 0d;            
	  @Column(name = "mfemiscellaneous")
	private Double mfemiscellaneous= 0d;          
	  @Column(name = "mfeelectricity")
	private Double  mfeelectricity= 0d;            
	  @Column(name = "mfesocialcharity")
	private Double  mfesocialcharity= 0d;          
	  @Column(name = "mfetotalfaminc")
	private Double mfetotalfaminc= 0d;            
	  @Column(name = "mfetotalexp")
	private Double  mfetotalexp = 0d;              
	  @Column(name = "msurpluscash")
	private Double msurpluscash  = 0d;            
	  @Column(name = "mdbr")
	  private Double mdbr = 0d; 
	  
	   @Column(name = "mloanmrefno", columnDefinition = "numeric(8) default 0")
	   private int mloanmrefno =0;
	   @Column(name = "mloantrefno", columnDefinition = "numeric(8) default 0")
	   private int mloantrefno=0;
	   @Column(name = "mcustmrefno", columnDefinition = "numeric(8) default 0")
	   private int mcustmrefno=0;
	   @Column(name = "mcusttrefno", columnDefinition = "numeric(8) default 0")
	   private int mcusttrefno=0;
	   
	   
	   @Column(name = "merrormessage",  columnDefinition = "nvarchar(250) default ''" )
		private String merrormessage ="";
	  
	  
	
	
	
}
