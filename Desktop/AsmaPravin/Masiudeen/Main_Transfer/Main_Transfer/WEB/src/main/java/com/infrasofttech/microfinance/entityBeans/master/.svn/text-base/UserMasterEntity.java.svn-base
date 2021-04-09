package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md002001",indexes = { @Index(columnList = "musrcode", name = "musrcode_hidx"),	
	})
@Data
public class UserMasterEntity extends BaseEntity {

	@Id
	@Column(name = "musrcode", unique = true, nullable = false, columnDefinition = "nvarchar(8)")
	private String musrcode;
	@Column(name = "mcustaccesslvl", columnDefinition = "numeric(2)")
	private int mcustaccesslvl;
	@Column(name = "mextnno", columnDefinition = "numeric(8)")
	private int mextnno;
	@Column(name = "mactiveinstn", columnDefinition = "nvarchar(12)")
	private String mactiveinstn;
	@Column(name = "mautologoutperiod", columnDefinition = "numeric(6)")
	private int mautologoutperiod;
	@Column(name = "mautologoutyn", columnDefinition = "nvarchar(1)")
	private String mautologoutyn;
	@Column(name = "mbadloginsdt")
	private LocalDateTime mbadloginsdt;
	@Column(name = "memailid", columnDefinition = "nvarchar(40)")
	private String memailid;
	@Column(name = "merror", columnDefinition = "numeric(2)")
	private int merror;
	@Column(name = "merrormessage", columnDefinition = "nvarchar(100)")
	private String merrormessage;
	@Column(name = "mgrpcd", columnDefinition = "numeric(4)")
	private int mgrpcd;
	@Column(name = "misloggedinyn", columnDefinition = "numeric(2)")
	private int misloggedinyn;
	@Column(name = "mlastpwdchgdt ")
	private LocalDateTime mlastpwdchgdt;
	@Column(name = "mlastsyslidt")
	private LocalDateTime mlastsyslidt;
	@Column(name = "mmaxbadlginperday", columnDefinition = "numeric(8)")
	private int mmaxbadlginperday;
	@Column(name = "mmaxbadlginperinst", columnDefinition = "numeric(8)")
	private int mmaxbadlginperinst;
	@Column(name = "mmobile", columnDefinition = "nvarchar(15)")
	private String mmobile;
	@Column(name = "mnextpwdchgdt")
	private LocalDateTime mnextpwdchgdt;
	@Column(name = "mnextsyslgindt")
	private LocalDateTime mnextsyslgindt;
	@Column(name = "mnoofbadlogins", columnDefinition = "numeric(4)")
	private int mnoofbadlogins;
	@Column(name = "mpwdchgforcedyn", columnDefinition = "nvarchar(1)")
	private String mpwdchgforcedyn;
	@Column(name = "mpwdchgperioddays", columnDefinition = "numeric(8)")
	private int mpwdchgperioddays;
	@Column(name = "mregdevicemacid", columnDefinition = "nvarchar(100)")
	private String mregdevicemacid;
	@Column(name = "mreportinguser", columnDefinition = "nvarchar(8)")
	private String mreportinguser;
	@Column(name = "mstatus", columnDefinition = "numeric(4)")
	private int mstatus;
	@Column(name = "musrbrcode", columnDefinition = "numeric(8)")
	private int musrbrcode;
	@Column(name = "musrdesignation", columnDefinition = "nvarchar(8)")
	private String musrdesignation;
	@Column(name = "musrname", columnDefinition = "nvarchar(40)")
	private String musrname;
	@Column(name = "musrpass", columnDefinition = "nvarchar(30)")
	private String musrpass;
	@Column(name = "musrshortname", columnDefinition = "nvarchar(30)")
	private String musrshortname;
	@Column(name = "mreason", columnDefinition = "nvarchar(50)")
	private String mreason;
	@Column(name = "msusdate")
	private LocalDateTime msusdate;
	@Column(name = "mjoindate")
	private LocalDateTime mjoindate;
	@Column(name = "mgender", columnDefinition = "nvarchar(1)")
	private String mgender;
	@Column(name = "moldpass1", columnDefinition = "nvarchar(30)")
	private String moldpass1;

	/*
	 * @Column(name = "mcreateddt") private LocalDateTime mcreateddt;
	 * 
	 * @Column(name = "mcreatedby", columnDefinition = "nvarchar(8)" ) private
	 * String mcreatedby;
	 * 
	 * @Column(name = "mlastupdatedt") private LocalDateTime mlastupdatedt;
	 * 
	 * @Column(name = "mlastupdateby", columnDefinition = "nvarchar(8)" ) private
	 * String mlastupdateby;
	 * 
	 * @Column(name = "mgeolocation", columnDefinition = "nvarchar(250)" ) private
	 * String mgeolocation;
	 * 
	 * @Column(name = "mgeolatd", columnDefinition = "nvarchar(20)" ) private String
	 * mgeolatd;
	 * 
	 * @Column(name = "mgeologd", columnDefinition = "nvarchar(20)" ) private String
	 * mgeologd;
	 * 
	 * @Column(name = "mlastsynsdate") private LocalDateTime mlastsynsdate;
	 */

}
