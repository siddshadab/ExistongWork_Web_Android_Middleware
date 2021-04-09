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
@Table(name = "md009027")
@Data
public class TDOffsetInterestSlabEntity extends BaseEntity {

	
	@EmbeddedId
    private TDOffsetInterestSlabCompositeEntity tdOffsetInterestSlabCompositeEntity;	

	
	@Column(name = "mcurcd",  columnDefinition = "nvarchar(30)" )	
	private String mcurcd;    
	@Column(name = "mdays",  columnDefinition = "numeric(8) default 0" )	
	private int mdays;
    @Column(name = "mmonths",  columnDefinition = "numeric(8) default 0" )	
	private int mmonths;
    @Column(name = "minvamtfrm")     	
	private Double minvamtfrm = 0d;	
	@Column(name = "muptoamt")     	
	private Double muptoamt = 0d;  
	@Column(name = "mlowertollimit")     	
	private Double mlowertollimit = 0d;
	 @Column(name = "muppertollimit")     	
	private Double muppertollimit = 0d;	
	@Column(name = "moffsetintrate")     	
	private Double moffsetintrate = 0d;		
	@Column(name = "mmlastsynsdate")	
	private LocalDateTime mmlastsynsdate;	
	

}
