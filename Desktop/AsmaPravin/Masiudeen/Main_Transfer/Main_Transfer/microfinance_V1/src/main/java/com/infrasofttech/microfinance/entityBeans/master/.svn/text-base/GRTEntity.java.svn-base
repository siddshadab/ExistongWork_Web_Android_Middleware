package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
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
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "grtmaster")
@Data
public class GRTEntity extends BaseEntity {
	
	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8)")               
	 private int trefno;
	 @Id
	 @GeneratedValue(strategy = GenerationType.IDENTITY)
	 @Column(name = "mrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	 private int mrefno;
	 @Column(name = "loantrefno")
	 private int loantrefno;
	 @Column(name = "loanmrefno")
	 private  int loanmrefno;
	 @Column(name = "mleadsid",  columnDefinition = "NVarChar(16)")
	 private String mleadsid;
	 @Column(name = "mgrtdoneby",  columnDefinition = "NVarChar(8)")
	 private String mgrtdoneby;
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
	 @Column(name = "midtype1status",  columnDefinition = "NVarChar(8)")
	 private String midtype1status;
	 @Column(name = "midtype2status",  columnDefinition = "NVarChar(8)")
	 private String midtype2status;
	 @Column(name = "midtype3status",  columnDefinition = "NVarChar(60)")
	 private String midtype3status;
	 @Lob
	 private byte[] mhouseVerifiImg;
	 
	 @OneToMany(mappedBy = "checkListGrtEntity", cascade = CascadeType.ALL,fetch=FetchType.EAGER)
     @Fetch(FetchMode.SELECT)
     @IndexColumn(name="INDEX_COL")
 	 /*@JsonIgnore
 	 @LazyCollection(LazyCollectionOption.FALSE)*/
 	 private Collection<CheckListGRTEntity> checkListGrtDetails = new ArrayList<CheckListGRTEntity>();
	
	/* @EmbeddedId private CGTCompositePrimaryEntity compositeCGT3Id; */
	  	 
}
