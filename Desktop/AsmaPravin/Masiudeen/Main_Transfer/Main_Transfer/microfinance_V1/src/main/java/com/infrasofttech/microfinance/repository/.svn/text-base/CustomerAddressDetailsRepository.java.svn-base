package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;

public interface CustomerAddressDetailsRepository extends JpaRepository<CustomerAddressDetailsEntity, Long>{

	
	@Modifying
	@Query(value="Delete  FROM  md010054 where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
	@Query(value="SELECT * FROM  md010054  WITH (NOLOCK) where mrefno=?1 ",nativeQuery = true)
	List<CustomerAddressDetailsEntity> findByMrefno(int mrefno);
}
