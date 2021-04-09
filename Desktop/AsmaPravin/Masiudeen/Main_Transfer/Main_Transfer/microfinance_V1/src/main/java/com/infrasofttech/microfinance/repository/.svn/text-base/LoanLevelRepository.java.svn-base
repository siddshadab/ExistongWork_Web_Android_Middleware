package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanLevelMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.ProductEntity;

public interface LoanLevelRepository  extends JpaRepository<LoanLevelMasterEntity, Long> {
	
	
	
	@Query(value="SELECT  * FROM  loan_level_master  WITH (NOLOCK) where mprdcd = ?1 ",nativeQuery = true)
	List<LoanLevelMasterEntity> findByPrdCd(String mprdcd);
	

}
