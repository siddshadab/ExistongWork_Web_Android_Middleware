package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;

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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Entity
@Table(name = "customerfingerprintentity", indexes = { @Index(columnList = "mrefno", name = "indxfingr")})
@Data
public class CustomerFingerPrintEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mimagerefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mimagerefno;
	@Column(name = "timagerefno", columnDefinition = "numeric(8) default 0")
	private int timagerefno = 0; 
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;  
	
	
	@Column(name = "mimagetype",  columnDefinition = "NVarChar(12) default ''")
	private String mimagetype = "";
	
	@Column 
	@Lob
	private byte[] mimagestring;
	
	
	@Column(name = "mimagesubtype",  columnDefinition = "NVarChar(10) default ''")
	private String mimagesubtype = "";

	



	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.PERSIST)
	@JoinColumns({
		@JoinColumn(name = "mrefno"),		  
	})
	
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private CustomerEntity  customerFingerPrintEntity;



}
