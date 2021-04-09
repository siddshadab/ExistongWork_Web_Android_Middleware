package com.infrasofttech.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;





public interface CustomerHouseholdExpenseRepository extends JpaRepository<CustomerHouseholdExpenseEntity, Long> {
	
	@Modifying
	@Query(value="Delete  FROM  md010057 where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
	@Query(value="SELECT * FROM  md010057 WITH (NOLOCK) where mrefno=?1 ",nativeQuery = true)
	List<CustomerHouseholdExpenseEntity> findByMrefno(int mrefno);
	
}
