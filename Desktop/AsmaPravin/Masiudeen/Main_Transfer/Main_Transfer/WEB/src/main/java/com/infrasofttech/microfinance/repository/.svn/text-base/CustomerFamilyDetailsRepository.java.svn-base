package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;





public interface CustomerFamilyDetailsRepository extends JpaRepository<CustomerFamilyDetailsEntity, Long> {
	
	@Modifying
	@Query(value="Delete  FROM  md010056 where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
	@Query(value="SELECT * FROM  md010056 WITH (NOLOCK) where mrefno=?1 ",nativeQuery = true)
	List<CustomerFamilyDetailsEntity> findByMrefno(int mrefno);
	
	
}
