package com.infrasofttech.microfinance.services;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.infrasofttech.microfinance.entityBeans.master.LoanLevelMasterEntity;
import com.infrasofttech.microfinance.entityBeans.master.holder.LoanLevelHolder;

public interface LoanLevelService {

	
	public ResponseEntity<?> getLoanLevel();
	
	public List<LoanLevelMasterEntity>  findByPrdCd(String prdCd);
	
	public ResponseEntity<?> addList(LoanLevelMasterEntity loanMasterEntity);
	
	public ResponseEntity<?> updateByMref(LoanLevelMasterEntity loanMasterEntity);
	
	public ResponseEntity<?> deleteByMref(List<Integer> mrefno);
	
	public ResponseEntity<?> findByRecByMref(LoanLevelMasterEntity loanEntity);
}
