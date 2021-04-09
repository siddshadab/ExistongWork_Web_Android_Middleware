package com.infrasofttech.microfinance.entityBeans.master;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "Sub_Lookup_master")
@Data
public class SubLookupMasterEntity extends BaseEntity{

	@EmbeddedId
    private LookupComposieEntity lookupComposieEntity;	
	@Column(name = "mcodedesc",  columnDefinition = "nvarchar(100)" )	
	private String mcodedesc;
	@Column(name = "mfield1value",  columnDefinition = "nvarchar(30)" )	
	private String mfield1value;		
	
}
