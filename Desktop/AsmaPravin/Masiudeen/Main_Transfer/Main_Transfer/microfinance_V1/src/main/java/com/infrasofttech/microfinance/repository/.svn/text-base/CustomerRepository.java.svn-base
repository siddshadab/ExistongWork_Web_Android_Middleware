package com.infrasofttech.microfinance.repository;



import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.CustomerLocationHolder;





@Repository
public interface CustomerRepository extends JpaRepository<CustomerEntity, Integer>{


	

	CustomerEntity findByMrefno (int mrefno);

		
		
	/*@Query(value="SELECT TOP 50 *   FROM  md009011 WITH (NOLOCK)  where missynctocoresys =?1 AND mcustno =0 AND mretry <= 3",nativeQuery = true)
	List<CustomerEntity> findDataByisDataSyncedNativeQuery(int isdataSynced);*/
	
	@Query(value="SELECT TOP 50 *   FROM  md009011 WITH (NOLOCK)  where missynctocoresys =?1  AND mretry <= 3",nativeQuery = true)
	List<CustomerEntity> findDataByisDataSyncedNativeQuery(int isdataSynced);
	
		@Modifying
	    @Query(value = "UPDATE md009011 SET mcustno = ?2 ,mlastupdatedt =?3, missynctocoresys=1 ,merrormessage = '', mcuststatus = ?4 , missyncfromcoresys = 0 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateCustomer( int mCustRefNo, int customerNumberOfCore,LocalDateTime updatedDt,int mcuststatus);
		
	
		@Modifying
	    @Query(value = "UPDATE md009011 SET merrormessage = ?2, missynctocoresys = 2,mlastupdatedt =?3 , missyncfromcoresys = 0  WHERE mrefno = ?1  ",nativeQuery = true)
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
    @Query(value = "UPDATE md009011 SET merrormessage = ?2,mlastupdatedt =?3 , mretry = ?4 , missynctocoresys = ?5 , missyncfromcoresys = 0 WHERE mrefno = ?1  ",nativeQuery = true)
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

		
		@Query(value="SELECT * FROM  md009011 WITH (NOLOCK) where Mdob=?1 AND  substring(mpannodesc,len(mpannodesc)-5,6)=?2 ",nativeQuery = true)
		CustomerEntity findByMnationalId(LocalDateTime mdob, String mnationalId);
		
	//CustomerDataholder save(CustomerDataholder customer);
		
		@Modifying
	    @Query(value = "UPDATE md009011 SET mgroupcd = ?2, mlastupdatedt =?3 , missyncfromcoresys = 0 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateGroupInCustomerDetails(int mrefno,int groupNumberOfCore,LocalDateTime updatedDateTime);
		
		@Modifying
	    @Query(value = "UPDATE md009011 SET mcenterid = ?2, mlastupdatedt =?3  , missyncfromcoresys = 0 WHERE mrefno = ?1  ",nativeQuery = true)
	    int updateCenterInCustomerDetails(int mrefno,int groupNumberOfCore,LocalDateTime updatedDateTime);
		
		@Modifying
	    @Query(value = "UPDATE md009011 SET mcuststatus = ?2 , missyncfromcoresys = 0 WHERE mcustno = ?1  ",nativeQuery = true)
	    int updateCustStatusInCustomerDetails(int custno,int custStatus);

		@Modifying
	    @Query(value = "UPDATE md009011 set mcuststatus = ?3 ,mlastupdatedt =?2 , missyncfromcoresys = 0  WHERE mcustno = ?1   ",nativeQuery = true)
		int updateStatusFromCore( int mcustno, LocalDateTime updatedDt, int macuthcd);
		
		@Query(value="SELECT * FROM  md009011 where mpannodesc=?1 ",nativeQuery = true)
		CustomerEntity findByOnlyMnationalId(String mnationalId);
		
		
		
		
		@Modifying
	    @Query(value = "UPDATE md009011 SET mismodify = 1,mlastupdatedt = ?2  , missyncfromcoresys = 0 WHERE mcustno = ?1  AND mlbrcode = ?3  ",nativeQuery = true)
	    int updateCustModRight(int mcustno,LocalDateTime updatedDateTime, int mlbrcode);
		
		@Query(value="SELECT * FROM  md009011 WITH (NOLOCK) where mcreatedby=?1 AND missyncfromcoresys = 0 AND mcuststatus <> 2 AND mcustno <> 0",nativeQuery = true)
		List<CustomerEntity> findByCreatedbyAndNotSynced(String mcreatedby);
		

		@Modifying
	    @Query(value = "UPDATE md009011 SET missyncfromcoresys = 1 WHERE mrefno IN (?1)  ",nativeQuery = true)
	    int updateCustSyncFromServer(List<Integer> mrefNoList);
				
		

		/*@Query("select CustomerLocationHolder(c.mfname  mfname , c.mmname  mmname, c.mlname  mlname, c.mgender  mgender, c.mlongname  mlongname, c.mrefno  mrefno, c.mcustno  mcustno,c.mcreateddt  mcreateddt,c.mcreatedby  mcreatedby, c.mlastupdatedt  mlastupdatedt,c.mlastupdateby  mlastupdateby,c.mgeolocation  mgeolocation,c.mgeolatd  mgeolatd , c.mgeologd  mgeologd, c.mlastsynsdate  mlastsynsdate) FROM  md009011  c  where c.mcenterid = ?1 AND c.mcuststatus <> 2 AND c.mcustno <> 0 AND c.mgeolatd IS NOT NULL AND c.mgeologd IS NOT NULL")
		List<CustomerLocationHolder> findByCenterIdSpecific(int centerId);*/
		
		
		/*@Query("select CustomerLocationHolder(c.mfname  mfname , c.mmname  mmname, c.mlname  mlname, c.mgender  mgender, c.mlongname  mlongname, c.mrefno  mrefno, c.mcustno  mcustno,c.mcreateddt  mcreateddt,c.mcreatedby  mcreatedby, c.mlastupdatedt  mlastupdatedt,c.mlastupdateby  mlastupdateby,c.mgeolocation  mgeolocation,c.mgeolatd  mgeolatd , c.mgeologd  mgeologd, c.mlastsynsdate  mlastsynsdate) FROM  md009011  c  where c.mcenterid = ?1 AND c.mcuststatus <> 2 AND c.mcustno <> 0 AND c.mgeolatd IS NOT NULL AND c.mgeologd IS NOT NULL")
		List<CustomerLocationHolder> findByCenterIdSpecific(int centerId);*/
		
		//@Query(value="SELECT * FROM  md009011  c  where c.mcenterid = ?1 AND c.mcuststatus <> 2 AND c.mcustno <> 0 AND c.mgeolatd IS NOT NULL AND c.mgeologd IS NOT NULL",nativeQuery = true)
		List<CustomerLocationHolder> findByMcenterid(int mcenterid);
		
		
		

}
