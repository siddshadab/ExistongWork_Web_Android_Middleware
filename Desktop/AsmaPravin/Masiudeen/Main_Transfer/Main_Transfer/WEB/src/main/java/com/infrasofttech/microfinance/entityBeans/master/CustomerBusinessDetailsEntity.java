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

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;


@Entity
@Table(name = "md010160" , indexes = { @Index(columnList = "mrefno", name = "md010160AltKey1")})
@Data
public class CustomerBusinessDetailsEntity implements Serializable {

    private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mbussdetailsrefno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mbussdetailsrefno;
	@Column(name = "trefno",  nullable = false, columnDefinition = "numeric(8) default 0")               
	private int trefno = 0;	
	@Column(name = "mcusactivitytype",  columnDefinition = "numeric(8) default 0")
	private int mcusactivitytype = 0;
	@Column(name = "mbusinessname",  columnDefinition = "NVarChar(50) default ''")
	private String mbusinessname = "";
	@Column(name = "mbusaddress1",  columnDefinition = "NVarChar(50) default ''")
	private String mbusaddress1 = "";
	@Column(name = "mbusaddress2",  columnDefinition = "NVarChar(50) default ''")
	private String mbusaddress2 = "";
	@Column(name = "mbusaddress3",  columnDefinition = "NVarChar(50) default ''")
	private String mbusaddress3 = "";
	@Column(name = "mbusaddress4",  columnDefinition = "NVarChar(50) default ''")
	private String mbusaddress4 = "";
	@Column(name = "mbuscity",  columnDefinition = "NVarChar(6) default ''")
	private String mbuscity = "";
	@Column(name = "mdistcd",  columnDefinition = "numeric(6) default 0")
	private int mdistcd = 0;
	@Column(name = "mbusstate",  columnDefinition = "NVarChar(3) default ''")
	private String mbusstate = "";
	@Column(name = "mbuscountry",  columnDefinition = "NVarChar(3) default ''")
	private String mbuscountry = "";
	@Column(name = "mbusarea",  columnDefinition = "numeric(11) default 0")
	private int mbusarea = 0;	
	@Column(name = "mbusvillage",  columnDefinition = "numeric(6) default 0")
	private int mbusvillage = 0;
	@Column(name = "mbuslandmark",  columnDefinition = "NVarChar(80) default ''")   	 
	private String mbuslandmark = "";	
	@Column(name = "mbuspin", columnDefinition = "numeric(8) default 0")
	private int mbuspin = 0;
	@Column(name = "mbusyrsmnths", columnDefinition = "numeric(8) default 0")
	private int mbusyrsmnths = 0;	 
	@Column(name = "mregisteredyn",  columnDefinition = "NVarChar(1) default ''")   	 
	private String mregisteredyn = "";
	@Column(name = "mregistrationno",  columnDefinition = "NVarChar(25) default ''")   	 
	private String mregistrationno = "";
	@Column(name = "mbusothtomanageabsyn",  columnDefinition = "NVarChar(1) default ''")   	 
	private String mbusothtomanageabsyn = "";
	@Column(name = "mbusothmanagername",  columnDefinition = "NVarChar(30) default ''")   	 
	private String mbusothmanagername = "";
	@Column(name = "mbusothmanagerrel", columnDefinition = "numeric(8) default 0")
	private int mbusothmanagerrel = 0;	 
	@Column(name = "mbusmonthlyincome")
	private Double mbusmonthlyincome = 0d;
	@Column(name = "mbusseasonalityjan",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalityjan = "";
	@Column(name = "mbusseasonalityfeb",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalityfeb = "";
	@Column(name = "mbusseasonalitymar",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalitymar = "";
	@Column(name = "mbusseasonalityapr",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalityapr = "";
	@Column(name = "mbusseasonalitymay",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalitymay = "";
	@Column(name = "mbusseasonalityjun",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalityjun = "";
	@Column(name = "mbusseasonalityjul",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalityjul = "";
	@Column(name = "mbusseasonalityaug",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalityaug = "";
	@Column(name = "mbusseasonalitysep",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalitysep = "";
	@Column(name = "mbusseasonalityoct",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalityoct = "";
	@Column(name = "mbusseasonalitynov",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalitynov = "";
	@Column(name = "mbusseasonalitydec",  columnDefinition = "NVarChar(1) default ''")
	private String mbusseasonalitydec = "";
	@Column(name = "mbushighsales")
	private Double mbushighsales = 0d;
	@Column(name = "mbusmediumsales")
	private Double mbusmediumsales = 0d;
	@Column(name = "mbuslowsales")
	private Double mbuslowsales = 0d;
	@Column(name = "mbushighincome")
	private Double mbushighincome = 0d;
	@Column(name = "mbusmediumincom")
	private Double mbusmediumincom = 0d;
	@Column(name = "mbuslowincome")
	private Double mbuslowincome = 0d;
	@Column(name = "mbusmonthlytotalEval")
	private Double mbusmonthlytotalEval = 0d;
	@Column(name = "mbusmonthlytotalVerif")
	private Double mbusmonthlytotalVerif = 0d;
	@Column(name = "mbusincludesurcalcyn",  columnDefinition = "NVarChar(1) default ''")
	private String mbusincludesurcalcyn = "";
	@Column(name = "mbusnhousesameplaceyn",  columnDefinition = "NVarChar(1) default ''")
	private String mbusnhousesameplaceyn = "";
	@Column(name = "mbusinesstrend",  columnDefinition = "NVarChar(1) default ''")
	private String mbusinesstrend = "";	
	@Column(name = "mmonthlyincome")
	private Double mmonthlyincome = 0d;
	@Column(name = "mtotalmonthlyincome")
	private Double mtotalmonthlyincome = 0d;
	@Column(name = "mbusinessexpense")
	private Double mbusinessexpense = 0d;
	@Column(name = "mhousehldexpense")
	private Double mhousehldexpense = 0d;
	@Column(name = "mmonthlyemi")
	private Double mmonthlyemi = 0d;
	@Column(name = "mincomeemiratio")
	private Double mincomeemiratio = 0d;
	@Column(name = "mnetamount")
	private Double mnetamount = 0d;
	@Column(name = "mpercentage")
	private Double mpercentage = 0d;
	@Column(name = "mcustno",  columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;
	@Column(name = "mbuslocownership",  columnDefinition = "numeric(8) default 0")
	private int mbuslocownership = 0;
	

	@OneToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinColumns({
		  @JoinColumn(name = "mrefno"),		  
		})
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
	private CustomerEntity  customerBussDetailsCustomerEntity;
	

}
