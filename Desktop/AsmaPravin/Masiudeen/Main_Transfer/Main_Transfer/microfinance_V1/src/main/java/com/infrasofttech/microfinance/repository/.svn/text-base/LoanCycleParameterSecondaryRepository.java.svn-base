package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.InterestOffsetEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterPrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;



@Repository
public interface LoanCycleParameterSecondaryRepository  extends JpaRepository<LoanCycleParameterSecondaryEntity, Long> {
	
	 @Query(value = "Select * from  md045375  WHERE mlbrcode= ?1",nativeQuery = true)
		List<LoanCycleParameterSecondaryEntity> findByMlbrCode(int mLbrcode);

}
