package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.LoanApprovalLimitEntity;
import com.infrasofttech.microfinance.entityBeans.master.LoanCycleParameterSecondaryEntity;



@Repository
public interface LoanApprovalLimitRepository extends JpaRepository<LoanApprovalLimitEntity, Long> {
	
	 @Query(value = "Select * from  md045286  WHERE mlbrcode= ?1 AND mgrpcd = ?2 AND (musercd =?3  OR musercd= 'ALLUSERS') ",nativeQuery = true)
		List<LoanApprovalLimitEntity> findByMlbrCodeAndUserCd(int mLbrcode,int mgrpcd,String usrcode);
	 

}
