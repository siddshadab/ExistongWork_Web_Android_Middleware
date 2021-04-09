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
@Table(name = "md010057", indexes = { @Index(columnList = "mrefno", name = "md010057ALTKey1")})
@Data
public class CustomerHouseholdExpenseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

	 @Id
	 @GeneratedValue(strategy=GenerationType.IDENTITY)
	 @Column(name = "mhoushldexpenrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int mhoushldexpenrefno;
	 @Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8) default 0")               
	 private int trefno = 0;	
	 @Column(name = "mhoushldexpntype",  columnDefinition = "NVarChar(4) default ''")
	 private String mhoushldexpntype = "";
	 @Column(name = "mhoushldevaluationamt" , nullable = true) 
	 private Double mhoushldevaluationamt = 0d;
	 @Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	 private int mcustno = 0;
	 @Column(name = "msrno",  columnDefinition = "numeric(4) default 0")
	 private int msrno = 0;
	
	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumns({
		  @JoinColumn(name = "mrefno"),		  
		})
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
	private CustomerEntity  householdExpenseCustomerEntity;
	
}
