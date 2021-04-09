package com.infrasofttech.microfinance.entityBeans.master.holder;

import java.time.LocalDateTime;

import javax.persistence.Entity;

import lombok.Data;

//@Data

public interface CustomerLocationHolder {
	
	public String getMcenterid();
	public String getMfname();
	public String getMmname();
	public String getMlname();
	public String getMgender() ;
	public String getMlongname();
	public int getMrefno();
	public int getMcustno();
	public LocalDateTime getMcreateddt();
	public String getMcreatedby() ;
	public LocalDateTime getMlastupdatedt() ;
	public String getMlastupdateby();
	public String getMgeolocation();
	public String getMgeolatd();
	public String getMgeologd();
	public LocalDateTime getMlastsynsdate();/*
	private String mfname = "";		
	private String mmname = "";	
	private String mlname = "";	
	private String mgender = "";	
	private String mlongname = "";
	private int mrefno;
	private int mcustno = 0;
	 private LocalDateTime mcreateddt;	 
	 private String mcreatedby;	 	 
	 private LocalDateTime mlastupdatedt;	 
	 private String mlastupdateby; 
	 private String mgeolocation;	 
	 private String mgeolatd;	 
	 private String mgeologd;	 		 
	 private LocalDateTime mlastsynsdate ;*/
	 
	/*public CustomerLocationHolder(String mfname, String mmname, String mlname, String mgender, String mlongname,
			int mrefno, int mcustno, LocalDateTime mcreateddt, String mcreatedby, LocalDateTime mlastupdatedt,
			String mlastupdateby, String mgeolocation, String mgeolatd, String mgeologd, LocalDateTime mlastsynsdate) {
		super();
		this.mfname = mfname;
		this.mmname = mmname;
		this.mlname = mlname;
		this.mgender = mgender;
		this.mlongname = mlongname;
		this.mrefno = mrefno;
		this.mcustno = mcustno;
		this.mcreateddt = mcreateddt;
		this.mcreatedby = mcreatedby;
		this.mlastupdatedt = mlastupdatedt;
		this.mlastupdateby = mlastupdateby;
		this.mgeolocation = mgeolocation;
		this.mgeolatd = mgeolatd;
		this.mgeologd = mgeologd;
		this.mlastsynsdate = mlastsynsdate;
	}
	public String getMfname() {
		return mfname;
	}
	public void setMfname(String mfname) {
		this.mfname = mfname;
	}
	public String getMmname() {
		return mmname;
	}
	public void setMmname(String mmname) {
		this.mmname = mmname;
	}
	public String getMlname() {
		return mlname;
	}
	public void setMlname(String mlname) {
		this.mlname = mlname;
	}
	public String getMgender() {
		return mgender;
	}
	public void setMgender(String mgender) {
		this.mgender = mgender;
	}
	public String getMlongname() {
		return mlongname;
	}
	public void setMlongname(String mlongname) {
		this.mlongname = mlongname;
	}
	public int getMrefno() {
		return mrefno;
	}
	public void setMrefno(int mrefno) {
		this.mrefno = mrefno;
	}
	public int getMcustno() {
		return mcustno;
	}
	public void setMcustno(int mcustno) {
		this.mcustno = mcustno;
	}
	public LocalDateTime getMcreateddt() {
		return mcreateddt;
	}
	public void setMcreateddt(LocalDateTime mcreateddt) {
		this.mcreateddt = mcreateddt;
	}
	public String getMcreatedby() {
		return mcreatedby;
	}
	public void setMcreatedby(String mcreatedby) {
		this.mcreatedby = mcreatedby;
	}
	public LocalDateTime getMlastupdatedt() {
		return mlastupdatedt;
	}
	public void setMlastupdatedt(LocalDateTime mlastupdatedt) {
		this.mlastupdatedt = mlastupdatedt;
	}
	public String getMlastupdateby() {
		return mlastupdateby;
	}
	public void setMlastupdateby(String mlastupdateby) {
		this.mlastupdateby = mlastupdateby;
	}
	public String getMgeolocation() {
		return mgeolocation;
	}
	public void setMgeolocation(String mgeolocation) {
		this.mgeolocation = mgeolocation;
	}
	public String getMgeolatd() {
		return mgeolatd;
	}
	public void setMgeolatd(String mgeolatd) {
		this.mgeolatd = mgeolatd;
	}
	public String getMgeologd() {
		return mgeologd;
	}
	public void setMgeologd(String mgeologd) {
		this.mgeologd = mgeologd;
	}
	public LocalDateTime getMlastsynsdate() {
		return mlastsynsdate;
	}
	public void setMlastsynsdate(LocalDateTime mlastsynsdate) {
		this.mlastsynsdate = mlastsynsdate;
	}*/

}


