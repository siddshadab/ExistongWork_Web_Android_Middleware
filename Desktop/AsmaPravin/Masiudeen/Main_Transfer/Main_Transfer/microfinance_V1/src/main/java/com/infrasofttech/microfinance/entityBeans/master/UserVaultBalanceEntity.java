package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;


@Entity
@Table(name = "md011054")
@Data
public class UserVaultBalanceEntity extends BaseEntity{
	

	@EmbeddedId
  	private UserVaultBalanceCompositetEntity userVaultBalanceCompositetEntity; 	
	
	 @Column(name = "acctStat",  columnDefinition = "numeric(8)" )        	
	 private int acctStat;
	 
	 @Column(name = "cashtype",  columnDefinition = "numeric(8)" )        	
	 private int cashtype;
	 
	 @Column(name = "magenta",  columnDefinition = "nvarchar(120) default ''")    	
	 private String magenta;    


	 @Column(name = "usertype",  columnDefinition = "nvarchar(12) default ''")    	
	 private String usertype; 
	 
	 @Column(name = "mbalance")
	 private Double mbalance = 0d;

	
}
