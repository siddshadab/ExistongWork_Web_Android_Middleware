package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursedListEntity;
import com.infrasofttech.microfinance.entityBeans.master.DisbursmentListEntity;

public interface DisbursedListRepository extends JpaRepository<DisbursedListEntity, Long>  {

	
	@Query(value="SELECT TOP 50 * FROM  md009343 WITH (NOLOCK) WHERE  missynctocoresys =?1 AND  mdisbstatus = ?2   ",nativeQuery = true)
	List<DisbursedListEntity> findByIsDataSynced(int isdatasynced,int mdisbstatus);
	
	
	

	@Modifying
    @Query(value = "UPDATE md009343 SET missynctocoresys = ?2 ,merrormessage =?3 ,mlastupdatedt =?4 WHERE mleadsid = ?1  ",nativeQuery = true)
    int updateStatus( String mleadsid, int isSync,String mErrorMessage,LocalDateTime updatedDt);
	
	
	
}
