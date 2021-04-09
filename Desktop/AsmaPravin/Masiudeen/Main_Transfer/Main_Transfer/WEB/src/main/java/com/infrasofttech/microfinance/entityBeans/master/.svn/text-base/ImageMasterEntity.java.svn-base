package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;

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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "imageMasterEntity", indexes = { @Index(columnList = "mrefno", name = "imageMasterEntityAltKey1")})
@Data
public class ImageMasterEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mimgrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mimgrefno;
	@Column(name = "timgrefno", columnDefinition = "numeric(8) default 0")
	private int timgrefno = 0; 
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;  
	@Column
	private String imgType = "";
	@Column 
	@Lob
	private byte[] imgString;
	@Column 
	private String imgSubType = "";
	@Column 
	private String description = "";
	@Column 
	private String imageByteString = "";
	



	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.PERSIST)
	@JoinColumns({
		@JoinColumn(name = "mrefno"),		  
	})
	
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private CustomerEntity  imageMasterEntity;



}
