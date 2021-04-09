package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.DailyLoanCollectionEntity;

public interface DailyLoanCollectionServices {

	public ResponseEntity<?> getAllLoanCollectionData() ;

	ResponseEntity<?> findByCreatedByAndLbr(DailyLoanCollectionEntity dailyLoanCollectionEntity);

	
}
