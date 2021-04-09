package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.TDReceiptsEntity;

public interface TDReceiptsRepository  extends JpaRepository<TDReceiptsEntity, Long> {
	@Modifying
    @Query(value="SELECT * FROM  md020004 where missynctocoresys =?1",nativeQuery = true)
    List<TDReceiptsEntity> findDataByisDataSynced(int isdataSynced);
  	

 	 @Modifying
 	 
 	 @Query(value =
 	 "UPDATE md020004 SET mcustno = ?2 ,mprdcd =?3, mprdacctid=?4, missynctocoresys=1 WHERE mrefno = ?1  "
 	 ,nativeQuery = true) int updateTDReceipts( int mCustRefNo, int
 	 mcustno,String mprdcd,String mprdacctid);

 			
	@Modifying
    @Query(value = "UPDATE md020004 SET mprdacctid=?2, missynctocoresys=1, mmatval=?3, mreceiptstatus=?4 , merrormessage = '',mbatchcd = ?5, msetno = ?6, mscrollno = ?7 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateTDReceipts( int mCustRefNo, String mprdacctid, double mmatval, int mreceiptstatus,String mbatchcd,int setno,int scrollno );
	
	@Modifying	  
	@Query(value="SELECT * FROM  md020004 where mcreatedby=?1 ",nativeQuery =
	true) List<TDReceiptsEntity> findByCreatedby(String mcreatedby);
	
	@Modifying
    @Query(value = "UPDATE md020004 SET merrormessage = ?2,mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
    int updateSavingsErrorfromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt);
	
	@Modifying
	  @Query(
	  value="SELECT * FROM  md020004 where mcreatedby=?1 AND mcreateddt > ?2 OR mlastupdatedt > ?2"
	  ,nativeQuery = true) List<TDReceiptsEntity>
	  findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);

}
