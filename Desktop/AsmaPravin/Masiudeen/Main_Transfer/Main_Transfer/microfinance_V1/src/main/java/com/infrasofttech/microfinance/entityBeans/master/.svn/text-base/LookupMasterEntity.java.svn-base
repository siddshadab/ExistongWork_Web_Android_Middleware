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
@Table(name = "md001002")
@Data
public class LookupMasterEntity extends BaseEntity {

	
	@EmbeddedId
    LookupComposieEntity lookupComposite;
	@Column(name = "mcodedesc",  columnDefinition = "nvarchar(100) default ''" )	
	private String mcodedesc = "";			
	@Column(name = "mcodedatatype",  columnDefinition = "numeric(2) default 0" )	
	private int mcodedatatype = 0;		
	@Column(name = "mcodedatalen",  columnDefinition = "numeric(2) default 0" )	
	private int mcodedatalen = 0;		
	@Column(name = "mlastsynsdate")	
	private LocalDateTime mlastsynsdate;		

}
