package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.LoanLevelMasterEntity;

public interface LoanLevelService {

	
	public ResponseEntity<?> getLoanLevel();
	
	public List<LoanLevelMasterEntity>  findByPrdCd(String prdCd);
	
}
