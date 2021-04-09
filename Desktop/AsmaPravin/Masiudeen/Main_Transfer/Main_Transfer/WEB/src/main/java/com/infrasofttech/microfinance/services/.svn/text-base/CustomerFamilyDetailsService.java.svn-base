package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerFamilyDetailsEntity;



public interface CustomerFamilyDetailsService {
	
/*public ResponseEntity<?> addFamilyList(CustomerFamilyDetailsEntity customer);*/
	
	public ResponseEntity<?> getAllCustomerFamilyData();

	/*public ResponseEntity<?> getCustomerFamilyByCustomerNo(Long custno);*/
	
	//public ResponseEntity<?> addFamilyDetails(@Valid CustomerFamilyDetailsEntity entity, CustomerCompositePrimaryEntity customerIdOfTab);

	ResponseEntity<?> addFamilyList(List<CustomerFamilyDetailsEntity> customer);

	public ResponseEntity<?> addFamilyDetails(@Valid List<CustomerFamilyDetailsEntity> entityList, int mCustRefno);
	
	

}
