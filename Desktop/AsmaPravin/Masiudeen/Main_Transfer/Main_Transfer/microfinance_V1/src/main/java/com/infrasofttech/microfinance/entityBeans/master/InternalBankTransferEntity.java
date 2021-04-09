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
@Table(name = "internalBankTranferMaster")
@Data
public class InternalBankTransferEntity extends BaseEntity{
	
	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno; 
	
	@Column(name = "mlbrcode", nullable = false, columnDefinition = "numeric(8)")
	private int mlbrcode;
	
	@Column(name = "mcashtr", nullable = false, columnDefinition = "numeric(2)")
	private int mcashtr;
	
	@Column(name = "mcrdr", columnDefinition = "NVarChar(2) default ''")
	private  String mcrdr;
	
	@Column(name = "mremark", columnDefinition = "NVarChar(50) default ''")
	private  String mremark;
	
	@Column(name = "mnarration", columnDefinition = "NVarChar(2) default ''")
	private  String mnarration;
	
	
	@Column(name = "mamt")
	private Double mamt = 0d;
	
	@Column(name = "maccid", columnDefinition = "NVarChar(40) default ''")
	private  String maccid;
	
	@Column(name = "mdraccid", columnDefinition = "NVarChar(40) default ''")
	private  String mdraccid;
	
	@Column(name = "mcraccid", columnDefinition = "NVarChar(40) default ''")
	private  String mcraccid;
	
	@Column(name = "merrormessage", columnDefinition = "NVarChar(100) default ''")
	private String merrormessage;
	
	@Column(name = "missyncfromcoresys", nullable = false, columnDefinition = "int default 0" )	
	private int missyncfromcoresys;
	
	@Column(name = "mretry", nullable = false, columnDefinition = "int default 0" )	
	private int mretry;

}
