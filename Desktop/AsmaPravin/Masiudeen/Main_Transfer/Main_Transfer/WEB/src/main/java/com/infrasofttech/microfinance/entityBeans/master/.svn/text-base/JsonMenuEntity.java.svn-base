package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Columns;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "JsonMenuMaster")
@Data
public class JsonMenuEntity{

//	@Id
//	@Column(name = "musrcode",  columnDefinition = "nvarchar(100) default ''" )	
//	private String musrcode;
//	
//	@Column(name = "mgrpcd",  columnDefinition = "numeric(8) default ''" )	
//	private String mgrpcd;	
	
	@EmbeddedId
	JsonMenuCompositeEntity jsonMenuComposite;	


	@Column(name = "mcachingvalue",  columnDefinition = "NVARCHAR(MAX) default ''" )	
	private String mcachingvalue;
 
	
	@Override
	public String toString() {
		return "JsonMenuEntity [jsonMenuComposite=" + jsonMenuComposite + ", mcachingvalue=" + mcachingvalue
				+ ", getJsonMenuComposite()=" + getJsonMenuComposite() + ", getMcachingvalue()=" + getMcachingvalue()
				+ ", hashCode()=" + hashCode() + ", getClass()=" + getClass() + ", toString()=" + super.toString()
				+ "]";
	}	
}
