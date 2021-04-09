package com.infrasofttech.microfinance.entityBeans.master;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.IndexColumn;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "cbresultmaster")
@Data
public class CreditBereauResultMasterEntity implements Serializable{

	private static final long serialVersionUID = 1L;
	
	/*@EmbeddedId
    private ProspectCompositePrimaryEntityAdhaar compositepropspectId;
	 */
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "mrefresultsrno", unique = true, nullable = false,  columnDefinition = "numeric(8)")
	private int mrefresultsrno;
	@Column(name = "trefno",columnDefinition = "numeric(8)" )	
	private int trefno;	
	@Column(name = "mcbcheckstatus",columnDefinition = "nvarchar(5)" )	
	private String mcbcheckstatus;	
	@Column(name = "mdateofissue" ,columnDefinition = "nvarchar(12)" )	
	private String mdateofissue;	
	@Column(name = "mdateofrequest",columnDefinition = "nvarchar(20)" )	
	private String mdateofrequest;	
	@Column(name = "miscustomercreated",columnDefinition = "nvarchar(5)" )	
	private String miscustomercreated;	
	@Column(name = "mpreparedfor",columnDefinition = "nvarchar(50)" )	
	private String mpreparedfor;	
	@Column(name = "mreportid",columnDefinition = "nvarchar(25)" )	
	private String mreportid;	
	@Column(name = "mcbresultblob")
	@Lob
	private String mcbresultblob;

	@Column(name = "mothrmficnt",columnDefinition = "numeric(3)" )	
	private int mothrmficnt;	

	@Column(name = "mloancycle",columnDefinition = "numeric(2)" )	
	private int mloancycle;	
	
	@Column(name = "mothrmficurbal") 	
	private Double mothrmficurbal =0d;
	@Column(name = "mothrmfiovrdueamt") 	
	private Double mothrmfiovrdueamt =0d;
	@Column(name = "mothrmfidisbamt") 	
	private Double mothrmfidisbamt =0d;
	@Column(name = "mtotovrdueaccno",columnDefinition = "numeric(2)" )	
	private int mtotovrdueaccno;	
	@Column(name = "mmfitotdisbamt") 	
	private Double mmfitotdisbamt =0d;
	@Column(name = "mmfitotcurrentbal") 	
	private Double mmfitotcurrentbal =0d;
	@Column(name = "mmfitotovrdueamt") 	
	private Double mmfitotovrdueamt =0d;
	@Column(name = "mtotovrdueamt") 	
	private Double mtotovrdueamt =0d;
	@Column(name = "mtotcurrentbal") 	
	private Double mtotcurrentbal =0d;
	
	@Column(name = "mtotdisbamt") 	
	private Double mtotdisbamt =0d;
	
	@Column(name = "mexpsramt") 	
	private Double mexpsramt =0d;
	
/*	@Column(name = "mprimarycurrentbal",columnDefinition = "nvarchar(10)" )	
	private String mprimarycurrentbal;	
	@Column(name = "mprimarynoofaccounts",columnDefinition = "nvarchar(3)" )	
	private String mprimarynoofaccounts;	
	@Column(name = "mprimaryoverdueamount",columnDefinition = "nvarchar(10)" )	
	private String mprimaryoverdueamount;	
	@Column(name = "mprimarynoofactiveacs",columnDefinition = "nvarchar(3)" )	
	private String mprimarynoofactiveacs;	
	@Column(name = "mprimarynoofodaccs",columnDefinition = "nvarchar(3)" )	
	private String mprimarynoofodaccs;	
	
	@Column(name = "msecondarycurrentbalance",columnDefinition = "nvarchar(10)" )	
	private String msecondarycurrentbalance;	
	@Column(name = "msecondarynoofaccs",columnDefinition = "nvarchar(3)" )	
	private String msecondarynoofaccs;
	@Column(name = "msecondaryoverdueamount",columnDefinition = "nvarchar(10)" )	
	private String msecondaryoverdueamount;
	@Column(name = "msecondarynoofactiveaccs",columnDefinition = "nvarchar(3)" )
	private String msecondarynoofactiveaccs;	
	@Column(name = "msecondarynoofodacs",columnDefinition = "nvarchar(3)" )	
	private String msecondarynoofodacs;	
	@Column(name = "msecondarysanctionedamt",columnDefinition = "nvarchar(10)" )	
	private String msecondarysanctionedamt;	*/
	/*@Column(name = "magentusername",columnDefinition = "nvarchar(8)" )	
	private String magentusername;	
	@Column(name = "mcreateddt",columnDefinition = "nvarchar(4)" )	
	private LocalDateTime mcreateddt;	
	@Column(name = "mcreatedby",columnDefinition = "nvarchar(8)" )
	private String mcreatedby;	
	@Column(name = "mlastupdatedt",columnDefinition = "nvarchar(4)" )	
	private LocalDateTime mlastupdatedt;	
	@Column(name = "mlastupdateby",columnDefinition = "nvarchar(8)" )	
	private String mlastupdateby;	
	@Column(name = "mgeolocation",columnDefinition = "nvarchar(250)" )	
	private String mgeolocation;	
	@Column(name = "mgeolatd",columnDefinition = "nvarchar(20)" )	
	private String mgeolatd;	
	@Column(name = "mgeologd",columnDefinition = "nvarchar(20)" )	
	private String mgeologd;	
	@Column(name = "missync",columnDefinition = "nvarchar(1)" )	
	private String missync;	
	@Column(name = "mlastsynsdate",columnDefinition = "nvarchar(4)" )	
	private LocalDateTime mlastsynsdate;	*/





	@OneToOne(fetch = FetchType.EAGER, cascade=CascadeType.ALL)
	@JoinColumns({
		@JoinColumn(name = "mrefno"),

	})	
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private ProspectCreationEntity  resultDetailsProspectEntity;


	


}
