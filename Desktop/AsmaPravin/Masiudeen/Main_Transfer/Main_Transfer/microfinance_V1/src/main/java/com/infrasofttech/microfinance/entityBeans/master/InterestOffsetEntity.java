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
@Table(name = "md001029")
@Data
public class InterestOffsetEntity extends BaseEntity {

	
	@EmbeddedId
    private InterestOffsetCompositeEntity interestOffsetCompositeEntity;
	/*@Column(name = "mlbrcode",  columnDefinition = "numeric(8)" )    	
	private int mlbrcode;    	
	@Column(name = "mprdcd",  columnDefinition = "nvarchar(8)" )      	
	private String mprdcd;      	
	@Column(name = "mloantype",  columnDefinition = "numeric(1)" )  	
	private int mloantype;  	
	@Column(name = "mloancycle",  columnDefinition = "numeric(1)" )  	
	private int mloancycle;  	
	@Column(name = "meffdate")    	
	private LocalDateTime meffdate; */   	
	/*@Column(name = "msrno",  columnDefinition = "numeric(8)" )	
	private int msrno;	*/
	@Column(name = "mmonths",  columnDefinition = "numeric(4)" )     	
	private int mmonths;     	
	@Column(name = "mamount")     	
	private Double mamount;     	
	@Column(name = "mintrestrate")	
	private Double mintrestrate;	
	@Column(name = "mlastsynsdate" )	
	private LocalDateTime mlastsynsdate;	
	
	

}
