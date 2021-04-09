package com.infrasofttech.microfinance.services;

import org.springframework.http.ResponseEntity;

public interface GLAccountService {
	
	public ResponseEntity<?> getDataByMlbrcode(int mLbrcode);
	
}
