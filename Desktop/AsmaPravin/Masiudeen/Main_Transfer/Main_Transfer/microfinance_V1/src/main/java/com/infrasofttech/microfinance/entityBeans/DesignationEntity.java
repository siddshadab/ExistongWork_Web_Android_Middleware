package com.infrasofttech.microfinance.entityBeans;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;

import lombok.Data;

/*@Entity
@Table(name = "User_Designation")
@Data*/
public class DesignationEntity {
	
/*	@Id
	@GeneratedValue
	@Column(unique = true, nullable = false)
	private Integer designationId;
	
	@Column(unique=true,nullable=false)
	private String description;
	
	@OneToMany( mappedBy = "designation" , cascade = CascadeType.ALL, orphanRemoval = false, fetch = FetchType.EAGER )
	private Set<UserMasterEntity> userMaster;*/
}
