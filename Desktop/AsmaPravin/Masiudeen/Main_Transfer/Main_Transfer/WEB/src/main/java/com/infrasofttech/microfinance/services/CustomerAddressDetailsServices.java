package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAddressDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;

public interface CustomerAddressDetailsServices {

	
public ResponseEntity<?> addList(CustomerAddressDetailsEntity customer);
	
	public ResponseEntity<?> getAllCustomerAddressDetailsData();	
	public ResponseEntity<?> addCustomerAddressDetails(@Valid List<CustomerAddressDetailsEntity> entityList, int mCustRefno);
	

	
}
