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
	

	@Query(value="select TOP 50 * "+
					"from (" +
					" select "
					+ "mrefno, mcreatedby, mcreateddt, mgeolatd, mgeolocation, mgeologd, missynctocoresys,"
					+ "mlastsynsdate, mlastupdateby, mlastupdatedt, madjfrmexcss, madjfrmsd, malmeffdate,"
					+ "masondate, mattndnc, mbatchcd, mcenterid, mcollamt, mcustno, memino, merrormessage,"
					+ "mfocode, mgroupid, midealbaldate, mlbrcode, mpaidbygrp, mprdacctid, mremarks, trefno," +
				" row_number() over (partition by mcreateddt,mprdacctid  order by mrefno) as srno "+
				" from focollectedsheet where missynctocoresys = 0 AND (merrormessage IS NULL OR merrormessage ='') "+
				" ) as rows " +
				" where srno = 1",nativeQuery = true)
	List<DailyLoanCollectedEntity> getNonSyncedUniquePayments();
	
//	@Query(value=
//			" select TOP 50  " +
//		" row_number() over (partition by mcreateddt,mprdacctid  order by mrefno) as srno , * "+
//		" from focollectedsheet where missynctocoresys = 0 AND (merrormessage IS NULL OR merrormessage ='') ",nativeQuery = true)
//List<DailyLoanCollectedEntity> getNonSyncedUniquePayments();
	
	
	
	@Query(value=
			" SELECT TOP 50 * FROM focollectedsheet WITH (NOLOCK) WHERE mprdacctid = ?1  AND mcreateddt = ?2 order by mrefno",nativeQuery = true)
	List<DailyLoanCollectedEntity> getDuplicateLoanCollections(String mprdacctid, LocalDateTime mcreateddt);
	
	
//	@Query(value=
//			" SELECT TOP 50 * FROM focollectedsheet WITH (NOLOCK) WHERE missynctocoresys= 0  AND (merrormessage = '' OR merrormessage IS NULL )  GROUP BY mprdacctid , mcreateddt ",nativeQuery = true)
//List<DailyLoanCollectedEntity> getNonSyncedUniquePayments();
	
	
	@Modifying
    @Query(value = "UPDATE focollectedsheet SET merrormessage = ?2 ,missynctocoresys=  ?1 ,mlastupdatedt =?3 WHERE   mrefno = ?4  ",nativeQuery = true)
    int updateDedupCheck( int missynctocoresys, String mErrorMessage,LocalDateTime lastUpdateDt, int mrefNo);
	
	
	@Modifying
    @Query(value = "UPDATE focollectedsheet SET merrormessage = ?2 ,missynctocoresys=  ?1 ,mlastupdatedt =?3 WHERE mprdacctid = ?4 AND mcreateddt = ?5  AND  mrefno != ?6 AND (merrormessage ='' OR merrormessage IS NULL ) ",nativeQuery = true)
    int updateOnPrdacctidAndCretedDtAndmrefno( int missynctocoresys, String mErrorMessage,LocalDateTime lastUpdateDt,String mprdacctid,LocalDateTime mcreateddt ,  int mrefNo);
	
	
}
