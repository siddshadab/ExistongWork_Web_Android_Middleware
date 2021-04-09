package com.infrasofttech.microfinance.entityBeans.master;

import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;

import lombok.Data;

@Entity
@Table(name = "transaction_mode_master")
@Data

public class TransactionModeEntity extends BaseEntity{
	

	@Id
	@GeneratedValue
	@Column(unique = true, nullable = false)
	private Long transactionModeId;
	
	@Column(unique = true, nullable = false)	
	private String transactionMode;
	
	@Column(unique = true, nullable = false)	
	private String transactionModeDescription;

}
