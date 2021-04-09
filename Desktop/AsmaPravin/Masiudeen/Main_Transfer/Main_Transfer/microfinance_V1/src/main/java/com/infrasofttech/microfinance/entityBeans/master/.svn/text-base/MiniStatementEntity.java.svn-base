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
@Table(name = "md009040")
@Data
public class MiniStatementEntity extends BaseEntity {

	 @Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0" )
	 private int mlbrcode;      
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
     private int mrefno;
	 @Column(name = "mprdacctid",  columnDefinition = "nvarchar(32) default ''" )
	 private String mprdacctid;	
	 @Column(name = "macttotbalfcy" )
	 private double mactTotbalfcy= 0d;	
	 @Column(name = "mtotallienfcy" )
	 private double mtotallienfcy= 0d;
	 @Column(name = "mshadowbalance" )
	 private double mshadowbalance= 0d;
	 @Column(name = "mcollectiondate" )
	 private LocalDateTime mcollectiondate;	
	 @Column(name = "mremarks",  columnDefinition = "nvarchar(32) default ''" )
	 private String mremarks;	
	 @Column(name = "merrormessage",  columnDefinition = "nvarchar(100) default ''" )
	 private String merrormessage = "";


}
