package com.infrasofttech.microfinance.repository;

import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;

import com.infrasofttech.microfinance.entityBeans.master.ImageMasterEntity;




public interface ImageMasterRepository extends JpaRepository<ImageMasterEntity, Long> {
	
	
	/*List<CustomerFamilyDetailsEntity> findByCustomerNumber(Long customernumber);
	findCustby*/
	
	@Query(value="SELECT * FROM  image_master_entity WITH (NOLOCK) where mrefno=?1 AND img_type != 'FingerPrint'    ",nativeQuery = true)
	List<ImageMasterEntity> findByMrefno(int mrefno);
	
	

	@Modifying
	@Query(value="Delete  FROM  image_master_entity where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
	
	
	
	
	
	@Query(value="SELECT * FROM  image_master_entity WITH (NOLOCK) where  timgrefno > 12 AND mrefno = (SELECT mrefno from md009011 WHERE  mcustno = ?1 )",nativeQuery = true)
	List<ImageMasterEntity> getByFingerPrint(int custNo);
	
	
}
