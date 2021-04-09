package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.util.ArrayList;
import java.util.List;

public class MenuHolderBean {
	
	int menuid; 
	int	parentid; 	   
	int	mgrpcd;
	String menudesc  ;
	String menutype ;  
	String	murl;
	String	parenttype;   
	String	musrcode;  
	int	authoritye; 
	int	browsee;   
	int	createe;   
	int	deletee;  
	int	modifye;	
	
	//List<MenuHolderBean> menuHolder = new ArrayList<>();

	public int getMenuid() {
		return menuid;
	}

	public void setMenuid(int menuid) {
		this.menuid = menuid;
	}

	public int getParentid() {
		return parentid;
	}

	public void setParentid(int parentid) {
		this.parentid = parentid;
	}

	public int getMgrpcd() {
		return mgrpcd;
	}

	public void setMgrpcd(int mgrpcd) {
		this.mgrpcd = mgrpcd;
	}

	public String getMenudesc() {
		return menudesc;
	}

	public void setMenudesc(String menudesc) {
		this.menudesc = menudesc;
	}

	public String getMenutype() {
		return menutype;
	}

	public void setMenutype(String menutype) {
		this.menutype = menutype;
	}

	public String getMurl() {
		return murl;
	}

	public void setMurl(String murl) {
		this.murl = murl;
	}

	public String getParenttype() {
		return parenttype;
	}

	public void setParenttype(String parenttype) {
		this.parenttype = parenttype;
	}

	public String getMusrcode() {
		return musrcode;
	}

	public void setMusrcode(String musrcode) {
		this.musrcode = musrcode;
	}

	public int getAuthoritye() {
		return authoritye;
	}

	public void setAuthoritye(int authoritye) {
		this.authoritye = authoritye;
	}

	public int getBrowsee() {
		return browsee;
	}

	public void setBrowsee(int browsee) {
		this.browsee = browsee;
	}

	public int getCreatee() {
		return createe;
	}

	public void setCreatee(int createe) {
		this.createe = createe;
	}

	public int getDeletee() {
		return deletee;
	}

	public void setDeletee(int deletee) {
		this.deletee = deletee;
	}

	public int getModifye() {
		return modifye;
	}

	public void setModifye(int modifye) {
		this.modifye = modifye;
	}

//	public List<MenuHolderBean> getMenuHolder() {
//		return menuHolder;
//	}
//
//	public void setMenuHolder(List<MenuHolderBean> menuHolder) {
//		this.menuHolder = menuHolder;
//	}

	@Override
	public String toString() {
		return "MenuHolderBean [menuid=" + menuid + ", parentid=" + parentid + ", mgrpcd=" + mgrpcd + ", menudesc="
				+ menudesc + ", menutype=" + menutype + ", murl=" + murl + ", parenttype=" + parenttype + ", musrcode="
				+ musrcode + ", authoritye=" + authoritye + ", browsee=" + browsee + ", createe=" + createe
				+ ", deletee=" + deletee + ", modifye=" + modifye + "]";
	}
	
	

}
