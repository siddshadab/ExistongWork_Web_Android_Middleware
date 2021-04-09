package com.infrasofttech.microfinance.entityBeans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDate;

import lombok.Data;

@Entity
@Table(name = "md500028")
@Data

public class SubDistrictsEntity {

	@Id
	//@GeneratedValue
	@Column(unique = true, nullable = true , columnDefinition = "NVarChar(6)")
	private String mplacecd;

	@Column(columnDefinition = "NVarChar(35)") 
	private String mplacecddesc;
	
	@Column(columnDefinition = "numeric(6) default 0")
	private int mdistcd;
	
	@Column(columnDefinition = "NVarChar(3)")
	private String mstatecd;
	@Column  
	private LocalDate mlastsynsdate;	

}
