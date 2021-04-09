package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class InterestOffsetCompositeEntity   implements Serializable{
	

	
	
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )	
	private int mlbrcode;		
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(8)" )	
	private String mprdcd;	
	@Column(name = "mloancycle",  columnDefinition = "numeric(4)" )	
	private int mloancycle;	
	@Column(name = "mloantype",  columnDefinition = "numeric(1)" )	
	private int mloantype;	
	@Column(name = "meffdate" )	
	private LocalDateTime meffdate;	
	@Column(name = "msrno",  columnDefinition = "numeric(8)" )	
	private int msrno;	

	public InterestOffsetCompositeEntity() {

	}


	public InterestOffsetCompositeEntity(int lbrcode, String prdcd,int loancycle,int loantype,LocalDateTime effdate,int srno ) {
		this.mlbrcode=lbrcode;
		this.mprdcd=prdcd;
		this.mloancycle=loancycle;
		this.mloantype = loantype;
		this.meffdate=effdate;
		this.msrno=srno;
				
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
	
	public int getmloancycle() {
		return mloancycle;
	}

	public void setmloancycle(int loancycle) {
		this.mloancycle = loancycle;
	}
	
	public int getmloantype() {
		return mloantype;
	}

	public void setmloantype(int loantype) {
		this.mloantype = loantype;
	}

	public LocalDateTime getmeffdate() {
		return meffdate;
	}


	public void setmeffdate(LocalDateTime effdate) {
		this.meffdate = effdate;
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
	if(! (obj instanceof CustomerCompositePrimaryEntity)){
		return false;
	}
	
	return Objects.equals(getmlbrcode(), this.getmlbrcode()) &&
            Objects.equals(getmprdcd(), this.getmprdcd()) &&
            Objects.equals(getmloancycle(), this.getmloancycle()) &&
            Objects.equals(getmloantype(), this.getmloantype()) &&
            Objects.equals(getmeffdate(), this.getmeffdate());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmlbrcode(),getmprdcd(),getmloancycle(),getmloantype(),getmeffdate());
	}


	

}
