package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md045275")
@Data
public class LoanCycleParameterPrimaryEntity extends BaseEntity {

	
	@EmbeddedId
   private LoanCycleParameterPrimaryCompositeEntity loanCycleParameterPrimaryCompositeEntity;
     	
	
	@Column(name = "mminamount" )    	
	private Double mminamount;    	
	@Column(name = "mmaxamount")    	
	private Double mmaxamount;    	
	@Column(name = "mminperiod",  columnDefinition = "numeric(8)" )       	
	private int mminperiod;       	
	@Column(name = "mmaxperiod",  columnDefinition = "numeric(8)" )       	
	private int mmaxperiod;       	
	@Column(name = "mminnoofgrpmems",  columnDefinition = "numeric(8)" )  	
	private int mminnoofgrpmems;  	
	@Column(name = "mmaxnoofgrpmems",  columnDefinition = "numeric(8)" )  	
	private int mmaxnoofgrpmems;  	
	@Column(name = "mgender",  columnDefinition = "nvarchar(8)" )       	
	private String mgender;       	
	@Column(name = "mminage",  columnDefinition = "numeric(2)" )          	
	private int mminage;          	
	@Column(name = "mmaxage",  columnDefinition = "numeric(2)" )          	
	private int mmaxage;          	
	@Column(name = "mgrpcycyn",  columnDefinition = "nvarchar(8)" )    	
	private String mgrpcycyn;    	
	@Column(name = "mlogic",  columnDefinition = "numeric(8)" )           	
	private int mlogic;           	
	@Column(name = "mtenor",  columnDefinition = "numeric(8)" )           	
	private int mtenor;           	
	@Column(name = "mfrequency",  columnDefinition = "nvarchar(8)" )    	
	private String mfrequency;    	
	@Column(name = "mincramount" )   	
	private Double mincramount;   	
	@Column(name = "mnoofinstlclosure",  columnDefinition = "numeric(8)" )	
	private int mnoofinstlclosure;	
	@Column(name = "mmultiplefactor",  columnDefinition = "numeric(8)" )  	
	private int mmultiplefactor;  	
	@Column(name = "mlastsynsdate")	
	private LocalDateTime mlastsynsdate;	

	
	

}
