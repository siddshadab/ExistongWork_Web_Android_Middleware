package com.infrasofttech.microfinance.entityBeans.master;

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
@Table(name = "loanImageEntity", indexes = { @Index(columnList = "mrefno", name = "md045806AltKey")})
@Data
public class LoanImageEntity extends BaseEntity {

	
	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8) default 0")
	private int trefno =0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno;
	@Column(name = "mimagebyteorfolder", columnDefinition = "numeric(2) default 0")
	private int mimagebyteorfolder =0; 
	@Column(name = "mimagepath", columnDefinition = "NVarChar(100) default ''" )
	private String mimagepath =""; 
	@Lob
	private byte[] mimagestring;
	
	@Column(name = "mimagetype", columnDefinition = "NVarChar(50) default ''" )
	private String mimagetype =""; 
	
	@Column(name = "mimgsubtype", columnDefinition = "NVarChar(50) default ''" )
	private String mimgsubtype =""; 
	
	@Column(name = "mimgsize", columnDefinition = "numeric(8) default 0")
	private int mimgsize =0;
	
	@Column(name = "mloanmrefno", columnDefinition = "numeric(8) default 0")
	   private int mloanmrefno =0;
	@Column(name = "mloantrefno", columnDefinition = "numeric(8) default 0")
	   private int mloantrefno=0;
	   
	
	
	
	
}
