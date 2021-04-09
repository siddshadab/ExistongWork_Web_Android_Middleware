package com.infrasofttech.microfinance.entityBeans.master;


import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;

public class UserVaultBalanceCompositetEntity   implements Serializable{



	@Column(name = "musercode",  columnDefinition = "nvarchar(8)")
	private String musercode;  		

	@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )        	
	private int mlbrcode; 

	@Column(name = "mcurcd",  columnDefinition = "nvarchar(3) default ''" )     	
	private String mcurcd = "";   

	public UserVaultBalanceCompositetEntity() {

	}


	public UserVaultBalanceCompositetEntity(int lbrcode, String musercode, String mcurcd ) {
		this.mlbrcode=lbrcode;
		this.musercode=musercode;		
		this.mcurcd=mcurcd;
	}


	public int getmlbrcode() {
		return mlbrcode;
	}


	public void setmlbrcode(int lbrcode) {
		this.mlbrcode = lbrcode;
	}


	public String getmusercode() {
		return musercode;
	}


	public void setmusercode(String musercode) {
		this.musercode = musercode;
	}


	public String getmcurcd() {
		return mcurcd;
	}


	public void setmcurcd(String mcurcd) {
		this.mcurcd = mcurcd;
	}




	@Override
	public boolean equals(Object obj) {

		if(this==obj) {
			return true;
		}
		if(! (obj instanceof UserVaultBalanceCompositetEntity)){
			return false;
		}

		return Objects.equals(getmlbrcode(), this.getmlbrcode()) &&            
				Objects.equals(getmusercode(), this.getmusercode())&&
				Objects.equals(getmcurcd(), this.getmcurcd()) ;

	}

	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getmlbrcode(),getmusercode(),getmcurcd());
	}




}
