package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
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

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Entity
@Table(name = "md010058", indexes = { @Index(columnList = "mrefno", name = "md010058ALtKey1")})
@Data
public class CustomerBorrowingDetailsEntity implements Serializable {

    private static final long serialVersionUID = 1L;

	
     
     
     @Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	 private int trefno = 0;
	 @Id
	 @GeneratedValue(strategy=GenerationType.IDENTITY)
	 @Column(name = "mborrowingrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int mborrowingrefno;
	 @Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	 private int mcustno = 0;
	 @Column(name = "msrno",  columnDefinition = "numeric(6) default 0")
	 private int  msrno = 0;
	 @Column(name = "mnameofborrower",  columnDefinition = "NVarChar(50) default ''")
	 private String mnameofborrower = "";	
	 @Column(name = "msource",  columnDefinition = "NVarChar(50) default ''")
	 private String msource = "";	 
	 @Column(name = "mpurpose",  columnDefinition = "NVarChar(50) default ''" )
	 private String mpurpose = "";
	 @Column(name = "mamount" , nullable = true)
	 private Double mamount = 0d;
	  @Column(name = "mintrate" , nullable = true)
	 private Double mintrate = 0d;
	 @Column(name = "memiamt" , nullable = true)
	 private Double memiamt = 0d;	
	 @Column(name = "moutstandingamt")
	 private Double moutstandingamt;	 
	 @Column(name = "mmemberno",  columnDefinition = "NVarChar(30) default ''")
	 private String mmemberno = "";
	 @Column(name = "mloancycle",  columnDefinition = "numeric(4) default 0" ) 
	 private int mloancycle = 0;
     
     

     
 	@ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
 	@JoinColumns({
 		  @JoinColumn(name = "mrefno"),		
 		})	
 	
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
	private CustomerEntity  borrowingDetailsCustomerEntity;
	
}
