package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerLoanEntity;
import com.infrasofttech.microfinance.entityBeans.master.KycMasterEntity;


@Repository
public interface KycMasterRepository extends JpaRepository<KycMasterEntity , Long> {

	@Query(value="SELECT TOP 50 * FROM  md045804 WITH (NOLOCK) where missynctocoresys =?1 AND  mleadsid <> '' AND mleadsid is NOT NULL ",nativeQuery = true)
	List<KycMasterEntity> findByIsDataSynced(int isDatasynced);
	
	@Modifying
    @Query(value = "UPDATE md045804 SET merrormessage = ?2,mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
    int updateErrorFromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt);
	
	@Modifying
    @Query(value = "UPDATE md045804 SET merrormessage = ?2,mlastupdatedt =?3,mretry =?4,   WHERE mrefno = ?1  ",nativeQuery = true)
    int updateErrorFromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt,int mRetry);
		
	@Modifying
    @Query(value = "UPDATE md045804 SET mleadsid = ?2 ,mlastupdatedt =?3,mretry =?4, missynctocoresys=2 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateKycMasterLeadId( int mLoanRefNo, String mleadsid,LocalDateTime updatedDt,int mRetry);
	
	@Query(value="SELECT * FROM  md045804  WITH (NOLOCK) where mcreatedby=?1  AND mlastupdatedt > ?2",nativeQuery = true)
	List<KycMasterEntity> findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);
	
	@Query(value="SELECT  * FROM  md045804  WITH (NOLOCK) where mcreatedby=?1 order BY mlastupdatedt  desc",nativeQuery = true)
	List<KycMasterEntity> findByCreatedby(String mcreatedby);	
	
	@Modifying
    @Query(value = "UPDATE md045804 SET missynctocoresys=1 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateStatus(int mrefno);
	
	@Modifying
    @Query(value = "UPDATE md045804 SET missynctocoresys=2 , merrormessage = ?2 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateErrorStatus( int mrefno, String merrormessage);
	
	
	 @Modifying
	  @Query(value = "UPDATE md045804 SET mleadsid= ?1 , mlastupdatedt = ?4 WHERE mloanmrefno = ?2 AND mloantrefno = ?3  ",nativeQuery = true)
	  int updateLeadsIdFromLoanMrefTref( String mleadsId,int mloanmrefno,int mloantrefno,LocalDateTime mlastUpdatDt);

	 @Modifying
	 @Query(value = "UPDATE md045804 SET missynctocoresys=1 , mleadsid= ?2 WHERE mrefno = ?1  ",nativeQuery = true)
	 int updateStatusAndLeadid( int mrefno,String mleadsId);         
}
