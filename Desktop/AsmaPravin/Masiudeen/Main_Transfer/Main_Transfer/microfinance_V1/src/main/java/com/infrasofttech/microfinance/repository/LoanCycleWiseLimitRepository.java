package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleWiseLimitEntity;

@Repository
public interface LoanCycleWiseLimitRepository extends JpaRepository<LoanCycleWiseLimitEntity, Long>{

	@Query(value = "Select * from  loancyclewiselimitmaster  ",nativeQuery = true)
	List<LoanCycleWiseLimitEntity> getLoanCycleLimit();
	
}
