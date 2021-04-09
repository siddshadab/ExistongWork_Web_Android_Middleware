package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import com.infrasofttech.microfinance.entityBeans.master.CheckListGRTEntity;

import lombok.Data;

@Data
public class GrtHolderBean {	
	
	private int trefno;
	private int mrefno;
	private int loantrefno;
	private int loanmrefno;
	private String mleadsid;
	private String mgrtdoneby;
	private LocalDateTime mstarttime;
	private LocalDateTime mendtime;
	private String mroutefrom;
	private String mrouteto;
	private String mremark;
	private String midtype1status;
	private String midtype2status;
	private String midtype3status;
	private LocalDateTime mcreateddt;	   
	private String mcreatedby;
	private LocalDateTime mlastupdatedt;		
	private String mlastupdateby;		
	private String mgeolocation;	
	private String mgeolatd;	
	private String mgeologd;	
	private int missynctocoresys;
	private LocalDateTime mlastsynsdate;

	private List<CheckListGRTEntity> checkListGrtDetails ;

}
