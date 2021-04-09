
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
@Table(name = "md045375")
@Data
public class LoanCycleParameterSecondaryEntity extends BaseEntity {

	
	@EmbeddedId
    private LoanCycleParameterSecondaryCompositeEntity loanCycleParameterSecondaryCompositeEntity;
	/*@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )      	
	private int mlbrcode;   	
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(8)" )     	
	private String mprdcd;  	
	@Column(name = "mloancycle",  columnDefinition = "numeric(4)" )    	
	private int mloancycle; 	
	@Column(name = "mcusttype",  columnDefinition = "numeric(1)" )     	
	private int mcusttype;  	
	@Column(name = "mgrtype",  columnDefinition = "numeric(1)" )   	
	private int mgrtype;	
	@Column(name = "meffdate")    
	private LocalDateTime meffdate; 	
	@Column(name = "mfrequency",  columnDefinition = "nvarchar(1)" )   	
	private String mfrequency;	
	@Column(name = "mruletype",  columnDefinition = "numeric(1)" )   	
	private int mruletype;	
	@Column(name = "msrno",  columnDefinition = "numeric(8)" )            	
	private int msrno;   */      	
	@Column(name = "muptoamount ")   	
	private Double muptoamount;	
	@Column(name = "mminamount")   	
	private Double mminamount;	
	@Column(name = "mmaxamount")   	
	private Double mmaxamount;	
	@Column(name = "mlastsynsdate ")   	
	private LocalDateTime mlastsynsdate;	

	
	

}
