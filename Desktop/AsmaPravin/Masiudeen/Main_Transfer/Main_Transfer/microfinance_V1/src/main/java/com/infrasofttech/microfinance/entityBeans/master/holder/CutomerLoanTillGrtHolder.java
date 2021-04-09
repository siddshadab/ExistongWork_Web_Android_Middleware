package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.CGT2Entity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.GRTEntity;

import lombok.Data;

@Data
public class CutomerLoanTillGrtHolder {
	
	private int trefno;	
	private int mrefno;	
	private String mleadsid;	
	private Double mappldloanamt = 0d;	
	private Double mapprvdloanamt = 0d;	
	private int mcustno;	
	private Double mloanamtdisbd = 0d;	
	private LocalDateTime mloandisbdt;	
	private int mleadstatus;	
	private LocalDateTime mexpdt;	
	private Double minstamt = 0d;	
	private LocalDateTime minststrtdt;	
	private Double minterestamount = 0d;		
	private int mrepaymentmode;	
	private int mmodeofdisb;	
	private int mPeriod;	
	private String  mprdcd;	
	private int mpurposeofloan;		
	private int msubpurposeofloan;	
	private Double mintrate = 0d;	
	private String mroutefrom;	
	private String mrouteto;	
	private String mprdacctid;	
	private int mloancycle;	
	private String mfrequency;	
	private  String mapprovaldesc;	
	private String merrormessage;	
	private LocalDateTime mcreateddt;	   
	private String mcreatedby;
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime mlastupdatedt;		
	private String mlastupdateby;		
	private String mgeolocation;	
	private String mgeolatd;	
	private String mgeologd;	
	private int missynctocoresys;
	private String mappliedasind;
	private int mcheckresaddchng;
	private String mspouserelname;
	private int mcheckspouserepay;
	private int mcheckbiometric;
	private int momnileadstatus;
	private int mlbrcode;
	//@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime mlastsynsdate;
	private int mcusttrefno;
	private int mcustmrefno;
	private int misdisbursed;
	List<CGT1Entity> cgt1Bean;
	List<CGT2Entity> cgt2Bean;
	List<GRTEntity> grtBean;
	CustomerEntity custBean;

}
