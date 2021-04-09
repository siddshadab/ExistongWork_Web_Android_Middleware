package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanCashFlowEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;

public interface CustomerLoanCashFlowRepository extends JpaRepository<CustomerLoanCashFlowEntity, Long> {
	
	
	@Query(value="SELECT TOP 50 * FROM  md045806  WITH (NOLOCK) WHERE missynctocoresys = ?1  AND mloanmrefno != 0 ",nativeQuery = true)
	List<CustomerLoanCashFlowEntity> findByIsDataSynced(int isDataSyncToCoresys);
	
	@Modifying
    @Query(value = "UPDATE md045806 SET missynctocoresys = ?1 ,merrormessage = ?3 WHERE mrefno = ?2  ",nativeQuery = true)
    int updateMisSyncToCoresys( int misSyncToCoreSys,int mrefno,String merrormessage);
	
	
	@Modifying
    @Query(value = "UPDATE md045806 SET merrormessage = ?2, missynctocoresys=?3 WHERE mrefno  = ?1  ",nativeQuery = true)
    int updateErrorFromOmni( int mrefno, String merrormesssage,int misSyncToCoreSys);
	
	
	  @Query(
	  value="SELECT * FROM  md045806 where mcreatedby=?1 AND (mcreateddt > ?2 OR mlastupdatedt > ?2)",nativeQuery = true)
	  List<CustomerLoanCashFlowEntity>findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);
	  
	
	  @Query(value="SELECT * FROM  md045806 where mcreatedby=?1 ",nativeQuery =
			  true) List<CustomerLoanCashFlowEntity> findByCreatedby(String mcreatedby);
			 
		
	  
	  @Query(value="SELECT * FROM  md045806 where mrefno = ?1",nativeQuery = true)
	  CustomerLoanCashFlowEntity findByMrefNo(int mrefno);
	  
	  
	  
	  @Modifying
	  @Query(value = "UPDATE md045806 SET mleadsid= ?1 , missynctocoresys = 1 ,mlastupdatedt = ?4 , merrormessage ='' WHERE mloanmrefno = ?2 AND mloantrefno = ?3  ",nativeQuery = true)
	  int updateLeadsIdFromLoanMrefTref( String mleadsId,int mloanmrefno,int mloantrefno,LocalDateTime mlastUpdatDt);
			  
	  
	  @Modifying
	  @Query(value = "UPDATE md045806 SET missynctocoresys=2 , mleadsid= ?2 WHERE mrefno = ?1  ",nativeQuery = true)
	  int updateStatusAndLeadid( int mrefno,String mleadsId);
	  
	  @Modifying
	  @Query(value = "UPDATE md045806 SET merrormessage= ?1 , missynctocoresys = 9 ,mlastupdatedt = ?4 WHERE mloanmrefno = ?2 AND mloantrefno = ?3  ",nativeQuery = true)
	  int updateErrorFromLoanMrefTref( String merrormessage,int mloanmrefno,int mloantrefno,LocalDateTime mlastUpdatDt);
		
	
	


}
