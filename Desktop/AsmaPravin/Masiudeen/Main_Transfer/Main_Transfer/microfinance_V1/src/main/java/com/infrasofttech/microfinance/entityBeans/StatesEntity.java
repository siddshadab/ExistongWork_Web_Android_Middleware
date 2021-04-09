package com.infrasofttech.microfinance.entityBeans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDate;

import lombok.Data;

@Entity
@Table(name = "md500025")
@Data
public class StatesEntity {

	@Id
	@GeneratedValue
	@Column(unique = true, nullable = true , columnDefinition = "NVarChar(3)")
	private String mstatecd;

	@Column(columnDefinition = "NVarChar(35)") 
	private String mstatedesc;
	
	@Column(columnDefinition = "NVarChar(3)")
	private String mcountryid;
	
	@Column  
	private LocalDate mlastsynsdate;	

}
