package com.infrasofttech.microfinance.entityBeans.master;

import java.time.LocalDateTime;
import java.util.Collection;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "loancyclewiselimitmaster")
@Data
public class LoanCycleWiseLimitEntity {


	 @Id
	 @Column(name = "mloancycle", unique = true, nullable = false,  columnDefinition = "numeric(2)")
	 private int mloancycle;
	 
	 @Column(name = "mloanlimit")	 
	 private double mloanlimit= 0d;
}
