package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class TDOffsetInterestSlabCompositeEntity   implements Serializable{
	

	
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8) default 0" )	
	private int mlbrcode;	
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(30)" )	
	private String mprdcd;		
	@Column(name = "maccttype",  columnDefinition = "numeric(8) default 0" )	
	private int maccttype;	
	@Column(name = "meffdate" )	
	private LocalDateTime meffdate;
	@Column(name = "msrno",  columnDefinition = "numeric(8) default 0" )	
	private int msrno;	
	

	public TDOffsetInterestSlabCompositeEntity() {

	}


	public TDOffsetInterestSlabCompositeEntity(int mlbrcode, String mprdcd, int maccttype,LocalDateTime meffdate,int msrno ) {
		this.mlbrcode=mlbrcode;
		this.mprdcd=mprdcd;
		this.maccttype = maccttype;
		this.meffdate=meffdate;
		this.msrno = msrno;
	}
	
	
	public int getmlbrcode() {
		return mlbrcode;
	}


	public void setmlbrcode(int mlbrcode) {
		this.mlbrcode = mlbrcode;
	}

	
	public String getmprdcd() {
		return mprdcd;
	}


	public void setmprdcd(String prdcd) {
		this.mprdcd = prdcd;
	}


	public int getmaccttype() {
		return maccttype;
	}


	public void setmaccttype(int maccttype) {
		this.maccttype = maccttype;
	}
	
	public LocalDateTime getmeffdate() {
		return meffdate;
	}


	public void setmeffdate(LocalDateTime meffdate) {
		this.meffdate = meffdate;
	}
	
	public int getmsrno() {
		return msrno;
	}


	public void setmsrno(int msrno) {
		this.msrno = msrno;
	}
	
	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof TDOffsetInterestSlabCompositeEntity)){
		return false;
	}
	
	return Objects.equals(getmprdcd(), this.getmprdcd()) &&
            Objects.equals(getmlbrcode(), this.getmlbrcode()) &&
            Objects.equals(getmaccttype(), this.getmaccttype()) &&
            Objects.equals(getmsrno(), this.getmsrno()) &&
            Objects.equals(getmeffdate(),this.getmeffdate());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmprdcd(),getmlbrcode(),getmaccttype(),getmeffdate(),getmsrno());
	}


	

}
