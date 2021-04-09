package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.GroupsFoundationEntity;
import com.infrasofttech.microfinance.entityBeans.master.InterestOffsetEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryEntity;



@Repository
public interface LoanCycleParameterPrimaryRepository  extends JpaRepository<LoanCycleParameterPrimaryEntity, Long> {
	
	 @Query(value = "Select * from  md045275  WHERE mlbrcode= ?1",nativeQuery = true)
		List<LoanCycleParameterPrimaryEntity> findByMlbrCode(int mLbrcode);

}
