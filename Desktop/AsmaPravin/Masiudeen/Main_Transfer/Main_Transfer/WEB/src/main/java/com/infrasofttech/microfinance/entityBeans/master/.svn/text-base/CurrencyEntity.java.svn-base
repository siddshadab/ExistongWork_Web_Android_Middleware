package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "md001012")
@Data
public class CurrencyEntity {

	@Id
	@GeneratedValue
	@Column(name = "mcurrcd", unique = true, nullable = true, columnDefinition = "NVarChar(3) ")
	private String mcurrcd;	
	
	@Column(name = "mcurrdesc", columnDefinition = "NVarChar(35) default ''")
	private String mcurrdesc;
}
