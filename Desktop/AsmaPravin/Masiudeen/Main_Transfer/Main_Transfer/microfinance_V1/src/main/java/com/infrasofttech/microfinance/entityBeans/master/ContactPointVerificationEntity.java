package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;


@Entity
@Table(name = "ContactPointVerificationEntity" , indexes = { @Index(columnList = "mrefno", name = "contactPointVerificationEntityAltKey1")})
@Data
public class ContactPointVerificationEntity implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mcpvrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mcpvrefno;
	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8) default 0")               
	private int trefno = 0;	
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;
	@Column(name = "maddmatch",  columnDefinition = "NVarChar(50) default ''")
	private String maddmatch = "";
	/*@Column(name = "massetvissibledesc",  columnDefinition = "NVarChar(250) default ''")
	private String massetvissibledesc = "";*/
	@Column(name = "massetvissiblecode",  columnDefinition = "NVarChar(200) default ''")
	private String massetvissiblecode = "";
	@Column(name = "mhouseprptystatus",  columnDefinition = "NVarChar(50) default ''")
	private String mhouseprptystatus = "";
	@Column(name = "mhousestructure",  columnDefinition = "NVarChar(12) default ''")
	private String mhousestructure = "";	
	@Column(name = "mhousewall",  columnDefinition = "NVarChar(12) default ''")
	private String mhousewall = "";
	@Column(name = "mhouseroof",  columnDefinition = "NVarChar(12) default ''")
	private String mhouseroof = "";	

	@Column(name = "myrsmovdin",  columnDefinition = "NVarChar(12) default ''")
	private String myrsmovdin = "";	
	
	@OneToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumns({
		  @JoinColumn(name = "mrefno"),		  
		})
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
	private CustomerEntity  contactPointVerificationEntity;

	@Override
	public String toString() {
		return "ContactPointVerificationEntity [mcpvrefno=" + mcpvrefno + ", trefno=" + trefno + ", maddmatch="
				+ maddmatch + ", massetvissiblecode="
				+ massetvissiblecode + ", mhouseprptystatus=" + mhouseprptystatus + ", mhousestructure="
				+ mhousestructure + ", mhousewall=" + mhousewall + ", mhouseroof=" + mhouseroof + ", myrsmovdin="
				+ myrsmovdin + ", contactPointVerificationEntity=" + contactPointVerificationEntity + "]";
	}
	

}
