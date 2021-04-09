package com.infrasofttech.microfinance.entityBeans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.LocalDate;

import lombok.Data;


@Entity
@Table(name = "md500035")
@Data
public class DistrictsEntity {
	
	@Id
	//@GeneratedValue
	@Column(unique = true,columnDefinition = "numeric(6) default 0")
	private int mdistcd;

	@Column(columnDefinition = "NVarChar(35)") 
	private String mdistdesc;
	
	@Column(columnDefinition = "NVarChar(3)")
	private String mstatecd;
	
	@Column 
	private LocalDate mlastsynsdate;	

}
