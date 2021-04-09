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
@Table(name = "md001016")
@Data
public class InterestSlabEntity extends BaseEntity {

	
	@EmbeddedId
    private InterestSlabCompositeEntity interestSlabCompositeEntity;
	/*@Column(name = "mprdcd",  columnDefinition = "nvarchar(8)" )     	
	private String mprdcd;     	
	@Column(name = "mcurcd",  columnDefinition = "nvarchar(3)" )     	
	private String mcurcd;     	
	@Column(name = "minteffdt" ) 	
	private LocalDateTime minteffdt; 	*/
	/*@Column(name = "msrno",  columnDefinition = "numeric(8)" )	
	private int msrno;*/	
	@Column(name = "mtoamt")     	
	private Double mtoamt = 0d;  	
	@Column(name = "mintrate")   	
	private Double mintrate = 0d; 	
	@Column(name = "mmlastsynsdate")	
	private LocalDateTime mmlastsynsdate;	
	

}
