package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "currentlocationMaster")
@Data
public class CurrentLocationMasterEntity extends BaseEntity{
	
    @Id
    @Column(name = "musrcode", unique = true, nullable = false,  columnDefinition = "nvarchar(8)")
    private String musrcode; 
    @Column(name = "musrname",  columnDefinition = "nvarchar(100)" )        	
	 private String musrname;        
     @Column(name = "mreportinguser",  columnDefinition = "nvarchar(8)",updatable=false )  	
	 private String mreportinguser; 
     @Transient @Lob private byte[] profileimage;

}
