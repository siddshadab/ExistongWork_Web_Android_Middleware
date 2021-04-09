package com.infrasofttech.microfinance.services;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.CustomerCompositePrimaryEntity;
import com.infrasofttech.microfinance.entityBeans.master.CustomerPPIDetailsEntity;



public interface CustomerPPIDetailsService {
	
	public ResponseEntity<?> getAllCustomerPPIData();

	ResponseEntity<?> addPPIList(List<CustomerPPIDetailsEntity> customer);
	public ResponseEntity<?> addPPIDetails(@Valid List<CustomerPPIDetailsEntity> entityList, int mCustRefno);


}
