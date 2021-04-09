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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;


@Entity
@Table(name = "md010157", indexes = { @Index(columnList = "mrefno", name = "md010157ALtKey1")})
@Data
public class CustomerAssetDetailsEntity implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "massetdetrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int massetdetrefno;
	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8) default 0")               
	private int trefno = 0;	
	@Column(name = "mitem",  columnDefinition = "numeric(4) default 0")
	private int mitem = 0;	
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;
	@Column(name = "mnoofitems",  columnDefinition = "numeric(4) default 0")
	private int mnoofitems = 0;
	@Column(name = "mamount" , nullable = true) 
	private Double mamount = 0d;
	

	@OneToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumns({
		  @JoinColumn(name = "mrefno"),		  
		})
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
	private CustomerEntity  assetCustomerEntity;
	

}
