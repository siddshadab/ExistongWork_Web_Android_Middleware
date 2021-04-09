package com.infrasofttech.microfinance.entityBeans.fields.values;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.infrasofttech.microfinance.entityBeans.fields.VillageArrangmentsScreenFieldsEntity;

import lombok.Data;


@Entity
@Table(name = "Village_Arrangments_Screen_Fields_Values")
@Data
public class VillageArrangmentsScreenValuesEntity {
	
	
	@Id
	@GeneratedValue
	@Column(unique = true, nullable = false)
	private Long village_Arrangments_Screen_Fields_Values_id;
	
	  @Column 
	  private String value;
	  
	  
	  @Column 
	  private String valueDesc;
	  
	@ManyToOne 
	@JsonIgnore
	@JoinColumn(name = "village_Arrangments_Screen_Fields_id")
	private VillageArrangmentsScreenFieldsEntity arrangmentValues;

}
