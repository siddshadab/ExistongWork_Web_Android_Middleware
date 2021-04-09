package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "reportfiltermaster" )
@Data
public class ReportFilterEntity {
	
	@EmbeddedId
	ReportFilterCompositeEntity reportFilterComposite;
	
	@Column(name = "mdisplay",  columnDefinition = "nvarchar(100) default ''" )	
	private String mdisplay = "";	
		
	
	@Column(name = "mismandatory",  columnDefinition = "numeric(1) default 0" )	
	private int mismandatory = 0;
	
	@Column(name = "mfieldid",  columnDefinition = "numeric(2) default 0" )	
	private int mfieldid= 0;
	
	@Column(name = "mdefaultval",  columnDefinition = "nvarchar(20) default ''" )	
	private String mdefaultval = "";	
	

	
}
