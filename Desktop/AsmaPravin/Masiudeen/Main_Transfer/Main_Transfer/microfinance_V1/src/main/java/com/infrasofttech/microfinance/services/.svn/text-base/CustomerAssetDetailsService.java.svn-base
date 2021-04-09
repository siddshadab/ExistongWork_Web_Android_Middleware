package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerAssetDetailsEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerBusinessExpenseEntity;


public interface CustomerAssetDetailsService {
	
	public ResponseEntity<?> getAllCustomerAssetData();
	
	ResponseEntity<?> addAssetList(List<CustomerAssetDetailsEntity> customer);

	public ResponseEntity<?> addAssetDetails(@Valid List<CustomerAssetDetailsEntity> entityList, int mCustRefno);

}
