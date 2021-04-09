package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT1Entity;

public interface CheckListCGT1Repository extends JpaRepository<CheckListCGT1Entity, Long> {
	
	@Modifying
	@Query(value="Delete  FROM  cgt1qadetails where mclcgt1refno =?1",nativeQuery = true)
	void deleteExistingRecords(int mChkListRefno);

}
