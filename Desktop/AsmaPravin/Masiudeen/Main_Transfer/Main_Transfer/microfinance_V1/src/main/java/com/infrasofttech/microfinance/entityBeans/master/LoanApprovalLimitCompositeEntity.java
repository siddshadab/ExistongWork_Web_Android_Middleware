package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class LoanApprovalLimitCompositeEntity implements Serializable{
	

	
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0" ) 
	private int mlbrcode;   	
	@Column(name = "mgrpcd",  columnDefinition = "numeric(8) default 0" )     	
	private int mgrpcd;  	
	@Column(name = "musercd",  columnDefinition = "nvarchar(8) default ''" )  	
	private String musercd;
        @Column(name = "msrno",  columnDefinition = "numeric(8) default 0" )            	
	private int msrno; 
   	

	public LoanApprovalLimitCompositeEntity() {

	}


	public LoanApprovalLimitCompositeEntity(int lbrcode, int mgrpcd,String musercd,int msrno) {
		this.mlbrcode=lbrcode;
		this.mgrpcd=mgrpcd;
		this.musercd=musercd;
		this.msrno=msrno;
		
	}
	
	
	public int getmlbrcode() {
		return mlbrcode;
	}


	public void setmlbrcode(int lbrcode) {
		this.mlbrcode = lbrcode;
	}


	public int getmgrpcd() {
		return mgrpcd;
	}


	public void setmgrpcd(int mgrpcd) {
		this.mgrpcd = mgrpcd;
	}
	
	public String getmusercd() {
		return musercd;
	}


	public void setmusercd(String musercd) {
		this.musercd = musercd;
	}
		public int getmsrno() {
		return msrno;
	}


	public void setmsrno(int srno) {
		this.msrno = srno;
	}
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof LoanApprovalLimitCompositeEntity )){
		return false;
	}
	
	return Objects.equals(getmlbrcode(), this.getmlbrcode()) &&
            Objects.equals(getmgrpcd(), this.getmgrpcd()) &&
            Objects.equals(getmusercd(), this.getmusercd()) &&          
                    Objects.equals(getmsrno(), this.getmsrno()
);

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmlbrcode(),getmgrpcd(),getmusercd(),getmsrno());
	}


	

}
