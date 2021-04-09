package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "loanLevelMaster")
@Data
public class LoanLevelMasterEntity {
	
	@Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
    private int mrefno;
	
	
	@Column(name = "mbuttonid",  columnDefinition = "numeric(2) default 0" )	
	private int mbuttonid = 0;
	
	@Column(name = "mbuttonname",  columnDefinition = "nvarchar(30)" )
	private String mbuttonname; 	
	
	@Column(name = "mstageid",  columnDefinition = "numeric(2) default 0" )	
	private int mstageid = 0;
	
	@Column(name = "mproductname",  columnDefinition = "nvarchar(75)" )
	private String mproductname; 	
		
	@Column(name = "mprdcd",  nullable = false, columnDefinition = "nvarchar(8)")               
	private String mprdcd;  
	
	@Column(name = "morderid",  columnDefinition = "numeric(2) default 0" )	
	private int morderid = 0;
	
	
	@Column(name = "mismandatory",  columnDefinition = "numeric(2) default 0" )	
	private int mismandatory = 0;


	@Override
	public String toString() {
		return "LoanLevelMasterEntity [mrefno=" + mrefno + ", mbuttonid=" + mbuttonid + ", mbuttonname=" + mbuttonname
				+ ", mstageid=" + mstageid + ", mproductname=" + mproductname + ", mprdcd=" + mprdcd + ", morderid="
				+ morderid + ", mismandatory=" + mismandatory + "]";
	}

}
