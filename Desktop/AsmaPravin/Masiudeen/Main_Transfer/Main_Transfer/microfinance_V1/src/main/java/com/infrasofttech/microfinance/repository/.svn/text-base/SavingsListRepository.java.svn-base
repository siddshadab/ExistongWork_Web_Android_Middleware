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


	
	    @Query(value="SELECT * FROM  md009022  WITH (NOLOCK) where missynctocoresys =?1",nativeQuery = true)
	    List<SavingsListEntity> findDataByisDataSynced(int isdataSynced);
      	

     	 @Modifying 
     	 @Query(value =
     	 "UPDATE md009022 SET mcustno = ?2 ,mprdcd =?3, mprdacctid=?4, missynctocoresys=1 , missyncfromcoresys= 0 WHERE mrefno = ?1  "
     	 ,nativeQuery = true) int updateSavingsList( int mCustRefNo, int
     	 mcustno,String mprdcd,String mprdacctid);

     			
		@Modifying
	    @Query(value = "UPDATE md009022 SET mprdacctid=?2, missynctocoresys=1,mcrs=?3, mlastsynsdate = ?4 , missyncfromcoresys= 0  WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateSavingsList( int mCustRefNo, String mprdacctid, String mcrs,LocalDateTime lastSynsDate);
		
		
		  
		  @Query(value="SELECT * FROM  md009022  WITH (NOLOCK) where mcreatedby=?1 ",nativeQuery =
		  true) List<SavingsListEntity> findByCreatedby(String mcreatedby);
		 
	
		@Modifying
	    @Query(value = "UPDATE md009022 SET merrormessage = ?2,missynctocoresys = 2 ,mlastsynsdate =?3 , missyncfromcoresys= 0  WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateSavingsLastErrorfromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt);
		
		
		@Modifying
	    @Query(value = "UPDATE md009022 SET merrormessage = ?2, mretry = ?3 , missyncfromcoresys= 0   WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateSavingsErrorfromOmni( int mCustRefNo, String updateErrorFromOmni, int mretry);
		
	
	  @Query(
	  value="SELECT * FROM  md009022 where mcreatedby=?1 AND missyncfromcoresys = 0  ",nativeQuery = true)
	  List<SavingsListEntity>findByNotSynced(String mcreatedby);
	  
	  
	  //SavingsListEntity getHerarchy (String mprdaccid,Integer mlbrcd);
	  
	  @Query(
	  value="SELECT * FROM  md009022 where mprdaccid=?1 AND mlbrcd = ?2",nativeQuery = true)
		public List<SavingsListEntity> getHerarchy(String mprdaccid,Integer mlbrcd);

	  
	  
	  
	  @Modifying
	    @Query(value = "UPDATE md009022 SET mcustno =?2 WHERE mcustmrefno = ?1 AND  missyncfromcoresys= 0  ",nativeQuery = true)
	    int updateSavingsListCustNo( int mcustmrefno, int mcustno);
		

	 
	  @Query(
	  value="SELECT * FROM  md009022 where mrefno = ?1 ",nativeQuery = true)
		public SavingsListEntity getSavingListEntityByMrefno(int mrefno);
	  
	  
	  @Modifying
	    @Query(value = "UPDATE md009022 SET merrormessage = ?2 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateSavingsErrorfromOmniWithoutlastSynsDate( int mCustRefNo, String updateErrorFromOmni);
	  
		@Modifying
	    @Query(value = "UPDATE md009022 SET missyncfromcoresys = 1 WHERE mrefno IN (?1)  ",nativeQuery = true)
	    int updateSavingsSyncFromServer(List<Integer> mrefNoList);
		

	 
}
