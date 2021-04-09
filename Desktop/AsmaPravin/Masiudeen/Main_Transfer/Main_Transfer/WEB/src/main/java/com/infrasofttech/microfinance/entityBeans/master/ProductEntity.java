package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Index;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "md009021" , indexes = {
		
		@Index(columnList = "mlbrcode", name = "mlbrcode_hidx")
})
@Data
public class ProductEntity extends BaseEntity {

	
	
	@EmbeddedId
  	private ProductComposieEntity productComposieEntity; 	
	// omni size is 75 of prdcd name 
	@Column(name = "mname",  columnDefinition = "nvarchar(75)" )
	private String mname;      	
	@Column(name="mintrate")
	private double mintrate=0d;
	@Column(name = "mmoduletype",  columnDefinition = "numeric(4) default 0" )	
	private int mmoduletype = 0;	 	
	@Column(name = "mcurcd",  columnDefinition = "nvarchar(3) default ''" )     	
	private String mcurcd = "";     	 	
	@Column(name = "mlastsynsdate" )	
	private LocalDateTime mlastsynsdate;		
	@Column(name = "mdivisiontype",  columnDefinition = "nvarchar(4) default ''" )
	private String mdivisiontype ="";
	@Column(name = "mnoofguaranter",  columnDefinition = "numeric(8) default 0" )	
	private int mnoofguaranter = 0;	 
	
}


