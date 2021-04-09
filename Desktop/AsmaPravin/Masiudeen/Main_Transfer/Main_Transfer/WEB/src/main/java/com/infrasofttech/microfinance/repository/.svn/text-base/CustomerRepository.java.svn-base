package com.infrasofttech.microfinance.repository;



import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.base.BaseEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerDataholder;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import java.lang.String;
import java.time.LocalDateTime;





@Repository
public interface CustomerRepository extends JpaRepository<CustomerEntity, Integer>{


	

	CustomerEntity findByMrefno (int mrefno);

		
		
	/*@Query(value="SELECT TOP 50 *   FROM  md009011 WITH (NOLOCK)  where missynctocoresys =?1 AND mcustno =0 AND mretry <= 3",nativeQuery = true)
	List<CustomerEntity> findDataByisDataSyncedNativeQuery(int isdataSynced);*/
	
	@Query(value="SELECT TOP 50 *   FROM  md009011 WITH (NOLOCK)  where missynctocoresys =?1  AND mretry <= 3",nativeQuery = true)
	List<CustomerEntity> findDataByisDataSyncedNativeQuery(int isdataSynced);
	
		@Modifying
	    @Query(value = "UPDATE md009011 SET mcustno = ?2 ,mlastupdatedt =?3, missynctocoresys=1 ,merrormessage = '', mcuststatus = ?4 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateCustomer( int mCustRefNo, int customerNumberOfCore,LocalDateTime updatedDt,int mcuststatus);
		
	
		@Modifying
	    @Query(value = "UPDATE md009011 SET merrormessage = ?2, missynctocoresys = 2,mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateErrorFromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt);

		
		//findBytrefnoAndM
	@Query(value="SELECT * FROM  md009011  WITH (NOLOCK) where trefno=?1 AND mcreatedby = ?2 AND mrefno =?3 AND missynctocoresys =?4 ",nativeQuery = true)
	CustomerEntity findByTrefAndMcreatedByAndIsSynced(long customerNumberOfTab,String usrCode , int mrefno,int isdataSynced);
	//findBymcreated
	
	@Query(value="SELECT * FROM  md009011 WITH (NOLOCK) where mcreatedby=?1 AND (mlastupdatedt > ?2 OR mlastsynsdate > ?2) AND mcuststatus <> 2 AND mcustno <> 0",nativeQuery = true)
	List<CustomerEntity> findByCreatedbyAndDateTime(String mcreatedby,LocalDateTime lastsynsdate);

	
	@Query(value="SELECT * FROM  md009011  WITH (NOLOCK) where mcreatedby=?1 AND mcuststatus <> 2 AND mcustno <> 0 ",nativeQuery = true)
	List<CustomerEntity> findByCreatedby(String mcreatedby);
	
	
	
	@Modifying
    @Query(value = "UPDATE md009011 SET merrormessage = ?2,mlastupdatedt =?3 , mretry = ?4 , missynctocoresys = ?5 WHERE mrefno = ?1  ",nativeQuery = true)
    int updateErrorWithRetryFromOmni( int mCustRefNo, String updateErrorFromOmni,LocalDateTime updatedDt,int retry, int isSysncToCoreSys);

	
	
	//findbyId
		@Query(value="SELECT * FROM md009011 WITH (NOLOCK) WHERE (mpannodesc = ?1 OR mpannodesc = ?2) AND mcustno <> 0   ",nativeQuery = true)
		List<CustomerEntity> findByID(String panNoDesc,String middesc);
		//findBymcreated
	
		
		
		@Query(value="SELECT * FROM  md009011  WITH (NOLOCK) where mcenterid = ?1 AND mcuststatus <> 2 AND mcustno <> 0" ,nativeQuery = true)
		List<CustomerEntity> findByCenterId(int centerId);

		@Query(value="SELECT * FROM  md009011 WITH (NOLOCK) where mrefno=?1 ",nativeQuery = true)
		CustomerEntity findByMrefNo(int mrefNo);

		@Query(value="SELECT * FROM  md009011  WITH (NOLOCK) where mcustno=?1 ",nativeQuery = true)
		CustomerEntity findByMcustNo(int mCustNo);

		
		@Query(value="SELECT * FROM  md009011 where Mdob=?1 AND  substring(mpannodesc,len(mpannodesc)-5,6)=?2 ",nativeQuery = true)
		CustomerEntity findByMnationalId(LocalDateTime mdob, String mnationalId);
		
	//CustomerDataholder save(CustomerDataholder customer);
		
		@Modifying
	    @Query(value = "UPDATE md009011 SET mgroupcd = ?2, mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateGroupInCustomerDetails(int mrefno,int groupNumberOfCore,LocalDateTime updatedDateTime);
		
		@Modifying
	    @Query(value = "UPDATE md009011 SET mcenterid = ?2, mlastupdatedt =?3  WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateCenterInCustomerDetails(int mrefno,int groupNumberOfCore,LocalDateTime updatedDateTime);
		
		@Modifying
	    @Query(value = "UPDATE md009011 SET mcuststatus = ?2  WHERE mcustno = ?1  ",nativeQuery = true)
	    int updateCustStatusInCustomerDetails(int custno,int custStatus);

		@Modifying
	    @Query(value = "UPDATE md009011 set mcuststatus = ?3 ,mlastupdatedt =?2  WHERE mcustno = ?1   ",nativeQuery = true)
		int updateStatusFromCore( int mcustno, LocalDateTime updatedDt, int macuthcd);
		
		@Query(value="SELECT * FROM  md009011 where mpannodesc=?1 ",nativeQuery = true)
		CustomerEntity findByOnlyMnationalId(String mnationalId);
		

}
