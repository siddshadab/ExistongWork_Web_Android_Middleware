package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md002026" ,indexes = {@Index(columnList = "musrcode", name = "musrcode_hidx"),})
@Data
public class SecondaryUserMasterEntity extends BaseEntity{

	@Id
    @Column(name = "musrcode", unique = true, nullable = false,  columnDefinition = "nvarchar(8)")
    private String musrcode;  
	
	@Column(name = "musrpass",  columnDefinition = "nvarchar(30)" )        	
	 private String musrpass;
	
	@Column(name = "mstatus",  columnDefinition = "numeric(4)" )        	
	 private int  mstatus;
	
	@Column(name = "mregdevicemacid",  columnDefinition = "nvarchar(100)" )        	
	 private String mregdevicemacid;
	
	@Column(name = "mlastpwdchgdt")        	
	 private LocalDateTime mlastpwdchgdt;
	
	@Column(name = "mnextpwdchgdt")        	
	 private LocalDateTime mnextpwdchgdt;
	
	
	
	@Column(name = "newpassword",  columnDefinition = "nvarchar(30)" )        	
	 private String newpassword;
	
	
	@Column(name = "moldpass1",  columnDefinition = "nvarchar(30)" )        	
	 private String moldpass1;
	
	@Column(name = "moldpass2",  columnDefinition = "nvarchar(30)" )        	
	 private String moldpass2;
	
	@Column(name = "moldpass3",  columnDefinition = "nvarchar(30)" )        	
	 private String moldpass3;
	
	@Column(name = "merrorcode",  columnDefinition = "numeric(2)" )           	
	 private int merrorcode; 
	@Column(name = "merrormessage",  columnDefinition = "nvarchar(100)" )           	
	 private String merrormessage; 
	
	
	
}
