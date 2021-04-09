package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.CountriesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerEntity;







public interface CustomerBorrowingDetailsRepository extends JpaRepository<CustomerBorrowingDetailsEntity, Long>{

	@Modifying
	@Query(value="Delete  FROM  md010058 where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
	@Query(value="SELECT * FROM  md010058 WITH (NOLOCK) where mrefno=?1 ",nativeQuery = true)
	List<CustomerBorrowingDetailsEntity> findByMrefno(int mrefno);
	
}
