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
@Table(name = "md045804" , indexes = {
@Index(name = "kyc_idx",columnList= "mrefno"),
})

@Data
public class KycMasterEntity extends BaseEntity {
	
	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8) default 0")
	private int trefno = 0;
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno = 0;
	
	@Column(name = "mleadsid", columnDefinition = "NVarChar(20) default ''" )
	private String mleadsid = "";
		
	
	@Column(name = "mloantrefno", columnDefinition = "numeric(8) default 0")
	private int mloantrefno = 0;
	
	@Column(name = "mloanmrefno", columnDefinition = "numeric(8) default 0")
	private int mloanmrefno = 0;
	
	@Column(name = "mcusttrefno", columnDefinition = "numeric(8) default 0")
	private int mcusttrefno = 0;
	
	@Column(name = "mcustmrefno", columnDefinition = "numeric(8) default 0")
	private int mcustmrefno = 0;
	
	@Column(name = "mbackground", columnDefinition = "numeric(8) default 0")
	private int mbackground = 0;
	
	@Column(name = "mjob", columnDefinition = "numeric(8) default 0")
	private int mjob = 0;
	
	@Column(name = "mlifestyle", columnDefinition = "numeric(8) default 0")
	private int mlifestyle = 0;
	
	@Column(name = "mloanrepay", columnDefinition = "numeric(8) default 0")
	private int mloanrepay = 0;
	
	@Column(name = "mnetworth", columnDefinition = "numeric(8) default 0")
	private int mnetworth = 0;
	
	@Column(name = "mcomments", columnDefinition = "NVarChar(100) default 0")
	private String mcomments = "";
	
	@Column(name = "mverifiedinfo", columnDefinition = "numeric(8) default 0")
	private int mverifiedinfo = 0;
	
	@Column(name = "merrormessage",  columnDefinition = "nvarchar(250) default ''" )
	private String merrormessage ="";

	
	
}
