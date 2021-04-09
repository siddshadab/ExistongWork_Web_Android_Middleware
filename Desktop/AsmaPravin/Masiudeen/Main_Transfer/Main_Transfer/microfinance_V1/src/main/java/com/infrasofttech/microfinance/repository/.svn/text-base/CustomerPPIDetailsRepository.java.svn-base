package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;

public interface CustomerPPIDetailsRepository extends JpaRepository<CustomerPPIDetailsEntity, Long> {
	
	@Modifying
	@Query(value="Delete  FROM  Customerppidetailsmaster where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
	@Query(value="SELECT * FROM  Customerppidetailsmaster WITH (NOLOCK) where mrefno=?1 ",nativeQuery = true)
	List<CustomerPPIDetailsEntity> findByMrefno(int mrefno);
	
}
