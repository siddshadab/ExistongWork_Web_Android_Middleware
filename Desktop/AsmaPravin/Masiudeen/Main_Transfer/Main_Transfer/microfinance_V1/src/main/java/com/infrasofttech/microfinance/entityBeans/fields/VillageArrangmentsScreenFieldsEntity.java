package com.infrasofttech.microfinance.entityBeans.fields;

import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.fields.values.VillageArrangmentsScreenValuesEntity;

import lombok.Data;

@Entity
@Data
@Table(name = "Village_Arrangments_Screen_Fields")
public class VillageArrangmentsScreenFieldsEntity  {
	
	

	  @Id
	  @GeneratedValue(strategy = GenerationType.AUTO)
	  private long village_Arrangments_Screen_Fields_id;

	  @Column (nullable=false)
	  private String captionValue; 
	  
	  @Column 
	  private String captionFieldsType;
	  
	  @Column 
	  private String captionFieldsValue;
	
	  @Column 
	  private String captionValuesDesc;
	  
	  @OneToMany(mappedBy = "arrangmentValues", cascade = CascadeType.ALL,fetch=FetchType.EAGER)
	  private Collection<VillageArrangmentsScreenValuesEntity> villageArrangmentsScreenValuesEntity = new ArrayList<VillageArrangmentsScreenValuesEntity>();
	
}
