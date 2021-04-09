package com.infrasofttech.microfinance.entityBeans.master;


import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "pathTrackerMaster")
@Data
public class PathTrackerMasterEntity extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno;
	
    @Column(name = "musrcode",   columnDefinition = "nvarchar(8)")
    private String musrcode; 
    @Column(name = "musrname",  columnDefinition = "nvarchar(100)" )        	
	 private String musrname;        
     @Column(name = "mreportinguser",  columnDefinition = "nvarchar(8)" )  	
	 private String mreportinguser; 
    

}
