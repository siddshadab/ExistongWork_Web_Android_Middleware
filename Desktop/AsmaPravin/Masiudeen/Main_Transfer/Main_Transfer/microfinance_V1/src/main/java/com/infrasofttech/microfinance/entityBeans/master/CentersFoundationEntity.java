package com.infrasofttech.microfinance.entityBeans.master;

import javax.persistence.Column;
import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md001006" , indexes = {
		@Index(columnList = "trefno", name = "trefno_hidx"),
		/*
		 * @Index(columnList = "mcustno", name = "mcustno_hidx"),
		 */		@Index(columnList = "mcreatedby", name = "mcreatedby_hidx"),
		@Index(columnList = "mlastsynsdate", name = "mlastsynsdate_hidx"),
		@Index(columnList = "mcreateddt", name = "mcreateddt_hidx"),
		@Index(columnList = "mlastupdatedt", name = "mlastupdatedt_hidx")
})
@Data
public class CentersFoundationEntity  extends BaseEntity{
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefno;		
	@Column(name = "trefno",  columnDefinition = "numeric(8) default 0" )                            	
	private int trefno;                            		
	@Column(name = "mcenterid",  columnDefinition = "numeric(8)" )	
	private int mcenterid;		
	@Column(name = "meffectivedt")	
	private LocalDateTime meffectivedt;		
	@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )	
	private int mlbrcode;		
	@Column(name = "mcentername",  columnDefinition = "nvarchar(50)" )	
	private String mcentername;		
	@Column(name = "mcrs",  columnDefinition = "nvarchar(8)" )	
	private String mcrs;		
	@Column(name = "marea",  columnDefinition = "numeric(11)" )
	private int marea;		
	@Column(name = "mareatype",  columnDefinition = "numeric(4)" )	
	private int mareatype;		
	@Column(name = "mformatndt")	private LocalDateTime mformatndt;		
	@Column(name = "mmeetingfreq",  columnDefinition = "nvarchar(1)" )	
	private String mmeetingfreq;		
	@Column(name = "mmeetinglocn",  columnDefinition = "nvarchar(30)" )	
	private String mmeetinglocn;		
	@Column(name = "mmeetingday",  columnDefinition = "numeric(1)" )	
	private int mmeetingday;		
	@Column(name = "mcentermthhmm",  columnDefinition = "nvarchar(5)" )	
	private String mcentermthhmm;		
	@Column(name = "mcentermtampm",  columnDefinition = "numeric(1)" )	
	private int mcentermtampm;		
	@Column(name = "mfirstmeetngdt")
	private  LocalDateTime mfirstmeetngdt;		
	@Column(name = "mnextmeetngdt")	
	private LocalDateTime mnextmeetngdt;		
	@Column(name = "mlastmeetngdt" )	
	private LocalDateTime mlastmeetngdt;		
	@Column(name = "mrepayfrom",  columnDefinition = "numeric(2)" )	
	private int mrepayfrom;		
	@Column(name = "mrepayto",  columnDefinition = "numeric(2)" )	
	private int mrepayto;		
	@Column(name = "mcurrnoofmembers",  columnDefinition = "numeric(8)" )	
	private int mcurrnoofmembers;		
	@Column(name = "mcenterstatus",  columnDefinition = "numeric(1)" )	
	private int mcenterstatus;		
	@Column(name = "mdropoutdate")	
	private LocalDateTime mdropoutdate;		
	@Column(name = "mlastmonitoringdate")	
	private LocalDateTime mlastmonitoringdate;		
	@Column(name = "mcreateddt")	
	private LocalDateTime mcreateddt;		
	@Column(name = "mcreatedby",  columnDefinition = "nvarchar(8)" )	
	private String mcreatedby;		
	@Column(name = "mlastupdatedt")	
	private LocalDateTime mlastupdatedt;		
	@Column(name = "mlastupdateby",  columnDefinition = "nvarchar(8)" )	
	private String mlastupdateby;		
	@Column(name = "mgeolocation",  columnDefinition = "nvarchar(250)" )	
	private String mgeolocation;	 	
	@Column(name = "mgeolatd",  columnDefinition = "nvarchar(20)" )	
	private String mgeolatd;		
	@Column(name = "mgeologd",  columnDefinition = "nvarchar(20)" )
	private String mgeologd;		
	@Column(name = "missync",  columnDefinition = "nvarchar(1)" )	
	private String missync;		
	@Column(name = "mlastsynsdate")	
	private LocalDateTime mlastsynsdate;
	@Column(name = "merrormessage",  columnDefinition = "nvarchar(250) default ''" )
	private String merrormessage ="";	
	@Override
	public String toString() {
		return "CentersFoundationEntity [mrefno=" + mrefno + ", trefno=" + trefno + ", mcenterid=" + mcenterid
				+ ", meffectivedt=" + meffectivedt + ", mlbrcode=" + mlbrcode + ", mcentername=" + mcentername
				+ ", mcrs=" + mcrs + ", marea=" + marea + ", mareatype=" + mareatype + ", mformatndt=" + mformatndt
				+ ", mmeetingfreq=" + mmeetingfreq + ", mmeetinglocn=" + mmeetinglocn + ", mmeetingday=" + mmeetingday
				+ ", mcentermthhmm=" + mcentermthhmm + ", mcentermtampm=" + mcentermtampm + ", mfirstmeetngdt="
				+ mfirstmeetngdt + ", mnextmeetngdt=" + mnextmeetngdt + ", mlastmeetngdt=" + mlastmeetngdt
				+ ", mrepayfrom=" + mrepayfrom + ", mrepayto=" + mrepayto + ", mcurrnoofmembers=" + mcurrnoofmembers
				+ ", mcenterstatus=" + mcenterstatus + ", mdropoutdate=" + mdropoutdate + ", mlastmonitoringdate="
				+ mlastmonitoringdate + ", mcreateddt=" + mcreateddt + ", mcreatedby=" + mcreatedby + ", mlastupdatedt="
				+ mlastupdatedt + ", mlastupdateby=" + mlastupdateby + ", mgeolocation=" + mgeolocation + ", mgeolatd="
				+ mgeolatd + ", mgeologd=" + mgeologd + ", missync=" + missync + ", mlastsynsdate=" + mlastsynsdate
				+ "]";
	}		

	
	
	
}
