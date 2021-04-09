package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Id;

public class LoanCycleParameterSecondaryCompositeEntity   implements Serializable{
	

	
	
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )      	
	private int mlbrcode;   	
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(8)" )     	
	private String mprdcd;  	
	@Column(name = "mloancycle",  columnDefinition = "numeric(4)" )    	
	private int mloancycle; 	
	@Column(name = "mcusttype",  columnDefinition = "numeric(6)" )     	
	private int mcusttype;  	
	@Column(name = "mgrtype",  columnDefinition = "numeric(6)" )   	
	private int mgrtype;	
	@Column(name = "meffdate")    
	private LocalDateTime meffdate; 	
	@Column(name = "mfrequency",  columnDefinition = "nvarchar(1)" )   	
	private String mfrequency;	
	@Column(name = "mruletype",  columnDefinition = "numeric(1)" )   	
	private int mruletype;	
	@Column(name = "msrno",  columnDefinition = "numeric(8)" )            	
	private int msrno;	

	public LoanCycleParameterSecondaryCompositeEntity() {

	}


	public LoanCycleParameterSecondaryCompositeEntity(int lbrcode, String prdcd,int loancycle,int custtype,int grtype,LocalDateTime effdate,String frequency ,int ruletype,int srno) {
		this.mlbrcode=lbrcode;
		this.mprdcd=prdcd;
		this.mloancycle=loancycle;
		this.mcusttype=custtype;
		this.mgrtype=grtype;
		this.meffdate=effdate;
		this.mfrequency=frequency;
		this.mruletype=ruletype;
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
	public int getmcusttype() {
		return mcusttype;
	}


	public void setmcusttype(int custtype) {
		this.mcusttype = custtype;
	}
	public int getmgrtype() {
		return mgrtype;
	}


	public void setmgrtype(int grtype) {
		this.mgrtype = grtype;
	}
	

	public LocalDateTime getmeffdate() {
		return meffdate;
	}


	public void setmeffdate(LocalDateTime effdate) {
		this.meffdate = effdate;
	}
	public String getmfrequency() {
		return mfrequency;
	}


	public void setmfrequency(String frequency) {
		this.mfrequency = frequency;
	}
	public int getmruletype() {
		return mruletype;
	}


	public void setmruletype(int ruletype) {
		this.mruletype = ruletype;
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
	if(! (obj instanceof LoanCycleParameterSecondaryCompositeEntity)){
		return false;
	}
	
	return Objects.equals(getmlbrcode(), this.getmlbrcode()) &&
            Objects.equals(getmprdcd(), this.getmprdcd()) &&
            Objects.equals(getmloancycle(), this.getmloancycle()) &&
            Objects.equals(getmcusttype(), this.getmcusttype()) &&
            Objects.equals(getmgrtype(), this.getmgrtype()) &&
            Objects.equals(getmeffdate(), this.getmeffdate()) &&
                    Objects.equals(getmfrequency(), this.getmfrequency()) &&
                    Objects.equals(getmruletype(), this.getmruletype()) &&
                    Objects.equals(getmsrno(), this.getmsrno()
);

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmlbrcode(),getmprdcd(),getmloancycle(),getmcusttype(),getmgrtype(),getmeffdate(),getmfrequency(),getmruletype(),getmsrno());
	}


	

}
