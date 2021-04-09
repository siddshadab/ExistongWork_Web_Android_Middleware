package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CheckListCGT2Entity;

public interface CheckListCGT2Repository extends JpaRepository<CheckListCGT2Entity, Long> {
	
	@Modifying
	@Query(value="Delete  FROM  cgt2qadetails where mclcgt2refno =?1",nativeQuery = true)
	void deleteExistingRecords(int mChkListRefno);

}
