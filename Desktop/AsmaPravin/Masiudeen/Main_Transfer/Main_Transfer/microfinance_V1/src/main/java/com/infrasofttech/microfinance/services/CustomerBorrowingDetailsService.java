package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBorrowingDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;



public interface CustomerBorrowingDetailsService {
	
public ResponseEntity<?> addList(CustomerBorrowingDetailsEntity customer);
	
	public ResponseEntity<?> getAllCustomerBorrowingData();
	
	public ResponseEntity<?> addCustomerBorrowingDetails(@Valid List<CustomerBorrowingDetailsEntity> entityList, int  mCustRefno) ;
	

}
