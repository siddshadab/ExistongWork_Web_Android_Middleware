package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectedEntity;
import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectionEntity;


@Repository
public interface DailyLoanCollectedRepository extends JpaRepository<DailyLoanCollectedEntity, Long> {


	
	@Query(value="SELECT TOP 200 * FROM  focollectedsheet  where missynctocoresys =?1 AND (merrormessage IS NULL OR merrormessage ='') ORDER BY mlastsynsdate ",nativeQuery = true)
	List<DailyLoanCollectedEntity> findByIsDataSynced(int isdatasynced);

	

	@Modifying
    @Query(value = "UPDATE focollectedsheet SET missynctocoresys = ?2 ,merrormessage =?3 ,mlastupdatedt =?4 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateStatus( int mrefno, int isSync,String mErrorMessage,LocalDateTime updatedDt);
	
	
}
