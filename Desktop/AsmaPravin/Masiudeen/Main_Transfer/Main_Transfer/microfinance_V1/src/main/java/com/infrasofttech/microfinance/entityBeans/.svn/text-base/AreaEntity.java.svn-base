package com.infrasofttech.microfinance.entityBeans;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.SpeedoMeterCompositePrimaryEntity;

import java.time.LocalDate;

import lombok.Data;

@Entity
@Table(name = "md500024")
@Data

public class AreaEntity {

	@EmbeddedId
    private AreaCompositePrimaryEntity compositeAreaId;	
	

	@Column(columnDefinition = "NVarChar(35)") 
	private String mareadesc;
	
	
	@Column  
	private LocalDate mlastsynsdate;	

}
