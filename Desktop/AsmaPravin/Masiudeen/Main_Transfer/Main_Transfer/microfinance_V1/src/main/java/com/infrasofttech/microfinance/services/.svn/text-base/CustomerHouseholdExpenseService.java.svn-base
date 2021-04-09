package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerHouseholdExpenseEntity;


public interface CustomerHouseholdExpenseService {
	
	public ResponseEntity<?> getAllCustomerHhExpenseData();
	
	ResponseEntity<?> addHhExpenseList(List<CustomerHouseholdExpenseEntity> customer);

	public ResponseEntity<?> addHhExpenseDetails(@Valid List<CustomerHouseholdExpenseEntity> entityList, int mCustRefno);

}
