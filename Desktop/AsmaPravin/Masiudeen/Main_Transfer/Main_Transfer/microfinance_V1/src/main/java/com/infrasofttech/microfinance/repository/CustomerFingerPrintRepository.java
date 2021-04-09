package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerFingerPrintEntity;
import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;

public interface CustomerFingerPrintRepository extends JpaRepository<CustomerFingerPrintEntity, Long> {

	@Query(value="SELECT * FROM  customerfingerprintentity WITH (NOLOCK) where mrefno=?1 ",nativeQuery = true)
	List<CustomerFingerPrintEntity> findByMrefno(int mrefno);
	
	

	@Modifying
	@Query(value="Delete  FROM  customerfingerprintentity where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
	
	
	
	
	
	@Query(value="SELECT * FROM  customerfingerprintentity WITH (NOLOCK) where   mrefno = (SELECT mrefno from md009011 WHERE  mcustno = ?1 )",nativeQuery = true)
	List<CustomerFingerPrintEntity> getByFingerPrint(int custNo);
}
