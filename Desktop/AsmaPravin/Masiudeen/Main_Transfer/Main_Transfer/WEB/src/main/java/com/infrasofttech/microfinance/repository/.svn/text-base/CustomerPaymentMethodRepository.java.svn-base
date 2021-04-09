package com.infrasofttech.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.infrasofttech.microfinance.entityBeans.AreaEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPaymentMethodDetailsEntity;

public interface CustomerPaymentMethodRepository extends JpaRepository<CustomerPaymentMethodDetailsEntity, Long>{
	


	@Modifying
	@Query(value="Delete  FROM  customer_payment_method_details_entity where mrefno =?1",nativeQuery = true)
	void deleteExistingRecords(int mCustRefno);
	
}
