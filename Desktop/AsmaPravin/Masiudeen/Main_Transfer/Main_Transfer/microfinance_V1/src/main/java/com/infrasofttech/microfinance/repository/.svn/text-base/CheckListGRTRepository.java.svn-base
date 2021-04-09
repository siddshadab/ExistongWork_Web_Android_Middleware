package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CheckListGRTEntity;

public interface CheckListGRTRepository extends JpaRepository<CheckListGRTEntity, Long> {
	
	@Modifying
	@Query(value="Delete  FROM  grtqadetails where mclgrtrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mChkListRefno);

}
