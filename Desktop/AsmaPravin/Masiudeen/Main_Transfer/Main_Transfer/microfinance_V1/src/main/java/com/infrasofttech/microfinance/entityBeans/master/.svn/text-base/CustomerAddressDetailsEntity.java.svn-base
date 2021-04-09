
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
@Table(name = "md010054", indexes = { @Index(columnList = "mrefno", name = "md010054ALTKey1")})
@Data
public class CustomerAddressDetailsEntity implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8)")
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "maddressrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int maddressrefno;
	@Column(name = "mcustno", columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;
	@Column(name = "maddrtype", columnDefinition = "numeric(2) default 0")
	private int maddrtype = 0;
	@Column(name = "maddr1", columnDefinition = "NVarChar(50) default ''")
	private String maddr1 = "";
	@Column(name = "maddr2", columnDefinition = "NVarChar(50) default ''")
	private String maddr2 = "";
	@Column(name = "maddr3", columnDefinition = "NVarChar(50) default ''")
	private String maddr3 = "";
	@Column(name = "mpincd", columnDefinition = "numeric(8) default 0")
	private int mpincd = 0;
	@Column(name = "mtel1", columnDefinition = "NVarChar(15) default ''")
	private String mtel1 = "";
	@Column(name = "mtel2", columnDefinition = "NVarChar(15) default ''")
	private String mtel2 = "";
	@Column(name = "mcitycd", columnDefinition = "NVarChar(6) default ''")
	private String mcitycd = "";
	@Column(name = "mfax1", columnDefinition = "NVarChar(15) default ''")
	private String mfax1 = "";
	@Column(name = "mfax2", columnDefinition = "NVarChar(15) default ''")
	private String mfax2 = "";
	@Column(name = "mcountrycd", columnDefinition = "NVarChar(3) default ''")
	private String mcountrycd = "";
	@Column(name = "marea", columnDefinition = "numeric(11) default 0")
	private int marea = 0;
	@Column(name = "mhousetype", columnDefinition = "numeric(6) default 0")
	private int mhousetype = 0;
	@Column(name = "mrntleasamt", nullable = true)
	private Double mrntleasamt = 0d;;
	@Column(name = "mrntleasdep", nullable = true)
	private Double mrntleasdep = 0d;;
	@Column(name = "mcontleasexp")
	private LocalDateTime mcontleasexp;
	@Column(name = "mroofcond", columnDefinition = "numeric(6) default 0")
	private int mroofcond = 0;
	@Column(name = "mutils", columnDefinition = "numeric(6) default 0")
	private int mutils = 0;
	@Column(name = "mareatype", columnDefinition = "numeric(6) default 0")
	private int mareatype = 0;
	@Column(name = "mlandmark", columnDefinition = "NVarChar(80) default ''")
	private String mlandmark = "";
	@Column(name = "mstate", columnDefinition = "NVarChar(3) default ''")
	private String mstate = "";
	@Column(name = "myearstay", columnDefinition = "numeric(3) default 0")
	private int myearstay = 0;
	@Column(name = "mwardno", columnDefinition = "NVarChar(6) default ''")
	private String mwardno = "";
	@Column(name = "mmobile", columnDefinition = "NVarChar(15) default ''")
	private String mmobile = "";
	@Column(name = "memail", columnDefinition = "NVarChar(35) default ''")
	private String memail = "";
	@Column(name = "mpattaname", columnDefinition = "NVarChar(30) default ''")
	private String mpattaname = "";
	@Column(name = "mrelationship", columnDefinition = "NVarChar(30) default ''")
	private String mrelationship = "";
	@Column(name = "msourceofdep", columnDefinition = "numeric(2) default 0")
	private int msourceofdep = 0;
	@Column(name = "minstamount", nullable = true)
	private Double minstamount = 0d;
	@Column(name = "mtoietyn", columnDefinition = "NVarChar(1) default ''")
	private String mtoietyn = "";
	@Column(name = "mnoofrooms", columnDefinition = "numeric(6) default 0")
	private int mnoofrooms = 0;
	@Column(name = "mspouseyearsstay", columnDefinition = "numeric(3) default 0")
	private int mspouseyearsstay = 0;
	@Column(name = "mdistcd", columnDefinition = "numeric(6) default 0")
	private int mdistcd = 0;
	@Column(name = "mvillage", columnDefinition = "numeric(6) default 0")
	private int mvillage = 0;
	@Column(name = "mcookfuel", columnDefinition = "numeric(2) default 0")
	private int mcookfuel = 0;
	@Column(name = "msecmobile", columnDefinition = "NVarChar(15) default ''")
	private String msecmobile = "";
	 @Column(name = "mgeolatd",  columnDefinition = "NVarChar(20)")
	 private String mgeolatd;
	 @Column(name = "mgeologd",  columnDefinition = "NVarChar(20)")
	 private String mgeologd;

	/*
	 * @ManyToOne(fetch = FetchType.LAZY, optional = false)
	 * 
	 * @JoinColumn(name = "mrefno", nullable = false)
	 * 
	 * @OnDelete(action = OnDeleteAction.CASCADE)
	 * 
	 * @JsonIgnore private CustomerEntity addressDetailsCustomerEntity;
	 */

	
	  @ManyToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)	  
	  @JoinColumns({	  
	  @JoinColumn(name = "mrefno"), })
	  @OnDelete(action = OnDeleteAction.CASCADE)	  
	  @JsonIgnore
	  private CustomerEntity addressDetailsCustomerEntity;
	 

	/*
	 * @ManyToOne
	 * 
	 * @JsonIgnore
	 * 
	 * @JoinColumn(name="customerNo" ) private CustomerEntity customerEntity;
	 */

}
