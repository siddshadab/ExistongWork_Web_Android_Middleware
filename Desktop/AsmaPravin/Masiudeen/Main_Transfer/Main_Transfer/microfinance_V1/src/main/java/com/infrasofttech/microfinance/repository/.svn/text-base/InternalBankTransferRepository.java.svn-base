package com.infrasofttech.microfinance.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.infrasofttech.microfinance.entityBeans.master.InternalBankTransferEntity;


@Repository
public interface InternalBankTransferRepository extends JpaRepository<InternalBankTransferEntity, Long> {
	
	@Query(value="SELECT TOP 50 * FROM  internal_bank_tranfer_master WITH (NOLOCK) where missynctocoresys= 0  ",nativeQuery = true)
	List<InternalBankTransferEntity> getTransactionNotSynced();

	@Query(value="SELECT  * FROM  internal_bank_tranfer_master WITH (NOLOCK) where mrefno= ?1  ",nativeQuery = true)
	InternalBankTransferEntity findByMrefNo(int mrefno);
	
	
	@Modifying
	@Query(value="UPDATE  internal_bank_tranfer_master SET merrormessage = ?1, missynctocoresys = ?2,mretry = ?3 , mlastupdatedt = ?5 , missyncfromcoresys = 0 where mrefno= ?4  ",nativeQuery = true)
	int updateStausFromOmni(String merrormessage,int missynctocoresys,int mretry, int mrefno, LocalDateTime mlastUpdatDt);
	
	
	@Modifying
    @Query(value = "UPDATE internal_bank_tranfer_master SET missyncfromcoresys = 1 WHERE mrefno IN (?1)  ",nativeQuery = true)
    int updateSyncFromServer(List<Integer> mrefNoList);
	
	
	
	@Query(value="SELECT  * FROM  internal_bank_tranfer_master WITH (NOLOCK) where mcreatedby= ?1  ",nativeQuery = true)
	List<InternalBankTransferEntity> findByCreatedby(String mcreatedBy);
	
	
	

	@Query(value="SELECT  * FROM  internal_bank_tranfer_master WITH (NOLOCK) where mcreatedby= ?1 and missyncfromcoresys = 0   ",nativeQuery = true)
	List<InternalBankTransferEntity> findByCreatedbyWithLastSyncDate(String mcreatedBy);
	
	
}
