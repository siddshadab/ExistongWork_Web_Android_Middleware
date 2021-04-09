package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md045803")
@Data
public class TradeAndNeighbourRefCheckEntity extends BaseEntity {
	
	 @Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	 private int trefno;
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)" )
	 private int mrefno;
	 @Column(name = "mloantrefno",  columnDefinition =  "numeric(8) default 0" )	
	 private int mloantrefno;
	 @Column(name = "mloanmrefno",  columnDefinition =  "numeric(8) default 0")	
	 private int mloanmrefno;
	 @Column(name = "mleadsid", columnDefinition = "NVarChar(16) default ''" )
	 private String mleadsid ="";
	 @Column(name = "mleadstatus", columnDefinition = "numeric(2) default 0")
	 private int mleadstatus =0;
	 @Column(name = "msupname", columnDefinition = "NVarChar(50) default ''" )
	 private String msupname ="";
     @Column(name = "msupaddress", columnDefinition = "NVarChar(50) default ''" )
     private String msupaddress ="";
     @Column(name = "msupcontact", columnDefinition = "NVarChar(25) default 0")
     private String msupcontact ="";
     @Column(name = "msupcredit", columnDefinition = "NVarChar(10) default ''" )
     private String msupcredit ="";
     @Column(name = "msuponcredit ", columnDefinition = "NVarChar(10) default ''" )
     private String msuponcredit ="";
     @Column(name = "mclientdelay", columnDefinition = "numeric(4) default 0")
     private int mclientdelay = 0;
     @Column(name = "mdefpayment", columnDefinition = "NVarChar(10) default ''" )
     private String mdefpayment ="";
     @Column(name = "mproductsup", columnDefinition = "NVarChar(50) default ''" )
     private String mproductsup ="";
     @Column(name = "msalcycles", columnDefinition = "numeric(4) default 0")
     private int msalcycles = 0;
     @Column(name = "mvalsalcycles", columnDefinition = "NVarChar(50) default ''" )
     private String mvalsalcycles ="";
     @Column(name = "mloanlender", columnDefinition = "NVarChar(10) default ''" )
     private String mloanlender ="";
     @Column(name = "mfacility", columnDefinition = "NVarChar(10) default ''" )
     private String mfacility ="";
     @Column(name = "mturnover", columnDefinition = "numeric(4) default 0")
     private int mturnover = 0;
     @Column(name = "mremarks", columnDefinition = "NVarChar(100) default ''" )
     private String mremarks ="";
     @Column(name = "mbuyersname", columnDefinition = "NVarChar(100) default ''" )
     private String mbuyersname ="";
     @Column(name = "mbuyersaddress", columnDefinition = "NVarChar(100) default ''" )
     private String mbuyersaddress ="";
     @Column(name = "mcontactno", columnDefinition = "NVarChar(100) default ''" )
     private String mcontactno ="";
     @Column(name = "mbuyingperiod", columnDefinition = "numeric(4) default 0")
     private int mbuyingperiod = 0;
     @Column(name = "mcreditbuying", columnDefinition = "NVarChar(10) default ''" )
     private String mcreditbuying ="";
     @Column(name = "mdays", columnDefinition = "NVarChar(15) default ''" )
     private String mdays ="";
     @Column(name = "mproducts", columnDefinition = "NVarChar(100) default ''" )
     private String mproducts ="";
     @Column(name = "mmonthlypur", columnDefinition = "NVarChar(100) default ''" )
     private String mmonthlypur ="";
     @Column(name = "mquality", columnDefinition = "numeric(4) default 0")
     private int mquality = 0;
     @Column(name = "mreliableper", columnDefinition = "NVarChar(10) default ''" )
     private String mreliableper ="";
     @Column(name = "mcusremarks", columnDefinition = "NVarChar(50) default ''" )
     private String mcusremarks ="";
     @Column(name = "mneigname", columnDefinition = "NVarChar(50) default ''" )
     private String mneigname ="";
     @Column(name = "mneigadd", columnDefinition = "NVarChar(100) default ''" )
     private String mneigadd ="";
     @Column(name = "mknownclient", columnDefinition = "numeric(4) default 0")
     private int mknownclient = 0;
     @Column(name = "mimprovement", columnDefinition = "numeric(4) default 0")
     private int mimprovement = 0;
     @Column(name = "mrelperson", columnDefinition = "NVarChar(10) default ''" )
     private String mrelperson ="";
     @Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )
 	 private String merrormessage = "";
     @Column(name = "mcustmrefno", columnDefinition = "numeric(8) default 0")
	 private int mcustmrefno=0;
	 @Column(name = "mcusttrefno", columnDefinition = "numeric(8) default 0")
	 private int mcusttrefno=0;
	
	 
	 
	  
}
