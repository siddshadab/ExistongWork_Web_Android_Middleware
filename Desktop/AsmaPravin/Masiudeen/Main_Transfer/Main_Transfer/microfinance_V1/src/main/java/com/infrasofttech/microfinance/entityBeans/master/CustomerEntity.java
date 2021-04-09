package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.Table;

import org.hibernate.annotations.IndexColumn;
import org.hibernate.annotations.NamedNativeQuery;
import org.springframework.beans.factory.annotation.Autowired;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerLocationHolder;

import lombok.Data;



@Entity
@Table(name = "md009011", indexes = { @Index(columnList = "trefno", name = "trefno_hidx"),
		@Index(columnList = "mcustno", name = "mcustno_hidx"),
		@Index(columnList = "missyncfromcoresys", name = "missyncfromcoresys_hidx"),
		@Index(columnList = "mcreatedby", name = "mcreatedby_hidx"),
		@Index(columnList = "missynctocoresys", name = "missynctocoresys_hidx"),
		@Index(columnList = "mdob,mpannodesc", name = "dobn_panno"),
		})
@Data

public class CustomerEntity extends BaseEntity {

	/*@Autowired
	CustomerLocationHolder customerLocationHolder;*/
	
	@Column(name = "trefno", nullable = false, columnDefinition = "numeric(8)")
	private int trefno = 0;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "mrefno", unique = true, nullable = false, columnDefinition = "numeric(8)")
	private int mrefno;
	@Column(name = "mcustno", columnDefinition = "numeric(8) default 0")
	private int mcustno = 0;
	@Column(name = "mlbrcode", columnDefinition = "numeric(8) default 0")
	private int mlbrcode = 0;
	@Column(name = "mcenterid", columnDefinition = "numeric(8) default 0")
	private int mcenterid = 0;
	@Column(name = "mgroupcd", columnDefinition = "numeric(8) default 0")
	private int mgroupcd = 0;
	@Column(name = "mnametitle", columnDefinition = "nvarchar(4) default ''")
	private String mnametitle = "";
	@Column(name = "mlongname", columnDefinition = "nvarchar(250) default ''")
	private String mlongname = "";
	@Column(name = "mfathertitle", columnDefinition = "nvarchar(4) default ''")
	private String mfathertitle = "";
	@Column(name = "mfathername", columnDefinition = "nvarchar(250) default ''")
	private String mfathername = "";
	@Column(name = "mspousetitle", columnDefinition = "nvarchar(4) default ''")
	private String mspousetitle = "";
	@Column(name = "mhusbandname", columnDefinition = "nvarchar(250) default ''")
	private String mhusbandname = "";
	@Column(name = "mdob")
	private LocalDateTime mdob;
	@Column(name = "mage", columnDefinition = "numeric(4) default 0")
	private int mage = 0;
	@Column(name = "mbankacyn", columnDefinition = "nvarchar(4) default ''")
	private String mbankacyn = "";
	@Column(name = "mbankacno", columnDefinition = "nvarchar(20) default ''")
	private String mbankacno = "";
	@Column(name = "mbankifsc", columnDefinition = "nvarchar(20) default ''")
	private String mbankifsc = "";
	@Column(name = "mbanknamelk", columnDefinition = "nvarchar(25) default ''")
	private String mbanknamelk = "";
	@Column(name = "mbankbranch", columnDefinition = "nvarchar(30) default ''")
	private String mbankbranch = "";
	@Column(name = "mcuststatus", columnDefinition = "numeric(4) default 0")
	private int mcuststatus = 0;
	@Column(name = "mdropoutdate")
	private LocalDateTime mdropoutdate;
	@Column(name = "mmobno", columnDefinition = "nvarchar(15) default ''")
	private String mmobno = "";
	@Column(name = "mpanno", columnDefinition = "numeric(4) default 0")
	private int mpanno = 0;
	@Column(name = "mpannodesc", columnDefinition = "nvarchar(25) default ''")
	private String mpannodesc = "";
	@Column(name = "mtdsyn", columnDefinition = "nvarchar(1) default ''")
	private String mtdsyn = "";
	@Column(name = "mtdsreasoncd", columnDefinition = "numeric (4) default 0")
	private int mtdsreasoncd = 0;
	@Column(name = "mtdsfrm15subdt")
	private LocalDateTime mtdsfrm15subdt;
	@Column(name = "memailid", columnDefinition = "nvarchar(50) default ''")
	private String memailid = "";
	@Column(name = "mcustcategory", columnDefinition = "numeric(4) default 0")
	private int mcustcategory = 0;
	@Column(name = "mtier", columnDefinition = "numeric(4) default 0")
	private int mtier = 0;
	@Column(name = "madd1", columnDefinition = "nvarchar(75) default ''")
	private String madd1 = "";
	@Column(name = "madd2", columnDefinition = "nvarchar(75) default ''")
	private String madd2 = "";
	@Column(name = "madd3", columnDefinition = "nvarchar(75) default ''")
	private String madd3 = "";
	@Column(name = "marea", columnDefinition = "numeric(11) default 0")
	private int marea = 0;
	@Column(name = "mpincode", columnDefinition = "nvarchar(8) default ''")
	private String mpincode = "";
	@Column(name = "mcouncd", columnDefinition = "nvarchar(3) default ''")
	private String mcouncd = "";
	@Column(name = "mcitycd", columnDefinition = "nvarchar(15) default ''")
	private String mcitycd = "";
	@Column(name = "mfname", columnDefinition = "nvarchar(50) default ''")
	private String mfname = "";
	@Column(name = "mmname", columnDefinition = "nvarchar(50) default ''")
	private String mmname = "";
	@Column(name = "mlname", columnDefinition = "nvarchar(50) default ''")
	private String mlname = "";
	@Column(name = "mgender", columnDefinition = "nvarchar(1) default ''")
	private String mgender = "";
	@Column(name = "mrelegion", columnDefinition = "nvarchar(1) default ''")
	private String mrelegion = "";
	@Column(name = "mruralurban", columnDefinition = "numeric(4) default 0")
	private int mruralurban = 0;
	@Column(name = "mcaste", columnDefinition = "nvarchar(4) default ''")
	private String mcaste = "";
	@Column(name = "mqualification", columnDefinition = "nvarchar(15) default ''")
	private String mqualification = "";
	@Column(name = "moccupation", columnDefinition = "numeric(4) default 0")
	private int moccupation = 0;
	@Column(name = "mlandtype", columnDefinition = "nvarchar(4) default ''")
	private String mlandtype = "";
	@Column(name = "mlandmeasurement", columnDefinition = "nvarchar(4) default ''")
	private String mlandmeasurement = "";
	@Column(name = "mmaritialstatus", columnDefinition = "numeric(4) default 0")
	private int mmaritialstatus = 0;
	@Column(name = "mtypeofid", columnDefinition = "numeric(4) default 0")
	private int mtypeofid = 0;
	@Column(name = "middesc", columnDefinition = "nvarchar(25) default ''")
	private String middesc = "";
	@Column(name = "mloanagreed", columnDefinition = "nvarchar(1) default ''")
	private String mloanagreed = "";
	@Column(name = "minsurancecovyn", columnDefinition = "nvarchar(1) default ''")
	private String minsurancecovyn = "";
	@Column(name = "mtypeofcoverage", columnDefinition = "numeric(4) default 0")
	private int mtypeofcoverage = 0;
	@Column(name = "miscbcheckdone", columnDefinition = "numeric(4) default 0")
	private int miscbcheckdone = 0;
	@Column(name = "merrormessage", columnDefinition = "nvarchar(100) default ''")
	private String merrormessage = "";
	@Column(name = "mcentername", columnDefinition = "nvarchar(50) default ''")
	private String mcentername = "";
	@Column(name = "mgroupname", columnDefinition = "nvarchar(100) default ''")
	private String mgroupname = "";
	@Column(name = "mexpsramt")
	private Double mexpsramt = 0d;
	@Column(name = "mcbcheckrprtdt")
	private LocalDateTime mcbcheckrprtdt;
	@Column(name = "mprofileind", columnDefinition = "nvarchar(2) default ''")
	private String mprofileind = "";
	@Column(name = "mhusdob")
	private LocalDateTime mhusdob;
	@Column(name = "mhusage", columnDefinition = "numeric(4) default 0")
	private int mhusage = 0;
	@Column(name = "mcrs", columnDefinition = "nvarchar(8) default ''")
	private String mcrs = "";
	@Column(name = "motpvrfdno", columnDefinition = "nvarchar(16) default ''")
	private String motpvrfdno = "";
	@Column(name = "mlangofcust", columnDefinition = "nvarchar(15) default ''")
	private String mlangofcust = "";
	@Column(name = "mmainoccupn", columnDefinition = "nvarchar(50) default ''")
	private String mmainoccupn = "";
	@Column(name = "msuboccupn", columnDefinition = "nvarchar(50) default ''")
	private String msuboccupn = "";
	@Column(name = "msecoccupatn", columnDefinition = "numeric(2) default 0")
	private int msecoccupatn = 0;
	
	@Column(name = "mcusttype", columnDefinition = "nvarchar(10) default ''")
	private String mcusttype ="";
	
	
	
	@Column(name = "mid1expdate")
	private LocalDateTime mid1expdate;
	@Column(name = "mid1issuedate")
	private LocalDateTime mid1issuedate;
	@Column(name = "mid2issuedate")
	private LocalDateTime mid2issuedate;
	@Column(name = "mid2expdate")
	private LocalDateTime mid2expdate;
	@Column(name = "mdropoutreason", columnDefinition = "nvarchar(4) default ''")
	private String mdropoutreason = "";
	
	@Column(name = "mmobilelastsynsdate")
	private LocalDateTime mmobilelastsynsdate;
	
	
	@Column(name = "mretry", columnDefinition = "numeric(2) default 0")
	private int mretry = 0;
	
	@Column(name = "mutils", columnDefinition = "numeric(2) default 0")
	private int mutils = 0;
	
	@Column(name = "trefcenterid", nullable = false, columnDefinition = "int default 0" )
	private int trefcenterid; 	
	@Column(name = "mrefcenterid", nullable = false, columnDefinition = "int default 0" )	
	private int mrefcenterid;
	
	@Column(name = "trefgroupid", nullable = false, columnDefinition = "int default 0" )
	private int trefgroupid; 	
	@Column(name = "mrefgroupid", nullable = false, columnDefinition = "int default 0" )	
	private int mrefgroupid;

	@Column(name = "mmemberno", nullable = false, columnDefinition = "int default 0" )	
	private int mmemberno;
	
	@Column(name = "designation", columnDefinition = "nvarchar(30) default ''")
	private String designation = "";
	@Column(name = "orgname", columnDefinition = "nvarchar(150) default ''")
	private String orgname = "";
	@Column(name = "yearsinorg", columnDefinition = "nvarchar(8) default ''")
	private String yearsinorg = "";
	@Column(name = "mismodify", nullable = false, columnDefinition = "int default 0" )	
	private int mismodify;
	@Column(name = "missyncfromcoresys", nullable = false, columnDefinition = "int default 0" )	
	private int missyncfromcoresys;
	
	

	
	@OneToOne(mappedBy = "customerBussDetailsCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private CustomerBusinessDetailsEntity customerBussDetails;

	@OneToMany(mappedBy = "familyDetailsCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerFamilyDetailsEntity> familyDetails;// = new ArrayList<CustomerFamilyDetailsEntity>();

	@OneToMany(mappedBy = "borrowingDetailsCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerBorrowingDetailsEntity> borrowingDetails;// = new ArrayList<CustomerBorrowingDetailsEntity>();

	@OneToMany(mappedBy = "addressDetailsCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerAddressDetailsEntity> addressDetails;// = new ArrayList<CustomerAddressDetailsEntity>();

	@OneToMany(mappedBy = "paymetMethodDetailsCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerPaymentMethodDetailsEntity> paymentDetailsDetails;// = new ArrayList<CustomerPaymentMethodDetailsEntity>();

	@OneToMany(mappedBy = "imageMasterEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<ImageMasterEntity> imageMaster;// = new ArrayList<ImageMasterEntity>();

	@OneToMany(mappedBy = "ppiDetailsCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerPPIDetailsEntity> customerPPIDetailsEntity;// = new ArrayList<CustomerPPIDetailsEntity>();

	@OneToMany(mappedBy = "businessExpenseCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerBusinessExpenseEntity> customerBusinessExpenseEntity;// = new ArrayList<CustomerBusinessExpenseEntity>();

	@OneToMany(mappedBy = "householdExpenseCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerHouseholdExpenseEntity> customerHouseholdExpenseEntity;// = new ArrayList<CustomerHouseholdExpenseEntity>();

	@OneToMany(mappedBy = "assetCustomerEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerAssetDetailsEntity> customerAssetDetailsEntity;// = new ArrayList<CustomerAssetDetailsEntity>();
	@OneToOne(mappedBy = "contactPointVerificationEntity", cascade = CascadeType.ALL)
	@IndexColumn(name = "INDEX_COL")
	private ContactPointVerificationEntity contactPointVerification;

	
	@OneToMany(mappedBy = "customerFingerPrintEntity", cascade = CascadeType.ALL)
//	@Fetch(FetchMode.SELECT)
	@IndexColumn(name = "INDEX_COL")
	//@LazyCollection(LazyCollectionOption.FALSE)
	private List<CustomerFingerPrintEntity> customerFingerPrintList;// = new ArrayList<ImageMasterEntity>();
	
}
