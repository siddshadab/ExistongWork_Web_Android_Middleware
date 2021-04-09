package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsCollectionListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;


@Repository
public interface SavingsCollectionListRepository  extends JpaRepository<SavingsCollectionListEntity, Long> {
 	@Modifying
 	
 	
    @Query(value="SELECT TOP 50 * FROM md001120 where missynctocoresys =?1 AND mbatchcd in (Select DISTINCT mbatchcd from md001120 where  missynctocoresys =?1 AND  mmoduletype=?2 AND mcashflow=?3) AND  mmoduletype=?2 AND mcashflow=?3 order by mlbrcode",nativeQuery = true)
    List<SavingsCollectionListEntity> findDataByisDataSynced(int isdataSynced,int mmoduletype,String mcashflow);
	
     @Modifying
     @Query(value = "UPDATE md001120 SET mentrydate=?2, missynctocoresys=1,mbatchcd=?3,msetno=?4,mscrollno=?5 WHERE mrefno = ?1  ",nativeQuery = true)
	 int updateSavingsCollectionList(int mrefno, LocalDateTime mentrydate, String mbatchcd, int msetno, int mscrollno);
     
 	@Modifying
    @Query(value = "UPDATE md001120 SET merrormessage = ?2,mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
    int updateSavingsCollectionErrorfromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt);
	

	@Modifying
    @Query(value = "UPDATE md001120 SET missynctocoresys = ?2 ,merrormessage =?3 ,mlastupdatedt =?4 WHERE mrefno = ?1  ",nativeQuery = true)
	int updateStatus( int mrefno, int isSync,String merrormessage,LocalDateTime updatedDt);
	
	
	
	@Modifying
    @Query(value = "UPDATE md001120 SET mprdacctid = ?2 WHERE msvngaccmrefno = ?1  ",nativeQuery = true)
	int updateSavingsCollectionprdcctid( int msvngaccmrefno, String mprdacctid);
	
}
