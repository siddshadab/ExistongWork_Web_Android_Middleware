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
@Table(name = "Customerppidetailsmaster", indexes = { @Index(columnList = "mrefno", name = "CustomerppidetailsmasterAltKey1")})
@Data
public class CustomerPPIDetailsEntity implements Serializable {

	private static final long serialVersionUID = 1L;



	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mppirefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mppirefno;
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;	 
	@Column(name = "mitem",  columnDefinition = "NVarChar(4) default ''")
	private String mitem = "";
	@Column(name = "mhaveyn",  columnDefinition = "NVarChar(4) default ''")
	private String mhaveyn = "";	
	@Column(name = "mnoofitems",  columnDefinition = "numeric default 0")
	private int mnoofitems = 0;
	 @Column(name = "mweightage" , nullable = true)
	private double mweightage = 0d;


	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumns({
		@JoinColumn(name = "mrefno"),		  
	})	
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private CustomerEntity ppiDetailsCustomerEntity;

	/*	@ManyToOne 
	@JsonIgnore
	@JoinColumn(name="customerNo" )
	private CustomerEntity  customerEntity;
	 */


}
