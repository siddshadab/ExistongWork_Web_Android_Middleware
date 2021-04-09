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
@Table(name = "userActivity")
@Data
public class UserActivityEntity extends BaseEntity{
	
	
	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8) default 0")
	private int trefno =0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno;
	
	@Column(name = "musercode", columnDefinition = "NVarChar(8) default ''" )
	private String musercode ="";
	
	/*@Id
    @Column(name = "musercode", unique = true, nullable = false,  columnDefinition = "nvarchar(8)")
    private String musercode;  	*/	
        		
	@Column(name = "mcustno", columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;
		
	@Column(name = "mcenterid", columnDefinition = "numeric(8) default 0")
	private int mcenterid = 0;
	
	@Column(name = "mgroupcd", columnDefinition = "numeric(8) default 0")
	private int mgroupcd = 0;
	
	 @Column(name = "mtxnamount")
	 private Double mtxnamount = 0d;
	 
	 @Column(name = "msstemnarration",  columnDefinition = "nvarchar(250) default ''")    	
	 private String msystemnarration;  
	 
	 @Column(name = "musernarration",  columnDefinition = "nvarchar(250) default ''")    	
	 private String musernarration;  
	 

	 @Column(name = "mactivity",  columnDefinition = "nvarchar(80) default ''")    	
	 private String mactivity;  
	 
	 @Column(name = "mmoduletype", columnDefinition = "numeric(4) default 0")
	 private int mmoduletype = 0;
	 
	 
	 @Column(name = "mtxnrefno",  columnDefinition = "nvarchar(32) default ''")    	
	 private String mtxnreno;  
	 
	 
	 @Column(name = "mcorerefno",  columnDefinition = "nvarchar(150) default ''")    	
	 private String mcorerefno;  
	 
	 
	 @Column(name = "status",  columnDefinition = "nvarchar(32) default ''")    	
	 private String status;  
	 
	 @Column(name = "screenname",  columnDefinition = "nvarchar(90) default ''")    	
	 private String screenname;  
	 	
}
