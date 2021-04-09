package com.infrasofttech.microfinance.entityBeans.master;


import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md010056", indexes = { @Index(columnList = "mrefno", name = "md010056AltKey1")})
@Data
public class CustomerFamilyDetailsEntity implements Serializable {

    private static final long serialVersionUID = 1L;


	 @Id
	 @GeneratedValue(strategy=GenerationType.IDENTITY)
	 @Column(name = "mfamilyrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int mfamilyrefno;
	 @Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8) default 0")               
	 private int trefno = 0;	
	 @Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	 private int mcustno = 0;
	 @Column(name = "mname",  columnDefinition = "NVarChar(50) default ''")
	 private String mname = "";
	 @Column(name = "mnicno",  columnDefinition = "NVarChar(25) default ''")
	 private String mnicno = "";
	 @Column(name = "mdob")   	 
	 private LocalDateTime mdob;
	 @Column(name = "mage",  columnDefinition = "numeric(4) default 0")
	 private int mage = 0;
	 @Column(name = "meducation",  columnDefinition = "NVarChar(15) default ''")
	 private String meducation = "";
	 @Column(name = "mmemberno",  columnDefinition = "NVarChar(30) default ''")
	 private String mmemberno = "";
	 @Column(name = "moccuptype",  columnDefinition = "numeric(4) default 0")
	 private int moccuptype = 0;
	 @Column(name = "mincome" , nullable = true) 
	 private Double mincome = 0d;
	 @Column(name = "mhealthstatus",  columnDefinition = "numeric(4) default 0")
	 private int mhealthstatus = 0;
	 @Column(name = "mrelationwithcust",  columnDefinition = "NVarChar(3) default ''")   	 
	 private String mrelationwithcust = "";
	 @Column(name = "maritalstatus", columnDefinition = "numeric(4) default 0")
	 private int maritalstatus = 0;
	 @Column(name = "mcontrforhouseexp")
	 private Double mcontrforhouseexp = 0d;
	 @Column(name = "macidntlinsurance",  columnDefinition = "NVarChar(1) default ''")
	 private String macidntlinsurance = "";
	 @Column(name = "mnomineeyn",  columnDefinition = "NVarChar(1) default ''")
	 private String mnomineeyn = "";
	
	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumns({
		  @JoinColumn(name = "mrefno"),		  
		})	
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
	private CustomerEntity  familyDetailsCustomerEntity;
	
/*	@ManyToOne 
	@JsonIgnore
	@JoinColumn(name="customerNo" )
	private CustomerEntity  customerEntity;
*/


}
