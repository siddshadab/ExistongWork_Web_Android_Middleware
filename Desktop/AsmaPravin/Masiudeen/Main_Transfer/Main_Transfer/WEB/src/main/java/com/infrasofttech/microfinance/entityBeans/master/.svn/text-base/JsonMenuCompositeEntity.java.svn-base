package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;

import javax.persistence.Column;

public class JsonMenuCompositeEntity implements Serializable {

	@Column(name = "musrcode",  columnDefinition = "nvarchar(30) default '' " )	
	private String musrcode;
	
	@Column(name = "mgrpcd",  columnDefinition = "numeric(8) default 0" )	
	private int mgrpcd;

	public String getMusrcode() {
		return musrcode;
	}

	public void setMusrcode(String musrcode) {
		this.musrcode = musrcode;
	}

	public int getMgrpcd() {
		return mgrpcd;
	}

	public void setMgrpcd(int mgrpcd) {
		this.mgrpcd = mgrpcd;
	}

	@Override
	public String toString() {
		return "JsonMenuCompositeEntity [musrcode=" + musrcode + ", mgrpcd=" + mgrpcd + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + mgrpcd;
		result = prime * result + ((musrcode == null) ? 0 : musrcode.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		
		if (obj == null)
			return false;
		
		if (getClass() != obj.getClass())
			return false;
		
		JsonMenuCompositeEntity other = (JsonMenuCompositeEntity) obj;
		
		if (mgrpcd != other.mgrpcd)
			return false;
		
		if (musrcode == null) {
			if (other.musrcode != null)
				return false;			
		} 
		else if (!musrcode.equals(other.musrcode))
			return false;
		return true;
	}
	
	
	
	
}
