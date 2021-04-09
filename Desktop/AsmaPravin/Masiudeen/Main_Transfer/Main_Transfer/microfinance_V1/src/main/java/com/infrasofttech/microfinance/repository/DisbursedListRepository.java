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

	
	@Query(value="SELECT TOP 50 * FROM  md009343 WITH (NOLOCK) WHERE missynctocoresys =?1 AND  mdisbstatus = ?2   ",nativeQuery = true)
	List<DisbursedListEntity> findByIsDataSynced(int isdatasynced,int mdisbstatus);
	
	
	

	@Modifying
    @Query(value = "UPDATE md009343 SET missynctocoresys = ?2 ,merrormessage =?3 ,mlastupdatedt =?4 WHERE mleadsid = ?1  ",nativeQuery = true)
    int updateStatus( String mleadsid, int isSync,String mErrorMessage,LocalDateTime updatedDt);
	
	
	@Query(value="SELECT  * FROM  md009343 WITH (NOLOCK) WHERE mrouteto = ?1 AND (mlastupdatedt > ?2 OR  mcreatedby >=?2 ) AND missynctocoresys = 1   ",nativeQuery = true)
	List<DisbursedListEntity> findByRouteAndMlastSynsDate(String  mrouteTo,LocalDateTime updatedDt);
	
	

	@Query(value="SELECT  * FROM  md009343 WITH (NOLOCK) WHERE mrouteto =?1 AND missynctocoresys = 1    ",nativeQuery = true)
	List<DisbursedListEntity> findByRouteTo(String mrouteTo);
	
	
	
	@Query(value="SELECT  * FROM  md009343 WITH (NOLOCK) WHERE mleadsid= ?1    ",nativeQuery = true)
	DisbursedListEntity findByleadsId(String mleadsid);
	
	
	@Query(value="SELECT  * FROM  md009343 WITH (NOLOCK) WHERE mcreatedby = ?1 OR (mrouteto = ?1 and  missynctocoresys = 1)  ",nativeQuery = true)
	List<DisbursedListEntity> findByCreatedBy(String mcreatedBy);
	
	@Query(value="SELECT  * FROM  md009343 WITH (NOLOCK) WHERE ( mcreatedby = ?1 OR (mrouteto =?1 AND  missynctocoresys = 1 )) AND (mlastupdatedt > ?2 OR  mcreateddt >=?2 )    ",nativeQuery = true)
	List<DisbursedListEntity> findByCratedByAndMlastSynsDate(String mcreatedBy,LocalDateTime updatedDt);
	
	
	@Query(value="SELECT  * FROM  md009343 WITH (NOLOCK) WHERE mrefno= ?1    ",nativeQuery = true)
	DisbursedListEntity findByMrefNo(int mrefno);
	
	
	@Modifying
    @Query(value = "UPDATE md009343 SET missynctocoresys = ?2 ,merrormessage =?3 ,mlastupdatedt =?4, mcurcd = ?5, mbatchcd = ?6 , msetno = ?7 WHERE mleadsid = ?1  ",nativeQuery = true)
    int updateStatusWithSetNo( String mleadsid, int isSync,String mErrorMessage,LocalDateTime updatedDt , String curcd, String mbatchcd, int msetno);
	
	
	
}
