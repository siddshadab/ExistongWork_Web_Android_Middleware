package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;

public class UserAccressRightsCompositeEntity implements Serializable{
	

	
	
	@Column(name = "mgrpcd", nullable = false,  columnDefinition = "numeric(8)")
	private int mgrpcd;   	 	

	@Column(name = "musrcode",  nullable = false, columnDefinition = "nvarchar(8)")               
	private String musrcode;   
	
	@Column(name = "menuid", nullable = false,  columnDefinition = "numeric(8)")
	private int menuid;   	 	

	
	public int getMgrpcd() {
		return mgrpcd;
	}


	public void setMgrpcd(int mgrpcd) {
		this.mgrpcd = mgrpcd;
	}


	public String getusrcode() {
		return musrcode;
	}


	public void setMusrcode(String musrcode) {
		this.musrcode = musrcode;
	}

	
	public int getMenuid() {
		return menuid;
	}


	public void setMenuid(int menuid) {
		this.menuid = menuid;
	}

	public UserAccressRightsCompositeEntity() {

	}


	public UserAccressRightsCompositeEntity(int mgrpcd, String musrcode,int menuid) {
		this.mgrpcd=mgrpcd;
		this.musrcode = musrcode;
		this.menuid = menuid;
	}
	
	

	
	@Override
	public boolean equals(Object obj) {

	if(this==obj) {
		return true;
	}
	if(! (obj instanceof UserAccressRightsCompositeEntity)){
		return false;
	}
	
	return Objects.equals(getMgrpcd(), this.getMgrpcd()) &&
            Objects.equals(getusrcode(), this.getusrcode()) &&
                    Objects.equals(getMenuid(), this.getMenuid());

	}
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return Objects.hash(getMgrpcd(),getusrcode(),getMenuid());
	}


	

}
