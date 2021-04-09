package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "licenseMaster")
@Data
public class LicenseMasterEntity {

	@Id
    @Column(name = "srno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int srno;  
	@Column(name = "mlicensekey",  columnDefinition = "nvarchar(100) default ''" )
	private String mlicensekey;
	
	 @Column(name = "mlastupdatedt")
	 private LocalDateTime mlastupdatedt;
	 
	 @Column(name = "mlastupdateby",  columnDefinition = "NVarChar(10)")
	 private String mlastupdateby;
	 
	 @Column(name = "mgeolocation",  columnDefinition = "NVarChar(250)")
	 private String mgeolocation;
	 
	 @Column(name = "mgeolatd",  columnDefinition = "NVarChar(20)")
	 private String mgeolatd;
	 
	 @Column(name = "mgeologd",  columnDefinition = "NVarChar(20)")
	 private String mgeologd;
	
	
	
	
	
}
