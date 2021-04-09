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
@Table(name = "md020018")
@Data
public class TDInterestSlabEntity extends BaseEntity {

	
	@EmbeddedId
    private TDInterestSlabCompositeEntity tdInterestSlabCompositeEntity;	

	@Column(name = "mdays",  columnDefinition = "numeric(8) default 0" )	
	private int mdays;
    @Column(name = "mmonths",  columnDefinition = "numeric(8) default 0" )	
	private int mmonths;
    @Column(name = "mintrate")     	
	private Double mintrate = 0d;	
	@Column(name = "mpenalintrate")     	
	private Double mpenalintrate = 0d;  
	@Column(name = "mlowertollimit")     	
	private Double mlowertollimit = 0d;
	 @Column(name = "muppertollimit")     	
	private Double muppertollimit = 0d;	
	@Column(name = "mminrate")     	
	private Double mminrate = 0d;	
	@Column(name = "mmaxrate")     	
	private Double mmaxrate = 0d;	
	@Column(name = "mfrommonths",  columnDefinition = "numeric(8) default 0" )	
	private int mfrommonths;	
	@Column(name = "mtomonths",  columnDefinition = "numeric(8) default 0" )	
	private int mtomonths;
	@Column(name = "mmlastsynsdate")	
	private LocalDateTime mmlastsynsdate;	
	

}
