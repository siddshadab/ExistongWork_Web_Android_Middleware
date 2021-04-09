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
@Table(name = "md001004")
@Data
public class SystemParameterEntity extends BaseEntity {


	@EmbeddedId
	SystemParameterCompositeEntity systemParameterCompositeEntity;
	
	@Column(name = "mcodedesc",  columnDefinition = "nvarchar(30) default ''" )	
	private String mcodedesc = "";	
	
	
	@Column(name = "mcodevalue",  columnDefinition = "nvarchar(100) default ''" )	
	private String mcodevalue = "";		
	
	@Column(name = "mcreateddt") 
    private LocalDateTime mcreateddt;	

}
