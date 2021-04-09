package com.infrasofttech.microfinance.entityBeans.master;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "repayment_frequency_master")
@Data
public class RepaymentFrequencyEntity extends BaseEntity {

	@Id
	@GeneratedValue
	@Column(unique = true, nullable = false)
	private Long repaymentFrequencyId;
	
	@Column 
	 private String repaymentFrequency;
	 @Column 
	 private String repaymentFrequencyDescription;
	
}
