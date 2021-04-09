package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class LoanCycleParameterPrimaryCompositeEntity   implements Serializable{
	

	
	
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )	
	private int mlbrcode;		
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(8)" )	
	private String mprdcd;		
	@Column(name = "meffdate" )	
	private LocalDateTime meffdate;	
        @Column(name = "mloancycle",  columnDefinition = "numeric(8)" )        	
	private int mloancycle;
        @Column(name = "mcusttype",  columnDefinition = "numeric(6)" )        	
	private int mcusttype;        	
	@Column(name = "mgrtype",  columnDefinition = "numeric(6)" )	
	private int mgrtype;

	public LoanCycleParameterPrimaryCompositeEntity() {

	}


	public LoanCycleParameterPrimaryCompositeEntity(int lbrcode, String prdcd,LocalDateTime effdate,int loancycle,int custtype,int grtype ) {
		this.mlbrcode=lbrcode;
		this.mprdcd=prdcd;
		
		this.meffdate=effdate;
                this.mloancycle=loancycle;
this.mcusttype=custtype;
this.mgrtype=grtype;
	}
	
	
	public int getmlbrcode() {
		return mlbrcode;
	}


	public void setmlbrcode(int lbrcode) {
		this.mlbrcode = lbrcode;
	}


	public String getmprdcd() {
		return mprdcd;
	}


	public void setmprdcd(String prdcd) {
		this.mprdcd = prdcd;
	}
	
	
	

	public LocalDateTime getmeffdate() {
		return meffdate;
	}


	public void setmeffdate(LocalDateTime effdate) {
		this.meffdate = effdate;
	}
	public int getmloancycle() {
		return mloancycle;
	}


	public void setmloancycle(int loancycle) {
		this.mloancycle = loancycle;
	}
         public int getmcusttype() {
		return mcusttype;
	}


	public void setmlbrcodecusttype(int custtype) {
		this.mcusttype = custtype;
	}
       public int getmgrtype() {
		return mgrtype;
	}


	public void setmgrtype(int grtype) {
		this.mgrtype = grtype;
	}
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof CustomerCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getmlbrcode(), this.getmlbrcode()) &&
            Objects.equals(getmprdcd(), this.getmprdcd()) &&
            Objects.equals(getmeffdate(), this.getmeffdate())&&
            Objects.equals(getmloancycle(), this.getmloancycle()) &&
            Objects.equals(getmcusttype(), this.getmcusttype())&&
            Objects.equals(getmgrtype(), this.getmgrtype()) ;

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmlbrcode(),getmprdcd(),getmeffdate(),getmloancycle(),getmcusttype(),getmgrtype());
	}


	

}
