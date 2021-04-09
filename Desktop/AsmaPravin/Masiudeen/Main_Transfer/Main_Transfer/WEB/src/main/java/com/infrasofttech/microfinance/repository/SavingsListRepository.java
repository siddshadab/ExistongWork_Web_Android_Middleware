package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.LookupMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.SavingsListEntity;
import com.infrasofttech.microfinance.entityBeans.master.SystemParameterEntity;
import com.infrasofttech.microfinance.entityBeans.master.UserMasterEntity;


@Repository
public interface SavingsListRepository  extends JpaRepository<SavingsListEntity, Long> {


	
     	@Modifying
	    @Query(value="SELECT * FROM  md009022 where missynctocoresys =?1",nativeQuery = true)
	    List<SavingsListEntity> findDataByisDataSynced(int isdataSynced);
      	

     	 @Modifying
     	 
     	 @Query(value =
     	 "UPDATE md009022 SET mcustno = ?2 ,mprdcd =?3, mprdacctid=?4, missynctocoresys=1 WHERE mrefno = ?1  "
     	 ,nativeQuery = true) int updateSavingsList( int mCustRefNo, int
     	 mcustno,String mprdcd,String mprdacctid);

     			
		@Modifying
	    @Query(value = "UPDATE md009022 SET mprdacctid=?2, missynctocoresys=1,mcrs=?3 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateSavingsList( int mCustRefNo, String mprdacctid, String mcrs);
		
		
		  @Modifying
		  
		  @Query(value="SELECT * FROM  md009022 where mcreatedby=?1 ",nativeQuery =
		  true) List<SavingsListEntity> findByCreatedby(String mcreatedby);
		 
	
		@Modifying
	    @Query(value = "UPDATE md009022 SET merrormessage = ?2,mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateSavingsErrorfromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt);
		
	
	  @Modifying
	  @Query(
	  value="SELECT * FROM  md009022 where mcreatedby=?1 AND mcreateddt > ?2 OR mlastupdatedt > ?2",nativeQuery = true)
	  List<SavingsListEntity>findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);
	  
	  
	  //SavingsListEntity getHerarchy (String mprdaccid,Integer mlbrcd);
	  
	  @Modifying
	  @Query(
	  value="SELECT * FROM  md009022 where mprdaccid=?1 AND mlbrcd = ?2",nativeQuery = true)
		public List<SavingsListEntity> getHerarchy(String mprdaccid,Integer mlbrcd);

	  
	  
	  
	  @Modifying
	    @Query(value = "UPDATE md009022 SET mcustno =?2 WHERE mcustmrefno = ?1  ",nativeQuery = true)
	    int updateSavingsListCustNo( int mcustmrefno, int mcustno);
		

	 
	  @Query(
	  value="SELECT * FROM  md009022 where mrefno = ?1 ",nativeQuery = true)
		public SavingsListEntity getSavingListEntityByMrefno(int mrefno);

	 
}
