package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.infrasofttech.microfinance.entityBeans.StatesEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.AddressMasterHolder;

@Service
public interface StatesServices {

	
	/*
	 * public ResponseEntity<?> addStates(@Valid StatesEntity entity, Long
	 * mcountryid);
	 */
	
	 public ResponseEntity<?> getStates(); 
	 
	 public ResponseEntity<?> getAllStates(StatesEntity statesEntity);
	 
	 public ResponseEntity<?> addStates(StatesEntity statesEntity);
	 
	 public ResponseEntity<?> editStates(StatesEntity statesEntity);
	 
	 public ResponseEntity<?> deleteStates(AddressMasterHolder addressMasterHolder);
	 
	// public ResponseEntity<?> bulkDelete(AddressMasterHolder addressHolder);
	 
}
