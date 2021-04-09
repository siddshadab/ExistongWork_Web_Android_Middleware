package com.infrasofttech.microfinance.entityBeans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDate;

import lombok.Data;


@Entity
@Table(name = "md500027")
@Data


public class CountriesEntity {

	@Id
	@GeneratedValue
	@Column(unique = true, nullable = true , columnDefinition = "NVarChar(3)")
	private String mcountryid;

	@Column(columnDefinition = "NVarChar(35)") 
	private String mcountryname;
	
	@Column  
	private LocalDate mlastsynsdate;	

}
