package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.infrasofttech.microfinance.entityBeans.master.CGT1Entity;
import com.infrasofttech.microfinance.entityBeans.master.LoanImageEntity;

public interface LoanImageRepository extends JpaRepository<LoanImageEntity, Long> {
	
	

}
