package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;


public interface CustomerBusinessExpenseService {
	
	public ResponseEntity<?> getAllCustomerBnExpenseData();
	
	ResponseEntity<?> addBnExpenseList(List<CustomerBusinessExpenseEntity> customer);

	public ResponseEntity<?> addBnExpenseDetails(@Valid List<CustomerBusinessExpenseEntity> entityList, int mCustRefno);

}
