package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.IndexColumn;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "cgt1master")
@Data
public class CGT1Entity extends BaseEntity {
	
	 @Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	 private int trefno;
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)" )
	 private int mrefno;
	 @Column(name = "loantrefno")
	 private int loantrefno;
	 @Column(name = "loanmrefno")
	 private  int loanmrefno;
	 @Column(name = "mleadsid",  columnDefinition = "NVarChar(16)")
	 private String mleadsid;
	 @Column(name = "mcgt1doneby",  columnDefinition = "NVarChar(8)")
	 private String mcgt1doneby;
	 @Column(name = "mstarttime")
	 private LocalDateTime mstarttime;
	 @Column(name = "mendtime")
	 private LocalDateTime mendtime;
	 @Column(name = "mroutefrom",  columnDefinition = "NVarChar(8)")
	 private String mroutefrom;
	 @Column(name = "mrouteto",  columnDefinition = "NVarChar(8)")
	 private String mrouteto;
	 @Column(name = "mremark",  columnDefinition = "NVarChar(60)")
	 private String mremark;
	 
	 
	 @OneToMany(mappedBy = "checkListCgt1Entity", cascade = CascadeType.ALL,fetch=FetchType.EAGER)
     @Fetch(FetchMode.SELECT)
     @IndexColumn(name="INDEX_COL")
 	 /*@JsonIgnore
 	 @LazyCollection(LazyCollectionOption.FALSE)*/
 	 private List<CheckListCGT1Entity> checkListCgt1Details = new ArrayList<CheckListCGT1Entity>();
	
	/* @EmbeddedId private CGTCompositePrimaryEntity compositeCGT1Id; */
	  
}
